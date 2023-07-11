Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D5C74E457
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 04:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjGKCit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 22:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjGKCis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 22:38:48 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18C01AC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 19:38:45 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R0Q6V6NQkzBHXkP
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 10:38:42 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689043122; x=1691635123; bh=s/qiL5OvwRpw8d931IAUYCY4uTp
        XmPulPbfcEyZ7+GA=; b=u0scnuf5kojhE7Sa9FVxSeOk0v/OoUA7rsqInz5wQ1l
        XqZsQKmMBZLei7A+J4h1DnRNslHRIHygi2Sjfn0GrQTCyx5pAZ97IEGQQ9knUr9t
        BqdZJnSVj5FDPnTo/OW00aFr6GWKGemMv5nNfu2jPmAkDs/RoMRaGUn9uZQ4nTb2
        BoNkzzJYGUTZnvjcLY1xU+ylHT3Pt30xGevW0nsZfKbFQQfqywA3qoYC4/jR46qu
        fTcM2LxhPFCs+77IYJYZ1ioTvKPELn5sgpG8sYbfedrZyw+2+1QyoQ+WMcI/WDVa
        lIraeESyoKOVCNcdr/APBEpb/8WBcMTto2tOdU/qezA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0ySu7cf4sMkS for <linux-kernel@vger.kernel.org>;
        Tue, 11 Jul 2023 10:38:42 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R0Q6V3XDKzBHXhc;
        Tue, 11 Jul 2023 10:38:42 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 11 Jul 2023 10:38:42 +0800
From:   sunran001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/volt: Move assignment outside if condition
In-Reply-To: <20230711023631.78374-1-xujianghui@cdjrlc.com>
References: <20230711023631.78374-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <b7c038a6d2f8484e348ad977565ae9e6@208suo.com>
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
  drivers/gpu/drm/nouveau/nvkm/subdev/volt/base.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/volt/base.c 
b/drivers/gpu/drm/nouveau/nvkm/subdev/volt/base.c
index a17a6dd8d3de..d1ae98a42e34 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/volt/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/volt/base.c
@@ -321,7 +321,8 @@ int
  nvkm_volt_new_(const struct nvkm_volt_func *func, struct nvkm_device 
*device,
             enum nvkm_subdev_type type, int inst, struct nvkm_volt 
**pvolt)
  {
-    if (!(*pvolt = kzalloc(sizeof(**pvolt), GFP_KERNEL)))
+    *pvolt = kzalloc(sizeof(**pvolt), GFP_KERNEL);
+    if (!*pvolt)
          return -ENOMEM;
      nvkm_volt_ctor(func, device, type, inst, *pvolt);
      return 0;
