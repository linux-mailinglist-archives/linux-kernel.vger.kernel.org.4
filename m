Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E9D6F3668
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 20:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbjEAS6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 14:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjEAS6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 14:58:46 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110801708
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 11:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=hZemwKqI+XbJvZCmRaGMFa4GqKWtdAWoykUnIAnqKOI=; b=eOZ/Xgo+w1avvUZ+ctjJLSHe4R
        3PO7t7pJxOMDpP1SwWDO6KhBpE+vxfmaAhSWlRNyAuX5KyzvoUPDibdD1c525ZUoBDeOBOIGkkry2
        pMBeT1wsv4GaR+MrbEZX945Y5c8d2bbWGzEoKZdR5Dh1TXA2IWFPDY5zV2fRHHIMIlpoUw2ynbljK
        N1gRQypiTIe1M/BZLxs+yQ3ZUtltDY4tbFNF2gjufV/DRkcV5wD8xMLk20NuoB9rj2akR9zi3pjUE
        muA/hWG58TT2ZlG4mnehsuEIWGGBAIbEAj4ZKGwUfZwaEq/qaEk0eBr3fIki9pJQ9/9YDH/qZzMwY
        1AxjAfRg==;
Received: from [179.113.250.147] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1ptYjO-00H3BT-Q4; Mon, 01 May 2023 20:58:39 +0200
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
Subject: [RFC PATCH 0/1] Add AMDGPU_INFO_GUILTY_APP ioctl
Date:   Mon,  1 May 2023 15:57:46 -0300
Message-Id: <20230501185747.33519-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently UMD hasn't much information on what went wrong during a GPU reset. To
help with that, this patch proposes a new IOCTL that can be used to query
information about the resources that caused the hang.

The goal of this RFC is to gather feedback about this interface. The mesa part
can be found at https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/22785

The current implementation is racy, meaning that if two resets happens (even on
different rings), the app will get the last reset information available, rather
than the one that is looking for. Maybe this can be fixed with a ring_id
parameter to query the information for a specific ring, but this also requires
an interface to tell the UMD which ring caused it.

I know that devcoredump is also used for this kind of information, but I believe
that using an IOCTL is better for interfacing Mesa + Linux rather than parsing
a file that its contents are subjected to be changed.

André Almeida (1):
  drm/amdgpu: Add interface to dump guilty IB on GPU hang

 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  |  7 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 29 ++++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h            |  7 ++++++
 7 files changed, 52 insertions(+), 1 deletion(-)

-- 
2.40.1

