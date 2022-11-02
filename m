Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC29615C14
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 07:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKBGOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 02:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKBGOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 02:14:05 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA2422514
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 23:14:03 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id cl5so11353575wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 23:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o43vwuA24wajcH3NT9U4yHBDV+T8Vjs7dSOOeA0bYns=;
        b=A7foFwJFWO0LfBZNjW/GTN1bvA6pQ3PUyDYyqk4AouzhnW20ehbKK2I1+Y8AOoAI5g
         Ebe0FBdnb26+sW+CQK3d7iSZMvvdBg8Ua9SvqXd1hjSHKCdnqH9MqO1SILBacm/G63Un
         60+qc0LQ+44vFT6lJ8+niq2Z4SCY3U5v1zZnDG+cufeSVPcuzMve6gs1qrG/+8lo6Ge8
         g7LA0phYnsN3aOK7kvx9dCBZzv9GJ9bHrz2T6+wkT8lnTgs/nMQYzIPZ9tdXT6yNktts
         S2RG3VEOgYBoJokjSZD8ncL5IPam587+Oli4HEe64UzHFjApHG15IOhxYMpdnOmyQ2dF
         HUGw==
X-Gm-Message-State: ACrzQf2J4cARLP+FFFWWMXKtY2kDl+sJs2DOhjVVkUXY6tz61Dy8K5lv
        FAYD5Y2Vg5/rieEAXu0ZCvMyd0epsXVN8Q==
X-Google-Smtp-Source: AMsMyM73WEGv/0bpS3g4usdkao7unXKzu7XYpQVlY1GgejkAOvOWIx7GoFJ7ozN7EtKtK82ZbaowNg==
X-Received: by 2002:adf:fdcc:0:b0:236:9927:1069 with SMTP id i12-20020adffdcc000000b0023699271069mr13918890wrs.468.1667369642186;
        Tue, 01 Nov 2022 23:14:02 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id u13-20020a056000038d00b00236c1f2cecesm11431152wrf.81.2022.11.01.23.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 23:14:01 -0700 (PDT)
Message-ID: <6b8d8331-bf1c-eaf7-83c0-bb258e3f2e23@kernel.org>
Date:   Wed, 2 Nov 2022 07:14:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 1/2] x86/boot: robustify calling startup_{32,64}() from
 the decompressor code
Content-Language: en-US
To:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20221101161529.1634188-1-alexandr.lobakin@intel.com>
 <20221101161529.1634188-2-alexandr.lobakin@intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20221101161529.1634188-2-alexandr.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01. 11. 22, 17:15, Alexander Lobakin wrote:
> After commit ce697ccee1a8 ("kbuild: remove head-y syntax"), I
> started digging whether x86 is ready for removing this old cruft.
> Removing its objects from the list makes the kernel unbootable.
> This applies only to bzImage, vmlinux still works correctly.
> The reason is that with no strict object order determined by the
> linker arguments, not the linker script, startup_64 can be placed
> not right at the beginning of the kernel.
> Here's vmlinux.map's beginning before removing:
> 
> ffffffff81000000         vmlinux.o:(.head.text)
> ffffffff81000000                 startup_64
> ffffffff81000070                 secondary_startup_64
> ffffffff81000075                 secondary_startup_64_no_verify
> ffffffff81000160                 verify_cpu
> 
> and after:
> 
> ffffffff81000000         vmlinux.o:(.head.text)
> ffffffff81000000                 pvh_start_xen
> ffffffff81000080                 startup_64
> ffffffff810000f0                 secondary_startup_64
> ffffffff810000f5                 secondary_startup_64_no_verify
> 
> Not a problem itself, but the self-extractor code has the address of
> that function hardcoded the beginning, not looking onto the ELF
> header, which always contains the address of startup_{32,64}().
> 
> So, instead of doing an "act of blind faith", just take the address
> from the ELF header and extract a relative offset to the entry
> point. The decompressor function already returns a pointer to the
> beginning of the kernel to the Asm code, which then jumps to it,
> so add that offset to the return value.
> This doesn't change anything for now, but allows to resign from the
> "head object list" for x86 and makes sure valid Kbuild or any other
> improvements won't break anything here in general.
> 
> Tested-by: Jiri Slaby <jirislaby@kernel.org>
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

thanks,
-- 
js
suse labs

