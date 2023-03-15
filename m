Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EAA6BB566
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbjCON62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjCON6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:58:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352747C3EF;
        Wed, 15 Mar 2023 06:58:06 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6ACC0660304F;
        Wed, 15 Mar 2023 13:58:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678888684;
        bh=uJqR7EssC//Fq/VnhmhfKuiFmnGhoDw1Z52cTcjrpVU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ma4KyOxNTTffxcyxbnl1X2J+7Njd+LaQyivOPbIi6i+utwTW50beH5GMWO2sQSOcB
         maGk7KOVzQf+8PxfTlIcLEvrEu7qH6OJof9IPsgUINsvhrQCO2XCZcNRRHjLrIilpI
         sAOTs/7Hc6bmwrKlI5yw62hpBlPQ/V3KyuNnNUDdQ9bepJbGuEl0NYoddDzcBVhxvf
         ij2wB4847oUulw25PblhthMc4tXZH53bjlsDQzsgJq69DBbbLhxYyMHfpfSWd49ERi
         RFknrqq/TSXIca/wf91CIwIweWGRP5V98MBRZV8AG/2Glgp3z161dtCCnRrSSAQG8q
         Tj1xEQbRrt7WA==
Message-ID: <bdade438cd93230daa47ee48eafab60f65cd4224.camel@collabora.com>
Subject: Re: [RFC 2/4] media: videobuf2: Replace bufs array by a list
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        ming.qian@nxp.com, shijie.qin@nxp.com, eagle.zhou@nxp.com,
        bin.liu@mediatek.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, tiffany.lin@mediatek.com,
        andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        daniel.almeida@collabora.com, hverkuil-cisco@xs4all.nl,
        jerbel@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Date:   Wed, 15 Mar 2023 09:57:51 -0400
In-Reply-To: <20230313181155.GC22646@pendragon.ideasonboard.com>
References: <20230313135916.862852-1-benjamin.gaignard@collabora.com>
         <20230313135916.862852-3-benjamin.gaignard@collabora.com>
         <20230313181155.GC22646@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 13 mars 2023 =C3=A0 20:11 +0200, Laurent Pinchart a =C3=A9crit=C2=
=A0:
> > -	/* Ensure that q->num_buffers+num_buffers is below VB2_MAX_FRAME */
> > -	num_buffers =3D min_t(unsigned int, num_buffers,
> > -			=C2=A0=C2=A0=C2=A0 VB2_MAX_FRAME - q->num_buffers);
> > -
>=20
> We can indeed drop this check now, but shouldn't we introduce some kind
> of resource accounting and limitation ? Otherwise any unpriviledged
> userspace will be able to starve system memory. This could be
> implemented on top, as the problem largely exists today already, but I'd
> like to at least record this in a TODO comment.

The current limit already isn't work for resource accounting and limitation=
 for
m2m drivers. You can open a device, allocate 32 buffers, and close that dev=
ice
keeping the memory around. And redo this process as many times as you want.

A TODO is most appropriate, but I would prefer to see this done at a memory
layer level (rather then v4l2 specific), so that limits and accounting work=
s
with containers and other sandboxes.

>=20
> I also wonder if we should still limit the number of allocated buffers.
> The limit could be large, for instance 1024 buffers, and it would be an
> in-kernel limit that could be increased later if needed. I'm concerned
> that dropping the limit completely will allow userspace to request
> UINT_MAX buffers, which may cause integer overflows somewhere. Limiting
> the number of buffers would avoid extensive review of all the code that
> deals with counting buffers.

