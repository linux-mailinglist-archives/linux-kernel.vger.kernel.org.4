Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122EB5F78C2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 15:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiJGNRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 09:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiJGNRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 09:17:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9DAD018E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 06:17:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCABCB822E6
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 13:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B4FC433D6;
        Fri,  7 Oct 2022 13:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665148625;
        bh=f+Qm9GXfjCsCnVzjA7YLDOi76PJFXUc5CeVj8sq1VDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QJf0BJt9dM1tcDlmrMOKLj4V0MvRJU4e4OoEO+1fxptuqC1ZMXdrfpndRUSqJAuja
         NmXrDVyDK6zWvhOQ9uZ61ybkQIoV57tphhyHED3iWPpkmXHDRQnV/1LCjszGuRRQBl
         FDHkcwWbuTtf6Fatlu+Dwuingvsj508QbIyvovy0B+xANLZ0ETlWGhpFa6A6QNiJ0f
         RsVI0KxSc/tjlEwQVKdjIyTQt7aZgkX+t2kCmg9bcRTzT5RMjW4ItU+2QPXzpKBRbj
         PBxmTHjvp2NjQsY7AmZZcJDpR72sI+/5sOgJVLBLYzMytQ1mZctMqQiUdTlQW127bf
         /6WSeZ9E4T57g==
Date:   Fri, 7 Oct 2022 14:17:00 +0100
From:   Will Deacon <will@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        catalin.marinas@arm.com
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Neng Chen <nengchen@linux.alibaba.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Hongbo Yao <yaohongbo@linux.alibaba.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/perf: ALIBABA_UNCORE_DRW_PMU should depend on
 ACPI
Message-ID: <20221007131659.GB26341@willie-the-truck>
References: <2a4407bb598285660fa5e604e56823ddb12bb0aa.1664285774.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a4407bb598285660fa5e604e56823ddb12bb0aa.1664285774.git.geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:37:16PM +0200, Geert Uytterhoeven wrote:
> The Alibaba T-Head Yitian 710 DDR Sub-system Driveway PMU driver relies
> solely on ACPI for matching.  Hence add a dependency on ACPI, to prevent
> asking the user about this driver when configuring a kernel without ACPI
> support.
> 
> Fixes: cf7b61073e4526ca ("drivers/perf: add DDR Sub-System Driveway PMU driver for Yitian 710 SoC")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/perf/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 44c07ea487f4482a..341010f20b777905 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -185,7 +185,7 @@ config APPLE_M1_CPU_PMU
>  
>  config ALIBABA_UNCORE_DRW_PMU
>  	tristate "Alibaba T-Head Yitian 710 DDR Sub-system Driveway PMU driver"
> -	depends on ARM64 || COMPILE_TEST
> +	depends on (ARM64 && ACPI) || COMPILE_TEST
>  	help
>  	  Support for Driveway PMU events monitoring on Yitian 710 DDR
>  	  Sub-system.

Acked-by: Will Deacon <will@kernel.org>

Another one for Catalin to queue as a fix.

Will
