Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569FE6DBA66
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 13:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjDHL2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 07:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjDHL2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 07:28:32 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CDB198B
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 04:28:31 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 338BRt4Y060710;
        Sat, 8 Apr 2023 06:27:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680953275;
        bh=7AStEtIeqWWtf5cdIY0biXRgvMPW0zVk22A12h8jBUg=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=F+kj6y2oVJAWPoqmJOa3Se0LJ1gcG7DhC1y/hzPaLoXU6T99R+kcFkkToDbJb83zD
         vmigjwJC6jE4F+U17Emnxd94ENoWrvs29459yrxfs+9AOKDM7ff15fTj86tS027QSG
         nNpKdoBVRlUwwLZiiqfd1Pp9lxx4mYzb0I51POTQ=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 338BRs3c048119
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 8 Apr 2023 06:27:55 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Sat, 8
 Apr 2023 06:27:54 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Sat, 8 Apr 2023 06:27:54 -0500
Received: from [10.249.133.214] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 338BRpo3028985;
        Sat, 8 Apr 2023 06:27:52 -0500
Message-ID: <d9d6dc1b-cc1d-d823-8777-3a8d6d2328f7@ti.com>
Date:   Sat, 8 Apr 2023 16:57:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH RFC v2 2/2] irqchip: irq-ti-sci-inta: Add direct mapped
 interrupts
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230327-irq-affinity-upstream-v2-0-1474e518f1cb@ti.com>
 <20230327-irq-affinity-upstream-v2-2-1474e518f1cb@ti.com>
 <87ile664i1.wl-maz@kernel.org>
From:   "Raghavendra, Vignesh" <vigneshr@ti.com>
In-Reply-To: <87ile664i1.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/8/2023 4:10 PM, Marc Zyngier wrote:
>> +static unsigned int ti_sci_inta_direct_events_am62x[] = {
>> +	/* CPSW etherenti DMA events */
>> +	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 4627),
>> +	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 4635),
>> +	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 4643),
>> +	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 4651),
>> +	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 4659),
>> +	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 4667),
>> +	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 4675),
>> +	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 4683),
>> +	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 5651),
>> +};
>> +
>> +static struct ti_sci_inta_soc_data soc_data_am62x = {
>> +	.events_list = ti_sci_inta_direct_events_am62x,
>> +	.events_list_size = ARRAY_SIZE(ti_sci_inta_direct_events_am62x),
>> +};
> I don't think these tables belong in a driver, and they are bound to
> grow without any obvious limits. 

Fair point.

> You have firmware tables that can express these things. Surely they can be put to a good use.

By firmware tables you mean device tree?

Regards
Vignesh
