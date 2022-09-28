Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703125EE1E7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbiI1Qbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbiI1QbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:31:22 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C307C58537
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:31:01 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1318106fe2cso6797449fac.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=RNYkwlzjSBs38E+/5XUZn4xEpIcCbwJSOmIImzP0KC4=;
        b=dog9Z6dDOTNjNFT3nVOx9AVPuy15Elp3ZH1zdCjCde6M2ULSae/opQ9DTfOXDMmbAa
         P+6LBTDdLGVRv5jOg/iz4bxV7IlENeLPwn7ylPWsm51mAwmjnoIsREm8CaqozryOClR0
         KNJ4Xcyi+JNTc4nXU8Coc6tODlMLmMSrhyKFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=RNYkwlzjSBs38E+/5XUZn4xEpIcCbwJSOmIImzP0KC4=;
        b=Mjs9R6ltp5NtiRMTQ1zFaKeChWr7ATI1PG8JhFFypT18dccdX6UE8UPN4OaAPkZDoH
         6ZGNOcLpCC7IVK9MIpA0e2tA/BaseL/0KbxKjGVUnQGSnIF8BZUL47T8I7FekhP334By
         J6Poe7XYu0BDtdrYu47jdnCVQ1LSG3PuwkziFWoUL8bOW8ZN+7PHVKupKnvrj0WJmHFw
         +vZ63nNVgs7qGe5OU1SieDZqLtjqAnaBB8uJaTCcZuVJeZR47fMfOFoA/Ki9CtB8rLL5
         BEQNROjkjKaSsiqWxKtw7hbwLAdVuN1w7YwRBMWSHWEVZrMKx1cBGfGVB/9txwryBMbR
         /VFQ==
X-Gm-Message-State: ACrzQf1VNGhVKNE1mYwqctCYSyjKQVR6jB/RDbtvItO9aQCmmshv/G1z
        wUDkaC4uJeP+YIlAEN/z4TpbGuFfZoK/Rw==
X-Google-Smtp-Source: AMsMyM6ZxFMTWH+Q/hYd1s+ysnB1REHt+ikv4/vxmEOS5NhGCJ8beHDhzR23jJnwlXc0Cp6hLuLvgg==
X-Received: by 2002:a05:6870:3288:b0:131:c12e:8f3b with SMTP id q8-20020a056870328800b00131c12e8f3bmr97696oac.171.1664382660428;
        Wed, 28 Sep 2022 09:31:00 -0700 (PDT)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com. [209.85.160.47])
        by smtp.gmail.com with ESMTPSA id 93-20020a9d0be6000000b0063ed39d585esm2323637oth.45.2022.09.28.09.31.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 09:31:00 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-11e9a7135easo17948727fac.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:31:00 -0700 (PDT)
X-Received: by 2002:a05:6870:c0c9:b0:127:c4df:5b50 with SMTP id
 e9-20020a056870c0c900b00127c4df5b50mr5762894oad.126.1664382162560; Wed, 28
 Sep 2022 09:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220926195931.2497968-1-shakeelb@google.com>
In-Reply-To: <20220926195931.2497968-1-shakeelb@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Sep 2022 09:22:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2DnK9RAJXJnrSa7WQdKhTXiHNoawCUcxGjk8TdCtJcw@mail.gmail.com>
Message-ID: <CAHk-=wj2DnK9RAJXJnrSa7WQdKhTXiHNoawCUcxGjk8TdCtJcw@mail.gmail.com>
Subject: Re: [PATCH] Revert "net: set proper memcg for net_init hooks allocations"
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Anatoly Pugachev <matorola@gmail.com>,
        Vasily Averin <vvs@openvz.org>,
        Jakub Kicinski <kuba@kernel.org>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 1:00 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> This reverts commit 1d0403d20f6c281cb3d14c5f1db5317caeec48e9.
>
> Anatoly Pugachev reported that the commit 1d0403d20f6c ("net: set proper
> memcg for net_init hooks allocations") is somehow causing the sparc64
> VMs failed to boot and the VMs boot fine with that patch reverted. So,
> revert the patch for now and later we can debug the issue.

Just FYI for the involved people - I've noq applied this directly to my tree.

                 Linus
