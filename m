Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC3462A28C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 21:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbiKOUMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 15:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiKOUMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:12:50 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8A228E25
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 12:12:49 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so17925786pjc.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 12:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gtdumD+sYWXHLAIjOz1Ln7ewpDQzQUNnaW6Cow2ec04=;
        b=JlHCtrAOeWZwKner1iPH8Did5rHFqJGlg1JYo2QaNIA6GqB9qxS9n9+mTAyGpjPtwp
         Dv+A7JNiGShlCI4UE3DDHC5yvxRYowDMBzcpQvqLG7qOSgPykJQTehI1F4bJBqc37hyC
         41ORrVUaucE3KrLXEaacy0Ou8Y2lrn2x2DAAcysXHbPXMk9PwPVwDqqIAlCpRlChk4Ci
         OveMFYdZe5b6xGUYqY/jnKkN72p8KF1TDg47oWDLNWK9YgTtE3+A9UzwZ4jEtxlkoP5b
         BYQ9zpf2rqto+CyrZ69Z9ALekafoKlp1MLxhL1sV3ehM17jT5LRBCYewPpCVUFFE9Tvw
         XB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtdumD+sYWXHLAIjOz1Ln7ewpDQzQUNnaW6Cow2ec04=;
        b=nIQEC7S83yaYG/VSGYQEbDoEphPmha65t7GWjebGlSb83YnJlyzbpDO7rdQUVJ6NTo
         GDk+o6AcOVw3xQjWL87O7BlEmO5OA0jGRo/lvwXJlT++3Gfzo+0RuxGW61YViLYcaEIE
         tDOf9Oz1ddl0RBoTqX0nRTiahF1IQcljlbcTqAT/FBxec3lXK+1CJ6B83iXsE3uAI+Mm
         9NoUwX8IrD3MDTaIkUbEsqivPdhe5eax/FtBXB3D3/rLT5jA5OHvLqj4a3mrXz/SoWde
         41R7xHL6TbR5Zyj02OHXvd0D4ijg8LHbr8etXViIJKmioNScuxYpzLYNClpBMUlLZK2y
         DNpQ==
X-Gm-Message-State: ANoB5pm68dfmJWlkPP4IzbPbQUxC/KF2wrgzxrEkk9jpDOWijcDqiazG
        B+M1t8gdP5+EdqOizYCrykM=
X-Google-Smtp-Source: AA0mqf6GP3BDQNTyj5e0pDtwytZS87+8OWuWiIidZ12dRAzBQ4pKpcdT3t/pYXR4tk8u/qFeS4Yl4A==
X-Received: by 2002:a17:90b:3a8d:b0:210:5de0:f3e3 with SMTP id om13-20020a17090b3a8d00b002105de0f3e3mr77120pjb.61.1668543168753;
        Tue, 15 Nov 2022 12:12:48 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:2d36:e9a0:170b:669f])
        by smtp.gmail.com with ESMTPSA id m15-20020a656a0f000000b0045dc85c4a5fsm8164519pgu.44.2022.11.15.12.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 12:12:47 -0800 (PST)
Date:   Tue, 15 Nov 2022 12:12:44 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>,
        Matthieu Castet <castet.matthieu@free.fr>,
        Stanislaw Gruszka <stf_xl@wp.pl>, ming.lei@redhat.com,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+6bc35f3913193fe7f0d3@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in
 kernfs_next_descendant_post (2)
Message-ID: <Y3PyvDZsJUXs1uSk@google.com>
References: <000000000000c183f505eb721745@google.com>
 <20221021225228.1750-1-hdanton@sina.com>
 <Y2BRzPxroVylPLan@slm.duckdns.org>
 <Y3J8GKR905SZ84EE@bombadil.infradead.org>
 <Y3KDxpuoY4PB22vt@google.com>
 <Y3Pp7geXZRX3ltNg@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3Pp7geXZRX3ltNg@bombadil.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 11:35:10AM -0800, Luis Chamberlain wrote:
> On Mon, Nov 14, 2022 at 10:07:02AM -0800, Dmitry Torokhov wrote:
> > I do not see how moving the point where we acquire device refcount
> > around fixes anything.
> 
> The patch I posted does two things, moving the point where we acquire
> device refcount was just one so it was not clear that what I really
> wanted to be enforce a check for first, and that is that the driver
> *did* do the correct thing.
> 
> So while we can surely expect the driver to do proper device refcounting
> and waiting on device removal, buggy drivers do exist and we should
> strive to not allow UAF with them.

You can not enforce any of that from the firmware loader itself.

> 
> So something like this:
> 
> From 92c8f4465a205e744c70dcba320708f72900442e Mon Sep 17 00:00:00 2001
> From: Luis Chamberlain <mcgrof@kernel.org>
> Date: Tue, 15 Nov 2022 10:02:13 -0800
> Subject: [PATCH] firmware_loader: avoid UAF on buggy request_firmware_nowait()
>  users
> 
> request_firmware_nowait() is documented as requiring the caller to
> ensure to maintain the the reference count of @device during the
> lifetime of the call to request_firmware_nowait() and the callback.
> 
> It would seem drivers exist which don't follow these rules though,
> and things like syzbot can trigger UAF if the device gets nuked
> as request_firmware_nowait() is being called. Instead of enabling
> use UAF, defend against such improperly written drivers and complain
> about it.

I fail to see how are you defending against improperly written drivers
and in what cases you expect your check to trigger. It is impossible for 
get_device() device to fail for non-NULL device (check the code), so
your test will never trigger.

> 
> Make the documentaiton a bit clearer and give a hint as to how to easily
> accomplish device lifetime maintenance on the driver using a completion
> and a wait_for_completion().

It is not clear to me why the caller must keep reference to device. The
callback is called with struct firmware and context pointer, which may
or may not be tied to a device instance. What you want to say is that
the caller must ensure that context is valid until after callback is
invoked.

The firmware loader uses device structure itself and does acquire
a reference, so it does the right thing, but the caller is free to drop
the device reference if it chooses to do so.

So for what its worth it is a NAK from me.

> 
> Fixes: 0cfc1e1e7b534 ("firmware loader: fix device lifetime")
> Fixes: f8a4bd3456b98 ("firmware loader: embed device into firmware_priv structure")
> Cc: stable@vger.kernel.org # v2.6.36
> Reported-by: syzbot+6bc35f3913193fe7f0d3@syzkaller.appspotmail.com
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  drivers/base/firmware_loader/main.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index 7c3590fd97c2..6ac92dfdd85e 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -1118,15 +1118,16 @@ static void request_firmware_work_func(struct work_struct *work)
>   * @uevent: sends uevent to copy the firmware image if this flag
>   *	is non-zero else the firmware copy must be done manually.
>   * @name: name of firmware file
> - * @device: device for which firmware is being loaded
> + * @device: device for which firmware is being loaded. The caller must hold
> + * 	the reference count of @device during the lifetime of this routine
> + * 	and the @cont callback. This typically can be done with a completion
> + * 	and wait_for_completion prior to device teardown.
>   * @gfp: allocation flags
>   * @context: will be passed over to @cont, and
>   *	@fw may be %NULL if firmware request fails.
>   * @cont: function will be called asynchronously when the firmware
>   *	request is over.
>   *
> - *	Caller must hold the reference count of @device.
> - *
>   *	Asynchronous variant of request_firmware() for user contexts:
>   *		- sleep for as small periods as possible since it may
>   *		  increase kernel boot time of built-in device drivers
> @@ -1171,7 +1172,12 @@ request_firmware_nowait(
>  		return -EFAULT;
>  	}
>  
> -	get_device(fw_work->device);
> +	if (WARN_ON(!get_device(fw_work->device))) {
> +		module_put(module);
> +		kfree_const(fw_work->name);
> +		kfree(fw_work);
> +		return -ENODEV;
> +	}
>  	INIT_WORK(&fw_work->work, request_firmware_work_func);
>  	schedule_work(&fw_work->work);
>  	return 0;
> -- 
> 2.35.1
> 

Thanks.

-- 
Dmitry
