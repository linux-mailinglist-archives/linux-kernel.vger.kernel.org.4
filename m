Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5B35EAA8B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbiIZPWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236304AbiIZPWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:22:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9A085AA3;
        Mon, 26 Sep 2022 07:08:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A1B451F8A4;
        Mon, 26 Sep 2022 14:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664201324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j600WWM/VHOKFyO6Qxlx/kgR3oXfjp923FSo/xkqVEo=;
        b=qYELV+5U/XVCqd6kESY7/gFf387nX8FJynNLNsM3BnQWoIagPjdK7IGMl1iFWBzlOeod/9
        M1vErEEHSaNoJznOOokLM0fFnbd14vY3PPtZBsc8IA1yQoFtKLWmI/Hf/eAmHB51DKO0VC
        DxEY0i3ZHBXuoKoEq2kjQHBHUTb3XZs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F18A139BD;
        Mon, 26 Sep 2022 14:08:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cuHOGWyyMWPMAQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 26 Sep 2022 14:08:44 +0000
Date:   Mon, 26 Sep 2022 16:08:43 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        wuyun.abel@bytedance.com
Subject: Re: [External] Re: [RFC] proc: Add a new isolated
 /proc/pid/mempolicy type.
Message-ID: <YzGya2Q3iuWS2WdM@dhcp22.suse.cz>
References: <20220926091033.340-1-hezhongkun.hzk@bytedance.com>
 <YzF3aaLvEvFhTQa3@dhcp22.suse.cz>
 <24b20953-eca9-eef7-8e60-301080a17d2d@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24b20953-eca9-eef7-8e60-301080a17d2d@bytedance.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 26-09-22 20:53:19, Zhongkun He wrote:
> > [Cc linux-api - please do so for any patches making/updating
> > kernel<->user interfaces]
> > 
> > 
> > On Mon 26-09-22 17:10:33, hezhongkun wrote:
> > > From: Zhongkun He <hezhongkun.hzk@bytedance.com>
> > > 
> > > /proc/pid/mempolicy can be used to check and adjust the userspace task's
> > > mempolicy dynamically.In many case, the application and the control plane
> > > are two separate systems. When the application is created, it doesn't know
> > > how to use memory, and it doesn't care. The control plane will decide the
> > > memory usage policy based on different reasons.In that case, we can
> > > dynamically adjust the mempolicy using /proc/pid/mempolicy interface.
> > 
> > Is there any reason to make it procfs interface rather than pidfd one?
> 
> Hi michal,  thanks for your reply.
> 
> I just think that it is easy to display and adjust the mempolicy using
> procfs. But it may not be suitable, I will send a pidfd_set_mempolicy patch
> later.

proc interface has many usability issues. That is why pidfd has been
introduced. So I would rather go with the pidfd interface than repeating
old proc API mistakes.

> Btw.in order to add per-thread-group mempolicy, is it possible to add
> mempolicy in mm_struct?

I dunno. This would make the mempolicy interface even more confusing.
Per mm behavior makes a lot of sense but we already do have per-thread
semantic so I would stick to it rather than introducing a new semantic.

Why is this really important?
-- 
Michal Hocko
SUSE Labs
