Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DF06F1B72
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 17:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346433AbjD1PZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 11:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346453AbjD1PZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 11:25:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AAB2129
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 08:24:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 385416144C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 15:24:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3EF2C4339B;
        Fri, 28 Apr 2023 15:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682695482;
        bh=CeQx95pndYIbafMVbv9ymYFM9yv+EXUbqDLtBIKLxYE=;
        h=From:Date:Subject:To:Cc:From;
        b=p2xSXUMfGfXHd2mEQXGmuAHNb/QoAkVaj6O9BD+5OVxXeJsViNovDRv/ow113E2tH
         81sTP3j/KvfLk4O9Fg6QmR0NGnTaMSBG88WYP9GybEye00fYCJ2QiUerwjUq1ODmL5
         jO4BvQBrcxseTpuGRJ6jpGwpG8ujSKZ6S3lYaANz/WZkyrBb1KKXMzMMtkdpKrWxzx
         tX4urLccbvaLFemlWw+YeJBNnRgyKLu2//vJkj/o9iFFv2iFWxcmTE/04B1TCKjQgU
         7y2ETy+EgH86lisQxTd33zzVtRs1od2aLWE0A/AXHUQQ4xLaetrfVZPsG5o6ZT4CAS
         rMQvzrMIGPfeA==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 28 Apr 2023 16:24:36 +0100
Subject: [PATCH] tools/nolibc: Implement WTERMSIG()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230427-nolibc-wtermsig-v1-1-6baf4219bb32@kernel.org>
X-B4-Tracking: v=1; b=H4sIADPlS2QC/x2NQQrCMBAAv1L27EKMqRK/Ij0k6bZd1ER2xQqlf
 2/a4wwMs4CSMCncmwWEfqxccoXzqYE0hTwScl8ZrLEX4+wNc3lxTDh/Sd7KI/o2tb25usE7D7W
 KQQmjhJymvZuLPHf9ERr4f4we3bpuJxOt73gAAAA=
To:     Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-00e42
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103; i=broonie@kernel.org;
 h=from:subject:message-id; bh=CeQx95pndYIbafMVbv9ymYFM9yv+EXUbqDLtBIKLxYE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkS+U4teCjOkla4xOi5GypuABmkRLalL5de/fu+hd+
 eHYvYf+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZEvlOAAKCRAk1otyXVSH0EOmB/
 9q/KiLpk9uCDZt+K/LshtOMqxVVZQqCIn95KO31yBZfcZlW82fFCaMl3YgOd0gjLtLbAFIUfrclB1g
 J2+wW5nDSxvRKkWW8x6CDMVROjdt/MO25OHvJuMU42IOneJlkTg+sLhxUy2Sq2BgGFLvx1PpxlS8Rq
 46Uufg1EVMxer9+DY21ovDoWE8c1AL1nFW+9RTe2aBoJarqDGivg2ieckLLJP98MSUkrsOQPMAKkBO
 eYHZhTYrpR7xee3mjG5kG5qhsSRu6SSeoRfc+T4Jvv9zS4jIelh/A+JSbpQ14RcWqp6N/Ntw6UxTEl
 bdD0ZZdfJvRiTBzE6sAOVd2QVOfemo
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an implementation of WTERMSIG() to allow nolibc programs to obtain the
signal that caused the exit of a process, and use it in WIFEXITED() since
the condition being checked there is that no signal was reported.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/include/nolibc/types.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index fbbc0e68c001..eb0b9f1ffe18 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -79,8 +79,9 @@
 #define LINUX_REBOOT_CMD_SW_SUSPEND 0xd000fce2
 
 /* Macros used on waitpid()'s return status */
+#define WTERMSIG(status)    ((status) & 0x7f)
 #define WEXITSTATUS(status) (((status) & 0xff00) >> 8)
-#define WIFEXITED(status)   (((status) & 0x7f) == 0)
+#define WIFEXITED(status)   (WTERMSIG(status) == 0)
 
 /* waitpid() flags */
 #define WNOHANG      1

---
base-commit: 457391b0380335d5e9a5babdec90ac53928b23b4
change-id: 20230427-nolibc-wtermsig-95c5d064f949

Best regards,
-- 
Mark Brown <broonie@kernel.org>

