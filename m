Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF1C60203E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 03:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiJRBNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 21:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiJRBNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 21:13:11 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C37193FF;
        Mon, 17 Oct 2022 18:13:09 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mrwkk2l0mzpVrk;
        Tue, 18 Oct 2022 09:09:50 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 09:13:00 +0800
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 09:12:59 +0800
Message-ID: <b936b12e-8b2c-4583-1c71-1f914d0fdb82@huawei.com>
Date:   Tue, 18 Oct 2022 09:12:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] "ACPI: PCC: Fix unintentional integer overflow"
To:     Manank Patel <pmanank200502@gmail.com>, <rafael@kernel.org>
CC:     <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>
References: <20221017182035.3g67uudttl6k5gag@bogus>
 <20221017184338.64152-1-pmanank200502@gmail.com>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20221017184338.64152-1-pmanank200502@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/10/18 2:43, Manank Patel 写道:
> Fixed unintentional u32 overflow by changing PCC_CMD_WAIT_RETRIES_NUM to 500ULL
>
> Fixes: 91cefefb6991 ("ACPI: PCC: replace wait_for_completion()")
>
> Signed-off-by: Manank Patel <pmanank200502@gmail.com>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>
> ---
> Thank you so much @sudeep for your clarifications!
>
> Changelog:
> v1->v2:
>          Change the macro itself to ULL instead of typecasting in the
>          code
>
>   drivers/acpi/acpi_pcc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
> index ee4ce5ba1fb2..3e252be047b8 100644
> --- a/drivers/acpi/acpi_pcc.c
> +++ b/drivers/acpi/acpi_pcc.c
> @@ -27,7 +27,7 @@
>    * Arbitrary retries in case the remote processor is slow to respond
>    * to PCC commands
>    */
> -#define PCC_CMD_WAIT_RETRIES_NUM	500
> +#define PCC_CMD_WAIT_RETRIES_NUM	500ULL
>   
>   struct pcc_data {
>   	struct pcc_mbox_chan *pcc_chan;

Acked-by: Huisong Li <lihuisong@huawei.com>

