Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DF26AED35
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjCGSC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjCGSBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:01:38 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543DDA8C6B;
        Tue,  7 Mar 2023 09:55:17 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 327HtC3L107157;
        Tue, 7 Mar 2023 11:55:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678211712;
        bh=RHjVOkhS+PdNKIbetrzo3N3lCUek1ZDu88rLwnpcBU0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=mftZpQ8WJDgQOf/EslR3JkRz8/DMh69fIWvefRO/8o0Dj+BL21zPjbcOOxiCeZxmR
         8IX4PbeshFMefIoY5tsFQMfVMLAfGP+UgoQtI0nUv2KdOW5ScVKqJq5VmJqNY2oB9N
         D5y+Akri7CnnrrfC2h8wOFX/FByHx2sS8By+lUco=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 327HtCcD106815
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Mar 2023 11:55:12 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 7
 Mar 2023 11:55:12 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 7 Mar 2023 11:55:12 -0600
Received: from [128.247.81.39] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 327HtCwa007749;
        Tue, 7 Mar 2023 11:55:12 -0600
Message-ID: <b6e4ae3f-a3ff-b118-43ce-a45d007ae2e9@ti.com>
Date:   Tue, 7 Mar 2023 11:55:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 4/6] gpio: pisosr: Use devm_gpiochip_add_data() to
 simplify remove path
Content-Language: en-US
To:     Andy Shevchenko <andy@kernel.org>
CC:     Peter Tyser <ptyser@xes-inc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230307165432.25484-1-afd@ti.com>
 <20230307165432.25484-4-afd@ti.com> <ZAd35D4C96MP5Qrm@smile.fi.intel.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <ZAd35D4C96MP5Qrm@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/23 11:44 AM, Andy Shevchenko wrote:
> On Tue, Mar 07, 2023 at 10:54:30AM -0600, Andrew Davis wrote:
>> Use devm version of gpiochip add function to handle removal for us.
>>
>> While here update copyright and module author.
> 
> ...
> 
>> -	mutex_destroy(&gpio->lock);
> 
> You need to wrap this into devm.
> 

I was thinking that but it seems there is no such thing. Most drivers
just ignore unwinding mutex_init() since it doesn't allocate anything.

mutex_destroy() is a NOP unless you are doing DEBUG builds were
it sets a magic value to check for use-after-free issues.

Andrew
