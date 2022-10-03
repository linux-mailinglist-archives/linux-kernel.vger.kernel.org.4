Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775285F389E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 00:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiJCWKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 18:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiJCWKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:10:19 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061D715FC8
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 15:10:18 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id h28so7434824qka.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 15:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=8tQFqbMsDcL//cqoHMj+RGE2AtlvGSBQlWoMcN9cKQ4=;
        b=AvtY0tiOxSdUPbeIhtIgG1MOY/W95riY4n2PmaJg7iAqsgfS/1d29gWkI+jxeSHNb/
         Ln987UU1+Wy0hgX/HN+Y7aSxXib0MfaspEQOwQCfzdyYxbzkBj7hXGsxTByWQmoBhS6h
         61g7/NKT1ET2QlM1CXqz6VuyYTGo3BaPfHcmlZKLKCQPeQwpwvydumERXjcd2kRbcStp
         yaLhkumaGlt7sxqMLhJtfVIbNEniUjJC3UC1uFAUgtqKx/V82nVN4fms8IfKR7D1fRBx
         hOUBXrTpyJdcl1gSze27v0Kw4kTvSVZz6xMJ3y3ZRy9XL7VjBPHdEruocOv46wIWoxqa
         X9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8tQFqbMsDcL//cqoHMj+RGE2AtlvGSBQlWoMcN9cKQ4=;
        b=475skr28+uNYIxY6HKXQz82pNPBpmIC6YTUB1XJwCuVZ30vJujeuFxYEIbdHoFG/Ju
         u5ygXTRskcEIiiyF+n4T7HpBSSNahwaVAdFrL7fupWIlmQIfwppDGSHvzmUueV2tf151
         UdHNN/97cqHKWun0p2lm2vkELP16MB18fy3/Vi8LzeKvrqeafzMLb2lQ7pshdC2Ry4bg
         e6jUWvwNUo52RJ5XR1za0nYzUlcqP/JzDVxp7mNaeZocmbBdrz+9OKVdSPA10RzGX4Dl
         hGRfh/9kodDWgSw3jm0Q4RQa2ZFNHD4AI3e6OF9viCH5Ez/ZZccSOSfeuRPV/RYmx9un
         2TYA==
X-Gm-Message-State: ACrzQf3nu587ZgbMf8pB26iSvyb4sFltCKoc7t7ouvCt2t5Fp/mC/5OP
        RDyKgygNKAah01oLkzxhOMI=
X-Google-Smtp-Source: AMsMyM7+1Lrc4a9pzbPkWKRDqlKgvwIcyf1qMIdnzZrYQkP0ffOMSCPf65kF4EQB9iDT7Ke8KuqGAg==
X-Received: by 2002:a05:620a:280d:b0:6cf:ab57:a130 with SMTP id f13-20020a05620a280d00b006cfab57a130mr15257843qkp.749.1664835017083;
        Mon, 03 Oct 2022 15:10:17 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id o26-20020ac8429a000000b0035a65bb6c1asm10881645qtl.85.2022.10.03.15.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 15:10:16 -0700 (PDT)
Message-ID: <7a7dc0a8-326d-7734-fc9c-3cc1121cb2e0@gmail.com>
Date:   Mon, 3 Oct 2022 15:10:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ARM: sun9i: smp: fix out-of-bounds access error
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     f.fainelli@gmail.com, anand.gore@broadcom.com,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        =?UTF-8?Q?Myl=c3=a8ne_Josserand?= <mylene.josserand@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
References: <20220929012944.454613-1-william.zhang@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220929012944.454613-1-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/22 18:29, William Zhang wrote:
> When running multi_v7_defconfig with CONFIG_UBSAN enabled, kernel
> reports UBSAN array-index-out-of-bounds error in sunxi_mc_smp_init
> function on non-sunxi platform.
> 
> Checking index to the sunxi_mc_smp_data array for out-of-bounds
> condition is needed to cover non-sunxi platform. Also fix the handling
> of return value from of_property_match_string function. Only negitive
> value is an error condition and should bail out from the function.
> 
> Fixes: 1631090e34f5 ("ARM: sun9i: smp: Add is_a83t field")
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

FWIW:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
