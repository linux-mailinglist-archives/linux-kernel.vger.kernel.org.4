Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA80708286
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 15:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjERNTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 09:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjERNTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 09:19:41 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287B61986
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 06:19:20 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QMVrm6DX7zLmNp;
        Thu, 18 May 2023 21:17:44 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 21:19:06 +0800
Subject: Re: [PATCH 5/5] irqchip: gicv3: add a iort_pmsi_get_dev_id()
 prototype
To:     Arnd Bergmann <arnd@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <jroedel@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        <linux-kernel@vger.kernel.org>
References: <20230516200516.554663-1-arnd@kernel.org>
 <20230516200516.554663-5-arnd@kernel.org>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <3141e176-f5d3-a313-1b11-8acc516228d8@huawei.com>
Date:   Thu, 18 May 2023 21:19:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20230516200516.554663-5-arnd@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/17 4:05, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> iort_pmsi_get_dev_id() has a __weak definition in the driver, and
> an override in arm64 specific code, but the declaration is conditional
> and not always seen when the copy in the driver gets built:
> 
> drivers/irqchip/irq-gic-v3-its-platform-msi.c:41:12: error: no previous prototype for 'iort_pmsi_get_dev_id' [-Werror=missing-prototypes]
> 
> Move the existing declaration out of the #ifdef block to ensure
> it can be seen in all configurations.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   include/linux/acpi_iort.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index b43be0987b19..6b70d02bc5f9 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -26,13 +26,14 @@ int iort_register_domain_token(int trans_id, phys_addr_t base,
>   			       struct fwnode_handle *fw_node);
>   void iort_deregister_domain_token(int trans_id);
>   struct fwnode_handle *iort_find_domain_token(int trans_id);
> +int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
> +
>   #ifdef CONFIG_ACPI_IORT
>   void acpi_iort_init(void);
>   u32 iort_msi_map_id(struct device *dev, u32 id);
>   struct irq_domain *iort_get_device_domain(struct device *dev, u32 id,
>   					  enum irq_domain_bus_token bus_token);
>   void acpi_configure_pmsi_domain(struct device *dev);
> -int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
>   void iort_get_rmr_sids(struct fwnode_handle *iommu_fwnode,
>   		       struct list_head *head);
>   void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode,

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun
