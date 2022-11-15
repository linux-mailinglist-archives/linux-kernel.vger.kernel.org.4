Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A6262A203
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 20:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiKOTfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 14:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiKOTfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 14:35:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E23B7D7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 11:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mgO4rRXdMPTGi5Q4zNT8/529jd3tvagEvnNVftk04JQ=; b=GfkGU3YspjFGPAC0f9Ozgqdh1D
        aVpTM4IoJS3HLfE0vvX9qCO4Kg07XgVH3nAp3xcedmUW/H1Xou0hf5mUakK2uxou4E0KgRGNv+xr0
        yLw0ArbpZp8YKkQXoWI2cxxeYY9l9dRqwMA1SRF7wFOJ689kviPqUGY0ia22CiW2jkJLfFMYzhUvv
        XbQgMGyzM7wnz1wLTQlrO7Xw//l/g7r8IR3QsGwrdv3H2QU/VDbggzngdCeok0DN4MfBdA0bgKJrq
        ujEO1QMWJfMaQePE9QFRsHdVjHQkDVEm15CLIdb5lT5dBI9S4KcHEG4IOrHUQx3ovqsY23Lpy1pZS
        Y1xID40g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ov1iA-00EJQ3-Ve; Tue, 15 Nov 2022 19:35:10 +0000
Date:   Tue, 15 Nov 2022 11:35:10 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Matthieu Castet <castet.matthieu@free.fr>,
        Stanislaw Gruszka <stf_xl@wp.pl>, ming.lei@redhat.com,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+6bc35f3913193fe7f0d3@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in
 kernfs_next_descendant_post (2)
Message-ID: <Y3Pp7geXZRX3ltNg@bombadil.infradead.org>
References: <000000000000c183f505eb721745@google.com>
 <20221021225228.1750-1-hdanton@sina.com>
 <Y2BRzPxroVylPLan@slm.duckdns.org>
 <Y3J8GKR905SZ84EE@bombadil.infradead.org>
 <Y3KDxpuoY4PB22vt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3KDxpuoY4PB22vt@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 10:07:02AM -0800, Dmitry Torokhov wrote:
> I do not see how moving the point where we acquire device refcount
> around fixes anything.

The patch I posted does two things, moving the point where we acquire
device refcount was just one so it was not clear that what I really
wanted to be enforce a check for first, and that is that the driver
*did* do the correct thing.

So while we can surely expect the driver to do proper device refcounting
and waiting on device removal, buggy drivers do exist and we should
strive to not allow UAF with them.

So something like this:

From 92c8f4465a205e744c70dcba320708f72900442e Mon Sep 17 00:00:00 2001
From: Luis Chamberlain <mcgrof@kernel.org>
Date: Tue, 15 Nov 2022 10:02:13 -0800
Subject: [PATCH] firmware_loader: avoid UAF on buggy request_firmware_nowait()
 users

request_firmware_nowait() is documented as requiring the caller to
ensure to maintain the the reference count of @device during the
lifetime of the call to request_firmware_nowait() and the callback.

It would seem drivers exist which don't follow these rules though,
and things like syzbot can trigger UAF if the device gets nuked
as request_firmware_nowait() is being called. Instead of enabling
use UAF, defend against such improperly written drivers and complain
about it.

Make the documentaiton a bit clearer and give a hint as to how to easily
accomplish device lifetime maintenance on the driver using a completion
and a wait_for_completion().

Fixes: 0cfc1e1e7b534 ("firmware loader: fix device lifetime")
Fixes: f8a4bd3456b98 ("firmware loader: embed device into firmware_priv structure")
Cc: stable@vger.kernel.org # v2.6.36
Reported-by: syzbot+6bc35f3913193fe7f0d3@syzkaller.appspotmail.com
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/base/firmware_loader/main.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 7c3590fd97c2..6ac92dfdd85e 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -1118,15 +1118,16 @@ static void request_firmware_work_func(struct work_struct *work)
  * @uevent: sends uevent to copy the firmware image if this flag
  *	is non-zero else the firmware copy must be done manually.
  * @name: name of firmware file
- * @device: device for which firmware is being loaded
+ * @device: device for which firmware is being loaded. The caller must hold
+ * 	the reference count of @device during the lifetime of this routine
+ * 	and the @cont callback. This typically can be done with a completion
+ * 	and wait_for_completion prior to device teardown.
  * @gfp: allocation flags
  * @context: will be passed over to @cont, and
  *	@fw may be %NULL if firmware request fails.
  * @cont: function will be called asynchronously when the firmware
  *	request is over.
  *
- *	Caller must hold the reference count of @device.
- *
  *	Asynchronous variant of request_firmware() for user contexts:
  *		- sleep for as small periods as possible since it may
  *		  increase kernel boot time of built-in device drivers
@@ -1171,7 +1172,12 @@ request_firmware_nowait(
 		return -EFAULT;
 	}
 
-	get_device(fw_work->device);
+	if (WARN_ON(!get_device(fw_work->device))) {
+		module_put(module);
+		kfree_const(fw_work->name);
+		kfree(fw_work);
+		return -ENODEV;
+	}
 	INIT_WORK(&fw_work->work, request_firmware_work_func);
 	schedule_work(&fw_work->work);
 	return 0;
-- 
2.35.1

