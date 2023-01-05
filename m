Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FED865E522
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 06:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjAEFfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 00:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjAEFf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 00:35:26 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15E35131B
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 21:35:22 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 141so5506956pgc.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 21:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4r1zqnoa/GOJgbipuY63hrj66rflDnjIXWSbNhuGNOs=;
        b=EGSjQuynS9un3JVTYO3IPwb/SKQnRRKPMu5l4AcWJwJkIa41oT44erlsdk340mhgJq
         QQ4vKm6QIvpotOqon7b9f6aRyGU7747+46h6H5V83squFiIRkZkqcgj1gtdQVyxoSXlb
         dFiimNWktvFQsLzrD88NlmZry7wSmMdtZ6Mis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4r1zqnoa/GOJgbipuY63hrj66rflDnjIXWSbNhuGNOs=;
        b=vaIO/w/P2iURXWtoXFlPRPsxZUFqOpcvIO3vPlxpKUNNhV6NTwnxu42dj02s3UnM/r
         eS5m1mFr04v4TmZ3HEvMmXMd3+KoSWDCaMpaB2/f/6tnWYdFrDve5wt33I0Eluxicj6P
         nhFZZMsqGEewZi3ybhsR+pJW6YnGn4YrXEorKTSK+R2FOs1122IXfo5VXW4j6sVhlgg+
         37td/PTC0pny1ySRsDo7vetGymeCY9hEvRis1EbauN/hHLowKhjdr+8+GEASAlUdgrN9
         d/P7o/BCw+MQGN2M5fC22hdxqg+PgXYQO0SbLcMFqn/mCvWCqcHjgorrohyz3hXtyKHK
         cWeQ==
X-Gm-Message-State: AFqh2kptdROd97KA5etBVtbxHWNpp9tPTqtgDmd5UwW2z1M6BeHSC7s3
        O5G6Xpff0fjW6frl1nheBoB6XX2iAEs0BQpt
X-Google-Smtp-Source: AMrXdXsbFn5JrU6+iN7GR2Oy3X56+lrbFBucclMH1z40yHL2DQWiwTRtQeyRqTl4hQABHoAJZOko9A==
X-Received: by 2002:a62:1e42:0:b0:582:a0e4:c45c with SMTP id e63-20020a621e42000000b00582a0e4c45cmr10615949pfe.3.1672896922299;
        Wed, 04 Jan 2023 21:35:22 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:da84:4bce:bb29:7dea])
        by smtp.gmail.com with ESMTPSA id v27-20020aa799db000000b00577c5915138sm2036855pfi.128.2023.01.04.21.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 21:35:21 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 0/4] zsmalloc: make zspage chain size configurable
Date:   Thu,  5 Jan 2023 14:35:06 +0900
Message-Id: <20230105053510.1819862-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	This turns hard coded limit on maximum physical pages
per-zspage into a config option. It also increases the default
limit from 4 to 8.

Sergey Senozhatsky (4):
  zsmalloc: rework zspage chain size selection
  zsmalloc: skip chain size calculation for pow_of_2 classes
  zsmalloc: make zspage chain size configurable
  zsmalloc: set default zspage chain size to 8

 .../admin-guide/blockdev/zsmalloc.rst         | 157 ++++++++++++++++++
 mm/Kconfig                                    |  19 +++
 mm/zsmalloc.c                                 |  72 +++-----
 3 files changed, 201 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/admin-guide/blockdev/zsmalloc.rst

-- 
2.39.0.314.g84b9a713c41-goog

