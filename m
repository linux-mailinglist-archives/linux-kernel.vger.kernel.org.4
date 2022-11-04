Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDC16193DA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbiKDJst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiKDJsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:48:46 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB47712A;
        Fri,  4 Nov 2022 02:48:45 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id t10so5631367ljj.0;
        Fri, 04 Nov 2022 02:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16368SpxFYfA1qhqcCioWm185iXGRNzUZqOGw6lrgz0=;
        b=Xd1ynscTvD0jWIVc/LcHxRJuZm1oz4N2zhwYuqO5oc04eoAsff/91czEHVf63D9c6S
         QhSWM2ULdJzhfOlexNlKXfArB9ox7bydCymJ/ss68zhzBgBFahcrGSX40OjGe6MNTK+8
         GiRNhL2LCrx0fuqz24in5TvhXAo6gH179KYW1usZr4iNmpAiPY1GN/4cNELLcYAZPmaQ
         E0Pum6PU6LMLZtp5XfiD2Nm4CuBDOPVNxkxtPUo84BJ1Vm2GqjHgHpcNgEVbaeIh/bfD
         Uo4Tf1RJTLU5+hMdl+HzGX/FcGVQfUPJ2fb29Sd/BmRYE1HM4CTGj+hupqrZcjbiXp/Y
         hzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=16368SpxFYfA1qhqcCioWm185iXGRNzUZqOGw6lrgz0=;
        b=5hBmd8o7JXy8L8vIDqRQftTnKale7LRsf3YL/3D0hFtaCu1aAVh9FW8HIIg+Oaw82R
         pV2j8zz2pdCNqqlVlALUrQob5WqDF2fS3rL8QcwlN1mMRdHHYgXr2AMs/9N1n/sV3sk+
         xD+pj825NjPv2KrFJLFkhEbPBbT+bwm9WMPFCUSO2MhiSv4Qe9MZ56b3nfTKkgO+0Xrs
         9fmVoWeK9Z2ihECQJ/Y91qQtXihqjggTS+8pvBZzhSwAd50N1i2pcvBDriRFsfkkOTeK
         8KVfSoLaK7ll7jyASPpbT4RqEqhcdcRCURpSD/fC/CYyvoifHFATKT9nC4cIwFMWpZMu
         zJsw==
X-Gm-Message-State: ACrzQf2AyD41r6IC4jYjSj6Sp5AqYRo8jteKf1quRNZFbBM6gSiAdUc0
        ydAEp7BAkrw2Xs+Tk6zeLmYH+mpQI4w=
X-Google-Smtp-Source: AMsMyM5lUfEeal7ji1xNwmiMKu1u535j/1rjCAffZnbxyiDTmKVBFhL/ByvYXf/1X7wZe7Nu2V8JCA==
X-Received: by 2002:a2e:8255:0:b0:277:e01:6119 with SMTP id j21-20020a2e8255000000b002770e016119mr1989418ljh.33.1667555323617;
        Fri, 04 Nov 2022 02:48:43 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.79.14])
        by smtp.gmail.com with ESMTPSA id n20-20020a2e7214000000b00277078d4504sm368687ljc.13.2022.11.04.02.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 02:48:42 -0700 (PDT)
Subject: Re: [PATCH] irqchip: loongson-liointc: fix improper error handling in
 liointc_init()
To:     Liu Peibao <liupeibao@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>
Cc:     Yinbo Zhu <zhuyinbo@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221104080347.21527-1-liupeibao@loongson.cn>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <539b63ee-7655-50c1-a95f-9f8210e7229d@gmail.com>
Date:   Fri, 4 Nov 2022 12:48:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20221104080347.21527-1-liupeibao@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 11/4/22 11:03 AM, Liu Peibao wrote:

> For cores less than 4, eg, loongson2k1000 with 2 cores, the
> of_property_match_string() may return with an error value,
> which causes that liointc could not work. At least one isr
> is what should be checked like previous commit <b2c4c3969fd7>
> (irqchip/loongson-liointc: irqchip add 2.0 version) did.

   It should look like this:

commit b2c4c3969fd7 ("irqchip/loongson-liointc: irqchip add 2.0 version")

> Fixes: 0858ed035a85 ("irqchip/loongson-liointc: Add ACPI init support")
> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
[...]

MBR, Sergey
