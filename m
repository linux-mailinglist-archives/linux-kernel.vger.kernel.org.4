Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB446E5FC7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 13:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjDRLZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 07:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjDRLY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:24:57 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B58C1706
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 04:24:56 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2470e93ea71so1264231a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 04:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681817096; x=1684409096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kTV7w1VBTv2R3i8IqtDqVdnfuP/Nq/s0lsxsfWsXrj8=;
        b=gzVeUfWM0Pliuy8Tli53mpWcf3DNvVUoV960W1E3em3zZLmXY2HkKGyOkmB1+m1XJY
         qlXo0SHybpdG85XTdm+rMPQXV/Yjlm/vcbGcccGNhpuqyi3r5D4Hx4qspf4ipULkexCm
         wMm5H+UR47QpltTEr+Csk+DZjDdhZG4CN3zzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681817096; x=1684409096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTV7w1VBTv2R3i8IqtDqVdnfuP/Nq/s0lsxsfWsXrj8=;
        b=eXkkfhEquZE5n90yYaPrcvKtD72GgqnOeIvGFiwY6nfErqQXUuqOTht46QwvjMktHQ
         YZZpeNsNwho/UPas7MtYae8JDb9POC+g9mJJQtlpLti8yr825mGjYoUIf3gzQkwpsXfd
         fFIgiIqwVzR2C2G+BpEDnEWLOcU+rBWtxWflmv6UVdPA5n6G3rcIolcJ+W8yt1v5ho+S
         huZvW8K00mx1HqODkG4HdTBBGosVNOZFsYWEiqbCOz2WeMg+0e5rk3AstJ/oODYg8ryh
         XDf4veQ83wNVWy7tx9Rl4dMonhnpLLNFJDqWdmRUwCkFaqwgtKmCFF4fU4ffmSK+UBtr
         BmzA==
X-Gm-Message-State: AAQBX9dYXzHYGqYhiEEWD8iKfVrJzd2+FAJNXya1K8fJcG72vk+pWbRN
        L4StW8PyXdN8Z/Z0Bd4Gi057Mg==
X-Google-Smtp-Source: AKy350ZEgHKWTr+RKRg2xGrHsBfWBCL+hbHo3vDqsTfOjNnICnQwXdK8PwtlJsu9ADmdHN+sqxKsBw==
X-Received: by 2002:a17:90a:670e:b0:23d:4b01:b27 with SMTP id n14-20020a17090a670e00b0023d4b010b27mr1911234pjj.10.1681817095838;
        Tue, 18 Apr 2023 04:24:55 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id m2-20020a17090aab0200b0024677263e36sm8675229pjq.43.2023.04.18.04.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 04:24:55 -0700 (PDT)
Date:   Tue, 18 Apr 2023 20:24:50 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv2] zsmalloc: allow only one active pool compaction context
Message-ID: <20230418112450.GT25053@google.com>
References: <20230417135420.1836741-1-senozhatsky@chromium.org>
 <20230417174131.44de959204814209ef73e53e@linux-foundation.org>
 <CAJD7tkZOmUnfi8mGtr3a-hbSZcHsR3cXqVO+Luo4w=8qh-i3_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkZOmUnfi8mGtr3a-hbSZcHsR3cXqVO+Luo4w=8qh-i3_w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/04/17 19:53), Yosry Ahmed wrote:
> 
> As for this patch, I personally do not observe a lot of compaction in
> our production environment, and allowing one thread to perform
> compaction while others move on with their lives can be better than
> having all of them continuously contending for the pool->lock, which
> means more contention with ~all zsmalloc operations, not just
> concurrent compactors. I can't say for sure that this is an
> improvement, but I *believe* it is.

Looking at one of ChromeOS memory-pressure tests, I see that sometimes
(albeit rarely) we can have up to 9 parallel zspool compaction contexts,
perhaps a little bit too many for a 12 CPUs laptop:

[ 2159.378827] zsmalloc: ctx #1 chrome -> zs_compact()
[ 2159.379002] zsmalloc: ctx #2 Chrome_ChildIOT -> zs_compact()
[ 2159.379120] zsmalloc: ctx #3 chrome -> zs_compact()
[ 2159.379135] zsmalloc: ctx #4 chrome -> zs_compact()
[ 2159.379213] zsmalloc: ctx #5 chrome -> zs_compact()
[ 2159.379271] zsmalloc: ctx #6 chrome -> zs_compact()
[ 2159.379276] zsmalloc: ctx #7 chrome -> zs_compact()
[ 2159.382786] zsmalloc: ctx #8 chrome -> zs_compact()
[ 2159.432153] zsmalloc: ctx #9 kswapd0 -> zs_compact()
