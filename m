Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EC16AB507
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 04:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjCFDUT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 5 Mar 2023 22:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjCFDUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 22:20:18 -0500
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D62793DC
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 19:20:17 -0800 (PST)
Received: from smtpclient.apple ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 3263K5qV006092-3263K5qX006092
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 6 Mar 2023 11:20:05 +0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.2\))
Subject: Re: [PATCH v2] drivers: loongson: fix memory leak in
 loongson2_guts_probe
From:   Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <b9a04f64-90a6-8915-2b96-2805d8117459@xen0n.name>
Date:   Mon, 6 Mar 2023 11:20:05 +0800
Cc:     Yinbo Zhu <zhuyinbo@loongson.cn>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <7AEE1E65-5A60-45DB-B2BA-AADB2711356C@hust.edu.cn>
References: <20230306025308.248987-1-dzm91@hust.edu.cn>
 <b9a04f64-90a6-8915-2b96-2805d8117459@xen0n.name>
To:     WANG Xuerui <kernel@xen0n.name>
X-Mailer: Apple Mail (2.3696.120.41.1.2)
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mar 6, 2023, at 11:03, WANG Xuerui <kernel@xen0n.name> wrote:
> 
> On 2023/3/6 10:53, Dongliang Mu wrote:
>> drivers/soc/loongson/loongson2_guts.c:150 loongson2_guts_probe()
>> warn: 'guts->regs' from ioremap() not released on lines: 131,135,139,143.
>> Fix this by modifying ioremap to devm_ioremap.
>> Note that, this patch is not tested due to the loongson architecture.
>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>> ---
>> v1->v2: instead of modifying error handling code, directly change
>> ioremap to devm_ioremap.
>>  drivers/soc/loongson/loongson2_guts.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/drivers/soc/loongson/loongson2_guts.c b/drivers/soc/loongson/loongson2_guts.c
>> index bace4bc8e03b..a053e3fdae09 100644
>> --- a/drivers/soc/loongson/loongson2_guts.c
>> +++ b/drivers/soc/loongson/loongson2_guts.c
>> @@ -107,7 +107,7 @@ static int loongson2_guts_probe(struct platform_device *pdev)
>>  	guts->little_endian = of_property_read_bool(np, "little-endian");
>>    	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -	guts->regs = ioremap(res->start, res->end - res->start + 1);
>> +	guts->regs = devm_ioremap(dev, res->start, res->end - res->start + 1);
> 
> resource_size(res) is exactly "res->end - res->start + 1", you may use that to simplify code now that you touched this line.

I will send a v3 patch since this is a good suggestion.

> 
>>  	if (IS_ERR(guts->regs))
>>  		return PTR_ERR(guts->regs);
>>  
> 
> Otherwise LGTM, thanks! Untested by me though,
> 
> Reviewed-by: WANG Xuerui <git@xen0n.name>
> 
> -- 
> WANG "xen0n" Xuerui
> 
> Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

