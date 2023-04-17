Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49FE6E5589
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 01:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjDQX7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 19:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjDQX7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 19:59:02 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20454EC2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 16:59:00 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id sj1-20020a17090b2d8100b00247bd1a66d4so2026118pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 16:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681775940; x=1684367940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RITZpfJt2wLFaKEtLmKDqjHQz+u5pMX2rxMOSSEHGY4=;
        b=eV+wV0fE9fa5MwcZz3jX1qGVEUvr0bjd3uTCoFpCYZeK+6YZZpqEXVmSyY5elgt4h9
         tQhjfoATVFX1GrjYBihNUFPCqa0H8wIvXDCW0Fr/ppaYUAY+QJBbtDcIPRAiPzLs27V5
         KsxTwW4kKKHvgC2u9QxKxi03MaOOA0coCGpxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681775940; x=1684367940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RITZpfJt2wLFaKEtLmKDqjHQz+u5pMX2rxMOSSEHGY4=;
        b=KgzTuDI9ZqpoDaTDxqiHu28uihL49ygPD0px5TQXlZ3pQDRuTUT1RuzR7Eyp6FXmgQ
         Hl+JuZEbdAlN2fXC3hPJ8N5txm6F/KLWLmMaRew8zwzMu14eOj/ez/x9Ke2XLXtHMSwS
         jkx0p3PlN25gDxWPGOUeoXQkz/nGFVeIY/GXheTiBTVMwYgRjiwBKOVrpYMevppmWrdL
         4gBYmIOcdHP0aNufZiPmd7b1F58gdUxlnTDq8jO/R+N5wyWMheV/DhpxVFha4cAX00Yg
         E88R461kihtXxcdOz6dQUcOBx6ojKXc6aFlLHE9EQTj87OaAPQN7JUAMDCHhIXtqIdty
         Vt8A==
X-Gm-Message-State: AAQBX9dmJA+xq+hxFpAdJnSCSby1YJi3uxnY/Ay5AAbp58YpQtGL0/lT
        Gd9kBUCd3u85DL4aH7hgVjb3I4YOEDApM1Tw4sU=
X-Google-Smtp-Source: AKy350ZDxGjkza/NUyha2Thb5Pzfe1zhquy2390TvypFPir0Sup4XTpiK7+NpSf9eMXus+V8Wer5hg==
X-Received: by 2002:a05:6a20:1790:b0:dd:cae3:641c with SMTP id bl16-20020a056a20179000b000ddcae3641cmr12691896pzb.55.1681775940331;
        Mon, 17 Apr 2023 16:59:00 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id y23-20020a63fa17000000b0051b93103665sm4218792pgh.63.2023.04.17.16.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 16:58:59 -0700 (PDT)
Date:   Tue, 18 Apr 2023 08:58:55 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2] zsmalloc: allow only one active pool compaction context
Message-ID: <20230417235855.GR25053@google.com>
References: <20230417135420.1836741-1-senozhatsky@chromium.org>
 <CAJD7tkbENFJ3YVrt9fs7AzHVfN+9oCA_4j+9qnpJHrFVEjqhug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkbENFJ3YVrt9fs7AzHVfN+9oCA_4j+9qnpJHrFVEjqhug@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/04/17 11:32), Yosry Ahmed wrote:
> > /proc/lock-stat after make -j$((`nproc`+1)) linux kernel for
> > &pool->lock#3:
> >
> >                 Base           Patched
> > ------------------------------------------
> > con-bounces     2035730        1540066
> > contentions     2343871        1774348
> > waittime-min    0.10           0.10
> > waittime-max    4004216.24     2745.22
> > waittime-total  101334168.29   67865414.91
> > waittime-avg    43.23          38.25
> > acq-bounces     2895765        2186745
> > acquisitions    6247686        5136943
> > holdtime-min    0.07           0.07
> > holdtime-max    2605507.97     482439.16
> > holdtime-total  9998599.59     5107151.01
> > holdtime-avg    1.60           0.99
> 
> The numbers seem to be better when using an atomic vs. a mutex, is
> this just noise or significant difference? (I am not familiar with
> lock-stat).

Pretty sure that's just noise. The test is make -j72 on a system
that swaps out, so it's terribly noisy.
