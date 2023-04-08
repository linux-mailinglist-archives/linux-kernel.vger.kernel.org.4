Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DD46DBA6E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 13:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjDHLeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 07:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjDHLeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 07:34:20 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCE8AF3F
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 04:34:19 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 338BYBFD061806;
        Sat, 8 Apr 2023 06:34:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680953651;
        bh=5lV2Q2UIZY+Vh70NwB/PzbbUK6ouvZkN8iFm+QcCWU0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=TOU9sWS0ytIXs5vTC4onXHyZyb+uXor++YV1KzNn1xPM2BszKSyCOiabsOQ274DIM
         jiNS9pwvLbR28rujKpD6zMxLIaUNimOY3XOdZKzGT+7GjXJWcgxzbvSqIEdaplxaov
         wgM367bydL6oE26AZvKUFNoszklBhybp2FXw28X0=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 338BYBNV085380
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 8 Apr 2023 06:34:11 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Sat, 8
 Apr 2023 06:34:11 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Sat, 8 Apr 2023 06:34:11 -0500
Received: from [10.249.133.214] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 338BY8YC089280;
        Sat, 8 Apr 2023 06:34:09 -0500
Message-ID: <83757273-26b5-118f-f18e-ab99986e668b@ti.com>
Date:   Sat, 8 Apr 2023 17:04:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH RFC v2 1/2] irqchip: irq-ti-sci-inta: Allocates VINTs at
 probe
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230327-irq-affinity-upstream-v2-0-1474e518f1cb@ti.com>
 <20230327-irq-affinity-upstream-v2-1-1474e518f1cb@ti.com>
 <87jzym64kg.wl-maz@kernel.org>
From:   "Raghavendra, Vignesh" <vigneshr@ti.com>
In-Reply-To: <87jzym64kg.wl-maz@kernel.org>
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



On 4/8/2023 4:09 PM, Marc Zyngier wrote:
> On Mon, 27 Mar 2023 16:04:26 +0100,
> Vignesh Raghavendra <vigneshr@ti.com> wrote:
>>
>> Simplify driver by allocating all VINTs at probe instead of
>> allocating on IRQ request. This will allow dedicating few VINTs as
>> direct IRQs without aggregation in future.
> 
> I think this is going in the wrong direction. Eager allocation is
> wasting memory, slowing down boot, and in general a bad idea.
> 
> Why can't you just pre-allocate *one* interrupt that serves as a
> chained handler for everything, and then use the rest of the interrupt
> space for "direct" interrupts?
> 


I may need more than one (at least 2 or 3), but I get the point.
Will rework accordingly.

Regards
Vignesh
