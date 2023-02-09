Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C71690485
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 11:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjBIKUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 05:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjBIKUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 05:20:12 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B07113F0;
        Thu,  9 Feb 2023 02:20:11 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PCCSM11ZCz6J68f;
        Thu,  9 Feb 2023 18:16:03 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 9 Feb
 2023 10:20:08 +0000
Date:   Thu, 9 Feb 2023 10:20:07 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Gwendal Grignou <gwendal@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the iio tree
Message-ID: <20230209102007.00002d07@Huawei.com>
In-Reply-To: <20230209143821.7e6870e8@canb.auug.org.au>
References: <20230209143821.7e6870e8@canb.auug.org.au>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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

On Thu, 9 Feb 2023 14:38:21 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> After merging the iio tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> drivers/iio/proximity/sx_common.c: In function 'sx_common_get_raw_register_config':
> drivers/iio/proximity/sx_common.c:438:55: error: implicit declaration of function 'acpi_device_hid'; did you mean 'dmi_device_id'? [-Werror=implicit-function-declaration]
>   438 |         snprintf(prop, ARRAY_SIZE(prop), "%s,reg_%s", acpi_device_hid(adev), reg_def->property);
>       |                                                       ^~~~~~~~~~~~~~~
>       |                                                       dmi_device_id
> drivers/iio/proximity/sx_common.c:438:44: error: format '%s' expects argument of type 'char *', but argument 4 has type 'int' [-Werror=format=]
>   438 |         snprintf(prop, ARRAY_SIZE(prop), "%s,reg_%s", acpi_device_hid(adev), reg_def->property);
>       |                                           ~^          ~~~~~~~~~~~~~~~~~~~~~
>       |                                            |          |
>       |                                            char *     int
>       |                                           %d
> cc1: all warnings being treated as errors
> 
> Caused by commit
> 
>   91af1d6c497b ("iio: proximity: sx_common: Add old register mapping")
> 
> I have reverted that commit for today.
> 

Thanks,  I misdiagnosed the issue in previous attempt to fix this.
Problem is lack of stub for that function in !CONFIG_ACPI
(not as I thought a missing include - which was also the case).

As that will need an ACPI related header change to avoid ifdef nastiness
in the driver I'll drop the patch from my tree and we can get back
to this next cycle.

Thanks again,

Jonathan
 


