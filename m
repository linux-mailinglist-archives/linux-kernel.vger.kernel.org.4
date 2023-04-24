Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563076ECBC3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 14:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjDXMEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 08:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjDXMD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 08:03:59 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0463010EA;
        Mon, 24 Apr 2023 05:03:54 -0700 (PDT)
Received: from [IPV6:2001:250:4000:5113:4140:2ad:3e:4b54] ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33OC3g4w013596-33OC3g4x013596
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 24 Apr 2023 20:03:43 +0800
Message-ID: <46299274-d827-279f-cadf-020e93296c13@hust.edu.cn>
Date:   Mon, 24 Apr 2023 20:03:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] spi: davinci: Remove dead code in `davinci_spi_probe()`
To:     Mark Brown <broonie@kernel.org>, Li Ningke <lnk_01@hust.edu.cn>
Cc:     hust-os-kernel-patches@googlegroups.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230423032446.34347-1-lnk_01@hust.edu.cn>
 <d29c4b3e-9e82-4ea9-9f0c-a8e2c7637eb9@sirena.org.uk>
From:   Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <d29c4b3e-9e82-4ea9-9f0c-a8e2c7637eb9@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/4/24 19:48, Mark Brown wrote:
> On Sun, Apr 23, 2023 at 03:24:46AM +0000, Li Ningke wrote:
>> Smatch complains that
>> drivers/spi/spi-davinci.c:915 davinci_spi_probe() warn:
>> platform_get_irq() does not return zero
>>
>> There is no need to check whether the return value is zero as
>> `platform_get_irq()` only returns non-zero IRQ number on success
>> or negative error number on failure, removing them to solve this
>> problem.
> Is that check valid?  0 was a valid interrupt for some architectures...

We just follow the comments of platform_get_irq().

/**
  * platform_get_irq - get an IRQ for a device
  * @dev: platform device
  * @num: IRQ number index
  *
  * Gets an IRQ for a platform device and prints an error message if 
finding the
  * IRQ fails. Device drivers should check the return value for errors 
so as to
  * not pass a negative integer value to the request_irq() APIs.
  *
  * For example::
  *
  *              int irq = platform_get_irq(pdev, 0);
  *              if (irq < 0)
  *                      return irq;
  *
  * Return: non-zero IRQ number on success, negative error number on 
failure.
  */
int platform_get_irq(struct platform_device *dev, unsigned int num)
{
         int ret;

         ret = platform_get_irq_optional(dev, num);
         if (ret < 0)
                 return dev_err_probe(&dev->dev, ret,
                                      "IRQ index %u not found\n", num);

         return ret;
}

