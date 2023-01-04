Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C773365DF03
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 22:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240220AbjADV1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 16:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239952AbjADV1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:27:25 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1722C41019
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 13:21:03 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so35792614pjj.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 13:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6hfBhSBEeVR/Fn0HrEuQ880MYtC3rq93jEqLDWrIRMw=;
        b=d/ljK1xNjvnmNQPClypMY7NthrX0dJ4f1EmgRBS4ehLUulZzgPMuUxNL14jLhPbdRk
         VB0imrhMZluktlgYVbD+MPXO1MHEQ7Z0Vsr+LkXuTeneVml+HlS01FkJlcAIMVN4T7uy
         7kgwDCHGZcv9kxNJ+gORs6nIPJ7Nf2suk5LMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6hfBhSBEeVR/Fn0HrEuQ880MYtC3rq93jEqLDWrIRMw=;
        b=6e5sC9CtHtlMOFO8lF99eiPdnOBp+VqcnFqNR9Qh/fGpCrqUs6SnSkmNlbmEdGeWfx
         7z4ePvGc+lzArv1Dl95vm/5DOu+F8v8pYCKA5hYuNQE3pAg7AdotY1H1UNsv2iz6qNUg
         8Ja2525wj2oVvWChx299Afq7O5v4gfHtQtgBuZLKV17/zgGhgDGHUK2A7Gci+eXSByQC
         RmpfpaLyYycIIRDDHUsUCKiZhpAMKxkQ85IX6oPCIMLiy4BbCqxMeeZ+acKUByH1N/77
         1lSyEARg85y6ef8BaDBg69/JqyhLEvf+5SvlZsqXQCMMZIa8F/aeFII78Y3TFum1q9y7
         jZpw==
X-Gm-Message-State: AFqh2krNEL2CcqYy4fNE4+egFIlguLi9phlj7PZ2PJnaejZ9madxR5kW
        owgUisjkjVS8WR1lGIK2CyziSa9PbhbHF9KG
X-Google-Smtp-Source: AMrXdXsKeXGtpr519xCOW080RFZiOWAh2y3jl+hgdaKT4z5qNzxQ6kZou5BSE/2l/r0y2R+hR0AEPg==
X-Received: by 2002:a17:902:ca89:b0:189:76ef:a1b0 with SMTP id v9-20020a170902ca8900b0018976efa1b0mr46271243pld.57.1672867254539;
        Wed, 04 Jan 2023 13:20:54 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d3-20020a170902cec300b00186a2274382sm24766893plg.76.2023.01.04.13.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 13:20:54 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Nick Terrell <terrelln@fb.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] lib: zstd: Fix -Wstringop-overflow warning
Date:   Wed,  4 Jan 2023 13:20:52 -0800
Message-Id: <20230104212048.gonna.331-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2611; h=from:subject:message-id; bh=HrYRlSpiw8NjSGyFfOnlBNqAWT9ChuUQa2gPPnHJcLg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjte2zv2TP+E05u9eD5sdJ7UCLi1M9EXgRuP8lLkxo Uy3r3xCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY7XtswAKCRCJcvTf3G3AJhB8EA CCGVmAc8Aoj7WuJx6zozmcccDcX1XIx12OZxp1wjb4/PJViRqYgqenc8t3l9FEuDDrVp096BX0ZuPx iALCAAWaHIviy+r0qB9gB1VTYUQs0+LM91DKWWpVZ3+l3okrT6+kZBUr7HAZQF1eH0u2qgBwb/E8JY LuwQH/MtMe+Eto/i6E93Zgh7kKo3CJDEEi/T1H/mYpyd/pGlzYi2LZdUaZEOuaaOprsHIAzqAt4jAw a3KGj7mFh0bbsyzNMz+CEFrawOMXHTYu+YU6baQG6nOn8Fxvr8Jb4i1YH9MnnE2mFUGSR9a55xzuaf Jl4JMzphl9PvhmubtsC09JR3oUrkQRkcOeSeTiVXdLuSb/qM8D4PLafSwboZGvCD2TvcVAhkvl2ysM 4Atj8B6HNB8DEBZViLvD1qzvnwFgnIr42X1QYt1N3w9qZ5SKXEvbfChWXqkks65KYzx67SLPovV01k PrQOTqTJg77vwAXVgNHN/I7xtJEerRGkeULDmdhz/63xnnZJdd3dHwimOgi1aJR8EarsinDXdPdFe0 jbnViZrRumskAa0LkT7+GrA2k0Sm1ptN8+y+5S71fkI/vlp2KsjNkqmda6ui27VSqphwKlof2b8hyz qAsr5PaYGjYFZO0r8CL+wCipiDiXQTTrcDvMN92oFQjyDkz/Cp2Xw7zbnvaA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following -Wstringop-overflow warning when building with GCC 11+:

lib/zstd/decompress/huf_decompress.c: In function ‘HUF_readDTableX2_wksp’:
lib/zstd/decompress/huf_decompress.c:700:5: warning: ‘HUF_fillDTableX2.constprop’ accessing 624 bytes in a region of size 52 [-Wstringop-overflow=]
  700 |     HUF_fillDTableX2(dt, maxTableLog,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  701 |                    wksp->sortedSymbol, sizeOfSort,
      |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  702 |                    wksp->rankStart0, wksp->rankVal, maxW,
      |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  703 |                    tableLog+1,
      |                    ~~~~~~~~~~~
  704 |                    wksp->calleeWksp, sizeof(wksp->calleeWksp) / sizeof(U32));
      |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/zstd/decompress/huf_decompress.c:700:5: note: referencing argument 6 of type ‘U32 (*)[13]’ {aka ‘unsigned int (*)[13]’}
lib/zstd/decompress/huf_decompress.c:571:13: note: in a call to function ‘HUF_fillDTableX2.constprop’
  571 | static void HUF_fillDTableX2(HUF_DEltX2* DTable, const U32 targetLog,
      |             ^~~~~~~~~~~~~~~~

by using pointer notation instead of array notation.

This is one of the last remaining warnings to be fixed before globally
enabling -Wstringop-overflow.

Co-developed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: Nick Terrell <terrelln@fb.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: use "rankValCol_t *" instead of U32
v1: https://lore.kernel.org/lkml/20220330193352.GA119296@embeddedor/
---
 lib/zstd/decompress/huf_decompress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/zstd/decompress/huf_decompress.c b/lib/zstd/decompress/huf_decompress.c
index 89b269a641c7..60958afebc41 100644
--- a/lib/zstd/decompress/huf_decompress.c
+++ b/lib/zstd/decompress/huf_decompress.c
@@ -985,7 +985,7 @@ static void HUF_fillDTableX2Level2(HUF_DEltX2* DTable, U32 targetLog, const U32
 
 static void HUF_fillDTableX2(HUF_DEltX2* DTable, const U32 targetLog,
                            const sortedSymbol_t* sortedList,
-                           const U32* rankStart, rankVal_t rankValOrigin, const U32 maxWeight,
+                           const U32* rankStart, rankValCol_t *rankValOrigin, const U32 maxWeight,
                            const U32 nbBitsBaseline)
 {
     U32* const rankVal = rankValOrigin[0];
-- 
2.34.1

