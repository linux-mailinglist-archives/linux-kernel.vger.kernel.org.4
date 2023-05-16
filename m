Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E487052BB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbjEPPsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbjEPPsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:48:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770F2A5D7;
        Tue, 16 May 2023 08:47:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B164C63BA1;
        Tue, 16 May 2023 15:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF635C433A1;
        Tue, 16 May 2023 15:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684252013;
        bh=Cpt8gD1DG91vSJDrfbt4Hrl17RTrQOpd+8m0dG4DdQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cFT7/bXodGtbqNhpbxA6rLR7H1Ne7v2c2QMRA6uuV1m+dtzvyi75WbAjVRMg99NqS
         o2ceMU63IhrPRo0CcVXXeGF2Hv3n8lhgD3ahh1EWLou27UjIcjkS0H3jDAivSRKdLs
         6Aftg255gYT4bl976C5uxerdFY9f94joSJux3id1TJ44D2uoMoeu+hOpaUYOktvdC4
         il8SGAa58aUJN9ehp7ezXkDm1ox8DesMBqNmQvf0XKZymPlK3Ici78OFBfZVAQJnR9
         8V2d593UtJAyx9p6KtrFHVGNy8oq2UifngtIjXdibQ4VOHf1hjA0Z617i8Gd//dknq
         U3dNTlQCB/9uA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 10/16] ARM: nommu: include asm/idmap.h
Date:   Tue, 16 May 2023 17:45:59 +0200
Message-Id: <20230516154605.517690-11-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516154605.517690-1-arnd@kernel.org>
References: <20230516154605.517690-1-arnd@kernel.org>
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

setup_mm_for_reboot() is declared in asm/idmap.h but that is not included
for the definition, causing a W=1 warning:

arch/arm/mm/nommu.c:178:6: error: no previous prototype for 'setup_mm_for_reboot' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mm/nommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 53f2d8774fdb..43cfd06bbeba 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -21,6 +21,7 @@
 #include <asm/cputype.h>
 #include <asm/mpu.h>
 #include <asm/procinfo.h>
+#include <asm/idmap.h>
 
 #include "mm.h"
 
-- 
2.39.2

