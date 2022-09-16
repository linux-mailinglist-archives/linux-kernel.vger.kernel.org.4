Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8119E5BA87B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 10:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiIPIrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 04:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiIPIrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 04:47:16 -0400
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94B37AC1C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 01:47:14 -0700 (PDT)
Received: from robin.home.jannau.net (unknown [91.200.110.112])
        by soltyk.jannau.net (Postfix) with ESMTPSA id D20AF26F070;
        Fri, 16 Sep 2022 10:47:12 +0200 (CEST)
From:   Janne Grunau <j@jannau.net>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] get_maintainer: Extend matched name characters in maintainers_in_file()
Date:   Fri, 16 Sep 2022 10:47:12 +0200
Message-Id: <20220916084712.84411-1-j@jannau.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the regexp matching name characters to cover Unicode blocks Latin
Extended-A and Extended-B.
Fixes 'scripts/get_maintainer.pl -f' for
'Documentation/devicetree/bindings/clock/apple,nco.yaml'.

Signed-off-by: Janne Grunau <j@jannau.net>

---
This still excludes Greek and Cyrilic characters which should be
expected in names as well. I tried to use '\p{L}' to match all Unicode
letters but couldn't get it to work. Feel free understand this as bug
report with an incomplete fix.

best regards,
Janne

---
 scripts/get_maintainer.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index ab123b498fd9..7c06f06dcbfa 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -442,7 +442,7 @@ sub maintainers_in_file {
 	my $text = do { local($/) ; <$f> };
 	close($f);
 
-	my @poss_addr = $text =~ m$[A-Za-zÀ-ÿ\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
+	my @poss_addr = $text =~ m$[A-Za-zÀ-ɏ\"\' \,\.\+-]*\s*[\,]*\s*[\(\<\{]{0,1}[A-Za-z0-9_\.\+-]+\@[A-Za-z0-9\.-]+\.[A-Za-z0-9]+[\)\>\}]{0,1}$g;
 	push(@file_emails, clean_file_emails(@poss_addr));
     }
 }
@@ -2460,7 +2460,7 @@ sub clean_file_emails {
 	    $name = "";
 	}
 
-	my @nw = split(/[^A-Za-zÀ-ÿ\'\,\.\+-]/, $name);
+	my @nw = split(/[^A-Za-zÀ-ɏ\'\,\.\+-]/, $name);
 	if (@nw > 2) {
 	    my $first = $nw[@nw - 3];
 	    my $middle = $nw[@nw - 2];
-- 
2.35.1

