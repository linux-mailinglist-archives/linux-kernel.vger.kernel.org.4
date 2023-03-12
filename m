Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A8A6B6503
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 11:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjCLKn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 06:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCLKn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 06:43:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8763B21A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 03:43:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2C77B802C8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 10:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FADC433EF;
        Sun, 12 Mar 2023 10:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678617831;
        bh=8GYf+PQQi+kaUF7gA17EyaQA3meYNTr25JSOs5QGxd4=;
        h=From:To:Cc:Subject:Date:From;
        b=svpF/YY69ixI7wCHDn4DDvo7stlqLenNg1uVWcjTmHukSwG3TX4sxK2UvB/p1HUjg
         0KQD2Lpp7JZLOH3ZDVWB3hHscQeXMuYohnP81l0pbvf4CXXSVhv0/B1p5sUFCygZ9P
         pnvVTHM+0fD0E3DrosL35375JtuBp+iqP/X1UDf3unVPuQrZ0hGqZOazHKemfUIifF
         gHysy8JrGXXBuAvQJdptT7INUKXG+ApwnHecfGVbIBoPNgaER9B/KsTZPZk0b6xLrf
         8m7o6htyKWOgkCjlorrhsvoqK0t4cT98647veFi2HxSmRdcPUZDLA344WxYI6whx7K
         /dii6L96fUlLQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] clone3 fix for v6.3
Date:   Sun, 12 Mar 2023 11:43:20 +0100
Message-Id: <20230312104319.913293-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2091; i=brauner@kernel.org; h=from:subject; bh=8GYf+PQQi+kaUF7gA17EyaQA3meYNTr25JSOs5QGxd4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTwrjlo5NMYaH7w1fb/mTyaoYbLpLlseboNGAItFiakLfQz mu3aUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBHlNkaGZ+vVtB6WTGgVefx+suF8Yc Zt7B92uYgu/mc9R8bQZGefKiNDJ/Mt/R/9wRvzb8S9e6yUNclRYFvnUa+ELF2TTyFOb7fzAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

/* Summary */
This contains a simple fix for the clone3() system call. The
CLONE_NEWTIME allows the creation of time namespaces. The flag reuses a
bit from the CSIGNAL bits that are used in the legacy clone() system
call to set the signal that gets sent to the parent after the child
exits.

The clone3() system call doesn't rely on CSIGNAL anymore as it uses a
dedicated .exit_signal field in struct clone_args. So we blocked all
CSIGNAL bits in clone3_args_valid(). When CLONE_NEWTIME was introduced
and reused a CSIGNAL bit we forgot to adapt clone3_args_valid() causing
CLONE_NEWTIME with clone3() to be rejected. Fix this.

/* Testing */
clang: Ubuntu clang version 15.0.2-1
gcc: gcc (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on v6.3-rc1 and have been sitting in linux-next.
No build failures or warnings were observed. All old and new tests in
fstests, selftests, and LTP pass without regressions.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/kernel.fork.v6.3-rc2

for you to fetch changes up to 515bddf0ec4155cbd666d72daf5bd68c8b7cd987:

  selftests/clone3: test clone3 with CLONE_NEWTIME (2023-03-08 12:31:35 +0100)

Please consider pulling these changes from the signed kernel.fork.v6.3-rc2 tag.

Thanks!
Christian

----------------------------------------------------------------
kernel.fork.v6.3-rc2

----------------------------------------------------------------
Tobias Klauser (2):
      fork: allow CLONE_NEWTIME in clone3 flags
      selftests/clone3: test clone3 with CLONE_NEWTIME

 kernel/fork.c                           | 2 +-
 tools/testing/selftests/clone3/clone3.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)
