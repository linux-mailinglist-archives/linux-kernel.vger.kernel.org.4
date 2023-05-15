Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7670703ED3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244901AbjEOUt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjEOUtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:49:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45A77EDA;
        Mon, 15 May 2023 13:49:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79240624A0;
        Mon, 15 May 2023 20:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD04EC4339B;
        Mon, 15 May 2023 20:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684183762;
        bh=uqZfGT9l3rtQQfCunfjAVcqiCEL6GKIudde5Fwx+3u4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rqif8ilFtUBkKEMRAH25KLmy4I6q2uj7SteexcS2UQoBjvn0+dIPrwS0xJncIgY3k
         p/QAFvF/lvtu1vmB+K3hMIxw7icpilpksHKM56genTXi4Vp13LzxKIGp87aNKGSeaJ
         CYRWxHDD56AKeAdIFCrN1w8xQ5ijlg88nnW7Qir5c0w1u6kjnuywV96qW2smqxQu+Z
         O2u36UoZk3W4XFiqFm6nezHQPlOrHrzoS/+LM2wJhS/8OWsj+oYu4r+r6Nt8W4GyPp
         8DWwJTpgZNXgfmny9Qs1wSblvKENiahEBaqCZ+XAgYqZDOSGFj1flGIlCOELMlxTMC
         oMU/qgrkl8coA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BD99A403B5; Mon, 15 May 2023 17:49:19 -0300 (-03)
Date:   Mon, 15 May 2023 17:49:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: [PATCH v2 0/2] perf doc improvements to man page reproducibility
Message-ID: <ZGKaz/wrobQGJAqk@kernel.org>
References: <ZF/0jJkAOXxzGAMc@decadent.org.uk>
 <CAP-5=fXmL509c2rhE7SYj9FW62eZPc7tPEWzG1h0DztF+Qmnww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXmL509c2rhE7SYj9FW62eZPc7tPEWzG1h0DztF+Qmnww@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 15, 2023 at 07:26:52AM -0700, Ian Rogers escreveu:
> On Sat, May 13, 2023, 1:35 PM Ben Hutchings <ben@decadent.org.uk> wrote:
> 
> > I previously sent a patch in 2016(!) to make the dates in man pages
> > reproducible, with KBUILD_BUILD_TIMESTAMP specifiying the date.  That
> > patch partly overlaps with commit d586ac10ce56 "perf docs: Allow man
> > page date to be specified", which implemented generation of dates
> > based on commit timestamps.
> >
> > However, both of those implementations were specific to the original
> > asciidoc's DocBook backend and had no effect on asciidoctor's direct
> > man page generation.
> >
> > This series builds on the current definition of perf_date, adding
> > support for asciidoctor and the KBUILD_BUILD_TIMESTAMP variable.
> >
> > Ben.
> >
> > Ben Hutchings (2):
> >   perf doc: Define man page date when using asciidoctor
> >   perf doc: Add support for KBUILD_BUILD_TIMESTAMP
> >
> 
> Acked-by: Ian Rogers<irogers@google.com>

Thanks, applied.

- Arnaldo

