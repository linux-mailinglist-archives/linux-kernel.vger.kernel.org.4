Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244AD6633C2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 23:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237654AbjAIWQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 17:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjAIWQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:16:30 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9F655AB
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 14:16:28 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id c17-20020a170902d49100b00192be705f76so7160410plg.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 14:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7dbGFSGl2P15wdLGEBTQ02HXgB4f3UQ0vhNqyU5IrAQ=;
        b=pWhUBCLpFd1CC7BFLkaI3kmyIoiv/iRvocf3G+aXcpoSRXCxWCuvK82+P3vUepBNQE
         bFiILQ5FH39WJP97Z9yOfLnr8BjULIJim4Kw3GHHg+N5+zbDvYldwBrqKztLh/hM9w0A
         qvzoQtXeTiq3/fS1GlmAMaFxEfTG5SxrmASQsS2nQu9/dM+T1ozA9lNWwr22vgpqzy3g
         C0QRvPGzYocQipXNwv+gJW2e+dYNCYfJSxka+4u8p6NerIbu/Y6BcbAxR24FE39FURIK
         sBBD+TYPVEmDUI50NQUXSBpGiJmNUxeP9CSi9N7dDupPRaDHeoT2aqHP9NF/Mywmh4gA
         GOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7dbGFSGl2P15wdLGEBTQ02HXgB4f3UQ0vhNqyU5IrAQ=;
        b=FwKpXbJhiGl2SJbEpXfnBoNBeP4SurE0q46wD/IeAQXF5r+nhJUv3jiV1QvjefsFJJ
         35yxHEzPM30oPPEmUvW1TmaZCC3fb1TXYBEgEbkaLVy+nA8Qk+urn11VIuRII7jbtzae
         g6iEtCUAvJngidVOgijznX9RYWKIXsrN0HFNa/Z+lN9noCIuwBMYkvz3NrQ6Emxv38nz
         LWHmUNt5Zv1a6ucNMTeoQc2ug5hclmus788lCfglqtqIjWHp+vbh1iPiSMG2Txpn3iB8
         yvBdePAWcfbyGKI2Qk0BBnkjMADNr+mGek56vulwLxru+9wMa/r+pkF4xDbSsFsh8tpz
         zFDg==
X-Gm-Message-State: AFqh2kp+0rnT6ayndtNy+KHKWBL9bpvjY7JkQ6zpm1DpYaJYAtcFtPV6
        Ta+n/ZICFbOVFcoO7/Oli1QvZaOZKs1k3w7qsyEonw==
X-Google-Smtp-Source: AMrXdXsV5dTjdmva6/QYT+10ElqKQltDtJDhXtnNH/Y7Wne3MIBWFqUYajmbsxrbX/FVmUXI3UrD39ci8xfypfC8sv26nQ==
X-Received: from isaacmanjarres.irv.corp.google.com ([2620:15c:2d:3:3990:5e50:b0f8:bcdd])
 (user=isaacmanjarres job=sendgmr) by 2002:a17:90b:23c8:b0:226:e800:120e with
 SMTP id md8-20020a17090b23c800b00226e800120emr860160pjb.54.1673302588362;
 Mon, 09 Jan 2023 14:16:28 -0800 (PST)
Date:   Mon,  9 Jan 2023 14:16:21 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109221624.592315-1-isaacmanjarres@google.com>
Subject: [PATCH v1 0/2] Fixes for kmemleak tracking with CMA regions
From:   "Isaac J. Manjarres" <isaacmanjarres@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Isaac J. Manjarres" <isaacmanjarres@google.com>,
        kernel-team@android.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

When trying to boot a device with an ARM64 kernel with the following
config options enabled:

CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
CONFIG_DEBUG_KMEMLEAK=y

a page-fault is encountered when kmemleak starts to scan the list of gray
or allocated objects that it maintains. Upon closer inspection, it was
observed that these page-faults always occurred when kmemleak attempted
to scan a CMA region.

At the moment, kmemleak is made aware of CMA regions that are specified
through the devicetree to be created at specific memory addresses or
dynamically allocated within a range of addresses. However, if the
CMA region is constrained to a certain range of addresses through the
command line, the region is reserved through the memblock_reserve()
function, but kmemleak_alloc_phys() is not invoked. Furthermore,
kmemleak is never informed about CMA regions being freed to buddy at
boot, which is problematic when CONFIG_DEBUG_PAGEALLOC is enabled, as
all CMA regions are unmapped from the kernel's address space, and
subsequently causes a page-fault when kmemleak attempts to scan any
of them.

This series makes it so that kmemleak is aware of every CMA region before
they are freed to the buddy allocator, so that at that time, kmemleak
can be informed that each region is about to be freed, and thus it
should not attempt to scan those regions.

Isaac J. Manjarres (2):
  mm/cma.c: Make kmemleak aware of all CMA regions
  mm/cma.c: Delete kmemleak objects when freeing CMA areas to buddy at
    boot

 mm/cma.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

-- 
2.39.0.314.g84b9a713c41-goog

