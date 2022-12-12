Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E1D64A802
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 20:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbiLLTQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 14:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbiLLTPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 14:15:51 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B3113FB9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 11:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670872542; x=1702408542;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pmkDGG0SCzGjvl2TyHg9CLp6eUz7InkcEkx47cTISGw=;
  b=DO/XmT4yUMJftdhxzELrqBeVP2wShdWobbLJjfnTy4koRGm+8US40TAj
   gCYmPaVQ9ai6pMY6e0ABuGLQOU0sQT69bbKkvIGCqIhVxjp54EvQ91lNo
   dMK3VYUGxGerbDP6chBTP6V4R6j38aVbjx/XwFKXZSeTXUyIvkdZuFL7z
   FF+SumrPE/wsqZgjXKkY0EUhVdVLby6ENBlBNhRXG3SnNpSlU5XjdWy86
   NK/pP1USqa82pe69RI0vpiNLr5kYNucFbS7G+In5Kuirtv0UXlBbNksll
   ojIiTWzcbg/d6jG+qqS08ZAuydt7KZI/UPrqQlA58cPwaTCa2xh4kfPT9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="317973432"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="317973432"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 11:15:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="716911531"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="716911531"
Received: from viggo.jf.intel.com (HELO ray2.sr71.net) ([10.54.77.144])
  by fmsmga004.fm.intel.com with ESMTP; 12 Dec 2022 11:15:24 -0800
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT PULL] x86/splitlock for 6.2
Date:   Mon, 12 Dec 2022 11:15:24 -0800
Message-Id: <20221212191524.553244-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull some x86/splitlock changes for v6.2.

This includes a single change which enables users to reduce the
penalty inflicted on split lock users.  There are some
proprietary, binary-only games which because entirely unplayable
with the old penalty.

Anyone opting into the new mode is, of course, more exposed to
the DoS nasitness inherent with split locks, but they can play
their games again.

--

The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:

  Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_splitlock_for_6.2

for you to fetch changes up to 727209376f4998bc84db1d5d8af15afea846a92b:

  x86/split_lock: Add sysctl to control the misery mode (2022-11-10 10:14:22 -0800)

----------------------------------------------------------------
Add a sysctl to control the split lock misery mode

----------------------------------------------------------------
Guilherme G. Piccoli (1):
      x86/split_lock: Add sysctl to control the misery mode

 Documentation/admin-guide/sysctl/kernel.rst | 23 +++++++++++
 arch/x86/kernel/cpu/intel.c                 | 63 ++++++++++++++++++++++++-----
 2 files changed, 76 insertions(+), 10 deletions(-)
