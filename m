Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47598716B6B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjE3RpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjE3RpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:45:16 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1D7D9;
        Tue, 30 May 2023 10:45:14 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126205198071.34.openmobile.ne.jp [126.205.198.71])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 899207EC;
        Tue, 30 May 2023 19:44:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1685468692;
        bh=jm2ldsqaGU1NMz+qnYWObPHh1yWtfkHkbJiCm2Lrw3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QQIuJnNignz0Gld4KLd6aQR5alFgqgMSvp3snFqjSd2o/rV87ixUHHsuHyk9Rs3K9
         UGUjUSZ1Tlbi45i5x8rMjxFCqghzD/DP6mtvBEw2+yD7yzHmmJm/WvxZ1sbWhBJc2E
         ZxjVWCBeOLNu6Nlg3zyDKJupvmnR43nVFEJGAovc=
Date:   Tue, 30 May 2023 20:45:13 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: camss: camss-video: Don't zero subdev format
 again after initialization
Message-ID: <20230530174513.GJ22516@pendragon.ideasonboard.com>
References: <20230503075340.45755-1-y.oudjana@protonmail.com>
 <20230530174225.GI22516@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230530174225.GI22516@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 08:42:30PM +0300, Laurent Pinchart wrote:
> Hi Yassine,
> 
> Thank you for the patch.
> 
> On Wed, May 03, 2023 at 10:53:40AM +0300, Yassine Oudjana wrote:
> > From: Yassine Oudjana <y.oudjana@protonmail.com>
> > 
> > In an earlier commit, setting the which field of the subdev format struct
> > in video_get_subdev_format was moved to a designated initializer that also
> > zeroes all other fields. However, the memset call that was zeroing the
> > fields earlier was left in place, causing the which field to be cleared
> > after being set in the initializer.
> > 
> > Remove the memset call from video_get_subdev_format to avoid clearing the
> > initialized which field.
> > 
> > Fixes: ecefa105cc44 ("media: Zero-initialize all structures passed to subdev pad operations")
> > Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> This is a regression fix, I'll send a pull request right away.

The patch has actually been applied to the media fixes branch already
:-)

> > ---
> >  drivers/media/platform/qcom/camss/camss-video.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/media/platform/qcom/camss/camss-video.c b/drivers/media/platform/qcom/camss/camss-video.c
> > index 898f32177b12..8640db306026 100644
> > --- a/drivers/media/platform/qcom/camss/camss-video.c
> > +++ b/drivers/media/platform/qcom/camss/camss-video.c
> > @@ -353,7 +353,6 @@ static int video_get_subdev_format(struct camss_video *video,
> >  	if (subdev == NULL)
> >  		return -EPIPE;
> >  
> > -	memset(&fmt, 0, sizeof(fmt));
> >  	fmt.pad = pad;
> >  
> >  	ret = v4l2_subdev_call(subdev, pad, get_fmt, NULL, &fmt);

-- 
Regards,

Laurent Pinchart
