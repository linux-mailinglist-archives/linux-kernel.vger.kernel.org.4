Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E142A665FB6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 16:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbjAKPvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 10:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbjAKPvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:51:12 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F8DFC4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673452244; bh=dejsgE3Ez/67WXZ8VD64EdJhbcaTHAeJCXvwM7APl2o=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=b1xwBMzSmZjZAGrMcc5ukE1wtNmAp3WxjkT4sWFQGR38WpcBunwCqGr1Zas1/jQyV
         S0LTaFpCMIYoNG4R4sXAKfrdwuzAsfts7CQ0Vuu03XbtK54ljfWRVavykPoV42HSB9
         KU3tFGK8dZlaREldkf7dGk32PXdWG/MmogmvqYIc=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Wed, 11 Jan 2023 16:50:44 +0100 (CET)
X-EA-Auth: TMlNij5nhUdtDQ4SpLM6IYnEDTxtuqjBkguRcd4KwH/DlESbPp9RituNi8rLvrnlqMWLkEhVjODFBx/z+HL5Fr66OQ31zz/p
Date:   Wed, 11 Jan 2023 21:20:40 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: [PATCH v3 0/2] drm/i915: Avoid full proxy f_ops debug attributes
Message-ID: <cover.1673451705.git.drv@mailo.com>
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
the full proxy f_ops at runtime. The patches 1 & 2 covers for the DRRS and FBC
f_ops debugfs attributes respectively.

Following coccicheck make command helped identify this change:

make coccicheck M=drivers/gpu/drm/i915/ MODE=patch COCCI=./scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci

Changes in v3:
   Patch 1/2: fix checkpatch function parameter alignment complaint
   Patch 2/2: None

Changes in v2:
   - Individual patches clubbed in patch set
   - Update patch log message to include coccicheck make command


Deepak R Varma (2):
  drm/i915/display: Avoid full proxy f_ops for DRRS debug attributes
  drm/i915/fbc: Avoid full proxy f_ops for FBC debug attributes

 drivers/gpu/drm/i915/display/intel_drrs.c |  8 ++++----
 drivers/gpu/drm/i915/display/intel_fbc.c  | 12 ++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.34.1



