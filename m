Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACF170F4DA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbjEXLNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbjEXLNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:13:20 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25686C5
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 04:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684926799; x=1716462799;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ctt2eux1S87Z+c64wTXFiMIMoUTvj2hM+36xZWgj04A=;
  b=TD7b68kijetsynfVpx/tInhLmKMVLZtM5BHtdf0bbhyYkkI6UjOAs9Ek
   fSPdhdqW234afj/b4D/iEDz48gcPmrenReagHmObm8JHL6HL4zLDwvuzK
   1adsC0cv33tnoMfWxmvG1kMOSLNphO8y3rSVLj8JwZuif5F1HCdTP1egw
   nQptmrkLujfEfNFgMxJrfofdlK6dmnnUghVKxJTAfjDalzujl6ymiDlaE
   8t1RdHj61XNNUXsZsi8BQOBQ2iTOoGMvLIFNECUlgbPtP8Oi0rjaWYWlq
   bXuouuGo4lPSjixDveXKt2ly73IBL/bn5lY51m9cffrUSvScv4iVFBgEd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="333156259"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="333156259"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 04:12:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="878621121"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="878621121"
Received: from mtkaczyk-devel.igk.intel.com ([10.102.105.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 04:12:55 -0700
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     arnd@arndb.de
Cc:     andriy.shevchenko@intel.com, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com
Subject: [PATCH v2 0/2] Enclosure interface cleanups
Date:   Wed, 24 May 2023 13:12:29 +0200
Message-Id: <20230524111231.14506-1-mariusz.tkaczyk@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,
While looking into adding Native PCIE Enclosure Management (NPEM) support
behind the existing enclosure ABI, I noticed a few opportunities for
cleanups.

Changes since v1[1] + internal review:
- Keep reporting the cached version of ecomp->active (Dan).
- Preserve cached values in ecomp, drop patch 2 (Dan).
- Add comment documenting cached ecomp->active (Dan).
- Move ATTRS macros close to appropriate _show and _store functions (Andy).

[1] https://lore.kernel.org/linux-pci/20221117163407.28472-1-mariusz.tkaczyk@linux.intel.com/

Mariusz Tkaczyk (2):
  misc: enclosure: remove get_active callback
  misc: enclosure: update sysfs api

 drivers/misc/enclosure.c  | 84 ++++++++++++++++++---------------------
 include/linux/enclosure.h |  2 -
 2 files changed, 39 insertions(+), 47 deletions(-)

-- 
2.26.2

