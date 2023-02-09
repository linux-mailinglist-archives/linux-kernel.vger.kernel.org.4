Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6C869029D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 09:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjBII4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 03:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBII4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 03:56:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4355953E6F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 00:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675932956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n6TU5rKWodC20RYMJYTUm5vvi5L1u7IqmgVDY3KRHF8=;
        b=BB4mdMiFu90stRqqmHyAcqnhtqQ1pyAGamkCcjx81Ml4kYnRl2buSwIfnxo+h1S+rI3VCa
        fpNje0fYvRePofEOh4aFQRgIdfiDoObQzw4CWJH1k1re1zdP802W568iaBFhG5ZrPZAsYz
        9baj+qjh39M4J5vsOes/df6+Rs41pUU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-462-71TRLXiHMAKoo7zCMdTE9g-1; Thu, 09 Feb 2023 03:55:53 -0500
X-MC-Unique: 71TRLXiHMAKoo7zCMdTE9g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33DB7101A52E;
        Thu,  9 Feb 2023 08:55:52 +0000 (UTC)
Received: from mail.corp.redhat.com (ovpn-192-232.brq.redhat.com [10.40.192.232])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EA311492B00;
        Thu,  9 Feb 2023 08:55:48 +0000 (UTC)
Date:   Thu, 9 Feb 2023 09:55:46 +0100
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
Subject: Re: [PATCH v2 1/5] HID: bigben_remove: manually unregister leds
Message-ID: <20230209085546.ohsonlwgqb7yd3d4@mail.corp.redhat.com>
References: <20230125-hid-unregister-leds-v2-0-689cc62fc878@diag.uniroma1.it>
 <20230125-hid-unregister-leds-v2-1-689cc62fc878@diag.uniroma1.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125-hid-unregister-leds-v2-1-689cc62fc878@diag.uniroma1.it>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pietro,

On Jan 31 2023, Pietro Borrello wrote:
> Unregister the LED controllers before device removal, as
> bigben_set_led() may schedule bigben->worker after the structure has
> been freed, causing a use-after-free.
> 
> Fixes: 4eb1b01de5b9 ("HID: hid-bigbenff: fix race condition for scheduled work during removal")
> Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
> ---
>  drivers/hid/hid-bigbenff.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/hid/hid-bigbenff.c b/drivers/hid/hid-bigbenff.c
> index e8b16665860d..d3201b755595 100644
> --- a/drivers/hid/hid-bigbenff.c
> +++ b/drivers/hid/hid-bigbenff.c
> @@ -306,9 +306,14 @@ static enum led_brightness bigben_get_led(struct led_classdev *led)
>  
>  static void bigben_remove(struct hid_device *hid)
>  {
> +	int n;
>  	struct bigben_device *bigben = hid_get_drvdata(hid);
>  
>  	bigben->removed = true;
> +	for (n = 0; n < NUM_LEDS; n++) {
> +		if (bigben->leds[n])
> +			devm_led_classdev_unregister(&hid->dev, bigben->leds[n]);
> +	}
>  	cancel_work_sync(&bigben->worker);

I don't think this is the correct fix. It would seem that we are
suddenly making the assumption that the devm mechanism would do things
in the wrong order, when the devm_led_classdev_unregister() should be
called *before* the devm_free() of the struct bigben_device.

However, you can trigger a bug, and thus we can analyse a little bit
further what is happening:

* user calls a function on the LED
* bigben_set_led() is called
* .remove() is being called at roughly the same time:
  - bigben->removed is set to true
  - cancel_work_sync() is called
* at that point, bigben_set_led() can not crash because
  led_classdev_unregister() flushes all of its workers, and thus
  prevents the call for dev_kfree(struct bigben_device)
* but now bigben_set_led() calls schedule_work()
* led_classdev_unregister() is now done and devm_kfree() is called for
  struct bigben_device
* now the led worker kicks in, and tries to access struct bigben_device
  and derefences it to get the value of bigben->removed (and
  bigben->report), which crashes.

So without your patch, the problem seems to be that we call a
schedule_work *after* we set bigben->removed to true and we call
cancel_work_sync().

And if you look at the hid-playstation driver, you'll see that the
schedule_work() call is encapsulated in a spinlock and a check to
ds->output_worker_initialized.

And this is why you can not reproduce on the hid-playstation driver,
because it is guarded against scheduling a worker when the driver is
being removed.

I think I prefer a lot more the playstation solution: having to manually
call a devm_release_free always feels wrong in a normal path. And also
by doing so, you might paper another problem that might happen on an
error path in probe for instance. Also, this means that the pattern you
saw is specific to some drivers, not all depending on how they make use
of workers.

Would you mind respinning that series with those comments?

Cheers,
Benjamin


>  	hid_hw_stop(hid);
>  }
> 
> -- 
> 2.25.1

