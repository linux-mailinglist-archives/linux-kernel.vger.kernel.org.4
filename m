Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC4969D6EB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 00:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjBTXGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 18:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBTXG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 18:06:28 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C120A211C7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 15:06:27 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536c6ce8d74so10926767b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 15:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YmN4phAlQkhzlJhZTnkt2lPmMnV0UPOAfOT82kiHHdI=;
        b=fi/UHzhloZhXYA+Bx7TCopexrAPK2VRGIvfjdEkvebvlmvA7Vhlp9PfNoezaPzsbuV
         j1rR6Ma/LX95ho2r3qSmsrznFmm8x297iifdcowOAhWGE+ijcNKeo2ks7u1lyAF0Veza
         UdxKl4vDG/x6FlnVq/I8CHEE9/uSCXM62sF2Ov75EUQcHkSCdNfEh/OdaJaQ6NDx+zkN
         CDdxer4hj6ukRwtzKenR4RIhDTJi4m39HVdeYt6BKy2Emo/v/dLGc43ptginipQN3JcQ
         C7nmPm2P7N0E60CT5foRxvrRZp116dAaWLwq57rks/KBO8t7XPkHFneGSAByUlOK6gVZ
         Q8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YmN4phAlQkhzlJhZTnkt2lPmMnV0UPOAfOT82kiHHdI=;
        b=Zvja5b8ok/4uIj74QN8iYcQEJB/yt/m06NYINTVzRf6Os+q7VBLLJxm58HfpO192N3
         V8DJu7oJRgQ+7g9ivOZcXOoICTPCErM1FH87Qa94lDGM4X/OjOVDBuIJO6wdhIav16RF
         YNsyElgGZAa0YcCNCC3K542RtwX12xZ4KBvwQV1bsO+F9FiGf6b7w2YsQv9nxncromgJ
         OrcFUMmVwvfH0fHyvpLYzmTSu2ua1jNHis3PwdpwQrO8QzCtpWw3IDgyLTaiY/3u5J7t
         Cp12hhnXL/fcQkCESB7tFBBSuPUZ2PQCsGBc1zb+GHmCddu08iEQH2xx00uVlay6pCV9
         1HbQ==
X-Gm-Message-State: AO0yUKWYqmY5NufBOqrD25WAyrjDGiTS+Pnfxxv2WQhIcdlvaMTdyWUc
        rRgBKzLKSe6Wyv6kB3PNz6LLqSo16Q/CKg==
X-Google-Smtp-Source: AK7set9eTbjxzVHgwqTVrsq8+t04iovD1710Gn5wrsNZM2XFjzZnV/4hUtkH0xHAmBIDFtB1R6h2fytmQbgKXA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a05:6902:10c9:b0:855:fdcb:4467 with SMTP
 id w9-20020a05690210c900b00855fdcb4467mr493046ybu.0.1676934387024; Mon, 20
 Feb 2023 15:06:27 -0800 (PST)
Date:   Mon, 20 Feb 2023 23:06:24 +0000
In-Reply-To: <Y/PhmEPc/qYeZ52T@P9FQF9L96D>
Mime-Version: 1.0
References: <20230220151638.1371-1-findns94@gmail.com> <Y/PhmEPc/qYeZ52T@P9FQF9L96D>
Message-ID: <20230220230624.lkobqeagycx7bi7p@google.com>
Subject: Re: [PATCH] mm: change memcg->oom_group access with atomic operations
From:   Shakeel Butt <shakeelb@google.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Yue Zhao <findns94@gmail.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        muchun.song@linux.dev, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 01:09:44PM -0800, Roman Gushchin wrote:
> On Mon, Feb 20, 2023 at 11:16:38PM +0800, Yue Zhao wrote:
> > The knob for cgroup v2 memory controller: memory.oom.group
> > will be read and written simultaneously by user space
> > programs, thus we'd better change memcg->oom_group access
> > with atomic operations to avoid concurrency problems.
> > 
> > Signed-off-by: Yue Zhao <findns94@gmail.com>
> 
> Hi Yue!
> 
> I'm curious, have any seen any real issues which your patch is solving?
> Can you, please, provide a bit more details.
> 

IMHO such details are not needed. oom_group is being accessed
concurrently and one of them can be a write access. At least
READ_ONCE/WRITE_ONCE is needed here. Most probably syzbot didn't
catch this race because it does not know about the memory.oom.group
interface.
