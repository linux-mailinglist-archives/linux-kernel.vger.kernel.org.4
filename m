Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E6469CF58
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 15:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjBTO1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 09:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjBTO06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 09:26:58 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516181EFF4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 06:26:57 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id e5so2604841plg.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 06:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9SpbamaPNl85gOD1dvXbiOUXPjiZW4r+h87yhkDRLd4=;
        b=EEaQ+MQJM1p1qLc+LJqIUu2RqpYfnPRSy7mYYcrlnd7suvvPm0Hye9q+vU+k0w0zq4
         aECyGhLzIVtMz7UIa8kXdVI0vLoVxJUiLYwdof9lBOPAyBEZcRcvx+XXLhg3DWVgSJA3
         OQIMu9+QLeyhLCuMkYMEBeBBV7Xo2gbD/N43ZJC65ImJbdd6ytYAcQgP7CG1hlTZskXW
         SktysZk2vu5BRArQchAHQ1CmAN9m1pdAMtvsGRC+2h5AycxRbY75BYOXVlZ3Nk4TAbh+
         wSH/QaXCwaDbwed6faKCgUtX4NfmNWzkjzMhLeTPsRd7uhforJdXbn+VBfZZpIHC9AWF
         wiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SpbamaPNl85gOD1dvXbiOUXPjiZW4r+h87yhkDRLd4=;
        b=hV8YjxSqRKkWyLWCuBbskLdqLf4qI26vdf3ZVjy4gBt2Ihc80TFA3C7uSOMFVMXJCu
         f+u6i5KmN2oerJ5TyEQBMdAMkOtaHOEWy52v9AWPdPdiSSQFKLk1hSKQTLCdbN5Ax/mm
         h3so8MspWsVWSsTQOMl8T0n/PZTROaHJbeLSX/UexisagIRcnEqs9jIoZfZYRCywQ9X+
         LOeJ0rKTiXD00Kf+vkfthCj1PpqmEqKn4fXhceTSlwMP7kIT5DQcL9VoT9JZs3aFOyKH
         oMgpQjsG4ZQ5aahdf+HBHOn/D6PmNnY3BAsirUw/V4/AduG+1UlwbGic2s1isgu0rcV1
         9x7w==
X-Gm-Message-State: AO0yUKXBU/qGVFS38U1zDiuHdxRAfSbtOmqKJEpTMeSgmSiDeFbWbQ4E
        gXh0yAFtqF1x8OktBQBqnzk=
X-Google-Smtp-Source: AK7set9t9SvmOWZt0SaXZRuin++O9uhNirZLa9nWoKKDyAwxIskH/g1cDh7mwu7jyY9B2OkWPmjkWw==
X-Received: by 2002:a17:902:c950:b0:19a:b44b:cca6 with SMTP id i16-20020a170902c95000b0019ab44bcca6mr2409217pla.24.1676903216666;
        Mon, 20 Feb 2023 06:26:56 -0800 (PST)
Received: from localhost ([2400:8902::f03c:93ff:fe27:642a])
        by smtp.gmail.com with ESMTPSA id i3-20020a170902c28300b00194c2f78581sm7973365pld.199.2023.02.20.06.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 06:26:55 -0800 (PST)
Date:   Mon, 20 Feb 2023 14:26:49 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, liam.howlett@oracle.com, surenb@google.com,
        ldufour@linux.ibm.com, michel@lespinasse.org, vbabka@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] about the maple tree and current status of mmap_lock
 scalability
Message-ID: <Y/ODKQFj446+KBSy@localhost>
References: <EC51CFA7-2BC8-4F72-A7D4-3B1A778EDB37@gmail.com>
 <Y6ysHNPvKayTfeq8@casper.infradead.org>
 <Y62ipKlWGEbJZKXv@hyeyoo>
 <Y63FmaNoLAcdsLaU@casper.infradead.org>
 <Y7LIPOc/ESmhRzYk@hyeyoo>
 <Y7LsDgMxHh8NHzDY@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7LsDgMxHh8NHzDY@casper.infradead.org>
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 02:37:02PM +0000, Matthew Wilcox wrote:
> On Mon, Jan 02, 2023 at 09:04:12PM +0900, Hyeonggon Yoo wrote:
> > > https://www.infradead.org/~willy/linux/store-free-page-faults.html
> > > outlines how I intend to proceed from Suren's current scheme (where
> > > RCU is only used to protect the tree walk) to using RCU for the
> > > entire page fault.
> > 
> > Thank you for sharing this your outlines.
> > Okay, so the planned scheme is:
> > 
> > 	1. Try to process entire page fault under RCU protection
> > 		- if failed, goto 2. if succeeded, goto 4.
> > 
> > 	2. Fall back to Suren's scheme (try to take VMA rwsem)
> > 		- if failed, goto 3. if succeeded, goto 4.
> 
> Right.  The question is whether to restart the page fault under Suren's
> scheme, or just grab the VMA rwsem and continue.  Experimentation
> needed.
> 
> It's also worth noting that Michel has an alternative proposal, which
> is to drop out of RCU protection before trying to allocate memory, then
> re-enter RCU mode and check the sequence count hasn't changed on the
> entire MM.  His proposal has the advantage of not trying to allocate
> memory while holding the RCU read lock, but the disadvantage of having
> to retry the page fault if anyone has called mmap() or munmap().  Which
> alternative is better is going to depend on the workload; do we see more
> calls to mmap()/munmap(), or do we need to enter page reclaim more often?
> I think they're largely equivalent performance-wise in the fast path.
> Another metric to consider is code complexity; he thinks his method
> is easier to understand and I think mine is easier.  To be expected,
> I suppose ;-)

I'm planning to suggest a cooperative project to my colleagues
that would involve making __p?d_alloc() take gfp flags.

Wondering if there was any progress or conclusion made on which
approach is better for full RCU page faults, or was there another
solution proposed?

Asking this because I don't want to waste my time if the approach
has been abandoned.

Regards,
Hyeonggon

> > 	3. Fall back to mmap_lock
> > 		- goto 4.
> > 
> > 	4. Finish page fault.
