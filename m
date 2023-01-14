Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B78266AC0E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 16:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjANPTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 10:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjANPTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 10:19:12 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8907EC3;
        Sat, 14 Jan 2023 07:19:11 -0800 (PST)
Received: from ideasonboard.com (93-61-96-190.ip145.fastwebnet.it [93.61.96.190])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1D803E68;
        Sat, 14 Jan 2023 16:19:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1673709549;
        bh=8DdFlTYIVYx7MH33ENuQ32ueX7/jjHZyqYmBP6RymQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uCwTnM+POwxmPx9k1hfd/HTR/7druFEY/2QbW4vZHQ1srpjmMaxN7lQAKi6ej7QOh
         NOoq+iaKGUsCfBVI2hXqFpKardxh4nsYtR5Wj1VmZzBKkop3RiPuHJdJlEDzYz7JsG
         l9wLRKGZCqTptqqxK6Xw5kMWvn63VDFVmTQhnEh4=
Date:   Sat, 14 Jan 2023 16:19:06 +0100
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Andrey Skvortsov <andrej.skvortzov@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: ov5640: Update last busy timestamp to reset
 autosuspend timer
Message-ID: <20230114151906.gkgmhzpq64dhwouu@uno.localdomain>
References: <20230114112109.982005-1-andrej.skvortzov@gmail.com>
 <Y8KgGhu0e/+xIfDm@valkosipuli.retiisi.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8KgGhu0e/+xIfDm@valkosipuli.retiisi.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari

On Sat, Jan 14, 2023 at 02:29:14PM +0200, Sakari Ailus wrote:
> Hi Andrey,
>
> On Sat, Jan 14, 2023 at 02:21:09PM +0300, Andrey Skvortsov wrote:
> > Otherwise autosuspend delay doesn't work and power is cut off
> > immediately as device is freed.
> >
> > Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> > ---
> >  drivers/media/i2c/ov5640.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
> > index ac35350..f71c0f7 100644
> > --- a/drivers/media/i2c/ov5640.c
> > +++ b/drivers/media/i2c/ov5640.c
> > @@ -1238,6 +1238,7 @@ static int ov5640_write_reg(struct ov5640_dev *sensor, u16 reg, u8 val)
> >  		return ret;
> >  	}
> >
> > +	pm_runtime_mark_last_busy(&sensor->i2c_client->dev);
> >  	return 0;
> >  }
> >
> > @@ -1305,6 +1306,7 @@ static int ov5640_read_reg(struct ov5640_dev *sensor, u16 reg, u8 *val)
> >  	}
> >
> >  	*val = buf[0];
> > +	pm_runtime_mark_last_busy(&sensor->i2c_client->dev);
>
> I wouldn't add these calls to register accesses. It's generally relevant
> with autosuspend_put().
>
> The rest seems fine to me.
>

Does it mean the same should be done for the all the sensor drivers that
use autosuspend ? I count 8 of them, not a huge number.

> >  	return 0;
> >  }
> >
> > @@ -3615,6 +3617,7 @@ static int ov5640_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
> >  		break;
> >  	}
> >
> > +	pm_runtime_mark_last_busy(&sensor->i2c_client->dev);
> >  	pm_runtime_put_autosuspend(&sensor->i2c_client->dev);
> >
> >  	return 0;
> > @@ -3702,6 +3705,7 @@ static int ov5640_s_ctrl(struct v4l2_ctrl *ctrl)
> >  		break;
> >  	}
> >
> > +	pm_runtime_mark_last_busy(&sensor->i2c_client->dev);
> >  	pm_runtime_put_autosuspend(&sensor->i2c_client->dev);
> >
> >  	return ret;
> > @@ -4034,8 +4038,10 @@ static int ov5640_s_stream(struct v4l2_subdev *sd, int enable)
> >  out:
> >  	mutex_unlock(&sensor->lock);
> >
> > -	if (!enable || ret)
> > +	if (!enable || ret) {
> > +		pm_runtime_mark_last_busy(&sensor->i2c_client->dev);
> >  		pm_runtime_put_autosuspend(&sensor->i2c_client->dev);
> > +	}
> >
> >  	return ret;
> >  }
> > @@ -4203,6 +4209,7 @@ static int ov5640_probe(struct i2c_client *client)
> >
> >  	pm_runtime_set_autosuspend_delay(dev, 1000);
> >  	pm_runtime_use_autosuspend(dev);
> > +	pm_runtime_mark_last_busy(dev);
> >  	pm_runtime_put_autosuspend(dev);
> >
> >  	return 0;
>
> --
> Kind regards,
>
> Sakari Ailus
