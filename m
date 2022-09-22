Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9D35E5819
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 03:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiIVBfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 21:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiIVBfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 21:35:19 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87ADF7E82F;
        Wed, 21 Sep 2022 18:35:17 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o99-20020a17090a0a6c00b002039c4fce53so661412pjo.2;
        Wed, 21 Sep 2022 18:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=HXQzwn8pzI8ZSAXB6BAQnLBK8XLxqnKwtGmeoW7IQn4=;
        b=gMwWv4KvncJ8ULBzpwvbnYjRCw+DzwFm6rlY/BbhgVbo1vH1UabtD2ayqX3VUerEwZ
         msZ/BLvU8SeTqLMAkQ8oQvfdBzrAdxTGjefcAVQMPl64vDL13dUhJLMSsaVwwEm1ZtIO
         cKE+Y+ydpKHd8wFjaaRCSZHcky8ZmJLXNsU5KQvKQnvDgWwb9nAtgZHElOLGY5We684Z
         RzJ8Pd/vovD1CrT/QWsRRAhLlQcwiqm9/G9nQX6RKN8fPlOSBreD3CAfWitB4F9Ba/Ql
         tFYN6yBHOTJYtQ/wQkqSYSwAh+Ry43WqAnDsuPnHCmgQd/MzkB9g6fQ8bJVRdOOkLn1D
         eNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=HXQzwn8pzI8ZSAXB6BAQnLBK8XLxqnKwtGmeoW7IQn4=;
        b=cKr59bA2ejf1+fjzoHzPGdH6O1Kn9NdBLYdDJv5YFOWsPckUwDszqFZHt6rV+nYDId
         9sl07oxO+o0FEQRj9bAzXh/cp9XQCXTKlb2K/ahYgOxyNIAEbQ5J7doQgXS8fvj0BxwO
         hE5+z/HzYtGGPub++03BlBNKB04vFHGl7+L8zn4/LrGOS71esPo/B8rihG2Zw/qmYcle
         St1IBuuW0zDRBlUNtmupHxGIcoNjximcAAINMSZQrtUb2tBQLMbsKnDoRDDRx9qaaZmY
         2OtrgxRiImU5wedYWAtActi3NYbt740x4dYF+G995CW6qEUWJS3k4+QL09uSMg7mT5I9
         xs8g==
X-Gm-Message-State: ACrzQf23U4Q3v+a0WOmvwEm8Ub3owUtYERRqKlgKO+m7nXRgauJ2WIPG
        xx3I2+zbini2lJI0Ats3nLCDQ++/Y1s=
X-Google-Smtp-Source: AMsMyM5bzL9ktblfLClCoSvrZGFhkgcNceRQgK8iJSPTNC++O0PjJnBSLzOZd8hsfPEpfuvPG+g36w==
X-Received: by 2002:a17:90b:17c7:b0:202:95a2:e30f with SMTP id me7-20020a17090b17c700b0020295a2e30fmr12335931pjb.28.1663810517090;
        Wed, 21 Sep 2022 18:35:17 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w62-20020a623041000000b0053e156e9475sm2865137pfw.182.2022.09.21.18.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 18:35:16 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     acme@kernel.org
Cc:     mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] perf tools: use strscpy() is more robust and safer
Date:   Thu, 22 Sep 2022 01:35:12 +0000
Message-Id: <20220922013512.233108-1-ye.xingchen@zte.com.cn>
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
 tools/perf/arch/x86/util/event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/event.c b/tools/perf/arch/x86/util/event.c
index e670f3547581..a7d3bfde0c7b 100644
--- a/tools/perf/arch/x86/util/event.c
+++ b/tools/perf/arch/x86/util/event.c
@@ -61,7 +61,7 @@ int perf_event__synthesize_extra_kmaps(struct perf_tool *tool,
 		event->mmap.pgoff = pos->pgoff;
 		event->mmap.pid   = machine->pid;
 
-		strlcpy(event->mmap.filename, kmap->name, PATH_MAX);
+		strscpy(event->mmap.filename, kmap->name, PATH_MAX);
 
 		if (perf_tool__process_synth_event(tool, event, machine,
 						   process) != 0) {
-- 
2.25.1
