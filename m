Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3001A6740AB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 19:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjASSOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 13:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjASSOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:14:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CB89014
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:14:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76AA061D12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 18:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECEFC433D2;
        Thu, 19 Jan 2023 18:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674152089;
        bh=+Uxtzpe7VHpQ7mR6Wx+g+3c+IPli4Rq4BJ29Aw5G0/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PJL0h7cIH/638KpbEtQDe+u9eQZYm4ToJu1EygzO9239GlRdqcl9o0i+zQmO71/hs
         rhqvJGS4WgTFjCFWZ1aoZNDE/GKKkO+jaXUbOxjlHlhoANKmRTa1g9O5Wv0J4sfffJ
         kKxI2K8ECvnd2jxeYXw5zQ5nMa0xYF6ortXEIY9tRfBoxoNyASeH5qO7f/kOtbZHq+
         hMYIRyfCStb/7DKwhOuGWLy6sPxa9M8Tk2JHVNjxYNDFnysxA3SdaxQwBKM/H0n1Qh
         3wT7mMTdseIt0pl3CR6rozeLCo2Vjugyki8s4hMDWxOcJJc38k3MH5djlJCpql+tNT
         lX1TMLvuifKRg==
Date:   Thu, 19 Jan 2023 18:14:44 +0000
From:   Will Deacon <will@kernel.org>
To:     Geoff Blake <blakgeof@amazon.com>, robin.murphy@arm.com
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/arm-cmn: Add shutdown routine
Message-ID: <20230119181444.GA20563@willie-the-truck>
References: <2bb86e97-6cef-700e-70ed-4f303da10fd9@amazon.com>
 <20221215180039.18035-1-blakgeof@amazon.com>
 <ab93909a-2c81-302f-9f85-33cf1a745e74@amazon.com>
 <7071a073-08f5-104b-f10f-e1013d1b5390@arm.com>
 <ed89d1a0-3aac-d8dc-2056-21cb4609e7fb@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed89d1a0-3aac-d8dc-2056-21cb4609e7fb@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 11:10:29AM -0600, Geoff Blake wrote:
> On Thu, 19 Jan 2023, Robin Murphy wrote:
>  
> > If you have a convincing argument that returning IRQ_NONE for unexpected
> > spurious interrupts is a real and important concern, then please propose
> > a general solution, because if it matters for arm-cmn then it matters
> > for hundreds of other drivers too, by rough estimate:
> > 
> > $ git grep -l IRQ_NONE '*.c' | xargs git grep -L IRQF_SHARED | wc -l
> > 834
> 
> The general solution for IRQ_NONE exists in the layer above the 
> driver, it complains with a visible warning that something might be wrong 
> and then moves on. Nothing more is needed.
> 
> Your shutdown routine that flips DT_EN in CMN_DT_DTC_CTL is sufficient, as 
> after some testing it solves the problem with left over IRQs for my kexec 
> use case.  

Please can you two let me know when you've settled on a fix for this? I'm
not going to queue something that you don't both agree on, although it seems
like we're quibbling over details at this point so maybe let's get
_something_ in and then work to improve it later?

Cheers,

Will
