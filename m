Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83906981B6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjBORQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjBORQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:16:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301E225963
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 09:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676481348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N2aYOOiv3MCMF+ppBroJDJcViaHR7pn3uVnoU3fQha0=;
        b=cDsglyPFYzLCa7qpan9FoDQvI36KvJvJlQ4lQRqrQAKAE1//YlQOgT24XAyIW5Jerai3Qu
        6nCLD7ATNMgSgDzhdmj8B+Dv/yBlj2JEh4kSvPVbc3MUTknhtEJ+1nS9uy/dESzitSmWRz
        6p0NVUp1vNp4HMalu1BMolbv38xUlZg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-218-MeHWDk9XN3qOrWz4HE_7NA-1; Wed, 15 Feb 2023 12:15:43 -0500
X-MC-Unique: MeHWDk9XN3qOrWz4HE_7NA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7EE05183B3C1;
        Wed, 15 Feb 2023 17:15:42 +0000 (UTC)
Received: from mail.corp.redhat.com (ovpn-194-191.brq.redhat.com [10.40.194.191])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DAE1018EC1;
        Wed, 15 Feb 2023 17:15:40 +0000 (UTC)
Date:   Wed, 15 Feb 2023 18:15:38 +0100
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Rishi Gupta <gupt21@gmail.com>, Jiri Kosina <jikos@kernel.org>,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: mcp-2221: prevent UAF in delayed work
Message-ID: <20230215171538.dnpl2gbwb77ffurf@mail.corp.redhat.com>
References: <20230215-wip-mcp2221-v1-1-d7d1da261a5c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215-wip-mcp2221-v1-1-d7d1da261a5c@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 15 2023, Benjamin Tissoires via B4 Submission Endpoint wrote:
> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> If the device is plugged/unplugged without giving time for mcp_init_work()
> to complete, we might kick in the devm free code path and thus have
> unavailable struct mcp_2221 while in delayed work.
> 
> Add a boolean and a spinlock to prevent scheduling the deleyed work if
> we are in the operation of removing the device.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
> Similar to Pietro's series, we can see the pattern in hid-mcp2221,
> except that this time the ledclass is not involved.
> 
> Link: https://lore.kernel.org/linux-input/20230125-hid-unregister-leds-v4-5-7860c5763c38@diag.uniroma1.it/
> ---
>  drivers/hid/hid-mcp2221.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
> index e61dd039354b..de8b988f4a48 100644
> --- a/drivers/hid/hid-mcp2221.c
> +++ b/drivers/hid/hid-mcp2221.c
> @@ -95,6 +95,8 @@ struct mcp2221 {
>  	struct mutex lock;
>  	struct completion wait_in_report;
>  	struct delayed_work init_work;
> +	spinlock_t init_work_lock;
> +	bool removing;
>  	u8 *rxbuf;
>  	u8 txbuf[64];
>  	int rxbuf_idx;
> @@ -922,6 +924,14 @@ static void mcp2221_hid_unregister(void *ptr)
>  /* This is needed to be sure hid_hw_stop() isn't called twice by the subsystem */
>  static void mcp2221_remove(struct hid_device *hdev)
>  {
> +	struct mcp2221 *mcp = hid_get_drvdata(hdev);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&mcp->init_work_lock, flags);
> +	mcp->removing = true;
> +	spin_unlock_irqrestore(&mcp->init_work_lock, flags);
> +
> +	cancel_delayed_work_sync(&mcp->init_work);

Actually, given that the only re-submission of this work is from the
work item itself, I wonder if I really need the boolean and the
spinlock. cancel_delayed_work_sync() might already prevent a
resubmission by itself as it does in cancel_work_sync().

Cheers,
Benjamin

>  }
>  
>  #if IS_REACHABLE(CONFIG_IIO)
> @@ -1040,6 +1050,7 @@ static void mcp_init_work(struct work_struct *work)
>  	struct mcp2221_iio *data;
>  	static int retries = 5;
>  	int ret, num_channels;
> +	unsigned long flags;
>  
>  	hid_hw_power(mcp->hdev, PM_HINT_FULLON);
>  	mutex_lock(&mcp->lock);
> @@ -1090,7 +1101,10 @@ static void mcp_init_work(struct work_struct *work)
>  		return;
>  
>  	/* Device is not ready to read SRAM or FLASH data, try again */
> -	schedule_delayed_work(&mcp->init_work, msecs_to_jiffies(100));
> +	spin_lock_irqsave(&mcp->init_work_lock, flags);
> +	if (!mcp->removing)
> +		schedule_delayed_work(&mcp->init_work, msecs_to_jiffies(100));
> +	spin_unlock_irqrestore(&mcp->init_work_lock, flags);
>  }
>  #endif
>  
> @@ -1131,6 +1145,7 @@ static int mcp2221_probe(struct hid_device *hdev,
>  	}
>  
>  	mutex_init(&mcp->lock);
> +	spin_lock_init(&mcp->init_work_lock);
>  	init_completion(&mcp->wait_in_report);
>  	hid_set_drvdata(hdev, mcp);
>  	mcp->hdev = hdev;
> 
> ---
> base-commit: d883fd110dc17308a1506c5bf17e00ce9fe7b2a2
> change-id: 20230215-wip-mcp2221-979d4115efb5
> 
> Best regards,
> -- 
> Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 

