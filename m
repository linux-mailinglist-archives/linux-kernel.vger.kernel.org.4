Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58769667319
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjALNY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjALNYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:24:22 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E87E36322
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 05:24:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9A4413D5;
        Thu, 12 Jan 2023 05:25:03 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.43.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CA863F67D;
        Thu, 12 Jan 2023 05:24:20 -0800 (PST)
Date:   Thu, 12 Jan 2023 13:24:17 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V7 2/6] arm64/perf: Add BRBE registers and fields
Message-ID: <Y8AKAZMq7YzOpwwV@FVFF77S0Q05N>
References: <20230105031039.207972-1-anshuman.khandual@arm.com>
 <20230105031039.207972-3-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105031039.207972-3-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On Thu, Jan 05, 2023 at 08:40:35AM +0530, Anshuman Khandual wrote:
> This adds BRBE related register definitions and various other related field
> macros there in. These will be used subsequently in a BRBE driver which is
> being added later on.

I haven't verified the specific values, but this looks good to me aside from
one minor nit below.

[...]

> +# This is just a dummy register declaration to get all common field masks and
> +# shifts for accessing given BRBINF contents.
> +Sysreg	BRBINF_EL1	2	1	8	0	0

We don't need a dummy declaration, as we have 'SysregFields' that can be used
for this, e.g.

  SysregFields BRBINFx_EL1
  ...
  EndSysregFields

... which will avoid accidental usage of the register encoding. Note that I've
also added an 'x' there in place of the index, which we do for other registers,
e.g. TTBRx_EL1.

Could you please update to that?

With that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.
