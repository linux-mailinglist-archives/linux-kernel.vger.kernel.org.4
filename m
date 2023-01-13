Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA1A66A0EF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjAMRoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjAMRnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:43:12 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1756C05B
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:29:40 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id a25so12446241qto.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pefoley.com; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3CFe1t4P+3FfzM80rDpGLVDJnMv8e1UCNX7pPuC4XSU=;
        b=XEAHraYnZZnyAOjUopJsKlc6GJZ3bSMSBGMIjhsUB26AHbVdASIA1RQu+GM1h8v68g
         uKhKuA9JHTpBC7J000kpZ4EEDmCvbv1d34Ur5c/gHet/SwbmhzkfKf4kuGhNbejt4310
         /Z7obismOr3B01ZxVI836oH6m3Xvw2jYwXl3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3CFe1t4P+3FfzM80rDpGLVDJnMv8e1UCNX7pPuC4XSU=;
        b=M45cfIYVrDfNN1Q/v04rNczsSm/E4vYxCIVLBPtG0SAGisgc36bFnon33XYU7zy1as
         C02APfCO1AXDIFPzgT3TkRJZOHV8LU8WwlOUAhsh0qV+iwQKcmP2CQfA4DPg9EDYs5XL
         CAjB8VhyT2lRvroccNhAglmNybNecDHroENdJnGEgSx5qOjw3m6h7gY9r937p8KUMeD7
         scrirhSryjt4GZOCa7j0A8vc+GW1qOkKq1ui4LbRXgH5NZeBX6KLWYpjVWbB7/Ei79D4
         EKmZJ+egPRm1vg29OhyzwmR3h5NJgf9dD+4oi8HnpUi90kghInLYJPWnZu9tJhVj9TJW
         2tYQ==
X-Gm-Message-State: AFqh2kpRb1TmPFqXLIXn0Vvf0YAmK+VGY4co+OkyromM1zB7T8hA0rFz
        Jk3h52SEWWpTMun+cT4IogQwQg==
X-Google-Smtp-Source: AMrXdXvRV69bnVP6msDnCyGfW+FutPKf4g24ZRCpSaFPk5yEjX2/jRqgXCvJ3fj2c2HED+o0GqBzsw==
X-Received: by 2002:ac8:785:0:b0:3a9:81f7:2d7f with SMTP id l5-20020ac80785000000b003a981f72d7fmr104698600qth.11.1673630979086;
        Fri, 13 Jan 2023 09:29:39 -0800 (PST)
Received: from [192.168.1.3] ([2600:4040:29fb:d300:887b:7eff:fe74:68b2])
        by smtp.gmail.com with ESMTPSA id l6-20020ac81486000000b003a981f7315bsm10853389qtj.44.2023.01.13.09.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 09:29:38 -0800 (PST)
From:   Peter Foley <pefoley2@pefoley.com>
Date:   Fri, 13 Jan 2023 12:29:36 -0500
Subject: [PATCH] scripts: coccicheck: Avoid warning about spurious escape
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230113-cocci-v1-1-0f4ae50494d3@pefoley.com>
X-B4-Tracking: v=1; b=H4sIAACVwWMC/x2NSQqAMAwAvyI5W+gCgn5FPLQxag5WSUQE8e9Wj
 8MMzA1KwqTQVTcInay85QKurgCXmGcyPBYGb32wzgWDGyIb59vQJI+2wQClTVHJJIkZl69eox4k
 n9iFJr7+QT88zwtagJvxcAAAAA==
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>
Cc:     cocci@inria.fr, linux-kernel@vger.kernel.org,
        Peter Foley <pefoley2@pefoley.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673630978; l=833;
 i=pefoley2@pefoley.com; s=20230111; h=from:subject:message-id;
 bh=v5ElnF2s+TFSKaksEa19tLKUsIOtwh2WjBET16twCuw=;
 b=1iFr8Ne5IpvgtFtEYGYG8MAj2N/lI6CDyjwiBXfV8ia3RDLcii2hvzzqXYK6VOeP6VTuTX5mfhGq
 7gxgpzQuBpFLX7t0s0VMeq+1u8Ua2XtBQzSwLUtdR5WkCLiARM3M
X-Developer-Key: i=pefoley2@pefoley.com; a=ed25519;
 pk=DCQqIdN6rHnvfQH58WQiQzJFfGUo1HyWSvdYG8vnO5o=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

e.g.
grep: warning: stray \ before -

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 scripts/coccicheck | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 2956fce8fa4f..fb492f032c5f 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -18,7 +18,7 @@ fi
 SPATCH_VERSION=$($SPATCH --version | head -1 | awk '{print $3}')
 
 USE_JOBS="no"
-$SPATCH --help | grep "\-\-jobs" > /dev/null && USE_JOBS="yes"
+$SPATCH --help | grep -e "--jobs" > /dev/null && USE_JOBS="yes"
 
 # The verbosity may be set by the environmental parameter V=
 # as for example with 'make V=1 coccicheck'

---
base-commit: d9fc1511728c15df49ff18e49a494d00f78b7cd4
change-id: 20230113-cocci-12936b2c06c3

Best regards,
-- 
Peter Foley <pefoley2@pefoley.com>
