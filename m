Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C22621B3C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbiKHRy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbiKHRyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:54:43 -0500
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DC3FD25
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 09:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=K7hR3kcY9SxHZtoP6I8WOetvo7/nxlSyWlDLbOd9cE0=; b=sF7V8SO+MpZ0/+pI4UY1NIrlwL
        eNtZnW/HAn/DSrDlb7g+lgJcIeCPFx3IvnDDlfZOl98lSS4feNSppwQokKpBGSxfe8w9u1UR2VRbN
        ry2jKn/pqWHqX6AuIgV/qeNm37xpGgfP8gK5wOloYoRj7OxvafWocV0ggYgD6dgfQzuCuGBN8QDUS
        JL/0AczqPR+4I3B3u5sFLIrh1CL90CeeZg//rBtImU0FJhHLD7sTcUiUMYm9RRWoStrFEvYDtEMin
        EAvqNOfUeXiKyTxUeEqHBkr5vc/gKLOxuRyIqghivu4izISkDEAQigP+PHqELb/CfNGzcsHebbdJw
        t8W5Zrdw==;
Received: from [177.34.169.227] (helo=bowie..)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1osSnw-00EVxA-R3; Tue, 08 Nov 2022 18:54:33 +0100
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To:     Melissa Wen <mwen@igalia.com>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
        "Juan A . Suarez" <jasuarez@igalia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH v2 0/2] Balance mutex_init and mutex_destroy calls
Date:   Tue,  8 Nov 2022 14:54:23 -0300
Message-Id: <20221108175425.39819-1-mcanal@igalia.com>
X-Mailer: git-send-email 2.38.1
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

This series introduces some changes to assure the correct resource release on
the V3D driver, especially the mutex. Currently, the V3D has no mutex_destroy()
calls, which means that a mutex is being instantiated, but it is not being
released by the end of its use.

So, use the DRM-managed mutex_init variants when possible to manage the mutex
release and add mutex_destroy() calls when not possible.

Best Regards,
- Maíra Canal

v1 -> v2: https://lore.kernel.org/dri-devel/20221107224656.278135-1-mcanal@igalia.com/T/#m3c23e3f21fe6aaae51138c746c74e94b2a7b3bfc

- Move mutex_destroy() to v3d_perfmon_put() (Daniel Vetter).
- Add mutex_destroy() on error case in v3d_perfmon_create_ioctl() (Daniel Vetter).
- Add Daniel Vetter's tags.

Maíra Canal (2):
  drm/v3d: switch to drmm_mutex_init
  drm/v3d: add missing mutex_destroy

 drivers/gpu/drm/v3d/v3d_gem.c     | 17 +++++++++++++----
 drivers/gpu/drm/v3d/v3d_perfmon.c |  6 +++++-
 2 files changed, 18 insertions(+), 5 deletions(-)

-- 
2.38.1

