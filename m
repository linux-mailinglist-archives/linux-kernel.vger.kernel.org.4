Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80036699892
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 16:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjBPPRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 10:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjBPPR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 10:17:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8D64D60F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 07:17:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2F8CB824EE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 15:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AA1C4339B;
        Thu, 16 Feb 2023 15:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676560644;
        bh=o7oNEOhWP2srNW6OJPdkZ0zsCNFAkePZ5wbwbnYQX7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VMt9wVxmQVm1Ankvw9ayTEHxSECKaIQygmOKBL1NEG1jfe65+dHmtjKVRINhhMiYd
         kYjb3zHJzqtxlQ3hXK5iRsuIl4rX0rBQBFAX/OZEvFvKkEr/WH/GjI6WHANasF36a2
         BLJU8eJDo0D3zbFAmlUrQWn7hPkbKN+JjxUPWV0eFQHiHI3QtQNjiVXJR/5F01XWZp
         SJfnmdmj6M8rllvVnO4NLSDCXFd+wyjSPoYJIZy0OVqpyR+nFFBD2E00kuxzVcf5yu
         kF7r76g3C/pV9YohnE+w+792ifG2xzY9M4zsr67xkkf4AblSn9/EqrtAqL64NwExTh
         ZuKH+IIPfd7rA==
Date:   Thu, 16 Feb 2023 15:17:19 +0000
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Janne Grunau <j@jannau.net>, linux-arm-kernel@lists.infradead.org,
        asahi@lists.linux.dev, ecurtin@redhat.com, lina@asahilina.net,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        ravi.bangoria@amd.com
Subject: Re: [PATCH 1/2] arm_pmu: fix event CPU filtering
Message-ID: <20230216151718.GA21275@willie-the-truck>
References: <20230216141240.3833272-1-mark.rutland@arm.com>
 <20230216141240.3833272-2-mark.rutland@arm.com>
 <20230216143519.GI17933@jannau.net>
 <Y+5IByR9RelBDm2+@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+5IByR9RelBDm2+@FVFF77S0Q05N.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 03:13:11PM +0000, Mark Rutland wrote:
> On Thu, Feb 16, 2023 at 03:35:19PM +0100, Janne Grunau wrote:
> > On 2023-02-16 14:12:38 +0000, Mark Rutland wrote:
> > > Fix the CPU filtering by performing this consistently in
> > > armpmu_filter(), and remove the redundant arm_pmu::filter() callback and
> > > armv8pmu_filter() implementation.
> > > 
> > > Commit bd2756811766 also silently removed the CHAIN event filtering from
> > > armv8pmu_filter(), which will be addressed by a separate patch without
> > > using the filter callback.
> 
> [...]
> 
> > This works as well. I limited the patch to the minimal fix this                                                   
> > this late in the cycle.
> 
> I did appreciate that you'd made the effort for the minimal fix; had the issue
> with CHAIN events not existed I would have acked that as-is and done the
> simplification later. Given the CHAIN issue and given the simplification make
> the code "obviously correct" I think it's preferable to do both bits now.
> 
> > Tested-by: Janne Grunau <j@jannau.net>
> 
> Thanks!
> 
> Hopefully Will or Peter can pick this up shortly; I'm assuming that Will can
> take this via the arm64 tree.

I'll grab 'em.

Will
