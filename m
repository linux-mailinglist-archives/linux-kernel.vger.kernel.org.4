Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456FF6C6CBC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjCWP4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjCWP4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:56:16 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9021D21A0B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:56:15 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id hf2so22922374qtb.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1679586974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=73H5IIveVwCSuj8ISfgz0DD6tM9W3+Bkt6XVlPhAYGQ=;
        b=BOTN3RHikvmNyJ/5BRIscfqCjptXrf8qpEubjPg0OC/Xwy+boUt94/+OfrbOvrjrzs
         cJmWGbxdzfNwYKXLNjFeE4gMQoT6n7Ue/HEG5/LMoEeTKeSw/uGUVJVLhA+eCCAdPAw6
         TtqrrK35mvYRbzkyskIxNy5mDJm9BfKY9K6UzVcc3DGVU9OzF+09jvq6Drjb5mZ2qmVt
         HenjMS5dF/r4y3zFsqrBc6Pye1BCCpqXxrBcHNF0Eo2mmCOm0/3b/V5FU143KRmBza1U
         0t4zXTHbwVZfvfVGehbwYOD9++M2yfXXjOlk6zzl04FgUWlZQ7+y/4hEPkd/CR7pqYbK
         NovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679586974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73H5IIveVwCSuj8ISfgz0DD6tM9W3+Bkt6XVlPhAYGQ=;
        b=OvFxkTtJ2l3Z3+9jnTI88PGWrPHasvTINrKhbehILiCqUKfc2scI8JfxSrbZgvbsgs
         zsZCsfBGgngx0MGheaL60VmI6uP0j4et2ASjW2CFYMJN2fpzPu5nPGkqFcQ4Q2iHo9nF
         i/fgM/thXtYHhEnOhyQ9xo/3zbzqZg+agW9lJB9LK4IxM624WxgTEarZnSBOTOgFiJwr
         jkxApkJGg+6sqaykSSWsUBtcm2XYNgxNeNGxQN5gT8oyg5a6Fa0tF9DqC/lFhrg4iwGl
         XeDzGfQYtbd7M6qkGDiQZyGXaAumxePBjdeetPV+2ResF0IoF/IpoI3hPMICO4CJl8DR
         hP7w==
X-Gm-Message-State: AO0yUKURM7QCLS82G4H9ozhHTXmYCva031OI/cUd3zrIeKbOC1qHn/RL
        cV84BlfpCUDISaLikV2BKkykNy39sIXyeZLrY2A=
X-Google-Smtp-Source: AK7set8ZHb51Enf0t/dIsgKw2woHO3ntBPTQ4bYWsu5XGHqtbaXdqba7YQaqZsTNXwWNIceHWF4QLA==
X-Received: by 2002:ac8:5b87:0:b0:3b9:bc8c:c214 with SMTP id a7-20020ac85b87000000b003b9bc8cc214mr9815638qta.31.1679586974671;
        Thu, 23 Mar 2023 08:56:14 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:62db])
        by smtp.gmail.com with ESMTPSA id 201-20020a3708d2000000b007456efa7f73sm8647826qki.85.2023.03.23.08.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 08:56:14 -0700 (PDT)
Date:   Thu, 23 Mar 2023 11:56:13 -0400
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
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Subject: Re: [RFC PATCH 4/7] memcg: sleep during flushing stats in safe
 contexts
Message-ID: <20230323155613.GC739026@cmpxchg.org>
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-5-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323040037.2389095-5-yosryahmed@google.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 04:00:34AM +0000, Yosry Ahmed wrote:
> @@ -644,26 +644,26 @@ static void __mem_cgroup_flush_stats(void)
>  		return;
>  
>  	flush_next_time = jiffies_64 + 2*FLUSH_TIME;
> -	cgroup_rstat_flush(root_mem_cgroup->css.cgroup, false);
> +	cgroup_rstat_flush(root_mem_cgroup->css.cgroup, may_sleep);

How is it safe to call this with may_sleep=true when it's holding the
stats_flush_lock?

>  	atomic_set(&stats_flush_threshold, 0);
>  	spin_unlock(&stats_flush_lock);
>  }
