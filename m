Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F216228C7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiKIKoI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Nov 2022 05:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiKIKns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:43:48 -0500
Received: from smtp.220.in.ua (smtp.220.in.ua [89.184.67.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB7AF2BF1;
        Wed,  9 Nov 2022 02:43:30 -0800 (PST)
Received: from smtpclient.apple (unknown [95.67.115.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.220.in.ua (Postfix) with ESMTPSA id 2DC4B1A21FD2;
        Wed,  9 Nov 2022 12:43:29 +0200 (EET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.200.110.1.12\))
Subject: Re: [PATCH 02/13] leds: el15203000: Fix devm vs. non-devm ordering
From:   Oleh Kravchenko <oleg@kaa.org.ua>
In-Reply-To: <bbd67e6a-8ce0-dbe8-6ab1-9d4a015f4ee9@huawei.com>
Date:   Wed, 9 Nov 2022 12:43:13 +0200
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>
Content-Transfer-Encoding: 8BIT
Message-Id: <6D18A607-EC63-495F-BA2D-78E0DB056D3C@kaa.org.ua>
References: <1667983694-15040-1-git-send-email-wangyufen@huawei.com>
 <1667983694-15040-3-git-send-email-wangyufen@huawei.com>
 <5D15416B-1866-4031-9958-7CD763C0BD6E@kaa.org.ua>
 <bbd67e6a-8ce0-dbe8-6ab1-9d4a015f4ee9@huawei.com>
To:     wangyufen <wangyufen@huawei.com>
X-Mailer: Apple Mail (2.3731.200.110.1.12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 9 лист. 2022 р. о 12:25 wangyufen <wangyufen@huawei.com> написав(ла):
> 
> 
> 在 2022/11/9 17:39, Oleh Kravchenko 写道:
>> Hello all!
>> 
>>> 9 лист. 2022 р. о 10:48 Wang Yufen <wangyufen@huawei.com> написав(ла):
>>> 
>>> return el15203000_probe_dt(priv);
>>> }
>>> 
>>> -static void el15203000_remove(struct spi_device *spi)
>> Is remove() callback from struct spi_driver deprecated?
> 
> It is not that remove() callback is deprecated,
> it's that after wrapping mutex_destroy() call with devm_add_action_or_reset(),
> remove() callback is unnecessary here.

When remove() is called, the memory allocated by devm_*() is valid.
So what you try to fix here?

> 
>> 
>>> -{
>>> - struct el15203000 *priv = spi_get_drvdata(spi);
>>> -
>>> - mutex_destroy(&priv->lock);
>>> -}
>>> 
>>> static const struct of_device_id el15203000_dt_ids[] = {
>>> { .compatible = "crane,el15203000", },
>>> @@ -331,7 +336,6 @@ static void el15203000_remove(struct spi_device *spi)
>>> 
>>> static struct spi_driver el15203000_driver = {
>>> .probe = el15203000_probe,
>>> - .remove = el15203000_remove,
>>> .driver = {
>>> .name = KBUILD_MODNAME,
>>> .of_match_table = el15203000_dt_ids,
>>> -- 
>>> 1.8.3.1
>>> 
>> 

