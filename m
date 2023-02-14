Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CBC696231
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjBNLRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjBNLRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:17:08 -0500
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBE8DBC1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:17:02 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id E5CC4C009; Tue, 14 Feb 2023 12:17:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676373443; bh=/eJLX6N8Wql6x4hLGnwhV1ycbyVYDBW+JqG/0usBf8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1qSqZIRf8f79863Rt5SSzu0gb9GWeRyNw4zSD3bw4+SAWl6IYgD/6uUvANG+cy6VJ
         z8lsR8hE3Zw+voqjc88eXUNNUL4Shl1cejt83NMWHslUyropbhESBZfhwwDrPnG0Ju
         qXmGw3sTN74pGhGOmsGj+V/KXy8VtQt+ThNKG9wTJZnNYVZbwO0Cv7uQFFDMwWksc3
         Y8NdaPNSEDQKQRH0Znj9qZdyrDilclRdhr+sDmal+Q41KZUSo6G8ltuchjbp3h5d8N
         L1JSR6hp7U0sr2DUerslNSHtYflwTSpBYqFPLhVNMfJH4Gl/99VzbrW9bAeUg+jCU5
         0Zw+vmF6ej0+Q==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 30937C009;
        Tue, 14 Feb 2023 12:17:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676373442; bh=/eJLX6N8Wql6x4hLGnwhV1ycbyVYDBW+JqG/0usBf8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PO9bv7qBRs2vQdKPuM0RSEXej0qKOwrCJXiVIfwgIJn1UhHzwhtS/4f00TuxAWeqF
         nQj32YMFGCi2//GMEdlUXXlQoxJD/T43GECn6Au3N/cOGm78QDpSi9YUxjoZK4wvtN
         WNoItWJH/0O4tOoBUN7UXmN80NjlEl8v9A+JCMzUVq3n9I1g9i4KUkNfk4hyEfmX1Y
         msMM/39F4SWNPPZPnDRFUsM2n0HyMFYq4BIh2agAYlqGol7mB+/11W3tG3j23lsk8z
         URVTX/ZnKT/ok9dZV+co8wkOQnmiRioOyomXHa5Q7kGvO/I6lh81VqvhWXSwYWfshU
         rdYiMfi2o6gfQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 6b2bd355;
        Tue, 14 Feb 2023 11:16:53 +0000 (UTC)
Date:   Tue, 14 Feb 2023 20:16:38 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH 0/5] Take 3 at async RPCs and no longer looping forever
 on signals
Message-ID: <Y+ttlog6sth3vPHJ@codewreck.org>
References: <20230211075023.137253-1-asmadeus@codewreck.org>
 <2973654.udxrvWzM6v@silver>
 <Y+q7vvc2Sek8d7wG@codewreck.org>
 <2526146.SOovFYVi4y@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2526146.SOovFYVi4y@silver>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Schoenebeck wrote on Tue, Feb 14, 2023 at 10:34:36AM +0100:
> > Ugh! thanks for the test, I'm not making much sense of the trace (folio
> > wait bit means some background write isn't happening when flushing
> > before the setattr?) but I'll try to reproduce and have a look
> > today/tomorrow
> 
> Yes, apparently it tries to write dirty pages of the mapped file and keeps
> hanging there [fs/9p/vfs_inode_dotl.c:586]:

Yeah, it'd help to get the trace of the thread actually trying to do the
IO, if it still exists.
I had some hangs in the check that there are no flush in flight at some
point, and I thought I fixed that, but I can't really see anywhere else
that'd start hanging with this... it'll be clearer if I can reproduce.


Anyway, I found another bug, just running ./configure on a random project
(picked coreutils tarball) fails with interrupted system call ?!

checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking whether make supports nested variables... yes
checking whether make supports nested variables... (cached) yes
checking for gcc... gcc
./configure: line 6385: can't create conftest.c: Interrupted system call
checking whether the C compiler works... no
sed: can't read conftest.c: No such file or directory
configure: error: in `/mnt/coreutils-9.1':
configure: error: C compiler cannot create executables
See `config.log' for more details


This obviously doesn't happen if I run with `sh -x configure`, but
through execsnoop I caught it's just calling 'gcc conftest.c' and
there's nothing special in here... But it doesn't happen without these
patches, so I get something to dig at first.
With a bit of luck it's the same root cause...

-- 
Dominique
