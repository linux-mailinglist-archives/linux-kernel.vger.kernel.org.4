Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC1362F30F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241814AbiKRK4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbiKRK4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:56:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C9D97AB4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 02:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668768900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Wu17TcJ/U0Y0VZBclAW0Sq9CIDRhj4hveCM90UJ+Snk=;
        b=iDww2ko+8S2P3Xi+wUaASitMbrNAd4xDIR4Dd/x0ZeBSUpe/3DD3OOFutbKkoxD2j2k9LX
        WqAMG7eaKZKJg8aaMFg/22AV/kz6HH3rKTuiqjr6cg+3xR9goyhZmKXFe82JlX7GhDAtxd
        b1BfYe/aHC0pRP6sU1ghVWj88l3xODY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-mhLQDY96P9q4bNonwfwG2Q-1; Fri, 18 Nov 2022 05:54:54 -0500
X-MC-Unique: mhLQDY96P9q4bNonwfwG2Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 75B4E1C05AAE;
        Fri, 18 Nov 2022 10:54:54 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.194.179])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8DB152027063;
        Fri, 18 Nov 2022 10:54:53 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH for-6.2/hid-bpf] HID: force HID depending on INPUT
Date:   Fri, 18 Nov 2022 11:54:48 +0100
Message-Id: <20221118105448.1888750-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In most configurations, INPUT is actually a boolean: either y or disabled,
but when it's disabled, you can't do much on your average laptop.

But it turns out that there is a possibility to have INPUT as a module:
you have to disable VT and TTY (of course), but also enable EXPERT.
I'll leave how to disable VT and TTY as an exercise for the bravest.

Anyway, if INPUT is m, we can still configure HID as y, which is not
correct because hid-input.c depends on the input API, meaning that
vmlinuz can not link.

So: add depends on INPUT too at the HID level, to ensure that if INPUT=m,
HID can only be m or disabled.

Fixes: 25621bcc8976 ("HID: Kconfig: split HID support and hid-core compilation")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/r/202211181742.QYJY6Gug-lkp@intel.com
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index ff40c18f4a2b..b345bbfb57bf 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -15,6 +15,7 @@ if HID_SUPPORT
 config HID
 	tristate "HID bus core support"
 	default y
+	depends on INPUT
 	help
 	  A human interface device (HID) is a type of computer device that
 	  interacts directly with and takes input from humans. The term "HID"
-- 
2.38.1

