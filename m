Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222036B78AF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjCMNSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjCMNSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:18:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20117DAA;
        Mon, 13 Mar 2023 06:17:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 434ED612A5;
        Mon, 13 Mar 2023 13:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7135C433EF;
        Mon, 13 Mar 2023 13:17:56 +0000 (UTC)
Message-ID: <7f9796d2-1885-a6f2-b9e3-d6ea58524033@xs4all.nl>
Date:   Mon, 13 Mar 2023 14:17:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] media: hantro: fix use after free bug in hantro_release
 due to race condition
Content-Language: en-US
To:     Zheng Wang <zyytlz.wz@163.com>, ezequiel@vanguardiasur.com.ar
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com
References: <20230307153542.1178065-1-zyytlz.wz@163.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20230307153542.1178065-1-zyytlz.wz@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2023 16:35, Zheng Wang wrote:
> In hantro_probe, vpu->watchdog_work is bound with
> hantro_watchdog. Then hantro_end_prepare_run may
> be called to start the work.
> 
> If we close the file or remove the module which will
> call hantro_release and hantro_remove to make cleanup,
> there may be a unfinished work. The possible sequence
> is as follows, which will cause a typical UAF bug.
> 
> The same thing will happen in hantro_release, and use
> ctx after freeing it.
> 
> Fix it by canceling the work before cleanup in hantro_release.
> 
> CPU0                  CPU1
> 
>                     |hantro_watchdog
> hantro_remove     |
>   v4l2_m2m_release  |
>     kfree(m2m_dev); |
>                     |
>                     | v4l2_m2m_get_curr_priv
>                     |   m2m_dev->curr_ctx //use
> 
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---
>  drivers/media/platform/verisilicon/hantro_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
> index b0aeedae7b65..cf00ccaa7829 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -601,6 +601,7 @@ static int hantro_release(struct file *filp)
>  	 * No need for extra locking because this was the last reference
>  	 * to this file.
>  	 */
> +	cancel_delayed_work(&vpu->watchdog_work);
>  	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
>  	v4l2_fh_del(&ctx->fh);
>  	v4l2_fh_exit(&ctx->fh);

drivers/media/platform/verisilicon/hantro_drv.c: In function ‘hantro_release’:
drivers/media/platform/verisilicon/hantro_drv.c:604:30: error: ‘vpu’ undeclared (first use in this function); did you mean ‘fpu’?
  604 |         cancel_delayed_work(&vpu->watchdog_work);
      |                              ^~~
      |                              fpu
drivers/media/platform/verisilicon/hantro_drv.c:604:30: note: each undeclared identifier is reported only once for each function it appears in

You clearly didn't compile this patch!

Regards,

	Hans
