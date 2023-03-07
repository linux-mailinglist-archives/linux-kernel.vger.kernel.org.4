Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824596AF6E3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 21:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjCGUog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 15:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjCGUod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:44:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847F3968E2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 12:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678221825;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=xZMx0Mf0lXi1lCxudiK/iMoePKdn8lIM16BDosseJjI=;
        b=JOFI+EAVs+bRxlqrWWaarR+cGCpC5hqQ+OUR4JQPZFdMB31iq3EGMOTCVB+eVyIwfyT69R
        U9zg7PTf35PjZK6Z3UlNpzSNzegEQAfE0AZhb53NmkDJfCFZThWpiaD8UNqTQT8+CRymw5
        DPDzQNUzB9NMRMXaTredQ7iXY3xDhgg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543-oZnQjvcmNJSLjUk9bq2VWg-1; Tue, 07 Mar 2023 15:43:42 -0500
X-MC-Unique: oZnQjvcmNJSLjUk9bq2VWg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29D0E385F36A;
        Tue,  7 Mar 2023 20:43:41 +0000 (UTC)
Received: from tucnak.zalov.cz (unknown [10.39.192.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BF42040C10FA;
        Tue,  7 Mar 2023 20:43:40 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.17.1/8.17.1) with ESMTPS id 327KhZE72668468
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 21:43:36 +0100
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.17.1/8.17.1/Submit) id 327KhVQT2668467;
        Tue, 7 Mar 2023 21:43:31 +0100
Date:   Tue, 7 Mar 2023 21:43:30 +0100
From:   Jakub Jelinek <jakub@redhat.com>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com,
        reinette.chatre@intel.com, fenghua.yu@intel.com,
        peternewman@google.com, james.morse@arm.com, babu.moger@amd.com,
        ananth.narayan@amd.com, vschneid@redhat.com,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-toolchains@vger.kernel.org
Subject: Re: [PATCH] x86/resctrl: avoid compiler optimization in
 __resctrl_sched_in
Message-ID: <ZAeh8g0nr3IFRSVI@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20230303231133.1486085-1-eranian@google.com>
 <20230306120106.GE1267364@hirez.programming.kicks-ass.net>
 <CAKwvOdnRvd5KK01awAyeyt5S36TPPW4_8Z6YL1r4gB-pBrHTbg@mail.gmail.com>
 <20230307113545.GB2017917@hirez.programming.kicks-ass.net>
 <20230307184315.GS25951@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307184315.GS25951@gate.crashing.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 12:43:16PM -0600, Segher Boessenkool wrote:
> On Tue, Mar 07, 2023 at 12:35:45PM +0100, Peter Zijlstra wrote:
> > So per that summary, I'm going to nit-pick and state we very much want
> > CSE. CSE good. What we don't want it violating store-load ordering.
> 
> So you need to describe exactly what you *do* want.  There is no way to
> forbid most otherwise valid things.  But you can express pretty much all
> dependencies.
> 
> > Oh, geez, what a twisty tale that... So Linus knew back in '09 that "p"
> > was icky, but it sorta was the only thing and it 'worked' -- until now
> > :/
> 
> The "p" constraint is just like any other address_constraint, in most
> aspects.  Since this is very specific to "p", that limits what is going
> on to really just one thing.

Are we actually talking here about "p" constraint or about p/P (x86) modifiers
(asm ("%p0" : : "i" (42));)?

	Jakub

