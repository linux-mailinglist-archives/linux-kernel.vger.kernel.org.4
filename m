Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E80740EFF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjF1Kjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:39:40 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:42504 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjF1Khb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:37:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 582F96129E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 10:37:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9650EC433C0;
        Wed, 28 Jun 2023 10:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687948650;
        bh=aH5Zi2HWLcJaXkjibaUhIqVkjSjeydXkdQfw0nYYoF8=;
        h=From:To:Cc:Subject:Date:From;
        b=J603JnL9uRIuxNuO2BDLuGuweOCS3KbMRwdDoSVQUZmNUuAu/k3H8S7x1O2T/5KVI
         9XsCl97Dbmi8RyiDzTS8aH/DHREMFwBLHWrJdItjpkWtJIn/5BvSVwOpwY2tf/tgZ4
         JlSy5yl4kuYlDbzdvwXOeGD9LhgUR3QAgAQ/tkw+iUYX+HmHOJNgpfpEfafoiFgVnx
         dOSN4BSzYNGy0X90ONno2MR/e3sIW6Ue1+4zNAvsRD+HQNdURuYBtu3cipQIenDk47
         plSPvSku7rfmgmAeNgoGT2cZGmVUlkAAZdAya/glNBtYJLjl7+ktTt8C/34/YXYPEv
         fLNjBOab5nXWA==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] pid: use flex array
Date:   Wed, 28 Jun 2023 12:37:19 +0200
Message-Id: <20230628-pokal-puzzeln-5199c679b051@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1638; i=brauner@kernel.org; h=from:subject:message-id; bh=aH5Zi2HWLcJaXkjibaUhIqVkjSjeydXkdQfw0nYYoF8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTM4Y38KT598+7PjOI/V7PMvx49YZLl/f5NQmv6pR26xM+I /dOR7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhInT3D/wjrprikIKv73AXaN3XeKT jdnqb7aHaO/5zUb1N+XDtY/Jbhf3hGcLPxMca8u8suds1etmMzZ/mnn8aH+Tter52lKbKlkxkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

/* Summary */
This contains Kees' work to make struct upid in struct pid a proper
flexible array and thus gets rid of a bunch of syzbot UBSAN warnings.

---

Sorry for sending this one later than the others.
It's pretty minimal though.

/* Testing */
clang: Ubuntu clang version 15.0.7
gcc: (Ubuntu 12.2.0-3ubuntu1) 12.2.0

All patches are based on v6.4-rc2 and have been sitting in linux-next.
No build failures or warnings were observed. All old and new tests in
selftests, and LTP pass without regressions.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/v6.5/kernel.pid

for you to fetch changes up to 757777eef55b48b310603d0a1f6591f2a138691b:

  pid: Replace struct pid 1-element array with flex-array (2023-05-30 17:46:48 +0200)

Please consider pulling these changes from the signed v6.5/kernel.pid tag.

Thanks!
Christian

----------------------------------------------------------------
v6.5/kernel.pid

----------------------------------------------------------------
Kees Cook (1):
      pid: Replace struct pid 1-element array with flex-array

 include/linux/pid.h    |  2 +-
 kernel/pid.c           | 13 ++++++++-----
 kernel/pid_namespace.c |  2 +-
 3 files changed, 10 insertions(+), 7 deletions(-)
