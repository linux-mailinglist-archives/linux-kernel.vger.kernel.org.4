Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290C55BFB10
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiIUJeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiIUJee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:34:34 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0983AD9E;
        Wed, 21 Sep 2022 02:34:32 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q3so5824522pjg.3;
        Wed, 21 Sep 2022 02:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=k49E7LJbSiVZNjNmcdoBwgiJRae2/LsEELVD7CSs6d0=;
        b=CmF7p64TL4djtFyI7TU+R/j7TjJ9Z+mREOlgBJkqiSLeP9PEWV4aj5gEsqHJwDR9Qa
         OEvsl+K5nxJKHr5oUL7dT3x7rbqHUi5iDmX07TT+Y67e/Taaly7OkPIXoSt/RNE/N/RM
         aq89zYZa8Bt322mk5uPftcywPORmileacfoL4zKsRdWG/bDmMAdzO169gjOAOznMzaBc
         LAUrKunGhyUZ8Kr7dzKLUEoTbHue1bS7ogTb8DeitPdWLXd1Lw3nkpIrkadkRDxLyUM1
         zGf4JH9Qf//fRXyZB4lONCl3pxw4egnV+9nG5weiEEKA2H9eg1j8brAlSr1bBvixFP97
         bW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=k49E7LJbSiVZNjNmcdoBwgiJRae2/LsEELVD7CSs6d0=;
        b=fvqIh5jM3dFdMy37rdowNL1GKzMdFM/hUXhqmeLtNlGWCJOlju65Qn4leBXjALc5We
         FFQvuopkSGWZAumRNXe0U5pNYCINcOEc1Kr/J/K7cjzpHKAcXkri/4Yr0IdTWOV3S6E1
         F8KugY64YExrevrwMcX8Gqr0eFrqPf/fvT+09Zt6bmRQ+aN1iUYNSnvsYLJI5QsOq3H0
         mEXj4Mbt0rSWaMV2M6o/H+1dKu86Qxvy50t3dJg6xGvD+lCpXovokOCRq2ueua14v4fW
         eMXzozHaPhYhU+NMCDnbJTEOKtQYj1W4q73j1vHYBGS7js61ZZZNkiB+I38JMlrzhj08
         3vPQ==
X-Gm-Message-State: ACrzQf2TIxmGNiwMtQ+tGaaY+YeXkKwcgu6T9u0Q4GjsUUUZEf4M+rQm
        b6nh3fpGr6US89PUB+Ky20U=
X-Google-Smtp-Source: AMsMyM6hnvUGWyd2NbU9gXkthouxGbjR+e4oNp+w2YxPZaZRLNM1G9c/878YJ9yi8NHQnUzNeJwKdw==
X-Received: by 2002:a17:90b:1bc7:b0:200:7f05:3c2 with SMTP id oa7-20020a17090b1bc700b002007f0503c2mr8512188pjb.95.1663752871642;
        Wed, 21 Sep 2022 02:34:31 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id na18-20020a17090b4c1200b001fde265ff4bsm1480330pjb.4.2022.09.21.02.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:34:31 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     acme@kernel.org
Cc:     mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] perf daemon: use strscpy() is more robust and safer
Date:   Wed, 21 Sep 2022 09:34:27 +0000
Message-Id: <20220921093427.230690-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

The implementation of strscpy() is more robust and safer.

That's now the recommended way to copy NUL terminated strings.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 tools/perf/builtin-daemon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 6cb3f6cc36d0..1e927c4dcc81 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -606,7 +606,7 @@ static int setup_server_socket(struct daemon *daemon)
 	memset(&addr, 0, sizeof(addr));
 	addr.sun_family = AF_UNIX;
 
-	strlcpy(addr.sun_path, path, sizeof(addr.sun_path) - 1);
+	strscpy(addr.sun_path, path, sizeof(addr.sun_path) - 1);
 	unlink(path);
 
 	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) == -1) {
@@ -877,7 +877,7 @@ static int setup_client_socket(struct daemon *daemon)
 
 	memset(&addr, 0, sizeof(addr));
 	addr.sun_family = AF_UNIX;
-	strlcpy(addr.sun_path, path, sizeof(addr.sun_path) - 1);
+	strscpy(addr.sun_path, path, sizeof(addr.sun_path) - 1);
 
 	if (connect(fd, (struct sockaddr *) &addr, sizeof(addr)) == -1) {
 		perror("failed: connect");
-- 
2.25.1
