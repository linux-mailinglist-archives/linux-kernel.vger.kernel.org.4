Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163DF702D9F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241267AbjEONJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242311AbjEONJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:09:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 811532D57;
        Mon, 15 May 2023 06:08:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C941B2F4;
        Mon, 15 May 2023 06:08:56 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C55EF3F67D;
        Mon, 15 May 2023 06:08:09 -0700 (PDT)
Date:   Mon, 15 May 2023 14:08:07 +0100
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
Message-ID: <20230515130807.pdvx7bxwjkfdsmsr@bogus>
References: <20230424073020.4039-1-lihuisong@huawei.com>
 <e0c4f4b5-8b34-4542-b676-f98ddb8ef586@app.fastmail.com>
 <20230425103040.znv66k364ant6klq@bogus>
 <c7d9c3c5-e400-c60a-52e0-0f267ec8c517@huawei.com>
 <20230425131918.5tf5vot4h7jf54xk@bogus>
 <db6c713c-f99c-fa3f-8d38-9a5d50889cc2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db6c713c-f99c-fa3f-8d38-9a5d50889cc2@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 09:16:16PM +0800, lihuisong (C) wrote:
>
> I'm tring to use CRS with GAS to report PCC channel ID and get other
> informations driver need by address.

OK you had pcc-chan-id pcc-type and device-flags in the DSD style bindings
to begin with. I haven't understood device-flags here so can't comment on
that.

> I found a way to obtain the generic register information according to
> "Referencing the PCC address space" in ACPI spec.
> And driver also get the PCC generic register information successfully.
>

Can you elaborate ? I assume by that you must be able to get pcc-chan-id
right ? You must not need pcc-type as the pcc mailbox driver must handle
the type for you. If not, we may need to fix or add any missing support.

> But I don't know how to set and use the address in PCC register.

It must be same as what you would have specified in you new bindings
under "pcc-chan-id". I am confused as you say you were able to get the
PCC generic register information successfully but you still claim you
don't know how to set or use the address.

> Where should this address come from?
> It seems that ACPI spec is not very detailed about this.
> Do you have any suggestions?
>

I am afraid, I don't have any as I am failing to understand the exact issue
you are facing. 

Let me try to ask the question explicity here: 

If you are just referring to just the <RegisterAddress,> in

Register (PCC, RegisterBitWidth, RegisterBitOffset, RegisterAddress, AccessSize)

then,

RegisterAddress is usually the offset in the comms address associated with
the PCC subspace ID specified in AccessSize. Yes the use of AccessSize for
the PCC subspace ID is bit confusing though.

You can either list all the registers with _CRS individually or the driver
can just use the PCC subspace ID in AccessSize and keep RegisterAddress = 0
but access individual offset based on its own knowledge. I haven't seen the
full driver yet but I assuming that's how you would have used if you went with
your DSD pcc-chan-id proposal.

> On the other hand, we think that System Memory space + method can also
> achieve above goal. What do you think of that?

Again I don't understand what you mean by that.

-- 
Regards,
Sudeep
