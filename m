Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572B674DE61
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 21:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjGJTmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 15:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjGJTmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:42:38 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAB5136;
        Mon, 10 Jul 2023 12:42:37 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-66767d628e2so3149900b3a.2;
        Mon, 10 Jul 2023 12:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689018157; x=1691610157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=04iwNdcQJeXG0mTcbAUJlB0Fp+3icsLoRreQ0OBOOd0=;
        b=AGJpRLLNY7gr0IHt75298Nt4r3trlw/X1GxvHxpZDpWIBel3ffomXdOFl/zKWLJMbT
         +3+hj2WsVbhtAYidOO3xWJfj0OTUE8z+lt3Sd8amPfkDdqXb2JIoVJkc65M21b/cR2OU
         lYzb7D8DRoaLl8DIvJrxAj3GGhA2ByTs08appnDyJdSMtjPidfvS2ve1/bP6zHl7rPvy
         pKhIW/mIuik4FyvRwit7g6MHsB3CYu1gFTKqAa6HN8m2H9UMbfujbFGJemUUD2SA/ygn
         Mv5+l0G0dVGPIkP81ySNtyl4njy+ClQc3b6WL4zBm2vFOvrB5QDSntI98bqAFOYHPrkI
         0OLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689018157; x=1691610157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04iwNdcQJeXG0mTcbAUJlB0Fp+3icsLoRreQ0OBOOd0=;
        b=Mhtnk3vgcijrCpAzheHBGM9qqxxLqSvhvxXJ67WUPEJ54kwr0HCMyo3eXsZp6uXz23
         jokBYDYZLbgYt9dojwwf4XFtlUL1OqlIcp3H7yyPeIJ97fUnBoNKg0ZZoFVGJkX0YgA4
         mDhQimcYmGb1MdM/1IsuQYx8nqRH7zcsGlzuipI5m7jOijtzkNOq3B6pAi9bIaGhMQde
         HWIM5oaTaQKEQdXvuyffbZkv1syUTjrHPA6qQPI+aBalI3THzFfCtOQVpFK67icgsoBW
         xjrkaazISqNsrBgA71NwldHqyBC8ByK94Qm2p+dydr1wvjvXqw8OqGqQbIiNig9RSeoB
         Lbvw==
X-Gm-Message-State: ABy/qLa3qyq2/KGBw/D1Gs1PdE5B4F2lrawuXlNmdJjcVSjTdnS0gZCO
        +mgHaXiPEHDoAyDUbjv1lZU=
X-Google-Smtp-Source: APBJJlGmlqcVyGDxNAqJ3GDBVll6Xd+YVNZXf0l5iLDCGbJCkXlBQ3AwPoKYCNT3QomWU3oAJfjpBA==
X-Received: by 2002:a05:6a00:148b:b0:681:6169:e403 with SMTP id v11-20020a056a00148b00b006816169e403mr13384559pfu.8.1689018156995;
        Mon, 10 Jul 2023 12:42:36 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id fk25-20020a056a003a9900b00682a0184742sm160002pfb.148.2023.07.10.12.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 12:42:36 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Jul 2023 09:42:35 -1000
From:   Tejun Heo <tj@kernel.org>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: Re: [PATCH v5] blk-mq: fix start_time_ns and alloc_time_ns for
 pre-allocated rq
Message-ID: <ZKxfK-cWyvkujSR0@slm.duckdns.org>
References: <20230710105516.2053478-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710105516.2053478-1-chengming.zhou@linux.dev>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 06:55:16PM +0800, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The iocost rely on rq start_time_ns and alloc_time_ns to tell saturation
> state of the block device. Most of the time request is allocated after
> rq_qos_throttle() and its alloc_time_ns or start_time_ns won't be affected.
> 
> But for plug batched allocation introduced by the commit 47c122e35d7e
> ("block: pre-allocate requests if plug is started and is a batch"), we can
> rq_qos_throttle() after the allocation of the request. This is what the
> blk_mq_get_cached_request() does.
> 
> In this case, the cached request alloc_time_ns or start_time_ns is much
> ahead if blocked in any qos ->throttle().
> 
> Fix it by setting alloc_time_ns and start_time_ns to now when the allocated
> request is actually used.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
