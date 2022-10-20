Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F939606B4B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 00:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiJTWgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 18:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJTWgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 18:36:33 -0400
Received: from p3plwbeout15-04.prod.phx3.secureserver.net (p3plsmtp15-04-2.prod.phx3.secureserver.net [173.201.193.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E261B65C0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 15:36:30 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.145])
        by :WBEOUT: with ESMTP
        id le9MojL9sA2xwle9NoEYOU; Thu, 20 Oct 2022 15:36:29 -0700
X-CMAE-Analysis: v=2.4 cv=Z5UpoFdA c=1 sm=1 tr=0 ts=6351cd6d
 a=7e6w4QD8YWtpVJ/7+iiidw==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=Qawa6l4ZSaYA:10 a=yWIVPUuzvU3vGxsu7U8A:9
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  le9MojL9sA2xw
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=phoenix.fritz.box)
        by smtp12.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1ole9M-0006zQ-4P; Thu, 20 Oct 2022 23:36:28 +0100
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     hsinyi@chromium.org, regressions@leemhuis.info,
        regressions@lists.linux.dev, dimitri.ledkov@canonical.com,
        michael.vogt@canonical.com, phillip.lougher@gmail.com,
        ogra@ubuntu.com, olivier.tilloy@canonical.com
Subject: [0/3] squashfs: fix some regressions introduced in the readahead code
Date:   Thu, 20 Oct 2022 23:36:13 +0100
Message-Id: <20221020223616.7571-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfIFzlIKSW3XYzndlyK3M7JgxAcxICOuXXO8radpldVOTlbDE48hfp5jDgl6yt923e2ox6Nh+FQoyOjMM8f4Xgkf158Hv9r5L1EQRjwYZQ0h+CDdtUBHp
 /v2aOlUjHPMvSbqATUJCDv5y3L54DwRC5kPir9xrqCw0SV6mAmGiUw/fPL3aA5j0kT+PFYN0lm6GA5nQUMSz+FqhQhf2AocFgkE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch-set fixes 3 regressions introduced by the recent readahead code.
The first regression is causing "snaps" to randomly fail after a couple of
hours or days, which how the regression came to light.

----------------------------------------------------------------
Phillip Lougher (3):
      squashfs: fix read regression introduced in readahead code
      squashfs: fix extending readahead beyond end of file
      squashfs: fix buffer release race condition in readahead code

 fs/squashfs/file.c       | 23 ++++++++++++++---------
 fs/squashfs/page_actor.c |  3 +++
 fs/squashfs/page_actor.h |  6 +++++-
 3 files changed, 22 insertions(+), 10 deletions(-)
