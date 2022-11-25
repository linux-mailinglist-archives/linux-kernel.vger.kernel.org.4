Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDACA6386E4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiKYJ64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKYJ4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:56:50 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A5B03FB8B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 01:54:44 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9416923A;
        Fri, 25 Nov 2022 01:54:50 -0800 (PST)
Received: from bogus (unknown [10.57.6.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C763C3F73B;
        Fri, 25 Nov 2022 01:54:41 -0800 (PST)
Date:   Fri, 25 Nov 2022 09:54:38 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     =?utf-8?B?546L5rSq6L6J?= <honghui.wang@ucas.com.cn>
Cc:     Hanjun Guo <guohanjun@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Maruss <cristian.marussi@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?UmXvvJpSZQ==?= =?utf-8?Q?=3A?= [PATCH 3/3] arm_scpi:
 modify to support acpi
Message-ID: <20221125095438.o6li7xgib27x5nb7@bogus>
References: <tencent_3D435BAB4430B7F532CF2ADD@qq.com>
 <9732f012-f2f5-d770-c9b7-6005fa0c578f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9732f012-f2f5-d770-c9b7-6005fa0c578f@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 09:38:42AM +0800, Hanjun Guo wrote:
> Hi Honghui,
> 
> On 2022/11/24 22:17, 锟斤拷锟斤拷锟? wrote:
> > Thanks!
> > 
> > The uefi firmware was built include ACPI/AML, but current kernel code is
> > not able to extract the info, the ACPI/AML driver of kernel is not enough
> > for majority of  devices , but fdt driver is. I think there's a lot of
> > work to support more acpi driver.
> 
> I think the firmware did the wrong thing about SCPI support,
> please take a look at ACPI 6.5, chapter 14 Platform Communications
> Channel (PCC).
>

Thanks Hanjun for pin pointing the exact references in the ACPI spec.

Hi Wang,

You seemed to be posting random patches to add SCPI support in ACPI.
You will get a NACK on all unless you explore PCC and PCC OpRegion in
ACPI and update your firmware to make it work on your platform.
You had sent a patch updating the mailbox driver which is not present
in the upstream. You must not need that driver when you use PCCT in
the ACPI firmware, so please drop the driver and any changes to that
as well. Without seeing the actual driver you are using with SCPI, I
can't help much on how to use it with PCC. Please refer chapter 14 as
Hanjun mention and check how to write one to your platform. Think
PCCT as mailbox node equivalent in DT and you *must not* just add similar
node in your ACPI DSDT with some custom HID/CID.

Hope this helps and gives you better idea on the suggestions made so far.

-- 
Regards,
Sudeep
