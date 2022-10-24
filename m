Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5A2609FB0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiJXLDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiJXLC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:02:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F35216C114
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 04:01:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F65F2B;
        Mon, 24 Oct 2022 04:01:11 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.7.186])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A7F13F7B4;
        Mon, 24 Oct 2022 04:01:04 -0700 (PDT)
Date:   Mon, 24 Oct 2022 12:00:57 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org, wangkefeng.wang@huawei.com,
        Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH -next] init/main: Use strtobool for param parsing in
 set_debug_rodata()
Message-ID: <Y1ZwaYLckR8/IDh5@FVFF77S0Q05N>
References: <20221024093817.3003291-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024093817.3003291-1-tongtiangen@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 09:38:17AM +0000, Tong Tiangen wrote:
> Aftern parsing "full", we can still use strtobool rather than "on" and
> "off" parsing in set_debug_rodata().
> 
> Fixes: 2e8cff0a0eee ("arm64: fix rodata=full")

Why do you think this is a fix; what do you believe is broken?

As noted in the commit message for 2e8cff0a0eee, we *deliberately* don't use
strtobool() here so that we don't accept garbage values like "ful".

NAK to this patch as it stands.

Thanks,
Mark.

> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> ---
>  init/main.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/init/main.c b/init/main.c
> index aa21add5f7c5..f420e20b1fa3 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1463,13 +1463,7 @@ static int __init set_debug_rodata(char *str)
>  	if (arch_parse_debug_rodata(str))
>  		return 0;
>  
> -	if (str && !strcmp(str, "on"))
> -		rodata_enabled = true;
> -	else if (str && !strcmp(str, "off"))
> -		rodata_enabled = false;
> -	else
> -		pr_warn("Invalid option string for rodata: '%s'\n", str);
> -	return 0;
> +	return strtobool(str, &rodata_enabled);
>  }
>  early_param("rodata", set_debug_rodata);
>  #endif
> -- 
> 2.25.1
> 
