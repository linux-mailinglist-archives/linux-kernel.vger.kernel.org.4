Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA7D722D3C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 19:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbjFERFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 13:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjFERFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:05:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6D2CD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 10:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685984694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C34hXNCSf/Aa3kcMa0UcAhHq7fjDLs+0N++RxsswSxE=;
        b=IZrftJBMm7rBrHyUY6xk0heoGbpkvtStpHWDnHCJz3TCarfk3iRJoHt927FBANDluEsZvH
        o6nPbeVrufF2IkNi/5+KEc7tDElA7BlW9pkxXtU5NZkWwguLxjuzm0+4HvmLOiL1QJtjjM
        ZFYvDpW19k+KiIn/GLBbvhqCu4gPrH8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-509-CTn3gnHUPZmIQ9tWJqvg7g-1; Mon, 05 Jun 2023 13:04:49 -0400
X-MC-Unique: CTn3gnHUPZmIQ9tWJqvg7g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8DB2938117E3;
        Mon,  5 Jun 2023 17:04:48 +0000 (UTC)
Received: from mail.corp.redhat.com (unknown [10.45.224.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A5917AE4;
        Mon,  5 Jun 2023 17:04:46 +0000 (UTC)
Date:   Mon, 5 Jun 2023 19:04:43 +0200
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Mark Lord <mlord@pobox.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        Filipe =?utf-8?B?TGHDrW5z?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: [PATCH] HID: logitech-hidpp: Handle timeout differently from busy
Message-ID: <ansxam7w4aiyyqh4e2g2elnd37qfbeywkl4q4rcezasw64kqc4@2c54ppsnhegm>
References: <20230531082428.21763-1-hadess@hadess.net>
 <nycvar.YFH.7.76.2305311606160.29760@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2306031440380.29760@cbobk.fhfr.pm>
 <15bb2507-a145-7f1b-8e84-58aeb02484b9@leemhuis.info>
 <7ko33em3pqdaeghkt6wumzks6fz2lzztmqyhyzvv3kisjovmvr@mojlmkmrqlml>
 <2c10eb8f-8804-d47f-7b15-5da56ffb5414@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c10eb8f-8804-d47f-7b15-5da56ffb5414@pobox.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Jun 05 2023, Mark Lord wrote:
> 
> On 2023-06-05 10:27 AM, Benjamin Tissoires wrote:
> > 
> > On Jun 05 2023, Linux regression tracking (Thorsten Leemhuis) wrote:
> >>
> >> On 03.06.23 14:41, Jiri Kosina wrote:
> >>> On Wed, 31 May 2023, Jiri Kosina wrote:
> >>>
> >>>>> If an attempt at contacting a receiver or a device fails because the
> >>>>> receiver or device never responds, don't restart the communication, only
> >>>>> restart it if the receiver or device answers that it's busy, as originally
> >>>>> intended.
> >>>>>
> >>>>> This was the behaviour on communication timeout before commit 586e8fede795
> >>>>> ("HID: logitech-hidpp: Retry commands when device is busy").
> >>>>>
> >>>>> This fixes some overly long waits in a critical path on boot, when
> >>>>> checking whether the device is connected by getting its HID++ version.
> >>>>>
> >>>>> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> >>>>> Suggested-by: Mark Lord <mlord@pobox.com>
> >>>>> Fixes: 586e8fede795 ("HID: logitech-hidpp: Retry commands when device is busy")
> >>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217412
> >>> [...]  
> >>>>
> >>>> I have applied this even before getting confirmation from the reporters in 
> >>>> bugzilla, as it's the right thing to do anyway.
> >>>
> >>> Unfortunately it doesn't seem to cure the reported issue (while reverting 
> >>> 586e8fede79 does):
> >>
> >> BTW, remind me again: was fixing this by reverting 586e8fede79 for now a
> >> option? I guess it's not, but if I'm wrong I wonder if that might at
> >> this point be the best way forward.
> > 
> > Could be. I don't think we thought at simply reverting it because it is
> > required for some new supoprted devices because they might differ
> > slightly from what we currently supported.
> > 
> > That being said, Bastien will be unavailable for at least a week AFAIU,
> > so maybe we should revert that patch.
> > 
> >>
> >>> https://bugzilla.kernel.org/show_bug.cgi?id=217523#c2
> 
> Pardon me, but I don't understand what that "retry" loop
> is even attempting to do inside function hidpp_send_message_sync().
> 
> It appears to unconditionally loop until:
>    (1) the __hidpp_send_report() fails,
> or (2) it gets a HIDPP_ERROR,
> or (3) it gets a HIDPP20_ERROR other than HIDPP20_ERROR_BUSY,
> or (4) until it has looped 3 times, which appears to be the normal exit.
> 
> It doesn't seem to have any provision to exit the loop earlier on "success"
> (whatever that is).
> 
> And so when it finally does exit after the 3 iterations,
> it then returns the last value of "ret",
> which will be zero from the __hidpp_send_report() call,
> or sometimes the most recent non-BUSY HIDPP20_ERROR seen.
> 
> Obviously I'm missing something, as otherwise this code would never have
> passed review and made it into the Linux kernel in the first place.  Right?

Ouch, very much ouch :(

So that one is on me, sorry, I completely missed that and trusted the
local tests. We are human and can make mistakes. And TBH a lot of people
have been staring at this code for a while now without noticing that.

Would you mind giving a shot at the following (untested) patch:

---
From 7d03a6b765571d7c518c85e7e74f6f9d498fa354 Mon Sep 17 00:00:00 2001
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Mon, 5 Jun 2023 18:56:36 +0200
Subject: [PATCH] HID: hidpp: terminate retry loop on success

It seems we forgot the normal case to terminate the retry loop,
making us asking 3 times each command, which is probably a little bit
too much.

And remove the ugly "goto exit" that can be replaced by a simpler "break"

Fixes: 586e8fede795 ("HID: logitech-hidpp: Retry commands when device is busy")
Suggested-by: Mark Lord <mlord@pobox.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-logitech-hidpp.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 2246044b1639..5e1a412fd28f 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -286,7 +286,7 @@ static int hidpp_send_message_sync(struct hidpp_device *hidpp,
 	struct hidpp_report *message,
 	struct hidpp_report *response)
 {
-	int ret;
+	int ret = -1;
 	int max_retries = 3;
 
 	mutex_lock(&hidpp->send_mutex);
@@ -300,13 +300,13 @@ static int hidpp_send_message_sync(struct hidpp_device *hidpp,
 	 */
 	*response = *message;
 
-	for (; max_retries != 0; max_retries--) {
+	for (; max_retries != 0 && ret; max_retries--) {
 		ret = __hidpp_send_report(hidpp->hid_dev, message);
 
 		if (ret) {
 			dbg_hid("__hidpp_send_report returned err: %d\n", ret);
 			memset(response, 0, sizeof(struct hidpp_report));
-			goto exit;
+			break;
 		}
 
 		if (!wait_event_timeout(hidpp->wait, hidpp->answer_available,
@@ -314,14 +314,14 @@ static int hidpp_send_message_sync(struct hidpp_device *hidpp,
 			dbg_hid("%s:timeout waiting for response\n", __func__);
 			memset(response, 0, sizeof(struct hidpp_report));
 			ret = -ETIMEDOUT;
-			goto exit;
+			break;
 		}
 
 		if (response->report_id == REPORT_ID_HIDPP_SHORT &&
 		    response->rap.sub_id == HIDPP_ERROR) {
 			ret = response->rap.params[1];
 			dbg_hid("%s:got hidpp error %02X\n", __func__, ret);
-			goto exit;
+			break;
 		}
 
 		if ((response->report_id == REPORT_ID_HIDPP_LONG ||
@@ -330,13 +330,12 @@ static int hidpp_send_message_sync(struct hidpp_device *hidpp,
 			ret = response->fap.params[1];
 			if (ret != HIDPP20_ERROR_BUSY) {
 				dbg_hid("%s:got hidpp 2.0 error %02X\n", __func__, ret);
-				goto exit;
+				break;
 			}
 			dbg_hid("%s:got busy hidpp 2.0 error %02X, retrying\n", __func__, ret);
 		}
 	}
 
-exit:
 	mutex_unlock(&hidpp->send_mutex);
 	return ret;
 
-- 
2.40.1

---

> 
> What is this code trying to do?  And what am I not seeing?

It was supposed to retry on specific errors only, but it was retrying
on success too...

Cheers,
Benjamin

