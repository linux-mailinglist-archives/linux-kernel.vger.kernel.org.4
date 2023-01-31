Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C25683AC8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 00:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjAaX55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 18:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjAaX5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 18:57:55 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3256230E9;
        Tue, 31 Jan 2023 15:57:53 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-15f97c478a8so21489519fac.13;
        Tue, 31 Jan 2023 15:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tCn4l7XyJmqvO8YOLUdVG8XKO+1cKoU6pW7RtF3tr74=;
        b=IzwooY+sBeq2MnjOtOpwvdVeZJFJhJySU3D2cF+O4XTn2J5TGIHfbkS5m9z0aootoi
         NgRUo/ESY5IPAWz609HRTLPZOiBzgeFt9EHSCw1RE5Dow1gbmsd47N4D/1WUEH6bQthG
         k6npYF3VU3fNnEH1wH0p+AyH6WHtV4oTemrtrbIt4iEZiQmA1w37CRiQdammZDXO4IMO
         NiSiNez5FU4Ndx+WimDiV0fw2NOP2YdnIdrrwdwTCvMJ5tErPMJ43eSCg1OYEAPGVcS+
         lyk3mRsLVFqFOHUM3m1ZMISJ/9WyLnY1zw36XHbc8QJwrgGdDAmgF6iH2FPnLZs6tq6w
         FPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tCn4l7XyJmqvO8YOLUdVG8XKO+1cKoU6pW7RtF3tr74=;
        b=XPMoK4Ilq7m+Z7Ft8ZSCUTh1N7K4ivKpcYPwZ8nRRk4998vU0gPD5f7E/3Inaxnm+v
         LcujCiQBaknaZShii8cBhHuwJXL5+1zQCSv/WHT7qu9+Tpsmi63PotXatkftVDnWM3g9
         KtfG7fFUhV2esWH9NDU//1KB16K1aCN67qoT63Qfm7IgtanjfDpAdD0hL6uESLjRJ0od
         38DruiBzP4x9q9rrc0s0QIoeQAUSG3JEBIv7WfoPDEWx1mXVJugwplDIkIVAgTuFzTS0
         dVAJ4V8QkSigrCTSq5/jDvnfONPaBDd6Bjo8vDQ+gsxaOjVOaUTdN/SUKIhhzo+LU22I
         Ewcw==
X-Gm-Message-State: AO0yUKUP+R37g21Xd3ESRbjHQzXk/2jnOZsT7DtHbozur9/YNlirnQMk
        pTlyARL8wqgogfSiIybC/95rI8Uxf5z338X+i9gJQc/PJ1M=
X-Google-Smtp-Source: AK7set/aCWzWuEyqapUB3071bHqGfTixl5dH1sOk6LZzWFxLlKNtaYfLDwh05ntlkd5cZpfYeUNQw8ahELSR+Vl7dwY=
X-Received: by 2002:a05:6870:3913:b0:163:4ae7:f200 with SMTP id
 b19-20020a056870391300b001634ae7f200mr2022329oap.84.1675209471325; Tue, 31
 Jan 2023 15:57:51 -0800 (PST)
MIME-Version: 1.0
References: <20230130131024.695212-1-arnd@kernel.org>
In-Reply-To: <20230130131024.695212-1-arnd@kernel.org>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Tue, 31 Jan 2023 15:57:37 -0800
Message-ID: <CAKdAkRRnjdsQC_4qsjtHY1FfuPZ9vmV6gjDOeCzp7CZQATcUrw@mail.gmail.com>
Subject: Re: [PATCH] rtc: moxart: convert to gpio descriptors
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 5:29 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The conversion is fairly simple as the driver only has DT based
> probing, and all the gpio calls have a direct replacement.

This is plain broken :( You cannot directly replace
of_get_named_gpio() with non-standartly-formatted GPIO name with
devm_gpiod_get().

Thanks.

-- 
Dmitry
