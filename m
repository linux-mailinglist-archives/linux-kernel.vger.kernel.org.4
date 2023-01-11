Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE946660E5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbjAKQpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbjAKQo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:44:56 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370671A8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:44:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AE9C04E91;
        Wed, 11 Jan 2023 16:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673455479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+lGYOpDp4bNuKnxJ8tlVYLr+bl6xRPelNh0S14fBeXs=;
        b=I7OoxYg3OlBX6EVM379TBGXUacU8S9i5T/xnB98LgJhbKPsWPa2P1VE6kAqNpctknauSk/
        kKvWiz7MUkRa3+JWHr6fOLyEJ4gjNiAl0XViAt3U78Ut0ayY18F99tkVfpCbgeuyDaLq0U
        2uunWKRUZusTCXL7/ZsZbinX7aMYMgw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 879B413591;
        Wed, 11 Jan 2023 16:44:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KM+lIHfnvmNOXAAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 11 Jan 2023 16:44:39 +0000
Date:   Wed, 11 Jan 2023 17:44:38 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@kernel.org>,
        "michel@lespinasse.org" <michel@lespinasse.org>,
        "joelaf@google.com" <joelaf@google.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "leewalsh@google.com" <leewalsh@google.com>,
        "david@redhat.com" <david@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "jglisse@google.com" <jglisse@google.com>,
        "punit.agrawal@bytedance.com" <punit.agrawal@bytedance.com>,
        "arjunroy@google.com" <arjunroy@google.com>,
        "minchan@google.com" <minchan@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "hughd@google.com" <hughd@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "gurua@google.com" <gurua@google.com>,
        "laurent.dufour@fr.ibm.com" <laurent.dufour@fr.ibm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "axelrasmussen@google.com" <axelrasmussen@google.com>,
        "kernel-team@android.com" <kernel-team@android.com>,
        "soheil@google.com" <soheil@google.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "liam.howlett@oracle.com" <liam.howlett@oracle.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "gthelen@google.com" <gthelen@google.com>,
        "ldufour@linux.ibm.com" <ldufour@linux.ibm.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "posk@google.com" <posk@google.com>,
        "lstoakes@gmail.com" <lstoakes@gmail.com>,
        "peterjung1337@gmail.com" <peterjung1337@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kent.overstreet@linux.dev" <kent.overstreet@linux.dev>,
        "hughlynch@google.com" <hughlynch@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tatashin@google.com" <tatashin@google.com>
Subject: Re: [PATCH 08/41] mm: introduce CONFIG_PER_VMA_LOCK
Message-ID: <Y77ndimzUsVZwjTk@dhcp22.suse.cz>
References: <20230109205336.3665937-1-surenb@google.com>
 <20230109205336.3665937-9-surenb@google.com>
 <20230111001331.cxdeh52vvta6ok2p@offworld>
 <CAJuCfpEv--awCY0=R3h5Fez8x74U1EZCzNkq4_7deCYqej5sSA@mail.gmail.com>
 <Y75x5fGPcJ63pBIp@dhcp22.suse.cz>
 <Y76HTfIeEt8ZOIH3@gmail.com>
 <6be809f5554a4faaa22c287ba4224bd0@AcuMS.aculab.com>
 <CAJuCfpH_VZq99=vGQGJ+evVg5wMPKGsjyawgHnOeoKhtEiAi6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpH_VZq99=vGQGJ+evVg5wMPKGsjyawgHnOeoKhtEiAi6w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-01-23 08:28:49, Suren Baghdasaryan wrote:
[...]
> Anyhow. Sounds like the overhead of the current design is small enough
> to remove CONFIG_PER_VMA_LOCK and let it depend only on architecture
> support?

Yes. Further optimizations can be done on top. Let's not over optimize
at this stage.
-- 
Michal Hocko
SUSE Labs
