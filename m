Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD9E6AA7F7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 05:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjCDETx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 23:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjCDETr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 23:19:47 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE50D126EA
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 20:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677903585; x=1709439585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IcgtldqkfkE6eHD67FeLCamBoKCMzTV2qNFng33ppWw=;
  b=bhgfJNBuZNt8h0hX5EEB9fRvMmF8zlAMFHVZ3YmP7ib4gdq2h4EyD1fY
   6QwbcG3D0lAy9M47X41xjZhsrzO4Rp0ROudSMFQfIMcgUXu/JWocqffOg
   9weHm+PslQMagB97GeTC2IzT+y9GQVbuDvl6E+DtN9qxgtZ7YOkWx1daW
   Nhg/Anu0075Oi//tGrQdiI/u5O2TMGRE0uJLFWnTLR9KHUbhq6V37BPJG
   MRiOEV54rhCYxy0gDOf1R1ntq0Zng0qaZ9jNgV3RPZtT29XmjR7DLOuJv
   Kl8pPHLXhoY8EwgHygvzqLloMoi0oinUKKf3ZdG1VIzTYeRA6HtbUHeJu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="315618100"
X-IronPort-AV: E=Sophos;i="5.98,232,1673942400"; 
   d="scan'208";a="315618100"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 20:19:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="708062010"
X-IronPort-AV: E=Sophos;i="5.98,232,1673942400"; 
   d="scan'208";a="708062010"
Received: from tdx-lm.sh.intel.com ([10.239.53.27])
  by orsmga001.jf.intel.com with ESMTP; 03 Mar 2023 20:19:42 -0800
From:   Wei Wang <wei.w.wang@intel.com>
To:     arnd@arndb.de, akpm@linux-foundation.org, keescook@chromium.org,
        herbert@gondor.apana.org.au, josh@joshtriplett.org,
        jani.nikula@intel.com, corbet@lwn.net, jgg@mellanox.com,
        dmatlack@google.com, mizhang@google.com, pbonzini@redhat.com,
        seanjc@google.com
Cc:     linux-kernel@vger.kernel.org, Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v1 2/3] Documentation/CodingStyle: do not use data type names as variable names
Date:   Sat,  4 Mar 2023 12:19:31 +0800
Message-Id: <20230304041932.847133-3-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230304041932.847133-1-wei.w.wang@intel.com>
References: <20230304041932.847133-1-wei.w.wang@intel.com>
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

Observed some merged code uses "bool" as variable name. This is
confusion either for the reader or compilier. Add a rule to have
programmers avoid using data types as variable names.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 Documentation/process/coding-style.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 007e49ef6cec..6d7f4069d55d 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -356,6 +356,9 @@ specification that mandates those terms. For new specifications
 translate specification usage of the terminology to the kernel coding
 standard where possible.
 
+"bool", "int", "long" etc. are specific names for data types, C
+programmers should not use them as variable names.
+
 5) Typedefs
 -----------
 
-- 
2.27.0

