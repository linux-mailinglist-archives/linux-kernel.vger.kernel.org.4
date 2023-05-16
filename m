Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91F470584C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjEPUEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjEPUEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:04:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D206582
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:04:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3F5A63297
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 20:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02352C433A0;
        Tue, 16 May 2023 20:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684267478;
        bh=rZ28KCD4ojWX4RAZAyET5Kd+odUNMgnk9dDmnsASVvY=;
        h=From:To:Cc:Subject:Date:From;
        b=E/iymKCjtgsV3gEVhH6XMd1xE4KndsZEq+KZShWqN1hmtCYVRAd6r97/995SIgNiw
         HojrALmG+uEtrRN7EU+oBveGl0+wkSEg1n0T8I6KAR1BuP53Vnd0U3hY3cj4pZJ8dv
         6atN5IBwZr66uvG2ISc+vDKXU8aCPwW8lFh8OkeGVbJWb5OpOk6b/dKB3ECYyBNOwQ
         LeRSdOgKkpSGVUVOrpysTSIOJ478saz2xUQLB/F7CDtL5Lb1gYVh4jLcmyMqttfcJ+
         moNVQSIkweldaYemjum1DPWDChpLECnr9QpY5RsSCLh8XmEA2uFHSTOgiwwt8N8I7A
         +jZxfd7snqU+A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Johan Hovold <johan+linaro@kernel.org>,
        Xu Qiang <xuqiang36@huawei.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Juergen Gross <jgross@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] irqdomain: include internals.h for function prototypes
Date:   Tue, 16 May 2023 22:04:28 +0200
Message-Id: <20230516200432.554240-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

irq_domain_debugfs_init() is defined in irqdomain.c, but the
declaration is in a header that is not included here:

kernel/irq/irqdomain.c:1965:13: error: no previous prototype for 'irq_domain_debugfs_init' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/irq/irqdomain.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index f34760a1e222..5bd01624e447 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1915,6 +1915,8 @@ static void irq_domain_check_hierarchy(struct irq_domain *domain)
 #endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
 
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
+#include "internals.h"
+
 static struct dentry *domain_dir;
 
 static void
-- 
2.39.2

