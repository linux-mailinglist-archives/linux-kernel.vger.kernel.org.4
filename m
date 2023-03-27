Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065B36CA3E1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjC0MUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjC0MTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:19:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444B86EA6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:17:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA28DB8118C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:17:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CD6C433D2;
        Mon, 27 Mar 2023 12:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679919461;
        bh=8F7QuYtpfLMxudvEc2UVzK8oJdfABOssMctt035/R6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K3KExgvBsPxXtPX+VC0N2a7KnIspWj4/twfMbAF949S+JDq5VnihcfFE48DsON2t5
         bkH95HsSncB6DLn/XqaM7mUtKZ6ROvhtNVF5qk8oKBFuF0AJoAOE/469MBmC1SYo9R
         bEnJ3GfnXNPuxrjYgIJnV/N7a+J7Q17ympwDCmPw+rIJ8TbvZFirNkZ6wUwSS/SieE
         4WvFXIVl6Qfm1Hc/jUAbif6ogBmWQMYUjOGEqqCF4LYjuZURxUaUnCSTm/XwpWENEN
         qejn3ZTFyPPCSxWskkRTl5uvSzi3gMsV342oCFZt8U7b6fk1J6t3OnI7eZ1Qn2rJN6
         nKhQGYOzIKHqA==
Date:   Mon, 27 Mar 2023 13:17:35 +0100
From:   Will Deacon <will@kernel.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Radu Rendec <rrendec@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Gavin Shan <gshan@redhat.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] cacheinfo: Add use_arch[|_cache]_info field/function
Message-ID: <20230327121734.GB31342@willie-the-truck>
References: <20230327115953.788244-1-pierre.gondois@arm.com>
 <20230327115953.788244-4-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327115953.788244-4-pierre.gondois@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 01:59:51PM +0200, Pierre Gondois wrote:
> The cache information can be extracted from either a Device
> Tree (DT), the PPTT ACPI table, or arch registers (clidr_el1
> for arm64).
> 
> The clidr_el1 register is used only if DT/ACPI information is not
> available. It does not states how caches are shared among CPUs.
> 
> Add a use_arch_cache_info field/function to identify when the
> DT/ACPI doesn't provide cache information. Use this information
> to assume L1 caches are privates and L2 and higher are shared among
> all CPUs.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  arch/arm64/kernel/cacheinfo.c |  5 +++++
>  drivers/base/cacheinfo.c      | 20 ++++++++++++++++++--
>  include/linux/cacheinfo.h     |  2 ++
>  3 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
> index c307f69e9b55..b6306cda0fa7 100644
> --- a/arch/arm64/kernel/cacheinfo.c
> +++ b/arch/arm64/kernel/cacheinfo.c
> @@ -96,3 +96,8 @@ int populate_cache_leaves(unsigned int cpu)
>  	}
>  	return 0;
>  }
> +
> +bool use_arch_cache_info(unsigned int cpu)
> +{
> +	return true;
> +}

It would be a lot nicer if this was a static inline function in a header
rather than a weak symbol.

Will
