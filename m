Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EC57260D5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240225AbjFGNNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240106AbjFGNNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:13:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7B7A6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 06:13:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 669E4614B2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 13:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29C2C433B4;
        Wed,  7 Jun 2023 13:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686143589;
        bh=UmnVtZ1aNvMxTRUFLoDpS3EQUEEKEzR4LcVjS/ySPgU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AmZo4yZ3jMBf52B9BuBQalBdSn/VkdAh4ngDQTmL8YKDBD5ebj1nmefOypkNS995j
         zL47vmwfg2+rZzhzOT/hptaQjrj5wC6mTrkzwNYRwULw2aJhprHamsf1P/syQunF8h
         uoXAVjakXZFWlSLxweRNWixhMDnHnh7frWUExYRB9L+dI7LmsW3k9u4YTCexIt6YW2
         J0KsN2EzXqAf9YYxm2l0ev6VSZu3E0eHf8NjicPVeyQFWEFyO8OQYU1dLaQuqXQcVh
         o+mF0FTiJMeQayIOm/5kwR6MVBvrqck2ksZdze+ZIrEGUSVWiw2Ffzh2rxKwLmkJwj
         iPNCDQcmMvUqw==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1q6syJ-003V4T-El;
        Wed, 07 Jun 2023 14:13:07 +0100
MIME-Version: 1.0
Date:   Wed, 07 Jun 2023 14:13:02 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     "Gowans, James" <jgowans@amazon.com>
Cc:     tglx@linutronix.de, "Raslan, KarimAllah" <karahmed@amazon.com>,
        liaochang1@huawei.com, linux-kernel@vger.kernel.org,
        zouyipeng@huawei.com, chris.zjh@huawei.com
Subject: Re: [PATCH v3 2/2] genirq: fasteoi supports resend on concurrent
 invoke
In-Reply-To: <9c831b0b0b0f067f48841903b5173e3c97f84292.camel@amazon.com>
References: <20230605155723.2628097-1-jgowans@amazon.com>
 <20230605155723.2628097-2-jgowans@amazon.com> <87jzwgo715.wl-maz@kernel.org>
 <9c831b0b0b0f067f48841903b5173e3c97f84292.camel@amazon.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <2fc0a230d79414ab2c2027ec02a022e3@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: jgowans@amazon.com, tglx@linutronix.de, karahmed@amazon.com, liaochang1@huawei.com, linux-kernel@vger.kernel.org, zouyipeng@huawei.com, chris.zjh@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-07 13:21, Gowans, James wrote:
> On Tue, 2023-06-06 at 18:05 +0100, Marc Zyngier wrote:
>> 
>> On Mon, 05 Jun 2023 16:57:23 +0100,
>> James Gowans <jgowans@amazon.com> wrote:
>> > ... and enable that functionality for GIC-v3 only.
>> 
>> nit: drop the multi-line subject.
> 
> Would you prefer two commits - one to introduce the functionality and 
> one
> to enable it for GIC-v3?

I'd prefer that. It is in general better to decouple driver stuff from
core code.

>> diff --git a/include/linux/irq.h b/include/linux/irq.h
>> > index b1b28affb32a..b76cc90faebd 100644
>> > --- a/include/linux/irq.h
>> > +++ b/include/linux/irq.h
>> > @@ -223,6 +223,8 @@ struct irq_data {
>> >   *                             irq_chip::irq_set_affinity() when deactivated.
>> >   * IRQD_IRQ_ENABLED_ON_SUSPEND       - Interrupt is enabled on suspend by irq pm if
>> >   *                             irqchip have flag IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND set.
>> > + * RQD_RESEND_WHEN_IN_PROGRESS       - Interrupt may fire when already in progress in which
>> > + *                             case it must be resent at the next available opportunity.
>> >   */
>> >  enum {
>> >       IRQD_TRIGGER_MASK               = 0xf,
>> > @@ -249,6 +251,7 @@ enum {
>> >       IRQD_HANDLE_ENFORCE_IRQCTX      = (1 << 28),
>> >       IRQD_AFFINITY_ON_ACTIVATE       = (1 << 29),
>> >       IRQD_IRQ_ENABLED_ON_SUSPEND     = (1 << 30),
>> > +     IRQD_RESEND_WHEN_IN_PROGRESS    = (1 << 31),
>> 
>> Make this unsigned, as it otherwise has the potential to sign-extend
>> and lead to "fun to debug" issues.
> 
> Ack, doing this change:
> 
> @@ -251,7 +251,7 @@ enum {
>         IRQD_HANDLE_ENFORCE_IRQCTX      = (1 << 28),
>         IRQD_AFFINITY_ON_ACTIVATE       = (1 << 29),
>         IRQD_IRQ_ENABLED_ON_SUSPEND     = (1 << 30),
> -       IRQD_RESEND_WHEN_IN_PROGRESS    = (1 << 31),
> +       IRQD_RESEND_WHEN_IN_PROGRESS    = (1U << 31),
>  };
> 
> (looks a bit odd having only this one unsigned though...)

Eventually, someone will bite the bullet and use BIT() everywhere.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
