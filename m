Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6455060EBD3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 00:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbiJZWrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 18:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbiJZWrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 18:47:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5226E5208C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 15:47:22 -0700 (PDT)
Received: from dimapc.. (109-252-112-196.nat.spd-mgts.ru [109.252.112.196])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 83AC766025FA;
        Wed, 26 Oct 2022 23:47:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666824440;
        bh=uz0L9V/MufGQfPQFvGuBTw01sGpXsDlYGwsQzODExM4=;
        h=From:To:Cc:Subject:Date:From;
        b=dwpZi68zeMshEPYyX1trG3cZXPZISoztx6rQP8i8XauKBPRc25VG8T5418gG6SAKH
         FmDbd9+KkcM2gfqZQHuzjOUbgfd6N1iHXHdM9HxgLAb46oCoqdWZf6B1z8LKfe7YMd
         tkIoG/tfprrlkNOJUiCbZu4NdSAwG1+yfVYIVX5khzWPqF6a1pbk3NKodlIri/nS0K
         SZErMHh3ihpgO0OiPIH2r0ILp4PxsmdFDqk7kpszBYu+D4aZ+GDigDJvVZqbgQiHOj
         xOXasHa4fFtJ1d3t+JdMTyvDTvN2pY0WrIji4HsFm7zmC0cysrfbs89kaSQUkWO0im
         Z34Na5XVxVhUQ==
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
Subject: [PATCH v1 0/2] Fixes for dma-buf locking issues found by Smatch
Date:   Thu, 27 Oct 2022 01:46:38 +0300
Message-Id: <20221026224640.7542-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here are the two patches fixing minor problems introduced by my
"dma-buf locking convention" series. Thanks to Dan Carpenter who
checked linux-next with Smatch and reported the found issues!

Please review/ack, I'll apply the patches to misc-next afterwards.

Thanks!

Dmitry Osipenko (2):
  dma-buf: Make locking consistent in dma_buf_detach()
  drm/gem: Check whether object is NULL in drm_gem_vunmap()

 drivers/dma-buf/dma-buf.c | 3 ++-
 drivers/gpu/drm/drm_gem.c | 9 ++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.37.3

