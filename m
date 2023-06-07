Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0207253F1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbjFGGOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbjFGGO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:14:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF681BD6;
        Tue,  6 Jun 2023 23:14:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5998632E7;
        Wed,  7 Jun 2023 06:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5206BC433D2;
        Wed,  7 Jun 2023 06:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686118462;
        bh=lx1FaogfADbvWr9OYO5AKNT2RPL89rJ/j4JUwZ6KOUE=;
        h=From:To:Cc:Subject:Date:From;
        b=ILMLPSm0gVE1Z51RSSgVijfxtGAjAhB8JyFKfx6eysmuSe144qumW4LeZd3TnKa/F
         PahJ5jXTElh+kAe2mLSjSWT/bQcyBlm0YUlQ5sjwLPpJODrSvmm6/naNlsvZErjQNs
         K2HoCmY642J08RV3d5Vunnmgaergy6pVx7p5EAMo6TQ/ib19UGgIWW172VQZ06F3bw
         yaY+JaJux7+1zNCxOm+WuEdvTug0P5PcsID6IhwkvqkVM3Hjzoqji2E9C4I/JmbIEs
         4GlkCLVXII3/ekrt7IJrhAKF2QC7WWv2UDkGBuTUwHqa0Gbird05twAHPAPPxsBcVl
         gmGfrUzm8YGCg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     masahiroy@kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        YehezkelShB@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: [PATCH] streamline_config.pl: handle also ${CONFIG_FOO}
Date:   Wed,  7 Jun 2023 08:14:17 +0200
Message-ID: <20230607061417.13636-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Slaby <jslaby@suse.cz>

streamline_config.pl currently searches for CONFIG options in Kconfig
files as $(CONFIG_FOO). But some Kconfigs (e.g. thunderbolt) use
${CONFIG_FOO}. So fix up the regex to accept both.

This fixes:
$ make LSMOD=`pwd/`/lsmod localmodconfig
using config: '.config'
thunderbolt config not found!!

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: andreas.noever@gmail.com
Cc: michael.jamet@intel.com
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: YehezkelShB@gmail.com
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
---
 scripts/kconfig/streamline_config.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kconfig/streamline_config.pl b/scripts/kconfig/streamline_config.pl
index 3387ad7508f7..d51cd7ac15d2 100755
--- a/scripts/kconfig/streamline_config.pl
+++ b/scripts/kconfig/streamline_config.pl
@@ -317,7 +317,7 @@ foreach my $makefile (@makefiles) {
 	$_ = convert_vars($_, %make_vars);
 
 	# collect objects after obj-$(CONFIG_FOO_BAR)
-	if (/obj-\$\((CONFIG_[^\)]*)\)\s*[+:]?=\s*(.*)/) {
+	if (/obj-\$[({](CONFIG_[^})]*)[)}]\s*[+:]?=\s*(.*)/) {
 	    $var = $1;
 	    $objs = $2;
 
-- 
2.41.0

