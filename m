Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AED96C8A4B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 03:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjCYCqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 22:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjCYCqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 22:46:45 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB331B2C5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 19:46:45 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so3365849pjz.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 19:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679712404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ertGgOCPC3YjWIL6B+j1WyltPx6+X44t3T9Dfq8TDO8=;
        b=H4Uol1cO7x6dkLKmgVJCtlEPbyk5WI1lLJLc57rJYO5SQA6kMITQVHxNeGGxZ9M8Iq
         pNZL3snUHp7A7ELjpuXdMLiLuhlgcc6FaK0Tdp7SDuXNxTw6Nz8S7vf6lMJStUacWQXN
         RkOW1dVIOq/MWhITlqJ7EC9mXUsH9MDoE/S+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679712404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ertGgOCPC3YjWIL6B+j1WyltPx6+X44t3T9Dfq8TDO8=;
        b=CcDoQUwdBqYFgGN+8Ll/O29iFvas1u4EySKnquIn7Mxm2MM4UEj4CGlgXKojfDTA+z
         m0JdJq8CATx7LI/DjI6rl/336EfyUi342C0+MjDWWrcdTUsXC2zFN2XOPwsu2xp0GFVs
         X32wntB+65Co36drECjRzWdLez3lc+xMOEDFhCOLV+pDnQo9P7g1rHEyDsiDQZFQE+vw
         SlXJQ84fPMYFZtRBANccnVCuAdf2/d//Lx9Y1rzzpeMoSO9LrvZtCBCuhieQgQrPPlUu
         TSNdFsp348l2y5WEpVKJF3JTtvjTYAppGxWciG1sW9ArdPhgqznnLf+UAdzU6jsfKfXE
         auhg==
X-Gm-Message-State: AAQBX9eDfeKkXfwWMTbIB1oDMop3qYwya/Sj2aMd/oDi9E7gs+1sFP4b
        dh1ivNze3mJoNJyDRCeFvDWoGA==
X-Google-Smtp-Source: AKy350au84O5zSgaUu/AUBu3IwQWtPCh/tHO+7MXfd22tljffRG63bOdi7TF/kGtnQ9/WRAqDRkaTw==
X-Received: by 2002:a17:90a:7306:b0:237:b702:499f with SMTP id m6-20020a17090a730600b00237b702499fmr4976033pjk.22.1679712404643;
        Fri, 24 Mar 2023 19:46:44 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6179:9cb5:be4d:f76b])
        by smtp.gmail.com with ESMTPSA id hv19-20020a17090ae41300b0023b4d33bedbsm3675840pjb.21.2023.03.24.19.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 19:46:44 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 2/2] zsmalloc: document freeable stats
Date:   Sat, 25 Mar 2023 11:46:31 +0900
Message-Id: <20230325024631.2817153-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230325024631.2817153-1-senozhatsky@chromium.org>
References: <20230325024631.2817153-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When freeable class stat was added to classes file (back in 2016)
we forgot to update zsmalloc documentation. Fix that.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/mm/zsmalloc.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/mm/zsmalloc.rst b/Documentation/mm/zsmalloc.rst
index 3c6bf639887f..a3c26d587752 100644
--- a/Documentation/mm/zsmalloc.rst
+++ b/Documentation/mm/zsmalloc.rst
@@ -83,6 +83,8 @@ pages_used
 	the number of pages allocated for the class
 pages_per_zspage
 	the number of 0-order pages to make a zspage
+freeable
+	the approximate number of pages class compaction can free
 
 Each zspage maintains inuse counter which keeps track of the number of
 objects stored in the zspage.  The inuse counter determines the zspage's
-- 
2.40.0.348.gf938b09366-goog

