Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F19B6FE438
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235547AbjEJSvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235765AbjEJSvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:51:42 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6A761B3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 11:51:33 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2ac785015d7so84702821fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 11:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683744692; x=1686336692;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cFGqFppUzpxmVkjUZvC53QtHHywz1Qo6h6Pn4F/DeOo=;
        b=dRetkPZ+CeYM6y+N3A8Ue6DO/zDRu6faoqdZKsAf8J0KFGPmPjyIb/EaIzvvHRFc7i
         gRqproQ/h3YhAJewP4g9I0vsejKFo309PgYdV6Po+9PH+QxCEcEYV6wH/4rbzbRccguZ
         6lJcN2QJTjEmkQhVUIDgAwqEac85hDIektPK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683744692; x=1686336692;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFGqFppUzpxmVkjUZvC53QtHHywz1Qo6h6Pn4F/DeOo=;
        b=eMsHjg49tPGm9UX1E4OyrBGu5hUQjf0bdwmRz/AAYercYyufg1CjG/XnL7XuZ0T22J
         jnHORH/TVhkfd5B43T+prg6MMTradQvUOF6O4EG7ZHd3DAYTtjwQq7yvYyVGOr3LN2HU
         PcWsu+lI3OxqmXp8edS06bAJXxuKpR+UKAtD12+Nq4ZHSMLyBp5DDjKert/QQVrN+9et
         oSC58XwZEfVPoPUeGcKOa+E7zGq+0TbxhlFQ2PpuGqn1RixTSjmdnluRFU0J6DNfcHXw
         lCSTmfAk6QaKeTwvSta0KrzkolNqJSy16mwyLg74/7ZkZD19ct339VBktCP+uCYm2lWt
         OHiA==
X-Gm-Message-State: AC+VfDwgJwgO00lBuOzmV/BxX3MJo+/O3Uxy8J5GLQ4bc2RchFrQN0N/
        CKinhFpuWt/Wet+H8d+gfuRFq6+oD7Z2+rFhgGxwNg==
X-Google-Smtp-Source: ACHHUZ7cJmHdcg31stA7TUYM2h7LeBE8zcTDEECiPZW7O5XhIGQzsrGE5q/Ubu5bYuEnl7rZE2HLL97g1M62iyv0Swk=
X-Received: by 2002:a2e:878c:0:b0:2ad:8cc6:135a with SMTP id
 n12-20020a2e878c000000b002ad8cc6135amr2563024lji.33.1683744691683; Wed, 10
 May 2023 11:51:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 May 2023 11:51:31 -0700
MIME-Version: 1.0
In-Reply-To: <ZFWZ785FRHDii/+5@google.com>
References: <20230505232417.1377393-1-swboyd@chromium.org> <ZFWZ785FRHDii/+5@google.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 10 May 2023 11:51:31 -0700
Message-ID: <CAE-0n521MhmdWjEb0-xwnPLQz07bMCGyXokZ3L87azYcw6_C_Q@mail.gmail.com>
Subject: Re: [PATCH] HID: google: Don't use devm for hid_hw_stop()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Torokhov (2023-05-05 17:06:07)
> On Fri, May 05, 2023 at 04:24:16PM -0700, Stephen Boyd wrote:
> >
> ...
> > Unfortunately, the hid google hammer driver hand rolls a devm function
> > to call hid_hw_stop() when the driver is unbound and implements an
> > hid_driver::remove() function. The driver core doesn't call the devm
> > release functions until _after_ the bus unbinds the driver, so the order
> > of operations is like this:
>
> Excellent analysis, but the problem is not limited to the hammer driver
> (potentially) and shalt be dealt with appropriately, at the HID bus
> level.

Thanks. I thought of the bus level approach as well, but I was trying to
keep the fix isolated to the driver that had the problem. I'd like to
get the fix into the stable kernel, as this fixes a regression
introduced by commit d950db3f80a8 ("HID: google: switch to devm when
registering keyboard backlight LED") in v5.18.

Is the bus level approach going to be acceptable as a stable backport?

Is it a problem to call hid_hw_stop() directly? I suppose for the
hid-google-hammer driver we don't want to leave the led sysfs node
hanging around after the hid_hw_stop() function has been called either,
so some sort of forced ejection of the devm led device is needed and the
bus level approach helps there.

I was curious to see if anything else had this problem so I did this
poor grep to find code that isn't calling hid_hw_stop() from probe or
remove:

  git grep -W hid_hw_stop | grep .c= | grep -v probe | grep -v remove

and I got this list (minus hid core which doesn't matter):

 drivers/hid/hid-google-hammer.c=static void hammer_stop(void *hdev)
 drivers/hid/hid-mcp2221.c=static void mcp2221_hid_unregister(void *ptr)
 drivers/hid/hid-wiimote-core.c=static void wiimote_destroy(struct
wiimote_data *wdata)
 drivers/hid/wacom_sys.c=static int wacom_parse_and_register(struct
wacom *wacom, bool wireless)
 drivers/hid/wacom_sys.c=static void wacom_wireless_work(struct
work_struct *work)
 drivers/hid/wacom_sys.c=static void wacom_mode_change_work(struct
work_struct *work)

The wacom_sys.c ones look OK because they're during workqueues that are
probably flushed, and wiimote_destroy() is called from an error path or
driver remove, so it is also OK. But mcp2221_hid_unregister() has the
same problem.

If you look at drivers/hid/hid-mcp2221.c you'll see this comment above
mcp2221_remove() too:

 /* This is needed to be sure hid_hw_stop() isn't called twice by the
subsystem */
 static void mcp2221_remove(struct hid_device *hdev)

which is kinda weird. Why can't we have a devm_hid_hw_start() API that
tells the hid bus to not call hid_hw_stop() at all in
hid_device_remove()? That would allow us to avoid this pitfall where
everything is moved to devm and the driver has no remove function at all
and we forget to populate an empty one. Instead, the bus layer can know
that hardware will be stopped with devm later.

>
> Actually, it is not even limited to HID, but exists in most buses with
> non-trivial ->remove() implementation. For example I fixed similar issue
> in I2C in 5b5475826c52 ("i2c: ensure timely release of driver-allocated
> resources"). I tried fixing it in SPI but Mark has some objections, and
> wanted to fix it in the driver core, so I was thinking about it and then
> dropped the ball. At this time I do not think fixing it at driver core
> makes logic any clearer, so I think we just need to fix a handful of
> buses.

Do you have a link to that discussion?

-------

This got me thinking that maybe both of these approaches are wrong.
Maybe the call to hid_close_report() should be removed from
hid_device_remove() instead.

The device is being removed from the bus when hid_device_remove() is
called, but it hasn't been released yet. Other devices like the hidinput
device are referencing the hdev device because they set the hdev as
their parent. Basically, child devices are still bound to some sort of
driver or subsystem when the parent hdev is unbound from its driver,
leading to a state where the child drivers could still access the hdev
while it is being destroyed. If we remove the hid_close_report() call
from this function it will eventually be called by hid_device_release()
when the last reference to the device is dropped, i.e. when the child
devices all get destroyed. In the case of hid-google-hammer, that would
be when hid_hw_stop() is called from the devm release function by driver
core.

The benefit of this approach is that we don't allocate a devres group
for all the hid devices when only two drivers need it. The possible
downside is that we keep the report around while the device exists but
has no driver bound to it.

Here's a totally untested patch for that.

---8<----
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 22623eb4f72f..93905e200cae 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1211,8 +1211,8 @@ int hid_open_report(struct hid_device *device)
 		hid_parser_reserved
 	};

-	if (WARN_ON(device->status & HID_STAT_PARSED))
-		return -EBUSY;
+	if (device->status & HID_STAT_PARSED)
+		hid_close_report(device);

 	start = device->dev_rdesc;
 	if (WARN_ON(!start))
@@ -2662,7 +2662,6 @@ static void hid_device_remove(struct device *dev)
 			hdrv->remove(hdev);
 		else /* default remove */
 			hid_hw_stop(hdev);
-		hid_close_report(hdev);
 		hdev->driver = NULL;
 	}
