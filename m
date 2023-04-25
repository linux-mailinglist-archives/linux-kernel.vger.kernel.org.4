Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05DA6EE2B2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbjDYNT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbjDYNTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:19:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12022210C;
        Tue, 25 Apr 2023 06:19:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2BA74B3;
        Tue, 25 Apr 2023 06:20:07 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 574FE3F64C;
        Tue, 25 Apr 2023 06:19:21 -0700 (PDT)
Date:   Tue, 25 Apr 2023 14:19:18 +0100
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
Message-ID: <20230425131918.5tf5vot4h7jf54xk@bogus>
References: <20230424073020.4039-1-lihuisong@huawei.com>
 <e0c4f4b5-8b34-4542-b676-f98ddb8ef586@app.fastmail.com>
 <20230425103040.znv66k364ant6klq@bogus>
 <c7d9c3c5-e400-c60a-52e0-0f267ec8c517@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7d9c3c5-e400-c60a-52e0-0f267ec8c517@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 09:00:31PM +0800, lihuisong (C) wrote:
> 
> For firmware, DSD way is simpler and easier to manage these virtual platform
> devices, and it's an usual way in kernel.

Any specific examples you are referring here. We had lots of debate when
DSD was introduced. It must be used only when there is no standard ACPI
way to achieve the same. But in this I don't (yet) think that is the case.
Further "simplicity" is remotely not the reason why you must use DSD.
So until you provide me technical reasons as why _CRS can't work, I
have to NACK this approach. DSD in this case seems like pure hack.

> Driver only needs to get a fixed value, like pcc-id and type, here.
>

Yes and _CRS is used to get similar such properties in ACPI. It includes
normally MMIO and interrupts and since GAS supports PCC and _CRS can
contain GAS, you must simply use that.

> Any vantage if using _CRS with GAS compared with DSD?

Simple IMO, it is also existing standard to achieve things you are trying
to here and DSD is not. You are defining new properties to make DSD work.

So the real question is if _CRS can be used what is the point in defining
DSD for that. Unless I hear more technical and solid reasoning, I see
DSD as just hack and misuse here. It wasn't designed for that and must not
be allowed to make use of it for such use case.

Anyways in case we decide to take DSD route(after more deeper and technical
discussions), as in the kernel docs, please refer [1] for DSD. You need
to publish properties there so that no one comes up with similar but
alternate solution to do exactly this.

> > quite understand what magic the flags contain here to provide any info
> > there.
> This flag is used to report other properties, and every bit means a
> property.
> For instance, driver doesn't need to request PCC channel during the probing
> phase if driver use PCC operation Region.

Sorry I still don't understand it fully.

-- 
Regards,
Sudeep

[1] https://github.com/UEFI/DSD-Guide
