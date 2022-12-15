Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91CC64E39D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 23:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiLOWED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 17:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiLOWD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 17:03:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FA8248E3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 14:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671141793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BPKipWOXSyP8E5uQq5bsZzZCMqia+WCVTmajdnr3pN0=;
        b=U9sbdwN/phURgPc14MFFGW/OM39VfOq+6ys2z7IWrxSQJR03lm0OYq9c6snnLRljPeefg2
        ZOplp797Z3ItwA7PVEU9sTZG3rpcI1Jn70o5sk9ZjHc0Fxjhm1tlMSJE7vvtP1rUJvBSCC
        MyKRpcU06JqiC7rudBtqw6Lk28cAp/8=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-94-uj1LpNuXM82DfnBVzgRuYQ-1; Thu, 15 Dec 2022 17:03:11 -0500
X-MC-Unique: uj1LpNuXM82DfnBVzgRuYQ-1
Received: by mail-yb1-f199.google.com with SMTP id y6-20020a25b9c6000000b006c1c6161716so399674ybj.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 14:03:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BPKipWOXSyP8E5uQq5bsZzZCMqia+WCVTmajdnr3pN0=;
        b=XegbD+RyvbaGj5gbp1xEI0VZ3xGDJf5MOV3urigUFCA52Nq8ujW7TWmT3yQhUVeQzB
         1tgADtGZ9c2rFup7LqqROM0ATEXz0ryLbyi+p/6t9ZRvl+Q9Eluz/WEt2TmvSoOYvsfw
         GY3Ll7u+RC5SiG60binhtXAofrmB660JzKzwgAndBfKxR4lf2pjOPe6cxnTSqjcuGzLe
         wgqKcdid+EZ/V0vvsGA4lB+N6gZzxgV/h+aTwNNCZcwaxEOLWGCOMelZ7t7Q93uKdntV
         cjA1xRO4e/8koe60nbE+aVVMs5C1fbeP/O+tD1RTfxjWNbLFpD1ITqq/hyzGaIEsC30E
         Kd6w==
X-Gm-Message-State: AFqh2kqgrvmatXbDJS0G7uimCGSbFIHq34hIFcCHWuTgVhY6nwqcQviy
        ks8MJKN10f//74kL3Rfs6IyMN2uXkqGNZ9l5zPBnDtvkyBSPaeiLm7VtjMFMF69Oe6DkK+GPrlv
        sgoHJZ8asfYy4iVcDYl95xd6ceq6fK5n6qvDiUfIW
X-Received: by 2002:a05:690c:b89:b0:3d7:66df:9b62 with SMTP id ck9-20020a05690c0b8900b003d766df9b62mr416823ywb.133.1671141790974;
        Thu, 15 Dec 2022 14:03:10 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvRzSEPBaBgu+lJoSwm3w6Biagapn8KFVa3XKSPikZdwWEZUIarQmDfP54zT4H9lanCQ/5IaDmz8Cwg446vXFA=
X-Received: by 2002:a05:690c:b89:b0:3d7:66df:9b62 with SMTP id
 ck9-20020a05690c0b8900b003d766df9b62mr416819ywb.133.1671141790717; Thu, 15
 Dec 2022 14:03:10 -0800 (PST)
MIME-Version: 1.0
References: <20221213234505.173468-1-npache@redhat.com> <Y5oCD0gFV+Cq1JqJ@casper.infradead.org>
 <CAA1CXcA2dGeG2tzc+-OZ77eMVpnSN2SKkdtz9LqpLPywhJMOwA@mail.gmail.com>
 <CAA1CXcCboCaVNgLv56Pc9ju95Yc9cK4XHCQObGPA_fbVZGxtTg@mail.gmail.com> <Y5uV3sS/nb+J+Akx@casper.infradead.org>
In-Reply-To: <Y5uV3sS/nb+J+Akx@casper.infradead.org>
From:   Nico Pache <npache@redhat.com>
Date:   Thu, 15 Dec 2022 15:02:44 -0700
Message-ID: <CAA1CXcBnFrDWsGcGfPj-kjkDXnUN=ZBY1Fgbk9FDSNYx9B_QhQ@mail.gmail.com>
Subject: Re: [RFC V2] mm: add the zero case to page[1].compound_nr in set_compound_order
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, gerald.schaefer@linux.ibm.com,
        Waiman Long <llong@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 2:47 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Dec 15, 2022 at 02:38:28PM -0700, Nico Pache wrote:
> > To expand a little more on the analysis:
> > I computed the latency/throughput between <+24> and <+27> using
> > intel's manual (APPENDIX D):
> >
> > The bitmath solutions shows a total latency of 2.5 with a Throughput of 0.5.
> > The branch solution show a total latency of 4 and throughput of 1.5.
> >
> > Given this is not a tight loop, and the next instruction is requiring
> > the data computed, better (lower) latency is the more ideal situation.
> >
> > Just wanted to add that little piece :)
>
> I appreciate how hard you're working on this, but it really is straining
> at gnats ;-)  For a modern cpu, the most important thing is cache misses
> and avoiding dirtying cachelines.  Cycle counting isn't that important
> when an L3 cache miss takes 2000 (or more) cycles.

Haha yeah I figured so once I saw the results, but I figured I'd share.

We have HPC systems in the TiB of memory so sometimes gnats matter ;p
The 2-3 extra cycles may turn into 2million extra cycles on a 2TiB
system full of THPs-- I guess that's not a significant amount of
cycles either in the grand scheme of things.

Cheers,
-- Nico

>

