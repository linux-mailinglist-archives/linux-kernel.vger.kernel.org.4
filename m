Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F29063374A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbiKVIkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbiKVIkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:40:18 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D7F30F68;
        Tue, 22 Nov 2022 00:40:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0A49E21F4C;
        Tue, 22 Nov 2022 08:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669106416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8BZ09nC+Ltb5ETuM0UVHvj1htjE600StTsDaDLvmw28=;
        b=Ejw1DBowwlD1MjGWZTvlL9cwgiYFjIT1GODBe3YPf+UfBsmX6zfGtD9/YNB6PKhsQANtUP
        Sl6oIxkVZMl8Osn6QTVBiIpJx0pVxG3AWBwnehh4sI23sYah90hsobVfqYd5sdDHDp08rS
        mmGmTVnERp0vqFnoAEDw+SQZ84WYvCo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E0A8513B01;
        Tue, 22 Nov 2022 08:40:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZRqONO+KfGP9IAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 22 Nov 2022 08:40:15 +0000
Date:   Tue, 22 Nov 2022 09:40:15 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, corbet@lwn.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [External] Re: [PATCH v2] mm: add new syscall
 pidfd_set_mempolicy().
Message-ID: <Y3yK78HMSVA/Q6CS@dhcp22.suse.cz>
References: <a44f794e-fe60-e261-3631-9107822d5c36@bytedance.com>
 <Y3IqLzvduM6HqPJV@dhcp22.suse.cz>
 <3a3b4f5b-14d1-27d8-7727-cf23da90988f@bytedance.com>
 <Y3KFFfMFE55lVdNZ@dhcp22.suse.cz>
 <82c9c89c-aee2-08a3-e562-359631bb0137@bytedance.com>
 <0bd0b744-3d97-b4c3-a4fb-6040f8f8024a@bytedance.com>
 <Y3T6SqZvAmSG5I6W@dhcp22.suse.cz>
 <6433156f-34a8-400f-e282-91268b242279@bytedance.com>
 <Y3uNWbPmwHtytKzY@dhcp22.suse.cz>
 <ff3e9255-028a-7174-3608-2d9c362bdaf7@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff3e9255-028a-7174-3608-2d9c362bdaf7@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-11-22 16:33:09, Zhongkun He wrote:
> Hi Michal, thanks for your replay and suggestions.
> 
> > 
> > Yes the memory consumption is going to increase but the question is
> > whether this is something that is a real problem. Is it really common to
> > have many vmas with a dedicated policy?
> 
> Yes, it does not a realy problem.
> 
> > 
> > What I am arguing here is that there are essentially 2 ways forward.
> > Either we continue to build up on top of the existing and arguably very
> > fragile code and make it even more subtle or follow a general pattern of
> > a proper reference counting (with usual tricks to reduce cache line
> > bouncing and similar issues). I do not really see why memory policies
> > should be any different and require very special treatment.
> > 
> 
> I got it. It is rather subtle and easy to get wrong if we push forward
> with the existing way and it is a good opportunity to get from the
> existing subtle model. I will try that on next version.

Thanks for being receptive to the review feedback!
-- 
Michal Hocko
SUSE Labs
