Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB3C6EAE19
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 17:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjDUPfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 11:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjDUPfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:35:05 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1457040D8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:35:04 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-5ef51c44141so10237206d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1682091303; x=1684683303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AIwc2EwMoi2Tn8izgV4+Oz6B5LB65bXuCsFCTBVkivA=;
        b=p46jR/2aVJ2uuWmw/MXDI1Bw0f8UBaTgoMrk4pt6iKCrL9SVUq8FNMpvaMf/q8MVmg
         HNw0sTRu87WY3YOHQ98z/CBUOc2QtL0XQBD9EskNE3OIoIh+cpLEsHtZI0yEObQDFBhj
         5f4+3re4Y4n6ztZ6B0XBnRhHyIQ/0a8c0mj2D3VymBJMxJJRNBQm7II5R7mILjp/5wgo
         AjZJ6WoIXS7D3kqqKI6sEnDtQHuLulHE1790VNTugUTainUef9mdTzSBM0mF2l4+J4Tr
         RDeu6ernIEcm2e3aijuIrwuybZgRywzldQ6kAPGIOgMAGKQJ4SREXTL8Gb7Q69C1XewD
         NNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682091303; x=1684683303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIwc2EwMoi2Tn8izgV4+Oz6B5LB65bXuCsFCTBVkivA=;
        b=QAs+6mL0hbTkN2SjByC48Et+p8ffb1PZglcc44xKMuTxwxsjQy79tQuzt2kimSbuqN
         NhIdOLpvW0Ov9QXVDwx2z3hLyZv/Q4aDfaTChKFuFToUAkY13p4UKgVVI61Dp6VkfX2I
         qLvWskG4XSLPhzv0BwWuwOZz8eFv1rXH8XI1pFOV4yTSaqCsdePcf2xUr1hqVHGCAuhc
         CDZzzO2PMz0VXNksPa11VTva0wCneij5MFhurBo/by+lbS0uk55j9mo/eeMrmfxHF3Ra
         AhXN0uwIpfxXz27I6+qwF3XdfmwRoMQ3L8hbGhsP8iZQZB+1AVnhkdr0jPeVYpZnAi30
         VXrw==
X-Gm-Message-State: AAQBX9eAs3UtfnCFmd8jq9VyAXlDyzMKsQgZv8Oe9sFdugekk+h9mKSx
        s8Kq562jsUE72MTT09YTQvWBcSm+Bug6pPjgPFs=
X-Google-Smtp-Source: AKy350ZwdA+v1rN8c74PIN9+mxpgKKx34vtCEgUKJxx7MVUc0wFWqwCTLswvulkzoZyCh1F2bg589Q==
X-Received: by 2002:a05:6214:d6e:b0:5ee:2789:15f9 with SMTP id 14-20020a0562140d6e00b005ee278915f9mr11262767qvs.16.1682091302909;
        Fri, 21 Apr 2023 08:35:02 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:6f0d])
        by smtp.gmail.com with ESMTPSA id oj2-20020a056214440200b005ef593385e3sm1249813qvb.1.2023.04.21.08.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 08:35:02 -0700 (PDT)
Date:   Fri, 21 Apr 2023 11:35:01 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 12/26] mm: page_alloc: per-migratetype free counts
Message-ID: <20230421153501.GE320347@cmpxchg.org>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418191313.268131-13-hannes@cmpxchg.org>
 <20230421142841.parju3gmqmpefigq@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421142841.parju3gmqmpefigq@techsingularity.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 03:28:41PM +0100, Mel Gorman wrote:
> On Tue, Apr 18, 2023 at 03:12:59PM -0400, Johannes Weiner wrote:
> > Increase visibility into the defragmentation behavior by tracking and
> > reporting per-migratetype free counters.
> > 
> > Subsequent patches will also use those counters to make more targeted
> > reclaim/compaction decisions.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Visibility into fragmentation behaviour is information that is
> almost certainly only useful to a developer and even then, there is
> /proc/pagetypeinfo. At minimum, move this patch to later in the series
> but I'm skeptical about its benefit.

Having them available in the memory dump (OOM, sysrq) was essential
while debugging problems in later patches. For OOMs or lockups,
pagetypeinfo isn't available. It would be useful to have them included
in user reports if any issues pop up.

They're used internally in several places later on, too.

I'll expand on the changelog and move them ahead in the series.

Thanks
