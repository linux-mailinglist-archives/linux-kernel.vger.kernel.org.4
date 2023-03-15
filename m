Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D546BC044
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 23:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjCOW5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 18:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjCOW5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:57:35 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4A2637DD;
        Wed, 15 Mar 2023 15:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678921053; x=1710457053;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tDPZ/wPZz6V1SdFA6mDCQhkpN4FFm6ylvZiLfFxCqRM=;
  b=UgfGKTGnVJampZb2XZkMNsysViTA4HTTa5zlytIiPgLDyyYQezKY+Cwc
   slUI7SO2uclR66/HOYgutGhFEZO7TAZrf6AIMJMkvpZdOk0DxBcS3IIuN
   G2fKVtUIqV81sgiap/E0X9yobFVcJr58NgXP281Uz7Tt28N/s3kiXns5X
   +Z06Oecq21LI/T3mHJoYIpZFr7eKUF/P8r6aa1E3isxaph5HBtLrEQEHs
   PQdnfn4F6HyQu+7zvDiozXct5Q9qzJIUE9A527KpFCHnc9qANVCnVFW/p
   01fQXnh4c9ulu54gUnbvSBwMex4D8Jsg43xK+fxx4JAPeEnxt58Nu6ySC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="340200309"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="340200309"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 15:57:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="672908595"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="672908595"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 15:57:32 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH] Documentation/x86: Update split lock documentation
Date:   Wed, 15 Mar 2023 15:57:22 -0700
Message-Id: <20230315225722.104607-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit b041b525dab9 ("x86/split_lock: Make life miserable for split
lockers") added a delay and serialization of cplit locks. Commit
727209376f49 ("x86/split_lock: Add sysctl to control the misery mode")
provided a sysctl to turn off the misery.

Update the split lock documentation to describe the current state of
the code.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 Documentation/x86/buslock.rst | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/x86/buslock.rst b/Documentation/x86/buslock.rst
index 7c051e714943..31ec0ef78086 100644
--- a/Documentation/x86/buslock.rst
+++ b/Documentation/x86/buslock.rst
@@ -53,8 +53,14 @@ parameter "split_lock_detect". Here is a summary of different options:
 |off	  	   |Do nothing			|Do nothing		|
 +------------------+----------------------------+-----------------------+
 |warn		   |Kernel OOPs			|Warn once per task and |
-|(default)	   |Warn once per task and	|and continues to run.  |
-|		   |disable future checking	|			|
+|(default)	   |Warn once per task, add a	|and continues to run.  |
+|		   |delay, add synchronization	|			|
+|		   |to prevent more than one	|			|
+|		   |core from executing a	|			|
+|		   |split lock in parallel.	|			|
+|		   |sysctl split_lock_mitigate	|			|
+|		   |can be used to avoid the	|			|
+|		   |delay and synchronization	|			|
 |		   |When both features are	|			|
 |		   |supported, warn in #AC	|			|
 +------------------+----------------------------+-----------------------+
-- 
2.39.2

