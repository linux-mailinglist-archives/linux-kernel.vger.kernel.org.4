Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF39361809C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiKCPIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiKCPIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:08:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C811B79A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 08:05:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF6DAB8286C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 15:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D15FC433D6;
        Thu,  3 Nov 2022 15:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667487939;
        bh=taCtcchtv3uY3su65/G9LRDcildfHLJU0tqiBjoGDBE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Tonntgpkv3sbmIQJUe7Wgxb+WKAhZJusSCZnMycciH99OnWuiXC2sfC6/h2m9GDCJ
         //uUT+8GGe9LEjUcCZOhYay60N7XkXcnD6/iJ2rYe3gt0YbjJ/PAw9fSso81Z7hCNV
         9Am3zbKZhPXiXCeF1TrFM9QaA7K5CUUSNzwvGWJG2z2g8hi+zKXigxTa1G3+ZDwUgw
         p19Z6mIrUUVPCtZoelfhrR4Qc0jFyIYwOolpqQiL8C5WTDgFMtjPQaf7i6VvrYBV/8
         vdNtBc/v372wHyvCbE9lEhyn9IxOMD687Tl0RrvNf3eeGcESW7S/i+qifuuEMxGu6Q
         Ke+cVRBjJcGDw==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oqbmj-003XAU-8Z;
        Thu, 03 Nov 2022 15:05:37 +0000
MIME-Version: 1.0
Date:   Thu, 03 Nov 2022 15:05:36 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Joe Korty <joe.korty@concurrent-rt.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: arch_timer: XGene-1: TVAL register math error
 breaks timer expiry calculation.
In-Reply-To: <86o7u0dqzj.wl-maz@kernel.org>
References: <20221024165422.GA51107@zipoli.concurrent-rt.com>
 <86o7u0dqzj.wl-maz@kernel.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <b6bfebb77b593e578bacec70646bc7e3@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: joe.korty@concurrent-rt.com, daniel.lezcano@linaro.org, mark.rutland@arm.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-25 13:31, Marc Zyngier wrote:
> Daniel, would you mind fixing it up when applying this patch? XGene is
> trivially broken without this fix, and it would be good if it could
> make it in one of the 6.1-rc.

Daniel, are you able to take this patch? I don't mind respinning
it myself if necessary.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
