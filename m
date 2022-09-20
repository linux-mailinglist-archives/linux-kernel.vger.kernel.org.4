Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9C25BE629
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiITMqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbiITMqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:46:43 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768BC6524E;
        Tue, 20 Sep 2022 05:46:41 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id D278140011;
        Tue, 20 Sep 2022 12:46:37 +0000 (UTC)
Date:   Tue, 20 Sep 2022 14:46:35 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Rafael Mendonca <rafaelmendsr@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: i2c: ov5648: Free V4L2 fwnode data on unbind
Message-ID: <20220920124635.jhprooo67daaivq7@lati>
References: <20220919023247.731106-1-rafaelmendsr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220919023247.731106-1-rafaelmendsr@gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael

On Sun, Sep 18, 2022 at 11:32:46PM -0300, Rafael Mendonca wrote:
> The V4L2 fwnode data structure doesn't get freed on unbind, which leads to
> a memleak.
>
> Fixes: e43ccb0a045f ("media: i2c: Add support for the OV5648 image sensor")
> Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
> ---
>  drivers/media/i2c/ov5648.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/media/i2c/ov5648.c b/drivers/media/i2c/ov5648.c
> index dfcd33e9ee13..95850f06112b 100644
> --- a/drivers/media/i2c/ov5648.c
> +++ b/drivers/media/i2c/ov5648.c
> @@ -2598,6 +2598,8 @@ static int ov5648_remove(struct i2c_client *client)
>  	mutex_destroy(&sensor->mutex);
>  	media_entity_cleanup(&subdev->entity);
>
> +	v4l2_fwnode_endpoint_free(&sensor->endpoint);
> +

Nit: all the other function calls are in a single block, this one
doesn't deserve an empty line before it.

Nit apart, the patch is a good fix.


>  	return 0;
>  }
>
> --
> 2.34.1
>
