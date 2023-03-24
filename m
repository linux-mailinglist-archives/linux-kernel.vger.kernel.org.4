Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C716C832D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 18:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjCXRRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 13:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbjCXRRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:17:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D47122CAE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 10:16:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8725462C21
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 17:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDAEAC4339E;
        Fri, 24 Mar 2023 17:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679678149;
        bh=KrjiDQaOUAvwQXctCJJ1xKGvf9WKffnW0brnRQ1xCp4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FpYVh15XZKhcENjTUinTA3SnkEZhZtMO+IzkRhPQeCet962agA2JUefL3CRitm0oA
         xlxyYEOatzUTDERPDc/uNvYV68grV745yvzrW1EBBk/d92M3f18+A4PXJj0uehexVj
         bDeKw01zwMXcvZG5SwTcxoPGnxPeyglIp+VlgAllqlPKPQ90RVK1yseNLcb3BA4s8i
         MOmP3UJ3MqWmSMVFIeWUmGm44b3JOGtj/MKdTAUoN2OwO/zWJ2TVWJQV8AjaoAprDf
         4i+5615NSxR0JQAFhr08Zq14dC8/cFnVrFOI1AyB6Ex2VEyw8tIK+2k0V4sYm9oAt2
         FHc9p0OS9XSXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9756C41612;
        Fri, 24 Mar 2023 17:15:48 +0000 (UTC)
Subject: Re: [GIT PULL] slab fix for 6.3-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <a329d2a9-9617-e00f-3bb8-3f5dcf07329f@suse.cz>
References: <a329d2a9-9617-e00f-3bb8-3f5dcf07329f@suse.cz>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <a329d2a9-9617-e00f-3bb8-3f5dcf07329f@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-fix-for-6.3-rc4
X-PR-Tracked-Commit-Id: 66a1c22b709178e7b823d44465d0c2e5ed7492fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cb7f5b41f8341148050fe63e27cf52aa4f1519ad
Message-Id: <167967814881.905.634782433585733452.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Mar 2023 17:15:48 +0000
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Mar 2023 16:04:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-fix-for-6.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cb7f5b41f8341148050fe63e27cf52aa4f1519ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
