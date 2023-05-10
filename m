Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4936FE319
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbjEJRNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236463AbjEJRNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:13:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FB335B8;
        Wed, 10 May 2023 10:12:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1CB364A2C;
        Wed, 10 May 2023 17:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08886C433D2;
        Wed, 10 May 2023 17:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683738761;
        bh=2M6v60PmJAp5aRYp2+d6DFkl/BsCoNJznvPo0Uk4u4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O7TIK7goJQmPY2ig9kdwsUlGEWE46U1blZi4RjyMBfJLxPH0PNjxI6NxvC3hzSOSh
         lp4U6At+XLEhkWkOgqxj8pOBdnQlcKyvPdhrsWe59KJja0k0DtXpIEiiqGkjtWgscn
         3BZvC0LV5pb++w/mpUGLxI1G+AwJK7CACcS77gAT8/0VUCWD0KaW4i61mLric/cIWs
         ushYm+7wSWM7xN3/BJ7zzm4QBT5unxnNSsEpNzsy8O2mOdlmnO2LmmOK0b2whlfgA9
         9Bj3ZULtzHIKiYF+sU27y+k3ogbXIoVSGLBvHpBUcwjEOxH6SHPthZgIaktzNTYery
         QZN5wkFIKSWhA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 626F2CE12D5; Wed, 10 May 2023 10:12:40 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Zhouyi Zhou <zhouzhouyi@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 6/6] torture: Remove duplicated argument -enable-kvm for ppc64
Date:   Wed, 10 May 2023 10:12:38 -0700
Message-Id: <20230510171238.2189921-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7ffd4a5d-61e9-4b4c-a312-a85bcde08c39@paulmck-laptop>
References: <7ffd4a5d-61e9-4b4c-a312-a85bcde08c39@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhouyi Zhou <zhouzhouyi@gmail.com>

The qemu argument -enable-kvm is duplicated because the qemu_args bash
variable in kvm-test-1-run.sh has already provides it.  This commit
therefore removes the ppc64-specific copy in functions.sh.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index b52d5069563c..48b9147e8c91 100644
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -250,7 +250,7 @@ identify_qemu_args () {
 		echo -machine virt,gic-version=host -cpu host
 		;;
 	qemu-system-ppc64)
-		echo -enable-kvm -M pseries -nodefaults
+		echo -M pseries -nodefaults
 		echo -device spapr-vscsi
 		if test -n "$TORTURE_QEMU_INTERACTIVE" -a -n "$TORTURE_QEMU_MAC"
 		then
-- 
2.40.1

