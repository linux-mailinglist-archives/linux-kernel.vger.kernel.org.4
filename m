Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3485B4D23
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 12:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiIKJ74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 05:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiIKJ7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 05:59:38 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB131131
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 02:59:32 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id h21so4339675qta.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 02:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=XLM1m2iZcSFN7zEYtkuHYYcYmZjAkeATO8o3pAdAyoQ=;
        b=dK8IGsH1J6j5irLf37g7ieCD4ck/MOLB0cramE5RrrjgdpHHVF5mw5wd2s75b3a94l
         2XA1exMylYG3mBaBY4drslL3G2Wr58g/tKZyaR96Rjny+antzG4vSdeJU2jjsZgJbOwh
         l1rarVtoxM8hJuVE4cMZGXQFYRc3sAcijxxs4gqKwGwmOjAgw2SLhZ4+S7KCauil99p5
         lwRlQBl5+O38nc8RwZA0hjvs3NWijTbLtlasFVm0u2mY3vvH3iQsqjw6uxhf8vZkmj3U
         6E5zxQdKtcdl1TOzLfLHVK9qZEpQFtXtJmdpxEwvF3ur9Pyt/REZjxQzTHQFILIPhjA9
         IK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XLM1m2iZcSFN7zEYtkuHYYcYmZjAkeATO8o3pAdAyoQ=;
        b=MbWrHjzyWB4uXALVBqIOin/ukQ9x05rTKFrr8YoXUe0lX+bZ4JxJUKyZA7XZ82vV0O
         8SsZz5C/BudQ2nWyUg8/rQlUTGDtpswuP56xhtvQExvuWTnGeACWnX6VFXVYME5XGkpJ
         EwwBRbNY94thzCAXbmerWGPrrHcb7thR05aaAJH1a0qVW/TBst6HFlLhclde9Ee+joD9
         MpDPsirxT1A/8ZUqmNb7sPSFu6id8/uTUQQljU7TaD1NXXJ8OecS2U3ms/4sUuxDwo2F
         LPi0gjzP9zCv8Fq/G2RJTiGY8mSfURwQv6P15xJn8H4SbZ6kg9fdgJ26oPr5WIjXv4z6
         BBXw==
X-Gm-Message-State: ACgBeo3Bay5sIlCmrLsjmRpEvS4YemAkyJ2b/W3n+mZZ3hsNaR13DunS
        /Jr19ywwdPMgPLnh9JG9gnU+Cw==
X-Google-Smtp-Source: AA6agR6jAmuFf2yJvMnDJ68B5wtvIomz7XM30r86b++gsxlkrxwEhuDJSX45o24EeDA83ZFIOnD1zQ==
X-Received: by 2002:a05:622a:6027:b0:343:5691:93de with SMTP id he39-20020a05622a602700b00343569193demr19278780qtb.165.1662890371433;
        Sun, 11 Sep 2022 02:59:31 -0700 (PDT)
Received: from soleen.c.googlers.com.com (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id y29-20020a37f61d000000b006cbd60c14c9sm4625233qkj.35.2022.09.11.02.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 02:59:30 -0700 (PDT)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, akpm@linux-foundation.org,
        corbet@lwn.net, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com
Subject: [PATCH 3/3] doc/vm: add information about page_table_check=panic
Date:   Sun, 11 Sep 2022 09:59:23 +0000
Message-Id: <20220911095923.3614387-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220911095923.3614387-1-pasha.tatashin@soleen.com>
References: <20220911095923.3614387-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default behavior of page table check was changed from panicking
kernel to printing a warning.

Add a note how to still panic the kernel when error is detected.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 Documentation/mm/page_table_check.rst | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/mm/page_table_check.rst b/Documentation/mm/page_table_check.rst
index 1a09472f10a3..9306cd75647c 100644
--- a/Documentation/mm/page_table_check.rst
+++ b/Documentation/mm/page_table_check.rst
@@ -16,13 +16,13 @@ Page table check performs extra verifications at the time when new pages become
 accessible from the userspace by getting their page table entries (PTEs PMDs
 etc.) added into the table.
 
-In case of detected corruption, the kernel is crashed. There is a small
-performance and memory overhead associated with the page table check. Therefore,
-it is disabled by default, but can be optionally enabled on systems where the
-extra hardening outweighs the performance costs. Also, because page table check
-is synchronous, it can help with debugging double map memory corruption issues,
-by crashing kernel at the time wrong mapping occurs instead of later which is
-often the case with memory corruptions bugs.
+In case of detected corruption, a warning is printed or kernel is crashed. There
+is a small performance and memory overhead associated with the page table check.
+Therefore, it is disabled by default, but can be optionally enabled on systems
+where the extra hardening outweighs the performance costs. Also, because page
+table check is synchronous, it can help with debugging double map memory
+corruption issues, by crashing kernel at the time wrong mapping occurs instead
+of later which is often the case with memory corruptions bugs.
 
 Double mapping detection logic
 ==============================
@@ -52,5 +52,7 @@ Build kernel with:
 
 - Boot with 'page_table_check=on' kernel parameter.
 
+- Boot with 'page_table_check=panic' in order to panic when error is detected.
+
 Optionally, build kernel with PAGE_TABLE_CHECK_ENFORCED in order to have page
 table support without extra kernel parameter.
-- 
2.37.2.789.g6183377224-goog

