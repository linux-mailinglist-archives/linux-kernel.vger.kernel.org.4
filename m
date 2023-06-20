Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F7E736241
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 05:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjFTDnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 23:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjFTDni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 23:43:38 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBA110CB;
        Mon, 19 Jun 2023 20:43:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vla4QdS_1687232610;
Received: from 30.240.115.170(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vla4QdS_1687232610)
          by smtp.aliyun-inc.com;
          Tue, 20 Jun 2023 11:43:31 +0800
Message-ID: <638b32ce-d2a8-2686-dda1-26abb0778bae@linux.alibaba.com>
Date:   Tue, 20 Jun 2023 11:43:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] ACPI: APEI: mark some functions __init
To:     Miaohe Lin <linmiaohe@huawei.com>, rafael@kernel.org
Cc:     lenb@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        bp@alien8.de, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230617080708.2002287-1-linmiaohe@huawei.com>
Content-Language: en-US
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20230617080708.2002287-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/17 16:07, Miaohe Lin wrote:
> hest_esrc_len() and apei_hest_parse() are only called inside __init
> section. So mark them __init too.

Hi, Miaohe,

should ghes_estatus_pool_init also be marked with __init?

Thanks.

Best Regards,
Shuai


> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  drivers/acpi/apei/hest.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
> index 6aef1ee5e1bd..2d78e808ab8b 100644
> --- a/drivers/acpi/apei/hest.c
> +++ b/drivers/acpi/apei/hest.c
> @@ -55,7 +55,7 @@ static inline bool is_generic_error(struct acpi_hest_header *hest_hdr)
>  	       hest_hdr->type == ACPI_HEST_TYPE_GENERIC_ERROR_V2;
>  }
>  
> -static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
> +static int __init hest_esrc_len(struct acpi_hest_header *hest_hdr)
>  {
>  	u16 hest_type = hest_hdr->type;
>  	int len;
> @@ -88,7 +88,7 @@ static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
>  
>  typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
>  
> -static int apei_hest_parse(apei_hest_func_t func, void *data)
> +static int __init apei_hest_parse(apei_hest_func_t func, void *data)
>  {
>  	struct acpi_hest_header *hest_hdr;
>  	int i, rc, len;
