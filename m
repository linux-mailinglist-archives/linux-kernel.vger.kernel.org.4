Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8E86429F8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiLEN4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiLEN4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:56:30 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD11D68
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 05:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=bTIenh40FCC39XN+WcIw5A8gMY4IR7S1+OwUya3n/HQ=; b=hZn4Qk2htMRvxGIHZ3+p7LU0sl
        mzdDdAmXoDuzOXVV2dAMJ0+CsPDiF0UcO8eDhbe6Z+u8Kyfj438RZc3fPPdAaE+wUuUUhxpSPQtFp
        aR8qRujsKTg3/rPK7GCk23WjKJPaEuZxiSWHK7cnDfBR66rCfM1shDOsmHQ7XVBkMlIE1HRcM8++q
        mEcEJJtF+khg3mEBhd/jAwwdPMPZEafJriLzJgD8sNUOOBSzog+4yQkGi8kkKUYBYGbCt/JLnx0lZ
        LEvEnuGzskVsd7XOc7EM8HBBHM+dHKYrcZsWOceleKHlrtPOQ9t4nkiNHB9/DE8Vpf66+m+RZ8a3W
        jj59ROgQ==;
Received: from [41.74.137.107] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1p2Bx2-00FUSn-Or; Mon, 05 Dec 2022 14:56:08 +0100
From:   Melissa Wen <mwen@igalia.com>
To:     airlied@gmail.com, daniel@ffwll.ch, emma@anholt.net,
        mwen@igalia.com
Cc:     Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maira Canal <mcanal@igalia.com>, kernel-dev@igalia.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] drm/v3d: replace obj lookup steps with
Date:   Mon,  5 Dec 2022 12:55:36 -0100
Message-Id: <20221205135538.3545051-1-mwen@igalia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch just prevents to iterate on a NULL job->bo array during
job cleanup. This situation can happen when v3d_lookup_bos() fails to
allocate memory for the job->bo array and job->bo_count was already set.
The second replace BOs lookup steps in v3d_lookup_bos() with the
common code of drm_gem_objects_lookup().

v2:
- rebase to drm-misc-next

Melissa Wen (2):
  drm/v3d: cleanup BOs properly when lookup_bos fails
  drm/v3d: replace obj lookup steps with drm_gem_objects_lookup

 drivers/gpu/drm/v3d/v3d_gem.c | 55 ++++-------------------------------
 1 file changed, 6 insertions(+), 49 deletions(-)

-- 
2.35.1

