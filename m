Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FA56424E2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbiLEInG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiLEInB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:43:01 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC875FA9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 00:42:49 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id m4so3227585pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 00:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxW/Vxu3X7sUPIxDEcWDVrIdRxXj7YBkmL0q7WUBeFw=;
        b=bLuzMxNGC9V/pkvZUfNXlaMMl1sDObrP7LLx8vFgFMOrQ8lVdIVp9DbXC9+coJ5Quj
         4idlgwdT93B///LhYfpfCTnPwnjxK8TXq0TaFI0A46NPSU07Lnn1KCquLmZJE+bTaUct
         yxYU1jD0WKMbBKU4b4uE57d/xzCLMxdgGmD5fR65KhXDxJTivXM0OOj7l3Jsqi56iEVV
         h+ldIx/6Y0xFCYrFARTG99ltCbtx3H0QznGHZ9+CgPJ3Jb//GvjwG3SOGCrpJme0fXe8
         kZfCUM0dIalsYXtrtIu0/jNKHA+t53H3Hd8pU6iuZ79+qY6isbpuDe+m/C45TLc/SxTY
         I4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxW/Vxu3X7sUPIxDEcWDVrIdRxXj7YBkmL0q7WUBeFw=;
        b=QqYfhWz4BpFAPdzSAAiGnUP4vlL+Z7VlgjzIBHxgLpxdA/q99ITq6todf5LbtlF1Kp
         myAM1nNImstsmcLLz5SIwlGy0R2ShEWupEnKF77xZO2nLWu44CwTJphowiXcNz5BE8GG
         5NCxJ7NYq1y2qtbip8JAsVt/Vwj8q+zFG4awIiAF92gyTERc4lXzgZ2ebqqPQRQm/Umi
         EZcUZ6kn6WaKY3UrTrSoDhWMdx0vYzawUaT7OXuucE2DpAQoWXA5YOdoLVXsmJdN/9Fl
         AjnDy7nLP91FQomkTs8dndwwRAQOl/ml6w9Tx4c5ncqb2mRFkTxElI06SJPDoeAVdF9c
         TgDA==
X-Gm-Message-State: ANoB5pmIfMRqiL8UW09l0Rxn5To71nHmYQ1khGfJi2B8Ed8UPeryjnAy
        4n5bnYk2dcFcUvdwavS003Xm
X-Google-Smtp-Source: AA0mqf5DmZYZvv6fzq8Q4+IzidH8vynH2MSHKvtr4PFO7z0vqkHGobpieVYO0HsUo9FszTvHPVFOvg==
X-Received: by 2002:a17:90a:a095:b0:218:e358:12d2 with SMTP id r21-20020a17090aa09500b00218e35812d2mr58560153pjp.208.1670229769512;
        Mon, 05 Dec 2022 00:42:49 -0800 (PST)
Received: from localhost ([101.229.232.206])
        by smtp.gmail.com with ESMTPSA id z19-20020aa79493000000b00576670cc170sm5601420pfk.93.2022.12.05.00.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 00:42:49 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/11] genirq/affinity:: Export irq_create_affinity_masks()
Date:   Mon,  5 Dec 2022 16:41:17 +0800
Message-Id: <20221205084127.535-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221205084127.535-1-xieyongji@bytedance.com>
References: <20221205084127.535-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export irq_create_affinity_masks() so that some modules
can make use of it to implement interrupt affinity
spreading mechanism.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 kernel/irq/affinity.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index d9a5c1d65a79..f074a7707c6d 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -487,6 +487,7 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 
 	return masks;
 }
+EXPORT_SYMBOL_GPL(irq_create_affinity_masks);
 
 /**
  * irq_calc_affinity_vectors - Calculate the optimal number of vectors
-- 
2.20.1

