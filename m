Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57D86C8150
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjCXPfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbjCXPe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:34:58 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9555720544
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:34:52 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id w25so1807392qtc.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112; t=1679672091;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7FyBbkUlSzWUDUg7FSl6pltsSXVFIHYA7e4KXdYYzK0=;
        b=MeRC33lk6v1nX1CaLMpuOD7McLymhdBaxID6EIllMJ/odTnOgZ3Ls7Ufy+LF90tZc3
         Rukbh2vhZd09yzD7IbWoKlFToE7vKOFmwn1MlDeyeK2QwZRl3EaVkSQlWGqiEQlqMsp7
         +9v2PHmuFRGG9NieLrA0J6+yO3Y+KmaQ1RDeU1+L6KYByp+SPGdB4x5pwH1MnsWM0ylM
         u8RqbExRZdZwI4k+Yxkf1E1Ncu/Jj4EjQsyS+95WiNCaJHSGdxvcEnqY5rb+M9AJs79D
         Hq3hRsBDyx/SQLzfVXCtTwZyf2mN6bBbx9A8WJIWFxsqFrARC4TK+bTN+cXf/4XHlGwY
         bS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679672091;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7FyBbkUlSzWUDUg7FSl6pltsSXVFIHYA7e4KXdYYzK0=;
        b=p8W15FSH80ItFGQDKw94Iyz1jUNnbozcCixbcEYd/C2gxeEwMg0EuDLM1Zauh/cSbD
         3rO3iMG8UmD0ibk8FSTTYx55+xr5jWzVWlXAWLtKZBA2X0jTL2UDKHVzSt7tQZUuB40a
         pvWKBqBhOVQ/NhuPe171C2qBA3qctLEafUT5LmWEBfkKnzGB8rsWe8h7gQgFjStVHtAr
         m+LgAb6wjJpgmnSmr5kJk4G7xRJsPxYeOKUQcIeNSVtd2Vq1DvN3hvvpdC3Ks+gXmOqY
         gnRkwsjG0X4vH36ghf4HdkHcMa9fNGN8QesEXYE1guLn4+4pRFfmuMXgMY3lJsZXbxyI
         fWYA==
X-Gm-Message-State: AO0yUKVxOiacnCEyrUXsCiA7T79JTzxkchqpYvRM8d3mAd6a2uGeEeSz
        pmGSg5ZEuLaXLP2EtW1riQyRFQ==
X-Google-Smtp-Source: AK7set/k7jemVRQn2HhZJ/81On3zU02ry4zvQi9KTc7/Sa7tSuj5SNuZNPCX6T0rkNYDxGsmo9XXJQ==
X-Received: by 2002:ac8:5f0b:0:b0:3e1:c341:f618 with SMTP id x11-20020ac85f0b000000b003e1c341f618mr5351655qta.65.1679672091486;
        Fri, 24 Mar 2023 08:34:51 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id h26-20020ac846da000000b003bfb5fd72a7sm12745420qto.86.2023.03.24.08.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 08:34:51 -0700 (PDT)
Message-ID: <6f2979d33526e5ccdc32cf096415d8309fc91d3d.camel@ndufresne.ca>
Subject: Re: [RFC 2/4] media: videobuf2: Replace bufs array by a list
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
Date:   Fri, 24 Mar 2023 11:34:48 -0400
In-Reply-To: <68ba7b3f-57f5-3969-5036-2c8d08273548@xs4all.nl>
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
         <2d6480e36ce061a63440d1e11d52b02e57ba746d.camel@ndufresne.ca>
         <68ba7b3f-57f5-3969-5036-2c8d08273548@xs4all.nl>
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

Le vendredi 24 mars 2023 =C3=A0 16:18 +0100, Hans Verkuil a =C3=A9crit=C2=
=A0:
> On 24/03/2023 16:14, Nicolas Dufresne wrote:
> > Le mercredi 22 mars 2023 =C3=A0 17:01 +0200, Laurent Pinchart a =C3=A9c=
rit=C2=A0:
> > > On Wed, Mar 22, 2023 at 10:50:52AM -0400, Nicolas Dufresne wrote:
> > > > Hi Laurent,
> > > >=20
> > > > Le lundi 20 mars 2023 =C3=A0 01:33 +0200, Laurent Pinchart a =C3=A9=
crit=C2=A0:
> > > > > > The typical usage is that applications allocate N buffers with =
the
> > > > > > VIDIOC_REQBUFS ioctl, and in most cases that's all they use.
> > > > >=20
> > > > > Note that once we get DELETE_BUF (or DELETE_BUFS) support I'd lik=
e to
> > > > > encourage applications to use the new API, and deprecate REQBUFS
> > > > > (dropping it isn't on my radar, as it would take forever before n=
o
> > > > > userspace uses it anymore).
> > > >=20
> > > > I was wondering if you can extend on this. I'm worried the count se=
mantic might
> > > > prevent emulating it over create_bufs() ops, but if that works, did=
 you meant to
> > > > emulate it so driver no longer have to implement reqbufs() if they =
have
> > > > create_bufs() ?
> > >=20
> > > For drivers it should be fairly simply, as the reqbufs and create_buf=
s
> > > ioctl handlers should just point to the corresponding videobuf2 helpe=
rs.
> > >=20
> > > What I meant is that I'd like to encourage userspace to use the
> > > VIDIOC_CREATE_BUFS ioctl instead of VIDIOC_REQBUFS.
> > >=20
> >=20
> > I'm not sure what rationale I can give implementer to "encourage" them =
to use a
> > more complex API that needs to copy over the FMT (which has just been s=
et),
> > specially in the initial pre-allocation case. For most, CREATE_BUFS aft=
er SMT
> > will look like a very redundant and counter intuitive thing. Maybe you =
have a
> > more optimistic view on the matter ? Or you have a better idea how we c=
ould give
> > a meaning to having a fmt there on the initial case where the allocatio=
n matches
> > the queue FMT ?
>=20
> I wouldn't mind if we can make a much nicer CREATE_BUFS variant with just=
 the
> size instead of a format. That was in hindsight a really bad idea, terrib=
le
> over-engineering.

Note that all DRM allocators also includes width/height and some format rel=
ated
info (or the full info). This is because the driver deals with the alignmen=
t
requirements. In some use cases (I have inter frame dynamic control in mind
here) the fmt could be a mean to feedback the alignment (like bytesperline)=
 back
to the application where the stream is no longer homogeneous on the FMT.

That being said, If we move toward a size base allocator API, we could also=
 just
point back to an existing HEAP (or export an new heap if none are valid). A=
nd
define the sizeimage(s) is now that information you need from the FMT to
allocate anything + which heap needs to be used for the current setup.

Nicolas

>=20
> Regards,
>=20
> 	Hans

