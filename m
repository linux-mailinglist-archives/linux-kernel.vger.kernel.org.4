Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB4E645636
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiLGJN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiLGJNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:13:09 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2E811B;
        Wed,  7 Dec 2022 01:13:08 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 63bfa5b1db124d5a; Wed, 7 Dec 2022 10:13:06 +0100
Received: from kreacher.localnet (unknown [213.134.169.108])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id AE98678085F;
        Wed,  7 Dec 2022 10:13:05 +0100 (CET)
Authentication-Results: v370.home.net.pl; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: v370.home.net.pl; spf=fail smtp.mailfrom=rjwysocki.net
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>
Cc:     Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: [PATCH v1 0/2] HID: Fix regression resulting from commit 532223c8ac57
Date:   Wed, 07 Dec 2022 10:10:47 +0100
Message-ID: <5647715.DvuYhMxLoT@kreacher>
In-Reply-To: <2262737.ElGaqSPkdT@kreacher>
References: <2262737.ElGaqSPkdT@kreacher>
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

Jiri, Bastien,

This series of 2 patches fixes a regression introduced by commit 532223c8ac57
("HID: logitech-hidpp: Enable HID++ for all the Logitech Bluetooth devices")
that caused my Logitech Bluetooth mouse to become unusable.

The problem is that the mouse doesn't work with HID++ and so it needs to be
added to the list of "unhandled" devices in logitech-hidpp (patch 2), but
this is not sufficient, because hid-generic needs to actually check whether
other drivers have ->match callbacks and what those callbacks return for
the given device (patch 1).

Thanks!



