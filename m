Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55436E63A2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjDRMmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjDRMmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:42:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E94D14440
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:41:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E40C63329
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C55C4339B;
        Tue, 18 Apr 2023 12:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681821715;
        bh=N0aVjDEryHvsJG1EaYORnjTrCWS41XOE62Wonr7Z8Uw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W5qaWaULjN6RRE5/LWN8qHwUEtdLd5gJDhMD+QYU8gScK53VFJwhFcXKAu8u/LdNj
         g3y6mbgI4WfAkWv3lWJ8fwgtqQngM6eg/+DVyRE9cBt5nO14FLa3V19aEpm54G3U+R
         TrKrX2pSngYRla8jomeaolBsoDvtmErHub2NgaAGnCC7JVa/NpdC3sODEoXhdWtIRu
         kxD34u8DRG/XMR6/MvGgIvf+0vLNNNKS4FpUZ/cYTyD7GkhyqTfT2+HfQO6JSLk2bk
         tSz6s8FHmHu9xjpEtQwShal70z8SC8RgZm0dFcnsoxYoypyrJDRqjM1MLJtP2Kw7nR
         DZAuGEsYOXugw==
Date:   Tue, 18 Apr 2023 13:41:49 +0100
From:   Will Deacon <will@kernel.org>
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Quentin Perret <qperret@google.com>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andrew Walbran <qwandor@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 03/12] KVM: arm64: Block unsafe FF-A calls from the host
Message-ID: <20230418124147.GA32435@willie-the-truck>
References: <20221116170335.2341003-1-qperret@google.com>
 <20221116170335.2341003-4-qperret@google.com>
 <Y3UgoIlukWSrT1WY@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3UgoIlukWSrT1WY@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 05:40:48PM +0000, Oliver Upton wrote:
> On Wed, Nov 16, 2022 at 05:03:26PM +0000, Quentin Perret wrote:
> > From: Will Deacon <will@kernel.org>
> > 
> > When KVM is initialised in protected mode, we must take care to filter
> > certain FFA calls from the host kernel so that the integrity of guest
> > and hypervisor memory is maintained and is not made available to the
> > secure world.
> > 
> > As a first step, intercept and block all memory-related FF-A SMC calls
> > from the host to EL3. This puts the framework in place for handling them
> > properly.
> 
> Shouldn't FFA_FEATURES interception actually precede this patch? At this
> point in the series we're outright lying about the supported features to
> the host.

FF-A is in a pretty sorry state after this patch as we block all the memory
transactions, but I take your point that we should be consistent and not
advertise the features that we're blocking.

I'll return FFA_RET_NOT_SUPPORTED for all FFA_FEATURES calls until the
interception patch comes in later and does something smarter.

Will
