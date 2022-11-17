Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1AF62E250
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239864AbiKQQyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239783AbiKQQyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:54:06 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726B06CA01;
        Thu, 17 Nov 2022 08:54:05 -0800 (PST)
Received: from frapeml500003.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NCm8w429Gz67MQZ;
        Fri, 18 Nov 2022 00:49:20 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 17:54:03 +0100
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 17 Nov
 2022 16:54:03 +0000
Date:   Thu, 17 Nov 2022 16:54:02 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Gerald Loacker <gerald.loacker@wolfvision.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Jakob Hauser <jahau@rocketmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH 1/2] dt-bindings: iio: magnetometer: add ti tmag5273
 documentation file
Message-ID: <20221117165402.000043c0@huawei.com>
In-Reply-To: <8c2da24c-ae10-40c9-bb3e-b300975a86d7@linaro.org>
References: <20221115073718.2377311-1-gerald.loacker@wolfvision.net>
        <20221115073718.2377311-2-gerald.loacker@wolfvision.net>
        <20221115174355.00004a01@Huawei.com>
        <f52dcb6d-30ec-3d49-7e28-9761462d4799@wolfvision.net>
        <8c2da24c-ae10-40c9-bb3e-b300975a86d7@linaro.org>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022 17:17:24 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 17/11/2022 17:12, Gerald Loacker wrote:
> >>  
> >>> +
> >>> +  compatible:
> >>> +    const: ti,tmag5273
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  "#io-channel-cells":
> >>> +    const: 1
> >>> +
> >>> +  ti,angle-enable:
> >>> +    description:
> >>> +      Enables angle measurement in the selected plane.
> >>> +      0 = OFF
> >>> +      1 = X-Y (default)
> >>> +      2 = Y-Z
> >>> +      3 = X-Z  
> >>
> >> This feels like something we should be configuring at runtime rather that
> >> DT, or is it driven by board design or similar?
> >>  
> > 
> > We use this sensor for a zoom wheel application, there is an EVM from TI
> > for this as well. So this is for setting the mounting position of the wheel.  
> 
> That's ok, but does not explain why choice of angle measurement should
> be a property of the hardware. I could imagine configuring device to
> measure sometimes X-Y and sometimes X-Z, depending on the use case. Use
> case can change runtime.

If it's part of a physical device mounting, may well not be changeable at runtime
(at least not with out a screw driver / hacksaw etc.  Not really different form
arguing someone might rewire a sensor at runtime.  In theory possible but if they
do they are on their own - mostly we don't bother supporting them doing that.

So I think this is probably valid as a DT property.


> 
> 
> Best regards,
> Krzysztof
> 

