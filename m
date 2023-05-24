Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1447E70FB0D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238077AbjEXP7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238023AbjEXP65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:58:57 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989A510E5
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:58:13 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-6238da9c235so9740146d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1684943892; x=1687535892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lo1Bd8kQQKok6XtJWBuvliy13W3lA66R3FmWEDQGTs8=;
        b=2VEdtsMcvvWFefWeiXYVDgLPH8JWObDrEJKYw1yXU4atsvZ1jZ4qTM94DTLUYSLPHp
         XRgahDkBOLaIGTfz9hRXc1671KG4VLdjlEt3w8BoM2hu3Hdzx7DH9NS9oVfrYKzWgiYJ
         hhueoStgujR8NChqyj+y8GrXQPAx3dJEnJTiJ9F+pskcByaurrE18+DKRQBT+Lq3AcX/
         OXQXsFOognFhXNzTyOaBQoE30ZVrwbE2aoKd8pVnpH2nnsosKJn/A6eH7WeLN2+zzMsT
         c63wQ/DnNCE2+Wg00CMsWEZvDURToZBhe1feccq7068rbO0Wlhyum/5ZK02njya7f5h+
         lGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684943892; x=1687535892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lo1Bd8kQQKok6XtJWBuvliy13W3lA66R3FmWEDQGTs8=;
        b=NtnuSfzWwEJu5w3j7cYrYe3vIR4V02IVbYt3Z5RNbaxV8wHUSQ1G2KnP4KPW6iQPsK
         7aCVTSX7sey/haX1l/Z/+tOonGr6E7iyXcURty7RBxI/UHwtUzdZrPvq+4oQdSyBYx5G
         5EFwlchHSfLU0l0twIar5jtulc7M8UjteoZsAi485YgZDx4jUdg3KIvJIsge8ytlFGSs
         Ab26YpRUV3wty7u0B9MBMDpg7nWxkPROuR+1wG+f+wNMOcdhio3P9c6bBzZzk+CEi4yU
         oHWPyuyaXe1zOX+M+ABeJE87MQ/d+9U5Csp/QZ3HLmWlmvyRv6fogMveXhNNknRksbgz
         FTcA==
X-Gm-Message-State: AC+VfDyvcRzYNMX6qrFQMLAj4c3zbGcMbBGK/5cVjS0TwrWZDFpGs+tw
        HIyPXevyX3JyVKOPz9RWAvgbAK7/GUkxc1NVf8s=
X-Google-Smtp-Source: ACHHUZ5PxIGt+Zc5ZcfzkXBmoWXbMEoEPZ8JoJKNs82T+X93QbJGrVVBdWsQ9j+GYYcm6SQrGhmtcg==
X-Received: by 2002:a05:6214:c4e:b0:5ef:6eb6:e26e with SMTP id r14-20020a0562140c4e00b005ef6eb6e26emr26359735qvj.6.1684943892343;
        Wed, 24 May 2023 08:58:12 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:8bb6])
        by smtp.gmail.com with ESMTPSA id l16-20020a056214029000b0062168714c8fsm3642179qvv.120.2023.05.24.08.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 08:58:11 -0700 (PDT)
Date:   Wed, 24 May 2023 11:58:11 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: compaction: avoid GFP_NOFS ABBA deadlock
Message-ID: <20230524155811.GA14306@cmpxchg.org>
References: <20230519111359.40475-1-hannes@cmpxchg.org>
 <8fd1a56d-5a22-4bde-59a5-169a4696219e@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fd1a56d-5a22-4bde-59a5-169a4696219e@suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 11:21:43AM +0200, Vlastimil Babka wrote:
> On 5/19/23 13:13, Johannes Weiner wrote:
> > During stress testing with higher-order allocations, a deadlock
> > scenario was observed in compaction: One GFP_NOFS allocation was
> > sleeping on mm/compaction.c::too_many_isolated(), while all CPUs in
> > the system were busy with compactors spinning on buffer locks held by
> > the sleeping GFP_NOFS allocation.
> > 
> > Reclaim is susceptible to this same deadlock; we fixed it by granting
> > GFP_NOFS allocations additional LRU isolation headroom, to ensure it
> > makes forward progress while holding fs locks that other reclaimers
> > might acquire. Do the same here.
> > 
> > This code has been like this since compaction was initially merged,
> > and I only managed to trigger this with out-of-tree patches that
> > dramatically increase the contexts that do GFP_NOFS compaction. While
> > the issue is real, it seems theoretical in nature given existing
> > allocation sites. Worth fixing now, but no Fixes tag or stable CC.
> 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> So IIUC the change is done by not giving GFP_NOFS extra headroom, but
> instead restricting the headroom of __GFP_FS allocations. But the original
> one was probably too generous anyway so it should be fine?

Yes, the original limit is generally half the LRU, which is quite high.

The new limit is 1/16th of the LRU for regular compactors and half for
GFP_NOFS ones. Note that I didn't make these up; they're stolen from
too_many_isolated() in vmscan.c. I figured those are proven values and
no sense in deviating from them until we have a reason to do so.

> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!
