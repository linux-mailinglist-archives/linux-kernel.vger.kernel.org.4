Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D2C6EABB7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 15:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjDUNb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 09:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjDUNbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 09:31:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942B8E6B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 06:31:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AD2665089
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 13:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66360C433EF;
        Fri, 21 Apr 2023 13:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682083882;
        bh=8EBH2her048jzRogoWHFH1n6MVsvvaM24vMFjKhFL9o=;
        h=From:To:Cc:Subject:Date:From;
        b=QJcP8OFBxH2POlidm83wq7FLQ1m4RrO3Q+ZLEJj+BN/GCoohuxxtbEzjansmq9ed6
         TmXYgpN0sHfpqVo3Kmrb1ED2F3BCRP/WNVLFXdbAaJ9FctiL+SNluQ6/fEBnzseJC2
         9uxWCW+OALQY2J+QllzHRNIBM5TFoZk6oqsQ91sv6yAdEJXjYCae8epL1U/k9XXuNm
         nqkI9YFmYFsfvOuwyTNfHcKUNPLlvcR8uiRZudhet3t6Hme35HLje/I/QUQ/IFWqa3
         hk/GQo1q7Z26U/Nj/fKyJiE52mhGgQEu3m1Var+URi6eAwCC4FdVhH1QeHlWVQhtjb
         8cF6UGTwDnnkg==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] clone3 selftest fix
Date:   Fri, 21 Apr 2023 15:29:18 +0200
Message-Id: <20230421-semester-nothilfen-990da22419a2@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1595; i=brauner@kernel.org; h=from:subject:message-id; bh=8EBH2her048jzRogoWHFH1n6MVsvvaM24vMFjKhFL9o=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ49a8Uz138Uaks3e/5pfcO3bHBzf+0Vmkz1rr5PFYNO7JB J2t3RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQC5RkZnq1gvD6Bw3b5vinagUaOuu d5YnWf71k+vabhzuOOLed/KTH8r1Mw3WSqu/zga9OVqetenPxpNKeB23vFnw7vGd/enNrjwQoA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

/* Summary */
This is a single fix to the clone3() selftstests.
It fell through the sefltest tree cracks a few times so I'll provide
it here. It has low urgency but we should still correctly report the
number of tests.

/* Testing */
clang: Ubuntu clang version 15.0.6
gcc: (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on 6.3-rc4 and have been sitting in linux-next.
No build failures or warnings were observed. All old and new tests in
fstests, selftests, and LTP pass without regressions.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit 197b6b60ae7bc51dd0814953c562833143b292aa:

  Linux 6.3-rc4 (2023-03-26 14:40:20 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/v6.4/kernel.clone3.tests

for you to fetch changes up to d95debbdc528d50042807754d6085c15abc21768:

  selftests/clone3: fix number of tests in ksft_set_plan (2023-04-06 11:57:28 +0200)

Please consider pulling these changes from the signed v6.4/kernel.clone3.tests tag.

Thanks!
Christian

----------------------------------------------------------------
v6.4/kernel.clone3.tests

----------------------------------------------------------------
Tobias Klauser (1):
      selftests/clone3: fix number of tests in ksft_set_plan

 tools/testing/selftests/clone3/clone3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
