Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83FE67A492
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 22:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbjAXVGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 16:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjAXVGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 16:06:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F692685;
        Tue, 24 Jan 2023 13:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ICVtCCIF1RiNdVb4bcXjAxEATA+1B36ocUpH9tEa/Rk=; b=0pSMUehe8Ctxx4L4c5TRzt5BrB
        3GVHzjJq3uXA6ScWh1t0lmIcglHsyGfGnJiMXmanx6gpmWUNUPpfTu36oNJPY0DtzK68IGL2qwMFg
        qN62h6OwCTv9bCNtZdl2qEU790kBjCUDuQUZRAPtvknWdxXsqKM0e8RuTSafUN0DifpCrvBHLBKSQ
        09v0trTCObn5kz455lvS/TF0xGSE+lvtPEMoLrnmjz+HmMC03MbtmVltiz3DxdQ64fUXpWvO471zh
        DeqqezreU18kmWvTPk6xStiEskZt94CSgNnJqFe28l4jagn7AaYoG8TRXyv79/e14JFQeHIAek2CS
        HdLl3Rpg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKQUt-005LXx-7r; Tue, 24 Jan 2023 21:06:27 +0000
Date:   Tue, 24 Jan 2023 13:06:27 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>, pmladek@suse.com
Cc:     petr.pavlu@suse.com, prarit@redhat.com, pmladek@suse.com,
        mwilck@suse.com, vegard.nossum@oracle.com, ebiederm@xmission.com,
        david@redhat.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] modules changes for v6.2-rc6
Message-ID: <Y9BIU5SGOS6YEdSh@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7bf70dbb18820b37406fdfa2aaf14c2f5c71a11a:

  Merge tag 'vfio-v6.2-rc6' of https://github.com/awilliam/linux-vfio (2023-01-23 11:56:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.2-rc6

for you to fetch changes up to 0254127ab977e70798707a7a2b757c9f3c971210:

  module: Don't wait for GOING modules (2023-01-24 12:52:52 -0800)

----------------------------------------------------------------
modules-6.2-rc6

There has been a fix we have been delaying for v6.2 due to lack of
early testing on linux-next. The commit has been sitting on linux-next
since December and testing has also been now a bit extensive by a few
developers. Since this is a fix which definitely will go to v6.3 it
should also apply to v6.2 so if there are any issues we pick them up
earlier rather than later. The fix fixes a regression since v5.3, prior
to me helping with module maintenance, however, the issue is real in
that in the worst case now can prevent boot.

We've discussed all possible corner cases [0] and at last do feel this is
ready for v6.2-rc6.

[0] https://lore.kernel.org/all/Y9A4fiobL6IHp%2F%2FP@bombadil.infradead.org/

----------------------------------------------------------------
Petr Pavlu (1):
      module: Don't wait for GOING modules

 kernel/module/main.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)
