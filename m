Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B00C698EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjBPImf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBPImc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:42:32 -0500
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E043455AB
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:42:29 -0800 (PST)
X-QQ-mid: bizesmtp66t1676536944t0kk30qh
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 16 Feb 2023 16:42:12 +0800 (CST)
X-QQ-SSF: 01400000002000I0Z000B00A0000000
X-QQ-FEAT: HzdOSj0BmyuHynpxetDeW9ax4efUR684v7vpx+z+dxkLM4upVma5FQdDWBcyW
        tbHlVo+n6+oovlcuqPR1OXE0308s/nq08MhRdhWUp3cG8W6gepi5COU4vk2/ijzJMbdnFmC
        8HyR7IKJCOlj8ZrIBoYjTxgLMQ/SIap/QsE9nJw8uuALxHvvr+agOpMSp5qB5K05QO1BcmD
        PL5Ka0fkiJfugA1LAC+FIbaEFWeAe0ATKnAAzsIauyAGwtFWTBgBn3vy26io4x50cPO+s8/
        UoywlaRskII5i4Dsxl8Rrw5ZDrF6+pf6AX7K1oS4NvXCDdfFoXbjoeSpNGUDoqHQPtSBqjS
        YB9hAJlKmRNoRkBZSdOhB/bM2KpCpSjqTIB3bIrt3wn16a1lLbwxJB4G5iPo1oCwUH2gDPu
X-QQ-GoodBg: 2
From:   Meng Tang <tangmeng@uniontech.com>
To:     masahiroy@kernel.org, linux-kernel@vger.kernel.org
Cc:     Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH] kbuild: optimize the increments the version number rules
Date:   Thu, 16 Feb 2023 16:42:09 +0800
Message-Id: <20230216084209.4783-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the build version of the kernel can only count integers.
If the user defines that the version in .version is a non-integer
number, the build version will be '1'.

The original intention of the version rule as I understand it is to
initialize the version to '1' when the user does not define a build
version.

In order to allow users to define a non-integer kernel version, and
it will not be automatically changed to '1' after definition, this
modification is submitted

Fixes: 2df8220cc511 ("kbuild: build init/built-in.a just once")

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 init/build-version | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/init/build-version b/init/build-version
index 537d45815083..ca985dc285cc 100755
--- a/init/build-version
+++ b/init/build-version
@@ -3,7 +3,12 @@
 
 prev_ver=$(cat .version 2>/dev/null) &&
 ver=$(expr ${prev_ver} + 1 2>/dev/null) ||
-ver=1
+if [ X$prev_ver = "X" ]
+then
+	ver=1
+else
+	ver=$prev_ver
+fi
 
 echo ${ver} > .version
 
-- 
2.20.1

