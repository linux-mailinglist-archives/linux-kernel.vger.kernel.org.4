Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D76A6E141E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 20:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjDMS0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 14:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjDMSZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 14:25:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC928A72;
        Thu, 13 Apr 2023 11:25:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CB9F640B2;
        Thu, 13 Apr 2023 18:25:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D13C433D2;
        Thu, 13 Apr 2023 18:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681410347;
        bh=ph4fXRi6oIbh9htiRmu0dWbvynpY2d1z+QyDZwciXss=;
        h=From:To:Cc:Subject:Date:From;
        b=i5+EPN3B4p5MqpnrUYB+6gE4+GIUrMuEFvxg/jCUNQ2cuyVxSWhZ1RAjXYyzR9JE7
         UwEFjdEX/meCCnK+yI8ZeTwPYyeTpvfksn+OwS/rKCDN/p6jeKroPk3E/oTA7tpnsN
         +GjHqO5wNHXfIfxKekIiUQStLUgQxWBboAaLtB6GgbI9o4PDe6iFMeNChYXaZ5mUfQ
         4D4lF6rAIi/qx6NdC0GGSFPTxQ+OHBXJOrlyMeYXlv8QeRKlOBTBFd47ORg/LY0xAI
         kWLmowVSWV9cJCYL3qwOYNi2/8mFXvTuYr6MeIMhP83lxccEJQRPj3I58wI5znk4RF
         kSdVCPIGz6++Q==
From:   broonie@kernel.org
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Apr 13
Date:   Thu, 13 Apr 2023 19:25:42 +0100
Message-Id: <20230413182542.1133335-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Changes since 20230411:

The sh tree gained a conflict with the mm-unstable tree.

The erofs tree gained a conflict with the vfs-idmapping tree.

The ext4 tree gained multiple conflicts with the mm-stable tree.

The net-next tree gained a conflict with the origin tree.

The bpf-next tree gained a conflict with the net-net tree.

Non-merge commits (relative to Linus' tree): 10382
 11028 files changed, 580165 insertions(+), 249563 deletions(-)

----------------------------------------------------------------------------

I have created today's linux-next tree at
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
(patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
are tracking the linux-next tree using git, you should not use "git pull"
to do so as that will try to merge the new linux-next release with the
old one.  You should use "git fetch" and checkout or reset to the new
master.

You can see which trees have been included by looking in the Next/Trees
file in the source.  There is also the merge.log file in the Next
directory.  Between each merge, the tree was built with a ppc64_defconfig
for powerpc, an allmodconfig for x86_64, a multi_v7_defconfig for arm
and a native build of tools/perf. After the final fixups (if any), I do
an x86_64 modules_install followed by builds for x86_64 allnoconfig,
powerpc allnoconfig (32 and 64 bit), ppc44x_defconfig, allyesconfig
and pseries_le_defconfig and i386, arm64, s390, sparc and sparc64
defconfig and htmldocs. And finally, a simple boot test of the powerpc
pseries_le_defconfig kernel in qemu (with and without kvm enabled).

Below is a summary of the state of the merge.

I am currently merging 357 trees (counting Linus' and 102 trees of bug
fix patches pending for the current merge release).

Stats about the size of the tree over time can be seen at
http://neuling.org/linux-next-size.html .

Status of my local build tests will be at
http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
advice about cross compilers/configs that work, we are always open to add
more builds.

Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
Gortmaker for triage and bug fixes.
