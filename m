Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A79D6FE20E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjEJQEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjEJQEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:04:36 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9F26E9D;
        Wed, 10 May 2023 09:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=qFGSltMU0maRHIab4CSVoDypiDLSU+vjevviExVnq68=; t=1683734674; x=1684944274; 
        b=NfIHh2t4uPYeNV51QJQl1jf2Cc8cXd+wYZvILgZgBmWjoUBRB1M/xq+ImeF6jFsQRg4qPMDRU1w
        Zk1lRPwNBsbBNZvdAZEQIxyocU9Qzyr66PnV3u+/ycE9/9T+T6gebe20nYtGYwmAM4W9WvMjE5rEq
        0WptHGgExdQ4dxmt/S1qEqJN5a8wEzjtywL7udOCxUGPIdmDEy8bP2Tc9QnNdUuJV0b65aDlOovSf
        HdiqcrRrfXl/Qr8NtpkV772bfnmMJcacGmAQID68qimfiknRnAYK7fCtjfqHereht0TFy78ffp0hg
        kacNRNdVECfjKFdcesUqE5hU8KV55GWh1sbw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pwmIq-005Uq9-1R;
        Wed, 10 May 2023 18:04:32 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [RFC PATCH 0/4] wifi locking simplification start
Date:   Wed, 10 May 2023 18:04:24 +0200
Message-Id: <20230510160428.175409-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

So maybe this outlines my thinking a bit better.

I'm adding two new bits of infrastructure to workqueues,
with the end result that a 'special' workqueue can be
completely serialized with other code even as far as
execution of a work is concerned.

The real advantage of this isn't the locking simplification
you see in patch 4, the real advantage is that mac80211
will later be able to use that workqueue, and even if it's
called from cfg80211 where the wiphy_lock() is already held
it can still properly clean up its own work structs. This
is a thing that in the passed caused the huge proliferation
of locks in mac80211, which really aren't needed since (a)
it also uses an ordered workqueue, and (b) all the drivers
have just their own underlying single lock to access the
device. Which makes sense, really, there's only one device.

As a consequence, this will allow us to radically simplify
locking, even with drivers not needing any locks, since all
(control!) paths will hold one mutex.

The second patch in this series is sort of not necessary,
we could just make our own worker infrastructure in cfg80211
and hold the lock there, but it seemed simple enough to at
least throw it out there; if you don't like it, I can just
rework without it, but maybe other subsystems may have some
ideas along the same lines in the future.

Even the first patch isn't strictly needed, I previously
posted a version of the third patch without it, but again
it seemed pretty simple here and less overhead.

An alternative overall might be to just get rid of both of
those patches, and put a separate work list into cfg80211,
and just execute those work structs off a single "real"
work struct on the workqueue, with appropriate locking and
exclusion, but that builds very local infrastructure where
this might be useful to others too?

Anyway, just an RFC right now. As described above the real
meat would only kick in later when we push this through to
mac80211 and even drivers.

johannes


