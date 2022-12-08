Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8699C64775E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 21:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiLHUjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 15:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiLHUjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 15:39:03 -0500
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4385582F9A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 12:39:02 -0800 (PST)
Received: from sopl295-1.home (unknown [IPv6:2a01:cb19:8d70:d500:6d47:7868:523:4848])
        (Authenticated sender: robert.jarzmik@free.fr)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id CFD18B00571;
        Thu,  8 Dec 2022 21:38:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1670531940;
        bh=YstTq1Myiif2EgThZ1/Ik29o/fO83gS7mbfHozyghFU=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=JVo2uzx7wkukQqGB/tORaLKiG+VvWQYfEUqaYh0iaYlC9MpVCfoTUkf4GAMP6rhFc
         TcvZt7ZD5EFlVm6fnXv6lgt6d11JQGRAXx2LAB2Vk/d3hj8PJDo0rzpK3Mz61lGeGk
         ehNIg/yOTycYsl18/3HC/+hxVQ4e5An1aLiDtS985aflFhOmWAttjR3EnAHgwIJ71u
         WtEfVNBiPqhO5Hz3gU05LK9oL13FOKJmDtVru/edrI8GjM24J8Dcr+zWIR1LdAuLGH
         jJFgRMNNoQwalTtZ2MHSqUZFH7wFTCihbvmcfkB8jBIS/nBJ+7WYnuNko9/WH8pWPu
         VT44TsUBnhitw==
References: <Y5B4QeNMNboJ42n4@probook> <Y5CxBzy47Gjn/V5a@lunn.ch>
 <Y5C0F/o4JS5MwkkJ@shell.armlinux.org.uk> <Y5DDCmXnamC6Zikx@probook>
 <Y5DbKNI3e+tFA++1@shell.armlinux.org.uk> <Y5IulKoRctcrWBzl@probook>
 <m2wn71emze.fsf@sopl295-1.home> <Y5I2oQexHNdlIbsQ@shell.armlinux.org.uk>
User-agent: mu4e 1.8.11; emacs 28.1
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Jonathan =?utf-8?Q?Ne?= =?utf-8?Q?usch=C3=A4fer?= 
        <j.neuschaefer@gmx.net>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>, linux-kernel@vger.kernel.org
Subject: Re: PXA25x: GPIO driver fails probe due to resource conflict with
 pinctrl driver
Date:   Thu, 08 Dec 2022 21:19:12 +0100
In-reply-to: <Y5I2oQexHNdlIbsQ@shell.armlinux.org.uk>
Message-ID: <m2pmcteilg.fsf@sopl295-1.home>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


"Russell King (Oracle)" <linux@armlinux.org.uk> writes:
> From a quick look, I think this commit is to blame:
>
> 542c25b7a209 drivers: gpio: pxa: use 
> devm_platform_ioremap_resource()
>
> Someone "helpfully" making this change:
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       if (!res)
> -               return -EINVAL;
> -       gpio_reg_base = devm_ioremap(&pdev->dev, res->start,
> -                                    resource_size(res));
> +
> +       gpio_reg_base = devm_platform_ioremap_resource(pdev, 0);
>
> which introduces request_mem_region() to the PXA GPIO driver, 
> resulting
> in this resource clash.
You're right.

Now, as for Jonathan, there are 2 options :
 - first one : revert the patch Russell pointed out
 - second one : a lot of work, detailed below :

Given that Arnd is removing legacy platformdata code, that will 
only leave the
device-tree one, which works only with the pinctrl driver enabled.
That gives the opportunity to drop the use of GPDR from the 
gpio-pxa driver,
and now we can map with separate iomem ressources pinctrl-pxa and 
gpio-pxa.

Therefore, if Jonathan has the will to make a patch, I would :
- keep the patch identfied by Russell (ie. don't revert it)
- amend the device-tree descriptions for pxa
  - pxa2xx.dtsi
...
		gpio: gpio@40e00000 {
...
			reg = <0x40e00000 0xc>, <0x40e00018 0x3c>, 
			<0x40e00100 4>, <0x40e00118 0x34>;
- amend the gpio_pxa.c driver, to map the 4 regions (and not only 
  one as before)
- the pinctrl-pxa25.c and its device-tree are already mapping the 
  holes in the
  previous list
- check that I didn't mess up the 4 iomem regions, they should 
  overlap with
  "pinctrl: pinctrl@40e00000".

Well it's up to Jonathan to see which version he prefers to 
choose, the simple
one or the tedious one.

Cheers.

--
Robert
