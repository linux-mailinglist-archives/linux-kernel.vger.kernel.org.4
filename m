Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1682F737D9E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjFUIe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjFUIeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:34:24 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CD819AC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:34:23 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35L8YGkd031030;
        Wed, 21 Jun 2023 03:34:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1687336456;
        bh=RcOH7fpnFEhX2+nNrVqYgVkolPMp+HFzURE6ojM7PyY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=AnGoNnmHJD+x/jN4l3uUlALaOytC33dlC8fFESTKS9UFjm4usLUMtG9kWrsWjKWUl
         fsc+zLoufhlKy42Z4sBT3dkaB+FFO1VjkkbCZVMw5wpRciQ+AHaC6ldir8G+HSuQlp
         u0f/qZUps4cOrNjeUAkLWMLu8+WOk0w0K28Arxbg=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35L8YGHW040884
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Jun 2023 03:34:16 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Jun 2023 03:34:15 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Jun 2023 03:34:16 -0500
Received: from [10.24.69.26] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35L8YD9Y081795;
        Wed, 21 Jun 2023 03:34:13 -0500
Message-ID: <2d15ea8e-b2d8-2ee7-ba66-7ed6e4237cb3@ti.com>
Date:   Wed, 21 Jun 2023 14:04:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] firmware: ti_sci: Fix few compiler warnings
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     Praneeth <praneeth@ti.com>, Vignesh <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230621082309.1569239-1-d-gole@ti.com>
From:   Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20230621082309.1569239-1-d-gole@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, seems like I missed similar patch,

On 21/06/23 13:53, Dhruva Gole wrote:
> Fix below warnings:
> 
>   CC      drivers/firmware/ti_sci.o
> drivers/firmware/ti_sci.c:1988: warning: Excess function parameter 'vint_irq' description in 'ti_sci_cmd_set_irq'
> drivers/firmware/ti_sci.c:2036: warning: Excess function parameter 'vint_irq' description in 'ti_sci_cmd_free_irq'
> drivers/firmware/ti_sci.c:2632: warning: Function parameter or member
> ...
> drivers/firmware/ti_sci.c:2748: warning: expecting prototype for ti_sci_cmd_get_boot_status(). Prototype was for ti_sci_cmd_proc_get_status() instead
> drivers/firmware/ti_sci.c:3267: warning: Function parameter or member 'sub_type' not described in 'devm_ti_sci_get_resource'
> drivers/firmware/ti_sci.c:3267: warning: Excess function parameter 'suub_type' description in 'devm_ti_sci_get_resource'
> 
> Fixes: 1e407f337f40 ("firmware: ti_sci: Add support for processor control")
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---

Nishanth already submitted this before I did,

https://lore.kernel.org/all/20230621021619.265162-1-nm@ti.com/

-- 
Thanks and Regards,
Dhruva Gole
