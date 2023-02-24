Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE9C6A1C58
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjBXMlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjBXMlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:41:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531A968284;
        Fri, 24 Feb 2023 04:41:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE511618D6;
        Fri, 24 Feb 2023 12:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB560C4339B;
        Fri, 24 Feb 2023 12:41:45 +0000 (UTC)
Message-ID: <ed37c8c7-92a8-73fe-1451-08695cd4db9f@xs4all.nl>
Date:   Fri, 24 Feb 2023 13:41:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 6/9] media: i2c: ov2685: convert to i2c's .probe_new()
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Wolfram Sang <wsa@kernel.org>
Cc:     kernel@pengutronix.de, Shunqian Zheng <zhengsq@rock-chips.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
References: <20230224120600.1681685-1-u.kleine-koenig@pengutronix.de>
 <20230224120600.1681685-7-u.kleine-koenig@pengutronix.de>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20230224120600.1681685-7-u.kleine-koenig@pengutronix.de>
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

On 24/02/2023 13:05, Uwe Kleine-König wrote:
> The probe function doesn't make use of the i2c_device_id * parameter so
> it can be trivially converted.
> 
> Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

> Link: https://lore.kernel.org/lkml/20221121102838.16448-1-u.kleine-koenig@pengutronix.de
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/media/i2c/ov2685.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov2685.c b/drivers/media/i2c/ov2685.c
> index a3b524f15d89..1c80b121e7d6 100644
> --- a/drivers/media/i2c/ov2685.c
> +++ b/drivers/media/i2c/ov2685.c
> @@ -707,8 +707,7 @@ static int ov2685_configure_regulators(struct ov2685 *ov2685)
>  				       ov2685->supplies);
>  }
>  
> -static int ov2685_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static int ov2685_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct ov2685 *ov2685;
> @@ -830,7 +829,7 @@ static struct i2c_driver ov2685_i2c_driver = {
>  		.pm = &ov2685_pm_ops,
>  		.of_match_table = of_match_ptr(ov2685_of_match),
>  	},
> -	.probe		= &ov2685_probe,
> +	.probe_new	= &ov2685_probe,
>  	.remove		= &ov2685_remove,
>  };
>  

