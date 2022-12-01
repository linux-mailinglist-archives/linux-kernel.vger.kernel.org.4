Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8BF63F826
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiLAT23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiLAT21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:28:27 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BD23D92D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:28:25 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id h24so2170675qta.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 11:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LB2YhMqTu2ntQjGIXenPSlW+YY6N15Qvn6akcp9m04Q=;
        b=iHxxOgC1AQ5I6cQYKhhBLqMu9WvJCbCwz3uq3QI2q1BeAakagA1VocuP62HL+GrOlk
         J9hfSSOgNfmYHdIpW97ulaXYPTUV9B9JLIrMNrj4U2RIEWJQtG3CYnormFYFDQqNKvHE
         iGwPojD/manJG2L4zTxfl7adGaS4s7kVRLEoazjhflAJP7L4goZ23CLlctlvSAye8+5V
         0DEFHxRaU6m++RfwEMZdQ/FYaKei/CjAcYsu8vjgp8XDnHTXJpIIiL+EChAvIcJfMF4t
         b8J0yxZiGe6lZB0IlKNbBxrMVvULpK/S2vnB1snQlLZfQ4b10XCXbFM7DBnoFHgewfT7
         Zd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LB2YhMqTu2ntQjGIXenPSlW+YY6N15Qvn6akcp9m04Q=;
        b=79thST7etSizwJ0SGB0CGItWmGUCQ6vkxn0Qpy6dUyXeGanLhdMWQSvmc2SMpB3J0v
         /vkThCps2CRXNFTYbBLdUEHeZNL6PAjNsdft126ysCFkfxEjruA71rFGrPPhB+ZjzYQE
         1RZ9nt8PQ3EGRjltfqyvm8HEvQrtilZPj8C7Ya3yCeJ9o2pFuss3K/Pcjrs80ERyUw+J
         u47BcEgkmLpM3f86g9u7tSLbO4Ql9U//0LDXd9Ul6PMLNPQtdsNexmuf+wor28kXfiAu
         C0rAS8p0f1jkz8HDq3kCcSrcXDnqmkTIAbvZ5PIL3VAwak98x6ErYN6eXvYYC++7INpq
         6m9w==
X-Gm-Message-State: ANoB5plOMpraH4eAgPnIrtiihamplILHYzQoSKUEuSRxbhyWmBEjzfKm
        KCTpjuK70Vhq2s550lsiZLg/Nr6WnNl1mA==
X-Google-Smtp-Source: AA0mqf7+cAsq3D4FG+LcFKXqr7lhFWlzCVCTl9zVPXdWLfHz4OfM3kJIErp8zos4lbAuKI43PjK8iw==
X-Received: by 2002:a37:6004:0:b0:6fc:9706:501 with SMTP id u4-20020a376004000000b006fc97060501mr11212988qkb.733.1669922904901;
        Thu, 01 Dec 2022 11:28:24 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o14-20020ac8698e000000b003a580cd979asm3029846qtq.58.2022.12.01.11.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 11:28:24 -0800 (PST)
Date:   Thu, 1 Dec 2022 11:28:14 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Johannes Weiner <hannes@cmpxchg.org>
cc:     Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove lock_page_memcg() from rmap
In-Reply-To: <Y4jNvzpX4g42afvP@cmpxchg.org>
Message-ID: <67a63be3-e5c3-946e-1565-c6ae8fee9a@google.com>
References: <20221123181838.1373440-1-hannes@cmpxchg.org> <16dd09c-bb6c-6058-2b3-7559b5aefe9@google.com> <Y4TpCJ+5uCvWE6co@cmpxchg.org> <Y4ZYsrXLBFDIxuoO@cmpxchg.org> <3659bbe0-ccf2-7feb-5465-b287593aa421@google.com> <CALvZod7_FjO-CjzHUpQTsCTm4-68a1eKi_qY=4XdF+g7yMLd4Q@mail.gmail.com>
 <e0918c92-90cd-e3ed-f4e6-92d02062c252@google.com> <Y4fZbFNVckh1g4WO@cmpxchg.org> <33f2f836-98a0-b593-1d43-b289d645db5@google.com> <Y4jNvzpX4g42afvP@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2022, Johannes Weiner wrote:
> On Wed, Nov 30, 2022 at 04:13:23PM -0800, Hugh Dickins wrote:
> 
> > And I don't know what will be best for the preliminary precharge pass:
> > doesn't really want the page lock at all, but it may be unnecessary
> > complication to avoid taking it then unlocking it in that pass.
> 
> We could make it conditional on target, which precharge doesn't pass,
> but I agree it's likely not worth optimizing that code at this point.

I hadn't noticed that NULL target so easily distinguishes that case:
unless it goes on to uglify things more (which I think it won't, seeing
now how there are already plenty of conditionals on target), I would
prefer to avoid the trylock and unlock in the precharge case; but
decide for yourself.

Hugh
