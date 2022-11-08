Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144AC621C53
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbiKHSpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiKHSoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:44:34 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F4B53EED
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 10:44:21 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id q71so14128529pgq.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 10:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JH2QhHpqacgVEtOu6V/3tcH+ucME36GLS7VYH7bPh2s=;
        b=gfgIf/HAVM/kaYeBJhJkJ8cAIt9JH8FVUt8AbdjcL2gtn5i2PkRUCbfffZxgLEJQda
         Op9+9xqJl1ZSfgbDb+QoJ31XG+Y7SoFu3phXGIBD/BAi48blSD4Cy/m5cY1F0tBCCosf
         sqct8v5HRhlNHTPkORouibJhLs16Y7nwqpA3GX3imljNb0GU6S/UFK+giUcl8+WjhnN5
         Jhgs1R1yrL0LPw2NKGkTs68Wa7hEfQkcCL9yNDgDFKkiTiH5RLEcLhiNglxXwAeW8Uzo
         UcsL257ewqmAUoHotpTt0ChgTn0CRmrq9BUeYpjYOqjLQQOFJ/8Bt0RwKzS6v/mY7Jl5
         SKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JH2QhHpqacgVEtOu6V/3tcH+ucME36GLS7VYH7bPh2s=;
        b=V8JBgYMMIg4gj87LH3jLdNmP0Rz4J7AjnManu9CAVIirZ8sUiEWB27lN2mHDDpixPl
         JN/Bf3Sty0V3nnXKtR8j0MoJ61qusAgfoWpxVXIDFY7Q5xBL84Zdl2z9S+QYHBQLRLU1
         BW8TV3jrT1yNqaSSr63SiH/LsCjqoAQDQnhhQ5A/sXhlb7fVyx3oXo5bmagNnEXnliCx
         IjLJP9JbjANcimONxrmjIGRMSZH/j1PK7ElMmo54Ww7tgW/VZ0UWNswZsa1ZQUrzwJ4X
         WuXTKD1K3Y2SAYXUR6NkC3ERlEnPzj87+/srZeCSIBDQS+9fu7/HbvfyZ9T4Tp0f94Ay
         LObg==
X-Gm-Message-State: ACrzQf2xvKzpFRw+dliBbUOTiItDqGYITm6+YlyoBKaxNRUfDSgsvO+G
        IH/7rXmI623cDGJCZJTXVIg=
X-Google-Smtp-Source: AMsMyM4PVPwARffTYpnfKIvuWpr70fVa/7XOUmPKj6m5uJOzRmuzpTdhkZzWLkvkEwznfbYUe1f4vw==
X-Received: by 2002:a63:1652:0:b0:470:4524:dc9e with SMTP id 18-20020a631652000000b004704524dc9emr18476984pgw.402.1667933061111;
        Tue, 08 Nov 2022 10:44:21 -0800 (PST)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id ij22-20020a170902ab5600b0017f36638010sm7210438plb.276.2022.11.08.10.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:44:19 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     zokeefe@google.com, mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [mm-unstable v3 PATCH 1/3] Revert "mm: don't warn if the node is offlined"
Date:   Tue,  8 Nov 2022 10:43:55 -0800
Message-Id: <20221108184357.55614-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 6baf85a005ad36dd8586e5c3de598f8c3059dc91.
---
 include/linux/gfp.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 594d6dee5646..ef4aea3b356e 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -218,6 +218,7 @@ static inline struct page *
 __alloc_pages_node(int nid, gfp_t gfp_mask, unsigned int order)
 {
 	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
+	VM_WARN_ON((gfp_mask & __GFP_THISNODE) && !node_online(nid));
 
 	return __alloc_pages(gfp_mask, order, nid, NULL);
 }
@@ -226,6 +227,7 @@ static inline
 struct folio *__folio_alloc_node(gfp_t gfp, unsigned int order, int nid)
 {
 	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
+	VM_WARN_ON((gfp & __GFP_THISNODE) && !node_online(nid));
 
 	return __folio_alloc(gfp, order, nid, NULL);
 }
-- 
2.35.1

