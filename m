Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D583869CA9C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 13:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjBTMRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 07:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjBTMQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:16:56 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29741B578;
        Mon, 20 Feb 2023 04:16:51 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id q5so1154632plh.9;
        Mon, 20 Feb 2023 04:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcEmxazxbqplmTcmN17Wwm+l41xqAQ1PKqf3h1uJiP4=;
        b=I4VVRfVXk1FNApIzDwUzdb0Y9aU/DgzdfRm7sekaAXTMVKlb+Qno9/aXncvwq+hEOa
         Vi2GEBCcSXIUm0geHa96o0yEqWM337hbp8bI/98czZVFchHezkzgcz/VqagN6Zy56oYt
         H36jUMrQpk5LlZewJPmZP1lYevM7GDnDtuLho6NDox5ZiK3uEgGstGLN4O09Kl+Gj02S
         Sed4VbMM+hxV8m/Y1FCAfI6RikvOoLgwPHZEvjrm37yrO7PZFif1IemetOSduoRluP5K
         QVlR+jQLWxAqrA+TE5ZqlFDpUZFKbje/idgBJteLM1qZWToSMN/KS79Nu3/fJgMxzuPM
         h6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcEmxazxbqplmTcmN17Wwm+l41xqAQ1PKqf3h1uJiP4=;
        b=R5N2kS9ie1y7yc6Rf4hFBRqP1R9cYL1PqBzXIeWiBVqRFbdCR/En4YC7JfS5KXRogX
         cz7P49av1V01o73OjxE0876w/l2sduSpFpDVL2SPqx6J8Z7gdsxxiFw4ybjreGxEgCLB
         Sf2cu9LdqBdT4LQ6To3dIb8zjY2/8Bwk71rtjfmXCmnEb3tfi/yPsVQTtQwp0tVNUZet
         KmmI3kiu5C8DB23v6qy8XLmtRfP4ahVndncMl4hjjSIRIqutEx12AGWNJNWrqFNdsbFr
         VYX02CbNLTQn2paoVACPujWnNQmeRvFuTz4VxDpHK/GWHN1aQdGtmGd/M3LPiP/2wrpA
         5D+g==
X-Gm-Message-State: AO0yUKWmgOVFyJCxY7jBYfzSZH/MdZDqQDIcco5f6h51yEseM3/p+Xwn
        QNWUT6ymwAitB867wohw6UY=
X-Google-Smtp-Source: AK7set/wLHmIl0qQEAoUiCiaL7tnmOU1vhxtFoFEIAJBnDwSEjooohnU6f0VacWTqeAvsT5fnTk2Zw==
X-Received: by 2002:a05:6a20:1587:b0:be:9478:55ba with SMTP id h7-20020a056a20158700b000be947855bamr1879748pzj.60.1676895411306;
        Mon, 20 Feb 2023 04:16:51 -0800 (PST)
Received: from redecorated-mbp ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id l64-20020a638843000000b004784cdc196dsm1157637pgd.24.2023.02.20.04.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 04:16:51 -0800 (PST)
Date:   Mon, 20 Feb 2023 23:16:42 +1100
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>
Subject: Re: [PATCH v3 4/5] apple-gmux: support MMIO gmux on T2 Macs
Message-ID: <20230220231642.1e0064db@redecorated-mbp>
In-Reply-To: <20230220092048.GA25532@wunner.de>
References: <20230218132007.3350-1-orlandoch.dev@gmail.com>
        <20230218132007.3350-5-orlandoch.dev@gmail.com>
        <20230220092048.GA25532@wunner.de>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Feb 2023 10:20:48 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> On Sun, Feb 19, 2023 at 12:20:06AM +1100, Orlando Chamberlain wrote:
> > --- a/drivers/platform/x86/apple-gmux.c
> > +++ b/drivers/platform/x86/apple-gmux.c
> > @@ -28,15 +28,17 @@
> >   * DOC: Overview
> >   *
> >   * gmux is a microcontroller built into the MacBook Pro to support
> > dual GPUs:
> > - * A `Lattice XP2`_ on pre-retinas, a `Renesas R4F2113`_ on
> > retinas.
> > + * A `Lattice XP2`_ on pre-retinas, a `Renesas R4F2113`_ on pre-T2
> > retinas.
> > + * The chip used on T2 Macs is not known.  
> 
> I've just taken a look at the schematics of the MBP16,1 and it turns
> out that T2 *is* the gmux.  The chip is called H9M.  The interaction
> with the OS is through that MMIO area.
> 
> There's a GPIO expander attached to T2 via I2C (NXP PCAL6524),
> probably because they didn't have enough GPIO pins available on T2
> itself. The GPIO expander enables/disables the voltage regulators of
> the discrete GPU, hence can cut power to it.  It also drives panel
> power and has a GPIO to switch the mux.
> 
> The mux is an NXP CBTL06142 as on previous models.

Thanks for figuring that all out, I can add that to the documentation.

> 
> Thanks,
> 
> Lukas

