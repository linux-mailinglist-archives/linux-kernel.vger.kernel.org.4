Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A09A6D0ED2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 21:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjC3TaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 15:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjC3TaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 15:30:20 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4FA5B82
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 12:30:18 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id l7-20020a4abe07000000b0053e1205c84bso2781934oop.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 12:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1680204618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Khpw7ou3XcOkEyyu20b7pCpZUxpOS3o1zWL8rB8cIWg=;
        b=EBZ5RSwu7qAxwJOxXP+VV5tCHAvd597imHWQHEOpyHjV99Yma2yYj2+GVrBE3CvEYu
         j8GOYLIo/8V6p01dDFwWDz0SuE7pJ9ps3e/uuV/vrp+Efny6FMlE8BM6+lrA9yui5XXy
         BP6sOtWFiXcCali8wq+wJ3ZeGb16MFGin5/zucLqAsEfB6IkgmUZYUNLVZS0o4LTsQYV
         p4WDiyCZ5dD1Xl6y5Lz0GhJWbb1bQHZ85QIJV0Hj8hcm7nUsFbYsfBttw01lkBWhwMDp
         adaoaJrHF1Tqpn0MyPd0QZKQohCtbf0gRnsrAsPTFufImEuTtaA7mENwlPt7Do/NeuEl
         4V8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680204618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Khpw7ou3XcOkEyyu20b7pCpZUxpOS3o1zWL8rB8cIWg=;
        b=yydrjn8XEwSmsRGnSD9DrUB5y0C6VsnbyOj+UkAC7rbTvRxDgjP8WPv4QYemzEWiYw
         kpelKyrDhUYTkM7eHlhYdrbFnr9nN4vWZQR7b5tkY8NQWkJbCQcSkfyC09f6OubIIK0V
         JW5nYerIVU5aKGTygWKqQRU1WC6vs4HbWlwF9V1XROJMxHfa+bsERCQjXYhlElV1wHMf
         Ni+DfZBwplPZObSQ1SZpy8cJy4YvM/HCGBlEsPSXnPGccEaxWVoDU4oZaJ+Sljeemk97
         TeEY/6bOp4AgNtsP1tvPTqKVGLd1TF76a9pcuUtxBaK+hNep8FLbEFdlt1KKY+vA4r5i
         TpbQ==
X-Gm-Message-State: AO0yUKU1vBFWb1QuvC4KuJ1HwaJqzxx6bD8mh7sxuEr1EJR3OdLbxxUL
        XszHfnzhh5dbDfTgRteQD0lCwA==
X-Google-Smtp-Source: AK7set8ZpEUnr0vsSLvX76E+UiWGEN8KrfPFawZyGwI6bQmQYsusk8/LecZTtUIeYJN+T8sl467z8w==
X-Received: by 2002:a4a:558f:0:b0:534:c237:eb00 with SMTP id e137-20020a4a558f000000b00534c237eb00mr11810755oob.3.1680204618144;
        Thu, 30 Mar 2023 12:30:18 -0700 (PDT)
Received: from localhost ([107.116.82.97])
        by smtp.gmail.com with ESMTPSA id 2-20020a4a0302000000b005251f71250dsm13103ooi.37.2023.03.30.12.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 12:30:17 -0700 (PDT)
Date:   Thu, 30 Mar 2023 15:30:13 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v3 5/8] memcg: sleep during flushing stats in safe
 contexts
Message-ID: <ZCXjRYASA+Cjomlx@cmpxchg.org>
References: <20230330191801.1967435-1-yosryahmed@google.com>
 <20230330191801.1967435-6-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330191801.1967435-6-yosryahmed@google.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 07:17:58PM +0000, Yosry Ahmed wrote:
> Currently, all contexts that flush memcg stats do so with sleeping not
> allowed. Some of these contexts are perfectly safe to sleep in, such as
> reading cgroup files from userspace or the background periodic flusher.
> Flushing is an expensive operation that scales with the number of cpus
> and the number of cgroups in the system, so avoid doing it atomically
> where possible.
> 
> Refactor the code to make mem_cgroup_flush_stats() non-atomic (aka
> sleepable), and provide a separate atomic version. The atomic version is
> used in reclaim, refault, writeback, and in mem_cgroup_usage(). All
> other code paths are left to use the non-atomic version. This includes
> callbacks for userspace reads and the periodic flusher.
> 
> Since refault is the only caller of mem_cgroup_flush_stats_ratelimited(),
> change it to mem_cgroup_flush_stats_atomic_ratelimited(). Reclaim and
> refault code paths are modified to do non-atomic flushing in separate
> later patches -- so it will eventually be changed back to
> mem_cgroup_flush_stats_ratelimited().
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
