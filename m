Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F69870697E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjEQNQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjEQNQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:16:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EECB7AAD;
        Wed, 17 May 2023 06:16:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36BB81FB;
        Wed, 17 May 2023 06:17:04 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D9BF3F7BD;
        Wed, 17 May 2023 06:16:17 -0700 (PDT)
Date:   Wed, 17 May 2023 14:16:14 +0100
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
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] soc: hisilicon: Support HCCS driver on Kunpeng SoC
Message-ID: <20230517131614.cwi2fcj2cngaq7dm@bogus>
References: <20230425131918.5tf5vot4h7jf54xk@bogus>
 <db6c713c-f99c-fa3f-8d38-9a5d50889cc2@huawei.com>
 <20230515130807.pdvx7bxwjkfdsmsr@bogus>
 <aa5b1919-74c6-1f97-78af-ab5f0904c3ce@huawei.com>
 <20230516122931.il4ai7fyxdo5gsff@bogus>
 <f0733521-2557-fdaf-e59b-b10d515c487c@huawei.com>
 <20230516143530.venhj4gax6stinah@bogus>
 <a98e3620-57da-000e-f5ee-2c2e47e97906@huawei.com>
 <20230517093033.4jvwjxuoeic46a24@bogus>
 <5ca49494-5a0c-4dc8-9cf5-fc4bc3b8e1b2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ca49494-5a0c-4dc8-9cf5-fc4bc3b8e1b2@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 07:35:25PM +0800, lihuisong (C) wrote:
> 
> 在 2023/5/17 17:30, Sudeep Holla 写道:
> > On Wed, May 17, 2023 at 03:16:12PM +0800, lihuisong (C) wrote:
> > 
> > [...]
> > 
> > > No. I want to use this flag to make compability between different platforms.
> > > This driver only use PCC OpRegion to access to the channel if platform
> > > support use PCC OpRegion.
> > What do you mean by that ? It is not correct. If there is a PCC Opregion,
> > then you need to make it work with drivers/acpi/acpi_pcc.c
> > 
> > You need to have all the other details in the firmware(ASL). By looking
> > at the driver, it has no connection to PCC Opregion IMO unless I am missing
> > something.
> Driver just needs to call these APIs, such as acpi_evaluate_integer(), if
> want to use PCC OpRegion.

OK, please provide examples. I am definitely lost as it doesn't match with
my understanding of how PCC Opregions are/can be used.

> I know that. I have tested PCC OpRegion before.

Cool, examples please.

> You've completely misunderstood what I said.😅
>

Hmm, may be but I need examples.

> I mean that this driver plans to support both PCC and PCC OpRegion.
> For example,
> Platform A: this driver use PCC (as the current implementation)

Good, then just keep what it needs in the implementation nothing more
until you add support for something you have described below(not that
I agree, just want you to make progress here based on what is actually
required today)

> Platform B: this driver use PCC OpRegion (Currently, this patch does not
> implement it, but it may be available in the future.)

Then let us discuss that in the future, don't add unnecessary complexity
for some future use case today. You can always add it when you introduce
that feature or support in the future.

> Note:
> This driver selects only one of them (PCC and PCC OpRegion) to communicate
> with firmware on one platform.

Let us keep it simple(KISS). The driver works just for PCC not PCC Opregion
for now.

> We use one bit in device-flags to know which one this driver will use.
>

NACK again just to re-iterate my point if you have not yet accepted that
fact.

> I'm not sure if you can understand what I mean by saing that.
> If you're not confused about this now, can you reply to my last email
> again?😁
>

The example you had IIRC is use of System Memory Opregion to demonstrate
some _DSM. That has nothing to do with PCC Opregion.

Commit 77e2a04745ff ("ACPI: PCC: Implement OperationRegion handler for
the PCC Type 3 subtype") has the example in the commit message. IIRC,
you have even fixed couple of bugs in that driver. That is the reason
why I don't understand how you think this driver and that can or must
work together. At least I fail to see how ATM(examples please, by that
I mean ASL snippet for PCC vs PCC Opregion usage to work with this driver)

-- 
Regards,
Sudeep
