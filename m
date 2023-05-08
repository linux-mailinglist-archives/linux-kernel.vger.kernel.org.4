Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A1D6FB572
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjEHQoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbjEHQox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:44:53 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D511C1;
        Mon,  8 May 2023 09:44:52 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-24e14a24c9dso3404138a91.0;
        Mon, 08 May 2023 09:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683564291; x=1686156291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UKOFP0LLYct/YBl+wmdCJgmdIN9Q6Kmod9oJFxHPnG8=;
        b=eDuemYLgMp+hP02pNfGL38Lj7cmF7Lcg0ru42KOTSqQH+a/+lZEee/0n77rs0+Qw9D
         t7OleNMBEgDNouG/C9ywXSOevHA/xDZnEc4Eps19CLWCufLc8yz65y3mneisG8O1KHLb
         8AqCAkUaXov329W4Sn8I5aUN+D/e+ECUxr4QCA+GeKZJZo5JuBkoB+CPVNKgfU8/bO3R
         5dGeQwgBAPZ8KQnQSdLeSfoS7cq3YJXIKNMQQmOOIW5uxXOGWCJwXeBVtirr8jE/n5nw
         Q+H4M3eJtaz6BMHAgzUGrSjeMwsX6QyBWHBFbg6Ic+2ofqNw35ElUmcmD+qm6nd9YQDR
         fFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683564291; x=1686156291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKOFP0LLYct/YBl+wmdCJgmdIN9Q6Kmod9oJFxHPnG8=;
        b=UV0yhOTKoQeFBbBwIxJd/Q3ajD4+RWv+xxWyr6/lcq/9P74InL07YT3HaFv/HFCyzb
         QSij2o3hVr0Tu287vfPsInB0w3NfCMWGgpT9+Zl51tL4Eo/Xf9EM7lViYbDrOoyH4AK5
         h8vXVudSxnrcXLcVCdeDoaa0GASO7omvTiLKMQZlbOohiZVi6IhL55v4thuFoDwSL6EB
         JayjTgkkq3Ta0d6kO765pjVNIL/IwConI9aLN1k/7c1ofOSofyF6i959TdWXloPl32Nc
         hrt47Q5U3CUlC5eM6t16Zc+Flq1T80JAFv6lei+w7S3qqkWhJRjmsyxnMee5OaZaNxC3
         0sVA==
X-Gm-Message-State: AC+VfDxykjUtPnsXNmSiDuTyxzJsiSOdE1Q3vb64SrOj3QeLtzGjlvf3
        eMGEQj6S1ZTvkwZ/tUbRhSo=
X-Google-Smtp-Source: ACHHUZ4b60htdC5Ba/WYAyy3RZgAunPovWBQwfeAFAtW54RnyVFENO+/sbQQrEs92yGJ4+qX0s7tTQ==
X-Received: by 2002:a17:90a:f488:b0:247:8ce1:996e with SMTP id bx8-20020a17090af48800b002478ce1996emr11038074pjb.29.1683564291416;
        Mon, 08 May 2023 09:44:51 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:4d1:db5a:dbba:cd34])
        by smtp.gmail.com with ESMTPSA id k11-20020a63ff0b000000b00528af015a8dsm6502153pgi.14.2023.05.08.09.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 09:44:50 -0700 (PDT)
Date:   Mon, 8 May 2023 09:44:47 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/4] Add haptics support to Nexus 5 using pwm-vibra driver
Message-ID: <ZFkm/wT/+5mlChWO@google.com>
References: <20230427-hammerhead-vibra-v1-0-e87eeb94da51@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427-hammerhead-vibra-v1-0-e87eeb94da51@z3ntu.xyz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 10:34:25PM +0200, Luca Weiss wrote:
> A while ago Brian Masney sent some patches for a clk-vibrator which was
> then succeeded by the idea of a clk-pwm driver that "converts" a clock
> into a PWM and to use the existing pwm-vibra driver.
> 
> Since clk-pwm has landed last year we can finally add haptics support
> upstream.
> 
> We just need to add support for an enable GPIO to the pwm-vibra driver
> since that also needs to be high for the haptics to work on this device.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Luca Weiss (4):
>       dt-bindings: input: pwm-vibrator: Add enable-gpio
>       Input: pwm-vibra - add newline to dev_err prints
>       Input: pwm-vibra - add support for enable GPIO
>       ARM: dts: qcom: msm8974-hammerhead: Add vibrator

Applied patches 1-3, thank you.

-- 
Dmitry
