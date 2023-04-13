Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3886E1093
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjDMPFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjDMPFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:05:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4099386A9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:05:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 562BE11FB;
        Thu, 13 Apr 2023 08:05:53 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D91603F73F;
        Thu, 13 Apr 2023 08:05:07 -0700 (PDT)
Date:   Thu, 13 Apr 2023 16:05:05 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Radu Rendec <rrendec@redhat.com>, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/3] cacheinfo: Add arm64 early level initializer
 implementation
Message-ID: <20230413150505.75g2dp6ra2ytfvpu@bogus>
References: <20230412185759.755408-1-rrendec@redhat.com>
 <20230412185759.755408-3-rrendec@redhat.com>
 <20230413102226.yzzd6iccqeamheas@bogus>
 <20230413144519.GA26421@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413144519.GA26421@willie-the-truck>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 03:45:22PM +0100, Will Deacon wrote:
> On Thu, Apr 13, 2023 at 11:22:26AM +0100, Sudeep Holla wrote:
> > Hi Will,
> > 
> > On Wed, Apr 12, 2023 at 02:57:58PM -0400, Radu Rendec wrote:
> > > This patch adds an architecture specific early cache level detection
> > > handler for arm64. This is basically the CLIDR_EL1 based detection that
> > > was previously done (only) in init_cache_level().
> > > 
> > > This is part of a patch series that attempts to further the work in
> > > commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU").
> > > Previously, in the absence of any DT/ACPI cache info, architecture
> > > specific cache detection and info allocation for secondary CPUs would
> > > happen in non-preemptible context during early CPU initialization and
> > > trigger a "BUG: sleeping function called from invalid context" splat on
> > > an RT kernel.
> > > 
> > > This patch does not solve the problem completely for RT kernels. It
> > > relies on the assumption that on most systems, the CPUs are symmetrical
> > > and therefore have the same number of cache leaves. The cacheinfo memory
> > > is allocated early (on the primary CPU), relying on the new handler. If
> > > later (when CLIDR_EL1 based detection runs again on the secondary CPU)
> > > the initial assumption proves to be wrong and the CPU has in fact more
> > > leaves, the cacheinfo memory is reallocated, and that still triggers a
> > > splat on an RT kernel.
> > > 
> > > In other words, asymmetrical CPU systems *must* still provide cacheinfo
> > > data in DT/ACPI to avoid the splat on RT kernels (unless secondary CPUs
> > > happen to have less leaves than the primary CPU). But symmetrical CPU
> > > systems (the majority) can now get away without the additional DT/ACPI
> > > data and rely on CLIDR_EL1 based detection.
> > > 
> > 
> > If you are okay with the change, can I have your Acked-by, so that I can
> > route this via Greg's tree ?
> 
> I really dislike the profileration of __weak functions in this file,

You mean in the generic cacheinfo.c right ? Coz arm64 version must not have
any and that is the file in this patch.

> rather than the usual approach of having arch-specific static inlines in
> a header file but it seems that nobody has the appetite to clean that up :(
>

Yes, I will try that when I get sometime. I had not seen or touched this
for longtime until recently when new requirements around this are coming.

> So I'm fine for Greg to queue this if he wants to, but I'd be a lot more
> excited if somebody tidied things up a bit first.
>

Agreed. One reason for such weak functions was to avoid conditional
compilation based on arch at that time with the aim to include couple
of more archs but that hasn't happened and perhaps it is time that it
needs a refresh.

--
Regards,
Sudeep
