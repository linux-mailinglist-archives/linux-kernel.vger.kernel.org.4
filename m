Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022BA69B32E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 20:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjBQTcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 14:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBQTcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 14:32:52 -0500
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDCB32CEC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 11:32:11 -0800 (PST)
Received: (wp-smtpd smtp.tlen.pl 3647 invoked from network); 17 Feb 2023 20:31:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1676662314; bh=NeTY7K463bS1HXo6rBORUcYtIDgVg1kEicOY8i9MBK0=;
          h=From:To:Cc:Subject;
          b=tAhhTWIPIs9pbNtQKVt+dluNPwGloWMrjUmwHsqlxPSFQJiWl0rUKrUvq62xkkBRB
           jpgfpOmXdzIqRonD/6FzTtVqcv/R86pVTlW0uuf0O9ufoO3CSN5OPi2zMxszp469d3
           4XHDd4PGNxwBjP4wfEMx4q7qbiiXeW+PN+QtHpzk=
Received: from aafq148.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.146.148])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <brian.gix@intel.com>; 17 Feb 2023 20:31:54 +0100
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     brian.gix@intel.com, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Luiz Von Dentz <luiz.von.dentz@intel.com>
Subject: Re: [PATCH 1/1] Bluetooth: Convert MSFT filter HCI cmd to hci_sync
Date:   Fri, 17 Feb 2023 20:31:42 +0100
Message-Id: <20230217193142.6954-1-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <8ca5bf9ce1f544096a3ff88b743381bc9e60a76d.camel@intel.com>
References: <8ca5bf9ce1f544096a3ff88b743381bc9e60a76d.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 7baa9ff0d548701b2bfad603fab9ea5f
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [4cNl]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 21.11.2022 o 19:48, Gix, Brian pisze:
> Hi Mateusz,
>
> On Sat, 2022-11-19 at 19:26 +0100, Mateusz Jończyk wrote:
>> W dniu 2.11.2022 o 18:59, Brian Gix pisze:
>>> The msft_set_filter_enable() command was using the deprecated
>>> hci_request mechanism rather than hci_sync. This caused the warning
>>> error:
>>> hci0: HCI_REQ-0xfcf0
>>>
>>> Signed-off-by: Brian Gix <brian.gix@intel.com>
>>> ---
>>>  net/bluetooth/msft.c | 36 +++++++++++-------------------------
>>>  1 file changed, 11 insertions(+), 25 deletions(-)
>>
>> Hello,
>>
>> On the first time I was testing this patch, I was heavily testing
>> various Bluetooth functionality. Eventually, something stopped
>> working
>> and I was no longer able to establish a Bluetooth connection between
>> my mobile phone and my laptop. To try to resolve this issue, I tried
>> suspending
>> my laptop, but after resume, I got a kernel panic (dmesg attached
>> below, I may
>> provide journal extracts on request).

Hello,

I have to apologize for the delay.

This kernel panic happened to me again, without this patch so now I can
say that it is unrelated. I have again tested the patch you provided and
Bluetooth with it appeared to be working correctly. I have even tested
with a mobile app called "Beacon Simulator" [1] and the beacon was
successfully found on my laptop.

I have tested this on top of 6.2.0-rc8.

Additionally, to see how it worked, I tested it with some debugging
printks and additional calls to
	msft_set_filter_enable(hdev, X);
(patch attached below) and the code appears to do as it is intended, but
when I combined two 
	msft_set_filter_enable(hdev, true);
calls one after the other, I got something like this:

	Bluetooth: hci0: BEGIN msft_set_filter_enable(hdev, 1)
	Bluetooth: hci0: BEGIN msft_le_set_advertisement_filter_enable_cb(hdev, user_data, 0)
	Bluetooth: hci0: END msft_set_filter_enable(hdev, 1), err = 0
	Bluetooth: hci0: BEGIN msft_set_filter_enable(hdev, 1)
	Bluetooth: hci0: Opcode 0xfcf0 failed: -16
	Bluetooth: hci0: BEGIN msft_le_set_advertisement_filter_enable_cb(hdev, user_data, f0)
	Bluetooth: hci0: END msft_set_filter_enable(hdev, 1), err = -16

instead of the error code 0x0C as is described in a comment in
msft_le_set_advertisement_filter_enable_cb() and the Microsoft
specification. Is this expected?

In msft_set_filter_enable() your patch also casts err from int to u8
while calling msft_le_set_advertisement_filter_enable_cb() without
checking its sign.

Greetings,

Mateusz

[1] https://play.google.com/store/apps/details?id=net.alea.beaconsimulator

Cc: Luiz Von Dentz <luiz.von.dentz@intel.com>

---
 net/bluetooth/msft.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index bf5cee48916c..a6f594bd0722 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -6,6 +6,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/mgmt.h>
+#include <linux/delay.h>
 
 #include "hci_request.h"
 #include "mgmt_util.h"
@@ -527,6 +528,12 @@ void msft_do_open(struct hci_dev *hdev)
 	if (msft_monitor_supported(hdev)) {
 		msft->resuming = true;
 		msft_set_filter_enable(hdev, true);
+		mdelay(1);
+		msft_set_filter_enable(hdev, false);
+		mdelay(1);
+		msft_set_filter_enable(hdev, true);
+		mdelay(1);
+		msft_set_filter_enable(hdev, true);
 		/* Monitors get removed on power off, so we need to explicitly
 		 * tell the controller to re-monitor.
 		 */
@@ -749,6 +756,8 @@ static void msft_le_set_advertisement_filter_enable_cb(struct hci_dev *hdev,
 	struct msft_cp_le_set_advertisement_filter_enable *cp = user_data;
 	struct msft_data *msft = hdev->msft_data;
 
+	bt_dev_warn(hdev, "BEGIN msft_le_set_advertisement_filter_enable_cb(hdev, user_data, %x)", (unsigned) status);
+
 	/* Error 0x0C would be returned if the filter enabled status is
 	 * already set to whatever we were trying to set.
 	 * Although the default state should be disabled, some controller set
@@ -804,6 +813,8 @@ int msft_set_filter_enable(struct hci_dev *hdev, bool enable)
 	struct msft_data *msft = hdev->msft_data;
 	int err;
 
+	bt_dev_warn(hdev, "BEGIN msft_set_filter_enable(hdev, %d)", (int) enable);
+
 	if (!msft)
 		return -EOPNOTSUPP;
 
@@ -814,6 +825,8 @@ int msft_set_filter_enable(struct hci_dev *hdev, bool enable)
 
 	msft_le_set_advertisement_filter_enable_cb(hdev, &cp, err);
 
+	bt_dev_warn(hdev, "END msft_set_filter_enable(hdev, %d), err = %d", (int) enable, err);
+
 	return 0;
 }
 
-- 
2.25.1

