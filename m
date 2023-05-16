Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C076704DCC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbjEPM3l convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 16 May 2023 08:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjEPM3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:29:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29D8A4C13;
        Tue, 16 May 2023 05:29:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 544EF2F4;
        Tue, 16 May 2023 05:30:21 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 336033F663;
        Tue, 16 May 2023 05:29:34 -0700 (PDT)
Date:   Tue, 16 May 2023 13:29:31 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "lihuisong (C)" <lihuisong@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        soc@kernel.org, wanghuiqiang@huawei.com, tanxiaofei@huawei.com,
        liuyonglong@huawei.com, huangdaode@huawei.com,
        linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] soc: hisilicon: Support HCCS driver on Kunpeng SoC
Message-ID: <20230516122931.il4ai7fyxdo5gsff@bogus>
References: <20230424073020.4039-1-lihuisong@huawei.com>
 <e0c4f4b5-8b34-4542-b676-f98ddb8ef586@app.fastmail.com>
 <20230425103040.znv66k364ant6klq@bogus>
 <c7d9c3c5-e400-c60a-52e0-0f267ec8c517@huawei.com>
 <20230425131918.5tf5vot4h7jf54xk@bogus>
 <db6c713c-f99c-fa3f-8d38-9a5d50889cc2@huawei.com>
 <20230515130807.pdvx7bxwjkfdsmsr@bogus>
 <aa5b1919-74c6-1f97-78af-ab5f0904c3ce@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <aa5b1919-74c6-1f97-78af-ab5f0904c3ce@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 03:35:54PM +0800, lihuisong (C) wrote:
>
> 在 2023/5/15 21:08, Sudeep Holla 写道:
> > On Thu, May 04, 2023 at 09:16:16PM +0800, lihuisong (C) wrote:
> > > I'm tring to use CRS with GAS to report PCC channel ID and get other
> > > informations driver need by address.
> > OK you had pcc-chan-id pcc-type and device-flags in the DSD style bindings
> > to begin with. I haven't understood device-flags here so can't comment on
> > that.
>
> We want to use the 'device-flags' to report some information by bit.

Please give more details, until then NACK for the idea.

> Currently, this driver requests PCC channel and use type2 to communicate
> with firmware.

OKAY...

> But, if some platform support type3 and PCC Operation Region, driver can
> choice this method to communicate with firmware.
> So firmware and driver have to use this flag to make compatibility.
>

I would rather add such things to the spec if it is any sort of limitation
with the current specification.

> >
> > > I found a way to obtain the generic register information according to
> > > "Referencing the PCC address space" in ACPI spec.
> > > And driver also get the PCC generic register information successfully.
> > >
> > Can you elaborate ? I assume by that you must be able to get pcc-chan-id
>
> Yes，driver can get pcc-chan-id by below register.
>
> Register (PCC, RegisterBitWidth, RegisterBitOffset, RegisterAddress, AccessSize)
>

Good to know.

> > right ? You must not need pcc-type as the pcc mailbox driver must handle
> > the type for you. If not, we may need to fix or add any missing support.
> Yes, PCC driver doesn't support it currently. And aother patch [1] we've
> been talking about does it.
> If it is applied to kernel, we can drop this pcc-type here.
>
> [1] https://patchwork.kernel.org/project/linux-acpi/patch/20230423110335.2679-2-lihuisong@huawei.com/

OK then we are good, no need for pcc-type then ?

> >
> > > But I don't know how to set and use the address in PCC register.
> > It must be same as what you would have specified in you new bindings
> > under "pcc-chan-id". I am confused as you say you were able to get the
> > PCC generic register information successfully but you still claim you
> > don't know how to set or use the address.
> My confusion about this address is mentioned below.

OK

> > > Where should this address come from?
> > > It seems that ACPI spec is not very detailed about this.
> > > Do you have any suggestions?
> > >
> > I am afraid, I don't have any as I am failing to understand the exact issue
> > you are facing.
> >
> > Let me try to ask the question explicity here:
> >
> > If you are just referring to just the <RegisterAddress,> in
> >
> > Register (PCC, RegisterBitWidth, RegisterBitOffset, RegisterAddress, AccessSize)
> Yeah, this is what I'm using.
> >
> > then,
> >
> > RegisterAddress is usually the offset in the comms address associated with
> Communication subspace in share memory of PCC subspace?
> > the PCC subspace ID specified in AccessSize. Yes the use of AccessSize for
> > the PCC subspace ID is bit confusing though.
> >
> > You can either list all the registers with _CRS individually or the driver
> List all the registers as following way?
> Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
> {
>     QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed,
> NonCacheable, ReadWrite,
>         0x0000000000000000, // Granularity
>         0x0000000098190000, // Range Minimum
>         0x000000009819FFFF, // Range Maximum
>         0x0000000000000000, // Translation Offset
>         0x0000000000010000, // Length
>         ,, , AddressRangeMemory, TypeStatic)
> })

Not sure if you can use QWordMemory here TBH.

> > can just use the PCC subspace ID in AccessSize and keep RegisterAddress = 0
> > but access individual offset based on its own knowledge. I haven't seen the
> Following words come from ACPI spec.
> -->
> As an example, the following resource template refers to the feld occupying
> bits 8 through 15 at address 0x30 in PCC
> subspace 9:
> ResourceTemplate()
> {
> Register (
>     PCC, //AddressSpaceKeyword
>     8, //RegisterBitWidth
>     8, //RegisterBitOffset
>    pcc 0x30, //RegisterAddress
>     9 //AccessSize (subspace ID)
>     )
> }
>
> If the width of the address is 32bit, set RegisterAddress to 0,
> RegisterBitOffset to 0 and set RegisterBitWidth to 64 here.
> Driver can access to the ((void __iomem *)pcc_comm_addr + 0x8 + 0) and
> ((void __iomem *)pcc_comm_addr + 0x8 + 4) address，right?
> (This virtual address = pcc mapped address + header size + offset within PCC
> subspace.)

Yes that's my understanding. I remember seeing the driver is just fetching
pcc-chan-id using DSD style key-value pair, which means you don't need
any other info other than the PCC subspace/channel ID, just have address
as 0.

Also I see the driver uses type for just rejecting the type 3 PCCT. The
question is will the driver probe and run on a platform with type 3 PCCT ?
If so what is the problem running on such a platform. I see it is useless
check in the driver and can be dropped. Also the comment above enum
HCCS_DEV_FLAGS_INTR_B is confusing and  so is the way flags is used.

> > full driver yet but I assuming that's how you would have used if you went with
> > your DSD pcc-chan-id proposal.
> >
> > > On the other hand, we think that System Memory space + method can also
> > > achieve above goal. What do you think of that?
> > Again I don't understand what you mean by that.
> Sorry, here is what I want to say.
> -->
> OperationRegion (CCS0, SystemMemory, 0x00000002081000CC, 0x04)
> Field (CCS0, DWordAcc, NoLock, Preserve)
> {
>     HAU1,   32
> }
> OperationRegion (CCS1, SystemMemory, 0x0000000201070410, 0x04)
> Field (CCS1, DWordAcc, NoLock, Preserve)
> {
>     HCGE,   32
> }
> Method (_DSM, 2, Serialized)  // _DSM: Device-Specific Method
> {
>     If ((Arg0 == ToUUID ("b06b81ab-0134-4a45-9b0c-483447b95fa7")))
>     {
>         If ((Arg1 == One))
>         {
>             Return (HAU1)
>         }
>
>         Return (HCGE)
>     }
> }
>
> Driver can call _DSM method to get some information, such as pcc_chan_id and
> device_flags.

Big fat NACK for _DSM for the above purpose, please stop abusing _DSM or _DSD
for such information which can be obtained with the existing _CRS.

--
Regards,
Sudeep
