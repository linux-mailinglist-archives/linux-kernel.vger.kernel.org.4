Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB669642A49
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 15:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbiLEOWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 09:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbiLEOVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 09:21:47 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C7C1A226
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 06:21:40 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id c17so7427196edj.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 06:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tObwGL/MMlN8TFc4loLjh6BEZOWq+dlz3cmU/K+yIJU=;
        b=U6H6h2KUZy6VCNfkxfLiN6T83KRyTFEGLS0dRWLukW4LvZIpidZt9usPMNKcc1MXAa
         N5G6Ikftb3O5mNI1EMqxWBWKYXIMpBOeyKB7k/BGFsINBVuuTCacGM4k2elEz6XfwBj+
         SJ9GZb34xcJw6CXCNReIfUMgpMGZUYcw8GE/+XfVwseG/P8UUN0RBdXdMXI1tJWzg8p6
         w+TAXqT3YAM++g2ny/qmau2TNawLxsG9nkWT00SwxbljMQnxbfWmDcxVaHBLYfQXfBcL
         jC4O9sRlwJxqJnERlBYFz0sWCMzBZCe8ApbOgEc6itbSXdXoxJ0HT8shH5UBI96Bmqz+
         HyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tObwGL/MMlN8TFc4loLjh6BEZOWq+dlz3cmU/K+yIJU=;
        b=WVSi5vBVhAIL2dhJxo+7vl+blkAkkncn6vVizjTJvWSUowJQ9/pxa5dT0aQphkWplI
         VHAiA2V4hM8av7TZPM/m+ZgraGIk+J8mVogf/7agv8GBgZHrUgkXU04UsgKPPiwUI68X
         yb9M/o8Ogd6iInH5YVbxS9foAwZ2lJ1D49Y4Pjp93NBlta4pznclSU4dUiXTEtz6D1+y
         hfGQ9BVM4foHRqYTv6Rbf3qV5tnRuPbK0Xglfbw6cpwRdmLipEvXomg122SSeK1lXFDC
         QrHZvmBnxmqw/HvjV6Rw9K+nL4SRXH44ofBlKirpfirTFxbXetDHJ+0+iJeUe8zZND3N
         hbUg==
X-Gm-Message-State: ANoB5pktNDYQ2lw5LYKFfc51hhmz1jTOx5/ATGfaEddPiTjGwMY0lrod
        eam7YLOIe9Y4313/S2C6rKQHug==
X-Google-Smtp-Source: AA0mqf4VoiAU0KpEZaoGn5PrdL7QEenwhLzzYkXw99I0TKH42IlhUBWCvbyH/cPDb9Qr8aHSXoT9Mg==
X-Received: by 2002:a05:6402:5290:b0:461:af68:9bcd with SMTP id en16-20020a056402529000b00461af689bcdmr58605297edb.67.1670250099275;
        Mon, 05 Dec 2022 06:21:39 -0800 (PST)
Received: from localhost ([2a02:8070:6387:ab20:15aa:3c87:c206:d15e])
        by smtp.gmail.com with ESMTPSA id bm14-20020a0564020b0e00b0046bf4935323sm3888099edb.30.2022.12.05.06.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 06:21:38 -0800 (PST)
Date:   Mon, 5 Dec 2022 09:21:37 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: memcg: fix swapcached stat accounting
Message-ID: <Y43+cUNTrq3VKgU2@cmpxchg.org>
References: <b8b96ee0-1e1e-85f8-df97-c82a11d7cd14@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8b96ee0-1e1e-85f8-df97-c82a11d7cd14@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2022 at 05:01:03PM -0800, Hugh Dickins wrote:
> I'd been worried by high "swapcached" counts in memcg OOM reports,
> thought we had a problem freeing swapcache, but it was just the
> accounting that was wrong.
> 
> Two issues:
> 
> 1. When __remove_mapping() removes swapcache, __delete_from_swap_cache()
> relies on memcg_data for the right counts to be updated; but that had
> already been reset by mem_cgroup_swapout().  Swap those calls around -
> mem_cgroup_swapout() does not require the swapcached flag to be set.
> 
> 6.1 commit ac35a4902374 ("mm: multi-gen LRU: minimal implementation")
> already made a similar swap for workingset_eviction(), but not for this.
> 
> 2. memcg's "swapcached" count was added for memcg v2 stats, but displayed
> on OOM even for memcg v1: so mem_cgroup_move_account() ought to move it.
> 
> Fixes: b6038942480e ("mm: memcg: add swapcache stat for memcg v2")
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
