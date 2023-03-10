Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F246B4F92
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjCJRy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjCJRyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:54:20 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21E5E9832;
        Fri, 10 Mar 2023 09:54:17 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32AFFK7V011608;
        Fri, 10 Mar 2023 18:21:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=YlmLOht25d1B1Huzy9T+x0MO+6RZN6cC1UZx/AC2t0M=;
 b=DuK/G3tC4ceOg/WF5XKpg5GXgb9s/jvah2H/XOSMFIlL7+ia/vuyOO2Yrc0HjwXxq5/X
 K8gBLmbBtGVDplSPYjDwOwpi5ev21nwtya3lwbg/el6j+0XApl8r7xW6o7HCXx+PmjcP
 tXBkOCBoCAeX4q3uFjSUT4pSjRkLV2T3OqgTGVUbzY4jImksZMRM4tOepIYDv36W1EHZ
 dtVLbjomrYAYz+TjECAtN/SIzqdWCBUiQ9Y4gVlEO2pL2YwzbhkmLjQhhDBsBnNxgc5U
 IkBWlisqJieEBSktLYkOhCGFGX/TucqCuQr8in0nj9DvIyG5+oCtTQ7eDFGQLXvWfgJ+ 1g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3p7vynd7k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 18:21:00 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5891D10002A;
        Fri, 10 Mar 2023 18:20:57 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3840521BF45;
        Fri, 10 Mar 2023 18:20:57 +0100 (CET)
Received: from [10.252.12.230] (10.252.12.230) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 10 Mar
 2023 18:20:53 +0100
Message-ID: <aca28784-c526-566b-dd7c-9cfda17e697a@foss.st.com>
Date:   Fri, 10 Mar 2023 18:20:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 0/4] Remove use of fw_devlink_purge_absent_suppliers()
To:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>
CC:     Yongqin Liu <yongqin.liu@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        <kernel-team@android.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20230301214952.2190757-1-saravanak@google.com>
Content-Language: en-US
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20230301214952.2190757-1-saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.12.230]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_08,2023-03-10_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/23 22:49, Saravana Kannan wrote:
> Yongqin, Martin, Amelie,
> 
> We recent refactor of fw_devlink that ends with commit fb42378dcc7f
> ("mtd: mtdpart: Don't create platform device that'll never probe"),
> fw_devlink is smarter and doesn't depend on compatible property. So, I
> don't think these calls are needed anymore. But I don't have these
> devices to test on and be sure and the hardware I use to test changes
> doesn't have this issue either.
> 
> Can you please test these changes on the hardware where you hit the
> issue to make sure things work as expected?


Hi Saravana,

Sorry for the late reply,
On behalf of Amelie, I did some testing on STM32MP15 DK2 board, on top
of commit fb42378dcc7f, and also with your series applied.
For reference, it's based on: arch/arm/boot/dts/stm32mp15xx-dkx.dtsi

I noticed some error messages on this board, since the 12 patch series,
around the I2C PMIC device links:

[    3.585514] i2c 1-0033: Failed to create device link with 1-0033
[    3.590115] i2c 1-0033: Failed to create device link with 1-0033
[    3.596278] i2c 1-0033: Failed to create device link with 1-0033
[    3.602188] i2c 1-0033: Failed to create device link with 1-0033
[    3.608165] i2c 1-0033: Failed to create device link with 1-0033
[    3.614278] i2c 1-0033: Failed to create device link with 1-0033
[    3.620256] i2c 1-0033: Failed to create device link with 1-0033
[    3.626253] i2c 1-0033: Failed to create device link with 1-0033
[    3.632252] i2c 1-0033: Failed to create device link with 1-0033
[    3.639001] stpmic1 1-0033: PMIC Chip Version: 0x10
[    3.645398] platform 5c002000.i2c:stpmic@33:regulators: Fixed
dependency cycle(s) with /soc/i2c@5c00200
0/stpmic@33/regulators/boost
[    3.655937] platform 5c002000.i2c:stpmic@33:regulators: Fixed
dependency cycle(s) with /soc/i2c@5c00200
0/stpmic@33/regulators/buck2
[    3.667824] platform 5c002000.i2c:stpmic@33:regulators: Fixed
dependency cycle(s) with /soc/i2c@5c00200
0/stpmic@33/regulators/buck4
[    3.719751] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators:
Failed to create device link with 1-0033
[    3.728099] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators:
Failed to create device link with 1-0033
[    3.737576] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators:
Failed to create device link with 1-0033
[    3.747216] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators:
Failed to create device link with 1-0033
[    3.756750] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators:
Failed to create device link with 1-0033
[    3.766382] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators:
Failed to create device link with 1-0033
[    3.775914] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators:
Failed to create device link with 1-0033
[    3.785545] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators:
Failed to create device link with 1-0033

Strangely some of the regulators seems to have "Fixed dependency", but
not all.

Regarding the typec stusb160x I noticed the message below. It seems
correct, right ?

[   15.962771] typec port0: Fixed dependency cycle(s) with
/soc/usb-otg@49000000/port/endpoint

But sometimes (lets say 1/5 times) during boot, when I have a cable
already plugged in, it looks like there's some race condition. The dwc2
driver reports some error logs in a loop, indefinitely, up to the
watchdog resets the platform :-(.

[   16.288458] dwc2 49000000.usb-otg: Mode Mismatch Interrupt: currently
in Host mode
[   16.288490] dwc2 49000000.usb-otg: Mode Mismatch Interrupt: currently
in Host mode
[   16.310429] dwc2 49000000.usb-otg: Mode Mismatch Interrupt: currently
in Host mode

It probably just points some already existing race condition here. Maybe
it isn't even linked to this patch. But I have no evidence at this
stage. I hope I can investigate further on this one, hopefully I can
free up some time for that.

Best Regards,
Fabrice

> 
> Yongqin, If you didn't have the context, this affected hikey960.
> 
> Greg,
> 
> Let's wait for some tests before we land these.
> 
> Thanks,
> Saravana
> 
> Cc: Yongqin Liu <yongqin.liu@linaro.org>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Martin Kepplinger <martin.kepplinger@puri.sm>
> Cc: Amelie Delaunay <amelie.delaunay@foss.st.com>
> 
> Saravana Kannan (4):
>   usb: typec: stusb160x: Remove use of
>     fw_devlink_purge_absent_suppliers()
>   usb: typec: tipd: Remove use of fw_devlink_purge_absent_suppliers()
>   usb: typec: tcpm: Remove use of fw_devlink_purge_absent_suppliers()
>   driver core: Delete fw_devlink_purge_absent_suppliers()
> 
>  drivers/base/core.c           | 16 ----------------
>  drivers/usb/typec/stusb160x.c |  9 ---------
>  drivers/usb/typec/tcpm/tcpm.c |  9 ---------
>  drivers/usb/typec/tipd/core.c |  9 ---------
>  include/linux/fwnode.h        |  1 -
>  5 files changed, 44 deletions(-)
> 
