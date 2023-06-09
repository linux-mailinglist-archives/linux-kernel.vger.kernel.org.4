Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C8672A36B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 21:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjFITue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 15:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbjFITua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:50:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A6835B6;
        Fri,  9 Jun 2023 12:50:24 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EECC16606F38;
        Fri,  9 Jun 2023 20:50:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686340223;
        bh=sT2pRLDd7z+EnfSme49Ke9q6MWh5t4ZyOMO6CUyMwM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=atA08n8m54vjX8SBuJeS3IX0TrUn1O020hMGKaJHiQzkVm57wBUvh8VuKZA2+M1zX
         AUIdD6zroJTMWm/k7oLKCjc1qFMvuD2aV95jDEKi8vEkqDrm1fU44qOGQb2ZeGarfK
         I0HIGj4ZWTJzmDsQSnAeWNC0d2F8pJgR/SVvQqT0cR8gyNl2uz6mblbs5A7PlmnVn5
         ltmRGEzJrK45v6t5JBUq+cl8F44x6Y37o1Cearg+Eq+v74N3uzFqEn8XrEP7G1halb
         nPTP1IRxOBsy2mwrtUhDX9VWNG3maLm08mATRZsS2uNduFpsZ9+L+6wH061UHHYvkv
         sZeu4/YIdPXCw==
Date:   Fri, 9 Jun 2023 15:50:15 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nathan Hebert <nhebert@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v4,3/4] media: mediatek: vcodec: move core context from
 device to each instance
Message-ID: <5d15905d-2a7b-4eb6-9f52-38303eaf5292@notapiano>
References: <20230525014009.23345-1-yunfei.dong@mediatek.com>
 <20230525014009.23345-4-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230525014009.23345-4-yunfei.dong@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 09:40:08AM +0800, Yunfei Dong wrote:
[..]
> --- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
[..]
> @@ -247,6 +229,8 @@ void vdec_msg_queue_deinit(struct vdec_msg_queue *msg_queue,
>  
>  		kfree(lat_buf->private_data);
>  	}
> +
> +	cancel_work_sync(&msg_queue->core_work);

Hi Yunfei,

this hunk is causing warnings during boot and when exercising the decoder with
fluster on mt8192-asurada-spherion. This deinit function is called on the
v4l2 release callback, even though the work might not have been initialized as
that only happens if/when the codec specific 'decode' callback is called (as a
result of device_run m2m callback).

Thanks,
Nícolas

<4>[  496.164381] ------------[ cut here ]------------
<4>[  496.169259] WARNING: CPU: 5 PID: 2338 at kernel/workqueue.c:3376 __flush_work.isra.0+0x23c/0x258
<4>[  496.178299] Modules linked in: r8153_ecm cdc_ether usbnet r8152 mt7921e mt7921_common mt76_connac_lib mt76 mac80211 btusb btintel btmtk btrtl btbcm cfg80211 bluetooth uvcvideo mt8192_mt6359_rt1015_rt5682 uvc ecdh_generic snd_soc_mt8192_afe ecc videobuf2_vmalloc crct10dif_ce cros_usbpd_logger fuse ip_tables ipv6
<4>[  496.206108] CPU: 5 PID: 2338 Comm: gst-launch-1.0 Tainted: G        W          6.4.0-rc5-next-20230607+ #475
<4>[  496.216182] Hardware name: Google Spherion (rev0 - 3) (DT)
<4>[  496.221915] pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
<4>[  496.229125] pc : __flush_work.isra.0+0x23c/0x258
<4>[  496.233992] lr : __cancel_work_timer+0x14c/0x1c8
<4>[  496.238859] sp : ffff8000896e3b00
<4>[  496.242423] x29: ffff8000896e3b00 x28: ffff57c3d4079f80 x27: 0000000000000000
<4>[  496.249807] x26: ffff57c3d4079f80 x25: ffffb76395b59dc8 x24: 0000000000000001
<4>[  496.257191] x23: ffffb763928daab8 x22: ffff57c3d4079f80 x21: 0000000000000000
<4>[  496.264575] x20: ffffb763955f6778 x19: ffff57c3cf06f4a0 x18: 0000000000000000
<4>[  496.271958] x17: 000000040044ffff x16: 005000f2b5503510 x15: 0000000000000000
<4>[  496.279342] x14: ffff57c3c03a1f80 x13: ffffa0616a2fc000 x12: 000000003464d91d
<4>[  496.286726] x11: 0000000000000000 x10: 0000000000001b10 x9 : ffffb763928de61c
<4>[  496.294110] x8 : ffff57c3d407baf0 x7 : 0000000000000000 x6 : ffff57c3d4079f80
<4>[  496.301494] x5 : ffff57c3d4079f80 x4 : 0000000000000000 x3 : 0000000000000000
<4>[  496.308878] x2 : ffff8000896e3bf0 x1 : 0000000000000011 x0 : 0000000000000000
<4>[  496.316262] Call trace:
<4>[  496.318958]  __flush_work.isra.0+0x23c/0x258
<4>[  496.323477]  __cancel_work_timer+0x14c/0x1c8
<4>[  496.327996]  cancel_work_sync+0x1c/0x30
<4>[  496.332082]  vdec_msg_queue_deinit+0xac/0xc8
<4>[  496.336604]  vdec_h264_slice_deinit+0x64/0xb8
<4>[  496.341211]  vdec_if_deinit+0x3c/0x68
<4>[  496.345123]  mtk_vcodec_dec_release+0x20/0x40
<4>[  496.349729]  fops_vcodec_release+0x50/0xd8
<4>[  496.354074]  v4l2_release+0x7c/0x100
<4>[  496.357900]  __fput+0x80/0x270
<4>[  496.361205]  ____fput+0x18/0x30
<4>[  496.364595]  task_work_run+0x78/0xe0
<4>[  496.368420]  do_notify_resume+0x29c/0x7f8
<4>[  496.372680]  el0_svc+0xa4/0xb8
<4>[  496.375987]  el0t_64_sync_handler+0xc0/0xc8
<4>[  496.380423]  el0t_64_sync+0x1a8/0x1b0
<4>[  496.384336] ---[ end trace 0000000000000000 ]---
