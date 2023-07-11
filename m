Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E860E74F9C9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 23:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjGKVft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 17:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjGKVfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 17:35:46 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A70C170C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 14:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=zxO2JUIk0+qcytPvORKjR4DXSclXMm1DGFD/RYtrULs=; b=hXyqhIfbhMl1hyi6fpooEVg7aG
        vc0Jq3WEj44nQhxddDYXuY1tI9OMYqU4WMBWGnxDcktpU6Fh4k0A7gRZ+6H+racLX+nDrolqEaMyl
        XNc+tgEgEnx8t90fDMLEprhMR1alVokirVMLzTmQXJFWOYbhmdboiJWnr25knb510mE5sVShcAeo+
        5JVZeaIzo2XvWEOUSkfbJL8mRnHWK1ezp/ETAUkiauFJW8Oeqcp7GXx+wbcJ6uLB7VaSdTVogLbAL
        a8uqc4zDcDVjDqDHx5awi49ACoCZHwcGAWUP4HEMM5gEtdHZY73W4XoA3UsREznZfMIGui4ZPE7Jj
        don4WyOg==;
Received: from [187.74.70.209] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qJL1H-00Cl0M-N0; Tue, 11 Jul 2023 23:35:40 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
        michel.daenzer@mailbox.org,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH 0/6] drm/amdgpu: Add new reset option and rework coredump
Date:   Tue, 11 Jul 2023 18:34:55 -0300
Message-ID: <20230711213501.526237-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The goal of this patchset is to improve debugging device resets on amdgpu.

The first patch creates a new module parameter to disable soft recoveries,
ensuring every recovery go through the full device reset, making easier to
generate resets from userspace tools like [0] and [1]. This is important to
validate how the stack behaves on resets, from end-to-end.

The second patch is a small addition to mark guilty jobs that causes soft
recoveries for API consistency.

The last patches are a rework to store more information at devcoredump files,
making it more useful to be attached to bug reports.

The new coredump content look like this:

   **** AMDGPU Device Coredump ****
   version: 1
   kernel: 6.4.0-rc7-tony+
   module: amdgpu
   time: 702.743534320
   process_name: vulkan-triangle PID: 4561
   IBs:
   	[0] 0xffff800100545000
   	[1] 0xffff800100001000
   ring name: gfx_0.0.0

Due to nested IBs, this may not be the one that really caused the hang, but it
gives some direction.

Thanks,
	André

[0] https://gitlab.freedesktop.org/andrealmeid/gpu-timeout
[1] https://github.com/andrealmeid/vulkan-triangle-v1

André Almeida (6):
  drm/amdgpu: Create a module param to disable soft recovery
  drm/amdgpu: Mark contexts guilty for causing soft recoveries
  drm/amdgpu: Rework coredump to use memory dynamically
  drm/amdgpu: Limit info in coredump for kernel threads
  drm/amdgpu: Log IBs and ring name at coredump
  drm/amdgpu: Create version number for coredumps

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 21 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 99 +++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  9 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   |  6 +-
 5 files changed, 112 insertions(+), 29 deletions(-)

-- 
2.41.0

