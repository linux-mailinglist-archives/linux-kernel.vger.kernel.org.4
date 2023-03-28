Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E5C6CBE09
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjC1LsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjC1LsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:48:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B2F4EEF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:48:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 526791FD88;
        Tue, 28 Mar 2023 11:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680004083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vFlxmCkFT3m//33K9ir1uA+dfJvleIWD/JRE4Jw7Dbk=;
        b=L1DwweSSmAw/ZOxbdHuywTMsf54s/dS2FVMTE01chluVjketcCM0Z3jZ2Lgt2RvxegMyI4
        lM6zP+lGcu/iD5LtQ39Xiy5dhmGIGqY3XjFNkAbj65VsreyDoqPvZmpPY1BsW+DN5bub+z
        YLVgqBp8Psc3/2KDSn0SzS6G2EbI5lM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 33C981390B;
        Tue, 28 Mar 2023 11:48:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZEtWCvPTImStHAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 28 Mar 2023 11:48:03 +0000
Date:   Tue, 28 Mar 2023 13:48:02 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonardo Bras <leobras@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] sched/isolation: Add cpu_is_isolated() API
Message-ID: <ZCLT8iH2ltmQ40my@dhcp22.suse.cz>
References: <20230317134448.11082-1-mhocko@kernel.org>
 <20230317134448.11082-2-mhocko@kernel.org>
 <ZBSyaVk919Fi07Wv@tpad>
 <ZBSy2QZYZRtCNBd8@tpad>
 <ZBVwlv+Mi+GfR1E3@dhcp22.suse.cz>
 <ZB4lt3IaPWVmn41n@localhost.localdomain>
 <ZCFu9jFm/rskeNlM@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZCFu9jFm/rskeNlM@tpad>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 27-03-23 07:24:54, Marcelo Tosatti wrote:
> On Fri, Mar 24, 2023 at 11:35:35PM +0100, Frederic Weisbecker wrote:
> > Le Sat, Mar 18, 2023 at 09:04:38AM +0100, Michal Hocko a écrit :
> > > On Fri 17-03-23 15:35:05, Marcelo Tosatti wrote:
[...]
> > > > Actually introducing cpu_is_isolated() seems fine, but it can call
> > > > housekeeping_test_cpu(cpu, HK_TYPE_TICK) AFAICS.
> > >  
> > > This is not really my area. Frederic, could you have a look please?
> > 
> > The point is to have a function that tells if either nohz_full= or
> > isolcpus=[domain] has been passed for the given CPU.
> > 
> > Because I assumed that both would be interested in avoiding that flush
> > noise, wouldn't it be the case?
> 
> Yes, that is the case. But as a note: for the two main types of
> configuration performed (one uses isolcpus=[domain] and the other
> cgroups, for isolating processes) nohz_full= is always set.
> 
> So just testing for nohz_full= would be sufficient (which perhaps would
> make the code simpler).

I do not see any mention about that assumption under Documentation/. Is
this a best practice documented anywhere or it just happens to be the
case with workloads you deal with?

-- 
Michal Hocko
SUSE Labs
