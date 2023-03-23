Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A856C691F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjCWNIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjCWNIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:08:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377C02E83D;
        Thu, 23 Mar 2023 06:07:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5C97626B7;
        Thu, 23 Mar 2023 13:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A79AC433EF;
        Thu, 23 Mar 2023 13:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679576848;
        bh=jeeYuf2cvJjDKCXLZ079Zr80fJiGBtLhCWrirRmqNdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qO7Mo9F/AWK4Qvz+eFnk5PzTeirAuzkuS19kYhe3YTd86AWex8Db6YF6asZZyVBO3
         x67p0g5xXUem3Bxev0O+B0jObOhzQiAlv7V3mCXfVxznXSmBes4JIuBY0ogXVgTBu+
         CvIyWPPqN6IU2DObf55aWZL4XE2MjM4v8djjgehThgphquZPpAaxdikQFHWUmhn/P6
         j1qW7g2KWAzgJWx6X5/XuDQr4NSeIsS/WtzmyzmMuFc09zeJjz9hkQW2CuymTBQSuD
         xjJsJZLlM4I2bW+9hm34IlPyMUs8AMfk8EwWwgiK1I440TuLXgOMBe2ikqoH5MQBUl
         ie8vmXR1fnrfg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 75EB04052D; Thu, 23 Mar 2023 10:07:25 -0300 (-03)
Date:   Thu, 23 Mar 2023 10:07:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH] perf list: Remove UTF-8 characters from json file
Message-ID: <ZBxPDagGB11SS8/D@kernel.org>
References: <20230323122532.2305847-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230323122532.2305847-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 23, 2023 at 01:25:32PM +0100, Thomas Richter escreveu:
> commit 7f76b3113068 ("perf list: Add IBM z16 event description for s390")
> contains the verbal description for z16 extended counter set.
> However some entries of the public description contain
> UTF-8 characters which brakes the build on some distros.
> 
> Fix this and remove the UTF-8 characters.

Thanks, tested and applied. Now its some power9 file failing...

- Arnaldo

 
> Fixes: 7f76b3113068 ("perf list: Add IBM z16 event description for s390")
> Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/pmu-events/arch/s390/cf_z16/extended.json | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/extended.json b/tools/perf/pmu-events/arch/s390/cf_z16/extended.json
> index c306190fc06f..c2b10ec1c6e0 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z16/extended.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z16/extended.json
> @@ -95,28 +95,28 @@
>  		"EventCode": "145",
>  		"EventName": "DCW_REQ",
>  		"BriefDescription": "Directory Write Level 1 Data Cache from Cache",
> -		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestor’s Level-2 cache."
> +		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestors Level-2 cache."
>  	},
>  	{
>  		"Unit": "CPU-M-CF",
>  		"EventCode": "146",
>  		"EventName": "DCW_REQ_IV",
>  		"BriefDescription": "Directory Write Level 1 Data Cache from Cache with Intervention",
> -		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestor’s Level-2 cache with intervention."
> +		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestors Level-2 cache with intervention."
>  	},
>  	{
>  		"Unit": "CPU-M-CF",
>  		"EventCode": "147",
>  		"EventName": "DCW_REQ_CHIP_HIT",
>  		"BriefDescription": "Directory Write Level 1 Data Cache from Cache with Chip HP Hit",
> -		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestor’s Level-2 cache after using chip level horizontal persistence, Chip-HP hit."
> +		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestors Level-2 cache after using chip level horizontal persistence, Chip-HP hit."
>  	},
>  	{
>  		"Unit": "CPU-M-CF",
>  		"EventCode": "148",
>  		"EventName": "DCW_REQ_DRAWER_HIT",
>  		"BriefDescription": "Directory Write Level 1 Data Cache from Cache with Drawer HP Hit",
> -		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestor’s Level-2 cache after using drawer level horizontal persistence, Drawer-HP hit."
> +		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestors Level-2 cache after using drawer level horizontal persistence, Drawer-HP hit."
>  	},
>  	{
>  		"Unit": "CPU-M-CF",
> @@ -284,7 +284,7 @@
>  		"EventCode": "172",
>  		"EventName": "ICW_REQ_DRAWER_HIT",
>  		"BriefDescription": "Directory Write Level 1 Instruction Cache from Cache with Drawer HP Hit",
> -		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from the requestor’s Level-2 cache using drawer level horizontal persistence, Drawer-HP hit."
> +		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from the requestors Level-2 cache using drawer level horizontal persistence, Drawer-HP hit."
>  	},
>  	{
>  		"Unit": "CPU-M-CF",
> -- 
> 2.17.1
> 

-- 

- Arnaldo
