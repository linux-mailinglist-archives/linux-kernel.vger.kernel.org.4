Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74F174FEDD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 07:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjGLFrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 01:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjGLFrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 01:47:18 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119C8135;
        Tue, 11 Jul 2023 22:47:17 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3fbc0609cd6so66203475e9.1;
        Tue, 11 Jul 2023 22:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689140835; x=1691732835;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7KhU5Ez9+mJlZdemSaBOe5QuCdwTYr99cQtnBoKdbfQ=;
        b=PaYe/Jjm9G+Wj+w1Flh2fimxxBZocpUxwhoBzJk6H7yaJGsboZsqhWSl+t4LVyE0Xb
         G3lm4L3faOTS9Y6AAIQo6/Am6ROEtCHRGcafiVBtQ+w2+i9TUpgEo9hB1MIm8gKhwrea
         UiKiNA4xoKcutEQgFZvtYY1UMELTnZ1QUIT4PC3chCb628ZCm+AIa21ROB0WHdr9AAye
         qaOMEismcViepCtgTqDgKT3U/OoO6BeAxeoLe0iYCszEzO1gGwmo/RXvM2fMGpCGDIqV
         NG/9z5K4Wz71I9USbmeDdwAeYoJXn1FyfM84LUm1M0xkZTd1W/b/cQmBHoWP8k+GHllC
         yrKQ==
X-Gm-Message-State: ABy/qLZZI9jIhEsMHPUw5stzIiyWYYSJAbeV2aYXaV6/wdwcw5ErDc7z
        JYBCNiAWkT7Q+0AcMCcZYuSowG1aUXfNCg==
X-Google-Smtp-Source: APBJJlGv2XsuPzLypp+ZJLBe+5DhRe1oSQlYjrlgxRLpONLrWAgxIn3TsbyxIaW+JqRPV32PGJqcvA==
X-Received: by 2002:a7b:c44c:0:b0:3fc:4:a5b5 with SMTP id l12-20020a7bc44c000000b003fc0004a5b5mr13760957wmi.29.1689140835231;
        Tue, 11 Jul 2023 22:47:15 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id a25-20020a1cf019000000b003fbb346279dsm4122031wmb.38.2023.07.11.22.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 22:47:14 -0700 (PDT)
Message-ID: <da2fdd15-fae1-2bf6-04e7-568c715372ce@kernel.org>
Date:   Wed, 12 Jul 2023 07:47:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Michal Suchanek <msuchanek@suse.de>, linux-modules@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230711153126.28876-1-msuchanek@suse.de>
 <20230711153457.29497-1-msuchanek@suse.de>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] depmod: Handle installing modules under a prefix
In-Reply-To: <20230711153457.29497-1-msuchanek@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11. 07. 23, 17:34, Michal Suchanek wrote:
> Some distributions aim at not shipping any files in / ustside of usr.
> 
> The path under which kernel modules are instaleld is hardcoded to /lib
> which conflicts with this goal.
> 
> When kmod provides the config command use it to determine the correct
> module installation prefix.
> 
> On kmod that does not provide the command / is used as before.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>   Makefile          | 4 +++-
>   scripts/depmod.sh | 8 ++++----
>   2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 47690c28456a..b05d696f06bd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1165,7 +1165,9 @@ export INSTALL_DTBS_PATH ?= $(INSTALL_PATH)/dtbs/$(KERNELRELEASE)
>   # makefile but the argument can be passed to make if needed.
>   #
>   
> -MODLIB	= $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
> +export KERNEL_MODULE_PREFIX := $(shell kmod config | jq -r .module_prefix)

echo -e 'KERNEL_MODULE_PREFIX := $(shell kmod config | jq -r 
.module_prefix)\nall:'|make -f -
invalid command 'config'
parse error: Invalid numeric literal at line 1, column 5

I think you should pipe kmod's 2> /dev/null to support older kmod. Ah, 
but you'd need 2> /dev/null for jq too. That would not be good as jq 
might not be installed and a user wouldn't see the error. So instead, I 
would do:

$(shell kmod config &> /dev/null && kmod config | jq -r .module_prefix)

thanks,
-- 
js
suse labs

