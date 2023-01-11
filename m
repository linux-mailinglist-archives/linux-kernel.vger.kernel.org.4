Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE872665503
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 08:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbjAKHHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 02:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbjAKHHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 02:07:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5539B1C7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 23:07:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A494B81AD7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:07:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F7EC433F0;
        Wed, 11 Jan 2023 07:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673420837;
        bh=chvKeHmzRnUNnaPUXPFQi7vJuGyxBdkeqmim3X0CCXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HsPN4JEZdY+7PczfvITRGL2Ojdd6ooCzBsnq2T9EQI2N1bXXWBc76Wzf/09eZTwgm
         rQOYGKcfo+hesFCL6paywYHPZ8VpklFDtWStO6D2mD/xhhHP5PAOqFE8U7+psQlJyC
         R5o6dcOrXSPoBiHmY65KocLv59T7b9AC7DzB599qo5gasEanpdtdzW+J0Q6uxSILDB
         xbwvpY7FrZ7O+s8qxnJEHm+JtR2SoqVXwLLUFcwCiToxxZdKscD93LTlHGwmssZZxr
         X5KrRi1B/Yfs95zV24y+K6VivIFaeU1Dl2PuBH0BXVMeLePM/7KXuEymbw1cWZPyYc
         wBMcv19U29gGQ==
Date:   Tue, 10 Jan 2023 23:07:15 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Li Lingfeng <lilingfeng3@huawei.com>
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, bingjingc@synology.com,
        james.smart@broadcom.com, houtao1@huawei.com, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2] lib: parser: optimize match_NUMER apis to use local
 array
Message-ID: <Y75gI7HRTiNzdfM4@sol.localdomain>
References: <20230111042215.4120156-1-lilingfeng3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111042215.4120156-1-lilingfeng3@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 12:22:15PM +0800, Li Lingfeng wrote:
>  /**
>   * match_one - Determines if a string matches a simple pattern
>   * @s: the string to examine for presence of the pattern
> @@ -129,14 +138,13 @@ EXPORT_SYMBOL(match_token);
>  static int match_number(substring_t *s, int *result, int base)
>  {
>  	char *endp;
> -	char *buf;
> +	char buf[NUMBER_BUF_LEN];
>  	int ret;
>  	long val;
>  
> -	buf = match_strdup(s);
> -	if (!buf)
> -		return -ENOMEM;
> -
> +	if ((s->to - s->from) >= NUMBER_BUF_LEN)
> +		return -ERANGE;
> +	match_strlcpy(buf, s, NUMBER_BUF_LEN);

Instead of doing '(s->to - s->from) >= NUMBER_BUF_LEN', it would be simpler to
check the return value of match_strlcpy():

	if (match_strlcpy(buf, s, NUMBER_BUF_LEN) >= NUMBER_BUF_LEN)
		return -ERANGE;

Likewise in match_u64int() and match_uint().

- Eric
