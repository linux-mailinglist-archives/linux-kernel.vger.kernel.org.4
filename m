Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08565F8D09
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 20:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiJISRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 14:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiJISQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 14:16:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BCC2CE00
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 11:15:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB03F60C38
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 18:15:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEACC433D7;
        Sun,  9 Oct 2022 18:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665339347;
        bh=dIhWemmhcrJkEADi3PjUFTm4lR2Lw6gcZBBCTCbrmH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o6zh19Z/xp2MfjX73mR8DSMb3M8LuCfWKR1yM147gYran8K+l8G/D/M5OKo+5Y/jF
         okm7hvGpCZcjAS2bvg///YvLVRcAcu036rFvxmMNazU4JB4gdekgjDIOjBGyOBw8HG
         PASVT6GVDXw4eSg0fAwl7h6VqP099Ph4MfIg9LqU=
Date:   Sun, 9 Oct 2022 20:16:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     "Christian A. Ehrhardt" <lk@c--e.de>, Tejun Heo <tj@kernel.org>,
        syzbot <syzbot+534ee3d24c37c411f37f@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH] cgroup: Fix crash with CLONE_INTO_CGROUP and v1 cgroups
Message-ID: <Y0MP/errn3nJ+9WQ@kroah.com>
References: <000000000000385cbf05ea3f1862@google.com>
 <00000000000028a44005ea40352b@google.com>
 <Y0CbtVwW6+QIYJdQ@slm.duckdns.org>
 <Y0HBlJ4AoZba93Uf@cae.in-ulm.de>
 <20221009084039.cw6meqbvy4362lsa@wittgenstein>
 <Y0LITEA/22Z7YVSa@cae.in-ulm.de>
 <20221009173519.jwuissylg5haicie@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009173519.jwuissylg5haicie@wittgenstein>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2022 at 07:35:19PM +0200, Christian Brauner wrote:
> On Sun, Oct 09, 2022 at 03:10:36PM +0200, Christian A. Ehrhardt wrote:
> > 
> > Since commit f3a2aebdd6, Version 1 cgroups no longer cause an
> > error when used with CLONE_INTO_CGROUP. However, the permission
> > checks performed during clone assume a Version 2 cgroup.
> > 
> > Restore the error check for V1 cgroups in the clone() path.
> > 
> > Reported-by: syzbot+534ee3d24c37c411f37f@syzkaller.appspotmail.com
> > Link: https://lore.kernel.org/lkml/000000000000385cbf05ea3f1862@google.com/
> > Fixes: f3a2aebdd6 ("cgroup: enable cgroup_get_from_file() on cgroup1")
> > Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> > ---
> 
> Thanks for fixing this,
> Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>

No cc: stable?  :(

