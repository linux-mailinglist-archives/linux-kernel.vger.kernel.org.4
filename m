Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6126AB1D9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 20:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjCETYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 14:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjCETYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 14:24:32 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B08901B
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 11:24:29 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cw28so30268931edb.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 11:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678044268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fi44WCd57at26UJSzcMRS82R0NS2E49ZTf2iYW8hb6E=;
        b=BT4l5QLHVE+3ikZ2h7j6l155DEcI33MOp5a5pSBv2d2ne6xCbUOc4ckDCrBGHeXvdk
         jE/AvDXNPfx3WdS2I7NpbM9AzLNE5cO0KrmC0DRrngRGGazYQROJ4fVs9Y10nXOTrPG0
         WyvRtWSFpUbuBSuevgWatcXwparAzm8LwBfhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678044268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fi44WCd57at26UJSzcMRS82R0NS2E49ZTf2iYW8hb6E=;
        b=yyqPwV/BJN9YDqO4TsSGiNjlJWMijO4JUpbBK278DRSCVQMQnD4ES74wugOnyXSv4D
         BhT4WqQE50whr1G98ULHkv1bkNCI1O32bFH9bCAuLvLzsLdLxOJ2OTD2yJZdl45J/9OZ
         wRaGjdb7etRi7Ln2PYYyTzDJphVsSqXjMmsikgFLqyfQ5Qq6KWiIWP3HdHG+k2MV8pb1
         eSC8GIfcFpDhFsFM4PtprD3oxsdxfRpU6iMSQct+rzV+Iz7TwcSG0qu/3U1d9VpqjgYt
         5Y8wgv9nkNe20PX1oV93HoIkYKxLYUr+/6FkFzxbpj2VaSWpz11wd2gapKyG/WVuWkmp
         t/WQ==
X-Gm-Message-State: AO0yUKWB5l25oADqHtsDuD2ULRm4zFlKzzbjOPNaf80PZkEjvIbz2PD9
        dN6YFjpRBVYsPFv8UK+YXFEyeVPmhoIkDJTEjaGTcg==
X-Google-Smtp-Source: AK7set/orOw7Asd5YCwGLD1Zb0YHsqZI+sYKMEIDYeDphJx+VATX3EEPRPqY+H1wU4WEJH19XsAhwA==
X-Received: by 2002:a17:906:e4d:b0:8b1:7b5d:fe9b with SMTP id q13-20020a1709060e4d00b008b17b5dfe9bmr9613597eji.28.1678044268059;
        Sun, 05 Mar 2023 11:24:28 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id p22-20020a1709060dd600b008b17aae2a01sm3533010eji.86.2023.03.05.11.24.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 11:24:27 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id u9so30334901edd.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 11:24:27 -0800 (PST)
X-Received: by 2002:a17:906:b10d:b0:878:561c:6665 with SMTP id
 u13-20020a170906b10d00b00878561c6665mr3962745ejy.0.1678044267197; Sun, 05 Mar
 2023 11:24:27 -0800 (PST)
MIME-Version: 1.0
References: <167800644191.309766.5757985605946414576.tglx@xen13>
In-Reply-To: <167800644191.309766.5757985605946414576.tglx@xen13>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Mar 2023 11:24:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=whr2KrDkMnQ5pKKxn8nCD718ExKAmPE3TLxkWnjtj6OvA@mail.gmail.com>
Message-ID: <CAHk-=whr2KrDkMnQ5pKKxn8nCD718ExKAmPE3TLxkWnjtj6OvA@mail.gmail.com>
Subject: Re: [GIT pull] irq/urgent for v6.3-rc1
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 5, 2023 at 12:55=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> ...
>  kernel/irq/msi.c            |   28 +++++++++++++++++++++++-----
>  kernel/irq/msi.c            |    9 ++++++---
>  8 files changed, 44 insertions(+), 15 deletions(-)

Funky diffstat you have there, with the same file done twice. I get
(and would have expected)

 ...
 kernel/irq/msi.c            | 37 +++++++++++++++++++++++++++++--------
 7 files changed, 44 insertions(+), 15 deletions(-)

instead.

           Linus
