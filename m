Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1073A732113
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 22:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjFOUqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 16:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjFOUp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 16:45:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F7F26AA
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:45:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 166DD60F90
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 20:45:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8929C433C8;
        Thu, 15 Jun 2023 20:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686861956;
        bh=4kFWV9+xv5jLSm4U5yuODKQvD7AuhX6h1oB5batCmX0=;
        h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
        b=ILI0n7N5PkVo1QKZhgos9zEUJzNQl5Sog0tSUKB/ACsfRmt+Ds5rFK+4lUruEpZlz
         4QH7SBxihgDuiKmKot2AkCdgqyjIQIEkZGQr2Tx7d+KRopRHn2WG6z03fnQPhfqOPh
         YwLKE4BR+KzeZJPubD4oGrWjm+dsOetdw8rn/jc0WIh1BTzW9fIvcbQpTQUqlnSn70
         9Wbfo1cULYm98sPlMM2M13BK3075p6rZrFejx4Fe0B/xKZSDu6X/TPMemEcwLS6IU/
         lzZpoTYcGSw7mWwzPC+90tZDpLqCEs8lbpmrE9dr0orM821swnQHXoUSf5XgTex4Wc
         7bUHoDH+WAjog==
Message-ID: <ea63420a-a08d-3610-b01f-61dabe56d2df@kernel.org>
Date:   Thu, 15 Jun 2023 22:45:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] regmap: Check for register readability before checking
 cache during read
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20230613-b4-regmap-check-readability-before-cache-v1-1-b144c0b01ed9@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>
From:   Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20230613-b4-regmap-check-readability-before-cache-v1-1-b144c0b01ed9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.06.2023 22:07, Mark Brown wrote:
> Ensure that we don't return a spurious cache hit for unreadable registers
> (eg, with the flat cache which doesn't understand sparseness) by checking
> for readability before we do a cache lookup.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
(+CC Bjorn)

Hi Mark,

this patch breaks using regmap_field_force_write() on fields that are
parts of registers marked as write-only (e.g. by regmap_access_table.no_ranges)

Is that intended?

What's the recommended fix?

FWIW this breaks soc/qcom/icc-bwmon.c, causing an interrupt storm at boot due
to the "clear the counters" register not being taken care of, so it'd be
appreciated if we can sort this out quickly.

Konrad
>  drivers/base/regmap/regmap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
> index fa2d3fba6ac9..3efbe59ca1a7 100644
> --- a/drivers/base/regmap/regmap.c
> +++ b/drivers/base/regmap/regmap.c
> @@ -2897,6 +2897,9 @@ static int _regmap_read(struct regmap *map, unsigned int reg,
>  	int ret;
>  	void *context = _regmap_map_get_context(map);
>  
> +	if (!regmap_readable(map, reg))
> +		return -EIO;
> +
>  	if (!map->cache_bypass) {
>  		ret = regcache_read(map, reg, val);
>  		if (ret == 0)
> @@ -2906,9 +2909,6 @@ static int _regmap_read(struct regmap *map, unsigned int reg,
>  	if (map->cache_only)
>  		return -EBUSY;
>  
> -	if (!regmap_readable(map, reg))
> -		return -EIO;
> -
>  	ret = map->reg_read(context, reg, val);
>  	if (ret == 0) {
>  		if (regmap_should_log(map))
> 
> ---
> base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375
> change-id: 20230613-b4-regmap-check-readability-before-cache-9f658338a5c1
> 
> Best regards,
