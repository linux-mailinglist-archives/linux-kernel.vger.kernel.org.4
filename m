Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D39973122B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244077AbjFOIai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240677AbjFOIaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:30:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587631A3;
        Thu, 15 Jun 2023 01:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=8140F8ZxyIF8h0Y78lNADZ9yCgB7dr+4A7JOaUUAgcI=; b=Z8nk6srOke/jCJkziNLpMv2I9u
        hHlVHMipg7fqtKw/YA95q37ZJ9hb+MhkbXSdrIYQ+xbTBgyfbFZ8gOioQ68s0WXI3LHo8Xjrcr+Pm
        q5gyt066R88L/KOGdVYPWOA1PtL4/Lb+KhevAYmURmQosYXhA+mIbsM1uyV+4GxCcSHhXf/v8AhD1
        FYa0vpuQOE4KNZffr0Rp8N465wJ+nVkAOVFYYNd8sam5MQkAQ2awILHwCIywcfzpqaxjYQNA6TD06
        ekv386ndhr/dKt59ZiN565unKidOoXogHO2oL80v/afKfDz7eZe3iINNF/mFbbXO1yZYyeEUzV/pX
        +HhcwzCQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q9iMc-00BkWh-0K;
        Thu, 15 Jun 2023 08:29:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5D116300208;
        Thu, 15 Jun 2023 10:29:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3679B2456F421; Thu, 15 Jun 2023 10:29:49 +0200 (CEST)
Date:   Thu, 15 Jun 2023 10:29:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Wilczynski, Michal" <michal.wilczynski@intel.com>,
        alison.schofield@intel.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mike Rapoport <rppt@kernel.org>, x86@kernel.org,
        linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derick Marks <derick.w.marks@intel.com>
Subject: Re: [PATCH v2 1/2] x86/numa: Introduce numa_fill_memblks()
Message-ID: <20230615082949.GA1683497@hirez.programming.kicks-ass.net>
References: <cover.1686712819.git.alison.schofield@intel.com>
 <9fcc548a6b4727cb2538e5227d7bad2e94e6adaf.1686712819.git.alison.schofield@intel.com>
 <03945e1f-caf6-3e5c-babc-d30e4e02b65e@intel.com>
 <6489b23bc67e0_142af829456@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6489b23bc67e0_142af829456@dwillia2-xfh.jf.intel.com.notmuch>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 05:27:39AM -0700, Dan Williams wrote:
> Wilczynski, Michal wrote:
> > On 6/14/2023 6:35 AM, alison.schofield@intel.com wrote:

> > > +static int __init cmp_memblk(const void *a, const void *b)
> > > +{
> > > +	const struct numa_memblk *ma = *(const struct numa_memblk **)a;
> > > +	const struct numa_memblk *mb = *(const struct numa_memblk **)b;
> > 
> > Is this casting necessary  ?
> 
> This is idiomatic for sort() comparison handlers.

Aside of that, it *is* actually required, since sort() does indirect
calls to it's cmp_func_t argument the Control Flow Integrity (CFI, not
to be confused with Call-Frame-Information) stuff has a hard requirement
that function signatures match.

At the very least clang builds should warn if you do indirect calls with
non-matching signatures these days. And kCFI enabled builds will get you
a runtime error if you manage to ignore that warning.

> > > +
> > > +	if (ma->start != mb->start)
> > > +		return (ma->start < mb->start) ? -1 : 1;
> > > +
> > > +	/* Caller handles duplicate start addresses */
> > > +	return 0;
> > > +}


