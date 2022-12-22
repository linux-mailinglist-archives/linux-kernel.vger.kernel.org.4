Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B040F6546E2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiLVTsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiLVTss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:48:48 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EB21838B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:48:42 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id y8so2661751wrl.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WF0czWG0z2T4oq6TY2ZkLRE6dWmClGYr0kuRjGhgjlc=;
        b=MwlMQDojPRl1N9RKswNye3CDEdP22NLQDZUxmKlxgtsd8sFEE9avKa8OUrmMpIrDOo
         Aon+VZIurNEFXw6IJhGWiW+VFEAsegrOwl4WFS1jMQhSQ5fZh3XoJaiY3BPkj5/zlcm9
         aN38lXwyHCc7/V4rdO312r8Rzu8HSP5ddz77APwlAgLiQYiClEaE34pMSo61W49YSVT7
         BwALNp1tPo0ADZziuee4Kvo+X8H5L0NfrheCjhDjPGWO+Th4gUZ2AKvDQ+t9agou4j6U
         FYgZ5sqQNPaMOSkhV9S2NrQpntsNyJKqeeJDicruSV1dKsr1Q2tLYk/lap/UrDzmUn+O
         lQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WF0czWG0z2T4oq6TY2ZkLRE6dWmClGYr0kuRjGhgjlc=;
        b=Pd8AYuyAM5Xn9AG5MhpMHumJm3eW2SwRdZXEusQt17OuoLLXwSgyrdNLgMVDXF2TnW
         rKr2Zwg0C55gO4X5/6uRgR4YgKGn0xjr9+dRyqjNSlUrpCmfCV40audGXvVVJrznhuJn
         Z0bIgKIjYA8Phcnqb8C2JJ7XFlDnalcYQJFWX5DPqRbNvgyg4Hmx0O7nTw7m/vNSNHk/
         CB+ZR46X6R4d8D+of20jHvv6kVr/Dfix+JU3f6bOaDNuG22PUJkWRB6U//klmlAxxK8N
         eHgsLBke3bnhzFA2+1B77N4cgBP7PZY55byWnD8BTLFf7GD2B3IqT1d+CFFJb/QayhNq
         RWGw==
X-Gm-Message-State: AFqh2kqRPqvLnn6aCugIuQo65b2lFPoa4dyYP+RZcZ5dKR2ppJnFiMdM
        6/EjlYIVwx9ecc5b45AOfVc=
X-Google-Smtp-Source: AMrXdXsY64F/wSGDz+J4qfQmolIKAjlZatXRULqtAUfDbCSbyupYNuq2zWD2zglwlDhx08crJ3WGiQ==
X-Received: by 2002:a05:6000:128a:b0:236:7591:cf13 with SMTP id f10-20020a056000128a00b002367591cf13mr4904284wrx.40.1671738520872;
        Thu, 22 Dec 2022 11:48:40 -0800 (PST)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id i1-20020adfb641000000b002425787c5easm1349317wre.96.2022.12.22.11.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 11:48:40 -0800 (PST)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <liam.howlett@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH 1/4] mm: pagevec: add folio_batch_reinit()
Date:   Thu, 22 Dec 2022 19:48:30 +0000
Message-Id: <f05b330bc806aa64f6ae5d0001ea9d29d47da354.1671738120.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1671738120.git.lstoakes@gmail.com>
References: <cover.1671738120.git.lstoakes@gmail.com>
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

This performs the same task as pagevec_reinit(), only modifying a folio
batch rather than a pagevec.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 include/linux/pagevec.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 215eb6c3bdc9..2a6f61a0c10a 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -103,6 +103,11 @@ static inline void folio_batch_init(struct folio_batch *fbatch)
 	fbatch->percpu_pvec_drained = false;
 }
 
+static inline void folio_batch_reinit(struct folio_batch *fbatch)
+{
+	fbatch->nr = 0;
+}
+
 static inline unsigned int folio_batch_count(struct folio_batch *fbatch)
 {
 	return fbatch->nr;
-- 
2.39.0

