Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C66692F36
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 08:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjBKHuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 02:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKHuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 02:50:51 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275441206B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 23:50:49 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 4BF52C01F; Sat, 11 Feb 2023 08:51:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676101870; bh=mZ7V6TvH4FiikbfdBWS/VYGEygwMettD8agI1gFOm1M=;
        h=From:To:Cc:Subject:Date:From;
        b=Sim4YISfEupjBbCSUW1dEtp1xy9940T9KIHPYJaHTzfTBMgTRimF9S0F9c6KjOGHU
         CVj/VBiQGPfGgO7P12lhm0etBp+UKNS7EULawsi7oRKOeQ4e6czX1EZQJF48QLxcxo
         h0vbdWVrBEq4W82UfDnK49Bg9GqKBF4ceHXsF+GZP5+8OYJ3aP1YLBGL7IJr4CLWAa
         y6ChuTVKp7Dc9Cn+tc7BqaE7NIzy2tNneRGw8Rwk64CBec9gbxGHOwPZAgf0Q/EnlW
         GKfANzIEWwyDY4nFEFzVpzeMeWEqB5Mm3D0cxXsy30xX8AhN/5k1DdZ2tbdYBJ4UK8
         bFBiFFV3rPy3Q==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id F1B04C009;
        Sat, 11 Feb 2023 08:51:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676101869; bh=mZ7V6TvH4FiikbfdBWS/VYGEygwMettD8agI1gFOm1M=;
        h=From:To:Cc:Subject:Date:From;
        b=UaVAGdvP1UrXfRlpEefbJxV82II9TLvIIo+tumn/ZPRwDTUbRn/lx4jItfYP6rWig
         lbs+hmErZz+dBzQYpBmDPwuZATvqkgYApuUB98U9e/jfg1QAStbnyJH7lfnvbl7FB5
         ZYOzsDbp5YBZbcsNW2u2PFhzmza7wSq2RTVxo9UJ+GLzLVVN3a4fxpCk4Dvq/JF6Dw
         ZKAuP/D/tT7IX2l5dtgzxUKMVdX9GtK1O5TjX8/iOFU3QZLavVSug48Ip3kOO4DH06
         OQsMkYsprDppSotSZAzDpAZl5vIlvIks8g146FIP6BddXMaRYAF0JaeKlk03KFFizZ
         VSQjqJGL+omxw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 7a50f303;
        Sat, 11 Feb 2023 07:50:41 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Latchesar Ionkov <lucho@ionkov.net>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 0/5] Take 3 at async RPCs and no longer looping forever on signals
Date:   Sat, 11 Feb 2023 16:50:18 +0900
Message-Id: <20230211075023.137253-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been working on async RPCs for a while and never had time to debug
the last issues this had, but by limiting the async clunks to failures
the impact is drastically smaller and I've not been able to reproduce
any more bug so far.

This will require some more testing and I'm tempted to say this is not
worth rushing this into the merge window next week-ish; the new problem
Jens reported with task_work isn't really new and I'd rather get this
right than rush new bugs in given the sour experience I've had with this
patch series... Hopefully it'll get in this time.
With that in mind I plan to take the patches in to my -next branch after
the merge window, so this has time to get reviewed first.

I'd like to measure impact on performance as well, but really spent way
more time on this than I already have, so that'll have to wait a bit.

The only good thing here is that this shouldn't conflict with Eric's
rework...


A few problems I ran into today:
 - not doing async clunks for retries led to massive fid leaks as soon
as I started doing async flush; I've described that in the clunk patch
but basically all the servers we tested with always replied with the
clunk before the flush, so the first clunk was never an error, so there
wasn't a need to retry at all... Because if it had it'd fall with
ERESTARTSYS immediately again, and it didn't.
This isn't perfect, but hopefully should be good enough to avoid too
many problems.

 - for flush itself, the waiting for all in-flight flushes before
sending new rpc isn't great, but I don't have any better idea.
I think in the general case we could get away with not waiting at all
most of the time (check if there are any pending flush sent by the
current tid?), but the current approach by making the thread not
killable at all (!) is much more conservative, so I feel like we
should try this much even if it costs a bit.


Anyway, here goes nothing. Comments please!


Dominique Martinet (5):
  9p/net: move code in preparation of async rpc
  9p/net: share pooled receive buffers size exception in p9_tag_alloc
  9p/net: implement asynchronous rpc skeleton
  9p/net: add async clunk for retries
  9p/net: make flush asynchronous

 include/net/9p/client.h |  15 +-
 net/9p/client.c         | 508 +++++++++++++++++++++++++---------------
 2 files changed, 339 insertions(+), 184 deletions(-)

-- 
2.39.1

