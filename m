Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E96F70642D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjEQJam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjEQJak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:30:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0658BE4E;
        Wed, 17 May 2023 02:30:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46C571FB;
        Wed, 17 May 2023 02:31:23 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E7443F663;
        Wed, 17 May 2023 02:30:35 -0700 (PDT)
Date:   Wed, 17 May 2023 10:30:33 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "lihuisong (C)" <lihuisong@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        soc@kernel.org, wanghuiqiang@huawei.com, tanxiaofei@huawei.com,
        liuyonglong@huawei.com, huangdaode@huawei.com,
        linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] soc: hisilicon: Support HCCS driver on Kunpeng SoC
Message-ID: <20230517093033.4jvwjxuoeic46a24@bogus>
References: <20230425103040.znv66k364ant6klq@bogus>
 <c7d9c3c5-e400-c60a-52e0-0f267ec8c517@huawei.com>
 <20230425131918.5tf5vot4h7jf54xk@bogus>
 <db6c713c-f99c-fa3f-8d38-9a5d50889cc2@huawei.com>
 <20230515130807.pdvx7bxwjkfdsmsr@bogus>
 <aa5b1919-74c6-1f97-78af-ab5f0904c3ce@huawei.com>
 <20230516122931.il4ai7fyxdo5gsff@bogus>
 <f0733521-2557-fdaf-e59b-b10d515c487c@huawei.com>
 <20230516143530.venhj4gax6stinah@bogus>
 <a98e3620-57da-000e-f5ee-2c2e47e97906@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a98e3620-57da-000e-f5ee-2c2e47e97906@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 03:16:12PM +0800, lihuisong (C) wrote:

[...]

> No. I want to use this flag to make compability between different platforms.
> This driver only use PCC OpRegion to access to the channel if platform
> support use PCC OpRegion.

What do you mean by that ? It is not correct. If there is a PCC Opregion,
then you need to make it work with drivers/acpi/acpi_pcc.c

You need to have all the other details in the firmware(ASL). By looking
at the driver, it has no connection to PCC Opregion IMO unless I am missing
something.

> Driver must select one of them (PCC and PCC OpRegion) to communicate with
> firmware on one platform.

No for reasons mentioned above. PCC Opregion support in the kernel will
be minimal and already there. Fix that if it is not working. If you are
attempting to do something with PCC Opregion in this driver, it is just
wrong and I will NACK it if I see anything around that.

> > If so that may not work as the current implementation of PCC Opregion
> > assumes the exclusive access to the channel. Since it is initialised
> > quite early, Opregion must succeed to get the mbox channel acquired and
> > this driver must fail if they are sharing the channel. Making the sharing
> > across firmware and this driver may need changes in the PCC Opregion
> Only using PCC OpRegion after requesting and releasing PCC channel shouldn't
> change PCC OpRegion code?

I don't understand what exactly that means. The spec states clearly that
PCC subspaces that are used for PCC Operation Regions must not be used
as PCC subspaces for other std ACPI features. I don't understand what
really is going on, on this platform as I don't see what you are saying
(which is wrong and I disagree with approach) in the code posted yet.

> > support code. One possible way is to acquire and release the channel for
> > each transaction which will be definitely overhead.
> Yes, transaction will be definitely overhead.
> The following method should be no such problem.
> -->
> If driver want to obtain other info by RegisterAddress and offset in PCC
> Register(), driver generally needs to do it as follows:
> 1> get channel ID and RegisterAddress and offset.
> 2> call pcc_mbox_request_channel to acquire the channel.
> 3> ioremap 'shmem_base_addr' to get 'pcc_comm_addr'
> 4> obtain other info based on RegisterAddress, offset and 'pcc_comm_addr'.

Above sound good but it is not PCC Opregion. Either you are not giving
full context or you are confusing what PCC Opregion means. There is a
section "Declaring PCC Operation Regions", please refer and see if that
is what you have on your platform.

> If driver selects PCC OpRegion method, driver may also need to release this
> PCC channel by calling pcc_mbox_free_channel.

As I mentioned, the driver must not do anything related to PCC Opregion.

> Because this channel will be requested when PCC OpRegion method is executed
> for the first time.
>

drivers/acpi/acpi_pcc.c must take care of that. If not patch that and get
it working. It must be generic and nothing to do with your platform.

> 
> Overall, the above process is a bit cumbersome if this driver only use PCC
> OpRegion.

Yes and hence must not touch anything around PCC Opregion.

> In addition, I have to dig one address from comm space in share memory,
> which will cause the available size of comm space to decrease, right?
> So it is better to use other way to do get channel ID and other info if it
> is possible.
> What do you think?

I am more confused about your platform than yesterday, so I don't have
much valuable suggestions ATM.

-- 
Regards,
Sudeep
