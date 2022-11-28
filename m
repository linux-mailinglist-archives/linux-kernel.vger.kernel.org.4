Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692E263B1AE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbiK1SzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiK1SzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:55:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA97F1E3E3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:55:20 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669661718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PWLIA/pxtxzHoAYO+XblQoP1kwn3WR6z8e/DGjKrDXU=;
        b=i3qJKuCSy+FtKT7UmDiIrv+n66NlVGz1iJNkF0aUSiO5E0TD7rfQgWmZ1+RB2eHw5pHYKu
        tC4XEpdw/m60zbTftkqnNMU/sfQdUt6gI8W5yPPpdnj+DIA+hCLLNkZn7whUKJZSeF0gRF
        K6zpEEvNZ1IHSwDa7r2iq+/ZCsv7GGlNbo1Wl11+QaGHzRHiSIOoKz8JAIv2elASq0l93i
        VCpJZz4YDVWXHfZQScRhGlbpUQ4vK3CGTGV4IecR9x83oh41CXIAhukB90RNjPsWNs09gI
        wns8TLpW4G+euK4uOCJpSRq5DDNBAbwgQsiZ5r1eH7qeojiszR5vrs1yo47kjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669661718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PWLIA/pxtxzHoAYO+XblQoP1kwn3WR6z8e/DGjKrDXU=;
        b=slLuzlTSMMTJf2ylwAr4zRBMKsP/LCSkM7LGcDFNXg4+LcoJubR6bAX7iHrK+mKT9Hpgf1
        ArAZerk8G2nRI3Dw==
To:     Greg KH <gregkh@linuxfoundation.org>,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     kraig@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] genirq/irqdesc: fix WARNING in irq_sysfs_del()
In-Reply-To: <Y4Tt2NIcPFeoss4s@kroah.com>
References: <20221128151612.1786122-1-yangyingliang@huawei.com>
 <Y4Tt2NIcPFeoss4s@kroah.com>
Date:   Mon, 28 Nov 2022 19:55:17 +0100
Message-ID: <87zgcavrhm.ffs@tglx>
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

On Mon, Nov 28 2022 at 18:20, Greg KH wrote:
> On Mon, Nov 28, 2022 at 11:16:12PM +0800, Yang Yingliang wrote:
>> @@ -292,6 +292,8 @@ static void irq_sysfs_add(int irq, struct irq_desc *desc)
>>  		 */
>>  		if (kobject_add(&desc->kobj, irq_kobj_base, "%d", irq))
>>  			pr_warn("Failed to add kobject for irq %d\n", irq);
>> +		else
>> +			desc->sysfs_added = true;
>
> Wait, no.  Why are you just not properly failing and unwinding here?

There is an issue here.

sysfs is not yet available when the first interrupts are allocated. So
we add the sysfs files late in the boot.

So what can we do if that fails? Unwind the boot process? :)

Sure we can fail after sysfs has been initialized, but that's
inconsistent at best and we need some special treatment for the late add
anyway.

I agree that this is not pretty, but the resulting choices are all but
pretty.

Thanks,

        tglx


