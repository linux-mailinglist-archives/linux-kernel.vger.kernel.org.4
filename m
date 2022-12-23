Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B903E6555EE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 00:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiLWXQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 18:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiLWXP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 18:15:58 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700B111808;
        Fri, 23 Dec 2022 15:15:56 -0800 (PST)
Received: from [IPv6:2804:14d:72b4:8284:32a8:8167:f815:2895] (unknown [IPv6:2804:14d:72b4:8284:32a8:8167:f815:2895])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dwlsalmeida)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9D9A86602BF9;
        Fri, 23 Dec 2022 23:15:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671837354;
        bh=CAp1gtyw+Vjt15RCYF5T8+05xn1NEUQ8J9Mvv1bxvTQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=F/DKa+h9/h+/rHhv0HRwLqhtF4tYj8CbJh0nwYfVkatN3bJKVJgTTigMsaxtG4oLc
         OUOhvBOgigNj4vvwx9GxfOz+aFaJCVL845ZMeDkLBjfTu7FCQn1FTfYvaAijaNUyqA
         GL95kWiwUHU9+uEcDcBogAsXUM1FJ0/WgjOJb+40qUD/IGhw606vick8EW8xPc4Dbw
         gHyI97gKK/CxMBdXaCn0y2tiGQrAQEK6bqz+O2c1mt7Vz8R2UKKm3su8mnG5cikrOx
         h17IY4rxSHqYb01cjz8Kk0txGV77LcI8vyCl6Ig/Pk/BKxkHLi8H5qd0kP0AfyHotr
         H4XKBflOoDKuQ==
Message-ID: <cb95838c835aa91cd69e7067c8a3b747f89d2e95.camel@collabora.com>
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
Date:   Fri, 23 Dec 2022 20:15:38 -0300
In-Reply-To: <d7025e7e-246f-a7f4-f0b5-d1290a38a96c@collabora.com>
References: <20221219155616.848690-1-benjamin.gaignard@collabora.com>
         <20221219155616.848690-8-benjamin.gaignard@collabora.com>
         <092f76873a914c52c5157a21401be6cf78e3f188.camel@ndufresne.ca>
         <be1ff517-765d-c97f-8cce-3f359cd0015c@collabora.com>
         <4afdce546b2f10cf97e12f8325232483efeea1ce.camel@ndufresne.ca>
         <d7025e7e-246f-a7f4-f0b5-d1290a38a96c@collabora.com>
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

> > +	int cur_offset[V4L2_AV1_NUM_REF_FRAMES - 1];
> > +	int cur_roffset[V4L2_AV1_NUM_REF_FRAMES - 1];
>=20
> This looks like V4L2_AV1_REFS_PER_FRAME. Daniel, should be remove
> this
> V4L2_AV1_NUM_REF_FRAMES ? Its redundant with
> V4L2_AV1_TOTAL_REFS_PER_FRAME ...

Hi. These are different. NUM_REF_FRAMES is the size of the "DPB" while
TOTAL_REFS_PER_FRAME is the maximum number of references a frame can
use. It just so happens that in AV1 these two are close in absolute
value (i.e. 7 vs 8).

Using VP9 as a comparison, the DPB size is still 8, but REFS_PER_FRAME
is 3 (meaning a frame can specificy LAST, GOLDEN and ALTREF values).

As this is per spec and a mere convenience, I vote for keeping it.=20

-- Daniel
