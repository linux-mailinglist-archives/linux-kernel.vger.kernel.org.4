Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EDA692F4A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 09:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjBKIGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 03:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjBKIGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 03:06:01 -0500
X-Greylist: delayed 902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 11 Feb 2023 00:06:00 PST
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5EA5BA65
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 00:06:00 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id E4F9BC01D; Sat, 11 Feb 2023 09:06:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676102781; bh=/4p9G+PVx8BGkfwEmhVgFFfnUl5ZHemCeP8SNirq5Lw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XcIOAxaKklddAXtfwh3QZJOZWBvjhO64tAB61EL25BX2JbwIVbj4iqTxjyLpLeQJX
         YC44bKPVLfSEny3Vat9VvD8SF6sbSQBG5GvX2FXuEdSogTQ02RV0vsa3FtHm3+i2zL
         jGL0w3SnJ8/ayvaZJSCJvTqlV7lGKHodxIFplC6PLNdmdLqQSMuS7DwmCYpnozxvX3
         pyq0aQgk+dhn9F/8nAe/7RWleQ6uCzggET47CE2QepGaeJ6gv5hW6moAGcEcqJzxdS
         USJA9oO+6PARLCGc/xIiUWktDQbDHcdGXtaQ2+y1lQ20cbJOrjlfL2FFaH+4raZLeZ
         jXFh13qSNBd6Q==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 52444C009;
        Sat, 11 Feb 2023 09:06:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676102781; bh=/4p9G+PVx8BGkfwEmhVgFFfnUl5ZHemCeP8SNirq5Lw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XcIOAxaKklddAXtfwh3QZJOZWBvjhO64tAB61EL25BX2JbwIVbj4iqTxjyLpLeQJX
         YC44bKPVLfSEny3Vat9VvD8SF6sbSQBG5GvX2FXuEdSogTQ02RV0vsa3FtHm3+i2zL
         jGL0w3SnJ8/ayvaZJSCJvTqlV7lGKHodxIFplC6PLNdmdLqQSMuS7DwmCYpnozxvX3
         pyq0aQgk+dhn9F/8nAe/7RWleQ6uCzggET47CE2QepGaeJ6gv5hW6moAGcEcqJzxdS
         USJA9oO+6PARLCGc/xIiUWktDQbDHcdGXtaQ2+y1lQ20cbJOrjlfL2FFaH+4raZLeZ
         jXFh13qSNBd6Q==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 0c5daf8e;
        Sat, 11 Feb 2023 08:05:54 +0000 (UTC)
Date:   Sat, 11 Feb 2023 17:05:39 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Latchesar Ionkov <lucho@ionkov.net>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH 0/5] Take 3 at async RPCs and no longer looping forever
 on signals
Message-ID: <Y+dMU4dRatN40BLF@codewreck.org>
References: <20230211075023.137253-1-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230211075023.137253-1-asmadeus@codewreck.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dominique Martinet wrote on Sat, Feb 11, 2023 at 04:50:18PM +0900:
> A few problems I ran into today:
> [...]

Ah, one more thing I forgot: I'm still convinced that
p9_virtio_zc_request is wrong in its current (before these patches), and
adding this on top doesn't make it any better.

We'll likely want to fix that too before merging this, giving another
reason to dealy this for 6.4.

p9_virtio_zc_request shouldn't unpin the pages if wait_event_killable is
interrupted, and the flush async cb should call back in the transport to
unpin at that point or something?

I'm probably repeating myself here but I really don't have time in the
day for everything, so that too will have to wait...
(and there's probably more I forgot, but that'll do for now)

-- 
Dominique
