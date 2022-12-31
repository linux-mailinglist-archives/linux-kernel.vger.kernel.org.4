Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12B365A03E
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 02:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbiLaBHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 20:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235933AbiLaBHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 20:07:19 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945341573A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 17:07:18 -0800 (PST)
Received: from [IPV6:2601:646:8600:40c1:5967:deb4:a714:2940] ([IPv6:2601:646:8600:40c1:5967:deb4:a714:2940])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 2BV170UU1463000
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 30 Dec 2022 17:07:01 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 2BV170UU1463000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022120601; t=1672448823;
        bh=u08p8tRZoIJ4p+ilvqUkzflwpfqtfcHjfr46xtIIqN4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=klQ791Lknjvg8C6br7VX3DtRnuY/spsJ6m5ccDf8RiJMLdEZIn4gbvrNf1vbZHcYf
         qkNzO2Q3QS/Snu5vC19/e2q8STbS6eDFZ2oo27TUacT+RkbL7k6E72WTsH8gZJ6pcu
         ag6Mz5Cfec2Oj6QiJXK705bGSgS4ZCvZ9IyJF9Zc0H4y2PIGjmfkIA31yyoYzQQy/s
         QzUdhVuv2vySfRcXPlcQjEnvPGkvWKxsDOfVI9TIlKXzTmHkPRO0jLboYRwO8tZCEr
         OMl6jMfUqXUyXx5KhvuhRSZtPoQIcED+tBFnc9XbjTlhQ+3yyaKJtw3tWrkeiVUm4E
         oJr3N2riwE94Q==
Message-ID: <46466e54-25c3-3194-8546-a57cd4a80d9d@zytor.com>
Date:   Fri, 30 Dec 2022 17:06:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH qemu] x86: don't let decompressed kernel image clobber
 setup_data
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Borislav Petkov <bp@alien8.de>, pbonzini@redhat.com,
        ebiggers@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, ardb@kernel.org, kraxel@redhat.com,
        philmd@linaro.org
References: <Y6x1knb8udpSyMSp@zx2c4.com>
 <9188EEE9-2759-4389-B39E-0FEBBA3FA57D@zytor.com> <Y6z765zHrQ6Rl/0o@zx2c4.com>
 <AF921575-0968-434A-8B46-095B78C209C1@zytor.com> <Y62MdawGaasXmoVL@zn.tnic>
 <Y68Js5b0jW/2nLU4@zx2c4.com> <Y68Zf/MKmX3Rr18E@zn.tnic>
 <CAHmME9oPUJemVRvO3HX0q4BJGTFuzbLYANeizuRcNq2=Ykk1Gg@mail.gmail.com>
 <Y69B40T9kWfxZpmf@zn.tnic> <E5D0A77E-5ABC-4978-9A66-37B60DA43869@zytor.com>
 <Y69h6ur79SMhu61F@zx2c4.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <Y69h6ur79SMhu61F@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/30/22 14:10, Jason A. Donenfeld wrote:
> On Fri, Dec 30, 2022 at 01:58:39PM -0800, H. Peter Anvin wrote:
>> See the other thread fork. They have identified the problem already.
> 
> Not sure I follow. Is there another thread where somebody worked out why
> this 62meg limit was happening?
> 
> Note that I sent v2/v3, to fix the original problem in a different way,
> and if that looks good to the QEMU maintainers, then we can all be happy
> with that. But I *haven't* addressed and still don't fully understand
> why the 62meg limit applied to my v1 in the way it does. Did you find a
> bug there to fix? If so, please do CC me.
> 

Yes, you yourself posted the problem:

> Then build qemu. Run it with `-kernel bzImage`, based on the kernel
> built with the .config I attached.
> 
> You'll see that the CPU triple faults when hitting this line:
> 
>         sd = (struct setup_data *)boot_params->hdr.setup_data;
>         while (sd) {
>                 unsigned long sd_addr = (unsigned long)sd;
> 
>                 kernel_add_identity_map(sd_addr, sd_addr + sizeof(*sd) + sd->len);  <----
>                 sd = (struct setup_data *)sd->next;
>         }
> 
> , because it dereferences *sd. This does not happen if the decompressed
> size of the kernel is < 62 megs.
> 
> So that's the "big and pretty serious" bug that might be worthy of
> investigation.

This needs to be something like:

kernel_add_identity_map(sd_addr, sd_addr + sizeof(*sd));
kernel_add_identity_map(sd_addr + sizeof(*sd),
	sd_addr + sizeof(*sd) + sd->len);


TThe 62 MB limit mentioned in boot.rst is unrelated, and only applies to 
very, very old kernels that used INT 15h, AH=88h to probe memory.

	-hpa
