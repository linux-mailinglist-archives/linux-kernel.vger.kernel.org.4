Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AE6707AAE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 09:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjERHPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 03:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjERHP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 03:15:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E1A185
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684394079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LMF9iQxS4+e096ixTrmjYfyxlJK1AWBZxgFG+XUX9Uo=;
        b=JcjoGrL07b7zNF1P+Xtu/qqyD4dZ83ysd2mc/+s8WIgArpPhaT+oHsO1nq9sEKWHrwT2/h
        JfJm4n6pazzEk/3Rvc5otnlSs4HwXhTivWaQ4z4VTmUzL1aTfXIH46u3wSOB83h955HGYR
        8pQoy479YZ1BnGTWCXmOREZqQNI9ogE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-ubXlnjKUNFWdHuigH41dhg-1; Thu, 18 May 2023 03:14:38 -0400
X-MC-Unique: ubXlnjKUNFWdHuigH41dhg-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3f398a25be2so1039741cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684394078; x=1686986078;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LMF9iQxS4+e096ixTrmjYfyxlJK1AWBZxgFG+XUX9Uo=;
        b=hy43t95xVC3QA8ZnJLvUaU/FkzLykfwB5Cr4eknpJPJJKh6givBFT0XmVHB1GdR6v7
         ELmkwl+gFYVqRcrXL5Q3FCx1Cu0I1lzcsbgTQ1Hl1E/DMS6SQhOiFnc760LIyptSign+
         +pjYKWwGKgbH+PQe6esIKGQKVUU+5rVsEqQS2lE5pFXeRcTj254rxZ3AhkoTRivvOq6b
         3aJo3CazyncpZF3QB2xtbnmHkz+mzFX3DtVuW63JA9pNJc+7ffPiXxrIGss5st029yVA
         teOgxda9f+zAZZa4C7qtvTkflLTHqZj0dnxxtTZs9Pltck0e7TdOY0gcnOs/2cyz682N
         pU5Q==
X-Gm-Message-State: AC+VfDy/og99MvAKxuJf/T+pRoE+1sOAAOle6mIAjy/ZNypgW+bk/zkE
        ycI0S9VLA2fLfIlwnMg22T871s6LvE3NuLsDOE2fJe+kgZ60vKRpecISQjJBgDmOGg1kNEtNcvM
        VV3Q3wJhcUbwh43RweFxqm6JyXiSCo6vR
X-Received: by 2002:ac8:7f16:0:b0:3f4:fdaa:8e14 with SMTP id f22-20020ac87f16000000b003f4fdaa8e14mr10695386qtk.2.1684394077913;
        Thu, 18 May 2023 00:14:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5wd4ylClQrAVa6bfDgK3AEgnKytECM9HuphhORsAdS5nxU1tdek68Vbw/wS8823V49shwfjg==
X-Received: by 2002:ac8:7f16:0:b0:3f4:fdaa:8e14 with SMTP id f22-20020ac87f16000000b003f4fdaa8e14mr10695372qtk.2.1684394077628;
        Thu, 18 May 2023 00:14:37 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-239-175.dyn.eolo.it. [146.241.239.175])
        by smtp.gmail.com with ESMTPSA id u8-20020ac87508000000b003e4dab0776esm301661qtq.40.2023.05.18.00.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 00:14:37 -0700 (PDT)
Message-ID: <40235375c0001845dc11b559a4352337e1d90e65.camel@redhat.com>
Subject: Re: linux-next: build failure after merge of the net tree
From:   Paolo Abeni <pabeni@redhat.com>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Date:   Thu, 18 May 2023 09:14:34 +0200
In-Reply-To: <CABGWkvr-LBVA0XehWHnRaVMT5n-m_V91GzqG4R30fj4QYbuV5g@mail.gmail.com>
References: <20230518090634.6ec6b1e1@canb.auug.org.au>
         <20230517214200.33398f82@kernel.org>
         <11ab22ff9ecf7e7a330ac45e9ac08bf04aa7f6df.camel@redhat.com>
         <CABGWkvr-LBVA0XehWHnRaVMT5n-m_V91GzqG4R30fj4QYbuV5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-05-18 at 08:52 +0200, Dario Binacchi wrote:
> Hi all,
>=20
> On Thu, May 18, 2023 at 8:47=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >=20
> > On Wed, 2023-05-17 at 21:42 -0700, Jakub Kicinski wrote:
> > > On Thu, 18 May 2023 09:06:34 +1000 Stephen Rothwell wrote:
> > > > Hi all,
> > > >=20
> > > > After merging the net tree, today's linux-next build (arm
> > > > multi_v7_defconfig) failed like this:
> > > >=20
> > > > Error: arch/arm/boot/dts/stm32f746.dtsi:265.20-21 syntax error
> > > > FATAL ERROR: Unable to parse input tree
> > > > make[2]: *** [scripts/Makefile.lib:419: arch/arm/boot/dts/stm32f746=
-disco.dtb] Error 1
> > > > Error: arch/arm/boot/dts/stm32f746.dtsi:265.20-21 syntax error
> > > > FATAL ERROR: Unable to parse input tree
> > > > make[2]: *** [scripts/Makefile.lib:419: arch/arm/boot/dts/stm32f769=
-disco.dtb] Error 1
> > > > Error: arch/arm/boot/dts/stm32f746.dtsi:265.20-21 syntax error
> > > > FATAL ERROR: Unable to parse input tree
> > > >=20
> > > > Caused by commit
> > > >=20
> > > >   0920ccdf41e3 ("ARM: dts: stm32: add CAN support on stm32f746")
> > > >=20
> > > > I have used the net tree from next-20230517 for today.
> > >=20
> > > Dario, Marc, can we get an immediate fix for this?
> >=20
> > Dario, Marc: we are supposed to send the net PR to Linus today. Lacking
> > a fix, I'll be forced to revert the mentioned commit in a little time.
> >=20
>=20
> Marc reverted the commit:
> https://lore.kernel.org/all/20230517181950.1106697-1-mkl@pengutronix.de/

Thanks for the pointer!

@Marc: could you please formally send the revert to netdev, too?

Thanks!

Paolo

