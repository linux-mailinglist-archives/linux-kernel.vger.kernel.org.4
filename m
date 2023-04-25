Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8376EE060
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 12:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjDYKau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 06:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbjDYKas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 06:30:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFDED13E;
        Tue, 25 Apr 2023 03:30:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E06A2F4;
        Tue, 25 Apr 2023 03:31:29 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7A423F5A1;
        Tue, 25 Apr 2023 03:30:42 -0700 (PDT)
Date:   Tue, 25 Apr 2023 11:30:40 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>, Huisong Li <lihuisong@huawei.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
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
Message-ID: <20230425103040.znv66k364ant6klq@bogus>
References: <20230424073020.4039-1-lihuisong@huawei.com>
 <e0c4f4b5-8b34-4542-b676-f98ddb8ef586@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0c4f4b5-8b34-4542-b676-f98ddb8ef586@app.fastmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Arnd for cc-ing the ALKML.

On Mon, Apr 24, 2023 at 10:09:47AM +0200, Arnd Bergmann wrote:
> On Mon, Apr 24, 2023, at 09:30, Huisong Li wrote:

[...]

> > +
> > +static int hccs_get_device_property(struct hccs_dev *hdev)
> > +{
> > +	struct device *dev = hdev->dev;
> > +
> > +	if (device_property_read_u32(dev, "device-flags", &hdev->flags)) {
> > +		dev_err(hdev->dev, "no device-flags property.\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	if (device_property_read_u8(dev, "pcc-type", &hdev->type)) {
> > +		dev_err(hdev->dev, "no pcc-type property.\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	if (device_property_read_u32(dev, "pcc-chan-id", &hdev->chan_id)) {
> > +		dev_err(hdev->dev, "no pcc-channel property.\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	hdev->intr_mode = hccs_get_bit(hdev->flags, HCCS_DEV_FLAGS_INTR_B);
> > +	if (!hccs_dev_property_supported(hdev))
> > +		return -EOPNOTSUPP;
> > +
>
> Where are the device properties documented? I'm never quite sure how
> to handle these for ACPI-only drivers, since we don't normally have the
> bindings in Documentation/devicetree/bindings/, but it feels like there
> should be some properly reviewed document somewhere else.
>
> Adding ACPI and devicetree maintainers to Cc for clarification.

Why are these DSD style properties added here ? Why can't we just make
use of _CRS with Generic Address Structure(GAS) register entry for each
of the PCC channel which eliminates the need of "pcc-chan-id". The type
must be deduced from the order in the list of _CRS if needed. I don't
quite understand what magic the flags contain here to provide any info
there.

--
Regards,
Sudeep
