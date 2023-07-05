Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5261174805A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjGEJCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 05:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbjGEJCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:02:31 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E891BE2;
        Wed,  5 Jul 2023 02:02:08 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-313f61890fbso6915787f8f.3;
        Wed, 05 Jul 2023 02:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688547725; x=1691139725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UctMD9lLbWvKap2mhJgEf9aqIh1/TdkYL5wIxpcYTBk=;
        b=r8+4Tj5Xb7xK0aTS57RfRrE0CNQiGZbpPtZuex/JSE3MnQUQmtVMpuOLTqhO6uu+9A
         iIS5MzRPLbWdYz1A5uCEOXpIMYqD4lzTALw0l0zLr+p0BbTriV9eIb+8ymenTCl7IcmH
         kmyc2kHbUSyfFUo45mxLGEOWMERPvus+9Gw9EcATNx8pgMOubQwojQvSXQeh4VTnawOH
         epiAeASwaOISfmMxtcJuKRF63lNflEW056nhKEeHCY6BZvW7ib5AZVyD9RE/Z8gRgAEm
         4aBckDidNyJF0J7ISx1Fugzsq0TFwt3oW/chZiWr+jck0HR1AfxfCf252FWu+8DHKXKA
         nuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688547725; x=1691139725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UctMD9lLbWvKap2mhJgEf9aqIh1/TdkYL5wIxpcYTBk=;
        b=iLJGZAb3sRxrXt7Dr0Gy1n7l7EgjRrQO/iLhjfDljAi5Dr0ebPFGkfmwNR8nTwSMJ6
         8b61THFvQBR6nnge9jkI3KjAr0BGyGyiqgZryYTOKzjIuHZ+KeSTdlUN3bSV9DsdAXje
         nlXQpfQCo1vAfNtfd513TOLpPOptw5vnWh8Dcz0D2QMeXNlBMzthmaIvIIngw6fgq06j
         05d54MRBUS8IPFhlRJNxqyPddkZydLyqSRtIu5zcqXlFjCANKfx3cyRzdHvCqmzgDof6
         Sg7EHV4Nut/FBSDKtQxeeY1OOYavhrY909iyJ9lyoqgH0vdm095s6b7lwpbK95E68jSS
         1+VA==
X-Gm-Message-State: ABy/qLZNCyVETyROsJhNIfA10O2k3mxtoqGaVq/IVtnkIdpNws8FvaZN
        wFrKADJWHF1tyoVhZt7/jF10Pwoe2Uz8JvcC2xA=
X-Google-Smtp-Source: APBJJlGyt6Z8HpphV7Bs5WkfA8gyuunqGho5HCctx0qj3+Nx/dh8VCLMOXn5Ta043CeE4oSyMKF0K8cew8kRbbhRpkI=
X-Received: by 2002:a5d:4c43:0:b0:313:eee0:89a4 with SMTP id
 n3-20020a5d4c43000000b00313eee089a4mr13008306wrt.12.1688547725257; Wed, 05
 Jul 2023 02:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230705072304.37741-1-dg573847474@gmail.com> <d15656f4-0d39-fbaf-884a-77935cd69e3f@linaro.org>
In-Reply-To: <d15656f4-0d39-fbaf-884a-77935cd69e3f@linaro.org>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Wed, 5 Jul 2023 17:01:54 +0800
Message-ID: <CAAo+4rW+bU-M=Wb16yMev8i3tdafH1p1bryCkKygDsShQ08n0w@mail.gmail.com>
Subject: Re: [PATCH v2] watchdog: s3c2410: Fix potential deadlock on &wdt->lock
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     alim.akhtar@samsung.com, wim@linux-watchdog.org,
        linux@roeck-us.net, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for the reminder!

I didn't notice that s3c2410wdt_keepalive() can also be called from
.ping callback. Would send a v3 patch soon.

Best Regards,
Chengfeng

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E4=BA=8E2023=E5=B9=B4=
7=E6=9C=885=E6=97=A5=E5=91=A8=E4=B8=89 16:58=E5=86=99=E9=81=93=EF=BC=9A
>
> On 05/07/2023 09:23, Chengfeng Ye wrote:
> > As &wdt->lock is acquired by hard irq s3c2410wdt_irq(), other
> > acquisition of the same lock under process context should
> > disable irq, otherwise deadlock could happen if the irq preempt
> > the execution while the lock is held in process context on the
> > same CPU.
> >
> > [Deadlock Scenario]
> > s3c2410wdt_suspend()
> >     -> s3c2410wdt_stop()
> >     -> spin_lock(&wdt->lock)
> >         <irq iterrupt>
> >         -> s3c2410wdt_irq()
> >         -> s3c2410wdt_keepalive()
> >         -> spin_lock(&wdt->lock) (deadlock here)
> >
> > [Deadlock Scenario]
> > s3c2410wdt_probe()
> >     -> s3c2410wdt_start()
> >     -> spin_lock(&wdt->lock)
> >         <irq iterrupt>
> >         -> s3c2410wdt_irq()
> >         -> s3c2410wdt_keepalive()
> >         -> spin_lock(&wdt->lock) (deadlock here)
> >
> > This flaw was found by an experimental static analysis tool I am
> > developing for irq-related deadlock, which reported the above
> > warning when analyzing the linux kernel 6.4-rc7 release.
> >
> > The tentative patch fix the potential deadlock by spin_lock_irqsave()
> > under process context.
> >
> > Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
> > ---
> >  drivers/watchdog/s3c2410_wdt.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_=
wdt.c
> > index 95416a9bdd4b..2dfc0d6a3004 100644
> > --- a/drivers/watchdog/s3c2410_wdt.c
> > +++ b/drivers/watchdog/s3c2410_wdt.c
> > @@ -399,10 +399,11 @@ static void __s3c2410wdt_stop(struct s3c2410_wdt =
*wdt)
>
> Why you didn't update also s3c2410wdt_keepalive()?
>
> Best regards,
> Krzysztof
>
