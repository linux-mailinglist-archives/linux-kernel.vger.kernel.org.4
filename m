Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCF2720A3C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 22:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbjFBUZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 16:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbjFBUZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 16:25:52 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEDEE40
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 13:25:51 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5695f6ebd85so12267637b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 13:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685737551; x=1688329551;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E/w9dpHTMqgkLEKvl14+NZFKAOeWHv5+6Cm9LcEp2Pk=;
        b=yLQeX37dgxp9PBBi8VizndbTFQ0QUx+l8iC6lB7aHf3WHqlzVM0sr3Knbm3N2EWBhw
         eZqpYVjs3t3t1cmAGoCNORvLZ8+FHUiHEBRNL7D6U6HSt7vWq9CRTVbjf660HFdOYef1
         R97noyMAORChP/anS1o79GwHXO2AK1/h+l1kpywQpPrYYYroDrmPZE/yWMiufDsascoF
         OLfw0QrP0qttpoClFMjgNKc8UoPuf2u3EbtL+JKqUsVnx0s+fHYPrwPOiysst7WXYUE4
         FUzN8Gk9kCSOktftMRWy2E51SlIaTtlyrVESbO6KanMkf4BVwX+YmFT1EMvmNOATbh9/
         kw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685737551; x=1688329551;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/w9dpHTMqgkLEKvl14+NZFKAOeWHv5+6Cm9LcEp2Pk=;
        b=LaQT1Ha8L1T582vf20xdeNh8Y2LtciOcBd+GXQp5i2lOTkL0V52gl6ldHEluwfswh+
         67o7BFp7Zv4PyhCVyhSTT49FCQk/j6JBCQ6A+t/nka153iKl9LqqFBkim75fSA6g1lo2
         aUOk7hjkCH7Dw/E+7bTD9tyzUNeimMR+Enknrzw3GMaNEpErbSBJ8NNn0efj5+V3eRbV
         daWPa95LIr2Q4GzP85xVZueVzgtT5JV77gS2nkgF6i0xrCXtjht5VlknZxeVXDoQF4PF
         wp7iiOidzLn7rMNNvKEHRLz4ohNRAS0g8bsg36O6TkI+DQSjWAob/7UlcFCJc0cSVSud
         tVQA==
X-Gm-Message-State: AC+VfDyr1ZmDHhr9MDGRraqEO0pjVrfB21YeJH/8ObL+vtQYmEdnkBwh
        M0SjMxs5Hxwg1bNPGSFc/xVpoaWnSJ70WQ==
X-Google-Smtp-Source: ACHHUZ5aXiSla8WVuXVKHCpO0levd8tv2DJvY5OiqwlaBcJWCvDt6MnMLYk9lsZATIzAwGIMvUjHj9o6HW8CBg==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a5b:804:0:b0:bac:a7d5:f895 with SMTP id
 x4-20020a5b0804000000b00baca7d5f895mr1398068ybp.10.1685737551177; Fri, 02 Jun
 2023 13:25:51 -0700 (PDT)
Date:   Fri, 2 Jun 2023 20:25:49 +0000
In-Reply-To: <20230602081135.75424-2-wuyun.abel@bytedance.com>
Mime-Version: 1.0
References: <20230602081135.75424-1-wuyun.abel@bytedance.com> <20230602081135.75424-2-wuyun.abel@bytedance.com>
Message-ID: <20230602202549.7nvrv4bx4cu7qxdn@google.com>
Subject: Re: [PATCH net-next v5 1/3] net-memcg: Fold dependency into memcg
 pressure cond
From:   Shakeel Butt <shakeelb@google.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Muchun Song <muchun.song@linux.dev>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 04:11:33PM +0800, Abel Wu wrote:
> The callers of mem_cgroup_under_socket_pressure() should always make
> sure that (mem_cgroup_sockets_enabled && sk->sk_memcg) is true. So
> instead of coding around all the callsites, put the dependencies into
> mem_cgroup_under_socket_pressure() to avoid redundancy and possibly
> bugs.
> 
> This change might also introduce slight function call overhead *iff*
> the function gets expanded in the future. But for now this change
> doesn't make binaries different (checked by vimdiff) except the one
> net/ipv4/tcp_input.o (by scripts/bloat-o-meter), which is probably
> negligible to performance:
> 
> add/remove: 0/0 grow/shrink: 1/2 up/down: 5/-5 (0)
> Function                                     old     new   delta
> tcp_grow_window                              573     578      +5
> tcp_try_rmem_schedule                       1083    1081      -2
> tcp_check_space                              324     321      -3
> Total: Before=44647, After=44647, chg +0.00%
> 
> So folding the dependencies into mem_cgroup_under_socket_pressure()
> is generally a good thing and provides better readablility.
> 

I don't see how it is improving readability. If you have removed the use
of mem_cgroup_sockets_enabled completely from the networking then I can
understand but this change IMHO will actually decrease the readability
because the later readers will have to reason why we are doing this
check at some places but not other.

