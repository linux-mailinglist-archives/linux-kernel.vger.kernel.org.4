Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B87D670D0B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjAQXQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjAQXNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:13:47 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E8C305DC
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:01:23 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id p24so34788454plw.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oik7f+Obtqb9oYcFCZxNF6kU7CTToRcYlL6LRTQBU44=;
        b=ZObfXX2Gb1HxVqeXxJx1k/YW5m5gwg1cpLLrVlMJ2+pTnSXrvA7vpoSoraw63QCidF
         ATflzj3vD699uzgaDMpc+H5Stx+Bk1CmS3m7ZxtMsPPnw4BGlICH2lsHbYAnib5mUN/D
         s/ib+uqIP792gG7o0TE2rd/ahd1agJ7UZwsJ8xTirF7G7tA6AuYHgellrnCR5ABCgRgQ
         UVN9t+QVyXJQI13PC63B0MxKm1FvAs1g7ATiJfiOfgo6PhSo3Z86PVs/uxt+7Cdw+pv0
         4XZk1v9hL8f/zUdMR+0AT4qMWskyZZTC/WTkOEYcwPg68EqucSCcC/TaMIPSUNkoVGDH
         v/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oik7f+Obtqb9oYcFCZxNF6kU7CTToRcYlL6LRTQBU44=;
        b=49HsjKy4wgQ+PYMswm63g7TdHll+Xnw5V431d481qo/mNblcATSailbsbNyxeFLfpn
         F4SdNCJNpLIAwIFhDvPA368lXlM8YMaa/2AsyGmodN5j6yWPl2RzbqG+llk8AMH/9BoD
         PpUIqV1Va/Iq1Au/R/meVMCSFAufDtnYTHDJf8e441KMbiP5htlsrDJHJW97pW7yvGJD
         aG/sCyqr+yipGbYW/TdKFPryPrSWjswgslKeOjV7qPAbOlMgEx+xNuwzrl2YhKgindJQ
         X1dL1jrxECN0H9gR+SrUXeeSwVuZmeHMaMGorOhqS9tA4HCzqBs0pd6CGIxnvXh9nV2v
         0hWA==
X-Gm-Message-State: AFqh2krEsaDhjO8/bsLhrhuwVYIrKQ8aJ+6WRGGa5WrVo9nUhS6k2l/8
        /X3qh+sY2MHzthmELmmB3ZPrTA==
X-Google-Smtp-Source: AMrXdXuhF09L1YSr6t9q2XBspLKlA69sK9BoqznjJjzvbl1iIrMmIFqZtvr7VXKd6/UbaIerQX9lig==
X-Received: by 2002:a05:6a21:33a1:b0:ac:af5c:2970 with SMTP id yy33-20020a056a2133a100b000acaf5c2970mr2853170pzb.3.1673989282322;
        Tue, 17 Jan 2023 13:01:22 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902ecca00b00189a7fbfd44sm21521000plh.211.2023.01.17.13.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 13:01:21 -0800 (PST)
Date:   Tue, 17 Jan 2023 21:01:18 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Zhi Wang <zhi.wang.linux@gmail.com>
Cc:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v11 018/113] KVM: TDX: create/destroy VM structure
Message-ID: <Y8cMnjHFNIFaoX27@google.com>
References: <cover.1673539699.git.isaku.yamahata@intel.com>
 <68fa413e61d7471657174bc7c83bde5c842e251f.1673539699.git.isaku.yamahata@intel.com>
 <20230113151258.00006a6d@gmail.com>
 <Y8F1uPsW56fVdhmC@google.com>
 <20230114111621.00001840@gmail.com>
 <Y8bFCb+rs25dKcMY@google.com>
 <20230117214414.00003229@gmail.com>
 <Y8cLcY12zDWqO8nd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8cLcY12zDWqO8nd@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023, Sean Christopherson wrote:
> On Tue, Jan 17, 2023, Zhi Wang wrote:
> > 2) As TDX module doesn't provide contention-and-wait, I guess the following
> > approach might have been discussed when designing this "retry".
> > 
> > KERNEL                          TDX MODULE
> > 
> > SEAMCALL A   ->                 PATH A: Taking locks
> > 
> > SEAMCALL B   ->                 PATH B: Contention on a lock
> > 
> >              <-                 Return "operand busy"
> > 
> > SEAMCALL B   -|
> >               |  <- Wait on a kernel waitqueue
> > SEAMCALL B  <-|
> > 
> > SEAMCALL A   <-                 PATH A: Return
> > 
> > SEAMCALL A   -|
> >               |  <- Wake up the waitqueue
> > SEMACALL A  <-| 
> > 
> > SEAMCALL B  ->                  PATH B: Taking the locks
> > ...
> > 
> > Why not this scheme wasn't chosen?
> 
> AFAIK, I don't think a waitqueue approach as ever been discussed publicly.  Intel
> may have considered the idea internally, but I don't recall anything being proposed
> publically (though it's entirely possible I just missed the discussion).
> 
> Anways, I don't think a waitqueue would be a good fit, at least not for S-EPT
> management, which AFAICT is the only scenario where KVM does the arbitrary "retry
> X times and hope things work".  If the contention occurs due to the TDX Module
> taking an S-EPT lock in VM-Enter, then KVM won't get a chance to do the "Wake up
> the waitqueue" action until the next VM-Exit, which IIUC is well after the TDX
> Module drops the S-EPT lock.  In other words, immediately retrying and then punting
> the problem further up the stack in KVM does seem to be the least awful "solution"
> if there's contention.

Oh, the other important piece I forgot to mention is that dropping mmu_lock deep
in KVM's MMU in order to wait isn't always an option.  Most flows would play nice
with dropping mmu_lock and sleeping, but some paths, e.g. from the mmu_notifier,
(conditionally) disallow sleeping.
