Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF5B6E9BBA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 20:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjDTSfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 14:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjDTSfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 14:35:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8371D524B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 11:34:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECCDD64B31
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 18:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28153C433EF;
        Thu, 20 Apr 2023 18:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682015593;
        bh=xQM+kO6WzR87nsdtVYHF5RzYM99P3AAbto6Xn+55Cso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k2UNPLHud3Ws0VXopWc5Odx+SHCHFnK/OT3OllLca95IvNweo+ofD4/FBDSk2SxIK
         yK5Q6TM8E4t1q+vINIIbRnsu9cDCujFFWjPwnNqFOroN22Qp6vDvOTavG5PtJdQAOn
         HKboagGIVHA1FsTP2NfXx5ZYBaHV87RKsiP2ma2q3ZatNWPSQeY6T0/vP4WE4nijaN
         7tuHoi3ZUoPbDlFR2DMwb20xrBHCefdDOwG5htQWYerHHAl1xzYPCrOHarCBvdnJ4C
         2WnHTrrwryJTjJzuSSIHvLyQndKnP3Qlt+2itBSIu9tAgrwrc20d6DTp5CjulZ2dEP
         zzL4EQmCoI86w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A17D5403B5; Thu, 20 Apr 2023 15:33:10 -0300 (-03)
Date:   Thu, 20 Apr 2023 15:33:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        mathieu.poirier@linaro.org, darren@os.amperecomputing.com,
        scott@os.amperecomputing.com, scclevenger@os.amperecomputing.com,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org
Subject: Re: [PATCH] perf cs-etm: Add support for coresight trace for any
 range of CPUs
Message-ID: <ZEGFZmBJSzr/PIgc@kernel.org>
References: <20230419172101.78638-1-gankulkarni@os.amperecomputing.com>
 <d758c5e2-aa32-d829-35ee-a685bdb56f75@arm.com>
 <84eb3363-2ef8-d3f1-4613-805959dbf334@os.amperecomputing.com>
 <91ba66e7-737f-6526-a703-a755e114f9d4@arm.com>
 <dea08376-e66b-bacc-7673-c79fe2a8f889@os.amperecomputing.com>
 <902dea0e-456b-d763-fdb5-a520ea3d7536@arm.com>
 <53132776-c998-a24f-a811-d8fb2e5e6535@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53132776-c998-a24f-a811-d8fb2e5e6535@arm.com>
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

Em Thu, Apr 20, 2023 at 04:44:21PM +0100, James Clark escreveu:
> On 20/04/2023 14:03, Suzuki K Poulose wrote:
> > On 20/04/2023 13:37, Ganapatrao Kulkarni wrote:
> >> On 20-04-2023 06:00 pm, James Clark wrote:
> >>> On 20/04/2023 12:47, Ganapatrao Kulkarni wrote:
> >>>> My patch is rebased on 6.3-RC7 codebase with Mike's 3 perf patches
> >>>> related to dynamic id [1] support(queued for 6.4).

> >>>> "perf report -D" works for me.

> >>> I was referring to sparse CPU lists, which I think you mentioned above
> >>> doesn't work even with this patch.

> >>>> [1] https://www.spinics.net/lists/linux-perf-users/msg27452.html

> >>> It should be based on the next branch here:
> >>> git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git

> >> OK.

> > It need not be. Since this patch is purely perf tools patch and has
> > nothing to do with the kernel drivers, it should be beased on whatever
> > the tip of the perf tool tree is. Otherwise we risk rebasing to that
> > eventually.

> Good point, sorry for the confusion!
 
> I wonder if we could have some kind of new staging branch that has both
> up to date perf and coresight changes at the same time? Either that
> would make things like this easier, or more complicated. I'm not sure.
 
> I suppose I can DIY it quite easily but then everyone would have to as well.

My two cents: It this was available together with a CI that would run
'perf test' + 'make -C tools/perf build-test' and any other set of
tests, that would be great.

But not having it also has an advantage: no lockstep development,
tooling should gracefully work with whatever is available.

I say this because it is a really common theme, even Debian had a
packaging scheme that shoehorned (forcefully fused?) perf's and the
kernel's version :-\

- Arnaldo
