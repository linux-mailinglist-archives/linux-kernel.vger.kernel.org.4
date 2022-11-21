Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3B3632682
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbiKUOlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiKUOiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:38:52 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444C3C6607;
        Mon, 21 Nov 2022 06:38:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BA05322102;
        Mon, 21 Nov 2022 14:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669041498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mGOXq9FRamV9l5/TyyRIyRTXW3ke43JzevqLuofDH3Y=;
        b=Qp2QXy9NNTrYv3zdpSBl0EZsKd2ZL4OlKqi1kbMro7WI8hKQmgvUkR5L5vMjAFNaRoKLll
        28zbJVicyhWSeXLfFhwMz7vyyC3ls5CZwNNI49b0di3gjRKWTlcRmEloPow04B6nT11aGG
        twcB4xQMvDzPaA2kU7Qi82sGddWVsp4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B7351377F;
        Mon, 21 Nov 2022 14:38:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7T40H1qNe2PBIgAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 21 Nov 2022 14:38:18 +0000
Date:   Mon, 21 Nov 2022 15:38:17 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, corbet@lwn.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [External] Re: [PATCH v2] mm: add new syscall
 pidfd_set_mempolicy().
Message-ID: <Y3uNWbPmwHtytKzY@dhcp22.suse.cz>
References: <20221111084051.2121029-1-hezhongkun.hzk@bytedance.com>
 <20221111112732.30e1696bcd0d5b711c188a9a@linux-foundation.org>
 <a44f794e-fe60-e261-3631-9107822d5c36@bytedance.com>
 <Y3IqLzvduM6HqPJV@dhcp22.suse.cz>
 <3a3b4f5b-14d1-27d8-7727-cf23da90988f@bytedance.com>
 <Y3KFFfMFE55lVdNZ@dhcp22.suse.cz>
 <82c9c89c-aee2-08a3-e562-359631bb0137@bytedance.com>
 <0bd0b744-3d97-b4c3-a4fb-6040f8f8024a@bytedance.com>
 <Y3T6SqZvAmSG5I6W@dhcp22.suse.cz>
 <6433156f-34a8-400f-e282-91268b242279@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6433156f-34a8-400f-e282-91268b242279@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17-11-22 15:19:20, Zhongkun He wrote:
> Hi Michal, thanks for your replay.
> 
> > 
> > It would be better to add the patch that has been tested.
> 
> OK.
> 
> > 
> > One way to deal with that would be to use a similar model as css_tryget
> 
> Percpu_ref is a good way to  reduce memory footprint in fast path.But it
> has the potential to make mempolicy heavy. the sizeof mempolicy is 32
> bytes and it may not have a long life time, which duplicated from the
> parent in fork().If we modify atomic_t to percpu_ref, the efficiency of
> reading in fastpath will increase, the efficiency of creation and
> deletion will decrease, and the occupied space will increase
> significantly.I am not really sure it is worth it.
> 
> atomic_t; 4
> sizeof(percpu_ref + percpu_ref_data + cpus* unsigned long)
> 16+56+cpus*8

Yes the memory consumption is going to increase but the question is
whether this is something that is a real problem. Is it really common to
have many vmas with a dedicated policy?

What I am arguing here is that there are essentially 2 ways forward.
Either we continue to build up on top of the existing and arguably very
fragile code and make it even more subtle or follow a general pattern of
a proper reference counting (with usual tricks to reduce cache line
bouncing and similar issues). I do not really see why memory policies
should be any different and require very special treatment.

> > Btw. have you tried to profile those slowdowns to identify hotspots?
> > 
> > Thanks
> 
> Yes, it will degrade performance about 2%-%3 may because of the task_lock
> and  atomic operations on the reference count as shown
> in the previous email.
> 
> new hotspots in perf.
> 1.34%  [kernel]          [k] __mpol_put
> 0.53%  [kernel]          [k] _raw_spin_lock
> 0.44%  [kernel]          [k] get_task_policy

Thanks!
-- 
Michal Hocko
SUSE Labs
