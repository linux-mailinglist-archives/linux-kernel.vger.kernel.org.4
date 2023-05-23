Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D04570E24C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237147AbjEWQrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjEWQrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:47:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11D6C2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:47:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37A2A633C6
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 16:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF54C433D2;
        Tue, 23 May 2023 16:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684860457;
        bh=P+E5V4yXEwV4VUqoxxCmc9HAaXwmyldyY2acq1W/+PM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pbzoM1Hpl+yazUyCg6hK7RyG+Nl1KNz1thduWK5rlj/DAXNyM17RKgH4rKMzVZx/s
         I0Jb30N2z0k9k/hjBcRsOsxlOBtCUEIudPnzyh7WJtYqsvTgYlYfc/tzPuZRdNtuMF
         KuN5MNfvCZogp998Gl4N3DDslwHfASZ+K5w+EJhfXg6gUlspMAm8G0LOxC8yMx9Pb1
         kDAGJMryjHftqKwWMBMs/LOG0xQoFxFl0Fey0YB46baTfD44zoCNDzTTtOw+iA26yG
         MbZcICZd47I7v/SK1pGP4TIlYyJ/8wcShC3A+hKGqqNQlgDw+jYNwNOJo0ydFwGkX8
         28ou9u5iKY3qA==
Date:   Tue, 23 May 2023 09:47:36 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        syzbot <syzbot+c2775460db0e1c70018e@syzkaller.appspotmail.com>,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        pabeni@redhat.com, wireguard@lists.zx2c4.com, jann@thejh.net
Subject: Re: [syzbot] [wireguard?] KASAN: slab-use-after-free Write in
 enqueue_timer
Message-ID: <20230523094736.3a9f6f8c@kernel.org>
In-Reply-To: <CAHmME9obRJPrjiJE95JZug0r6NUwrwwWib+=LO4jiQf-y2m+Vg@mail.gmail.com>
References: <000000000000c0b11d05fa917fe3@google.com>
        <ZGzfzEs-vJcZAySI@zx2c4.com>
        <20230523090512.19ca60b6@kernel.org>
        <CANn89iLVSiO1o1C-P30_3i19Ci8W1jQk9mr-_OMsQ4tS8Nq2dg@mail.gmail.com>
        <20230523094108.0c624d47@kernel.org>
        <CAHmME9obRJPrjiJE95JZug0r6NUwrwwWib+=LO4jiQf-y2m+Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 18:42:53 +0200 Jason A. Donenfeld wrote:
> > It should, no idea why it isn't. Looking thru the code now I don't see
> > any obvious gaps where timer object is on a list but not active :S
> > There's no way to get a vmcore from syzbot, right? :)
> >
> > Also I thought the shutdown leads to a warning when someone tries to
> > schedule the dead timer but in fact add_timer() just exits cleanly.
> > So the shutdown won't help us find the culprit :(  
> 
> Worth noting that it could also be caused by adding to a dead timer
> anywhere in priv_data of another netdev, not just the sole timer_list
> in net_device.

Oh, I thought you zero'ed in on the watchdog based on offsets.
Still, object debug should track all timers in the slab and complain
on the free path.
