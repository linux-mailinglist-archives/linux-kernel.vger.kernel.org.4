Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5683A6DADA2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjDGNbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240804AbjDGNbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 09:31:24 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDC7AF12;
        Fri,  7 Apr 2023 06:31:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id A858AF1003;
        Fri,  7 Apr 2023 06:31:06 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hROvoePqLQxn; Fri,  7 Apr 2023 06:31:05 -0700 (PDT)
Message-ID: <cb0c1ad7e00523a43ce6ad73a79e7e396c4b52aa.camel@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1680874265; bh=T7vpFXDNomoCxY8qP+17WW148a4mIe6W7ti0M3g0XQw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=WMrhcl6hfx+3B4ON96J3a1E7qDIbPZ0wYZNIKS6fJ/RSG2OyJxB6hAuS+8VhQ42v3
         iGcaMqa5YsJMBOcr0tWV7a/yh531u/ZSMgvw0eKQUSaZNtjsWqjSFiwvCbwYAR5Xmp
         h/sKubetDvcysQ7s8Rm9heCNh+2xiuRe8fOfXdFVIx7LzYVwxH51Z9alu0QAD7A8G+
         EWnyjuf66Iej12/D+vrbS3A0KlxnqsNs9ubA9y3dmcbP8epbHBtix+XBUGUdDC7/55
         Ss3kjfmq9WJS18LG6p1soUSbGh+q3iA0LbMqGihSPRkviaAv7t+jR4XJd3xrFJf8Qw
         machgJap3C/6A==
Subject: Re: [PATCH v1 1/2] media: hi846: fix usage of
 pm_runtime_get_if_in_use()
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     mchehab@kernel.org, laurent.pinchart@ideasonboard.com,
        kernel@puri.sm, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 07 Apr 2023 15:31:02 +0200
In-Reply-To: <ZC1vJNIGeEu+xi+i@valkosipuli.retiisi.eu>
References: <20230405092904.1129395-1-martin.kepplinger@puri.sm>
         <20230405092904.1129395-2-martin.kepplinger@puri.sm>
         <ZC1vJNIGeEu+xi+i@valkosipuli.retiisi.eu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1+deb11u1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, dem 05.04.2023 um 15:52 +0300 schrieb Sakari Ailus:
> Hi Martin,
> 
> On Wed, Apr 05, 2023 at 11:29:03AM +0200, Martin Kepplinger wrote:
> > pm_runtime_get_if_in_use() does not only return nonzero values when
> > the device is in use, it can return a negative errno too.
> > 
> > And especially during resuming from system suspend, when runtime pm
> > is not yet up again, this can very well happen. And in such a case
> > the subsequent pm_runtime_put() call would result in a refcount
> > underflow!
> 
> I think this issue should have a more generic solution, it's very
> difficult
> to address this in drivers only with the current APIs.
> 
> pm_runtime_get_if_in_use() will also return an error if runtime PM is
> disabled, so this patch will break the driver for that configuration.

ok but the driver is currently broken for any *other* error returned by
pm_runtime_get_if_in_use() (than the runtime-PM disabled error).

The execution-path during system-resume I'm interested in gets -EAGAIN
here. Would it be ok for you if I'd return early only for that one
error only here?


> 
> > 
> > Fix it by correctly using pm_runtime_get_if_in_use().
> > 
> > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > ---
> >  drivers/media/i2c/hi846.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/media/i2c/hi846.c b/drivers/media/i2c/hi846.c
> > index 5b5ea5425e984..0b0eda2e223cd 100644
> > --- a/drivers/media/i2c/hi846.c
> > +++ b/drivers/media/i2c/hi846.c
> > @@ -1544,7 +1544,7 @@ static int hi846_set_ctrl(struct v4l2_ctrl
> > *ctrl)
> >                                          exposure_max);
> >         }
> >  
> > -       if (!pm_runtime_get_if_in_use(&client->dev))
> > +       if (pm_runtime_get_if_in_use(&client->dev) <= 0)
> >                 return 0;
> >  
> >         switch (ctrl->id) {
> 


