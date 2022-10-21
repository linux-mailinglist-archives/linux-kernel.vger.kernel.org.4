Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CEE607EE9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiJUTQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiJUTQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:16:22 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AF31116D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 12:15:42 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LDufN2004136;
        Fri, 21 Oct 2022 21:15:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=rpB0t4cce39ShZcMP7Omj98OzqHAfccHfhWe9Hk8V0g=;
 b=JYGOVtHzsm8o02qL7Ie8vsiw5bieAN68feZKusIqBTYDiJ/puZ/I20pL1xd1f9lwbYUz
 Y1GSNBCHOQUdhf7APHLxKXW7BB3vEa/Ncqo8B49W3jQfapiAhODJkXgkSkvqsQZxLnwB
 z9U/m+KaTnT+Tu5FgDKaFoUDzeSBmrbQOAzv9oTBRtJqmpHzIThp6Rx8KLhQ5+6CaxpR
 LunZSi9VFT2Uf8aEwC/5mQtqPRY0nmPiIQstCcxPSqKHWsCYHVa8WGkwz5o+rPAlhXdT
 b23Jn+HeqAi4RzltqWCU6PlYmWqYmQZKHe7yHKR8+hvJqXpOvdR82vuMmOoRyJfEdLbX VA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3kbrgtk7r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 21:15:25 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D145B10002A;
        Fri, 21 Oct 2022 21:15:19 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 67F0B2C4212;
        Fri, 21 Oct 2022 21:15:19 +0200 (CEST)
Received: from localhost (10.211.9.227) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 21:15:19 +0200
From:   Antonio Borneo <antonio.borneo@foss.st.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        <linux-kernel@vger.kernel.org>
CC:     Antonio Borneo <antonio.borneo@foss.st.com>
Subject: [PATCH] checkpatch: handle utf8 while computing length of commit msg lines
Date:   Fri, 21 Oct 2022 21:15:07 +0200
Message-ID: <20221021191507.9026-1-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.211.9.227]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current check for the length of each line in the commit msg
uses length($line) that counts line's bytes.
If the line contains utf8 characters, the byte count can exceed
the cap even on quite short lines.

Count the utf8 characters for checking line length.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>

---

Actually it's not fully clear to me if utf8 characters in the
commit msg are acceptable/tolerated or to be avoided.
In the commit msg of 15662b3e8644 ("checkpatch: add a --strict
check for utf-8 in commit logs") is stated:
	Some find using utf-8 in commit logs inappropriate.


 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1e5e66ae5a52..eaad5da50554 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3220,7 +3220,7 @@ sub process {
 
 # Check for line lengths > 75 in commit log, warn once
 		if ($in_commit_log && !$commit_log_long_line &&
-		    length($line) > 75 &&
+		    length(decode("utf8", $line)) > 75 &&
 		    !($line =~ /^\s*[a-zA-Z0-9_\/\.]+\s+\|\s+\d+/ ||
 					# file delta changes
 		      $line =~ /^\s*(?:[\w\.\-\+]*\/)++[\w\.\-\+]+:/ ||

base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
2.38.0

