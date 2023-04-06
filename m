Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE4C6D8CC5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 03:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbjDFBdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 21:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjDFBdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 21:33:33 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF98F769E;
        Wed,  5 Apr 2023 18:33:31 -0700 (PDT)
Received: from pendragon.ideasonboard.com (fp76f193f3.tkyc206.ap.nuro.jp [118.241.147.243])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 61879905;
        Thu,  6 Apr 2023 03:33:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1680744810;
        bh=BI5DhEt/1y4gYVxBN+ayCH+/Db/18c3nUDYO3pW1iWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JAFTmKzZeaTqYXH1XIeVr/dhEf6ElQAGv/LKcJzBO/scS7hOY/t8yxlS05Alj/t4Q
         uwVCy8dcHos5SggoUYewHfFlsu0rIDq7FDTOuxym8AAdBhWMA7pkx3RYbUsqJa+eMv
         u6N2ov/xv0yOJ7VVvgyW8BfQoP91K0cbwq7Gp4Xw=
Date:   Thu, 6 Apr 2023 04:33:38 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Martin Kepplinger <martin.kepplinger@puri.sm>, mchehab@kernel.org,
        kernel@puri.sm, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] media: hi846: fix usage of
 pm_runtime_get_if_in_use()
Message-ID: <20230406013338.GK9915@pendragon.ideasonboard.com>
References: <20230405092904.1129395-1-martin.kepplinger@puri.sm>
 <20230405092904.1129395-2-martin.kepplinger@puri.sm>
 <ZC1vJNIGeEu+xi+i@valkosipuli.retiisi.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZC1vJNIGeEu+xi+i@valkosipuli.retiisi.eu>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Wed, Apr 05, 2023 at 03:52:52PM +0300, Sakari Ailus wrote:
> On Wed, Apr 05, 2023 at 11:29:03AM +0200, Martin Kepplinger wrote:
> > pm_runtime_get_if_in_use() does not only return nonzero values when
> > the device is in use, it can return a negative errno too.
> > 
> > And especially during resuming from system suspend, when runtime pm
> > is not yet up again, this can very well happen. And in such a case
> > the subsequent pm_runtime_put() call would result in a refcount underflow!
> 
> I think this issue should have a more generic solution, it's very difficult
> to address this in drivers only with the current APIs.
> 
> pm_runtime_get_if_in_use() will also return an error if runtime PM is
> disabled, so this patch will break the driver for that configuration.

I'm increasingly inclined to depend on CONFIG_PM for all camera sensor
drivers.

> > Fix it by correctly using pm_runtime_get_if_in_use().
> > 
> > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > ---
> >  drivers/media/i2c/hi846.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/media/i2c/hi846.c b/drivers/media/i2c/hi846.c
> > index 5b5ea5425e984..0b0eda2e223cd 100644
> > --- a/drivers/media/i2c/hi846.c
> > +++ b/drivers/media/i2c/hi846.c
> > @@ -1544,7 +1544,7 @@ static int hi846_set_ctrl(struct v4l2_ctrl *ctrl)
> >  					 exposure_max);
> >  	}
> >  
> > -	if (!pm_runtime_get_if_in_use(&client->dev))
> > +	if (pm_runtime_get_if_in_use(&client->dev) <= 0)
> >  		return 0;
> >  
> >  	switch (ctrl->id) {

-- 
Regards,

Laurent Pinchart
