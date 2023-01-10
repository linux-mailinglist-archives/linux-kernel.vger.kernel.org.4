Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37B8664AAD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239168AbjAJSe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239431AbjAJSd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:33:29 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6905496C8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673375358; bh=ysQKgi/JrIlMmf5X/MsjVffw4bVjIB+SlJMK93Fc6kg=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=OexEuoD9w2rlMChDuyt0Lgha7b7LxqL3HJv8QJLNqyDAcSy+l2nixqXecxJQhxkqS
         5QvyViSKyMEvFCWmZ0A5h4m2Cmv2yE15Vo4a1D1+q+CD5JNsXKoC6xcif0M6+BLN9t
         Zf3EpUPIuX94dRxlKAXQI/s5DZHkkRBpBUhuCuG0=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue, 10 Jan 2023 19:29:18 +0100 (CET)
X-EA-Auth: oQ+AcTSeF9jeNjLefVNdNkG4EnXmo8P+THlMmFEOkOeY8Q9R+8z2jAIjLfGWEzOAlKzkPWXxiVB7FkaoUs3fWy/2E/lJeh2t
Date:   Tue, 10 Jan 2023 23:59:12 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: [PATCH 0/2] drm/i915/gvt: Avoid full proxy f_ops debug attributes
Message-ID: <cover.1673375066.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series proposes to replace a combination of DEFINE_SIMPLE_ATTRIBUTE() +
debugfs_create_file() by a combination of DEFINE_DEBUGFS_ATTRIBUTE() +
debugfs_create_file_unsafe(). The change reduced overhead in terms of managing
the full proxy f_ops at runtime. The patches 1 & 2 covers for the scan_nonprivbb
 and vgpu_status f_ops debugfs attributes respectively.

Following coccicheck make command helped identify this change:
    
make coccicheck M=drivers/gpu/drm/i915/ MODE=patch COCCI=./scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci



Deepak R Varma (2):
  drm/i915/gvt: Avoid full proxy f_ops for scan_nonprivbb debug
    attributes
  drm/i915/gvt: Avoid full proxy f_ops for vgpu_status debug attributes

 drivers/gpu/drm/i915/gvt/debugfs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

-- 
2.34.1



