Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17C9664CF4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 21:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjAJUEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 15:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjAJUE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 15:04:28 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEDD373B8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 12:04:27 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id j16-20020a05600c1c1000b003d9ef8c274bso6624319wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 12:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MZNu5ozoSkh9uaJy1rfaWNQva2WecGGGMzIGliOy9aw=;
        b=AtVGs7t94tt98lfoWaSqFUJM+BbUEtKQ95BgkTfG6RraLysou76hFgvezW1wb+W66Y
         2q94GiON/1+VLFt5Ucy1xIhHpZaNf3aItEgLODdPtPcfLofEogIuIWLoYydriBuxomUJ
         4rZR0vr1rrYMDJL+nqIrHfe6tkY+K+lGQCeyNNYGRFHMvw0RHjqOhlXWqp+KAgva7exZ
         NfZyk4cN6XViIYwv5yCL6IKaU3nxya0qep4pct6K2MYRJjJtXmqRkg9PBetvcjLdHQN0
         TiEySTtaP5r5ENkIecNfuudw2j/AIZmwbKvRzcHAshtfHLwFYoKnbZ00G/yelVISKxYI
         WruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZNu5ozoSkh9uaJy1rfaWNQva2WecGGGMzIGliOy9aw=;
        b=ySEjFXei/6sJKMusUUHX9qOMHwXebcDeYm/jJa8D74U4uktW+2k5QLN75l6pnb7QgV
         MdqKz+oBFgZNS3klfRXOsnQ+AsZcH0Or2jRoSbIiDCXX+//+ktb976cEneKTImculQMt
         MHqYgZEfk7ijG5cV6ceGHOPC9hX34YT1YabzE082s9DaITOdkIxCM4IvNrWgAMQwiy49
         bObOPmuzsX5JUgzqtmSyF5krdEZFZS6Wx3oEbrwMnY+TMlohgU+FpgVvHI4EXM16A95A
         PElQ2HjhDcadxepbcAmkr8xDib15zIOWxwcwb42aJC+6bnBxIFb1gi7Av7TfV5Kps6/C
         PEAA==
X-Gm-Message-State: AFqh2koizzCFY4O4BN9ON/vPr+0oKnYzVG2uudkhfsmHxd5WmRNmq6mC
        UjocruEf8DeOm710FCHFYsi/ECOe+wf7q5r7NJbpsA==
X-Google-Smtp-Source: AMrXdXutExl6Q6Pj0nBYDjwAyRPBg7aoUlg/eFqKQAK0/No8r0/Ksxekc0V+GE5rahAJnxijatuxVZzeVzWGKRbkHLA=
X-Received: by 2002:a05:600c:434c:b0:3d0:7d89:227e with SMTP id
 r12-20020a05600c434c00b003d07d89227emr3619525wme.166.1673381066034; Tue, 10
 Jan 2023 12:04:26 -0800 (PST)
MIME-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com> <20230105101844.1893104-36-jthoughton@google.com>
In-Reply-To: <20230105101844.1893104-36-jthoughton@google.com>
From:   James Houghton <jthoughton@google.com>
Date:   Tue, 10 Jan 2023 15:04:14 -0500
Message-ID: <CADrL8HUvugKN15=XBkELCa=rhd3vjRiwUDsY5cFKkWHO1x5Nyg@mail.gmail.com>
Subject: Re: [PATCH 35/46] hugetlb: add MADV_COLLAPSE for hugetlb
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
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

> +
> +               if (curr < end) {
> +                       /* Don't hold the VMA lock for too long. */
> +                       hugetlb_vma_unlock_write(vma);
> +                       cond_resched();
> +                       hugetlb_vma_lock_write(vma);

I need to drop/reacquire the mapping lock here too (missed this when I
added the bits to grab the mapping lock in this function).
