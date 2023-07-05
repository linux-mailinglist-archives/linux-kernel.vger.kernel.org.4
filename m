Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DA07484E3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjGEN27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGEN26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:28:58 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41ABF1719
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 06:28:57 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3a1ebb85f99so5327740b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 06:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688563736; x=1691155736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NpR6o6UngpTjfG4xhlvc/k43Ojwmfmb7RvTInWAKx/A=;
        b=IzKz48eZVZRf0SSZ42e493A33i8LmM0OVazoCU1gSc2Nc1BiNPA1/iLTfvGrFuuqOn
         DCdWg6n0WIs4Aoh/bibBMWLGoJwVVQZlwqa9E2fqLHqf/2cFFfjXn9MciAdLtmrRdc+O
         Rm68J/ItixE4/Y4Npx9Q8A3aYHIvn1ex5DjZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688563736; x=1691155736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpR6o6UngpTjfG4xhlvc/k43Ojwmfmb7RvTInWAKx/A=;
        b=MPlxr5Ib6FSBg/83j6+1uP/EOhUytizcyEaxAmrlMIAdAXnLYzhrGhuP7H5DFAuIVL
         +F9DhTUpEZPPw6ZiahJh0sWjYSRICdAkZEBzWTLPN9uEqECNGB6IeCugoVNZeVu1mE2F
         Ik3eGk/oWarcOV5zx6VHK39Nx7jTBoyAiM2q+TxodFPVTz3ZD4Svf2CqyUG0QaXywY9l
         Mk7NBQmXOF85ob88owTzr7iUTvP0+9aTZnP5ED9LDi3pVlLkKxw95+1qDpqxnnriMUQV
         8bYu57DBBdLfMMk4Y0tcWsg3s1Aex5mfyt1BfXczA2/XkbUGbPEqp7ovPJ8m8qGsqiqV
         J4Zg==
X-Gm-Message-State: ABy/qLaxKXrHsLFFrichdBvKIV0t29OL3hiQVz2jOr9GtK4k8vYnfvYZ
        yJNOrdrgLsWk9nVt8jxbr78ZPg==
X-Google-Smtp-Source: APBJJlEwskeS7PJ5c/IKumSrNExWt3Akj3CfwMxbuBrtNqK+mjNW0fExiV0qWkThqkp2+hfaeG17yA==
X-Received: by 2002:aca:d07:0:b0:3a3:d7da:cb6f with SMTP id 7-20020aca0d07000000b003a3d7dacb6fmr643096oin.2.1688563736626;
        Wed, 05 Jul 2023 06:28:56 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id w29-20020a63161d000000b0052871962579sm17664589pgl.63.2023.07.05.06.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 06:28:56 -0700 (PDT)
Date:   Wed, 5 Jul 2023 22:28:52 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv2 0/3] zsmalloc: small compaction improvements
Message-ID: <20230705132852.GE283328@google.com>
References: <20230624053120.643409-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230624053120.643409-1-senozhatsky@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/06/24 14:12), Sergey Senozhatsky wrote:
> Hi,
> 	A tiny series that can reduce the number of
> find_alloced_obj() invocations (which perform a linear
> scan of sub-page) during compaction. Inspired by Alexey
> Romanov's findings.
> 
> v2:
> -- picked up a patch from Minchan
> 
> Minchan Kim (1):
>   zsmalloc: remove zs_compact_control
> 
> Sergey Senozhatsky (2):
>   zsmalloc: do not scan for allocated objects in empty zspage
>   zsmalloc: move migration destination zspage inuse check

Just for the record,

A synthetic zsmalloc fragmentation+compaction test (100% reproducible)

           num find_tagged_obj() calls     num iterations in find_tagged_obj()

base                 545699                              812899
patch #1             460701                              691821
patch #2             422372                              651372

// lower is better


patch #1 is "zsmalloc: do not scan for allocated objects in empty zspage"
patch #2 is "zsmalloc: move migration destination zspage inuse check"
