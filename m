Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FAE6BEC85
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 16:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjCQPJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 11:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjCQPI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 11:08:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1607831BC0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:08:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4061DB825D7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 15:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D489C4339B;
        Fri, 17 Mar 2023 15:07:40 +0000 (UTC)
Date:   Fri, 17 Mar 2023 15:07:37 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kristina Martsenko <kristina.martsenko@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Luis Machado <luis.machado@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] arm64: mops: document boot requirements for MOPS
Message-ID: <ZBSCObGmIXjyeMA6@arm.com>
References: <20230216160012.272345-1-kristina.martsenko@arm.com>
 <20230216160012.272345-5-kristina.martsenko@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216160012.272345-5-kristina.martsenko@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 04:00:06PM +0000, Kristina Martsenko wrote:
> +  For CPUs with Memory Copy and Memory Set instructions (FEAT_MOPS):
> +
> +  - If the kernel is entered at EL1 and EL2 is present:
> +
> +    - HCRX_EL2.MSCEn (bit 11) must be initialised to 0b1.
> +
> +    - HCRX_EL2.MCE2 (bit 10) must be initialised to 0b0.

Regarding MCE2, does EL1 actually care if EL2 wants to handle all the
memcpy/memset exceptions? There may even be a valid case to do this at
EL2 if you run a guest that uses these instructions but has no clue on
how to deal with the specific exception like WrongOption.

-- 
Catalin
