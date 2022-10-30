Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2A0612B4A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 16:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJ3Po4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 11:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJ3Pox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 11:44:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A421314
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 08:44:51 -0700 (PDT)
Received: from dimapc.. (unknown [109.252.112.196])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 007AA6601639;
        Sun, 30 Oct 2022 15:44:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667144689;
        bh=PBCW1pQYZlulS+wkcdlxXBG/yfECQX+mmoneFqYHeMc=;
        h=From:To:Cc:Subject:Date:From;
        b=KO/aESh02ORnQ42eMXxzJ5iTOy+T7I0QoN2WW71yk2KrvzJmauqcX+laILuetlsTq
         6xGve78DarOd2CW6TbZQLpfpbB1qluBlOU5efCRwOK82ksWmf+0WM+XT5g9CqcK9b7
         49uHQ/s6ghJGOXEazU7RFcCg893+Lx0OLVqgnU6PnXW1tLcMYYDBN7jecVpknpKOtU
         0jZB09ZdvKnKRxWVUvHXtQw1YFkkyaFf5Sak1ob3ie8MRnm2bZmsDvkOCIO8szSH4H
         CbOgtXPQz7q0aUD9AgiceotOH02FnVVtwvH+i3RmaPinm7MDj6p+BXkUtPUL+KASJ0
         aR1J1LciYfYSQ==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, noralf@tronnes.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Fixes for dma-buf locking issues found by Smatch
Date:   Sun, 30 Oct 2022 18:44:10 +0300
Message-Id: <20221030154412.8320-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here are the two patches fixing minor problems introduced by my
"dma-buf locking convention" series. Thanks to Dan Carpenter who
checked linux-next with Smatch and reported the found issues.

Changelog:

v2: - Added ack from Christian König to the dma-buf patch and improved
      the dma-buf/attachment pointer check.

    - Dropped v1 patch that added GEM NULL-checking to
      drm_gem_vunmap_unlocked() and replaced it with the NULL-checking
      in drm_client_buffer_delete(), like was suggested by Christian König.

Dmitry Osipenko (2):
  dma-buf: Make locking consistent in dma_buf_detach()
  drm/client: Prevent NULL dereference in drm_client_buffer_delete()

 drivers/dma-buf/dma-buf.c    | 4 ++--
 drivers/gpu/drm/drm_client.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.37.3

