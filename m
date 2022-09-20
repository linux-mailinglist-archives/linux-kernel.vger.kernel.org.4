Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABA15BE16D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiITJJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbiITJIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:08:40 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3296E5D115
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:08:03 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id u18so2669666lfo.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=lTwQgGKsN4u+IHIwS7NB3rxBXGJGFOsQ4NRRi3geOiA=;
        b=i3RphDML/blXszxKEWFj2igVbpOcSOH7TgpMIy0B6DcHZFoa42jUI0WiZjFXXimooT
         L+nCMfCIbmj29DgFHspN7eGv7Y7ZdsgsMenlxtYjKx0Avsv5YZ3TbE2OYD919oUJ0LBZ
         DegB7SZhhY36JPgwvmjvYcwhej0Edm80mB1z7VJLbkx61vWljlxEkcIeZKyYrHqLsOvU
         AoTDLjS4pOfFOWkwpm69U3haWb5HGkYsjwH3rS+zRcOl04ruLL0LSALoOv6P98fILWSb
         uEnpD12nyUcBDhyueGgiDs4rRRxEjZ8d1CyiWWj0DALcLP9jDhtq/EtyFIfXhlii1uz2
         Dq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=lTwQgGKsN4u+IHIwS7NB3rxBXGJGFOsQ4NRRi3geOiA=;
        b=pWl7ISZ1Vgc1pNj1HwYt5BNncDTAw9gqdmO5NwnKAYpXmCLKK2wLMu7NyWjtunRVKo
         VNyYfnP9EzHaJ72fr9Iz6gl92InkNS1YuleqIL6Ka6Mnbp6sqNYrM/UvhtAE55smvHLA
         IZM+unxqO6lApRo2S/9OpMdqd874cwEVYx/oxpMbdH3pC+tvpCmTkL2DNueioDRLvYtD
         ySeT6Q7jnqmPae8x8j5xU+/ZovuSOB/vgDG15XqyZFpF+fdoohu2VBX/iIduURsJ0mPr
         iRo17si6z3mlwGMxcsKB53W5QIl0TqOT94twc4BjZj5VEONeBbZIZ6GI4WIi41mhPMYy
         m9aA==
X-Gm-Message-State: ACrzQf3XnQbjzRd1CZKD934ptg8w623Is6J2jtIiMxlAMWZE5moJCXqN
        QuprR7gom/mX1qpn2wEC9ApmYa2qZ5hhYTxJKKM=
X-Google-Smtp-Source: AMsMyM7NOubRpDrd2wtB5vj/FYh5Cxm1ew8oaIofNOeyAv2a+rf+IxsKz/AWngvtLvYwF7zn6FG1yDanFNDKC1QfbTM=
X-Received: by 2002:a05:6512:151a:b0:49c:2f02:4e22 with SMTP id
 bq26-20020a056512151a00b0049c2f024e22mr8308280lfb.130.1663664881408; Tue, 20
 Sep 2022 02:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <1663634940-6515-1-git-send-email-zhaoyang.huang@unisoc.com> <20220920085437.ngyrzgxe2uoi7g4a@techsingularity.net>
In-Reply-To: <20220920085437.ngyrzgxe2uoi7g4a@techsingularity.net>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Tue, 20 Sep 2022 17:07:33 +0800
Message-ID: <CAGWkznELJWUGBbRb8GE0nRVCtEVSpnLvT+PFnOt-vtyE98CqEw@mail.gmail.com>
Subject: Re: [PATCHv2] mm: check high-order page when free it to pcp
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Ke Wang <ke.wang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 4:55 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Tue, Sep 20, 2022 at 08:49:00AM +0800, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > High-order pcp page escaped from checking when both of DEBUG_VM and debug_pagealloc
> > are all disabled if it allocated again from pcp_list without going to global
> > free list, which should be introduced by 44042b4498.
> >
> > fix:44042b4498
> >
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> Why is the order check needed? In this case, I think the comment itself was
> wrong and should be corrected. free_pcp_prepare is called when dealing with
> a PCP page being freed and these days that may order-0 or high-order pages.
> Wieh DEBUG_VM disabled, the pages are checked in by bulkfree_pcp_prepare
> when freeing pages from PCP to the core allocator. Why would just
> high-order pages be checked in free_pcp_prepare and checked again in
> bulkfree_pcp_prepare?
for high-order pcp pages(head page in fact), they might escape from
bulkfree_pcp_prepare if they were allocated from pcp-list
again(pcp->count < high) prior to going to core allocator.
for order-0 pcp pages, they will not be checked at all for the purpose
of reducing overhead.
>
> --
> Mel Gorman
> SUSE Labs
