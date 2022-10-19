Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1ADE6051AD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 23:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiJSVAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 17:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiJSVAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 17:00:15 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C2CF53E2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 14:00:12 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id d26so42827563ejc.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 14:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7B3HRHjNpnBpaI5qlpPSiOMumjOcoFKJt56DP4KqPMM=;
        b=SxUE8X9QkZ7Zt+v4Dx0Ua8t+BN4j3eNoHXuWMSi3TqQLAfk13oyom7hzkYIqYf8d2D
         I6meVt2PG9LN4tHmlZDCcwn38wd4rRg6/fzhz57Bsg4vlzLpZBKqrZVQLl0pCEFZDJgZ
         WalsGmHT+9X7UhJdUpyM9o0SfCGgfyRsxKusc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7B3HRHjNpnBpaI5qlpPSiOMumjOcoFKJt56DP4KqPMM=;
        b=PE816aQ0ELRS+AEXwvq03z8rQqNrsElGqsI8BK/6sZQVGFYvLcAT+7SANEMBitTZgn
         glhm5DOAPcnCId8NLo7YX1ihtmry8ifX9a5EjS+cZD+mJc5N2aK2feIBS+QBTaWvf4dM
         bGGXltZ1PZh6XeIRakMZybCVCDhiXSF90gQOmO4maCL/NDdl5SAWUmgGk/Xc3oI6aq1G
         Pa2m1hdjyckE2nsnpI0wQsp+TnZLpTSfJO53b2wQLJleCNS8vs6Sioj6DsjgPaBHnpds
         qzTTrHDXWyek1fURf+0rRLSqC2GzN9G1qDQ/jh/zcCJEHAQLVo+i5yjosaUEl1ESH0ja
         MfIw==
X-Gm-Message-State: ACrzQf0H+lw3tv2z5FdNULAgi6IB0scaaNHkkXpe2CZQ+UwH3gYmMWNT
        4Q96w1q3D3l4H2EFQslP/UkcJg==
X-Google-Smtp-Source: AMsMyM7j83A8j2fgwHRwYEHy6dycWlOPv4NGP8/RSv4ZJ682CTNJ+GtTySsLCbknc8ARf6bOFr0SNg==
X-Received: by 2002:a17:907:162a:b0:78e:2859:76be with SMTP id hb42-20020a170907162a00b0078e285976bemr8268481ejc.768.1666213210993;
        Wed, 19 Oct 2022 14:00:10 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.65])
        by smtp.gmail.com with ESMTPSA id k13-20020a17090627cd00b0077826b92d99sm9448022ejc.12.2022.10.19.14.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 14:00:10 -0700 (PDT)
Message-ID: <cc38380a-de69-d8f6-44b5-8ae4d073d916@rasmusvillemoes.dk>
Date:   Wed, 19 Oct 2022 23:00:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/1] vsprintf: protect kernel from panic due to
 non-canonical pointer dereference
Content-Language: en-US
To:     Jane Chu <jane.chu@oracle.com>, pmladek@suse.com,
        rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     wangkefeng.wang@huawei.com, konrad.wilk@oracle.com,
        haakon.bugge@oracle.com, john.haxby@oracle.com
References: <20221019194159.2923873-1-jane.chu@oracle.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20221019194159.2923873-1-jane.chu@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2022 21.41, Jane Chu wrote:
> Having stepped on a local kernel bug where reading sysfs has led to
> out-of-bound pointer dereference by vsprintf() which led to GPF panic.

Just to be completely clear, the out-of-bounds dereference did not
happen in vsprintf if I understand your description right. Essentially
you have an array of char* pointers, and you accessed beyond that array,
where of course some random memory contents then turned out not to be a
real pointer, and that bogus pointer value was passed into vsprintf() as
a %s argument.

> And the reason for GPF is that the OOB pointer was turned to a
> non-canonical address such as 0x7665645f63616465.

That's ved_cade , or more properly edac_dev ...

> 
> vsprintf() already has this line of defense
> 	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
>                 return "(efault)";
> Since a non-canonical pointer can be detected by kern_addr_valid()
> on architectures that present VM holes as well as meaningful
> implementation of kern_addr_valid() that detects the non-canonical
> addresses, this patch adds a check on non-canonical string pointer by
> kern_addr_valid() and "(efault)" to alert user that something
> is wrong instead of unecessarily panic the server.
> 
> On the other hand, if the non-canonical string pointer is dereferenced
> else where in the kernel, by virtue of being non-canonical, a crash
> is expected to be immediate.

I'm with Andy on this one, we don't add random checks like this in the
kernel, not in vsprintf or elsewhere.

check_pointer_msg is/was actually more about checking the various
%p<foo> extensions, where it is (more) expected that somebody does

  struct foo *f = get_a_foo();
  pr_debug("got %pfoo\n", f);
  if (IS_ERR(f)) { ... }

[possibly in a not so obvious path], and the PAGE_SIZE check is
similarly for cases where the "base" pointer is actually NULL but what
is passed is &f->member.

Rasmus
