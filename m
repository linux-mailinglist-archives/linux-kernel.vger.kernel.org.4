Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781226C4966
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 12:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCVLnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 07:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjCVLnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:43:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D85822A17;
        Wed, 22 Mar 2023 04:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679485408; x=1711021408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=yKRlI5y9bcnhFzUxINJn9nGvLAKcMTT01x+wzzrAUoA=;
  b=DLTQNunNN1L6he5p7lKp710ebeNY9SZIm+3oOa9Eh1RVJ+astUM5S7tO
   wDynW57eeVoLnGRonwv8xt/thzVSjpJYbtUhJp2NLVyk4wNpqt/6iB7zD
   kGEcaeLlFojIeMUkSA1RTw7kM229KNFgFu1z9iwDd2ENVGH/kY3SkqWTn
   cPp02ncHdrM24TBfhtrYIM+uy2QfKTQ7ZEeq+4eWMSTHlfxytv219CNZc
   uXi7ZSiXtlyaqqNXSMIFhY/n28vUly7Cpio/e9936/dQ2baJACzaY5AgU
   E+Uo9AV+yH209SWxAhU4VkFomHCTfSMV6/cmEIzW3GXwkTemsbYFMenu5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="327570441"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="327570441"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 04:43:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="746261281"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="746261281"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 04:43:24 -0700
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     paulmck@kernel.org
Cc:     dave@stgolabs.net, frederic@kernel.org, jiangshanlai@gmail.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
        qiuxu.zhuo@intel.com, quic_neeraju@quicinc.com,
        rcu@vger.kernel.org, rostedt@goodmis.org
Subject: [PATCH v4 0/2] Stop kfree_scale_thread thread(s) after unloading rcuscale
Date:   Wed, 22 Mar 2023 19:42:39 +0800
Message-Id: <20230322114241.88118-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <a4a3e103-78b3-4be3-80b8-bbae7b1bb2f4@paulmck-laptop>
References: <a4a3e103-78b3-4be3-80b8-bbae7b1bb2f4@paulmck-laptop>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2:

 - Move rcu_scale_cleanup() after kfree_scale_cleanup() to eliminate the
   declaration of kfree_scale_cleanup().

 - Remove the unnecessary step "modprobe torture" from the commit message.

 - Add the description for why move rcu_scale_cleanup() after
   kfree_scale_cleanup() to the commit message.

v2 -> v3:

 - Split the single v2 patch into two patches.

 - Move the commit message description for why move rcu_scale_cleanup()
   after kfree_scale_cleanup() to Patch 1.

v3 -> v4 (No function changes):

 - Rebased Patch 1 & 2 on top of the rcu "-dev" branch.

 - Added two "Reviewed-by" tags to the commit message of Patch 2.


Qiuxu Zhuo (2):
  rcu/rcuscale: Move rcu_scale_*() after kfree_scale_cleanup()
  rcu/rcuscale: Stop kfree_scale_thread thread(s) after unloading rcuscale

 kernel/rcu/rcuscale.c | 199 ++++++++++++++++++++++--------------------
 1 file changed, 102 insertions(+), 97 deletions(-)


base-commit: 86b3da94693e412ca43d996a7e6ed5766ef7a5f4
-- 
2.17.1

