Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276FB5E54D6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 23:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiIUVAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 17:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiIUU75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 16:59:57 -0400
X-Greylist: delayed 421 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 21 Sep 2022 13:59:55 PDT
Received: from novek.ru (unknown [213.148.174.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3071A79EFA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 13:59:53 -0700 (PDT)
Received: from [192.168.0.18] (unknown [37.228.234.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by novek.ru (Postfix) with ESMTPSA id A1DD1504D02;
        Wed, 21 Sep 2022 23:49:09 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 novek.ru A1DD1504D02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=novek.ru; s=mail;
        t=1663793351; bh=+FOY44FFFHbhCZX3hBs0Td2GFcgqZ+wLRlydeq/m0eY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZZXxMT7jZjhm8ILPmyA6obyMYbMuFE7ok5qU0/+IsRJdbTQFn56DWtY8nemEw1OQ6
         rzcB5FU2FVTA3A9z0TdBhSqJbEFKor0HQzx9PTg3LfoBosdIl4DNGKqPFoCOXDUAIG
         I+mjmSTIISD7XuycCb+4ndCiUcUO3LOka/O1Rj0w=
Message-ID: <b7536b94-b37c-9e8a-363f-cbca652f1cbd@novek.ru>
Date:   Wed, 21 Sep 2022 21:52:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 1/1] ptp_ocp: use device_find_any_child() instead of
 custom approach
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vadim Fedorenko <vadfed@fb.com>,
        Richard Cochran <richardcochran@gmail.com>
References: <20220921141005.2443-1-andriy.shevchenko@linux.intel.com>
From:   Vadim Fedorenko <vfedorenko@novek.ru>
In-Reply-To: <20220921141005.2443-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.09.2022 15:10, Andy Shevchenko wrote:
> We have already a helper to get the first child device, use it and
> drop custom approach.
> 

LGTM. This patch should go to net-next, I believe.

Acked-by: Vadim Fedorenko <vadfed@fb.com>

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/ptp/ptp_ocp.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 83da36e69361..ebed0161879e 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -1311,12 +1311,6 @@ ptp_ocp_read_eeprom(struct ptp_ocp *bp)
>   	goto out;
>   }
>   
> -static int
> -ptp_ocp_firstchild(struct device *dev, void *data)
> -{
> -	return 1;
> -}
> -
>   static struct device *
>   ptp_ocp_find_flash(struct ptp_ocp *bp)
>   {
> @@ -1325,7 +1319,7 @@ ptp_ocp_find_flash(struct ptp_ocp *bp)
>   	last = NULL;
>   	dev = &bp->spi_flash->dev;
>   
> -	while ((dev = device_find_child(dev, NULL, ptp_ocp_firstchild))) {
> +	while ((dev = device_find_any_child(dev))) {
>   		if (!strcmp("mtd", dev_bus_name(dev)))
>   			break;
>   		put_device(last);

