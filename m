Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47758724B0E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjFFSSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237398AbjFFSSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:18:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49812170A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 11:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KZtFnJ2L9OWzprVfwt3qlf6rELtuXcoaIYQWpeva1OY=; b=crQzr4eVCMC190VCdeHBlFN5aT
        1lHHegjNMKcRAjumU08TXRnyltRquOC1DpG1tDxznqUx8uTnjCPAlMeRed5tr6L97+ZYsCZiGkgX8
        G+Qljeh+Ljr88J/5OEOPu6PNmewdxoGzABn141Kek2fFQG5w77KSpa1KYJCKQn5m2Ev6SphLEn75N
        DIj6O32zMOR0pwbQKOO0oEvF4lgH+d8vQtOvu1zxAaqwnBlLV5GNvByFxoHjE2zCa+EISHn1EITso
        KATSNq7+HgZayM7r5qWXEnwIYxBklCEj+LCkfUsQ5jm0Fd/M8GpG7+es2k53WxlSHF1TKEtNprXsz
        bjWm60Ow==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q6bFm-0049TN-2m;
        Tue, 06 Jun 2023 18:17:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 86F9630026A;
        Tue,  6 Jun 2023 20:17:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4AE3C2019EC65; Tue,  6 Jun 2023 20:17:57 +0200 (CEST)
Date:   Tue, 6 Jun 2023 20:17:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com
Subject: Re: [PATCH V2 1/6] perf/x86/intel: Add Grand Ridge and Sierra Forest
Message-ID: <20230606181757.GB942082@hirez.programming.kicks-ass.net>
References: <20230522113040.2329924-1-kan.liang@linux.intel.com>
 <2b2e7308-edeb-2977-596a-f638d19174d6@linux.intel.com>
 <20230606132432.GD905437@hirez.programming.kicks-ass.net>
 <3c187521-0686-1204-7b3e-e8f183c50938@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c187521-0686-1204-7b3e-e8f183c50938@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 12:16:29PM -0400, Liang, Kan wrote:

> > names for a reason, so that enums like the above become something
> > sensible like:
> > 
> > 	case INTEL_FAM6_ATOM_CRESTMONT:
> > 	case INTEL_FAM6_ATOM_CRESTMONT_X:
> > 
> > and now it's super obvious why they're grouped.
> > 
> >>> +		pr_cont("Crestmont events, ");
> 
> The Sierra Forest should not be a platform name. I think it's the code
> name of the processor.
> 
> The problem is that the uarch name doesn't work for the hybrid, since it
> has different uarchs in the same processors. To make the naming rules
> consistent among big core, atom, and hybrid, maybe we should use the
> code name of the processor in intel-family.h.

I obviously disagree; these are not hybrid and calling them both
CRESTMONT makes *far* more sense than the random gibberish they're
called now.

Yes, hybrid made a complete mess of things (in many ways), but we should
then not do the obvious correct thing for when we can.
