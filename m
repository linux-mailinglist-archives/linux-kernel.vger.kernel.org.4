Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8B76E3D89
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 04:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjDQCo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 22:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDQCow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 22:44:52 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8FD2D74
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 19:44:51 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id y6so23068280plp.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 19:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681699491; x=1684291491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5BW9mUGbE4CjcE5YLGMl/RAMUggg+307btqnvGXyK7k=;
        b=kuRByPl6WakkokDKUuQi2G8ok9eGSNerVlAC2Ntd8FA4oCxGqYUnpDuDiDmXkLSWjm
         53J0l43hDgyhKiFMO47jPKr3IgVqiytUuGvkUnI8T6PoGwhIJ5fZ9f9Ht13ox6GT2dcb
         pxFNC8JxerHwXuG4U0BpfIaRZKPHgK7kSWeJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681699491; x=1684291491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BW9mUGbE4CjcE5YLGMl/RAMUggg+307btqnvGXyK7k=;
        b=NFbN7QmrQeZfqSVqKGGWvcEmCgwWu8rTSjX8NPNSuhSO+pQbSO7JRX487oXKk3lUKA
         63i9oZS+FJVSxDmlnxGwFGrByecT+EmzMCGPTh9B0CYZSPtQ8sXkhENOysmq7D3JXlra
         p1cyYhvQgL8mMs3uWcKn9uKrusM3JP6oSsVBoV/Rf7XV/AXm+0iiNZZQg8oEcE8xBpQY
         FhQl7zKB1u6xIoPxpScBjHESUodXS4InXuVWpUvsDCjITE/1znMHjEmHzqqQo5rZJuUm
         rrV1H86DzcPEpFoZ41nFKuZ3gX7oR99jE+DO8R1Ca3e36J/SDby/f77D2+XBI6qe4rSC
         HVMA==
X-Gm-Message-State: AAQBX9eIEi5v7qOmMCj5cwFqg2ekGuKstLMMbkmkuJ74b5fJhYk6cEt0
        Q1BB7lPYXJ4i4F8UG2UVDMnuIdGQ2KhVUPaHQzw=
X-Google-Smtp-Source: AKy350Y2YySI9UdnGoVY7WmBo02qeEtux7soZEnOezCIW99T/kUw/VVxPotquhtNxyUVOxE0ixEELg==
X-Received: by 2002:a17:902:e88c:b0:19e:f315:98d with SMTP id w12-20020a170902e88c00b0019ef315098dmr13179576plg.43.1681699491429;
        Sun, 16 Apr 2023 19:44:51 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id ja3-20020a170902efc300b001a65258011bsm6458214plb.26.2023.04.16.19.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 19:44:50 -0700 (PDT)
Date:   Mon, 17 Apr 2023 11:44:46 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv4 0/4] zsmalloc: fine-grained fullness and new compaction
 algorithm
Message-ID: <20230417024446.GL25053@google.com>
References: <20230304034835.2082479-1-senozhatsky@chromium.org>
 <CAOUHufZ6jPLJYeshO8=2TaqXRmpOFuMQ92E9sg-oCh54fkqW7g@mail.gmail.com>
 <20230416151853.GK25053@google.com>
 <CAOUHufZk+dxE8UXWwGzGbX1BYxomD_25u2xoWt3vnoQp4xSZqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOUHufZk+dxE8UXWwGzGbX1BYxomD_25u2xoWt3vnoQp4xSZqw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/04/16 13:27), Yu Zhao wrote:
> > Hi,
> >
> > Did you bisect it down to this series?
> 
> Not exactly -- since this series was the only suspect I had, I cherry
> picked it to v6.3-rc6 and verified it is the culprit.

Can't reproduce it yet. One of the theories is that get_fullness_group()
maybe returns an invalid index, but I don't immediately see how would it
do so.

Is the problem reproducible? Do you run some specific test?
