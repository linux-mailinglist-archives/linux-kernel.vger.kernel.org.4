Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B9C67EEB1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjA0Tpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjA0ToU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:44:20 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBED32ED53
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:43:11 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4bdeb1bbeafso65144387b3.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z2/pTj5C3cgEFiOJp2CeCn46OI8ibDfme0ccGGe2ykQ=;
        b=Cb3p2QcNsUnk+wL6/K6P4ED35dG3ZUcB734zcAsddvwr/PVSkrRYzepHFsLMU82wqr
         DCByjFxSWTXuXxKpPzrEyhOes5tD65SfDW58DVPGzZ4bl/GM62EXvV72BYyh+FkQftRL
         9ik0iporDuduJD370bXV4KniJvgp40Hs/4xlWBjuzB4w/OEbzQnMEDOcEM26lHODokML
         801aFmGgsonG3Ea3SKObTIkdYEG/WUj/siwNQ/Elnoh6/xVR3ypDahdEx2v1JUXFD+l6
         cbwz8ftG3Ry5zhC62QLkQy0TB2bZZjts/vu8EdbF1X6krxdoifCb7qgLuiaEVqlGXvIi
         PdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z2/pTj5C3cgEFiOJp2CeCn46OI8ibDfme0ccGGe2ykQ=;
        b=bdCGFf6cMuLUD8Uq0vdVuagR1jKFPZaK89oZgrnVf+cdT806KX/aFulRurodZ05Wic
         ZklDK0jmmfqJUDy9eWGIauQ2QqqY4an1oDWRrwiHrqzpaf8jchuTh+2xojazDIv58kPB
         rK1UhTxJ7H/Kbogudyn2nD7Uqm6iPLCmieD/NLIO1qbrwRtbJV3Pav2EvSvs45Vf8cFl
         USWIEUwK+q2RmgRgzAgyRPK+4vkuEkIZBQkkiTus+V+9scNtStZZubxAySnUplfaSve9
         2RMbFH7y2R4LI72cNrQzIPs3MMRT5PR0kInlbrdjhwjlzcle0Dsl6LTSVib0utmL/FT0
         Hasg==
X-Gm-Message-State: AFqh2krdyO6GovkVmIQPCfNaF2t0HY+847oOKszqr56nYc+9andaG4jn
        TnviBoMycSLuODwXZInvKArrBiffd8c=
X-Google-Smtp-Source: AMrXdXvc0ioDltykhYGthi7quhcG5gFdvKFRYGkIf9fgUkYhxxt/rX6VwG8N7AhqKPLty1w08hNt6tf3mAM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:4e19:be9:c5d0:8483])
 (user=surenb job=sendgmr) by 2002:a0d:f6c2:0:b0:4dc:1241:cc0a with SMTP id
 g185-20020a0df6c2000000b004dc1241cc0amr6165876ywf.499.1674848512603; Fri, 27
 Jan 2023 11:41:52 -0800 (PST)
Date:   Fri, 27 Jan 2023 11:40:53 -0800
In-Reply-To: <20230127194110.533103-1-surenb@google.com>
Mime-Version: 1.0
References: <20230127194110.533103-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230127194110.533103-17-surenb@google.com>
Subject: [PATCH v2 16/33] mm/mmap: write-lock VMA before shrinking or
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
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        surenb@google.com
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
index 6fff76334177..60038c24d836 100644
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

