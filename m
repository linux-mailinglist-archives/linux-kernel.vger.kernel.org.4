Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2E767828F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjAWRFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjAWRFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:05:34 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80C21B55F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:05:23 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-142b72a728fso14624340fac.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybecE7vl8IXqIAJRMP/wGF59IDlD/hkvogtnVPzlVAI=;
        b=APL7TitIWu54rYa8SCVe8M3t0wMgLY+EV18cpTS1TnvN1zchHcLl1Ucf9YXLj3UDrT
         7NgDbZrD/5d1Ri7Y5BX5j4wEvWROYTj6Ah0D07piXUurw4bQNf8fHkltGPmYEovdFyir
         W9EIKbIvyhtvwkPubU2J5RShw8WGwD7mOV65YKKY+C8iQUexFcSXqJ8D+Nu/qoUYtrgr
         UDfKq36+TkUnpoof+BMglXhqxWwr95hspOcKgpJ0NxFlgRsNSWsde/dbjtRXeJJuWh+J
         e0Jus9A143Rj74MtKcxi6llOf07toQnooc0l0KLGRcLgGCvhUs8IrZwiXNMGjX99G0Ta
         FxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybecE7vl8IXqIAJRMP/wGF59IDlD/hkvogtnVPzlVAI=;
        b=SLT3EI7gaXd/6J04mt/obJCwey8QdREFx1AIqy+wOIki85SLGU4d1vU0V0zyosvqjW
         x+PEFzMf1i/kvCPzVyNzXaHS7/Cq4rCqNki4ETdqQxjIAgVqFNhNhT3cmE7w2nyW7HMM
         GVENMWBKyNekd9tTRdDVkyB1FxhmqfPjAVaNJ5yvOUuVSoDnH1MGED9hwInbs0s1ivX9
         emfDssSP6M4a2QUHHY2p26HOILI0kIP5+fzb3X5D5cpDM/Ni12xannB0pJUIJdepdM3v
         WaQDc1X+WkZI662QJA9C/OI4nCS1eKIQs3DhxMcPabWS6Gu8i/RyyYK4hqgxwzHso2oT
         BN6w==
X-Gm-Message-State: AFqh2kovHv5S5rBFtIzTezHLDB7+PAaKsceybavhiczaq2Qe9gK+ZxND
        aRkpZIdXtVLSFlTnfTDSye5/VVdcN5KcpIc3RNqfF8sTY7ma8sKgczBzItDrGhhHxMdj5gzZbDF
        LCRyahKuG3sqh5W3wUuGuhi82KY25QVM2DFR2ECgafPPBaXfc14mJeqpsXLA6OoDef4inax8zhE
        wrtIp1F3k4pQ==
X-Google-Smtp-Source: AMrXdXsRhvT7IPixwWUMSoAngcVnbBU4uqLsWAOHwwINbPYyJOELbPpvjBW1uZWQE2O5oDk3JmtS4w==
X-Received: by 2002:a05:6870:ab84:b0:15f:32b:6e46 with SMTP id gs4-20020a056870ab8400b0015f032b6e46mr13704980oab.49.1674493522851;
        Mon, 23 Jan 2023 09:05:22 -0800 (PST)
Received: from DESKTOP-B7RB26P.localdomain (cpe-70-114-202-97.austin.res.rr.com. [70.114.202.97])
        by smtp.gmail.com with ESMTPSA id 2-20020aca0502000000b0035ec1384c9esm23160163oif.23.2023.01.23.09.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 09:05:22 -0800 (PST)
From:   George Prekas <george@enfabrica.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        George Prekas <george@enfabrica.net>
Subject: [PATCH 8/9] mm: kmemleak: erase page->freelist in slab_destroy
Date:   Mon, 23 Jan 2023 11:04:18 -0600
Message-Id: <20230123170419.7292-9-george@enfabrica.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230123170419.7292-1-george@enfabrica.net>
References: <20230123170419.7292-1-george@enfabrica.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

slab_destroy frees the allocated memory pointed by page->freelist. It
should also erase the reference to it. Otherwise, when the memory is
reused for another object, kmemleak will find the stale pointer and
erroneously increase the reference count of the new object. That will
lead to undetected memory leaks.

Signed-off-by: George Prekas <george@enfabrica.net>
---
 mm/slab.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/slab.c b/mm/slab.c
index aa5eb725ee9c..12acce274502 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1625,8 +1625,10 @@ static void slab_destroy(struct kmem_cache *cachep, struct slab *slab)
 	 * From now on, we don't use freelist
 	 * although actual page can be freed in rcu context
 	 */
-	if (OFF_SLAB(cachep))
+	if (OFF_SLAB(cachep)) {
 		kfree(freelist);
+		kmemleak_erase(&slab->freelist);
+	}
 }
 
 /*
-- 
2.37.1

