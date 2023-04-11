Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF446DD70D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 11:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjDKJkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 05:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjDKJkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 05:40:10 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B20272B;
        Tue, 11 Apr 2023 02:39:40 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 9287AEBCCB;
        Tue, 11 Apr 2023 02:39:38 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id szR5xkP6yVdK; Tue, 11 Apr 2023 02:39:37 -0700 (PDT)
Message-ID: <9ad81a9b2806272c715784985a3e0f52cda159c7.camel@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1681205977; bh=78H+kq1MA3qAPgJDeC2Mvq4z8qNyX9HDvr7Gs/K953g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=WaHYjMkof9EQQ97Wv2wBLHqnSkIyel2UYJzIm86a5VR+SzDZYyRNQXtOkV7rAI1Yq
         01mQvKsIpmFPVUYiVQER6KXU85556WQ7x0rNzwHapP41K7fYi40DkKsl8LoeyZPi2U
         hlxDVVXaXG5cFMtMrz+D60PwM5RrK58ufMTZ5gc9u/3sG6ldEWnGH3Kj/rrxT8NxQF
         MKb/7mA7BvRqJiKDq0Kqxax2aGzm/Bd/y9G20DIbeeVtLsSPh4bqwIaTYEHWUSEyeW
         8pkWRuh8oTclUKBHRnu+9JJI+5ZGFINhfZJg1nFz3/IUjh3QYPUKt+Y9JGLaL2TnBl
         GNXWB3nLsLgbQ==
Subject: Re: [PATCH v1 2/2] media: hi846: preserve the streaming state
 during system suspend
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     mchehab@kernel.org, kernel@puri.sm, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 11 Apr 2023 11:39:32 +0200
In-Reply-To: <20230406013551.GL9915@pendragon.ideasonboard.com>
References: <20230405092904.1129395-1-martin.kepplinger@puri.sm>
         <20230405092904.1129395-3-martin.kepplinger@puri.sm>
         <20230406013551.GL9915@pendragon.ideasonboard.com>
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

Am Donnerstag, dem 06.04.2023 um 04:35 +0300 schrieb Laurent Pinchart:
> Hi Martin,
> 
> Thank you for the patch.
> 
> On Wed, Apr 05, 2023 at 11:29:04AM +0200, Martin Kepplinger wrote:
> > The hi846 driver changed the "streaming" state inside of
> > "start/stop_streaming".
> > The problem is that inside of the (system) suspend callback, it
> > calls
> > "stop_streaming" unconditionally. So streaming would always be
> > stopped
> > when suspending.
> > 
> > That makes sense with runtime pm for example, after s_stream(...,
> > 0) but
> > does not preserve the "streaming" state during system suspend when
> > currently streaming.
> 
> The driver shouldn't need to stop streaming at system suspend time.
> It
> should have had its .s_stream(0) operation called and shouldn't be
> streaming anymore. If that's not the case, there's an issue somewhere
> else, which should be fixed. The code that stops streaming at system
> suspend and restarts it at system resume should then be dropped from
> this driver.
> 
> > Fix this by simply setting the streaming state outside of
> > "start/stop_streaming"
> > which is s_stream().
> > 
> > While at it, improve things a bit by not assigning "1", but the
> > "enable"
> > value we later compare against, and fix one error handling path in
> > resume().
> > 
> > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > ---
> >  drivers/media/i2c/hi846.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/media/i2c/hi846.c b/drivers/media/i2c/hi846.c
> > index 0b0eda2e223cd..1ca6e9407d618 100644
> > --- a/drivers/media/i2c/hi846.c
> > +++ b/drivers/media/i2c/hi846.c
> > @@ -1780,8 +1780,6 @@ static int hi846_start_streaming(struct hi846
> > *hi846)
> >                 return ret;
> >         }
> >  
> > -       hi846->streaming = 1;
> > -
> >         dev_dbg(&client->dev, "%s: started streaming
> > successfully\n", __func__);
> >  
> >         return ret;
> > @@ -1793,8 +1791,6 @@ static void hi846_stop_streaming(struct hi846
> > *hi846)
> >  
> >         if (hi846_write_reg(hi846, HI846_REG_MODE_SELECT,
> > HI846_MODE_STANDBY))
> >                 dev_err(&client->dev, "failed to stop stream");
> > -
> > -       hi846->streaming = 0;
> >  }
> >  
> >  static int hi846_set_stream(struct v4l2_subdev *sd, int enable)
> > @@ -1816,10 +1812,12 @@ static int hi846_set_stream(struct
> > v4l2_subdev *sd, int enable)
> >                 }
> >  
> >                 ret = hi846_start_streaming(hi846);
> > +               hi846->streaming = enable;
> >         }
> >  
> >         if (!enable || ret) {
> >                 hi846_stop_streaming(hi846);
> > +               hi846->streaming = 0;
> >                 pm_runtime_put(&client->dev);
> >         }
> >  
> > @@ -1898,6 +1896,8 @@ static int __maybe_unused hi846_resume(struct
> > device *dev)
> >                 if (ret) {
> >                         dev_err(dev, "%s: start streaming failed:
> > %d\n",
> >                                 __func__, ret);
> > +                       hi846_stop_streaming(hi846);
> > +                       hi846->streaming = 0;
> >                         goto error;
> >                 }
> >         }
> 

hi Laurent,

ok I see. My first test without any streaming-state handling in
suspend/resume doesn't succeed. But now I know that's the goal and I'll
put this on my list to do.

Since this driver *already* tracks "streaming", would you be ok with
this fix in the meantime?

thanks,
                               martin


