Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2421640B84
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbiLBRAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbiLBQ7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:59:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F76331
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 08:59:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3122B821F5
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 16:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08DCEC433C1;
        Fri,  2 Dec 2022 16:59:37 +0000 (UTC)
Date:   Fri, 2 Dec 2022 11:59:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John 'Warthog9' Hawley <warthog9@kernel.org>
Subject: [PATCH] ktest.pl minconfig: Unset configs instead of just removing
 them
Message-ID: <20221202115936.016fce23@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>

After a full run of a make_min_config test, I noticed there were a lot of
CONFIGs still enabled that really should not be. Looking at them, I
noticed they were all defined as "default y". The issue is that the test
simple removes the config and re-runs make oldconfig, which enables it
again because it is set to default 'y'. Instead, explicitly disable the
config with writing "# CONFIG_FOO is not set" to the file to keep it from
being set again.

With this change, one of my box's minconfigs went from 768 configs set,
down to 521 configs set.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 590518144167..56135e7d2295 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -3775,9 +3775,10 @@ sub test_this_config {
     # .config to make sure it is missing the config that
     # we had before
     my %configs = %min_configs;
-    delete $configs{$config};
+    $configs{$config} = "# $config is not set";
     make_new_config ((values %configs), (values %keep_configs));
     make_oldconfig;
+    delete $configs{$config};
     undef %configs;
     assign_configs \%configs, $output_config;
 
-- 
2.35.1

