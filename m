Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C7E666B86
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 08:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236560AbjALHTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 02:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbjALHS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 02:18:57 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738FC167DD
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 23:18:46 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id 78so12182778pgb.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 23:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UDSVYKBNF2+Uy+iLNC5V0cr7qiLHD6nPA7wwnGptmgE=;
        b=SijGG49NZHdI1KNM+q13z6V78bOY7XyDD6HAs474o0IjHEkHj57jWZBXi4RWTHkifD
         pY0kXWrxRJgkaaZMeRuiHTKfz41QF01vcK8r0DwR+a5Fp45ftlUykQqAtwDKVAp5inKA
         TgWzdgKzm6hU2Bojxi5+zYOPgEs1Triw2BYpBl51NwbGYBgA2UIvT+iPxk7Jm+zeWp7M
         DsZa+dSnR6q20RsGSLEot1ZrQAr04dx4ABX0zA4B2aQ1aInJ5bS39y5FMT6xMPzscQwR
         xkuAhZP0tzGvfWNu25b5AmnuK+5+U0C0P1fv8gjo95guqzF1+eGgDSxwR8cfUYHmoOT5
         Jwog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDSVYKBNF2+Uy+iLNC5V0cr7qiLHD6nPA7wwnGptmgE=;
        b=VuKhLACoUvtuMc4R6F9ux9PJrdRtL0pf+/2hOmh5aRA13SorgR9wj+RUOMCRwt135f
         FVCwev7kcQDF2FX8QVDt5FOWDCzE9q5wtHLQ+z9ZJU2BGTU1vYuvbttWZeKvOC4jCTcK
         OeKVXHEY7epvTn4FOApz40ZHhLus3MPGNIoWglos5So10pOszYDilQ21jTIbyjCbMcAL
         BP3RPhS6CR2ZeWo2eFuZnLgUF1VM9mfni3jb+aJ/DyoRQvFh4xTpxKZjEU2bbNhbhIGW
         FFrTmOHbKgtyj3GvC0C4mAQaBEdcwC2wuAaSEZQju37dDp9s3VHpoVE8mo2L374VG4Kh
         3bEA==
X-Gm-Message-State: AFqh2krogBUHJTQwSCFQ9/kSbD11EjJ3kWbn5U16RVsQ8xv2QMt1wGlj
        fXY/vzLIT8SCiOtZSIunDFk=
X-Google-Smtp-Source: AMrXdXuZYt2mUlQGkVh+q0eNdji128F4aLy4TNV26HWjm8aiwgOEHsgMnZSu+LHtNx6YoVKwe8NlSQ==
X-Received: by 2002:a62:6d03:0:b0:582:998a:bed5 with SMTP id i3-20020a626d03000000b00582998abed5mr4990282pfc.23.1673507926535;
        Wed, 11 Jan 2023 23:18:46 -0800 (PST)
Received: from localhost.localdomain ([43.132.141.9])
        by smtp.gmail.com with ESMTPSA id e17-20020aa798d1000000b0058ba98f16a3sm289121pfm.171.2023.01.11.23.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 23:18:46 -0800 (PST)
From:   korantwork@gmail.com
To:     bskeggs@redhat.com, kherbst@redhat.com, airlied@gmail.com,
        daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, Xinghui Li <korantli@tencent.com>,
        loydlv <loydlv@tencent.com>
Subject: [PATCH] drm/nouveau/mmu: Fix an UAF issue in NVKM
Date:   Thu, 12 Jan 2023 15:18:42 +0800
Message-Id: <20230112071842.819123-1-korantwork@gmail.com>
X-Mailer: git-send-email 2.31.1
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

From: Xinghui Li <korantli@tencent.com>

In nvkm_mem_new_host, the mem is be alloced. And mem->memory is
assigned to pmemory. During this process, the mem will be free if
the error occurs. But the *pmemory still points to the &mem->memory
which has been relased.Laterly, the nvkm_memory_unref will put the
memory which points to the pmemory again.So, we set the *pmemory to
NULL to avoid UAF issue.

Reported-by: loydlv <loydlv@tencent.com>
Signed-off-by: Xinghui Li <korantli@tencent.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/mem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/mem.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/mem.c
index 92e363dbbc5a..ab30eb1fc0a3 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/mem.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/mem.c
@@ -185,6 +185,7 @@ nvkm_mem_new_host(struct nvkm_mmu *mmu, int type, u8 page, u64 size,
 	} else
 	if ( (ret = nvif_unvers(ret, &argv, &argc, args->vn))) {
 		kfree(mem);
+		*pmemory = NULL;
 		return ret;
 	}
 
-- 
2.31.1

