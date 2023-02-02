Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408AA687863
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjBBJJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjBBJJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:09:45 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BD669539
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 01:09:44 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso4955864pjj.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 01:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vc9dKkOu9Bxzey4EMEiWLkvY83L8oxqqOyKDYNLTu5g=;
        b=aJY+fw9Yr3mDpnG1pelzv7csrHxEYkyQh1y4fJRjzdswGPzA7ZfQWGtLMrdepTq9Dc
         i54BlCMZFSoUglW7CIdfRuIWEikWbQJiNqMYVJEbzig77Z6tb2CH3BBs7l0OH9E6hnG9
         3S4L/tGa2DFZtFkutLppOiZoBaxQsseNNwyBHkaacm/QpTuTDolJpgl6nIUDMMNRCgSu
         J04eoysVHd3Gew+kM8SK7/yDFqf+7VeLP2hfhiCLWNmgtMkGBe1bRZOzDYtx8AupPuo5
         vbtBh3DCYD3HrQucGK/ccN7augOUbzp4NhQj1WC5ITcvXA+qdYar2P2fR0ZyOpGGjo9O
         +cIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vc9dKkOu9Bxzey4EMEiWLkvY83L8oxqqOyKDYNLTu5g=;
        b=j+I+wE2HYFPGCCizolGxhPfcLHeBkMHCsJXUaul6vlg2g3Vq/5NowXAqZSkgtH8VOf
         K84ulalKJP5isMDYHp2yE+aKqeIIjk73HN7UWHmAtG5Z+iSiqiEEpJkFvCGscZr2mARw
         Xd+We6icki71rC2MQPNSll0GuhhZgSjWzwxYV9qqXEEkhJxJmHWoVV6EsPRew/RjlsvH
         BVNzqb8aCoGAmBf3kPNq1XOPBea5lMEdYMiiWxztXsVG8uGPUky7CP0yhYPcf4ceJqSR
         kMjZ7udjRxK/36m7zV785Y2tBY6kdPZlP4Ztni8dby9v3t4NbXCWTgCSKX8ZkW07HhJE
         qrwQ==
X-Gm-Message-State: AO0yUKUT0iXnTIumWsxfOGzKMPdt6b5xmJ69jgfe+kyqojvqJQJTKa6k
        ZQKqrz6p2T4wkX/DTLVSs8gTAw==
X-Google-Smtp-Source: AK7set8tx+u5ePofxYMmfqsidTs9Png9ELrgrcDtRFgGE1ZkOU3rNSgt+Gog2PZBE6m4rN7yBj+JCA==
X-Received: by 2002:a17:902:f355:b0:196:8cd2:15b1 with SMTP id q21-20020a170902f35500b001968cd215b1mr4593128ple.37.1675328983805;
        Thu, 02 Feb 2023 01:09:43 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id ik12-20020a170902ab0c00b001929827731esm13145968plb.201.2023.02.02.01.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:09:43 -0800 (PST)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Rusty Russell <rusty@rustcorp.com.au>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shunsuke Mie <mie@igel.co.jp>
Subject: [RFC PATCH v2 1/7] vringh: fix a typo in comments for vringh_kiov
Date:   Thu,  2 Feb 2023 18:09:28 +0900
Message-Id: <20230202090934.549556-2-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230202090934.549556-1-mie@igel.co.jp>
References: <20230202090934.549556-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Probably it is a simple copy error from struct vring_iov.

Fixes: f87d0fbb5798 ("vringh: host-side implementation of virtio rings.")
Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 include/linux/vringh.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/vringh.h b/include/linux/vringh.h
index 212892cf9822..1991a02c6431 100644
--- a/include/linux/vringh.h
+++ b/include/linux/vringh.h
@@ -92,7 +92,7 @@ struct vringh_iov {
 };
 
 /**
- * struct vringh_iov - kvec mangler.
+ * struct vringh_kiov - kvec mangler.
  *
  * Mangles kvec in place, and restores it.
  * Remaining data is iov + i, of used - i elements.
-- 
2.25.1

