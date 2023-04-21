Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE136EADB7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 17:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjDUPIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 11:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbjDUPIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:08:11 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0621026E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:08:10 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-5ef414ce24eso10047636d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1682089689; x=1684681689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x7VjX6mpJ5cFi3m7vM66Dwsbikc4Q0r6RI58qqcJeXI=;
        b=XnnatUxaHtIy69QhahifLFisJ+faKLmFDhsgF5zNfRuXQ9qn+F32eDP9H64JnU4ER3
         SLTJiGggC1hj3852G6VrcmjiJy8XT8n7tN2Cgbp+YZ/zfh3cP7oObkfpQJgkfgJIFgfr
         kSO2i/oI1kMfu2XMhtAYez0HckcymzMVeRsIMHCbKm0x1R5MOrOe/Tht1GXVlyGq9tbG
         pLXmvkDzmcrxTFnjUZu8cxpdiTT00fLwcUsg5Ig4zwEf0tg1vAAkFbY2uch6CB5bd7xB
         aiLzjaCer6p3051dSXWfnW2dMnNFoV5Lst0U2Q1uLMCOvd5J52dxQ9ElPFXmxXsz21XJ
         1spg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682089689; x=1684681689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7VjX6mpJ5cFi3m7vM66Dwsbikc4Q0r6RI58qqcJeXI=;
        b=lqYVAcboGdvZuQzBVG/kYElEJbBje7030rD4wdRsIJhnXVJ0fnw0A9LFExq5gW2RSU
         8PEH8nQi0aBwYQ/iJXg3eiqAlaPEs8W8JV0QHcn4u78T4i3KeNQ7erMwoeWJymgrSE5j
         vn0EUaFfAy7ZGh1dtVRFGKrgbRqu+/jttX+9JtFk83FMdoEjOw43Jp7exRiAfn5JKo4t
         gP5+XTTv09AnGUEwYAaDFDpYshhTAnDa6nGsIOAnkoo83wm8d5p3YzBmOUvBCSsfLjr0
         fs0Gub+EpignMEP5rXKwAL+79duM5gw7z3PyTkmPVvuokB7+MeWQ6Fl5wuxKy+0A+y6n
         JbYg==
X-Gm-Message-State: AAQBX9exKDXfVBIJUdhyJJV6RJxotrD/y9RFGqpSzIrq1TxHweoYPVzo
        lDxurwzB90eZODyleSG34myxqQ==
X-Google-Smtp-Source: AKy350YPHteLRp00Et4PERpGtH87hoCnCwqsQI6zl7gaNxZJUiNmIgA8w2EvGj6RrDSPdk6yI43Aew==
X-Received: by 2002:a05:6214:d4d:b0:5f8:ad2a:fef7 with SMTP id 13-20020a0562140d4d00b005f8ad2afef7mr9673559qvr.32.1682089689353;
        Fri, 21 Apr 2023 08:08:09 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:6f0d])
        by smtp.gmail.com with ESMTPSA id a18-20020a0ce392000000b005dd8b9345aesm1226270qvl.70.2023.04.21.08.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 08:08:08 -0700 (PDT)
Date:   Fri, 21 Apr 2023 11:08:08 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 06/26] mm: page_alloc: consolidate free page
 accounting
Message-ID: <20230421150808.GC320347@cmpxchg.org>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-7-hannes@cmpxchg.org>
 <20230421125453.np6b5hirktkj6ji5@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421125453.np6b5hirktkj6ji5@techsingularity.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 01:54:53PM +0100, Mel Gorman wrote:
> On Tue, Apr 18, 2023 at 03:12:53PM -0400, Johannes Weiner wrote:
> > Free page accounting currently happens a bit too high up the call
> > stack, where it has to deal with guard pages, compaction capturing,
> > block stealing and even page isolation. This is subtle and fragile,
> > and makes it difficult to hack on the code.
> > 
> > Push the accounting down to where pages enter and leave the physical
> > freelists, where all these higher-level exceptions are of no concern.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> I didn't look too closely at this one as I'm scanning through to see how
> the overall series works and this is mostly a mechanical patch.
> However, it definitely breaks build
> 
> > @@ -843,7 +843,7 @@ static int __init debug_guardpage_minorder_setup(char *buf)
> >  early_param("debug_guardpage_minorder", debug_guardpage_minorder_setup);
> >  
> >  static inline bool set_page_guard(struct zone *zone, struct page *page,
> > -				unsigned int order, int migratetype)
> > +				  unsigned int order
> >  {
> >  	if (!debug_guardpage_enabled())
> >  		return false;

Oops, this is under a config I didn't test. Will fix. Thanks.

