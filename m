Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701D26787BB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjAWU1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjAWU1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:27:47 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B157D10F3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=RULCWiPhPuqguKPxWggrB48SbG5JaPHXTn2zv7ytB64=; b=YvKRnLol1Xw+H2O5RNLQhlw80B
        C4GL+k78PIKX1nhXWFGIny2Iv0jnH3PHAgLh6De7d1V5lxiAlthVWeps0xXvbXB8ta68onFQn7h6c
        VSL+j5Lwv4ZMTdHJDw103YVRi3/pJSwkCpbIKcQxTxOrV+qJdXCeyAcW/es12ns4T69mmL4PcZxlE
        Sy11atYU5ev2mcP7XQGLslGNJoXjpAKrvag3bHckfi72jmwEz+3yIKi0ovVlsUtfsZMvT+vGMa3nH
        UGBsT01Ux8IRVCPYwQjn7Xq3mdACL9P6B7d3JDfY4WN4WDOdYC+vqrRTG4RAMoawNn2rxiYzE4j4y
        yeBXmuyA==;
Received: from [177.102.82.39] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pK3Po-00GEfP-Kd; Mon, 23 Jan 2023 21:27:41 +0100
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        contactshashanksharma@gmail.com, amaranath.somalapuram@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniel@fooishbar.org>,
        =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [RFC PATCH 0/1] drm: Add doc about GPU reset
Date:   Mon, 23 Jan 2023 17:26:45 -0300
Message-Id: <20230123202646.356592-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.39.1
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
  drm: Create documentation about device resets

 Documentation/gpu/drm-reset.rst | 51 +++++++++++++++++++++++++++++++++
 Documentation/gpu/index.rst     |  1 +
 2 files changed, 52 insertions(+)
 create mode 100644 Documentation/gpu/drm-reset.rst

-- 
2.39.1

