Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B14638F55
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 18:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiKYRwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 12:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiKYRwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 12:52:33 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A75CA46B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 09:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=GIcWfR29KxBSmoIZOlpYH+gYQbsCenYVDvVyeGYpOa4=; b=Os8oO+tErbmLzBCYSvntbuX9PH
        C88GYeet3nbuGPlPvFdLRr4wP9NmyLQJbFbHaLK/GnBl19SD7RJ7DWmQki0rdw+QDkIwM4F2Dq/c0
        RMrkdgtaOEBxT+nzDVo1N91k7U2YvhR9ovwB/JiDk0UCq4UTHFCd2p7mD0zRSeQyZPMPSroQaYii+
        hc2KLZYAKaIUalK4Xgxn+VNK2DTCIPtdH7XWfFPYx9n6OkfNSRTNOId0J0sTZL+2CokkGwvWJWTfw
        aE9bQJt6Z1zjLOaiHy90buK6e47xjpv/3D7oxfWq2mI+NwDFcVfeU8twLgTB5uU3LN1C4HTaAVqZv
        x3T6r+xg==;
Received: from 200-148-10-170.dsl.telesp.net.br ([200.148.10.170] helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oycsD-008yzi-6T; Fri, 25 Nov 2022 18:52:25 +0100
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        contactshashanksharma@gmail.com, amaranath.somalapuram@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@gmail.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniel@fooishbar.org>,
        =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v3 0/2] drm: Add GPU reset sysfs
Date:   Fri, 25 Nov 2022 14:52:01 -0300
Message-Id: <20221125175203.52481-1-andrealmeid@igalia.com>
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

This patchset adds a udev event for DRM device's resets.

Userspace apps can trigger GPU resets by misuse of graphical APIs or driver
bugs. Either way, the GPU reset might lead the system to a broken state[1], that
might be recovered if user has access to a tty or a remote shell. Arguably, this
recovery could happen automatically by the system itself, thus this is the goal
of this patchset.

For debugging and report purposes, device coredump support was already added
for amdgpu[2], but it's not suitable for programmatic usage like this one given
the uAPI not being stable and the need for parsing.

GL/VK is out of scope for this use, giving that we are dealing with device
resets regardless of API.

A basic userspace daemon is provided at [3] showing how the interface is used
to recovery from resets.

[1] A search for "reset" in DRM/AMD issue tracker shows reports of resets
making the system unusable:
https://gitlab.freedesktop.org/drm/amd/-/issues/?search=reset

[2] https://lore.kernel.org/amd-gfx/20220602081538.1652842-2-Amaranath.Somalapuram@amd.com/

[3] https://gitlab.freedesktop.org/andrealmeid/gpu-resetd

v2: https://lore.kernel.org/dri-devel/20220308180403.75566-1-contactshashanksharma@gmail.com/

André Almeida (1):
  drm/amdgpu: Add work function for GPU reset event

Shashank Sharma (1):
  drm: Add GPU reset sysfs event

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  4 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 30 ++++++++++++++++++++++
 drivers/gpu/drm/drm_sysfs.c                | 26 +++++++++++++++++++
 include/drm/drm_sysfs.h                    | 13 ++++++++++
 4 files changed, 73 insertions(+)

-- 
2.38.1

