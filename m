Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C92C603205
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJRSLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiJRSK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:10:58 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D011C2A402
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:10:57 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id y14so34239891ejd.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H6dnY2qPHeoBcs6HubS9cUAM+0LtGHa/ulywywX3FVo=;
        b=Jv7+0asfdLx2HKvp1E6Zx5TezKntWBKZifjrrNIn4sz025+F+xjRCj0WxEefKNKqjC
         bW4C2E/+X83CbbibP8cSpxEkc7ZKylD+tGj4BCJHdWGmIaMsX+SZyco/9hEDlBN24Wi/
         h1Ni7NhTXtQ7DGSfll5qspr9pbcrK8xgTdRkAE2KMlsQOBM3ykNuHIFrm0XA81c3U8A2
         Yew22jHPZRNezzTrgmeINFnRKcW8S4SF4KqH6Skm1nSK8WSrIkikAwdq3YSlzAUQkI0a
         XS9yCW9gZdxgCtG1x97O+/o2rRHuPUgZiUxUdOz8iy79ODfvfF46QeLA9AhlHspT7LrV
         p3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H6dnY2qPHeoBcs6HubS9cUAM+0LtGHa/ulywywX3FVo=;
        b=oS/DXDhQdR6OKOOOjgOzJGA37Qtkfuhw9kt4dqMY43/EwsadfaBolkYijY5C7jVK6/
         bRF0N89MrUAotUkLVbr98u3/Fn0sW2LPvFXWQtPKTOW4XvbriDG0bASXIXD2wVThHEYz
         eNOld2NQdy60IVG+wgX8alr/StEVxvOGfcOdCFQDj5Yo3EebEDGFTzzQDYrUmvAoS3cg
         B1obAyDQ0aYVXY83d1IEbUd/8szpeT5KogqF7RA/pNZkr+fEFTicSaBLDnGg6Upin7Ie
         NS1UU/CQxMpCbtTi1thMF1TDKP3QCkQopF6TLfLBfu9h5cuYWswpL8JpJauP01ZvYGF6
         WnjA==
X-Gm-Message-State: ACrzQf3wByZ/Z2+QlO76VDXqQ2q+kW/qAmXxS1nqpt/Glo1NHzM1WjNO
        c/UxQMrSNZFx+Q8bi/hSWh1I9NXd44s=
X-Google-Smtp-Source: AMsMyM7mtbmgZJyLuTWKmLL/eqP/CD0mXxBUQ4SRRmfPaLlvQlpc+NPe2z7SKLCbbcOz52+gndiDRA==
X-Received: by 2002:a17:907:8a17:b0:782:6e72:7aba with SMTP id sc23-20020a1709078a1700b007826e727abamr3520967ejc.474.1666116656198;
        Tue, 18 Oct 2022 11:10:56 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090618a100b007877ad05b32sm7739302ejf.208.2022.10.18.11.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:10:55 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 0/7] Add basic trace events for vmap/vmalloc (v2)
Date:   Tue, 18 Oct 2022 20:10:46 +0200
Message-Id: <20221018181053.434508-1-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
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

Description is here https://lore.kernel.org/linux-mm/20221017160233.16582-1-urezki@gmail.com/

Changelog v1 -> v2:
- Fix a compilation error for the ARCH=um SUBARCH=i386

Uladzislau Rezki (Sony) (7):
  mm: vmalloc: Add alloc_vmap_area trace event
  mm: vmalloc: Add purge_vmap_area_lazy trace event
  mm: vmalloc: Add free_vmap_area_noflush trace event
  mm: vmalloc: Use trace_alloc_vmap_area event
  mm: vmalloc: Use trace_purge_vmap_area_lazy event
  mm: vmalloc: Use trace_free_vmap_area_noflush event
  vmalloc: Add reviewers for vmalloc code

 MAINTAINERS                    |  12 +++-
 include/trace/events/vmalloc.h | 123 +++++++++++++++++++++++++++++++++
 mm/vmalloc.c                   |  20 +++++-
 3 files changed, 151 insertions(+), 4 deletions(-)
 create mode 100644 include/trace/events/vmalloc.h

-- 
2.30.2

