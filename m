Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139835FA458
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 21:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiJJTv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 15:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJJTvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 15:51:54 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D733774CD9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:51:53 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id z20so11257984plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RucGBt4u1fw4jXoxTMl5Lz77PCfmP6zYPe4rzfBZtZQ=;
        b=i8ChExYqDUyn618tY1Za/PYodA8b+2qgNjfalEV5g39YNO5GbriN09WAg2EhkX2VZC
         l7HHIOAIswibwI+gmBa/V31gT8OxmCJQelwUcI9cyDxUsc5jf29fKolM5+pdHt5fdKIH
         UdVP4MwDoFUd6LvrNwFGNYNXLN3UcQBu6CPHwIzuRK3qehaffRcKU40RLNfbjnxezPlr
         +L6O9awERQOLhtaC2wB2KAokIwzGCqsroc1wfdpLR10kJ8+V+8MMco6+2r6RNUdA29tz
         dgYvSmEiNRV5iBpqyYSE4lWKGAQjsJbMxV4bdNzaoTG/njr0AzmleOvzgspq1DKUkpug
         WWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RucGBt4u1fw4jXoxTMl5Lz77PCfmP6zYPe4rzfBZtZQ=;
        b=720cGumnsF0sSu4vQmw2nDU3yZVcXTkyWzcfp2HNiVWXTLCLSzYX+vtIIftHt2J7C0
         HARF+sDrToaC3easMBtgD0xjeZDXRhs6MO/FoRHM5w8gCdK/MpwJ7GQb5PzEyDSQSlup
         8DvaXj4aFMgWStpO3Q+3VcyEaj+6aP8OE1uuBsQ9dpHYFV2SZGeXfXSU5rKOCYV0wOys
         gDsm5ncQKS8x19VHDfUw2Z9seENVqNbQ4xi/3gk2J+PV6/EmMEexYEDueU/+xcIwveqJ
         QhWiZZABa5NMmxo7c0osSvC4uKhlksTWi2x21V1NfD7h9czjszrRlEqJ/19aW5nihOpp
         K1Ng==
X-Gm-Message-State: ACrzQf0K6D+ycPa8u2ofGDBk85pA9GmIGAwgNhAAiQg4d3xt9zosDkWt
        L0KrVeoXfCziCAjybOggzK5rihXWYNGxsg==
X-Google-Smtp-Source: AMsMyM6PPSkGm2KHYCoRMa2Q67mRgUWJgSCKwOW3sg8X7r3cefdAYVcLAmtij9le6ICM1jM3tzJmbw==
X-Received: by 2002:a17:902:a718:b0:182:c500:d8da with SMTP id w24-20020a170902a71800b00182c500d8damr5056393plq.98.1665431513189;
        Mon, 10 Oct 2022 12:51:53 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709026f0100b001837fa52710sm211045plk.220.2022.10.10.12.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 12:51:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Oct 2022 09:51:51 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     "Christian A. Ehrhardt" <lk@c--e.de>,
        Christian Brauner <brauner@kernel.org>,
        syzbot <syzbot+534ee3d24c37c411f37f@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH] cgroup: Fix crash with CLONE_INTO_CGROUP and v1 cgroups
Message-ID: <Y0R31xyfivqtKb9h@slm.duckdns.org>
References: <000000000000385cbf05ea3f1862@google.com>
 <00000000000028a44005ea40352b@google.com>
 <Y0CbtVwW6+QIYJdQ@slm.duckdns.org>
 <Y0HBlJ4AoZba93Uf@cae.in-ulm.de>
 <20221009084039.cw6meqbvy4362lsa@wittgenstein>
 <Y0LITEA/22Z7YVSa@cae.in-ulm.de>
 <Y0Rn5qzP6MjayoCz@slm.duckdns.org>
 <CAJD7tka2jwPnYyCmLu0T5Oq_X-LJCx7TVqLayLPS_6fOjqf93A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tka2jwPnYyCmLu0T5Oq_X-LJCx7TVqLayLPS_6fOjqf93A@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Oct 10, 2022 at 11:50:50AM -0700, Yosry Ahmed wrote:
> The purpose of f3a2aebdd6 was to make cgroup_get_from_fd() support
> cgroup1, which IIUC makes sense. It was unrelated to IDs.

Ah, right you are. For some reason, I thought this was ID based.

> There are currently two users of
> cgroup_get_from_file()/cgroup_get_from_fd() AFAICT, one of which is
> the fork code fixed by this commit, the second is BPF cgroup prog
> attachment. I can send another patch to add explicit filtering in the
> BPF attachment code as well.
> 
> Alternatively, we can have separate functions that do the filtering if
> needed. For example:
> cgroup_get_from_fd() / cgroup_get_from_file() -> support both v1 and v2
> cgroup_get_dfl_from_fd() / cgroup_get_dfl_from_file() -> support only v2
> 
> We can then use the versions with filtering for all the current users
> except cgroup_iter (that needs to support both v1 and v2). WDYT?

Yes, but please leave the existing ones v2 only and add new ones which
allows cgroup1 too.

Thanks.

-- 
tejun
