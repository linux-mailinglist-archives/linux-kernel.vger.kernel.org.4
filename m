Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D48065FF98
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 12:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjAFLdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 06:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbjAFLdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 06:33:13 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E537188D;
        Fri,  6 Jan 2023 03:33:09 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d17so1025510wrs.2;
        Fri, 06 Jan 2023 03:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OqkdQ5G9rb4qZN5W7C4j2Bu+ggdN8QmTgW7jJJOTWPo=;
        b=Lw0UaEgaQpA0N2O0PV5PJVp7RFES+I7ywOv87/pdBuJoHEBy2cvcxSV4vLfO9/3wDR
         tKdAVsjHm7o5eDlvLVou7792v0c0oGXw29sWl9HJrWRIju6C8ey5undQ9Kzkx6KMTd5i
         n1C4Q2xcOwGNoMsjpGHvg7dZHlrUoMCH8cz1GsjnpBQGjpXvmbNDjKkgL2YJC85rQenn
         2jOB5Je0NXScrZcgjIEl+8R4q3PpOmbiBbg5C220QAU5qQlqIvdqGijmqsFAlOee9kiN
         Vil3gt9XdiMSwiCyMoP4hO2fRfeGww3Ak/H9z1KvNmxsxcPm3iaF4xqNn2LSQxfjgGy0
         DOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqkdQ5G9rb4qZN5W7C4j2Bu+ggdN8QmTgW7jJJOTWPo=;
        b=p9/5NYF9iS9swSbkKv08cYQUyAzvNr88YBDQNLkX0nXMxH26gYIdCWEroPezriXkKj
         pONRX+exr/kHHrFqLypRc7MJuUQ47WyvNk2waoq1op714HkH/JnNJBCb6aEnkLf0ZRcZ
         xWFxJgnR5ffMB8TwlRjWPriNRc8ehZKHDIp00qp6SBNsBmjiLNhSPhCt2mKaLnC9wfdv
         qFAmCBzX5eiYk1P+yRwOYtUVutl6IxXNatEqBTrvsj8SrlbWZQJ0fdw7mj/uBVBAs7CJ
         aZCjuW/1S3uBT8TevpRI3GcvnrfctTCLt7gbcOZhDUGFi6LOQ2DcMtrq2rORniUeSHyZ
         AqDQ==
X-Gm-Message-State: AFqh2koo5xan8sbDm6rMVUi0+MSxlYuj4uHGTEL417MNCmCtAAa47kRA
        BoCmHeV30yK/2Y57Xld3Jyk=
X-Google-Smtp-Source: AMrXdXue3C1pjFHQKaFnRtbMyNGy4MkodHQFfwjbhxT5GhV8IeRRXO3+QcaY52gWAEp3ZMTba7KrnA==
X-Received: by 2002:adf:9dd1:0:b0:242:165c:95ed with SMTP id q17-20020adf9dd1000000b00242165c95edmr33567664wre.48.1673004788116;
        Fri, 06 Jan 2023 03:33:08 -0800 (PST)
Received: from gmail.com (1F2EF380.nat.pool.telekom.hu. [31.46.243.128])
        by smtp.gmail.com with ESMTPSA id a11-20020a5d508b000000b002779dab8d85sm942586wrt.8.2023.01.06.03.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 03:33:07 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 6 Jan 2023 12:33:05 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] perf/x86/rapl: Add support for Intel Meteor Lake
Message-ID: <Y7gG8R8ZRWTXYSGq@gmail.com>
References: <20230104145831.25498-1-rui.zhang@intel.com>
 <25d07838-3904-a086-4238-f56c9424b53a@intel.com>
 <ea9186869cca50a21efcc1a9cc4dbe5adcd1784b.camel@intel.com>
 <Y7aejeHDpLlwwYbr@zn.tnic>
 <4cc5cd868b20366fc9d4bf157656e0c295074282.camel@intel.com>
 <Y7f6RhF8FuK9R399@zn.tnic>
 <Y7f+UqN5qqfJUeoy@gmail.com>
 <Y7gB+uVpSJAQ6p+9@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7gB+uVpSJAQ6p+9@zn.tnic>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Jan 06, 2023 at 11:56:18AM +0100, Ingo Molnar wrote:
> > It's a trade-off in any case: there's a point where quirk flags or even 
> > feature flags become harder to read and harder to maintain than cleanly 
> > separated per model driver functions.
> 
> Yeah, no, singular: a synthetic feature *flag*: X86_FEATURE_RAPL.
> 
> cpu/intel.c can set it and driver can test it.
> 
> Everything else inside the driver.
> 
> Until Intel can get their act together and actually do a CPUID bit like AMD. :-P
> 
> But when you think about it, whether the model matching happens in the driver or
> in cpu/intel.c doesn't matter a whole lot.
> 
> All that matters is, they should finally give it a CPUID bit.

The other thing that matters here are the RAPL *incompatibilities* between 
model variants, which are significant AFAICS.

With a CPUID we get a kind of semi-compatible hardware interface with well 
defined semantics & expansion.

With 'non-architectural', per-model RAPL features we get very little of 
that...

Which is why it's a trade-off that is hard to judge in advance: maybe we 
can simplify the code via a synthethic CPUID[s], maybe it will just be 
another zoo of per-model feature flags...

Likely won't be able to tell for sure until we see patches.

Thanks,

	Ingo
