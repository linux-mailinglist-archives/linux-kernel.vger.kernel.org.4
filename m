Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5C6719ADB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjFALUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjFALUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:20:53 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87535123;
        Thu,  1 Jun 2023 04:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jzcx+R+c6UOqzz0gVG07uUa29kOBvr3x5e8X9TFuwcA=; b=oQ8d4cw3GAx07aySlQ39lT4A8H
        prkDbHMJybq15SDspPHtVe9iiG+gfjkElttDpsY8z8UlgWtby1L64wWiDvn4LCC+WTcKHkzU2uCVU
        Il3IG6TJVbBw9F0wcsP4EFmQr1my4e2Wh0UYpw8cam+gBKhpQJY7tpxiPeVWY1yhA82CNY6Fx9I5x
        mM91gUzo12SNrcaM9a68ZIINX0H2/ZLb74OaH9RebDzycs3fze5p/lWol2AQOXOyvokCXPilqkWa5
        +nhi4EoTnMscy882WT5oR/Y5l8hR6D2t88nbMSI93A02rL9M7UpKAB5iPK226BszP0ZiYxjDrPS8Q
        i7+Eq3vg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4gM0-00H940-1R;
        Thu, 01 Jun 2023 11:20:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 34D6630031F;
        Thu,  1 Jun 2023 13:20:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2450C202BDCB6; Thu,  1 Jun 2023 13:20:27 +0200 (CEST)
Date:   Thu, 1 Jun 2023 13:20:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     Ian Rogers <irogers@google.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Nathan Chancellor <nathan@kernel.org>, namhyung@kernel.org,
        eranian@google.com, acme@kernel.org, mark.rutland@arm.com,
        jolsa@kernel.org, bp@alien8.de, kan.liang@linux.intel.com,
        adrian.hunter@intel.com, maddy@linux.ibm.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com, kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 3/4] perf/core: Remove pmu linear searching code
Message-ID: <20230601112027.GI38236@hirez.programming.kicks-ass.net>
References: <CAP-5=fWYbzmTETgqJ11y22=JaXDM0gnb4qR6KYeRGmFXw08f-Q@mail.gmail.com>
 <86jzwtdhmk.wl-maz@kernel.org>
 <CAP-5=fVW6KbUbbEfF3mEFvTfFDC5yKSjSpa+w3D55dG3CNUERw@mail.gmail.com>
 <86h6rxd3gh.wl-maz@kernel.org>
 <0075d8a9-2df4-86eb-8171-8995f59904e0@linux.ibm.com>
 <CAP-5=fXo0t+buDrmf7SyTD97gmTWGoDAO2YXWyav+_79O3MZ0w@mail.gmail.com>
 <a1f27798-0b06-7dc3-028b-038512947306@linux.ibm.com>
 <CAP-5=fVw3vSEu7yGFDnZi8c3VUFJu_XEZtY9ZcTsD7ip2imR6Q@mail.gmail.com>
 <aa2f8581-6440-87c0-1578-157719f7543e@linux.ibm.com>
 <20230601111856.GW4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601111856.GW4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 01:18:56PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 01, 2023 at 01:02:30PM +0200, Thomas Richter wrote:
> 
> > PS: I have the feeling, it gets complicated to have multiple hardware PMUs
> > per platform.
> 
> Recently someone was poking around giving the pmu device a parent, this
> would, I think, result in sysfs links, which could be used to decide
> what's what.
> 
> Core pmus would have the CPU device as their parent, while memory
> controller thingies would link to the relevant node or something.
> 
> Ofc. all that's future-work/pending.

https://lkml.kernel.org/r/20230404134225.13408-1-Jonathan.Cameron%40huawei.com

https://lkml.kernel.org/r/20230531110011.13963-2-Jonathan.Cameron%40huawei.com
