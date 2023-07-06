Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C33974969A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 09:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbjGFHi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 03:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbjGFHis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:38:48 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F180B1FC9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 00:38:33 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-3460770afe2so78365ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 00:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688629113; x=1691221113;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3wp3nIROV9TflcSxrE2jgJnjD70KAFiAFAmondYIM9o=;
        b=pi0wFpf6X/VZ+08PP1Q0vtFiGT/HRzAcVttvm+YOm1EQJGnmEd9pzlrDboY9mitk87
         SPrhjB6f4PmNUY6SmToKx9lmhkM6+jGz/Cxdcl93ITxBZzHXLEDBlpQtqI1wZpQ0hBW6
         wc62RTY6r03WMVr0OLvcbrX2o0VABOb6JLw6Trc30mnvMEo6/SmcTsoy7d0RyZokuhqV
         8NPCjQ6PSobgFIHwqV1zkvFFcR8deNH7SQgi4uPG68T8mIWQvz1mvjbtbMn+pDAIDCim
         nCo9Ywbkd4Ye1HSLU8tKdVyjc1SS5MaxlOzR4KPMy8M+g34AIxyJme0IKQAzgjPjJqa+
         xyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688629113; x=1691221113;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3wp3nIROV9TflcSxrE2jgJnjD70KAFiAFAmondYIM9o=;
        b=kdu0V/buAZswecu6mQVxXraLGIptFLQhh2qxVyBHTupPMhO8hV/qgTZq3wMtX9aj1L
         upVM70P1N+oPQewBBH5j3z9J46nrS1MI4mEXAyuHlz3skWLm00YEA3b3oKcqQ4e6f6Zj
         MURpbcSP0JjZIDfW/A0pX09/V6NeirEH8jo+5nZAPp+mM2uOR2UMYe4gdVcxT47ibrx7
         WG9exuf9SXgFI3R+EGq8WRDcjmTc6BxSkX7+NzsRLfDtu1WZr/3m8ZZiQL4BBI4TwC1E
         Ev1yACcUnUertOIKudl7hPQFMkiKbpu9lyty1B9Tu5zNwVBi4T98cIgMwBLwgZIYSnJn
         h5MA==
X-Gm-Message-State: ABy/qLanBU6tq5wmMiztFc0GuDdVCEGd9tZu/IGXo8byhwt7VWDkLxUZ
        GFviHbft6Wecbiddc5dz/17rLg==
X-Google-Smtp-Source: APBJJlGuOq8c1qAySXCbXUJ4wcUjJsKRJcSRgxSb9ccHR7tXNLCcwrUTKQ9BheOlDBW7sHnn8hr8Ag==
X-Received: by 2002:a05:6e02:12c9:b0:346:8c2:5f92 with SMTP id i9-20020a056e0212c900b0034608c25f92mr70825ilm.19.1688629112865;
        Thu, 06 Jul 2023 00:38:32 -0700 (PDT)
Received: from [2620:0:1008:15:4e6c:6fcc:6706:5cc] ([2620:0:1008:15:4e6c:6fcc:6706:5cc])
        by smtp.gmail.com with ESMTPSA id fe7-20020a056a002f0700b0063f0c9eadc7sm657569pfb.200.2023.07.06.00.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 00:38:32 -0700 (PDT)
Date:   Thu, 6 Jul 2023 00:38:31 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Julian Pidancet <julian.pidancet@oracle.com>
cc:     Christoph Lameter <cl@linux.com>,
        "Lameter, Christopher" <cl@os.amperecomputing.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v2] mm/slub: disable slab merging in the default
 configuration
In-Reply-To: <8813897d-4a52-37a0-fe44-a9157716be9b@google.com>
Message-ID: <17349901-df3a-494e-fa71-2584d92526b5@google.com>
References: <20230629221910.359711-1-julian.pidancet@oracle.com> <38083ed2-333b-e245-44e4-2f355e4f9249@google.com> <CTSGWINSM18Q.3HQ1DN27GNA1R@imme> <8813897d-4a52-37a0-fe44-a9157716be9b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2023, David Rientjes wrote:

> hackbench

Running hackbench on Skylake with v6.1.30 (A) and v6.1.30 + your patch 
(B), for example:

              LABEL             | COUNT |    MIN     |    MAX     |    MEAN    |   MEDIAN   |  STDDEV   |   DIRECTION    
--------------------------------+-------+------------+------------+------------+------------+-----------+----------------
  SReclaimable                  |       |            |            |            |            |           |                
  (A) v6.1.30                   | 11    | 129480.000 | 233208.000 | 189936.364 | 204316.000 | 31465.625 |                
  (B) <same sha>                | 11    | 139084.000 | 236772.000 | 198931.273 | 213672.000 | 30013.204 |                
                                |       | +7.42%     | +1.53%     | +4.74%     | +4.58%     | -4.62%    | <not defined>  
  SUnreclaim                    |       |            |            |            |            |           |                
  (A) v6.1.30                   | 11    | 305400.000 | 538744.000 | 422148.000 | 449344.000 | 65005.045 |                
  (B) <same sha>                | 11    | 305780.000 | 518300.000 | 422219.636 | 450252.000 | 61245.137 |                
                                |       | +0.12%     | -3.79%     | +0.02%     | +0.20%     | -5.78%    | <not defined>  

Amount of reclaimable slab significantly increases which is likely not a 
problem because, well, it's reclaimable.  But I suspect we'll find other 
interesting data points with the other suggested benchmarks.

And benchmark results:

              LABEL             | COUNT |    MIN     |    MAX     |    MEAN    |   MEDIAN   |  STDDEV   |   DIRECTION    
--------------------------------+-------+------------+------------+------------+------------+-----------+----------------
  hackbench_process_pipes_234   |       |            |            |            |            |           |                
  (A) v6.1.30                   | 7     | 1.735      | 1.979      | 1.831      | 1.835      | 0.086291  |                
  (B) <same sha>                | 7     | 1.687      | 2.023      | 1.886      | 1.911      | 0.10276   |                
                                |       | -2.77%     | +2.22%     | +3.00%     | +4.14%     | +19.09%   | <not defined>  
  hackbench_process_pipes_max   |       |            |            |            |            |           |                
  (A) v6.1.30                   | 7     | 1.735      | 1.979      | 1.831      | 1.835      | 0.086291  |                
  (B) <same sha>                | 7     | 1.687      | 2.023      | 1.886      | 1.911      | 0.10276   |                
                                |       | -2.77%     | +2.22%     | +3.00%     | +4.14%     | +19.09%   | - is good      
  hackbench_process_sockets_234 |       |            |            |            |            |           |                
  (A) v6.1.30                   | 7     | 7.883      | 7.909      | 7.899      | 7.899      | 0.0087808 |                
  (B) <same sha>                | 7     | 7.872      | 7.961      | 7.907      | 7.904      | 0.028019  |                
                                |       | -0.14%     | +0.66%     | +0.10%     | +0.06%     | +219.09%  | <not defined>  
  hackbench_process_sockets_max |       |            |            |            |            |           |                
  (A) v6.1.30                   | 7     | 7.883      | 7.909      | 7.899      | 7.899      | 0.0087808 |                
  (B) <same sha>                | 7     | 7.872      | 7.961      | 7.907      | 7.904      | 0.028019  |                
                                |       | -0.14%     | +0.66%     | +0.10%     | +0.06%     | +219.09%  | - is good      
  hackbench_thread_pipes_234    |       |            |            |            |            |           |                
  (A) v6.1.30                   | 7     | 2.146      | 2.677      | 2.410      | 2.418      | 0.18143   |                
  (B) <same sha>                | 7     | 2.016      | 2.514      | 2.268      | 2.241      | 0.17474   |                
                                |       | -6.06%     | -6.09%     | -5.88%     | -7.32%     | -3.69%    | <not defined>  
  hackbench_thread_pipes_max    |       |            |            |            |            |           |                
  (A) v6.1.30                   | 7     | 2.146      | 2.677      | 2.410      | 2.418      | 0.18143   |               
  (B) <same sha>                | 7     | 2.016      | 2.514      | 2.268      | 2.241      | 0.17474   |                
                                |       | -6.06%     | -6.09%     | -5.88%     | -7.32%     | -3.69%    | - is good      
  hackbench_thread_sockets_234  |       |            |            |            |            |           |                
  (A) v6.1.30                   | 7     | 8.025      | 8.127      | 8.084      | 8.085      | 0.029755  |                
  (B) <same sha>                | 7     | 7.990      | 8.093      | 8.042      | 8.035      | 0.035152  |                
                                |       | -0.44%     | -0.42%     | -0.53%     | -0.62%     | +18.14%   | <not defined>  
  hackbench_thread_sockets_max  |       |            |            |            |            |           |                
  (A) v6.1.30                   | 7     | 8.025      | 8.127      | 8.084      | 8.085      | 0.029755  |                
  (B) <same sha>                | 7     | 7.990      | 8.093      | 8.042      | 8.035      | 0.035152  |                
                                |       | -0.44%     | -0.42%     | -0.53%     | -0.62%     | +18.14%   | - is good    
