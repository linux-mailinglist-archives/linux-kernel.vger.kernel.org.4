Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FB16902B5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 10:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjBIJAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 04:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjBIJAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 04:00:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5382DB455
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 00:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675933191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yP8Oc/wD0SRDPHRdmmsD8nB/Qzshc+tehAXv+/O2etw=;
        b=SxjBelhM3bWmqB73Az+FXXS7SrgVlJhcbJYfZQVxRMPfUzrje5vl18k952ewSp9ujLtLYb
        Egds3xseQPQjxuPvo+FL9wiuX7ULUAtCjw42ShO1rZ8b43L7ESLDz5slOhX8zO5sirTAiV
        1EyF5Iu7W2NNxagARfXh+E7r8UpvTzQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-344-kD5fB-FoM7CLI4ap1VLSTQ-1; Thu, 09 Feb 2023 03:59:46 -0500
X-MC-Unique: kD5fB-FoM7CLI4ap1VLSTQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8B0029DD980;
        Thu,  9 Feb 2023 08:59:45 +0000 (UTC)
Received: from mail.corp.redhat.com (ovpn-192-232.brq.redhat.com [10.40.192.232])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B95974043840;
        Thu,  9 Feb 2023 08:59:42 +0000 (UTC)
Date:   Thu, 9 Feb 2023 09:59:40 +0100
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Pietro Borrello <borrello@diag.uniroma1.it>
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
Subject: Re: [PATCH v2 3/5] HID: dualsense_remove: manually unregister leds
Message-ID: <20230209085940.53mrapggf6nagkdh@mail.corp.redhat.com>
References: <20230125-hid-unregister-leds-v2-0-689cc62fc878@diag.uniroma1.it>
 <20230125-hid-unregister-leds-v2-3-689cc62fc878@diag.uniroma1.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125-hid-unregister-leds-v2-3-689cc62fc878@diag.uniroma1.it>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 31 2023, Pietro Borrello wrote:
> Unregister the LED controllers before device removal, to prevent
> unnecessary runs of dualsense_player_led_set_brightness().
> 
> Fixes: 8c0ab553b072 ("HID: playstation: expose DualSense player LEDs through LED class.")
> Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
> 
> ---
> 
> Contrary to the other patches in this series, failing to unregister
> the led controller does not results into a use-after-free thanks
> to the output_worker_initialized variable and the spinlock checks.

And so we don't need that patch (nor for hid-sony.c) because we have a
guard against scheduling a worker job when the device is being removed.

So please drop 3,4,5 from this series, they are just making the code
worse.

Cheers,
Benjamin

> 
> Changes in v2:
> - Unregister multicolor led controller
> - Clarify UAF
> - Link to v1: https://lore.kernel.org/all/20230125-hid-unregister-leds-v1-3-9a5192dcef16@diag.uniroma1.it/
> ---
>  drivers/hid/hid-playstation.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
> index 27c40894acab..f23186ca2d76 100644
> --- a/drivers/hid/hid-playstation.c
> +++ b/drivers/hid/hid-playstation.c
> @@ -1503,11 +1503,17 @@ static void dualsense_remove(struct ps_device *ps_dev)
>  {
>  	struct dualsense *ds = container_of(ps_dev, struct dualsense, base);
>  	unsigned long flags;
> +	int i;
>  
>  	spin_lock_irqsave(&ds->base.lock, flags);
>  	ds->output_worker_initialized = false;
>  	spin_unlock_irqrestore(&ds->base.lock, flags);
>  
> +	for (i = 0; i < ARRAY_SIZE(ds->player_leds); i++)
> +		devm_led_classdev_unregister(&ps_dev->hdev->dev, &ds->player_leds[i]);
> +
> +	devm_led_classdev_multicolor_unregister(&ps_dev->hdev->dev, &ds->lightbar);
> +
>  	cancel_work_sync(&ds->output_worker);
>  }
>  
> 
> -- 
> 2.25.1

