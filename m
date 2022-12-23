Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334466555F9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 00:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiLWXUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 18:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiLWXU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 18:20:29 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A179611808;
        Fri, 23 Dec 2022 15:20:28 -0800 (PST)
Received: from [IPv6:2804:14d:72b4:8284:32a8:8167:f815:2895] (unknown [IPv6:2804:14d:72b4:8284:32a8:8167:f815:2895])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dwlsalmeida)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B54FE6602C2E;
        Fri, 23 Dec 2022 23:20:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671837627;
        bh=G4pm6jA9V9AVhYNVaCCN3JOos9BOTi5byDHnIfA0tRY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Y8fKRZKrqPXVaDIxWwpek2JxmsNNFXfNpITkSukMyQpz8dhEqLOXxULmWCgeH00Ac
         21FMlWUBcTtqUaDKAo3YX/enmzp/dsmGGHetes11THJu0rUyYCf1ZwLHCAxxGv9UB9
         zdHdOlJfQiKYij0opVzbOwshsW8wKz1qCOTbHCVv5nTj3hcU2NSLfeWnb8CzoPVENs
         WlP6CG7ddGR/+9jyNutgq7OeMCSobDpvMj5IyVMSGYp4Vj3RkVFIVKUuliBv7Tfqzq
         BsegJgYLgXiYOk9hFpX7F0wcsKxlE0fuhHI1GoTHUdBcnaV21pwlawi4zukZFmN3/1
         ylJgNRyUnOHfQ==
Message-ID: <e67149df1e72ccdaf7e9f51a0b2f81ac6602bfa2.camel@collabora.com>
Subject: Re: [PATCH v1 7/9] media: verisilicon: Add Rockchip AV1 decoder
From:   Daniel Almeida <daniel.almeida@collabora.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Date:   Fri, 23 Dec 2022 20:20:10 -0300
In-Reply-To: <cb95838c835aa91cd69e7067c8a3b747f89d2e95.camel@collabora.com>
References: <20221219155616.848690-1-benjamin.gaignard@collabora.com>
         <20221219155616.848690-8-benjamin.gaignard@collabora.com>
         <092f76873a914c52c5157a21401be6cf78e3f188.camel@ndufresne.ca>
         <be1ff517-765d-c97f-8cce-3f359cd0015c@collabora.com>
         <4afdce546b2f10cf97e12f8325232483efeea1ce.camel@ndufresne.ca>
         <d7025e7e-246f-a7f4-f0b5-d1290a38a96c@collabora.com>
         <cb95838c835aa91cd69e7067c8a3b747f89d2e95.camel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ah, I was too quick on that answer :/

I see that they have REFS_PER_FRAME (7), TOTAL_REFS_PER_FRAME (8) _and_
NUM_REF_FRAMES (8), in which case it is redundant indeed. I will remove
that on v4.

-- Daniel

On Fri, 2022-12-23 at 20:15 -0300, Daniel Almeida wrote:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int cur_offset[V4L2_AV1_NU=
M_REF_FRAMES - 1];
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int cur_roffset[V4L2_AV1_N=
UM_REF_FRAMES - 1];
> >=20
> > This looks like V4L2_AV1_REFS_PER_FRAME. Daniel, should be remove
> > this
> > V4L2_AV1_NUM_REF_FRAMES ? Its redundant with
> > V4L2_AV1_TOTAL_REFS_PER_FRAME ...
>=20
> Hi. These are different. NUM_REF_FRAMES is the size of the "DPB"
> while
> TOTAL_REFS_PER_FRAME is the maximum number of references a frame can
> use. It just so happens that in AV1 these two are close in absolute
> value (i.e. 7 vs 8).
>=20
> Using VP9 as a comparison, the DPB size is still 8, but
> REFS_PER_FRAME
> is 3 (meaning a frame can specificy LAST, GOLDEN and ALTREF values).
>=20
> As this is per spec and a mere convenience, I vote for keeping it.=20
>=20
> -- Daniel

