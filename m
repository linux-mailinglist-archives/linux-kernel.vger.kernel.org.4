Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940196002B2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 20:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiJPSKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 14:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJPSJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 14:09:49 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5362117AA4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 11:09:47 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w18so15154935wro.7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 11:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lKX8sLbXqFEyfL/b3ZjUwDYXx8N7tsBaTEOHjLLDLgg=;
        b=T0ksjtS64SgZg+ynjnhdZrQdSg4bAyz710FjraW3gjDq2p8ORsc6wHFhCa/aePZurJ
         ytDBmb7rVC0T/RvAZclMcIDWL0AZp4gWSml78Zg26uo7JFkTQncC92Ks9Axb/Boshpkt
         l8PMYuyCVxq4vpOSf/Uj09dbbfLKN94En1stpAWCvNLSJ7zRKP2uge/793nvWvw3N2aP
         IuZPiWof0s6JKlg3QUW7yw0yYQt4Zi4/LW9sbZLXgnSFTyK2ohwpq6V9gFFPCRnm5dso
         J0JURalvtRI5PamaE1DttY2ToJ50QaJs0Lo+lN6QQtByYr/wpjf5b0uTP5U7mP+fFwxR
         h1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lKX8sLbXqFEyfL/b3ZjUwDYXx8N7tsBaTEOHjLLDLgg=;
        b=5klLUl0KUzHinOQevzEbU8d4g+qxJ1n1IBxPHT3xvAtFxHvL3jOecTurHO5sYeIu3J
         UPX9QUzx7m0PAFNUL6Unn6wxAQMwtW4bYJ5vz1noioAo3nPPBHk9FClyWma9akmzQt1c
         dC4lY/dFxtI87zQcAxf85HFob0S+lPDvXSaYwsqACjkSwmbsqdyXYcRkNuDjQ4CWYe4q
         9Kq2ICSPTkNJk8KZuVdYvrXpsDPYpg7zgy5kQnTl4Nk2/FhxZurdg+JRbhCNEssaDOjd
         /j8tFXI/cWthIMZ43scGWA9BNZ6zB2gwKXet4s82DuKSxU7Lu+e/0mvYxxlwyPbGuBEu
         mJHw==
X-Gm-Message-State: ACrzQf0rmvtKC6YEvnMerqwYBOj01hoRa2XynQ1xi4XOvLi4BvpYdXAV
        JwuRq/HHiGjHsw97fDSsd8I=
X-Google-Smtp-Source: AMsMyM5OBZbpCpK+rtWXQ5hh89eacxaqxDOXFM4ZEp/IMVaftu5b7+IXgZMPp0kzBWoOY7N/Fo2ArQ==
X-Received: by 2002:adf:e2c8:0:b0:230:ba81:cf0c with SMTP id d8-20020adfe2c8000000b00230ba81cf0cmr4520684wrj.357.1665943785730;
        Sun, 16 Oct 2022 11:09:45 -0700 (PDT)
Received: from localhost.localdomain (host-95-250-231-122.retail.telecomitalia.it. [95.250.231.122])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c444900b003c6f8d30e40sm156225wmn.31.2022.10.16.11.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 11:09:44 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        John Harrison <John.C.Harrison@Intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [RESEND PATCH 0/3] drm/i915: Replace kmap() with kmap_local_page()
Date:   Sun, 16 Oct 2022 20:09:35 +0200
Message-Id: <20221016180938.17403-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

kmap() is being deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as
mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and still valid.

Since its use in drm/i915 is safe everywhere, it should be preferred.

Therefore, replace kmap() with kmap_local_page() in drm/i915.

These changes should be tested in an 32 bits system, booting a kernel
with HIGHMEM enabled. Unfortunately I have no i915 based hardware,
therefore any help with testing would be greatly appreciated.

I'm resending this little series because I suspect that it has been
lost, since it was submitted on Aug 11, 2022. In the meantime I'm
adding one more recipient (Anirudh) who is helping, along with others, Ira
and me with these conversions / removals of kmap() and kmap_atomic() 

Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Fabio M. De Francesco (3):
  drm/i915: Replace kmap() with kmap_local_page()
  drm/i915/gt: Replace kmap() with kmap_local_page()
  drm/i915/gem: Replace kmap() with kmap_local_page()

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c          |  6 ++----
 drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c |  8 ++++----
 drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c       |  4 ++--
 drivers/gpu/drm/i915/gt/shmem_utils.c              | 11 ++++-------
 drivers/gpu/drm/i915/i915_gem.c                    |  8 ++++----
 5 files changed, 16 insertions(+), 21 deletions(-)

-- 
2.37.1

