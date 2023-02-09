Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5BC690931
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjBIMqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjBIMqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:46:08 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2AD5ACD1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 04:46:04 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id rp23so5942989ejb.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 04:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diag.uniroma1.it; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+ju7t4a36+oHzJBzDdbRdtWVOsqQ7SpJKvGOYlM6F+o=;
        b=a2zMTHmykLPxR2GgyDQR2DSW5pN50V//iASjZNSbAnnRVNNv8S4pBWdn7zy6T/sQS0
         ax43Av1sTVvs1tZ2op8ghcek45fzvnolaohbctL0rmfdlnUCkbyQa5Yn+Y4BHZkR/0Hb
         qDCn7YLbKZyfIXyB0RxGtD2GoFzQ2pv4KwQSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ju7t4a36+oHzJBzDdbRdtWVOsqQ7SpJKvGOYlM6F+o=;
        b=AsMDySuarR+SQqeRSj0wFBHLB6r0qg7Du8xjgbnBkPlZrnMc4ZLJzn/v9kALIxs8mV
         B8MOreli9TlAFOKCq0jJhWxAdjgfN6+zNEWMEpoVQGkp+/EhFre9Pvoh8MMdAOxbSRpR
         /xxn9ZpuR8nCRRfYquGxYpOnR5R7G0WILLTDMKkMUkpZ6q5U3VZ4ZoUspJtkGpet1BUP
         MSrQQpN3tK7ceZqg9zNCuuJLBQ19pIJ/RRGeNx93v/QgoIt39TdgwV9YfyLMcRnW/qmd
         VH2cExaDzvCQjdSKwBz/o+rN/ITEfM3ITDr3AvuYLEPpQ3g5dzzydCB08y1kqJ/WnfEb
         4sAQ==
X-Gm-Message-State: AO0yUKWbjJ8Xh2rZSuKCot2zXe34swUvSdYZrYESb3+Ri4lTo85Hz7jx
        eK/9lQzRwq/HCB0mEgHKqDycQSQs/AXv+h624ybwmQ==
X-Google-Smtp-Source: AK7set++vJmr/SzPfa6+O9EgOJ702xNHmIggfP/tFLO73cFDcKd70TkBpa+7Jt7MzWG7UOmc/P5lIOlAnYKG5d0YrRs=
X-Received: by 2002:a17:906:2f8c:b0:8ae:9f1e:a1c5 with SMTP id
 w12-20020a1709062f8c00b008ae9f1ea1c5mr479205eji.3.1675946762699; Thu, 09 Feb
 2023 04:46:02 -0800 (PST)
MIME-Version: 1.0
References: <20230125-hid-unregister-leds-v2-0-689cc62fc878@diag.uniroma1.it>
 <20230125-hid-unregister-leds-v2-1-689cc62fc878@diag.uniroma1.it> <20230209085546.ohsonlwgqb7yd3d4@mail.corp.redhat.com>
In-Reply-To: <20230209085546.ohsonlwgqb7yd3d4@mail.corp.redhat.com>
From:   Pietro Borrello <borrello@diag.uniroma1.it>
Date:   Thu, 9 Feb 2023 13:45:51 +0100
Message-ID: <CAEih1qUyxfjWo2vV4AUbwt59tKL2Lmz=4P6N4xm9ba99mQiUMA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] HID: bigben_remove: manually unregister leds
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Hanno Zulla <kontakt@hanno.de>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Roderick Colenbrander <roderick.colenbrander@sony.com>,
        Sven Eckelmann <sven@narfation.org>,
        linux-leds@vger.kernel.org,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Roderick Colenbrander <roderick@gaikai.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Feb 2023 at 09:55, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> Hi Pietro,
>
> On Jan 31 2023, Pietro Borrello wrote:
> > Unregister the LED controllers before device removal, as
> > bigben_set_led() may schedule bigben->worker after the structure has
> > been freed, causing a use-after-free.
> >
> > Fixes: 4eb1b01de5b9 ("HID: hid-bigbenff: fix race condition for scheduled work during removal")
> > Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
> > ---
> >  drivers/hid/hid-bigbenff.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/hid/hid-bigbenff.c b/drivers/hid/hid-bigbenff.c
> > index e8b16665860d..d3201b755595 100644
> > --- a/drivers/hid/hid-bigbenff.c
> > +++ b/drivers/hid/hid-bigbenff.c
> > @@ -306,9 +306,14 @@ static enum led_brightness bigben_get_led(struct led_classdev *led)
> >
> >  static void bigben_remove(struct hid_device *hid)
> >  {
> > +     int n;
> >       struct bigben_device *bigben = hid_get_drvdata(hid);
> >
> >       bigben->removed = true;
> > +     for (n = 0; n < NUM_LEDS; n++) {
> > +             if (bigben->leds[n])
> > +                     devm_led_classdev_unregister(&hid->dev, bigben->leds[n]);
> > +     }
> >       cancel_work_sync(&bigben->worker);
>
> I don't think this is the correct fix. It would seem that we are
> suddenly making the assumption that the devm mechanism would do things
> in the wrong order, when the devm_led_classdev_unregister() should be
> called *before* the devm_free() of the struct bigben_device.
>
> However, you can trigger a bug, and thus we can analyse a little bit
> further what is happening:
>
> * user calls a function on the LED
> * bigben_set_led() is called
> * .remove() is being called at roughly the same time:
>   - bigben->removed is set to true
>   - cancel_work_sync() is called
> * at that point, bigben_set_led() can not crash because
>   led_classdev_unregister() flushes all of its workers, and thus
>   prevents the call for dev_kfree(struct bigben_device)
> * but now bigben_set_led() calls schedule_work()
> * led_classdev_unregister() is now done and devm_kfree() is called for
>   struct bigben_device
> * now the led worker kicks in, and tries to access struct bigben_device
>   and derefences it to get the value of bigben->removed (and
>   bigben->report), which crashes.
>
> So without your patch, the problem seems to be that we call a
> schedule_work *after* we set bigben->removed to true and we call
> cancel_work_sync().

Yes, this matches my intuition of what is happening here.
Thank you for the extensive description.

>
> And if you look at the hid-playstation driver, you'll see that the
> schedule_work() call is encapsulated in a spinlock and a check to
> ds->output_worker_initialized.
>
> And this is why you can not reproduce on the hid-playstation driver,
> because it is guarded against scheduling a worker when the driver is
> being removed.
>
> I think I prefer a lot more the playstation solution: having to manually
> call a devm_release_free always feels wrong in a normal path. And also
> by doing so, you might paper another problem that might happen on an
> error path in probe for instance. Also, this means that the pattern you
> saw is specific to some drivers, not all depending on how they make use
> of workers.
>

Yes, I agree this would be much cleaner.

> Would you mind respinning that series with those comments?

Sure, I'll work on that!

Best regards,
Pietro
