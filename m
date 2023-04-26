Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2D96EF411
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 14:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240504AbjDZMM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 08:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjDZMMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 08:12:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631EF1BCB;
        Wed, 26 Apr 2023 05:12:23 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Q5yNH6HqJzLnlG;
        Wed, 26 Apr 2023 20:09:35 +0800 (CST)
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 20:12:19 +0800
Message-ID: <51025038-21e0-63ad-1286-ff426f6df5bc@huawei.com>
Date:   Wed, 26 Apr 2023 20:12:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] soc: hisilicon: Support HCCS driver on Kunpeng SoC
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>,
        <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <wanghuiqiang@huawei.com>, <tanxiaofei@huawei.com>,
        <liuyonglong@huawei.com>, <huangdaode@huawei.com>,
        <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230424073020.4039-1-lihuisong@huawei.com>
 <e0c4f4b5-8b34-4542-b676-f98ddb8ef586@app.fastmail.com>
 <20230425103040.znv66k364ant6klq@bogus>
 <c7d9c3c5-e400-c60a-52e0-0f267ec8c517@huawei.com>
 <20230425131918.5tf5vot4h7jf54xk@bogus>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20230425131918.5tf5vot4h7jf54xk@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/4/25 21:19, Sudeep Holla 写道:
> On Tue, Apr 25, 2023 at 09:00:31PM +0800, lihuisong (C) wrote:
>> For firmware, DSD way is simpler and easier to manage these virtual platform
>> devices, and it's an usual way in kernel.
> Any specific examples you are referring here. We had lots of debate when
> DSD was introduced. It must be used only when there is no standard ACPI
> way to achieve the same. But in this I don't (yet) think that is the case.
> Further "simplicity" is remotely not the reason why you must use DSD.
> So until you provide me technical reasons as why _CRS can't work, I
> have to NACK this approach. DSD in this case seems like pure hack.
>
>> Driver only needs to get a fixed value, like pcc-id and type, here.
>>
> Yes and _CRS is used to get similar such properties in ACPI. It includes
> normally MMIO and interrupts and since GAS supports PCC and _CRS can
> contain GAS, you must simply use that.
Hi Sudeep,
Can you give me some usage examples about this? I will try to do it.
>
>> Any vantage if using _CRS with GAS compared with DSD?
> Simple IMO, it is also existing standard to achieve things you are trying
> to here and DSD is not. You are defining new properties to make DSD work.
>
> So the real question is if _CRS can be used what is the point in defining
> DSD for that. Unless I hear more technical and solid reasoning, I see
> DSD as just hack and misuse here. It wasn't designed for that and must not
> be allowed to make use of it for such use case.
>
> Anyways in case we decide to take DSD route(after more deeper and technical
> discussions), as in the kernel docs, please refer [1] for DSD. You need
> to publish properties there so that no one comes up with similar but
> alternate solution to do exactly this.
All right.
>
>>> quite understand what magic the flags contain here to provide any info
>>> there.
>> This flag is used to report other properties, and every bit means a
>> property.
>> For instance, driver doesn't need to request PCC channel during the probing
>> phase if driver use PCC operation Region.
> Sorry I still don't understand it fully.
If a driver uses type2 with polling way on one platform, and uses PCC 
operation Region way to obtain some information on other platform.
The driver doesn't need to request PCC channel when it uses PCC 
Operation Region.
So this driver must be aware of the communication way in advance in a 
way during initialization.

>
