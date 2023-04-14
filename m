Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363956E2414
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 15:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjDNNNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 09:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjDNNNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:13:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FDE3A8D;
        Fri, 14 Apr 2023 06:13:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E5EE647AD;
        Fri, 14 Apr 2023 13:13:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADEDC433EF;
        Fri, 14 Apr 2023 13:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681478020;
        bh=jKSx0MxXc8qHaQ8KeJbSXbIdQoP+ohJUZhAj5Nn0cd4=;
        h=From:To:Cc:Subject:Date:From;
        b=ELIh4tGzxahT2biMJGnJDciRv2w82yxCBdurq0+p/4F68e4x2wv4VdZNWKGnqgPFC
         Hy+9NkMW5BzWY5PPQt/a7wVBE2qm49HoS0ygEyjKcXMyTu7ign3Hb3OFFvWdR5xWlS
         XcwtmOfCrGIJnBSiJnn+7t5PeVZMgxRWbaKI7dEy4USD23Xxem6BvZfw9hK+UCCSpS
         PJ9IoD8gRDDv3BLYoBD+E40rWA/o5/IZiE8QKosC1nIfU0McXO5u6uwydykEnUoXNg
         lS3QWIBMOV3VlcoYr4GC0qBr2kbBWpCzC8eIdi9puN2Hc63Nw7M+f6shios2gCgI+v
         ktE+qTfD/fj3Q==
From:   broonie@kernel.org
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: linux-next: manual merge of the modules tree with the mm-everything tree
Date:   Fri, 14 Apr 2023 14:13:30 +0100
Message-Id: <20230414131330.1053570-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the modules tree got a conflict in:

  scripts/gdb/linux/constants.py.in

between commit:

  96839cd89fa9f ("scripts/gdb: print interrupts")

from the mm-everything tree and commit:

  b4aff7513df32 ("scripts/gdb: use mem instead of core_layout to get the module address")

from the modules tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc scripts/gdb/linux/constants.py.in
index 36fd2b1458531,8085d3693a055..0000000000000
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@@ -58,10 -54,9 +58,13 @@@ LX_VALUE(SB_NODIRATIME
  /* linux/htimer.h */
  LX_GDBPARSED(hrtimer_resolution)
  
 +/* linux/irq.h */
 +LX_GDBPARSED(IRQD_LEVEL)
 +LX_GDBPARSED(IRQ_HIDDEN)
 +
+ /* linux/module.h */
+ LX_GDBPARSED(MOD_TEXT)
+ 
  /* linux/mount.h */
  LX_VALUE(MNT_NOSUID)
  LX_VALUE(MNT_NODEV)
