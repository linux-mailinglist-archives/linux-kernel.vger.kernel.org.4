Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52481632C71
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 19:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiKUS4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 13:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiKUS4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 13:56:37 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28D9C8CB6;
        Mon, 21 Nov 2022 10:56:34 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2ALIuStg078505;
        Mon, 21 Nov 2022 12:56:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1669056988;
        bh=UggNQ4SVXmBlKbdqW4RABVrFUltLkjGfFH5klcNmk7s=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=cDLzh+pJLkw4uvOaMDTAgeZYRNLc/LaSi7zE18f/LZD6dapJVxqglArXMe4AL6RwA
         yszlhI3t0AdaqreIkapoUvodCdJcgCRjAZWKq7BDj6Nf/EGkVmab7Z/rzNw0Umbt+k
         wUcY5ENEUIBLbaTNfDTc+bDZHI3nkBAOs4VNYiIw=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2ALIuSEs059290
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Nov 2022 12:56:28 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 21
 Nov 2022 12:56:27 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 21 Nov 2022 12:56:27 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2ALIuRu0102167;
        Mon, 21 Nov 2022 12:56:27 -0600
Date:   Mon, 21 Nov 2022 12:56:27 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Georgi Vlaev <g-vlaev@ti.com>
CC:     Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH v4 3/5] firmware: ti_sci: Allocate memory for the LPM
 modes
Message-ID: <20221121185627.lysq4u7guiprclxt@surviving>
References: <20221116181307.198209-1-g-vlaev@ti.com>
 <20221116181307.198209-4-g-vlaev@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221116181307.198209-4-g-vlaev@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20:13-20221116, Georgi Vlaev wrote:
> +	/*
> +	 * Attempt to call prepare_sleep, this will be NAK'd if suspend is not
> +	 * supported by firmware in use, in which case we will not attempt to
> +	 * init suspend.
> +	 */
> +	ret = ti_sci_cmd_prepare_sleep(&info->handle, 0,
> +				       (u32)(info->ctx_mem_addr & 0xffffffff),
> +				       (u32)((u64)info->ctx_mem_addr >> 32), 0);
> +

https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html#tisci-msg-prepare-sleep
"Prepare the SOC for entering into a low power mode."

But we are in the init process here. From the documentation, firmware
does'nt seem to guarantee it would do something unexpected (like setup
io daisy chain or something like that which normal LP entry state
would have to do) - How is it safe to use it as a discovery of
capability API?


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
