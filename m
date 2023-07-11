Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7490274EC4E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjGKLJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjGKLJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:09:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0055F9B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:09:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9270061478
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 11:09:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4288FC433C7;
        Tue, 11 Jul 2023 11:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689073790;
        bh=IHPGTpFNkJxjHd3j16Zp70SLf28Ex3L77RYopTx73vw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N0ctGuSk3DmmruB+WZyZ7fdwiXQcBQy9J5r3j2ak9JiXtDOh5iv1ZbpXz7qM041es
         ixEMi9ew/4iNZk5ZpKcOsgOK37mZJsMtBJJkluoFOAi25JuHUA3xOG/L4BoULPlW2Q
         7AufnLkjlD+s8RBcLb7tzQBbWNSzqIqcfU3DEK6RnRCtm+XHGMrSQ+QUVQOM4L30mn
         Tf3o1tsGiNzd0WP+FErjYIl8UVrOmxU3cA6pf0Pcfoe7jCU4W67tAkUCyQjsg/lY38
         091e6SbuNhv7Aps+Az+9f0ciPBFBnGgeFHNJYdbY8kiuVdCFn8AKk7h29xGWhMYFAV
         BWid01Yq4G9tg==
Date:   Tue, 11 Jul 2023 14:09:45 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        paulmck@kernel.org, mingo@redhat.com, will@kernel.org,
        luto@kernel.org, songliubraving@fb.com, peterx@redhat.com,
        david@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        regressions@leemhuis.info,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        maorg@nvidia.com, gal@nvidia.com, ranro@nvidia.com,
        drort@nvidia.com, idok@nvidia.com, sergeyy@nvidia.com
Subject: Re: [PATCH v4 00/33] Per-VMA locks
Message-ID: <20230711110945.GO41919@unreal>
References: <20230227173632.3292573-1-surenb@google.com>
 <20230711103541.GA190975@unreal>
 <53676850-539f-2813-d55d-a8bc0ec88092@suse.cz>
 <20230711110141.GN41919@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711110141.GN41919@unreal>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 02:01:41PM +0300, Leon Romanovsky wrote:
> On Tue, Jul 11, 2023 at 12:39:34PM +0200, Vlastimil Babka wrote:
> > On 7/11/23 12:35, Leon Romanovsky wrote:
> > > 
> > > On Mon, Feb 27, 2023 at 09:35:59AM -0800, Suren Baghdasaryan wrote:
> > > 
> > > <...>
> > > 
> > >> Laurent Dufour (1):
> > >>   powerc/mm: try VMA lock-based page fault handling first
> > > 
> > > Hi,
> > > 
> > > This series and specifically the commit above broke docker over PPC.
> > > It causes to docker service stuck while trying to activate. Revert of
> > > this commit allows us to use docker again.
> > 
> > Hi,
> > 
> > there have been follow-up fixes, that are part of 6.4.3 stable (also
> > 6.5-rc1) Does that version work for you?
> 
> I'll recheck it again on clean system, but for the record:
> 1. We are running 6.5-rc1 kernels.
> 2. PPC doesn't compile for us on -rc1 without this fix.
> https://lore.kernel.org/all/20230629124500.1.I55e2f4e7903d686c4484cb23c033c6a9e1a9d4c4@changeid/

Ohh, I see it in -rc1, let's recheck.

> 3. I didn't see anything relevant -rc1 with "git log arch/powerpc/mm/fault.c".
> 
> Do you have in mind anything specific to check?
> 
> Thanks
> 
