Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65AE65FBF6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 08:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbjAFHak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 02:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjAFHad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 02:30:33 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE7E71FED;
        Thu,  5 Jan 2023 23:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1672990229; x=1704526229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K08OhAmW3FK1nvM92XEIEnUdOkleecistnUg2IhBg3k=;
  b=nRe5PyDTYWL0wo0ycu850GkHLnGa0q9cDpTNfOt1fI1DK0lpW3iD/e7w
   XQvrcmsG/D8CNGhuGcx6Jz2JFN/FeVl/ybDb1o9Fy/qiJ7zdTs1DBNYzE
   GmbOHJWF4/OBnu1Y+VDV4r0WfXvD5zoS9VYUgkHKfauoIdDEmC3HtaSq4
   n3Ao1l/QfJf+sJppaPUAIpHW8D3fd0pymOERZ/fx1QOUUt1KeGZgwCJw1
   AC62R01fqvLtzsMP8bIa2UEMDNsK2mk0PyD0mH5uDRjgMoyLTbvwUPo7Y
   zZ8ODzBuosAiSq9y+pChMaaJpLsAzTk9GcB0DcRG9MRtOISD1Q7h/0kmy
   w==;
X-IronPort-AV: E=Sophos;i="5.96,304,1665439200"; 
   d="scan'208";a="28270425"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 06 Jan 2023 08:30:26 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 06 Jan 2023 08:30:26 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 06 Jan 2023 08:30:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1672990226; x=1704526226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K08OhAmW3FK1nvM92XEIEnUdOkleecistnUg2IhBg3k=;
  b=ldXTu9BGtkiqGItpxWzU57eAJYp6eAQXSUCTt32kH+9gixjJt8xGqXw0
   aaNiIGf4DVFfkMVGFrGhV2iE9LH3ebbbfW5EKdOjvjSoN0L1fry2alAeY
   NSoNQB545dwGbyZPGZrW9stTiI47zhj6hrUiQ8kvScVOPBaKYM8QwEYNO
   MuZjlkwlTkLMrH23FbU/3zyppS4vmHEJ7SYHEmeUOYuHUPlKZTo7ZfHzk
   XxCe+FMFt8hlklN0ZzroO/iC7AFWzPHKo7XQj4GymSDno2vqBevnh3l2Z
   kPK/YMm++AUXzbe71Y4Ljs5QhsnYhi7BORf+k0GDDxGTAs0lrabgFeMSW
   g==;
X-IronPort-AV: E=Sophos;i="5.96,304,1665439200"; 
   d="scan'208";a="28270424"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 06 Jan 2023 08:30:26 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 15BC2280056;
        Fri,  6 Jan 2023 08:30:26 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Colin Ian King <colin.i.king@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] media: rkisp1: make a few const arrays static
Date:   Fri, 06 Jan 2023 08:30:23 +0100
Message-ID: <10879096.BaYr0rKQ5T@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230105184403.63419-1-colin.i.king@gmail.com>
References: <20230105184403.63419-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

Am Donnerstag, 5. Januar 2023, 19:44:03 CET schrieb Colin Ian King:
> Don't populate the const arrays on the stack, instead make them
> static. Also makes the object code smaller.

While I don't dislike this change itself, are you sure about the size change?

bloat-o-meter shows an overall increase:
> ./scripts/bloat-o-meter /tmp/rkisp1-capture_old.o
> /tmp/rkisp1-capture_new.o
> add/remove: 3/0 grow/shrink: 1/2 up/down: 256/-116 (140)
> Function                                     old     new   delta
> rkisp1_try_fmt_vid_cap_mplane                 56     280    +224
> dev_names                                      -      16     +16
> max_widths                                     -       8      +8
> max_heights                                    -       8      +8
> rkisp1_try_fmt                               356     304     -52
> rkisp1_register_capture                      548     484     -64
> Total: Before=12333, After=12473, chg +1.14%

To be honest I don't know why GCC now inlines rkisp1_try_fmt() in 
rkisp1_try_fmt_vid_cap_mplane.

Best regards,
Alexander

> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  .../platform/rockchip/rkisp1/rkisp1-capture.c     | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c index
> d4540684ea9a..d1d1fdce03e3 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> @@ -1131,10 +1131,12 @@ static void rkisp1_try_fmt(const struct
> rkisp1_capture *cap, const struct rkisp1_capture_config *config =
> cap->config;
>  	const struct rkisp1_capture_fmt_cfg *fmt;
>  	const struct v4l2_format_info *info;
> -	const unsigned int max_widths[] = { RKISP1_RSZ_MP_SRC_MAX_WIDTH,
> -					    
RKISP1_RSZ_SP_SRC_MAX_WIDTH };
> -	const unsigned int max_heights[] = { RKISP1_RSZ_MP_SRC_MAX_HEIGHT,
> -					     
RKISP1_RSZ_SP_SRC_MAX_HEIGHT};
> +	static const unsigned int max_widths[] = {
> +		RKISP1_RSZ_MP_SRC_MAX_WIDTH, RKISP1_RSZ_SP_SRC_MAX_WIDTH
> +	};
> +	static const unsigned int max_heights[] = {
> +		RKISP1_RSZ_MP_SRC_MAX_HEIGHT, RKISP1_RSZ_SP_SRC_MAX_HEIGHT
> +	};
> 
>  	fmt = rkisp1_find_fmt_cfg(cap, pixm->pixelformat);
>  	if (!fmt) {
> @@ -1336,8 +1338,9 @@ void rkisp1_capture_devs_unregister(struct
> rkisp1_device *rkisp1)
> 
>  static int rkisp1_register_capture(struct rkisp1_capture *cap)
>  {
> -	const char * const dev_names[] = {RKISP1_MP_DEV_NAME,
> -					  RKISP1_SP_DEV_NAME};
> +	static const char * const dev_names[] = {
> +		RKISP1_MP_DEV_NAME, RKISP1_SP_DEV_NAME
> +	};
>  	struct v4l2_device *v4l2_dev = &cap->rkisp1->v4l2_dev;
>  	struct video_device *vdev = &cap->vnode.vdev;
>  	struct rkisp1_vdev_node *node;




