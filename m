Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDF774F859
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 21:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjGKT0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 15:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGKT0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 15:26:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C56411B;
        Tue, 11 Jul 2023 12:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=GMA2aZWPUThsAzz+NFrmqxioBQWjjKPUhDpaZRVfQsA=; b=vyzbPgfJkgup5BL8JyXyIn1z4a
        I5VIcczVYKXC+54YDSmCNxMk6DX6aOEw10833hMmRUmowBsGld7WyaZ+iK4kveZMF2dUI7d/aOzGg
        9YNX5Am31kr6aGZ85O7BTa/QtfwwapuXjNJXWrdKqBeQNZNOqHtW1jjjmXL75IowrQvmKZMqGiCdX
        46d0dW04tOQ7eorCb5Ell4uGxWifPpgd3yXFlij0NDim/cRXEg8lAsl8A9LmhzFtunqgCnFFrfLoU
        S2o+yZBcuroDsJElrcckw+SofWEPk26D62A57wQH9WOB7DfFGBGd6s2yK7L1F2pj0gQbilK5IKpcv
        x6it8GGg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJJ03-00Fk5Z-2v;
        Tue, 11 Jul 2023 19:26:15 +0000
Message-ID: <cde1fd99-04ae-f604-a5d0-5af3ddf57f7d@infradead.org>
Date:   Tue, 11 Jul 2023 12:26:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V13 - RESEND 06/10] arm64/perf: Enable branch stack events
 via FEAT_BRBE
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
Cc:     Mark Brown <broonie@kernel.org>, James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230711082455.215983-1-anshuman.khandual@arm.com>
 <20230711082455.215983-7-anshuman.khandual@arm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230711082455.215983-7-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 7/11/23 01:24, Anshuman Khandual wrote:
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index f4572a5cca72..7c8448051741 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -180,6 +180,17 @@ config ARM_SPE_PMU
>  	  Extension, which provides periodic sampling of operations in
>  	  the CPU pipeline and reports this via the perf AUX interface.
>  
> +config ARM64_BRBE
> +	bool "Enable support for Branch Record Buffer Extension (BRBE)"
> +	depends on PERF_EVENTS && ARM64 && ARM_PMU
> +	default y
> +	help
> +	  Enable perf support for Branch Record Buffer Extension (BRBE) which
> +	  records all branches taken in an execution path. This supports some
> +	  branch types and privilege based filtering. It captured additional

preferably:
	                                                 captures

> +	  relevant information such as cycle count, misprediction and branch
> +	  type, branch privilege level etc.

-- 
~Randy
