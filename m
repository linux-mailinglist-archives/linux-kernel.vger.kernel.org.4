Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B776D4C30
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjDCPlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjDCPld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:41:33 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0D626AF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 08:41:32 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id b6so10755647ljr.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 08:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1680536491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4aFBg56Z9ArQV6qPrCGhXlj3uEiLVU9FC7/3hRMjXpY=;
        b=FF4A9WuTI1jLbd4ouhu3zt7lPkGNvHdBsMUeQ9DgBWk1nm/4iKs2RL42XXJOt1cNH7
         mdK9G1xZ/v4V3RgRPFLIHNqwTZrwsWLibdkwNv+aBCol+d7/wkKgACvXykMi4hC4qpNz
         9QalyIa4Pn6Whrjf9fnsh+ml0zQ48th/Eb4qr39tIlg4oij7XlXaQKXr1Qq0LMDpJ+TT
         4sx5Mu4J/pfGGz03LAPJDiVV+LZ0G7BpQW/JQ1GEfcc/n6cDB1RbAWjL223nSrbAaSSG
         FnwSe28L21YEUP1N081OT03Am4vye5h/br/clMYr3bKepUm6hYtAChxCXYedzI37NQOl
         JBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680536491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4aFBg56Z9ArQV6qPrCGhXlj3uEiLVU9FC7/3hRMjXpY=;
        b=QMhIuucjTgnapG/jIbsm8ejSabwLN0W3WzbAfTgyEQcchVucTW9Iya+We5ayPrp8X6
         o6WlQn2sFEYPO172ZLKEwN1D84AoAuRITgPwFw0hHHmpSVc6iPj1+fgjCjSFp5ica3a0
         q/Fryq+X/xOBpdzHURUT0dTKl5PVlZzH8lQ1LwAKrfKxL805zUIBYDmwgY67z/lLIHRI
         g2x3hi6iZWt6f66dBnF0gY02Iu+xsoATLJBRK+Con/jWSzjh9Pd0vNrPxVsy1jFPbFwY
         q0scY2f/L6AiXUna68xOYNpKEvREOrJdG9POEEppiscNRO5nzodK2phRY6ICy/x8AnlJ
         Js7g==
X-Gm-Message-State: AAQBX9fOzZXKYGI56XciXs2XuVvg2H4kUwY3jwNUdFHiLWRdIn9EA8Ms
        rBZIB5ZSoXipZggbxNC6E4ShkJ3H6tX7QVKCFGmcOQ==
X-Google-Smtp-Source: AKy350Y4MM+Bjn9T3q5vxSkO+1ovlTqgu8m931rbddtxfliX31XNcw+9AJLu9vTiLAiwFoa6CxOVxhKYKPP71KcTr24=
X-Received: by 2002:a2e:7017:0:b0:295:bb34:9c2 with SMTP id
 l23-20020a2e7017000000b00295bb3409c2mr11023656ljc.10.1680536490849; Mon, 03
 Apr 2023 08:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230403072443.83810-1-d-gole@ti.com>
In-Reply-To: <20230403072443.83810-1-d-gole@ti.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 3 Apr 2023 17:41:18 +0200
Message-ID: <CAMRc=McXUt0L6dea0N1hea5PJo9n+kwgRmjEcq=Zf2bvcHCrZA@mail.gmail.com>
Subject: Re: [PATCH 0/2] gpio: davinci: interrupt related fixes
To:     Dhruva Gole <d-gole@ti.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Devarsh Thakkar <devarsht@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Vibhore Vardhan <vibhore@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 3, 2023 at 9:25=E2=80=AFAM Dhruva Gole <d-gole@ti.com> wrote:
>
> This series fixes some critical bugs in the gpio-davinci driver
> that come to light when the system tries to wakeup from a suspended
> state.
>
> It was earlier posted as an RFC here:
> https://lore.kernel.org/all/20230323122910.991148-1-d-gole@ti.com/
>
> No changes, just resending without the RFC tag since the patches are now
> proposed to be merged into mainline.
> Also add all the Acks and R-by's from respective maintainers and reviewer=
s.
>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Devarsh Thakkar <devarsht@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Vibhore Vardhan <vibhore@ti.com>
>
> Dhruva Gole (2):
>   gpio: davinci: Do not clear the bank intr enable bit in save_context
>   gpio: davinci: Add irq chip flag to skip set wake
>
>  drivers/gpio/gpio-davinci.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> --
> 2.25.1
>

Queued for fixes. Thanks!

Bart
