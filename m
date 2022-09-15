Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F205BA08E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 19:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiIOR4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 13:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIOR4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 13:56:40 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D6F74CC1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 10:56:39 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id p4so1932661vsa.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 10:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=6R15UDYWCPlv8CkuUmhLYYnCsk3TgroblTtGcqD+OxI=;
        b=hv19UOihN1HQFux+vxC38XY8F2OZ/wbKgvNlfGEXlGZS0UsbNwXyrjIXKpKkAufId2
         w9j17Ofze2/94oPXDcBS5R/IrGvAUBhb172PMBmCUs28VGVdgEoxtvLA9Jxv4cmXJsYu
         LVuMTOrWqLcVUQbWJES0pKlEO4B1QK24xqTuo4XmrKUz81MWiISd1IwI2MBhVysQvmHO
         qY5XVzSrakxQ5lvg3OxJhNoSa4zFy0uBvr62rbfYg5OEROA1AziUU8PNGkqHFVSmbOVE
         md5NCH8LcDTye5nFr9brK4Y1ZwRf6UyNFLiZLhCtoDTLq3UJSxT1YfPaVX46p6sKZhsz
         xneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6R15UDYWCPlv8CkuUmhLYYnCsk3TgroblTtGcqD+OxI=;
        b=aLjLojSRkj2O6vARhHSJJTaVs4b4uGkeOstLK4NU0Vfpb1snD03nQgi0bV5qLUYe/M
         qjyzR8lcECfE5p9LAneoylw5N0qxzkbpxaO7aqWv7mWMyI63TovcWQE2iBqvJ+BktaVC
         /tnddmkDHYUgevDCXcOMyQCLrLurGZLyq0RYUcuObpDB81rzbLFq8gBdJOBwR5EwA616
         TkKt8bf9VwGAPgKchqVIvgbLwsYi12YF6d65maGFIgvX8PQ+DynRcFLevQfl6r4hiVuF
         cMiaJHGmV+EX6NnOl6ubEzZCnfWJyfoOd6bjy1pCBeMsxKUUyCDATW985jtddiFy2vnr
         9xog==
X-Gm-Message-State: ACrzQf1Ajv3pVK2Txc4VL0brFFsmqK/rCqoX4es+k5PROA920DdHdK25
        tSerM+/FQjCfOsX0u2RdnQYtxdeSK1MNBvOMaaHAYA==
X-Google-Smtp-Source: AMsMyM6ljPOdRxZyAfL+Hv948pFu9ioMk+dFDU/D3NwzG7Itx8/f/6hSSSORm2EOreZJeGJFGzUSB4vUEORHPkMDreM=
X-Received: by 2002:a67:1d83:0:b0:398:928e:3b94 with SMTP id
 d125-20020a671d83000000b00398928e3b94mr621843vsd.46.1663264598547; Thu, 15
 Sep 2022 10:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220815071332.627393-1-yuzhao@google.com> <20220911170814.f6a32b40e64397a61b1f8daf@linux-foundation.org>
In-Reply-To: <20220911170814.f6a32b40e64397a61b1f8daf@linux-foundation.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 15 Sep 2022 11:56:02 -0600
Message-ID: <CAOUHufZk-u0S+FyDEdxw1nehBKz_G_GG_3_LAzqyssx21Wd4Jw@mail.gmail.com>
Subject: Re: [PATCH v14 00/14] Multi-Gen LRU Framework
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2022 at 6:08 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> I'd like to move mglru into the mm-stable branch late this week.
>
> I'm not terribly happy about the level of review nor the carefulness of
> the code commenting (these things are related) and I have a note here
> that "mm: multi-gen LRU: admin guide" is due for an update and everyone
> is at conference anyway.  But let's please try to push things along anyway.

Thanks for the heads-up. Will add as many comments as I can and wrap
it up by the end of tomorrow.
