Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C070068D42B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjBGK3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjBGK3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:29:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D13430281
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:29:19 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675765758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=frkmIWsRvasMuS2qy8Vy6B6oZC8gT12cpOdYjVtbbbY=;
        b=Vd00BSMzjXlvYG5StAdZW7Bl8qDnQDMg/P4dy/Yd1lSk9GFMWOcOqYBHVAjEzNIY2Bqd9K
        8S934gfljcgsdmEi5hBuH3dPfhS1iu9wq+ocICKQ6NPmyr3iPCnyV8fv0xVIrK91llHsG6
        qwy3aWDXWWCVOWX7dwB5iCvgzTOeUWL87v6WWO6az1D3f141pgGeuZ/+aMdlcNp8V8YBH5
        WOnclTCj5Ulq90EXO6kJF7L3ATbf/rsv2e7+CoVRXwsozXahVEK59u/FUfRyc4290mLlZw
        11b015gyMAGXUd+tavnRhd2locT93LEHqHfsNespUIyHLXWey+nKjgK6miRt2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675765758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=frkmIWsRvasMuS2qy8Vy6B6oZC8gT12cpOdYjVtbbbY=;
        b=vdq8sZUGznSKxslQoYEH/BVob8oFdJrMI/PE1PxxJjdaHvcF4rrG06r4dBx1nS1CuKtDoT
        7bR/kDHncMAqIdAg==
To:     Shanker Donthineni <sdonthineni@nvidia.com>,
        Marc Zyngier <maz@kernel.org>, Michael Walle <michael@walle.cc>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] genirq: Use the common function irq_expand_nr_irqs()
In-Reply-To: <0ef7b7be-4132-669a-448d-ce7c9f198d57@nvidia.com>
References: <20230130005725.3517597-1-sdonthineni@nvidia.com>
 <20230130005725.3517597-5-sdonthineni@nvidia.com> <87h6w711yc.ffs@tglx>
 <0ef7b7be-4132-669a-448d-ce7c9f198d57@nvidia.com>
Date:   Tue, 07 Feb 2023 11:29:17 +0100
Message-ID: <877cwtwyyq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31 2023 at 10:43, Shanker Donthineni wrote:
> On 1/31/23 03:35, Thomas Gleixner wrote:
>>> +static int irq_expand_nr_irqs(unsigned int nr)
>>> +{
>>> +     if (nr > MAX_SPARSE_IRQS)
>>> +             return -ENOMEM;
>>> +     nr_irqs = nr;
>>> +     return 0;
>>> +}
>> 
>> or preferrably something like this:
>> 
>>          if (!IS_ENABLED(CONFIG_SPARSEIRQ) || nr > MAX_SPARSE_IRQS)
>>                  return -ENOMEM;
>> 
>> which makes it entirely clear and also allows the compiler to optimize
>> is down to a 'return -ENOMEM'.
>> 
> I'll drop this patch since you're suggesting to remove !SPARSEIRQ support.

Sometime in the future when I analyzed what the implications are. So
just keep it and make it readable.

Thanks,

        tglx

