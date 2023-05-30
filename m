Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4237165FE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjE3PED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjE3PEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:04:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E34D9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:03:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685459037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=ffd7BIo0RG9iYEAP05EAXIJsUhP7tH/wkxnbALKQ+m0=;
        b=IwUV7KM6ZNj17NS9CAfRur1vJUmtx4Cph/1uu3Ba+DFU3BdN+wLK18YG0o/BoXDKePZtfG
        1vHKW6dKZQRHq2NbthONWrkXWiCtWbYfkbbbXpDQng6jFIUCOankqi7lv0bUiYQpbtKiaP
        7jI3cN9/rZsOO6Ba23xxJg2QZ+FVJGxrreKQ4yGdDtc+3aFy+JB+91OqAYN4m/rfH2ZkU1
        8zXCwEaWDrE0W23dsvhAnWdr7DLT2nQkm8/YR6RZ7YCX9gpxGnqWpH4HJW4OHqQ2sp6d6B
        eWYT5ctp+fd0W/F7tYOSDEHBWzezIn9YZ455pSkIYq20d5olna6y/8wMgBTmvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685459037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=ffd7BIo0RG9iYEAP05EAXIJsUhP7tH/wkxnbALKQ+m0=;
        b=C8gi1+a+TmWm7vQmepAGS3aDZh41zdSM3zl8BECxun2kiqDr4gDHo6vQWMQ+2IRyNYCnER
        UBhyKg6+t+sXxaAA==
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 1/2] genirq/msi, platform-msi: Adjust return value of
 msi_domain_prepare_irqs()
In-Reply-To: <CAAhV-H6uZWgZQsVh=1-U2B4ZZZz6EPJ3gkv0mxHSNGOMPB=VwQ@mail.gmail.com>
Date:   Tue, 30 May 2023 17:03:56 +0200
Message-ID: <87zg5lj1yb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30 2023 at 16:34, Huacai Chen wrote:
> On Tue, May 30, 2023 at 4:19=E2=80=AFAM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> Let's take a step back and look at the larger picture:
>>
>>  1) A PCI/MSI irqdomain is attached to a PCI bus
>>
>>  2) The number of PCI devices on that PCI bus is usually known at boot
>>     time _before_ the first device driver is probed.
>>
>>     That's not entirely true for PCI hotplug devices, but that's hardly
>>     relevant for an architecture which got designed less than 10 years
>>     ago and the architects decided that 256 MSI vectors are good enough
>>     for up to 256 CPUs. The concept of per CPU queues was already known
>>     at that time, no?
> Does this solution depend on the per-device msi domain? Can we do that
> if we use the global msi domain?

In principle it should not depend on per-device MSI domains, but I
really don't want to add new functionality to the old operating models
as that does not create an incentive for people to convert their stuff
over.

>> So the irqdomain can tell the PCI/MSI core the maximum number of vectors
>> available for a particular bus, right?
>>
>> The default, i.e if the irqdomain does not expose that information,
>> would be "unlimited", i.e. ULONG_MAX.
> OK, thanks, but how to expose? By msi_domain_info::hwsize?

Probably. Needs a proper helper around it.

Thanks,

        tglx
