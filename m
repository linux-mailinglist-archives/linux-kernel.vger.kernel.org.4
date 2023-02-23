Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743FD6A0E90
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 18:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjBWRUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 12:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBWRUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 12:20:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDC54E5EE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 09:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=zrfI7CilhOCa+PtfPUy1z9S6Br3AxmLJ0p9AfsQK+cw=; b=YPFeEJ/NV4N+4HkDFrodNyL7pw
        hPGri4q6s4RWw1Wpj8zNo1+9ggeTOqETGnYlpjlPoTFXS7UV90Gjgm+5v9qKJktfHKwhQFyfVlDE/
        OHfdjHNP/UaduZdFHR7AacTSR6l1QP7QEJFe8LFgj1v8tiKNhH3F4wAWf/DDAGu7f9l8EDLzeG9Fw
        J/CWsiDoPcPuJvxXZ0qvnB0E/a3r7YmFyGIlupwFH6/bvxsg6cTqyUnB0wOZnlIOwoxh5qISKdfqT
        V8d2XmSTDKPehmGq+lJCPH+51rG1MbC49+f9bgcByNQmn/XZsnuy6BcV7gVIa7PJJUySEWmqX6KCH
        iHcEKSNg==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pVFGN-00HLtl-Ak; Thu, 23 Feb 2023 17:20:11 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Elimar Riesebieter <riesebie@lxtec.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3] macintosh: via-pmu-led: fix Kconfig for ADB_PMU_LED_DISK
Date:   Thu, 23 Feb 2023 09:20:10 -0800
Message-Id: <20230223172010.21780-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LEDS_TRIGGER_DISK depends on ATA, so selecting LEDS_TRIGGER_DISK
when ATA is not set/enabled causes a Kconfig warning:

WARNING: unmet direct dependencies detected for LEDS_TRIGGER_DISK
  Depends on [n]: NEW_LEDS [=y] && LEDS_TRIGGERS [=y] && ATA [=n]
  Selected by [y]:
  - ADB_PMU_LED_DISK [=y] && MACINTOSH_DRIVERS [=y] && ADB_PMU_LED [=y] && LEDS_CLASS [=y]

Fix this by making ADB_PMU_LED_DISK depend on LEDS_TRIGGER_DISK
instead of selecting it.

Seen on both PPC32 and PPC64.

Fixes: 0e865a80c135 ("macintosh: Remove dependency on IDE_GD_ATA if ADB_PMU_LED_DISK is selected")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Elimar Riesebieter <riesebie@lxtec.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
v2: add a complete Subject: line
v3: change select to depends on (Michael)

 drivers/macintosh/Kconfig |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff -- a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -88,8 +88,7 @@ config ADB_PMU_LED_DISK
 	bool "Use front LED as DISK LED by default"
 	depends on ADB_PMU_LED
 	depends on LEDS_CLASS
-	select LEDS_TRIGGERS
-	select LEDS_TRIGGER_DISK
+	depends on LEDS_TRIGGER_DISK
 	help
 	  This option makes the front LED default to the disk trigger
 	  so that it blinks on disk activity.
