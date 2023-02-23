Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342CD6A00B6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 02:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjBWBl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 20:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBWBl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 20:41:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B473BD87
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 17:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=4Y/vUgi+zlUePCC78E4DGLn2+CH9ssQFh6vEdznAP9w=; b=LZPK0iLJzCjnUGWbq8qCOx/93y
        LjP0q1Pvaf5mPsdHgFYtqgrVhncPKPbprYF2m04fLaAjC+IJ7MRaedgo/awUyMcHVCQ+kjAtbN8a2
        tr3T56MJikybyESRgRxDAOp/W+s+X0o2aRrYwn6f94VmWEQ1DPMGpRslDyQeDA+3dcnouvXOjRrGO
        Og91Oj5NpfUTq4NGJQCr+2CNllFw9YLWTQyWU644YtdxlhW2LjkCJ9hDURofNTIHwEohG+W6CFWOI
        EPf1U+ZZAZKMhFzpEQPPYgyaP0IEyFkF6xlpDR9180sPojTZRINoy1XENEgCWTu2RcESrFmo+ZyBV
        6ugW3KMg==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pV0cK-00EgHt-Ln; Thu, 23 Feb 2023 01:41:52 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Elimar Riesebieter <riesebie@lxtec.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] macintosh: via-pmu-led: *********************************
Date:   Wed, 22 Feb 2023 17:41:51 -0800
Message-Id: <20230223014151.19270-1-rdunlap@infradead.org>
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

Fix this by making ADB_PMU_LED_DISK depend on ATA.

Seen on both PPC32 and PPC64.

Fixes: 0e865a80c135 ("macintosh: Remove dependency on IDE_GD_ATA if ADB_PMU_LED_DISK is selected")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Elimar Riesebieter <riesebie@lxtec.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
 drivers/macintosh/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -86,6 +86,7 @@ config ADB_PMU_LED
 
 config ADB_PMU_LED_DISK
 	bool "Use front LED as DISK LED by default"
+	depends on ATA
 	depends on ADB_PMU_LED
 	depends on LEDS_CLASS
 	select LEDS_TRIGGERS
