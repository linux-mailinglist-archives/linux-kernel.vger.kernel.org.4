Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E037172CD7A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbjFLSGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbjFLSGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:06:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C680FE63;
        Mon, 12 Jun 2023 11:06:15 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AE45C6606EAE;
        Mon, 12 Jun 2023 19:06:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686593174;
        bh=yYx4qqYv+3yHSQphvr+NHsZgUVmCj4ZXNZY98wPyhWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XPwPwMLI0ZfzEdBT8NjCN8q1A+cvE199gGBV1X45+SJfJJB0mbIJk2K1rMcrnJhyD
         434Aobe2o5K1K6BFcgdkCkdZhKQRXpjgiq6DVu3e+vOY3qzwY+Rn5nTZCNNaA7+t5t
         YxHRblK9m+YNlhA8FmzTFZ9yoivi4FS6CmknWzsBM8zf5U6U8Vm7avDPcUltH0cYyv
         h/0tdUgOFiqkGM9tGHKq0KcRJTq1kwPy90I/lCBmj1nDCsPQrHX3mrAXIq1zrRoc9I
         TQpFLmNlJzThpP28xKpw4tP8kE8R9FaB9faRh17rNxN/q1hJbojtfIjS17qyIZ4UCA
         IIDebQY46fBQg==
Date:   Mon, 12 Jun 2023 14:06:06 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nathan Hebert <nhebert@chromium.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2] media: mediatek: vcodec: fix cancel_work_sync fail
 with fluster test
Message-ID: <b130377d-4e1a-423c-9e51-c96a3833b51c@notapiano>
References: <20230612101939.20259-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230612101939.20259-1-yunfei.dong@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 06:19:39PM +0800, Yunfei Dong wrote:
> Will cause below warning then reboot when exercising the decoder with
> fluster on mt8192-asurada-spherion.
> 
> This deinit function is called on the v4l2 release callback, even though the
> work might not have been initialized as that only happens if/when the codec
> specific 'decode' callback is called (as a result of device_run m2m callback).
> 
> CPU: 5 PID: 2338 Comm: gst-launch-1.0 Tainted: G        W          6.4.0-rc5-next-20230607+ #475
> Hardware name: Google Spherion (rev0 - 3) (DT)
> pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __flush_work.isra.0+0x23c/0x258
> lr : __cancel_work_timer+0x14c/0x1c8
> sp : ffff8000896e3b00
> x29: ffff8000896e3b00 x28: ffff57c3d4079f80 x27: 0000000000000000
> x26: ffff57c3d4079f80 x25: ffffb76395b59dc8 x24: 0000000000000001
> x23: ffffb763928daab8 x22: ffff57c3d4079f80 x21: 0000000000000000
> x20: ffffb763955f6778 x19: ffff57c3cf06f4a0 x18: 0000000000000000
> x17: 000000040044ffff x16: 005000f2b5503510 x15: 0000000000000000
> x14: ffff57c3c03a1f80 x13: ffffa0616a2fc000 x12: 000000003464d91d
> x11: 0000000000000000 x10: 0000000000001b10 x9 : ffffb763928de61c
> x8 : ffff57c3d407baf0 x7 : 0000000000000000 x6 : ffff57c3d4079f80
> x5 : ffff57c3d4079f80 x4 : 0000000000000000 x3 : 0000000000000000
> x2 : ffff8000896e3bf0 x1 : 0000000000000011 x0 : 0000000000000000
> Call trace:
>  __flush_work.isra.0+0x23c/0x258
>  __cancel_work_timer+0x14c/0x1c8
>  cancel_work_sync+0x1c/0x30
>  vdec_msg_queue_deinit+0xac/0xc8
>  vdec_h264_slice_deinit+0x64/0xb8
>  vdec_if_deinit+0x3c/0x68
>  mtk_vcodec_dec_release+0x20/0x40
>  fops_vcodec_release+0x50/0xd8
>  v4l2_release+0x7c/0x100
>  __fput+0x80/0x270
>  ____fput+0x18/0x30
>  task_work_run+0x78/0xe0
>  do_notify_resume+0x29c/0x7f8
>  el0_svc+0xa4/0xb8
>  el0t_64_sync_handler+0xc0/0xc8
>  el0t_64_sync+0x1a8/0x1b0
> ---[ end trace 0000000000000000 ]---
> 
> Fixes: 297160d411e3 ("media: mediatek: vcodec: move core context from device to each instance")
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Hi Yunfei,

thanks for addressing the issue. The warnings are now gone with this patch
applied.

Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
