Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB986379C1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiKXNQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKXNQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:16:10 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB492F3937;
        Thu, 24 Nov 2022 05:16:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 74E7E1F6E6;
        Thu, 24 Nov 2022 13:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669295766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DTq9mK8VryLtbjZZAvH3we6XnRn6OtTrekdTcapv/l8=;
        b=JGHx/Vzm8iMeeco2EUjZhBy3Dm/bAuWC/r8DILvMltgPfyNvvrxcjDeOyYX8SkJysecsqC
        0Ozc5TiUx/a1MN+/j1MIhvxXHujgZTIwYyjcxpiDNDnandnJoEGwvb/DLEzrB2R54YPgAl
        5OrrEpbLV2+41q5+xcW9GjBLz0Z2AFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669295766;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DTq9mK8VryLtbjZZAvH3we6XnRn6OtTrekdTcapv/l8=;
        b=3w3QYFQfEMqpWgOhTx5Ft+Kb26w13b0GalTNfEuabZMqAMwSo6N5U7AG/6w4muHkASanTI
        GNT7pFI6HZevcyCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8B8113B4F;
        Thu, 24 Nov 2022 13:16:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wuYBLJVuf2NnIAAAMHmgww
        (envelope-from <jdelvare@suse.de>); Thu, 24 Nov 2022 13:16:05 +0000
Date:   Thu, 24 Nov 2022 14:16:04 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     linux-can@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc:     Pavel Pisa <pisa@cmp.felk.cvut.cz>,
        Ondrej Ille <ondrej.ille@gmail.com>
Subject: [PATCH] can: ctucanfd: Drop obsolete dependency on COMPILE_TEST
Message-ID: <20221124141604.4265225f@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
is possible to test-build any driver which depends on OF on any
architecture by explicitly selecting OF. Therefore depending on
COMPILE_TEST as an alternative is no longer needed.

It is actually better to always build such drivers with OF enabled,
so that the test builds are closer to how each driver will actually be
built on its intended target. Building them without OF may not test
much as the compiler will optimize out potentially large parts of the
code. In the worst case, this could even pop false positive warnings.
Dropping COMPILE_TEST here improves the quality of our testing and
avoids wasting time on non-existent issues.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: Ondrej Ille <ondrej.ille@gmail.com>
---
 drivers/net/can/ctucanfd/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-6.0.orig/drivers/net/can/ctucanfd/Kconfig
+++ linux-6.0/drivers/net/can/ctucanfd/Kconfig
@@ -23,7 +23,7 @@ config CAN_CTUCANFD_PCI
 
 config CAN_CTUCANFD_PLATFORM
 	tristate "CTU CAN-FD IP core platform (FPGA, SoC) driver"
-	depends on HAS_IOMEM && (OF || COMPILE_TEST)
+	depends on HAS_IOMEM && OF
 	select CAN_CTUCANFD
 	help
 	  The core has been tested together with OpenCores SJA1000


-- 
Jean Delvare
SUSE L3 Support
