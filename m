Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77006A5AC2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 15:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjB1OVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 09:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjB1OVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 09:21:06 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A682312D;
        Tue, 28 Feb 2023 06:21:04 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.217.110])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2B43C6602F90;
        Tue, 28 Feb 2023 14:20:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677594063;
        bh=fXrXYib4/IODPE+Or2l+E6ijJeid0k/x8BCxHGZiwIQ=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=TwWnx4/7sn4zeKGWVlB7xF34Q3kfjGHBo3Muw5icuLERAnrRYWiuHHQ9y5nCiUHi4
         ySiO0wKlRLmE7DaiN4+Tr9nnsPrX4f3X7lAhFPxQEjWbbYO+tyeGnvb5AdaU4JISlz
         Kxst2cFuDfbZn58tpNOgNDqRcd7wLeuFV3UDuovmwuMzksN7jJO9XW4mmuFifsjfqe
         aaxaBDDdia2uVDI8y/Ou08uhz2MQ7niM8qZ8B6NjHSXbWGsjvlmu08a3FNHpjVWeSk
         4LhCC0yISDy5xP8f/YdkWNV6gJMiwAX6zqIlu0r9mIFu5NPdcQh6pnQhcJRWf1P1j2
         fSC93BbfvpEzQ==
Message-ID: <803f7ef2-f217-65fe-d0b9-98ae469556fa@collabora.com>
Date:   Tue, 28 Feb 2023 19:20:48 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, hpa@zytor.com,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, gautham.shenoy@amd.com,
        ananth.narayan@amd.com,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH] perf/x86/rapl: Enable Core RAPL for AMD
To:     Stephane Eranian <eranian@google.com>,
        Wyes Karny <wyes.karny@amd.com>
References: <20230217161354.129442-1-wyes.karny@amd.com>
 <Y/NdUjLiQu+D0q7b@hirez.programming.kicks-ass.net>
 <CABPqkBTU_gnTr9ayvg220T4pO5NAguvu_UJAkZO2RUATWuMJ3A@mail.gmail.com>
 <Y/ROTsCSCFtrwwTK@beas>
 <CABPqkBQ_bSTC-OEe_LrgUrpj2VsseX1ThvO-yLcEtF8vb4+AAw@mail.gmail.com>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABPqkBQ_bSTC-OEe_LrgUrpj2VsseX1ThvO-yLcEtF8vb4+AAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/23 1:50 PM, Stephane Eranian wrote:
> Hi,
> 
> Testing Wyes' patch for energy-cores on Zen3 server loaded with triad
> bench on socket0:
> 
> $ perf stat --per-core -a -C0-63 -I 1000 -e
> power/energy-cores/,power/energy-pkg/
> #           time core               cpus             counts   unit events
>      1.001019203 S0-D0-C0              1               1.28 Joules
> power/energy-cores/
>      1.001019203 S0-D0-C0              1             231.38 Joules
> power/energy-pkg/
>      1.001019203 S0-D0-C1              1   4,294,967,130.96 Joules
> power/energy-cores/
>      1.001019203 S0-D0-C1              1             231.38 Joules
> power/energy-pkg/
>      1.001019203 S0-D0-C2              1   4,294,967,126.23 Joules
> power/energy-cores/
>      1.001019203 S0-D0-C2              1             231.38 Joules
> power/energy-pkg/
>      1.001019203 S0-D0-C3              1   4,294,967,122.50 Joules
> power/energy-cores/
>      1.001019203 S0-D0-C3              1             231.38 Joules
> power/energy-pkg/
>      1.001019203 S0-D0-C4              1   4,294,967,129.92 Joules
> power/energy-cores/
>      1.001019203 S0-D0-C4              1             231.38 Joules
> power/energy-pkg/
>      1.001019203 S0-D0-C5              1   4,294,967,121.49 Joules
> power/energy-cores/
>      1.001019203 S0-D0-C5              1             231.39 Joules
> power/energy-pkg/
> 
> I think the result of energy-cores is not reliable and I think that is
> why I did not
> include it in the patch.
> 
> Could also be a problem with the kernel code, but I don't know why it would only
> impact energy-cores given energy-pkg looks reasonable here.
> 

I'm getting consistent per core energy measurements on AMD Custom APU 405.
Probably consistency depends on the chip.

sudo perf stat -a --per-core -C 0-7 -e power/energy-cores/

 Performance counter stats for 'system wide':

 S0-D0-C0           2               0.51 Joules power/energy-cores/
 S0-D0-C1           2               0.51 Joules power/energy-cores/
 S0-D0-C2           2               0.51 Joules power/energy-cores/
 S0-D0-C3           2               0.51 Joules power/energy-cores/

What is the fate of this patch now?

[..]

>>>> Stephane, this was an oversight?
>>>>
>>> I think it may depend on the CPU model. I remember it returning either
>>> 0 or bogus values on my systems. They may have improved that.
>>> The commit msg does not show which CPU model this is run on.
>>
>> I've tested this on Zen 2, 3 and 4 server systems.
>>
>> Thanks,
>> Wyes

-- 
BR,
Muhammad Usama Anjum
