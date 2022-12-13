Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810EB64B961
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 17:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236033AbiLMQO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 11:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235670AbiLMQOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 11:14:55 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006B320984
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 08:14:53 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-3c090251d59so198788707b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 08:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f1nD9sEqUn0kZvdyrOVwMupeHs9n9TUcPbvvCTtNHKY=;
        b=Dcg+fvf5E73fyEBvAWU3Q9s+yoVXu4xkzlDFKkK6XjenGPZH+qPhP787QtMpRHBe6+
         AJkLvvbBr648QYu5qDnZx9EhqHEMMXgCE9eq1F45KD19dbZMHYxhYj0zjusaUcSXueaW
         O5bUKkSuKhwU6lhynhlcCjan0b0vEurCg2y6f92+lj7Ktbz/K/zHAT/JI8mf1suAGVVZ
         ZCdfJdu5A5SRUz7UzJ/Wpz8MCvexDVHVd9+IEbm/8Ok1Yp8Dk7QDnHQ5gmf2MMlrl2QY
         RFJY0mymmScFWzWBVBkb7z9G9xc6KKwOwARGpaP/CaiQx3P9z9k3+ISZFUUPfGsAIF+J
         JwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1nD9sEqUn0kZvdyrOVwMupeHs9n9TUcPbvvCTtNHKY=;
        b=XeIGWtRXLnRNj7j02/wQ68q3/r1U5SR0D1vcOOsbu6auC02tkrjE+nB9PRo658tJZN
         InE6OtSr867goI7wMqEK4TmOVljGQytJ9pis3hkwLvtksM0droROYHmxuQpZJ+eNbitu
         Mb6757QpS2zzh+QMFmkqRu6Z9w0v+OV8tnCsmA3dr19eRyTFRVwGQN012cjbU8vZfWr6
         /cvYIp9h716UQw+/geYEd1mntTSf8gTfaQbayEnabkh/sylpcncfo6gWpfINjnI6IRCu
         Dw4SepUQZtaGz7lqHdPvFNIWvikoCcT6pgNHeFJr0x9JgpRXpD/1NxM23gLFjFG40Wlx
         v6NQ==
X-Gm-Message-State: ANoB5pnVQZgfTAOC1VAnwTd04hPh1yD91xIJA5k97Tw8OFCN+BvUdTEC
        6iQBRNihcSCvXOwjQixhJDVDQA==
X-Google-Smtp-Source: AA0mqf6B6+EebPR/YduhnWildkkZiZCvGs0caCcK8P0VZGLAC6YkISifHPK3S4LdJUq4lOEdOZxtIQ==
X-Received: by 2002:a05:7500:5c1b:b0:eb:3b43:9eb7 with SMTP id fd27-20020a0575005c1b00b000eb3b439eb7mr2217849gab.5.1670948093136;
        Tue, 13 Dec 2022 08:14:53 -0800 (PST)
Received: from localhost ([107.116.82.99])
        by smtp.gmail.com with ESMTPSA id bm25-20020a05620a199900b006fa4cac54a5sm8142328qkb.72.2022.12.13.08.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 08:14:52 -0800 (PST)
Date:   Tue, 13 Dec 2022 17:14:48 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>, Wei Xu <weixugc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: memcg reclaim demotion wrt. isolation
Message-ID: <Y5ik+CCmvapf87Mb@cmpxchg.org>
References: <Y5idFucjKVbjatqc@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5idFucjKVbjatqc@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 04:41:10PM +0100, Michal Hocko wrote:
> Hi,
> I have just noticed that that pages allocated for demotion targets
> includes __GFP_KSWAPD_RECLAIM (through GFP_NOWAIT). This is the case
> since the code has been introduced by 26aa2d199d6f ("mm/migrate: demote
> pages during reclaim"). I suspect the intention is to trigger the aging
> on the fallback node and either drop or further demote oldest pages.
> 
> This makes sense but I suspect that this wasn't intended also for
> memcg triggered reclaim. This would mean that a memory pressure in one
> hierarchy could trigger paging out pages of a different hierarchy if the
> demotion target is close to full.

This is also true if you don't do demotion. If a cgroup tries to
allocate memory on a full node (i.e. mbind()), it may wake kswapd or
enter global reclaim directly which may push out the memory of other
cgroups, regardless of the respective cgroup limits.

The demotion allocations don't strike me as any different. They're
just allocations on behalf of a cgroup. I would expect them to wake
kswapd and reclaim physical memory as needed.
