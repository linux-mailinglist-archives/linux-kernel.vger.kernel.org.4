Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0619F6C4E8E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjCVOwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjCVOwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:52:33 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0D46A41F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:50:56 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id x1so22873084qtr.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112; t=1679496655;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xqEwR0mnH2dQTWES7qcpZxyDU3kIdJJrQjcIfcIfUws=;
        b=4mDo4UpOGVHUWLxUshM4Dz9N05BjdMLZQ56BMssgs0qciRkedoa4RVR4EJUVB3FRjs
         Ve7/uD241dSYiTmpXtZO/ZPzqSqxEq1/dEWNWiCFmglU4N115xERZS8mj66G1g44ObEU
         DUXgol5g66ixnMBg57YAmEiwVV5RMg8nWH9LyC9QJfrkVJZnspc3wbP4ekuFLLG990eZ
         p0dt1wZDF0FDDJHO6VuJnmTyVBSfbRBkRPEWGQawc0zvjyxupCmql6MVg/fw3DeJxUwp
         6EoMlWZn20w7yUhUSWMybVMwQUzOlI3RCagsvYnUA360+1fl0qLv0KXrHwazDroI58FA
         Cilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679496655;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xqEwR0mnH2dQTWES7qcpZxyDU3kIdJJrQjcIfcIfUws=;
        b=YsQ0zXc0y+bdtNOZtzytngvXydPl7wdAA1AdEIBYcHvux/xE6RaaGl034EDHs28J3i
         gBu+IaR+qietFkd+zUJdeCguqbITaBLUp4c4q4bbpk4uN1DYDRAIREiRhuDUED2N86cB
         Y0TCqB9hNOhu/obp9srfIW5ha9Hn9Jxh74lhr8hYbOMBMH7/3EvW3lJsaHTtuk96touo
         gCrbvfOmDtn1nVD1YQWiynu1hK99NCUSDDbRQDpZle+4N2IkkTJSxT085mW1z2T+hgp5
         AHVHTgsqst289R/XJxESKnrSjLun39F2jCW+8WrX5nqT7IEUSZYZt/ZrLGt5cc5/xKds
         h8sg==
X-Gm-Message-State: AO0yUKXAuzW/sq4lfhFqz6EDIecU4H+cpYq86g65iELaVqutskP6VggD
        SVVY4IaM0yTRhImXsxX4ctgjcQ==
X-Google-Smtp-Source: AK7set+olGnH2L8HiH8wu79IhsPwiTafG3zfFFddwhNxvuWfFc+q5aG+tjjynN8ff7zGF9L/LuK8og==
X-Received: by 2002:a05:622a:4d2:b0:3bf:e471:69a3 with SMTP id q18-20020a05622a04d200b003bfe47169a3mr6127461qtx.65.1679496655113;
        Wed, 22 Mar 2023 07:50:55 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id 69-20020a370c48000000b00746777fd176sm5025558qkm.26.2023.03.22.07.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 07:50:54 -0700 (PDT)
Message-ID: <f085aa9225c573df906bdc7ff032a8fd591b18b3.camel@ndufresne.ca>
Subject: Re: [RFC 2/4] media: videobuf2: Replace bufs array by a list
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     David Laight <David.Laight@ACULAB.COM>,
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
Date:   Wed, 22 Mar 2023 10:50:52 -0400
In-Reply-To: <20230319233358.GD20234@pendragon.ideasonboard.com>
References: <20230313135916.862852-1-benjamin.gaignard@collabora.com>
         <20230313135916.862852-3-benjamin.gaignard@collabora.com>
         <20230313181155.GC22646@pendragon.ideasonboard.com>
         <86df05244d974416903e919d387a0a0b@AcuMS.aculab.com>
         <e704b505-86d8-c6f2-8546-adccdab72622@xs4all.nl>
         <dc04d48e34ed40e58f43badd001a81d0@AcuMS.aculab.com>
         <cbf34cf1-e065-8136-8344-89ca1864f637@xs4all.nl>
         <20230319233358.GD20234@pendragon.ideasonboard.com>
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

Hi Laurent,

Le lundi 20 mars 2023 =C3=A0 01:33 +0200, Laurent Pinchart a =C3=A9crit=C2=
=A0:
> > The typical usage is that applications allocate N buffers with the
> > VIDIOC_REQBUFS ioctl, and in most cases that's all they use.
>=20
> Note that once we get DELETE_BUF (or DELETE_BUFS) support I'd like to
> encourage applications to use the new API, and deprecate REQBUFS
> (dropping it isn't on my radar, as it would take forever before no
> userspace uses it anymore).

I was wondering if you can extend on this. I'm worried the count semantic m=
ight
prevent emulating it over create_bufs() ops, but if that works, did you mea=
nt to
emulate it so driver no longer have to implement reqbufs() if they have
create_bufs() ?

Nicolas
