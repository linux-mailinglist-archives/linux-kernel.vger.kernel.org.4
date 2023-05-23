Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD6570E316
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237968AbjEWRHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238016AbjEWRHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:07:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53264E4B
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:06:53 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1q1VT6-000211-QU; Tue, 23 May 2023 19:06:40 +0200
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1q1VT3-0000Bx-RL; Tue, 23 May 2023 19:06:37 +0200
Date:   Tue, 23 May 2023 19:06:37 +0200
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     ezequiel@vanguardiasur.com.ar, nicolas.dufresne@collabora.com,
        p.zabel@pengutronix.de, mchehab@kernel.org,
        m.szyprowski@samsung.com, didi.debian@cknow.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        regressions@lists.linux.dev
Subject: Re: [PATCH] media: verisilicon: Additional fix for the crash when
 opening the driver
Message-ID: <20230523170637.GE9943@pengutronix.de>
Mail-Followup-To: Michael Tretter <m.tretter@pengutronix.de>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, nicolas.dufresne@collabora.com,
        p.zabel@pengutronix.de, mchehab@kernel.org,
        m.szyprowski@samsung.com, didi.debian@cknow.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        regressions@lists.linux.dev
References: <20230523162515.993862-1-benjamin.gaignard@collabora.com>
 <c034db29-b664-793d-35e0-406fdfe2b145@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c034db29-b664-793d-35e0-406fdfe2b145@collabora.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 18:36:09 +0200, Benjamin Gaignard wrote:
> 
> Le 23/05/2023 à 18:25, Benjamin Gaignard a écrit :
> > This fixes the following issue observed on Odroid-M1 board:
> > 
> >   Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
> >   Mem abort info:
> >   ...
> >   Modules linked in: crct10dif_ce hantro_vpu snd_soc_simple_card snd_soc_simple_card_utils v4l2_vp9 v4l2_h264 rockchip_saradc v4l2_mem2mem videobuf2_dma_contig videobuf2_memops rtc_rk808 videobuf2_v4l2 industrialio_triggered_buffer rockchip_thermal dwmac_rk stmmac_platform stmmac videodev kfifo_buf display_connector videobuf2_common pcs_xpcs mc rockchipdrm analogix_dp dw_mipi_dsi dw_hdmi drm_display_helper panfrost drm_shmem_helper gpu_sched ip_tables x_tables ipv6
> >   CPU: 3 PID: 176 Comm: v4l_id Not tainted 6.3.0-rc7-next-20230420 #13481
> >   Hardware name: Hardkernel ODROID-M1 (DT)
> >   pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> >   pc : hantro_try_fmt+0xa0/0x278 [hantro_vpu]
> >   lr : hantro_try_fmt+0x94/0x278 [hantro_vpu]
> >   ...
> >   Call trace:
> >    hantro_try_fmt+0xa0/0x278 [hantro_vpu]
> >    hantro_set_fmt_out+0x3c/0x298 [hantro_vpu]
> >    hantro_reset_raw_fmt+0x98/0x128 [hantro_vpu]
> >    hantro_set_fmt_cap+0x240/0x254 [hantro_vpu]
> >    hantro_reset_encoded_fmt+0x94/0xcc [hantro_vpu]
> >    hantro_reset_fmts+0x18/0x38 [hantro_vpu]
> >    hantro_open+0xd4/0x20c [hantro_vpu]
> >    v4l2_open+0x80/0x120 [videodev]
> >    chrdev_open+0xc0/0x22c
> >    do_dentry_open+0x13c/0x48c
> >    vfs_open+0x2c/0x38
> >    path_openat+0x550/0x934
> >    do_filp_open+0x80/0x12c
> >    do_sys_openat2+0xb4/0x168
> >    __arm64_sys_openat+0x64/0xac
> >    invoke_syscall+0x48/0x114
> >    el0_svc_common+0x100/0x120
> >    do_el0_svc+0x3c/0xa8
> >    el0_svc+0x40/0xa8
> >    el0t_64_sync_handler+0xb8/0xbc
> >    el0t_64_sync+0x190/0x194
> >   Code: 97fc8a7f f940aa80 52864a61 72a686c1 (b9400800)
> >   ---[ end trace 0000000000000000 ]---
> > 
> > Fixes: db6f68b51e5c ("media: verisilicon: Do not set context src/dst formats in reset functions")

This patch partially reverts the previous commit. I wonder whether the reason
for resetting the context format only if the targeted queue is not busy still
stands.

> > 
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Tested-by: Michael Tretter <m.tretter@pengutronix.de>

> > ---
> 
> Diederick, Marek, Michael,
> I have tested this patch on my boards and I see no regressions on
> decoder part and no more crash when probing the encoder.
> Could you test it on your side to confirm it is ok ?
> 
> Thorsten, I try/test regzbot commands, please tell me if it is correct.
> 
> #regzbot ^introduced db6f68b51e5c
> #regzbot title media: verisilicon: null pointer dereference in try_fmt
> #regzbot ignore-activity
> 
> 
> >   drivers/media/platform/verisilicon/hantro_v4l2.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
> > index 835518534e3b..61cfaaf4e927 100644
> > --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> > +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> > @@ -397,10 +397,12 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx, int bit_depth)
> >   	if (!raw_vpu_fmt)
> >   		return -EINVAL;
> > -	if (ctx->is_encoder)
> > +	if (ctx->is_encoder) {
> >   		encoded_fmt = &ctx->dst_fmt;
> > -	else
> > +		ctx->vpu_src_fmt = raw_vpu_fmt;
> > +	} else {
> >   		encoded_fmt = &ctx->src_fmt;
> > +	}
> >   	hantro_reset_fmt(&raw_fmt, raw_vpu_fmt);
> >   	raw_fmt.width = encoded_fmt->width;
> 
