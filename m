Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F1B627D03
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbiKNLvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236634AbiKNLvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:51:13 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8F023BDB;
        Mon, 14 Nov 2022 03:46:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 00E3122921;
        Mon, 14 Nov 2022 11:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668426413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yz5j0yLS60RhoozEN+4P1jT0Vz/W/dGC3w+wIvkQm60=;
        b=JqQA61DtYKzNUreBa21Ln2ee1u+Nnx3ICkr8BaOKN1saiEjcwA2jBOTq0n8NqAUZVCidL7
        JpH0+hZ62Cja3fMW9DWOSUAStE2nyIg3wJaAsYseV4a7l34Scin4D5AEL2cBZhYft95Iq5
        bsD5IlYSAPDifI2Kyze3U+Lo5IGCyak=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7BB013A92;
        Mon, 14 Nov 2022 11:46:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wypfM6wqcmNzBAAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 14 Nov 2022 11:46:52 +0000
Date:   Mon, 14 Nov 2022 12:46:52 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, corbet@lwn.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [External] Re: [PATCH v2] mm: add new syscall
 pidfd_set_mempolicy().
Message-ID: <Y3IqrCrDNdM5LDFt@dhcp22.suse.cz>
References: <20221111084051.2121029-1-hezhongkun.hzk@bytedance.com>
 <20221111112732.30e1696bcd0d5b711c188a9a@linux-foundation.org>
 <a44f794e-fe60-e261-3631-9107822d5c36@bytedance.com>
 <Y3IqLzvduM6HqPJV@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3IqLzvduM6HqPJV@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14-11-22 12:44:48, Michal Hocko wrote:
> On Mon 14-11-22 00:41:21, Zhongkun He wrote:
> > Hi Andrew, thanks for your replay.
> > 
> > > This sounds a bit suspicious.  Please share much more detail about
> > > these races.  If we proced with this design then mpol_put_async()
> > > shouild have comments which fully describe the need for the async free.
> > > 
> > > How do we *know* that these races are fully prevented with this
> > > approach?  How do we know that mpol_put_async() won't free the data
> > > until the race window has fully passed?
> > 
> > A mempolicy can be either associated with a process or with a VMA.
> > All vma manipulation is somewhat protected by a down_read on
> > mmap_lock.In process context there is no locking because only
> > the process accesses its own state before.
> 
> We shouldn't really rely on mmap_sem for this IMO. There is alloc_lock
> (aka task lock) that makes sure the policy is stable so that caller can
> atomically take a reference and hold on the policy. And we do not do
> that consistently and this should be fixed. E.g. just looking at some
> random places like allowed_mems_nr (relying on get_task_policy) is
> completely lockless and some paths (like fadvise) do not use any of the
> explicit (alloc_lock) or implicit (mmap_lock) locking. That means that
> the task_work based approach cannot really work in this case, right?

Just to be more explicit. Task work based approach still requires an
additional synchronization among different threads unless I miss
something so this is really fragile synchronization model.
-- 
Michal Hocko
SUSE Labs
