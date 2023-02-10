Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2116920D0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 15:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjBJO1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 09:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjBJO1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:27:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9007D19685
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676039209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gwSuRObxa9mbaORD/+4MDVXikhy2F5XiABD2IkJjms8=;
        b=cV0WGO69SA8e0xjhuvpu77/zQ16g1/3soZJnuwjVhVBSxAMiQH2N31yuSAmRDbtnCR/MFr
        stxjxbTEclIxa9dRIZDY/eG8p/SuNbrAmkCq8YYOBvG0onWQuQQx9vInN5UfCq9tJZzsdG
        1Ch7cPjlKYvXBMLpmOx3lz6ftTiMFxc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-rN9uQs1eM9y1jIDD2gouhw-1; Fri, 10 Feb 2023 09:26:45 -0500
X-MC-Unique: rN9uQs1eM9y1jIDD2gouhw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C24A81C05AF6;
        Fri, 10 Feb 2023 14:26:44 +0000 (UTC)
Received: from mail.corp.redhat.com (ovpn-195-1.brq.redhat.com [10.40.195.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 81DBD2166B29;
        Fri, 10 Feb 2023 14:26:38 +0000 (UTC)
Date:   Fri, 10 Feb 2023 15:26:34 +0100
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Pietro Borrello <borrello@diag.uniroma1.it>
Cc:     Jiri Kosina <jikos@kernel.org>, Hanno Zulla <kontakt@hanno.de>,
        Carlo Caione <carlo@endlessm.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Roderick Colenbrander <roderick@gaikai.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] HID: bigben: use spinlock to safely schedule
 workers
Message-ID: <20230210142634.2exh6mvbvysy3hqo@mail.corp.redhat.com>
References: <20230125-hid-unregister-leds-v3-0-0a52ac225e00@diag.uniroma1.it>
 <20230125-hid-unregister-leds-v3-1-0a52ac225e00@diag.uniroma1.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125-hid-unregister-leds-v3-1-0a52ac225e00@diag.uniroma1.it>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 09 2023, Pietro Borrello wrote:
> Use spinlocks to deal with workers introducing a wrapper
> bigben_schedule_work(), and several spinlock checks.
> Otherwise, bigben_set_led() may schedule bigben->worker after the
> structure has been freed, causing a use-after-free.
> 
> Fixes: 4eb1b01de5b9 ("HID: hid-bigbenff: fix race condition for scheduled work during removal")
> Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
> ---
>  drivers/hid/hid-bigbenff.c | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hid/hid-bigbenff.c b/drivers/hid/hid-bigbenff.c
> index e8b16665860d..28769aa7fed6 100644
> --- a/drivers/hid/hid-bigbenff.c
> +++ b/drivers/hid/hid-bigbenff.c
> @@ -174,6 +174,7 @@ static __u8 pid0902_rdesc_fixed[] = {
>  struct bigben_device {
>  	struct hid_device *hid;
>  	struct hid_report *report;
> +	spinlock_t lock;
>  	bool removed;
>  	u8 led_state;         /* LED1 = 1 .. LED4 = 8 */
>  	u8 right_motor_on;    /* right motor off/on 0/1 */
> @@ -184,15 +185,24 @@ struct bigben_device {
>  	struct work_struct worker;
>  };
>  
> +static inline void bigben_schedule_work(struct bigben_device *bigben)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&bigben->lock, flags);
> +	if (!bigben->removed)
> +		schedule_work(&bigben->worker);
> +	spin_unlock_irqrestore(&bigben->lock, flags);
> +}
>  
>  static void bigben_worker(struct work_struct *work)
>  {
>  	struct bigben_device *bigben = container_of(work,
>  		struct bigben_device, worker);
>  	struct hid_field *report_field = bigben->report->field[0];
> +	unsigned long flags;
>  
> -	if (bigben->removed || !report_field)

You are removing an important test here: if (!report_field), please keep
it.

> -		return;
> +	spin_lock_irqsave(&bigben->lock, flags);
>  
>  	if (bigben->work_led) {
>  		bigben->work_led = false;
> @@ -219,6 +229,8 @@ static void bigben_worker(struct work_struct *work)
>  		report_field->value[7] = 0x00; /* padding */
>  		hid_hw_request(bigben->hid, bigben->report, HID_REQ_SET_REPORT);
>  	}
> +
> +	spin_unlock_irqrestore(&bigben->lock, flags);

Ouch, having hid_hw_request() called whithin a spinlock is definitely not
something that should be done.

However, the spinlock should be protecting 2 kinds of things:
- any access to any value of struct bigben_device, but in an atomic way
  (i.e. copy everything you need locally in a spinlock, then release it
  and never read that struct again in that function).
- the access to bigben->removed, which should be checked only in
  bigben_schedule_work() and in the .remove() function.

Please note that this is what the playstation driver does: it prepares
the report under the spinlock (which is really fast) before sending the
report to the device which can be slow and be interrupted.

With that being said, it is clear that we need 2 patches for this one:
- the first one introduces the spinlock and protects the concurrent
  accesses to struct bigben_device (which is roughly everything below
  with the changes I just said)
- the second one introduces bigben_schedule_work() and piggy backs on
  top of that new lock.

Cheers,
Benjamin

>  }
>  
>  static int hid_bigben_play_effect(struct input_dev *dev, void *data,
> @@ -228,6 +240,7 @@ static int hid_bigben_play_effect(struct input_dev *dev, void *data,
>  	struct bigben_device *bigben = hid_get_drvdata(hid);
>  	u8 right_motor_on;
>  	u8 left_motor_force;
> +	unsigned long flags;
>  
>  	if (!bigben) {
>  		hid_err(hid, "no device data\n");
> @@ -242,10 +255,13 @@ static int hid_bigben_play_effect(struct input_dev *dev, void *data,
>  
>  	if (right_motor_on != bigben->right_motor_on ||
>  			left_motor_force != bigben->left_motor_force) {
> +		spin_lock_irqsave(&bigben->lock, flags);
>  		bigben->right_motor_on   = right_motor_on;
>  		bigben->left_motor_force = left_motor_force;
>  		bigben->work_ff = true;
> -		schedule_work(&bigben->worker);
> +		spin_unlock_irqrestore(&bigben->lock, flags);
> +
> +		bigben_schedule_work(bigben);
>  	}
>  
>  	return 0;
> @@ -259,6 +275,7 @@ static void bigben_set_led(struct led_classdev *led,
>  	struct bigben_device *bigben = hid_get_drvdata(hid);
>  	int n;
>  	bool work;
> +	unsigned long flags;
>  
>  	if (!bigben) {
>  		hid_err(hid, "no device data\n");
> @@ -267,6 +284,7 @@ static void bigben_set_led(struct led_classdev *led,
>  
>  	for (n = 0; n < NUM_LEDS; n++) {
>  		if (led == bigben->leds[n]) {
> +			spin_lock_irqsave(&bigben->lock, flags);
>  			if (value == LED_OFF) {
>  				work = (bigben->led_state & BIT(n));
>  				bigben->led_state &= ~BIT(n);
> @@ -274,10 +292,11 @@ static void bigben_set_led(struct led_classdev *led,
>  				work = !(bigben->led_state & BIT(n));
>  				bigben->led_state |= BIT(n);
>  			}
> +			spin_unlock_irqrestore(&bigben->lock, flags);
>  
>  			if (work) {
>  				bigben->work_led = true;
> -				schedule_work(&bigben->worker);
> +				bigben_schedule_work(bigben);
>  			}
>  			return;
>  		}
> @@ -307,8 +326,12 @@ static enum led_brightness bigben_get_led(struct led_classdev *led)
>  static void bigben_remove(struct hid_device *hid)
>  {
>  	struct bigben_device *bigben = hid_get_drvdata(hid);
> +	unsigned long flags;
>  
> +	spin_lock_irqsave(&bigben->lock, flags);
>  	bigben->removed = true;
> +	spin_unlock_irqrestore(&bigben->lock, flags);
> +
>  	cancel_work_sync(&bigben->worker);
>  	hid_hw_stop(hid);
>  }
> @@ -362,6 +385,7 @@ static int bigben_probe(struct hid_device *hid,
>  	set_bit(FF_RUMBLE, hidinput->input->ffbit);
>  
>  	INIT_WORK(&bigben->worker, bigben_worker);
> +	spin_lock_init(&bigben->lock);
>  
>  	error = input_ff_create_memless(hidinput->input, NULL,
>  		hid_bigben_play_effect);
> @@ -402,7 +426,7 @@ static int bigben_probe(struct hid_device *hid,
>  	bigben->left_motor_force = 0;
>  	bigben->work_led = true;
>  	bigben->work_ff = true;
> -	schedule_work(&bigben->worker);
> +	bigben_schedule_work(bigben);
>  
>  	hid_info(hid, "LED and force feedback support for BigBen gamepad\n");
>  
> 
> -- 
> 2.25.1
> 

