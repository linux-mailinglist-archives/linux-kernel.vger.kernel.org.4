Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6956EEC11
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 03:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239258AbjDZBvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 21:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239205AbjDZBvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 21:51:22 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227D5193D5;
        Tue, 25 Apr 2023 18:51:16 -0700 (PDT)
Received: from [IPV6:2001:250:4000:5113:cc18:37eb:8a69:2648] ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33Q1oQ02003919-33Q1oQ03003919
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 26 Apr 2023 09:50:26 +0800
Message-ID: <1488abfa-9a0e-970b-e074-11842a6c6413@hust.edu.cn>
Date:   Wed, 26 Apr 2023 09:50:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] spi: davinci: Remove dead code in `davinci_spi_probe()`
To:     Mark Brown <broonie@kernel.org>
Cc:     Li Ningke <lnk_01@hust.edu.cn>,
        hust-os-kernel-patches@googlegroups.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>
References: <20230423032446.34347-1-lnk_01@hust.edu.cn>
 <d29c4b3e-9e82-4ea9-9f0c-a8e2c7637eb9@sirena.org.uk>
 <46299274-d827-279f-cadf-020e93296c13@hust.edu.cn>
 <ed846afc-7155-4998-9a8d-e9d9e8aaf8e2@sirena.org.uk>
From:   Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <ed846afc-7155-4998-9a8d-e9d9e8aaf8e2@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/4/24 23:52, Mark Brown wrote:
> On Mon, Apr 24, 2023 at 08:03:42PM +0800, Dongliang Mu wrote:
>> On 2023/4/24 19:48, Mark Brown wrote:
>>> Is that check valid?  0 was a valid interrupt for some architectures...
>> We just follow the comments of platform_get_irq().
>>   * Gets an IRQ for a platform device and prints an error message if finding
>> the
>>   * IRQ fails. Device drivers should check the return value for errors so as
>> to
>>   * not pass a negative integer value to the request_irq() APIs.
> I'm not sure that's universally true yet, though there were some moves
> to try to get us there.  arm, where this driver is used, was one of the
> platforms with 0 as a valid interrupt.

Hi Brown,

First, we're sorry about the fact that our internal robot(beta) made a 
mistake and sent our testing message to LKML. We have fixed the 
incorrect logic.

Second, from code review of platform_get_irq / 
platform_get_irq_optional, it would warn IRQ 0 as an invalid IRQ number.

out:
	if (WARN(!ret, "0 is an invalid IRQ number\n"))
		return -EINVAL;
	return ret;

Dongliang Mu

