Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E903A673912
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjASM7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjASM7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:59:35 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB813A8A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 04:59:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 82A265CDDB;
        Thu, 19 Jan 2023 12:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674133172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6sRp6Bi5byJg7E3z1L9LTqM9mlmV+SgeNGEbx21jvSk=;
        b=F8KH4t1JRlcgQI2I+hzoI1fK5XJvigE77GMCR1ycl6y7TQzAvYxEN2rxvsH0D+pdVXgWTh
        D1OV01TP7fWNZ5UAynd+38pwHM/HiRyZq0skqU7t/Ih0VPBhV6zHaGmvM2DhI0Fwetevnl
        pFh6bd4ZFY36oRCTSZWOl+GuZSHTaBE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 571C8139ED;
        Thu, 19 Jan 2023 12:59:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zLXVFLQ+yWO1cAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 19 Jan 2023 12:59:32 +0000
Date:   Thu, 19 Jan 2023 13:59:31 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 39/41] kernel/fork: throttle call_rcu() calls in
 vm_area_free
Message-ID: <Y8k+syJu7elWAjRj@dhcp22.suse.cz>
References: <20230109205336.3665937-1-surenb@google.com>
 <20230109205336.3665937-40-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109205336.3665937-40-surenb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09-01-23 12:53:34, Suren Baghdasaryan wrote:
> call_rcu() can take a long time when callback offloading is enabled.
> Its use in the vm_area_free can cause regressions in the exit path when
> multiple VMAs are being freed. To minimize that impact, place VMAs into
> a list and free them in groups using one call_rcu() call per group.

After some more clarification I can understand how call_rcu might not be
super happy about thousands of callbacks to be invoked and I do agree
that this is not really optimal.

On the other hand I do not like this solution much either.
VM_AREA_FREE_LIST_MAX is arbitrary and it won't really help all that
much with processes with a huge number of vmas either. It would still be
in housands of callbacks to be scheduled without a good reason.

Instead, are there any other cases than remove_vma that need this
batching? We could easily just link all the vmas into linked list and
use a single call_rcu instead, no? This would both simplify the
implementation, remove the scaling issue as well and we do not have to
argue whether VM_AREA_FREE_LIST_MAX should be epsilon or epsilon + 1.

-- 
Michal Hocko
SUSE Labs
