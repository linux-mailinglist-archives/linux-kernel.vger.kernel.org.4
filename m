Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF1F661FB7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbjAIIKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbjAIIKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:10:17 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C92B513F10
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:10:02 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 30989Qe6026643;
        Mon, 9 Jan 2023 09:09:26 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 3/4] rcutorture: add support for s390
Date:   Mon,  9 Jan 2023 09:09:09 +0100
Message-Id: <20230109080910.26594-4-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20230109080910.26594-1-w@1wt.eu>
References: <20230109080910.26594-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Schnelle <svens@linux.ibm.com>

Add the required values to identify_qemu() and
identify_bootimage().

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/rcutorture/bin/functions.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index 66d0414d8e4b..b52d5069563c 100644
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -159,6 +159,9 @@ identify_boot_image () {
 		qemu-system-aarch64)
 			echo arch/arm64/boot/Image
 			;;
+		qemu-system-s390x)
+			echo arch/s390/boot/bzImage
+			;;
 		*)
 			echo vmlinux
 			;;
@@ -184,6 +187,9 @@ identify_qemu () {
 	elif echo $u | grep -q aarch64
 	then
 		echo qemu-system-aarch64
+	elif echo $u | grep -q 'IBM S/390'
+	then
+		echo qemu-system-s390x
 	elif uname -a | grep -q ppc64
 	then
 		echo qemu-system-ppc64
-- 
2.17.5

