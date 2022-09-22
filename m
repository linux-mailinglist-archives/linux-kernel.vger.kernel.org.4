Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5835E57FF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 03:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiIVB24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 21:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiIVB2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 21:28:53 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C486A346F;
        Wed, 21 Sep 2022 18:28:53 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 78so7654040pgb.13;
        Wed, 21 Sep 2022 18:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=p7OsaPgDaE8pzyhnEYEnbmNVT1iMG/0i7m3psJG5hJU=;
        b=JTg+FuIUoN7QXGLTOc5pFww5WflXJmVGLsZtoOkE8i4YVlX+2yEb0PC/sVFsJRhJho
         UIW979soJAyYIY53vQ+rtvJ4GZKWxhAHeFvtiiJVI+AhXYihOTKxgddzL8iIl+zSZ7/6
         EhdpcEdGioqkfb0JkoPx/zDyRPjyUdTiPK6DJSHS+BwjTlQ0YnfIgeh8cx4564eVRycc
         NyKRSaT7xwW9CUd05TgKl+EJo9xsLgvRS+YStkMUEBOC4UAvfKyOfoB286al5ZNpRYX5
         b7e4Q0AekBec0P0pVmOtxhql8zqNehth6WuR1/D4T7tA0rb7s/qwj/P35AHJgPL6qxMT
         GYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=p7OsaPgDaE8pzyhnEYEnbmNVT1iMG/0i7m3psJG5hJU=;
        b=qlbgmdUD+TU9dRuNOVWcgnwB2/5QEn6iYBm5xlgmWSl89D7esf8DGtT5Xuv4dFK8fO
         yqudTrdMJ7SuEz77aRBAdEsiwiYabKJ1gbAPXr/bIf5QZ25l33sXupgGRWm7mfI3chC+
         NhJNYGmicjxQeUM6bV88LcdW3ZNnTiPHQE5GSRpP+0GA1Zpr8eKnVDcL33j58+TBr0Jh
         b6MeSqH9uPHQD63e03vEMqxsLcP1ZyuQlT4aPE1RcHOZ3qL7KTNp/5evp2CBcK8WXT5p
         47Kq+KlWa2qLkvbNPgqZORARq7azioHPAbGC6/rCQnGvG0w/8HBxc9RBqTU4TrVLAGYg
         jlUA==
X-Gm-Message-State: ACrzQf39uloB8go5oU7L26UnSq3iBJ/JoLDtqAER83yelgD2n60crk+U
        VY5nVj+AEbRB6kfgAiNpUtI=
X-Google-Smtp-Source: AMsMyM6nUMugRddL+PWON7kDYamD0thDUMiqTGYmaKTyTlskgOnK1xqjv/gp7Ub/ZEbPIiOVj2O9rA==
X-Received: by 2002:a63:5d5b:0:b0:439:e032:4198 with SMTP id o27-20020a635d5b000000b00439e0324198mr940633pgm.398.1663810132100;
        Wed, 21 Sep 2022 18:28:52 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b124-20020a636782000000b00439dfe09770sm2503724pgc.12.2022.09.21.18.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 18:28:51 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     acme@kernel.org
Cc:     mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com, irogers@google.com,
        ak@linux.intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] perf auxtrace: use strscpy() is more robust and safer
Date:   Thu, 22 Sep 2022 01:28:46 +0000
Message-Id: <20220922012846.232684-1-ye.xingchen@zte.com.cn>
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
 tools/perf/util/auxtrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index b59c278fe9ed..81ee28983071 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1208,7 +1208,7 @@ void auxtrace_synth_guest_error(struct perf_record_auxtrace_error *auxtrace_erro
 	auxtrace_error->fmt = 1;
 	auxtrace_error->ip = ip;
 	auxtrace_error->time = timestamp;
-	strlcpy(auxtrace_error->msg, msg, MAX_AUXTRACE_ERROR_MSG);
+	strscpy(auxtrace_error->msg, msg, MAX_AUXTRACE_ERROR_MSG);
 	if (machine_pid) {
 		auxtrace_error->fmt = 2;
 		auxtrace_error->machine_pid = machine_pid;
-- 
2.25.1
