Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DE55BFA6A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiIUJOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiIUJOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:14:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4E18E4D9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:13:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF1F5B82EAD
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:13:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C5EC433B5;
        Wed, 21 Sep 2022 09:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663751633;
        bh=mm3yWg4zUv+RoBBZFdZLopMIwemsd56mkYyPQK/6HS4=;
        h=From:To:Cc:Subject:Date:From;
        b=0A+4yjY/JQQeWtBGzF12XnpGj3FiC8Y2cMfveHyaSBD5UiP5Mftz7PtVn8pSLwctQ
         mmqEuMPGohxKOe/bTGar8uZDV88PSYa9mqsPPLpMVP3JPeaU4GiCTF1MMjvWdadFP+
         YcAOvt585YTQsBIrWhnmaIcPhrlWMKZd53zcJHDQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     cocci@inria.fr
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>
Subject: [PATCH] scripts: coccicheck: use "grep -E" instead of "egrep"
Date:   Wed, 21 Sep 2022 11:13:41 +0200
Message-Id: <20220921091341.217365-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=979; i=gregkh@linuxfoundation.org; h=from:subject; bh=mm3yWg4zUv+RoBBZFdZLopMIwemsd56mkYyPQK/6HS4=; b=owGbwMvMwCRo6H6F97bub03G02pJDMlaV48uZA/1NjKcvF3n4q8zzZ15lytKd7FEtviJ61207Kjj t5/YEcvCIMjEICumyPJlG8/R/RWHFL0MbU/DzGFlAhnCwMUpABPxfcGwoJ03pLxb5HQtz+Y9xYJn68 qKyrMEGRZctyu2nm2yh2Oy63zJ1uJNj86bcc4AAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latest version of grep claims that egrep is now obsolete so the build
now contains warnings that look like:
        egrep: warning: egrep is obsolescent; using grep -E
fix this up by moving the vdso Makefile to use "grep -E" instead.

Cc: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Cc: cocci@inria.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/coccicheck | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index caba0bff6da7..2956fce8fa4f 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -47,7 +47,7 @@ FLAGS="--very-quiet"
 # inspected there.
 #
 # --profile will not output if --very-quiet is used, so avoid it.
-echo $SPFLAGS | egrep -e "--profile|--show-trying" 2>&1 > /dev/null
+echo $SPFLAGS | grep -E -e "--profile|--show-trying" 2>&1 > /dev/null
 if [ $? -eq 0 ]; then
 	FLAGS="--quiet"
 fi
-- 
2.37.3

