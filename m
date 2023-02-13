Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA80D6953F4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 23:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjBMWiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 17:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBMWiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 17:38:15 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBFE1F5D3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 14:38:13 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id C222FC020; Mon, 13 Feb 2023 23:38:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676327914; bh=qc0SPeDsGDMpENtqVoAdYcVFFZk3bBzBoe7PO+dRXfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rIAoHAMVJeH0jUxCLHmE5cjx0rHAHVht2Ln/jv+EnjiU6pl1fWHUlqvHYlDnIxQy6
         EmAlEraE2Ik1P/ZlaLBxCKFBTeErM7QWYV7C+8Lno30MLwRA/ZLAGXZgOr6a2l4L3F
         hOJ8EgMpqAMdAeOzyly1oqio91Veov/l/7Xl1d/RR+3qqj0oVqDt03/rEBqc3ZtrY8
         I6dV0eZxz2fjw+3pV3fsYoglkQhHFfMG+PaGJyaV9DHVrMaz3C8Pr6b6jrGjrvMeNj
         4xe/3oj2JBTI1XyID2ESMWuXO5TS3uYV7HfUUWJY8EdDAoKhGV0yVwf7BvKsLU8Lkh
         7rE+3mQaRg7PQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id E227CC009;
        Mon, 13 Feb 2023 23:38:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676327914; bh=qc0SPeDsGDMpENtqVoAdYcVFFZk3bBzBoe7PO+dRXfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rIAoHAMVJeH0jUxCLHmE5cjx0rHAHVht2Ln/jv+EnjiU6pl1fWHUlqvHYlDnIxQy6
         EmAlEraE2Ik1P/ZlaLBxCKFBTeErM7QWYV7C+8Lno30MLwRA/ZLAGXZgOr6a2l4L3F
         hOJ8EgMpqAMdAeOzyly1oqio91Veov/l/7Xl1d/RR+3qqj0oVqDt03/rEBqc3ZtrY8
         I6dV0eZxz2fjw+3pV3fsYoglkQhHFfMG+PaGJyaV9DHVrMaz3C8Pr6b6jrGjrvMeNj
         4xe/3oj2JBTI1XyID2ESMWuXO5TS3uYV7HfUUWJY8EdDAoKhGV0yVwf7BvKsLU8Lkh
         7rE+3mQaRg7PQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 31ec479b;
        Mon, 13 Feb 2023 22:38:05 +0000 (UTC)
Date:   Tue, 14 Feb 2023 07:37:50 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH 0/5] Take 3 at async RPCs and no longer looping forever
 on signals
Message-ID: <Y+q7vvc2Sek8d7wG@codewreck.org>
References: <20230211075023.137253-1-asmadeus@codewreck.org>
 <4256068.OCvV93pMlr@silver>
 <2973654.udxrvWzM6v@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2973654.udxrvWzM6v@silver>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Schoenebeck wrote on Mon, Feb 13, 2023 at 07:45:34PM +0100:
> On Monday, February 13, 2023 7:26:54 PM CET Christian Schoenebeck wrote:
> > On Saturday, February 11, 2023 8:50:18 AM CET Dominique Martinet wrote:
> > > I've been working on async RPCs for a while and never had time to debug
> > > the last issues this had, but by limiting the async clunks to failures
> > > the impact is drastically smaller and I've not been able to reproduce
> > > any more bug so far.
> > > 
> > > This will require some more testing and I'm tempted to say this is not
> > > worth rushing this into the merge window next week-ish; the new problem
> > > Jens reported with task_work isn't really new and I'd rather get this
> > > right than rush new bugs in given the sour experience I've had with this
> > > patch series... Hopefully it'll get in this time.
> > > With that in mind I plan to take the patches in to my -next branch after
> > > the merge window, so this has time to get reviewed first.
> > > 
> > > I'd like to measure impact on performance as well, but really spent way
> > > more time on this than I already have, so that'll have to wait a bit.
> > 
> > I have not observed performance degradation, nor any (new) errors. So for
> > this entire series:
> > 
> > Tested-by: Christian Schoenebeck <linux_oss@crudebyte.com>
> 
> Sorry, strike that. :-/

Ugh! thanks for the test, I'm not making much sense of the trace (folio
wait bit means some background write isn't happening when flushing
before the setattr?) but I'll try to reproduce and have a look
today/tomorrow

-- 
Dominique
