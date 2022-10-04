Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A169A5F4B9A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 00:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiJDWFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 18:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiJDWFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 18:05:32 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586983C8C1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 15:05:24 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id DB9BEC01C; Wed,  5 Oct 2022 00:05:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1664921121; bh=FmRYiMqfekn9AN8DpzCa2by7y35Y1eEzLukhmKFSTy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uzTZTyPOXplk/lQKI5nszSC+A58/lowiQxhIE/DrvVRYLmw9NMGFSjZRbqR1zUm/b
         Wlq3SnqYnkGHypf5BTaeN0Wei7nQrn4JmEqsudZ8N+nK+gFdEy7GaCcah2vNyac1mh
         gtIiaKyzP/ZRHjYediSHLHBNIExSpDyG7wOh8OWpHh2uyMYY6gFj+atY51Ggx6Mzf9
         D7GMTr3Xi07D/rTb8+6p3q4UjBXDaSJ2b7umU3+cmL3TnjocD1Yn38VRBHGujHyuuJ
         wh+7rG3DVQOf8mi06r/Wa/omBeDmFys01BkGfk4hNBi0Ab0fmOGzwFotIJzCAjXNxJ
         8U/Juw+hjDNNw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 87FD9C009;
        Wed,  5 Oct 2022 00:05:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1664921121; bh=FmRYiMqfekn9AN8DpzCa2by7y35Y1eEzLukhmKFSTy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uzTZTyPOXplk/lQKI5nszSC+A58/lowiQxhIE/DrvVRYLmw9NMGFSjZRbqR1zUm/b
         Wlq3SnqYnkGHypf5BTaeN0Wei7nQrn4JmEqsudZ8N+nK+gFdEy7GaCcah2vNyac1mh
         gtIiaKyzP/ZRHjYediSHLHBNIExSpDyG7wOh8OWpHh2uyMYY6gFj+atY51Ggx6Mzf9
         D7GMTr3Xi07D/rTb8+6p3q4UjBXDaSJ2b7umU3+cmL3TnjocD1Yn38VRBHGujHyuuJ
         wh+7rG3DVQOf8mi06r/Wa/omBeDmFys01BkGfk4hNBi0Ab0fmOGzwFotIJzCAjXNxJ
         8U/Juw+hjDNNw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id ddebc26d;
        Tue, 4 Oct 2022 22:05:17 +0000 (UTC)
Date:   Wed, 5 Oct 2022 07:05:02 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Leon Romanovsky <leon@kernel.org>,
        syzbot+67d13108d855f451cafc@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] 9p: client_create/destroy: only call
 trans_mod->close after create
Message-ID: <YzyuDiQb6arOvUOm@codewreck.org>
References: <20221004215114.1850991-1-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221004215114.1850991-1-asmadeus@codewreck.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dominique Martinet wrote on Wed, Oct 05, 2022 at 06:51:13AM +0900:
> destroy code would incorrectly call close() if trans_mod exists after some
> hasty code cleanup: we need to make sure we only call close after create
> 
> The new bool added to track this has been added in a hole of the struct
> and will not increase p9_client's size.
> It might be possible to do better with a bit more work, but that will
> have to do for now.
> 
> Link: https://lkml.kernel.org/r/00000000000015ac7905e97ebaed@google.com
> Reported-by: syzbot+67d13108d855f451cafc@syzkaller.appspotmail.com
> Reported-by: Leon Romanovsky <leon@kernel.org>
> Fixes: 3ff51294a055 ("9p: p9_client_create: use p9_client_destroy on failure")

Oh... Fixing tags for stable made me notice this actually wasn't merged
into 5.19 unlike what I thought, so we only have the original bug of
potentially freeing the idr with tags still in it.

That's a much smaller bug and I'll just remove the first
p9_client_destroy on failure patch for this merge window (small leak
that requires root on error) ; then we can take time to properly fix
this one way or another for next cycle.

--
Dominique
