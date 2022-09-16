Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B7D5BB098
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 17:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiIPPzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 11:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiIPPy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:54:57 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCD6201B6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 08:54:55 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id 13so21395055ejn.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 08:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=EuWFWN26twjl6pnBL7u1oZiY5YRuiq7q1++u96G3pgY=;
        b=EoQJiVAYTrd4M3+DKqSvM9nCwEIljCqrB31LX/Mf3YTd9IN1mXiqpwdfmYb1HmzhSF
         hBXK9YQ4RNqyZzeDWzGuAExSL8cI7LfiyjoHgtvsnZmoTCP0xOrpNd+c46PDGFtKDrft
         arPkvo2nWfkQBevvVRQORFApZ7E1ncEhBKau6WEfbADES93CreFsNJaTUq2Cb3uUhb1G
         MoF0+YsZKJ04z84ZAfyGHcwhZIYZEMzvjx+l2SfhjkDO4OLQpIXjsNG684fnZ9HP5Y2z
         PBq0MP9cq0SS8L/cQGrLrtmJHJZCn04wDe3dVYkHhYn68gk8mi9PfgIMl7NNv8ut9uTM
         jIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=EuWFWN26twjl6pnBL7u1oZiY5YRuiq7q1++u96G3pgY=;
        b=ns6EQPqHl/NWP38CIuh3WPPFoHIT3ngmsyRr11914kIGd8Yf2uClDxidw0dB0Qvf69
         FynccPVFVMusgAmfQP+ukrZMF9mTKJZeDZtE9WI+nElhukXb7/PJwzGWG+jYAJTAikVA
         63hXv0+Q/dzx0ry27F197OfZaW7Q3FyUpm6XWGCIT4B5vdiybdWfUD611GHk9hux9dDN
         PWFz4aY6yLVvLk/dhSU8OHGXLz7j2HonwXyd1ORrcvtAmhJGIqqKQBoFexHlWNZojsE8
         dfwBZ4k5yiKG9qDjOYmA/dhkrPiOhW2TzGoBom5lL/BXnNeeyMkMTdrOglqFMKIFXfcM
         LNLA==
X-Gm-Message-State: ACrzQf193SHnyUAjIouAUC6opxBjtHhRACDTbEX6nBWa3HZgktkCnHrO
        bELutfzPQ8UuY3rEHTQZ91me3r7vMS9t1aAFPb8=
X-Google-Smtp-Source: AMsMyM5S2RFtr9n8n8rdNH6foyfaJk78kYuOTBmn+L2hXS5/Y0XV9NEVfOYZSy1QOWTfM/qwcuFWq3lkxQaCptutRsM=
X-Received: by 2002:a17:906:8a77:b0:780:a02d:ca4a with SMTP id
 hy23-20020a1709068a7700b00780a02dca4amr2848192ejc.488.1663343694459; Fri, 16
 Sep 2022 08:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAJedcCxVW++iH49UFZp9ruUuTcNubWCH6Wsqe11K4COB3E8msg@mail.gmail.com>
 <CAJedcCw1eJqjSK+yR7eQMDheNtH3Mjm+viwt00xAhnmrfpq2pw@mail.gmail.com>
 <CAJedcCweHjD78F7iydiq6Xc2iH=t_3m=H9JKnaCooToUk32FvQ@mail.gmail.com>
 <YxWtfjfpNsoPUrgh@kroah.com> <CAJedcCzMo51aiy=Dv7zn7VmL3gwkw7JgzwAPAB2Z27C9CnhoYA@mail.gmail.com>
 <20220907030754.GU1089@zhen-hp.sh.intel.com> <CAJedcCxO_Rq0qMeLiHtY5+FuN1A1pDGsZd3gMtvUpm1xbAK3aA@mail.gmail.com>
 <Yxmzj2nCoTKurCY8@kroah.com> <CAJedcCwVC6Rg+wF7h6GhFvL6BGkKV=DS9Mo9fOf-gfDAk9VqPg@mail.gmail.com>
 <CAJedcCxRQ4h-ChNsD4OWpDMUJd3JNaQrvD=uVKxMpYONGFUgzA@mail.gmail.com> <YyQzDlM5n7mOLh5Q@kroah.com>
In-Reply-To: <YyQzDlM5n7mOLh5Q@kroah.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Fri, 16 Sep 2022 23:54:42 +0800
Message-ID: <CAJedcCzt_1ZRV5egMLdoFVZ4hBDE+nDu9fLkBuGY0A=uYicvQA@mail.gmail.com>
Subject: Re: [PATCH] drm/i915/gvt: fix double-free bug in split_2MB_gtt_entry.
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        "alex000young@gmail.com" <alex000young@gmail.com>,
        "security@kernel.org" <security@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "tvrtko.ursulin@linux.intel.com" <tvrtko.ursulin@linux.intel.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        xmzyshypnc <1002992920@qq.com>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "zhi.a.wang@intel.com" <zhi.a.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From afe79848cb74cc8e45ab426d13fa2394c87e0422 Mon Sep 17 00:00:00 2001
From: xmzyshypnc <1002992920@qq.com>
Date: Fri, 16 Sep 2022 23:48:23 +0800
Subject: [PATCH] drm/i915/gvt: fix double-free bug in split_2MB_gtt_entry

There is a double-free security bug in split_2MB_gtt_entry.

Here is a calling chain :
ppgtt_populate_spt->ppgtt_populate_shadow_entry->split_2MB_gtt_entry.

If intel_gvt_dma_map_guest_page failed, it will call
ppgtt_invalidate_spt, which will finally call ppgtt_free_spt and
kfree(spt). But the caller does not notice that, and it will call
ppgtt_free_spt again in error path.

Fix this by only freeing spt in ppgtt_invalidate_spt in good case.

Signed-off-by: Zheng Wang <hackerzheng666@gmail.com>
---
 drivers/gpu/drm/i915/gvt/gtt.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index ce0eb03709c3..550519f0acca 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -959,7 +959,7 @@ static inline int ppgtt_put_spt(struct
intel_vgpu_ppgtt_spt *spt)
    return atomic_dec_return(&spt->refcount);
 }

-static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *spt);
+static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *spt, int
is_error);

 static int ppgtt_invalidate_spt_by_shadow_entry(struct intel_vgpu *vgpu,
        struct intel_gvt_gtt_entry *e)
@@ -995,7 +995,7 @@ static int
ppgtt_invalidate_spt_by_shadow_entry(struct intel_vgpu *vgpu,
                ops->get_pfn(e));
        return -ENXIO;
    }
-   return ppgtt_invalidate_spt(s);
+   return ppgtt_invalidate_spt(s, 0);
 }

 static inline void ppgtt_invalidate_pte(struct intel_vgpu_ppgtt_spt *spt,
@@ -1016,7 +1016,7 @@ static inline void ppgtt_invalidate_pte(struct
intel_vgpu_ppgtt_spt *spt,
    intel_gvt_dma_unmap_guest_page(vgpu, pfn << PAGE_SHIFT);
 }

-static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *spt)
+static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *spt, int is_error)
 {
    struct intel_vgpu *vgpu = spt->vgpu;
    struct intel_gvt_gtt_entry e;
@@ -1059,9 +1059,11 @@ static int ppgtt_invalidate_spt(struct
intel_vgpu_ppgtt_spt *spt)
        }
    }

-   trace_spt_change(spt->vgpu->id, "release", spt,
+   if (!is_error) {
+       trace_spt_change(spt->vgpu->id, "release", spt,
             spt->guest_page.gfn, spt->shadow_page.type);
-   ppgtt_free_spt(spt);
+       ppgtt_free_spt(spt);
+   }
    return 0;
 fail:
    gvt_vgpu_err("fail: shadow page %p shadow entry 0x%llx type %d\n",
@@ -1215,7 +1217,7 @@ static int split_2MB_gtt_entry(struct intel_vgpu *vgpu,
        ret = intel_gvt_dma_map_guest_page(vgpu, start_gfn + sub_index,
                           PAGE_SIZE, &dma_addr);
        if (ret) {
-           ppgtt_invalidate_spt(spt);
+           ppgtt_invalidate_spt(spt, 1);
            return ret;
        }
        sub_se.val64 = se->val64;
@@ -1393,7 +1395,7 @@ static int
ppgtt_handle_guest_entry_removal(struct intel_vgpu_ppgtt_spt *spt,
            ret = -ENXIO;
            goto fail;
        }
-       ret = ppgtt_invalidate_spt(s);
+       ret = ppgtt_invalidate_spt(s, 0);
        if (ret)
            goto fail;
    } else {
-- 
2.25.1
