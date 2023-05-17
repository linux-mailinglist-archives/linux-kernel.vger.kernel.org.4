Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E2A7066C0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjEQLdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjEQLdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:33:05 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B4B183
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:33:04 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-56186035b61so6450067b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684323183; x=1686915183;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HvwENPq8tz9NntrqfQSfZoeD7LfbRJhmcL0T3gzk8cQ=;
        b=N2DxmYlr27xb0YitGC/hgEDkTgMt7b1iKxAHC68gdSzL+L0v1G35idBVkCx6Ybj8W6
         YsyR4O5U8mzovWTQWLq9K8q5W7NFgg7GUl5wzSCxsiUyip8nBe4tUmBhMRnFbe6ldOZB
         f0Mg5faItUv/poG4hvzPUzKZPe/Ox/0uGUty/0pYiZSYTN0pdzIWgnzKLo2ADFGAPzB2
         V5L7ovVNnhItXHGFqjn1wCvBlsxTfBs8AlbxNAXY7yOAKRnVACWuIicPwt0p7wRkwL/Y
         zWW41o4E9Ulolm/FBenBlsL6vyJtF9wEAUPPnZfM9UYt4Yc+L6cf5mSC8yofzX/xByUG
         PT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684323183; x=1686915183;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HvwENPq8tz9NntrqfQSfZoeD7LfbRJhmcL0T3gzk8cQ=;
        b=DP8Lo/49nukr/zOztSu+TpC2ICaUO/r9CG0my07HnA06+fTQdNmwtRIXUlaiIO41j6
         ESDJXlWNofHemn3V2FVgvuna0bTp2HUOwMkcIHYGLPa6HyaL/h6xkVPDINnhPML+1IaO
         UuydmHOJ06xkujrq2HFFWyd2flP/5+1rvkDwn/g8Ww4gqfEVfD/5G1IpQYH24HwEehOM
         j44yX/bYMfipOWzVEa+YAq9SNjWS1RTGzrZ5Sz6axSGbIBc4fUbHsKCAHfhDi9DpTyzm
         lUWDcZd+61NK2CDUiqnAzK+NG3ZWpxeiQSlgadgJFooKlmGU88H/PDL6BQX5F8WqjKJt
         s9dA==
X-Gm-Message-State: AC+VfDyrWtO0jYPlJVLXcJNUPBsMf5/Wz/bZssTqt2YSXXGeCLnsWs2E
        gJwqKdnNzjQVE9/9qzoTn5LXpQ==
X-Google-Smtp-Source: ACHHUZ7QI6oEtWWpej1fkbLVHNVY3j0sKPynjITx+DFobNdeMqR68LNW0+OB/2tJfik76Ijyk66Giw==
X-Received: by 2002:a0d:e255:0:b0:561:904d:27d9 with SMTP id l82-20020a0de255000000b00561904d27d9mr4059441ywe.4.1684323183452;
        Wed, 17 May 2023 04:33:03 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k1-20020a819301000000b005617251bb95sm593292ywg.84.2023.05.17.04.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 04:33:03 -0700 (PDT)
Date:   Wed, 17 May 2023 04:32:50 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Charan Teja Kalla <quic_charante@quicinc.com>
cc:     Hugh Dickins <hughd@google.com>, akpm@linux-foundation.org,
        willy@infradead.org, markhemm@googlemail.com, rientjes@google.com,
        surenb@google.com, shakeelb@google.com, fvdl@google.com,
        quic_pkondeti@quicinc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 2/2] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED
 for shmem
In-Reply-To: <eeeba374-9247-96fd-c9f5-8cba8761f1b9@quicinc.com>
Message-ID: <aa4352d8-a549-32e5-874f-1cfee2a5b3e@google.com>
References: <cover.1676378702.git.quic_charante@quicinc.com> <631e42b6dffdcc4b4b24f5be715c37f78bf903db.1676378702.git.quic_charante@quicinc.com> <2d56e1dd-68b5-c99e-522f-f8dadf6ad69e@google.com> <eeeba374-9247-96fd-c9f5-8cba8761f1b9@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2023, Charan Teja Kalla wrote:
> On 4/21/2023 5:37 AM, Hugh Dickins wrote:
> > This is where I ran out of time.  I'm afraid all the focus on
> > fadvise_calc_endbyte() has distracted you from looking at the DONTNEED
> > in mm/fadvise.c: where there are detailed comments on why and how it
> > then narrows the DONTNEED range.  And aside from needing to duplicate
> > that here for shmem (or put it into another or combined helper), it
> > implies to me that shmem_isolate_pages_range() needs to do a similar
> > narrowing, when it finds that the range overlaps part of a large folio.
> > 
> Sure, will include those range calculations for shmem pages too.

Oh, I forgot this issue, you would have liked me to look at V8 by now,
to see whether I agree with your resolution there.  Sorry, no, I've
not been able to divert my concentration to it yet.

And it's quite likely that I shall disagree, because I've a history of
disagreeing even with myself on such range widening/narrowing issues -
reconciling conflicting precedents is difficult :(

> 
> > Something that has crossed my mind as a worry, but I've not had time
> > to look further into (maybe it's no concern at all) is the question
> > of this syscall temporarily isolating a very large number of folios,
> > whether they need to be (or perhaps already are) counted in
> > NR_ISOLATED_ANON, whether too many isolated needs to be limited.
> 
> They are _not_ counted as ISOLATED_ANON now as this operation is for a
> small duration. I do see there exists too_many_isolated() checks in
> direct reclaim/compaction logic where it is necessary to stop the
> multiple processes in the direct reclaim from isolating too many pages.
> 
> I am not able to envisage such problem here, where usually single
> process doing the fadvise operation on a file. Even If the file is
> opened by multiple processes and do fadvise, the operation is limited
> only to the pages of this file and doesn't impact the system.
> 
> Please let me know if I'm missing something where I should be counting
> these as NR_ISOLATED.

Please grep for NR_ISOLATED, to see where and how they get manipulated
already, and follow the existing examples.  The case that sticks in my
mind is in mm/mempolicy.c, where the migrate_pages() syscall can build
up a gigantic quantity of transiently isolated pages: your syscall can
do the same, so should account for itself in the same way.

I'm not claiming that mm/vmscan.c's too_many_isolated(), and the way it
gets used by shrink_inactive_list(), is perfect: not at all.  But please
follow existing convention.

Sorry, that's all for now.
Hugh
