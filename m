Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25C76EFEB2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 02:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242722AbjD0Azg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 20:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242797AbjD0Azc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 20:55:32 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA893A92
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:55:31 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b52ad6311so9179129b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682556931; x=1685148931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yudVX7H4NIkiNzJ9h/7v+Ix6+CQ48FCh3vdWg2CCa+Y=;
        b=lyo5HpmPPSKolKBMxnPM231JTOTMTYvltSMnwkbTvdMQxeRwrvOaTo//K+J0zWJYLK
         4/53gNTzI3i5Cxkomb16kK3VD2XaUWL5wSilFWJwDKWwddRdABcgiKcy0yHgG9grtzT+
         OmsXMqq0zQHNDZphrGnQvCMOGHRkMLS9q32Jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682556931; x=1685148931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yudVX7H4NIkiNzJ9h/7v+Ix6+CQ48FCh3vdWg2CCa+Y=;
        b=NcMqNd/5FSfKtiDyfS5RZY50wyTv208CE+C8x+Uss2LiAd+TIsBQtCWvnRT9uKnCa1
         sxIpVWS62YZ7mdJ3NDA0vWonGZiADvnQ0SsYlBGYW7QKvF3FN97JVpP4AHmD+A8jVy37
         nArR76w0+FckzIY3A4fRe2/IgqHhRJuXGJnZob64bgfniWx2AtZtFyAYoG1N44+hvlPN
         M7sinoiIitexXCgHVNhYOlmpiz0C0dCq1P4DLBubulojl7Ery1FAVYVgmF36SnLcYgzL
         3HtNqKrGcegRTjOLMLgmXjhX2HfLurAlJtJ6LwCVhcjxdh3CX7wgykeSEU1Ku6XoRWO2
         H/mA==
X-Gm-Message-State: AAQBX9ehYq7pA86sPeGPxRN8SVs6SMyOI5TWLLHyzrSsg1cvVRUsh69y
        s9inIsrVfFKLIipo6NUq6hKRsw==
X-Google-Smtp-Source: AKy350YskKlSRM7MYbei0qJ+kZPwyxuutnsUnqhTuV4kOICiCIk7mkOGwawDAp85yUEY+tM92eHw0w==
X-Received: by 2002:a05:6a00:b87:b0:63d:2d99:2e91 with SMTP id g7-20020a056a000b8700b0063d2d992e91mr32488778pfj.28.1682556931215;
        Wed, 26 Apr 2023 17:55:31 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id q14-20020aa7842e000000b00640dbbd7830sm5830995pfn.18.2023.04.26.17.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 17:55:30 -0700 (PDT)
Date:   Thu, 27 Apr 2023 09:55:25 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>, Chris Li <chrisl@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] memcg: use seq_buf_do_printk() with
 mem_cgroup_print_oom_meminfo()
Message-ID: <20230427005525.GF1496740@google.com>
References: <20230426133919.1342942-1-yosryahmed@google.com>
 <20230426133919.1342942-2-yosryahmed@google.com>
 <ZElCHJrkOVsy79KY@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZElCHJrkOVsy79KY@dhcp22.suse.cz>
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/04/26 17:24), Michal Hocko wrote:
> No objection from me but is it possible that more printk calls (one per
> line with this change correct?) would add a contention on the printk
> path?

It probably will have opposite effect: console->write of longer lines
keep local IRQs disabled longer and keep console_waiter printk spinning
(in console_trylock_spinning()) longer.
