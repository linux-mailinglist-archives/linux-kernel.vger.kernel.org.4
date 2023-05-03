Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F397A6F5EBD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjECTAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 15:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjECTAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:00:06 -0400
X-Greylist: delayed 138804 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 03 May 2023 12:00:05 PDT
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050:0:465::103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692A572A5
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 12:00:04 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4QBR8d46lqz9sZK;
        Wed,  3 May 2023 21:00:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1683140401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kd4WwoqlDq8W1IwkIvxY9uUCOlAljhhWlJJQqwLWlE8=;
        b=BG/F0nPUX2yAea6wYXJ1ndute0ps9hFS8otigOWBln6cYAMxT/HBjVGozB/TPmhirB7GrD
        Iy7tQnjqSG4FY/P/lBhYpSq5OMPjfq9N4RBn0w5yEwKi0L08Zl/Q4Ycd1FUK2IcnygM1nN
        8ZSfv4YEtji/GC1+aABrXGOxcJGihqAZv+PIWHiFZuwyFiEnRYyx16NjjbJsy5XJK6Bzz/
        bkcbZkk1m3wfTibQWWOQPZR7HqcCOeSA8DNEq17Oy05iHIlryEEKsmSge7ftx8eRvE2rJ8
        EPxqX3RTTcOcnSUvV0Blia9efhczDHIew4qDqqbdLQIzWnSGbGNesJZW6znokg==
Message-ID: <6159a755f5d13763a3dda36781d56d27c29445cd.camel@mailbox.org>
Subject: About me and about btree_blue
From:   liuwf <liuwf@mailbox.org>
To:     linux-kernel@vger.kernel.org
Cc:     joern@purestorage.com, torvalds@linux-foundation.org
Date:   Wed, 03 May 2023 14:59:51 -0400
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 4oem9ibemxog7hfng3whnq3fy6zybd8h
X-MBO-RS-ID: 7f9a269307bee5c6c5e
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


With several days of upgrading since btree_blue's first RFC posted in kernel
mailling list, currently btree_blue can be observed 40% or more faster than
the original lib/btree in random inserts/deletes, and 10x (1000%) faster than 
rbtree when traversing a 1M keys in a tree.  

Basically, btree_blue under linux run 2xx ms or even 1xx ms per 1M operations,
this rate may be prudently comparing with Google's btree, the later is single-
thread btree(fixme) at a rate level of 1xx ~ 2xx ms per 1M operations also. 

I'm agreed wtih Linus's comments on my RFC, multi-thread frendly trees are 
more important than signle-thread one in high-perf required cases. Besides, 
I'm also afraid that btree_blue is still needed to be faster when used in some
cases - even if those cases may not be easily replaced by multi-thread trees. 

Imaging one is waiting to check-out at the gate after selected his goods, 
there are a dozen of cashing channels in the mall - that's fine, and, even 
though there is no one else queued in any of those cashing channels except 
himself, a question still exists for him: how much time is used to service him
singly ? normally we are seviced within 3 or 5 minutes, if the time is 15 
minutes or more our shopping experience may be different - even if there are
a dozen of cashing channels.

The perf rise in my patchs are not based on a group of stamp-collectors. In 
today's linux kernel community, it is a challenge for almost any twenty percent 
advances, because any present codes we can see (btree, rbtree. etc.) are 
excellent enough. In fact, the only reason for me to choose the name 
btree_blue is that I'm quite concerned my patch's perf if it is slower than
original one after I added several features to it, I don't think anyone will 
be happy to accept or give a review for a mediocre patch, so I decide to give
the temporary name to it rather than call it lib/btree's patch before post it 
out. But I still think it is good for me to call it as btree's patches even if
it's relatively fast and have more features, because that presents a faith - 
every people offer his idea to make things better - the Linux spirit.

Two months before I posted a patch for btrfs after I decided to give some in-
depth studies to the file system again, which is one of my favourit.That patch 
targets to one of two code-paths in btrfs free space sub-system - a less normal
code-path, only run in a diffiuclt condition when the level of free space is 
lower. I am glad that I used a simple trick to rise the path's perf more than
200% from fstest result, but the patch has not been reviewed too. After that 
patch I found there are several places in another code-path - the mainline 
code-path of btrfs free space sub-system - may be given some improvments. 

In fact, a known developer of btrfs has also noticed problems and offered a set
of patchs to fix them several years ago. If I'm right, that set of patchs were
not applied finally, and this is a bit beyond me. I searched all btrfs mailling
list and found no info about their discussions on the thing, I guess they 
discussed in other occasions and dicided they had no needs for that set of 
patchs. But I still have some puzzle for the issue, and I think personally it
maybe better if another data structure is used in those cases. so I try to get
a btree-like thing to estimate the probability of applying in btrfs. I viewed
lib/btree and felt only one tiny pity for it - there is lack of a linear 
travesal in it(fixme). The good thing is that, Joern Engel's btree is elegant
and fast, so I decided to add several features based on it. As my said in 
previous patchs I found it is a challenge to keep the same perf and effective
with the original one when features added, so I have to do several optimizings
on it - that the btree's patch come from.

In next days I think I need some time to add several more APIs to the patchs
first and refine it, any opions is welcome.


