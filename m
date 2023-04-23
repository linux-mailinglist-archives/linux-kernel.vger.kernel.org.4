Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934816EBFCA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 15:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjDWNi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 09:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDWNiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 09:38:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF3DE4C
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 06:38:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A198360F55
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 13:38:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53868C433EF;
        Sun, 23 Apr 2023 13:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682257103;
        bh=X0CzlQ7DeLiLo5XSC8aAcVNlZSUiv+H5SzNN8Js8smc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XowOucbwxVtK15zuGoC6BwgJPZJ4ROtbL0ChORdG+Cv+KZt2uIwtdXThDbrq53AKV
         adrS14eybn2knt0esblTzAI+01L+rMLNFj82jW0av04/NFx9sP4FQi5yss/9luj+V5
         EeycepyToyzm/DcvaqBvy6wEvc7+kuq1riMJV4338PIhxjIVd4UaINhc8G5DqvPR7r
         c3r17nJ0lGHRKmzudHDRn9Giclp7FcLSViEHuWqe2qXDEwvH1ySqnve2NV3pb0htjZ
         G+eMcwuM5gvcsRuw4WTpsSxNR1QG0a1JXIdwdwfDE0kTSGWZvtxHGNXMN7Sdjv1lfS
         CYa3fifYd3rnQ==
Message-ID: <6be75dac-0904-390d-023b-a533f79073ce@kernel.org>
Date:   Sun, 23 Apr 2023 15:38:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drivers: w1: slaves: Drop unnecessary explicit casting
To:     Anup Sharma <anupnewsmail@gmail.com>, zbr@ioremap.net
Cc:     linux-kernel@vger.kernel.org
References: <ZECFjQMLwnoYPMeL@yoga>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <ZECFjQMLwnoYPMeL@yoga>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2023 02:21, Anup Sharma wrote:
> Provide correct specifiers while printing error logs to discard the use
> of unnecessary explicit casting.
> 
> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> ---
>  drivers/w1/slaves/w1_ds2433.c  | 6 +++---
>  drivers/w1/slaves/w1_ds28e04.c | 8 ++++----
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/w1/slaves/w1_ds2433.c b/drivers/w1/slaves/w1_ds2433.c
> index 0f72df15a024..ba441d42b0b0 100644
> --- a/drivers/w1/slaves/w1_ds2433.c
> +++ b/drivers/w1/slaves/w1_ds2433.c
> @@ -213,15 +213,15 @@ static ssize_t eeprom_write(struct file *filp, struct kobject *kobj,
>  #ifdef CONFIG_W1_SLAVE_DS2433_CRC
>  	/* can only write full blocks in cached mode */
>  	if ((off & W1_PAGE_MASK) || (count & W1_PAGE_MASK)) {
> -		dev_err(&sl->dev, "invalid offset/count off=%d cnt=%zd\n",
> -			(int)off, count);
> +		dev_err(&sl->dev, "invalid offset/count off=%pe cnt=%zd\n",
> +			off, count);

I don't think you tested this patch. Why do you think off is a pointer?

Best regards,
Krzysztof

