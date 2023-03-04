Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5F86AA7F4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 05:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjCDETl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 23:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCDETj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 23:19:39 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853611027D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 20:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677903578; x=1709439578;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DxbG3dnwzdgNhDUdBwaOLbn/TlHpTsT3olEm03AKNx8=;
  b=BKEMVqwPGqmSC2P44gsRgghEHsFqQ3qvN0UN6kiUbr6ttG8qthp2o9tm
   Rsoyo/f6f9kk8W/Scc3HpbBt9M3u8YxUw24iGEwFvyNJE2pVb0MEG51o0
   394vUVUZ7dZq8+Nw6Y4C9AJRWFH9Vttn3+fuj6b+2r2oa1vb742I+vQGy
   H3TXL+3dGynCZo+pHQIP4r9CeVpaSJwNKsuwuNZDqPlF+aBg9E5gfdrFk
   DZvr0agP9GhwFZKAa9ennSjT1s+hDPEE/XzF9A0YWhYPpgAcv1E+hglHf
   gaZ8D0GuSAtH+EVKZHT3fW+7eoChp6ppwbb/26lB87QX0R28FG9KpRPO0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="315618074"
X-IronPort-AV: E=Sophos;i="5.98,232,1673942400"; 
   d="scan'208";a="315618074"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 20:19:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="708061997"
X-IronPort-AV: E=Sophos;i="5.98,232,1673942400"; 
   d="scan'208";a="708061997"
Received: from tdx-lm.sh.intel.com ([10.239.53.27])
  by orsmga001.jf.intel.com with ESMTP; 03 Mar 2023 20:19:34 -0800
From:   Wei Wang <wei.w.wang@intel.com>
To:     arnd@arndb.de, akpm@linux-foundation.org, keescook@chromium.org,
        herbert@gondor.apana.org.au, josh@joshtriplett.org,
        jani.nikula@intel.com, corbet@lwn.net, jgg@mellanox.com,
        dmatlack@google.com, mizhang@google.com, pbonzini@redhat.com,
        seanjc@google.com
Cc:     linux-kernel@vger.kernel.org, Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v1 0/3] Regarding using 'bool' appropriately
Date:   Sat,  4 Mar 2023 12:19:29 +0800
Message-Id: <20230304041932.847133-1-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I'm working on patch 3 to change WARN/WARN_ON to use bool for
__ret_warn_on according to the documentation in CodingStyle about using
'bool', compiler reports an error from tpm2_key_encode(), and the root
cause is that it names a variable 'bool' which conficts with the data
type name 'bool'. So fix it and add a rule in CodingStyle to avoid such
naming that causes confusion. This is also the reason that the three
patches are grouped into one patchset.

Wei Wang (3):
  security: keys: don't use data type as variable name
  Documentation/CodingStyle: do not use data type names as variable
    names
  bug: use bool for __ret_warn_on in WARN/WARN_ON

 Documentation/process/coding-style.rst    |  3 +++
 include/asm-generic/bug.h                 | 12 ++++++------
 security/keys/trusted-keys/trusted_tpm2.c |  5 +++--
 tools/include/asm/bug.h                   | 10 +++++-----
 4 files changed, 17 insertions(+), 13 deletions(-)

-- 
2.27.0

