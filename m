Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D639772A6C3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 01:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjFIXeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 19:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbjFIXdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 19:33:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4249D3C39;
        Fri,  9 Jun 2023 16:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=lufy/ezNAeUbR/JheOSHrV1cD2JJd1bYnsaGsmZuXMg=; b=yVU7fzidhDNoB2h2l+GKecnMla
        cZ1gAPG7LOoOjVGIk9P9YJ2b8B7IIBzKBc+1Le9WolPESJBWbLyGAmMukLxn7hewdSkpDjzVTi7hm
        A44dYJQ4B49Ua/7yxpMHjVTnJpaEhAoDvWbbhzW983E1pQTOdAiJBFRwH08X0ioneoPsgQxGm7NE/
        25FIrVxQj5YUaKTtJvE2tcqKtUTMNAJ5YizPtAmaXtLsnE5UCtl778bHHd5jIAQ2Eb7rodwEhw8PH
        zmkq5tev43w3qrJzoFBPdB2KMT5RfYJ5TRXyhyUCYSB1zrSpCskuNrPYqFXcAHytpfuSDZ0zxuRxy
        cmCo948g==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q7lYZ-00EZR4-2X;
        Fri, 09 Jun 2023 23:30:11 +0000
Message-ID: <332b83a8-779f-73a6-8113-50f59c7e7184@infradead.org>
Date:   Fri, 9 Jun 2023 16:30:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] Enable AMD3255 Proc to show negative temperature
To:     Baskaran Kannan <Baski.Kannan@amd.com>, Mario.Limonciello@amd.com,
        babu.moger@amd.com, clemens@ladisch.de, jdelvare@suse.com,
        linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230609231139.3006-1-Baski.Kannan@amd.com>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230609231139.3006-1-Baski.Kannan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

Style issues:

On 6/9/23 16:11, Baskaran Kannan wrote:
> From: Your Name <you@example.com>

Fix that. ^^^^^

Provide a comment message (not empty).

> 
> Signed-off-by: Baski Kannan <Baski.Kannan@amd.com>
> ---
>  drivers/hwmon/k10temp.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 489ad0b1bc74..58e4d90de5e3 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -77,6 +77,11 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
>  #define ZEN_CUR_TEMP_RANGE_SEL_MASK		BIT(19)
>  #define ZEN_CUR_TEMP_TJ_SEL_MASK		GENMASK(17, 16)
>  
> +/* AMD's Industrial processor 3255 supports temperature from -40 deg to 105 deg Celsius.
> + * Do not round off to zero for negative Tctl or Tdie values
> + */

Linux multi-line coding style (except for net/ and bpf/) is like:

/*
 * AMD's Industrial processor 3255 supports temperature from -40 deg to 105 deg Celsius.
 * Do not round off to zero for negative Tctl or Tdie values
 */

End the last sentence above with a period.


> +#define AMD_I3255_STR				"3255"
> +
>  struct k10temp_data {
>  	struct pci_dev *pdev;
>  	void (*read_htcreg)(struct pci_dev *pdev, u32 *regval);


For the next patch version, please make sure that it says v2
and explain the differences in v1 and v2.

thanks.
-- 
~Randy
