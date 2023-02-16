Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2258698BB4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjBPFUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjBPFTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:19:19 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97D742BD8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:45 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id p7-20020a257407000000b0091b90b20cd9so869939ybc.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gs5XDlSmqlz144wCEPg25vfe9kudkVyQE95J1Pewv8Q=;
        b=NZSRPVmVQg07iGqxuaNSoyEyX/JUlE5074LqD7StZA8wPOZx80SXxNMt5E5KxxrtoC
         5GmbXen1kftSSNBaHdmndb327iEU+JgvGlsjv+jrut0kw6bBF6uNimcKzz4dFOSEItYW
         Y4LEl4ERFvkTfh+pRssZBSprx0WHPyqr3iZkWvDeufJqDlNo5Dl9o53Xv9skjZ4WRCg9
         pPw2zfwLYTP83BBCg7T3fM4u8tR26MmRDA1XMM3A/clmWDV/BI6rgpWB66aseND2aMHJ
         sak6MgPcdV5XEwJQs9ETMkutqiCQEhW6TAM4KAr4SAjK7KgYItsJ/rcb5RNyZGDs+f6q
         Q5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gs5XDlSmqlz144wCEPg25vfe9kudkVyQE95J1Pewv8Q=;
        b=z5HT4SprMcPNuNcT3lm4djTjfO3QyMjxUIKUeVcycvYqZ9+Yhz5oyJyKR93sl/bIxJ
         hZbvWKKE1WpGQuDnImLs2vScmX/viRzHYfK7MomFeykWIbeTaA92ell6w58ykjrFdsbb
         +PtuSkGY6Qq3FCWGCygCUsxir5cHEoSxmZ/Xb5SgZOLlvh7QDmt0Qo1lTyJBP3YoGutp
         RsEadFbhoNPhtJIrUI8BOyVkOCUfMi+NfOcX9d5yS8or9eE3hizsw8TadZ1AB49L+MA4
         AGfMwyUBJQpCCweZk2pCiFgRpvizP8sNebKxIP9njMMHKcSoZwqs7myyMyPUNc/OjzLT
         iCUw==
X-Gm-Message-State: AO0yUKWaWg8YbSJgw9u+VRqFYHL33ZJsinlugrWsfA723BW8PENHxxPN
        /QrRTGxHx7kZy0WEdE26EllXwamHcrw=
X-Google-Smtp-Source: AK7set81sG3yc9X92pQzrCT4qIFN1iEujQCfNrT8GtjdXbA2djctnG24/XowjsXx2FP9/9bsOvEUQhAtEC0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f781:d5ed:1806:6ebb])
 (user=surenb job=sendgmr) by 2002:a81:9345:0:b0:52e:e6ed:30bb with SMTP id
 k66-20020a819345000000b0052ee6ed30bbmr607996ywg.571.1676524715849; Wed, 15
 Feb 2023 21:18:35 -0800 (PST)
Date:   Wed, 15 Feb 2023 21:17:32 -0800
In-Reply-To: <20230216051750.3125598-1-surenb@google.com>
Mime-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230216051750.3125598-18-surenb@google.com>
Subject: [PATCH v3 17/35] mm/mmap: write-lock VMA before shrinking or
 expanding it
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        chriscli@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, rppt@kernel.org, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vma_expand and vma_shrink change VMA boundaries. Expansion might also
result in freeing of an adjacent VMA. Write-lock affected VMAs to prevent
concurrent page faults.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index ec2f8d0af280..f079e5bbcd57 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -674,6 +674,9 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		ret = dup_anon_vma(vma, next);
 		if (ret)
 			return ret;
+
+		/* Lock the VMA  before removing it */
+		vma_start_write(next);
 	}
 
 	init_multi_vma_prep(&vp, vma, NULL, remove_next ? next : NULL, NULL);
@@ -686,6 +689,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (vma_iter_prealloc(vmi))
 		goto nomem;
 
+	vma_start_write(vma);
 	vma_adjust_trans_huge(vma, start, end, 0);
 	/* VMA iterator points to previous, so set to start if necessary */
 	if (vma_iter_addr(vmi) != start)
@@ -725,6 +729,7 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (vma_iter_prealloc(vmi))
 		return -ENOMEM;
 
+	vma_start_write(vma);
 	init_vma_prep(&vp, vma);
 	vma_adjust_trans_huge(vma, start, end, 0);
 	vma_prepare(&vp);
-- 
2.39.1

