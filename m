Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431546A4C6D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 21:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjB0Uk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 15:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjB0UkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 15:40:25 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99A940C6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 12:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=skccS5dCHnUWuDDB7Qkqv95X91Iw1J6jxu1lqMy1F1M=; b=OMC/ULOELfp3GHxMbmwvDd92f+
        3XC5UUjde61y0pWmQVIAsg9N/loY+0FdX/bo47xZiwJ+PmDOMzsIw85uBvLw/Qb/jG71r07NzwQIL
        Z9rXJqFRqRFNfvfWTThc4TzAyfV5vi1McYXCZ1H33FFiO802/VNBXK6bKDigPI4ymtPlDbS/rl8LN
        KWXqstkVH4GT8vFkZMZbTYcbmRbOMX4sDfBrGOAR5FKG5gfeJt6y2SRXFp+iRn3vlxfEN3c7k+IQ8
        UP0b0weaHwOYq1JWqXiUF9PI7WNAk1o3NQDNiy5gGMWvZwCv+Iy25c0oLtbKrZlPoEotynXQiDqQA
        YO52NAhA==;
Received: from [181.199.58.72] (helo=localhost.localdomain)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pWkI2-00H62x-4L; Mon, 27 Feb 2023 21:40:06 +0100
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        contactshashanksharma@gmail.com, amaranath.somalapuram@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        "Simon Ser" <contact@emersion.fr>,
        "Rob Clark" <robdclark@gmail.com>,
        "Pekka Paalanen" <ppaalanen@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Daniel Stone" <daniel@fooishbar.org>,
        =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
        "Dave Airlie" <airlied@gmail.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v2 0/1] drm: Add doc about GPU reset
Date:   Mon, 27 Feb 2023 15:39:59 -0500
Message-Id: <20230227204000.56787-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.39.2
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

Hi,

Thanks everyone that gave feedback. v2 Changes:
- This new version is a section of drm-uapi instead of a new file
- Drop requirement for KMD to kill applications
- Drop role of init systems on compositors recover
- Drop assumption that robust apps creates new contexts

Original cover letter bellow:

Due to the complexity of its stack and the apps that we run on it, GPU resets
are for granted. What's left for driver developers is how to make resets a
smooth experience as possible. While some OS's can recover or show an error
message in such cases, Linux is more a hit-and-miss due to its lack of
standardization and guidelines of what to do in such cases.

This is the goal of this document, to proper define what should happen after a
GPU reset so developers can start acting on top of this. An IGT test should be
created to validate this for each driver.

Initially my approach was to expose an uevent for GPU resets, as it can be seen
here[1]. However, even if an uevent can be useful for some use cases (e.g.
telemetry and error reporting), for the "OS integration" case of GPU resets
it would be more productive to have something defined through the stack.

Thanks,
	André

[1] https://lore.kernel.org/amd-gfx/20221125175203.52481-1-andrealmeid@igalia.com/

André Almeida (1):
  drm/doc: Document DRM device reset expectations

 Documentation/gpu/drm-uapi.rst | 51 ++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

-- 
2.39.2

