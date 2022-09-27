Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A878C5EC01F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbiI0KuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbiI0Kt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:49:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C17285FA4;
        Tue, 27 Sep 2022 03:49:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 99A5C1FAF1;
        Tue, 27 Sep 2022 10:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664275792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G8dqFAhkv4BryP1THvyAkwJNHBTPJawb0NYObWUxY9w=;
        b=VPdMo9+yxkx3+UAodpV1393pNS+NneaMam/tNJK5JusGnkPfyzFoiR29ybyBFq4k2kWl9B
        sWp670PEDwr3dT3IhBkC9XHtJGwul7Z6fB7z27ixWLiNcJmZ8CAJd3mpjQPqE1tucjmLNk
        XXqvbxuOJk1+lOZKMFTErFxRxO55aTk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 789EA139B3;
        Tue, 27 Sep 2022 10:49:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Gvl1G1DVMmNxWAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 27 Sep 2022 10:49:52 +0000
Date:   Tue, 27 Sep 2022 12:49:51 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Zhongkun He <hezhongkun.hzk@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [RFC] proc: Add a new isolated /proc/pid/mempolicy type.
Message-ID: <YzLVTxGHgYp3Es4t@dhcp22.suse.cz>
References: <20220926091033.340-1-hezhongkun.hzk@bytedance.com>
 <YzF3aaLvEvFhTQa3@dhcp22.suse.cz>
 <24b20953-eca9-eef7-8e60-301080a17d2d@bytedance.com>
 <YzGya2Q3iuWS2WdM@dhcp22.suse.cz>
 <7ac9abce-4458-982b-6c04-f9569a78c0da@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ac9abce-4458-982b-6c04-f9569a78c0da@bytedance.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-09-22 11:20:54, Abel Wu wrote:
[...]
> > > Btw.in order to add per-thread-group mempolicy, is it possible to add
> > > mempolicy in mm_struct?
> > 
> > I dunno. This would make the mempolicy interface even more confusing.
> > Per mm behavior makes a lot of sense but we already do have per-thread
> > semantic so I would stick to it rather than introducing a new semantic.
> > 
> > Why is this really important?
> 
> We want soft control on memory footprint of background jobs by applying
> NUMA preferences when necessary, so the impact on different NUMA nodes
> can be managed to some extent. These NUMA preferences are given by the
> control panel, and it might not be suitable to overwrite the tasks with
> specific memory policies already (or vice versa).

Maybe the answer is somehow implicit but I do not really see any
argument for the per thread-group semantic here. In other words why a
new interface has to cover more than the local [sg]et_mempolicy?
I can see convenience as one potential argument. Also if there is a
requirement to change the policy in atomic way then this would require a
single syscall.
-- 
Michal Hocko
SUSE Labs
