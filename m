Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F4C6C80F9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjCXPPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjCXPP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:15:27 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BC11F48C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:14:59 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id c19so1719282qtn.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112; t=1679670894;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BlgJl6q6nmXLwoducihQkeA4VjkQWrKTU/XpmLER5K8=;
        b=QAEyb3y2Vs1mSwY136+bu6SS016Otbf3KKfs9Mlyynm1gBzKn8IBg7DKKBORGVgyRL
         Wz6AisMNEwAkdbvXM7zJ93PyYVnHMRLt+SqV2+KIzgZGBKfSEA/SvYbGi1DbKwG8+t3X
         EnXZZz4q60ZBfI96mKWDnSZ2+1OtBHBRk9yySy0hupZdJ1YJ07CTHjT6hQzPp0un5Zi4
         ZMc2Z4n2f2EN3LAB+6ExoNkdtMUvrlZM9biFAE3RvcusV/CPEzZ0QodUUN6PBVj+S7q1
         VeHHAUt7o/Jx+ffoh+LeHf8+aj5khtrxdEJIKejig4N0viMRuvBtbR/GYyPRluiAV9Ca
         /PWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679670894;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BlgJl6q6nmXLwoducihQkeA4VjkQWrKTU/XpmLER5K8=;
        b=5a2ZHkpNbyayvmhYgN639ViIkBtU6ODx7EWf2HxEyFZCu4jQWHRVghGiMZd8Ojkng/
         HhGYnMjtaAfyGNrTXUuD/IAW12SPgvn2F1Aic1IiIuf8a4jSm+HBVqslqT9eozW1h5YR
         xAZpasfxTgbwncC8GCeKSIPy+wX93VeDFx2txefmj4Jcy+zotNLIKuAJKrplBRrbtFFG
         VveUTma4locRqvFNNQJFr6mL0gp50vPFtdJg6wJ9XJdDtFHpqqVB9ecYO/bnIsNYadr2
         qoV6e9BGIzuDwM/Hew5+b0i1SUndmPkKoa2Saa71Rd6Vx/gFufPdY7DVnB3AImWlE5rH
         BRJA==
X-Gm-Message-State: AAQBX9emheE9wVgUT7dbo1wKnvWLUYpepE112ZrHFGeDoy+VJdNWf8/l
        /ZUPvI5ietIToUTKRUke0+olXA==
X-Google-Smtp-Source: AKy350bCWxvUk1MaT4pqUixyno5lVt9EBSSrGyxJa0A4C2Bz3kyCAOSzYiktlm5Ro2rq0tSjC73bYQ==
X-Received: by 2002:a05:622a:1181:b0:3e3:90f7:b33c with SMTP id m1-20020a05622a118100b003e390f7b33cmr5002528qtk.7.1679670894617;
        Fri, 24 Mar 2023 08:14:54 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id n14-20020ac8674e000000b003d65e257f10sm4230146qtp.79.2023.03.24.08.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 08:14:54 -0700 (PDT)
Message-ID: <2d6480e36ce061a63440d1e11d52b02e57ba746d.camel@ndufresne.ca>
Subject: Re: [RFC 2/4] media: videobuf2: Replace bufs array by a list
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        David Laight <David.Laight@ACULAB.COM>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        "tfiga@chromium.org" <tfiga@chromium.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "ming.qian@nxp.com" <ming.qian@nxp.com>,
        "shijie.qin@nxp.com" <shijie.qin@nxp.com>,
        "eagle.zhou@nxp.com" <eagle.zhou@nxp.com>,
        "bin.liu@mediatek.com" <bin.liu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "tiffany.lin@mediatek.com" <tiffany.lin@mediatek.com>,
        "andrew-ct.chen@mediatek.com" <andrew-ct.chen@mediatek.com>,
        "yunfei.dong@mediatek.com" <yunfei.dong@mediatek.com>,
        "stanimir.k.varbanov@gmail.com" <stanimir.k.varbanov@gmail.com>,
        "quic_vgarodia@quicinc.com" <quic_vgarodia@quicinc.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
        "ezequiel@vanguardiasur.com.ar" <ezequiel@vanguardiasur.com.ar>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "daniel.almeida@collabora.com" <daniel.almeida@collabora.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "kernel@collabora.com" <kernel@collabora.com>
Date:   Fri, 24 Mar 2023 11:14:52 -0400
In-Reply-To: <20230322150153.GO20234@pendragon.ideasonboard.com>
References: <20230313135916.862852-1-benjamin.gaignard@collabora.com>
         <20230313135916.862852-3-benjamin.gaignard@collabora.com>
         <20230313181155.GC22646@pendragon.ideasonboard.com>
         <86df05244d974416903e919d387a0a0b@AcuMS.aculab.com>
         <e704b505-86d8-c6f2-8546-adccdab72622@xs4all.nl>
         <dc04d48e34ed40e58f43badd001a81d0@AcuMS.aculab.com>
         <cbf34cf1-e065-8136-8344-89ca1864f637@xs4all.nl>
         <20230319233358.GD20234@pendragon.ideasonboard.com>
         <f085aa9225c573df906bdc7ff032a8fd591b18b3.camel@ndufresne.ca>
         <20230322150153.GO20234@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 22 mars 2023 =C3=A0 17:01 +0200, Laurent Pinchart a =C3=A9crit=
=C2=A0:
> On Wed, Mar 22, 2023 at 10:50:52AM -0400, Nicolas Dufresne wrote:
> > Hi Laurent,
> >=20
> > Le lundi 20 mars 2023 =C3=A0 01:33 +0200, Laurent Pinchart a =C3=A9crit=
=C2=A0:
> > > > The typical usage is that applications allocate N buffers with the
> > > > VIDIOC_REQBUFS ioctl, and in most cases that's all they use.
> > >=20
> > > Note that once we get DELETE_BUF (or DELETE_BUFS) support I'd like to
> > > encourage applications to use the new API, and deprecate REQBUFS
> > > (dropping it isn't on my radar, as it would take forever before no
> > > userspace uses it anymore).
> >=20
> > I was wondering if you can extend on this. I'm worried the count semant=
ic might
> > prevent emulating it over create_bufs() ops, but if that works, did you=
 meant to
> > emulate it so driver no longer have to implement reqbufs() if they have
> > create_bufs() ?
>=20
> For drivers it should be fairly simply, as the reqbufs and create_bufs
> ioctl handlers should just point to the corresponding videobuf2 helpers.
>=20
> What I meant is that I'd like to encourage userspace to use the
> VIDIOC_CREATE_BUFS ioctl instead of VIDIOC_REQBUFS.
>=20

I'm not sure what rationale I can give implementer to "encourage" them to u=
se a
more complex API that needs to copy over the FMT (which has just been set),
specially in the initial pre-allocation case. For most, CREATE_BUFS after S=
MT
will look like a very redundant and counter intuitive thing. Maybe you have=
 a
more optimistic view on the matter ? Or you have a better idea how we could=
 give
a meaning to having a fmt there on the initial case where the allocation ma=
tches
the queue FMT ?

Nicolas

