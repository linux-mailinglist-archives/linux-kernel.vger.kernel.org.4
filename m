Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34DA74E573
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 05:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjGKDnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 23:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjGKDnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 23:43:42 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595BD1BC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 20:43:41 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R0RYR1fNFzBJR3h
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 11:43:39 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689047019; x=1691639020; bh=PROXNSRNkmtHn8K/s7RFD4PL/CT
        OhC4irdWGixGUyVM=; b=1C/rS180+1xqNa9qU67FhPsrfoKHF13ZcVl5yEw35Ir
        h+0Z/gF7udnawEOTpzRJSXtkP1M5keVlBF3ZDZJRGQxN24LGwJbjbFvUPR4EIP9P
        Pzo6l8hhlccC9Y4u6UeSIyMHV+JqeTneiCNFF0TMvdKalvfJcGRk/yGqjEfEuzka
        yxLBW6fxI90ASVftLXIInXg2rcNVORdupRfD1y/6YOZ8eQWej0oM6sHVjmFg7E4h
        1xsonX6nLDXcKQhkbjfEwK3IXA6fExZENeKuf1Bq+CX3Vh9yp6U642voj6ZamPoC
        W3lcrc14mH74Q22+ETow9bHY7UotrnieR39So6TPQMA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JY1E1PZta8Mr for <linux-kernel@vger.kernel.org>;
        Tue, 11 Jul 2023 11:43:39 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R0RYQ6Q7mzBJ8kq;
        Tue, 11 Jul 2023 11:43:38 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 11 Jul 2023 11:43:38 +0800
From:   sunran001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/flcn/qmgr: Move assignment outside if condition
In-Reply-To: <20230711034221.79302-1-xujianghui@cdjrlc.com>
References: <20230711034221.79302-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <4a21bb7bb79108ae96518a8d1372ef1d@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following checkpatch errors:

ERROR: do not use assignment in if condition

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/nouveau/nvkm/falcon/qmgr.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/falcon/qmgr.c 
b/drivers/gpu/drm/nouveau/nvkm/falcon/qmgr.c
index a453de341a75..48abdb124326 100644
--- a/drivers/gpu/drm/nouveau/nvkm/falcon/qmgr.c
+++ b/drivers/gpu/drm/nouveau/nvkm/falcon/qmgr.c
@@ -73,7 +73,8 @@ nvkm_falcon_qmgr_new(struct nvkm_falcon *falcon,
      struct nvkm_falcon_qmgr *qmgr;
      int i;

-    if (!(qmgr = *pqmgr = kzalloc(sizeof(*qmgr), GFP_KERNEL)))
+    qmgr = *pqmgr = kzalloc(sizeof(*qmgr), GFP_KERNEL);
+    if (!qmgr)
          return -ENOMEM;

      qmgr->falcon = falcon;
