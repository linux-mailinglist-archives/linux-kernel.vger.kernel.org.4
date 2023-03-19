Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DE06C06A0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 00:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjCSXd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 19:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCSXdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 19:33:55 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC70E19687;
        Sun, 19 Mar 2023 16:33:53 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 289A11449;
        Mon, 20 Mar 2023 00:33:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1679268832;
        bh=l2p4ZDBneAwEGOLjso6EkHUNvJxzex1xBmjmxf7QRGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aLcAv49AFw0OYSHbmnljKSRWyI2EloW7N3ryboN/dLV3MR3iF00oAyaxNlPwAjbTA
         TRmqA5Cwa86orRcNH7geU2YfHVDB4sIM45GO+ZPVBETuvTSCzeVyunEXiZOfr0a/Jr
         GPXVEd+Pz7pKmMVUVySEGmPANB3jS0kMSWW6MFxo=
Date:   Mon, 20 Mar 2023 01:33:58 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
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
Subject: Re: [RFC 2/4] media: videobuf2: Replace bufs array by a list
Message-ID: <20230319233358.GD20234@pendragon.ideasonboard.com>
References: <20230313135916.862852-1-benjamin.gaignard@collabora.com>
 <20230313135916.862852-3-benjamin.gaignard@collabora.com>
 <20230313181155.GC22646@pendragon.ideasonboard.com>
 <86df05244d974416903e919d387a0a0b@AcuMS.aculab.com>
 <e704b505-86d8-c6f2-8546-adccdab72622@xs4all.nl>
 <dc04d48e34ed40e58f43badd001a81d0@AcuMS.aculab.com>
 <cbf34cf1-e065-8136-8344-89ca1864f637@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cbf34cf1-e065-8136-8344-89ca1864f637@xs4all.nl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Tue, Mar 14, 2023 at 11:42:46AM +0100, Hans Verkuil wrote:
> On 3/14/23 11:11, David Laight wrote:
> > From: Hans Verkuil
> >> Sent: 14 March 2023 08:55
> > ...
> >> Why not start with a dynamically allocated array of 32 vb2_buffer pointers?
> >> And keep doubling the size (reallocing) whenever more buffers are needed,
> >> up to some maximum (1024 would be a good initial value for that, I think).
> >> This max could be even a module option.

The kernel has IDR and IDA APIs, why not use them instead of reinventing
the wheel ?

> > I don't know the typical uses (or the code at all).
> > But it might be worth having a small array in the structure itself.
> > Useful if there are typically always (say) less than 8 buffers.
> > For larger sizes use the (IIRC) kmalloc_size() to find the actual
> > size of the structure that will be allocate and set the array
> > size appropriately.
> 
> The typical usage is that applications allocate N buffers with the
> VIDIOC_REQBUFS ioctl, and in most cases that's all they use.

Note that once we get DELETE_BUF (or DELETE_BUFS) support I'd like to
encourage applications to use the new API, and deprecate REQBUFS
(dropping it isn't on my radar, as it would take forever before no
userspace uses it anymore).

> The
> current max is 32 buffers, so allocating that initially (usually
> during probe()) will cover all current cases with a single one-time
> kzalloc.

Pre-allocating for the most common usage patterns is fine with me.

> Only if the application wants to allocate more than 32 buffers will
> there be a slight overhead.

-- 
Regards,

Laurent Pinchart
