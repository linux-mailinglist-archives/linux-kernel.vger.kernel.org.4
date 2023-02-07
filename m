Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB6368E38C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 23:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjBGWqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 17:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBGWqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 17:46:44 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43B91D91F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 14:46:43 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id k4so17962334vsc.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 14:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1675810002;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dd4k2clGQvAYBUq7oYGCfW0nQaeNii+CVBUcnHja++A=;
        b=aFdGcBbsSwnv7E8NykVKcj5yUXrHS/JVFsmAQ7a4DD1xn86ypvDBdJBqMwPbgoVSz5
         JovXcDp6p+vlVpM2KdoX+Fc6U8beRHxay4MyGFe2X4onczuMTGcTtEVFDuZCq0+m9b+o
         hZDmW+lwCZ0AQu/bVUVg613ApPOZ1DzqYq365zpOGjLBoWx7T/uer5s5MmwY25I2J6oE
         nlNwhZB9Tc2ocy+ygTlcUTphmtyW2Q+ywO87gfnXvbszKxDSGXu5hAsZrWO7DQYkAQPM
         GNVoI837kC/kSfrgiMQup3r9V8Qh/IfGr8ZxNCCo/uLNwmIJzevHbvXuZ6eChLJ7luvs
         aUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1675810002;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dd4k2clGQvAYBUq7oYGCfW0nQaeNii+CVBUcnHja++A=;
        b=jLlolHHaIxhpNC7Etl3L7oTvRfwJzgcdfZ/D1ETMz65WJIYNQjB+SQLCjFhJ5SN5p1
         cDaqWvwB1qsko3kuPL0Xjy4hEiCp68I+QEl8Rh9QGOC7yrKQav5Wm3VJh6Q5T0uYf5je
         JZMaHNhDlAYHW0qJqs93AFdD70SPOoevf7tf2JCDRY1iNghC5ovVM9uEy97lHQqXSDP4
         GkUFuLz5FhiWBEDZbRE6vH/b9KTUkOzvYkmWDRMzdxdqTjwfQBl8CZG8sLMi245fYjw5
         W2s6tQgHcVobLeuecmWfjP/o4fk/aaYw7oObhIBHzF71+DGJV1A+hpexp68CxQhL5z7g
         0oTw==
X-Gm-Message-State: AO0yUKWyBkOs6sFlOOtE+3psCr7R5+i6oBr7AIppAtlBy8tVXXmEYfyN
        pbezbu2nU5RDIqMiHgWiTUVP8I2JRffqbwEiKM5r7w==
X-Google-Smtp-Source: AK7set9KdE7K2VwpkmpPDdbgRPU9KWW0L/1ytARhlMr9eWAC9KK+OPs217EpAVwaL9S1d9Ug0mbZtnDwK65brTseVCU=
X-Received: by 2002:a05:6102:201b:b0:3f7:dda3:f85 with SMTP id
 p27-20020a056102201b00b003f7dda30f85mr1048272vsr.66.1675810002563; Tue, 07
 Feb 2023 14:46:42 -0800 (PST)
MIME-Version: 1.0
References: <Y9Li93O6Ffwcr+vn@x1n> <CADrL8HVJb9mA3Lbz5UKJ8EudTk9sGDY-pdRqvW3TGawD_bJB0A@mail.gmail.com>
 <Y9f+jMLWy6ngpYuR@x1n> <CADrL8HX3sf6OO3PXS1g6b2dKf8b5phQ7oyNR0dVT=sAOdTmmqw@mail.gmail.com>
 <Y9gzOqwKcu7p/PEw@x1n> <CADrL8HXX9YDFUxmPPsm2s3Pno0XXgAyFB40fV1PdtP9eb-5D2A@mail.gmail.com>
 <Y9m/VVRABt0Blfjh@x1n> <CADrL8HXpfTE1+eE3rNGQyOr1QRtDtG5mBp-b3xcNX22QJRvPaQ@mail.gmail.com>
 <Y9qRta3bd4JqjUHx@x1n> <CADrL8HU809O0cPa9hXjf3k+ob139SQqvxOvpqm6UEv=zrPjHSg@mail.gmail.com>
 <Y9re82gctIZf08cX@x1n> <CADrL8HVja_xJ9qczsd-fQfEPvEEXswhXQwoan=a_LSMyORvqww@mail.gmail.com>
 <CADrL8HUSx6=K0QXQtTmv9ZJQmvhe6KEb+FiAviRfO3HjmRUeTw@mail.gmail.com>
In-Reply-To: <CADrL8HUSx6=K0QXQtTmv9ZJQmvhe6KEb+FiAviRfO3HjmRUeTw@mail.gmail.com>
From:   James Houghton <jthoughton@google.com>
Date:   Tue, 7 Feb 2023 14:46:04 -0800
Message-ID: <CADrL8HUm7g4pBLv9vjmB-LhJqxm4jyksGJQAdwRsweKKAnofDg@mail.gmail.com>
Subject: Re: [PATCH 21/46] hugetlb: use struct hugetlb_pte for walk_hugetlb_range
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

> Here is the result: [1] (sorry it took a little while heh). The
> implementation of the "RFC v1" way is pretty horrible[2] (and this
> implementation probably has bugs anyway; it doesn't account for the
> folio_referenced() problem).
>
> Matthew is trying to solve the same problem with THPs right now: [3].
> I haven't figured out how we can apply Matthews's approach to HGM
> right now, but there probably is a way. (If we left the mapcount
> increment bits in the same place, we couldn't just check the
> hstate-level PTE; it would have already been made present.)
>
> We could:
> - use the THP-like way and tolerate ~1 second collapses

Another thought here. We don't necessarily *need* to collapse the page
table mappings in between mmu_notifier_invalidate_range_start() and
mmu_notifier_invalidate_range_end(), as the pfns aren't changing,
we aren't punching any holes, and we aren't changing permission bits.
If we had an MMU notifier that simply informed KVM that we collapsed
the page tables *after* we finished collapsing, then it would be ok
for hugetlb_collapse() to be slow.

If this MMU notifier is something that makes sense, it probably
applies to MADV_COLLAPSE for THPs as well.


> - use the (non-RFC) v1 way and tolerate the migration/smaps differences
> - use the RFC v1 way and tolerate the complicated mapcount accounting
> - flesh out [3] and see if it can be applied to HGM nicely
>
> I'm happy to go with any of these approaches.
>
> [1]: https://pastebin.com/raw/hJzFJHiD
> [2]: https://github.com/48ca/linux/commit/4495f16a09b660aff44b3edcc125aa3a3df85976
> [3]: https://lore.kernel.org/linux-mm/Y+FkV4fBxHlp6FTH@casper.infradead.org/

- James
