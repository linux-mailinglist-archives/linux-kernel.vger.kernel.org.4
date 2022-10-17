Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A58600CCB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiJQKqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiJQKqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:46:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15EBB18B3E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:46:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29F591042;
        Mon, 17 Oct 2022 03:46:17 -0700 (PDT)
Received: from e122027.arm.com (unknown [10.57.1.201])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3B293F67D;
        Mon, 17 Oct 2022 03:46:09 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc:     Steven Price <steven.price@arm.com>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 0/2] drm/panfrost: Fix UAPI for C++/BSD compatibility
Date:   Mon, 17 Oct 2022 11:46:00 +0100
Message-Id: <20221017104602.142992-1-steven.price@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Panfrost DRM interface to user space is uesd in Mesa for targets
other than C/Linux. Specifically the header file needs to compile in C++
code and for FreeBSD which shares the same UABI.

The first patch fixes the C++ compilation issue by removing the
(unnecessary) type name from internal structs which is invalid in C++.

The second patch technically changes the UABI by changing the header
values in the dump format to be native endian rather than fixed
little-endian. Since (a) there are no known big-endian Mali systems, and
(b) this has only appeared in -rc1, this shouldn't break user space.
Tools can use the 'magic' field to identify the endianness of the dump
if they want to support big-endian.

This is effectively a 'v2' of Adrián's series here [1].

[1] https://lore.kernel.org/r/20220920211545.1017355-1-adrian.larumbe%40collabora.com

Steven Price (2):
  drm/panfrost: Remove type name from internal structs
  drm/panfrost: replace endian-specific types with native ones

 drivers/gpu/drm/panfrost/panfrost_dump.c | 36 ++++++++++++------------
 include/uapi/drm/panfrost_drm.h          | 36 +++++++++++++-----------
 2 files changed, 38 insertions(+), 34 deletions(-)

-- 
2.34.1

