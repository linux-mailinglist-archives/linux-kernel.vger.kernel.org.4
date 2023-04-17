Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CED6E47F0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjDQMiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjDQMiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:38:13 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC6B212F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 05:37:47 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id b2-20020a17090a6e0200b002470b249e59so15089732pjk.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 05:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681735064; x=1684327064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vie4whHHPmibdiBKTG0fY7db5Iv/a7XJkSahv5+UhFk=;
        b=HF/7DG2n1EMT2xuofihIKJwY3AgaoLvNbmm9LAh7A3lIqLAYThD2zLU9zOBOIFpFoF
         RXooN2MahML4yoGupZdv0xpFFR06vhAsdj7+aDclEylSmHRkv48RF4ZfvRMN/dp5bcWg
         znxgy5WkZ9glu+iWumCVabVquQgOe9RG3NBjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681735064; x=1684327064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vie4whHHPmibdiBKTG0fY7db5Iv/a7XJkSahv5+UhFk=;
        b=B9LOQhon6CnMTgdN+TfWvWOYbc8NidAuEm/mNzzyO3J9HgA+P4ViTia4flyKsuKwPz
         t5eJiGdLCDfcFVkUFo/XXmQwGOvZv4p6sUrvkPu6oUauw8uv5JiB4S8m09rZUY6fHNE5
         jO80cgzTHHI+okl/L3JumxMuXgzCIBUL4obbhPTAAtJf2E4xoulWe8FMo6dqFJ0YuW0B
         XUdn3X0PKks/KY2VHI3x3tl+zrYvZYbvRiwXwUd/XuOJvKZNoqMy2VsD1G4lf4mqNboI
         QqzC85+Dtl9rUzLNWGFCiGirv4XkGdnHxNVyD+pz2wPdWXuljyKFhhmehIdfPBnyn0Rg
         ttJQ==
X-Gm-Message-State: AAQBX9dYtZIKtDMbBVb0HapbuWfso06JMHThh2i96eYvDBuKKiEJd06i
        8TluxE41dSIqfT+cDIdICPWiOw==
X-Google-Smtp-Source: AKy350avrCH6piHZBzzjYd0m9IgipYojqQEVpd1UaznV/jomwntqa2XKZ8LCNkK3m2JSq1pjn6yMmg==
X-Received: by 2002:a17:902:aa84:b0:1a6:7fae:3a28 with SMTP id d4-20020a170902aa8400b001a67fae3a28mr11736865plr.42.1681735063984;
        Mon, 17 Apr 2023 05:37:43 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id w7-20020a170902904700b001a25d7d1fbcsm7594893plz.38.2023.04.17.05.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 05:37:43 -0700 (PDT)
Date:   Mon, 17 Apr 2023 21:37:40 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] zsmalloc: allow only one active pool compaction context
Message-ID: <20230417123740.GP25053@google.com>
References: <20230417110259.1737315-1-senozhatsky@chromium.org>
 <CAJD7tkbVnwV0t8BPqVcY7+gooW8NSs=nq2U0TuQC5ZP1xhVSNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkbVnwV0t8BPqVcY7+gooW8NSs=nq2U0TuQC5ZP1xhVSNg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On (23/04/17 04:53), Yosry Ahmed wrote:
> > Introduce pool compaction mutex and permit only one compaction
> > context at a time.
> 
> I am not sure what's the best practice here, but if the only use of
> the mutex is a trylock, do we need a mutex here? It seems like a
> simple atomic would do the trick. Perhaps something like:
> 
> static atomic_t ongoing_compaction = ATOMIC_INIT(0);
> ...
> if (atomic_xchg(&ongoing_compaction, 1))
>     return;
> ....
> atomic_set(&ongoing_compaction, 0);

Looks good to me. Will switch to atomic_t in v2.
