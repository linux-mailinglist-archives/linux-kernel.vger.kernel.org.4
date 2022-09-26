Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79905EAC8E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiIZQcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiIZQb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:31:56 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A5282D2F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 08:21:01 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id e187so8774422ybh.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 08:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Fddt9wdq/J6CWGu90+cFZ6uqg+vju1ZgOwGknKQrGms=;
        b=TgMFdscVjGqwG6aw8YINYC6hut/9EoC0pUZ1CZ/6dDVVoxWEhmoXyjgdSPeBA+iscl
         SM68MDTHPhtCbdHqyQXgP2dQJfYqYFonvFpgJG5iD9pVtQtutMoCCC5RjWuP8ouzDhDF
         ZF5/m2ejMr8gdSODmlJAColLtiUNdNji6QKIvP21zqnsbhsp6llxe1A1cNawNk7J4HAI
         77HMYtxhvL5R0utZmPF/o+c1nllwoOid2lDgktWsVDzjxASpyoJLFSyZxhTq3giIH1BT
         yGWDMoLuhS+dLb8ZQbvXS6bWU7eIbcIfqBV622xZRa19fnVpxcnyNRxg9onMkwGSs5Y3
         cfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Fddt9wdq/J6CWGu90+cFZ6uqg+vju1ZgOwGknKQrGms=;
        b=LagxzI2ihwBuXC8s46nCOa/pAEhrdHXmx68XudO9fIGdD6Vzmr9wVwBharz+STRpBf
         dDhovzqvezg94ZD8QuKt6X9Gh6ZW8saMcHzqkdVFJZDNKFkZc3dhOv+No3cn17R17X+G
         kQrgQxsTwdthXjUboCTl1hSGzM9sEAekO46GHLT2sQ3fMwE0uUbcWvhdpifeOMnZDK9b
         u02Lq289DCu8iP32oNtPM/MuhKqMBQ+Cib97RXGKnxvKnZKsNjEOKRIErMxa4FQYBRkr
         p/UcAm7rc8VW92L+iJEIPnPXAv48ZDtaGDMXFDYvNQxXDddR9EF0o3WoIl/1OMLSHiX4
         HN/w==
X-Gm-Message-State: ACrzQf1yGDIkkv7cUrlOSPrcw1KjmkjKrJVyhqFs/kuU8xF1N5kqF1XQ
        LZ0qGsa2TQ8SQQfAZsLhHDqJpxQ94M4+44JthQJn+eXzEsc=
X-Google-Smtp-Source: AMsMyM4vqLQBjoje2tRkYCsa/HpLs2TMDNhLbiS7qdXIZdkByfg8x8usPZSmcibYbptjkn8wu9MqYDrKBTSjWsQW5Aw=
X-Received: by 2002:a25:3007:0:b0:6b1:ba6b:1b06 with SMTP id
 w7-20020a253007000000b006b1ba6b1b06mr20752440ybw.208.1664205648759; Mon, 26
 Sep 2022 08:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220926135704.400818-1-hannes@cmpxchg.org> <20220926135704.400818-4-hannes@cmpxchg.org>
In-Reply-To: <20220926135704.400818-4-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 26 Sep 2022 08:20:38 -0700
Message-ID: <CALvZod5BPO20mf2taEwGuF18e9tR3u=P7LMOAJJT5iuRjEJh=w@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm: memcontrol: use do_memsw_account() in a few more places
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hugh Dickins <hughd@google.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Mon, Sep 26, 2022 at 6:57 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> It's slightly more descriptive and consistent with other places that
> distinguish cgroup1's combined memory+swap accounting scheme from
> cgroup2's dedicated swap accounting.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Shakeel Butt <shakeelb@google.com>
