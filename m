Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A8C645637
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiLGJNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiLGJNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:13:07 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753CC286F5;
        Wed,  7 Dec 2022 01:13:06 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 71a7a6d26ff50113; Wed, 7 Dec 2022 10:13:04 +0100
Received: from kreacher.localnet (unknown [213.134.169.108])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 22F24780872;
        Wed,  7 Dec 2022 10:13:04 +0100 (CET)
Authentication-Results: v370.home.net.pl; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: v370.home.net.pl; spf=fail smtp.mailfrom=rjwysocki.net
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>
Cc:     Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: [PATCH v1 1/2] HID: generic: Add ->match() check to __check_hid_generic()
Date:   Wed, 07 Dec 2022 10:11:50 +0100
Message-ID: <4809717.31r3eYUQgx@kreacher>
In-Reply-To: <5647715.DvuYhMxLoT@kreacher>
References: <2262737.ElGaqSPkdT@kreacher> <5647715.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.169.108
X-CLIENT-HOSTNAME: 213.134.169.108
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudefrddufeegrdduieelrddutdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeiledruddtkedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepkedprhgtphhtthhopehjihhkohhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrgguvghssheshhgruggvshhsrdhnvghtpdhrtghpthhtoheplhgrihhnshesrhhishgvuhhprdhnvghtpdhrtghpthhtohepsggvnhhjrghmihhnrdhtihhsshhoihhrvghssehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhinhhpuhhtsehvghgvrhdrkhgvrhhn
 vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrvghgrhgvshhsihhonhhssehlvggvmhhhuhhishdrihhnfhho
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Some special HID drivers (for example, hid-logitech-hidpp) use ->match()
callbacks to reject specific devices that otherwise would match the
driver's device ID list, with the expectation that those devices will
be handled by some other drivers.  However, this doesn't work if
hid-generic is expected to bind to the given device, because its
->match() callback, hid_generic_match(), rejects all devices that match
device ID lists of the other HID drivers regardless of what is returned
by the other drivers' ->match() callbacks.

To make it work, amend the function used by hid_generic_match() for
checking an individual driver, __check_hid_generic(), with a check
involving the given driver's ->match() callback, so 0 is returned
when that callback rejects the device in question.

Fixes: 532223c8ac57 ("HID: logitech-hidpp: Enable HID++ for all the Logitech Bluetooth devices")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/hid/hid-generic.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/hid/hid-generic.c
===================================================================
--- linux-pm.orig/drivers/hid/hid-generic.c
+++ linux-pm/drivers/hid/hid-generic.c
@@ -31,7 +31,13 @@ static int __check_hid_generic(struct de
 	if (hdrv == &hid_generic)
 		return 0;
 
-	return hid_match_device(hdev, hdrv) != NULL;
+	if (!hid_match_device(hdev, hdrv))
+		return 0;
+
+	if (hdrv->match)
+		return hdrv->match(hdev, false);
+
+	return 1;
 }
 
 static bool hid_generic_match(struct hid_device *hdev,



