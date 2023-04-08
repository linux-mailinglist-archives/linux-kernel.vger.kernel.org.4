Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379546DBA74
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 13:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjDHLgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 07:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjDHLgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 07:36:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08472C650
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 04:36:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90A8761015
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 11:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE407C433D2;
        Sat,  8 Apr 2023 11:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680953801;
        bh=4sWQWQ7rAvQiBV0KZjcJLfMpSVh8t/1nW509H8PVZ8U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q5eCVM4YdR4u9Zd9ZN/81iyIWgsj7OFYpAZcpUKATtBUEHcDLJMYsnWFNySFnybOk
         nirTCXwyHtEioB5I4NfT6KlzlDtuqihqkDNIiqhqGnY91jItMCo1cbQ8R9DEutwu9x
         /SEBE/JmAwOLZqDiSXIktNwygWiXzpiQ7gYd3NZIuQBYTTZTzn/4ZO5OepOrwff1+x
         HOjx3m/9p/JgmBiYsRdw0Jx8hAT9ZcjycMUkWnXsuqXCkpvv7eN/S5f1oPa2QX/18q
         EbA4e/IMFcpiFS2RQaj6gBQLXVrkT7EWe4aXJsdjqVcSZ9O5g30+ZufJ1bM9Cc2den
         8haKM88E6MgNw==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1pl6s2-006uXl-JP;
        Sat, 08 Apr 2023 12:36:38 +0100
MIME-Version: 1.0
Date:   Sat, 08 Apr 2023 12:36:38 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     "Raghavendra, Vignesh" <vigneshr@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/2] irqchip: irq-ti-sci-inta: Add direct mapped
 interrupts
In-Reply-To: <d9d6dc1b-cc1d-d823-8777-3a8d6d2328f7@ti.com>
References: <20230327-irq-affinity-upstream-v2-0-1474e518f1cb@ti.com>
 <20230327-irq-affinity-upstream-v2-2-1474e518f1cb@ti.com>
 <87ile664i1.wl-maz@kernel.org> <d9d6dc1b-cc1d-d823-8777-3a8d6d2328f7@ti.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <c42185ee1b224fd7814b6e336a3fc3f5@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: vigneshr@ti.com, nm@ti.com, kristo@kernel.org, ssantosh@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-08 12:27, Raghavendra, Vignesh wrote:
> Hi,
> 
> On 4/8/2023 4:10 PM, Marc Zyngier wrote:
>>> +static unsigned int ti_sci_inta_direct_events_am62x[] = {
>>> +	/* CPSW etherenti DMA events */
>>> +	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 4627),
>>> +	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 4635),
>>> +	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 4643),
>>> +	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 4651),
>>> +	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 4659),
>>> +	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 4667),
>>> +	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 4675),
>>> +	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 4683),
>>> +	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 5651),
>>> +};
>>> +
>>> +static struct ti_sci_inta_soc_data soc_data_am62x = {
>>> +	.events_list = ti_sci_inta_direct_events_am62x,
>>> +	.events_list_size = ARRAY_SIZE(ti_sci_inta_direct_events_am62x),
>>> +};
>> I don't think these tables belong in a driver, and they are bound to
>> grow without any obvious limits.
> 
> Fair point.
> 
>> You have firmware tables that can express these things. Surely they 
>> can be put to a good use.
> 
> By firmware tables you mean device tree?

That, or any other machine-specific mean. From what I get of these
systems, they already make heavy use of some runtime firmware to get
things configured. That side could also provide setup information.

I don't mind either way, as long as we don't end-up with forever
growing in-kernel tables that are just board files in disguise.

           M.
-- 
Jazz is not dead. It just smells funny...
