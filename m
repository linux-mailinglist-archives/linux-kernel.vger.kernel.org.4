Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551E36C51EE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjCVRJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjCVRJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:09:18 -0400
X-Greylist: delayed 576 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Mar 2023 10:09:10 PDT
Received: from 9.mo576.mail-out.ovh.net (9.mo576.mail-out.ovh.net [46.105.56.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92FF2703
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:09:10 -0700 (PDT)
Received: from director10.ghost.mail-out.ovh.net (unknown [10.108.4.80])
        by mo576.mail-out.ovh.net (Postfix) with ESMTP id AF8DB25F8C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 16:59:32 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-wtqxn (unknown [10.110.208.116])
        by director10.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 7F7281FEAA;
        Wed, 22 Mar 2023 16:59:31 +0000 (UTC)
Received: from RCM-web8.webmail.mail.ovh.net ([151.80.29.22])
        by ghost-submission-6684bf9d7b-wtqxn with ESMTPSA
        id SGdcHfMzG2T7dgIAYG/iTw
        (envelope-from <rafal@milecki.pl>); Wed, 22 Mar 2023 16:59:31 +0000
MIME-Version: 1.0
Date:   Wed, 22 Mar 2023 17:59:31 +0100
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v2 1/4] nvmem: Add macro to register nvmem layout drivers
In-Reply-To: <20230322165804.2240285-2-miquel.raynal@bootlin.com>
References: <20230322165804.2240285-1-miquel.raynal@bootlin.com>
 <20230322165804.2240285-2-miquel.raynal@bootlin.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <1b566a91229ba23d2dae693ce376a888@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3743617193994660834
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegvddgleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihitgfgsehtkehjtddtreejnecuhfhrohhmpeftrghfrghlucfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpeejvdelgfeutdfhfeelheegfedtleduleeuvdfgfeefvefhvedtheetjeetfeehgeenucfkphepuddvjedrtddrtddruddpudelgedrudekjedrjeegrddvfeefpdduhedurdektddrvdelrddvvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehrrghfrghlsehmihhlvggtkhhirdhplheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeeipdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-22 17:58, Miquel Raynal wrote:
> Provide a module_nvmem_layout_driver() macro at the end of the
> nvmem-provider.h header to reduce the boilerplate when registering 
> nvmem
> layout drivers.
> 
> Suggested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Acked-by: Rafał Miłecki <rafal@milecki.pl>

> ---
>  include/linux/nvmem-provider.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/nvmem-provider.h 
> b/include/linux/nvmem-provider.h
> index 0cf9f9490514..3e97c8315c45 100644
> --- a/include/linux/nvmem-provider.h
> +++ b/include/linux/nvmem-provider.h
> @@ -9,6 +9,7 @@
>  #ifndef _LINUX_NVMEM_PROVIDER_H
>  #define _LINUX_NVMEM_PROVIDER_H
> 
> +#include <linux/device/driver.h>
>  #include <linux/err.h>
>  #include <linux/errno.h>
>  #include <linux/gpio/consumer.h>
> @@ -240,4 +241,9 @@ nvmem_layout_get_match_data(struct nvmem_device 
> *nvmem,
>  }
> 
>  #endif /* CONFIG_NVMEM */
> +
> +#define module_nvmem_layout_driver(__layout_driver)		\
> +	module_driver(__layout_driver, nvmem_layout_register,	\
> +		      nvmem_layout_unregister)
> +
>  #endif  /* ifndef _LINUX_NVMEM_PROVIDER_H */
