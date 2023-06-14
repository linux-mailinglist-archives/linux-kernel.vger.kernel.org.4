Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072DE73056C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbjFNQuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbjFNQuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:50:09 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DA91FC2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686761408; x=1718297408;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lF5f5n/e4aXoP+GMV3/7WyCPHfb2ROWwQeBKvgiW28A=;
  b=U5dC4OAOTeM39IdmVazv3LeGrjjN4r78euxwNqjmMhvN7SBZHL28ANYG
   ACBGLFfwJANEVyBLGA0L8+MAmHCrOUtNQChKjFrVxEy2PaI7DN5sXnKU2
   5Z0CkrkjVylMutm2exG5glRilZW4rfy8ZwawBx/sXkKcGHyzmeV+r+Gmy
   HRzkMJBgkVr4rpLD7dgg9zY4xG2lwpf73kjs5lpb6RZxSh/aw2fJwWbmU
   Qwx0OPlHVuCiyunwFWsVvqm+segDB+ZIVv47VShi6oJrxOWHnLGUwZlBM
   4u0r2sbXn1yKNUovtR+6H+FxTLL4QhMPWWYlLNE8Eeb63JbskXSZGi9bZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="338304238"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="338304238"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 09:50:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="782162198"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="782162198"
Received: from awvttdev-05.aw.intel.com ([10.228.212.156])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 09:50:04 -0700
From:   "Michael J. Ruhl" <michael.j.ruhl@intel.com>
To:     linux-kernel@vger.kernel.org, apw@canonical.com, joe@perches.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com, corbet@lwn.net,
        david@redhat.com
Cc:     "Michael J. Ruhl" <michael.j.ruhl@intel.com>
Subject: [PATCH] checkpatch: Include GEM_BUG_xxx variant in the excluded check list
Date:   Wed, 14 Jun 2023 12:49:55 -0400
Message-Id: <20230614164955.1319870-1-michael.j.ruhl@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GEM_BUG_ON is usually compiled as WARN.  You have to change to
debug configuration to get this to be BUG.

checkpatch flags this a WARN level issue.

Since this is a i915 local debug macro, allow its use in checkpatch.pl.

Fixes: 69d517e6e210 ("checkpatch: warn on usage of VM_BUG_ON() and other BUG variants")

Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b30114d637c4..d3ddde4cd63e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4821,7 +4821,7 @@ sub process {
 		}
 
 # do not use BUG() or variants
-		if ($line =~ /\b(?!AA_|BUILD_|DCCP_|IDA_|KVM_|RWLOCK_|snd_|SPIN_)(?:[a-zA-Z_]*_)?BUG(?:_ON)?(?:_[A-Z_]+)?\s*\(/) {
+		if ($line =~ /\b(?!AA_|BUILD_|DCCP_|GEM_|IDA_|KVM_|RWLOCK_|snd_|SPIN_)(?:[a-zA-Z_]*_)?BUG(?:_ON)?(?:_[A-Z_]+)?\s*\(/) {
 			my $msg_level = \&WARN;
 			$msg_level = \&CHK if ($file);
 			&{$msg_level}("AVOID_BUG",
-- 
2.39.2

