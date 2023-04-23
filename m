Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DFF6EBC75
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 04:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjDWCfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 22:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjDWCfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 22:35:00 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B1A1BF0;
        Sat, 22 Apr 2023 19:34:58 -0700 (PDT)
Received: from [IPV6:2001:250:4000:5113:78e9:d35:fdff:4057] ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33N2XTsv018716-33N2XTsw018716
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 23 Apr 2023 10:33:29 +0800
Message-ID: <f71f3012-916c-5271-b908-feeee5a85a46@hust.edu.cn>
Date:   Sun, 23 Apr 2023 10:33:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] Input: xpad - fix GPF in xpad_probe
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Dan Carpenter <error27@gmail.com>
Cc:     Vicki Pfau <vi@endrift.com>, kernel-janitors@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Rojtberg <rojtberg@gmail.com>,
        Nate Yocom <nate@yocom.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        John Butler <radon86dev@gmail.com>,
        Matthias Benkmann <matthias.benkmann@gmail.com>,
        Christopher Crockett <chaorace@gmail.com>,
        Santosh De Massari <s.demassari@gmail.com>,
        hust-os-kernel-patches@googlegroups.com,
        syzbot+a3f758b8d8cb7e49afec@syzkaller.appspotmail.com,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230414125603.686123-1-dzm91@hust.edu.cn>
 <c3e0823b-2b03-4dab-b7cb-a8bc5151f0b1@kili.mountain>
 <011c00e7-c351-4331-8be4-1c184d5773e1@kili.mountain>
 <3ccc85bd-0541-4ffb-a207-dfc533a2c0aa@kili.mountain>
 <d49bb5a2-ed78-4b16-b7ea-b9c7748ca0e4@kili.mountain>
From:   Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <d49bb5a2-ed78-4b16-b7ea-b9c7748ca0e4@kili.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/4/23 03:48, Dan Carpenter wrote:
> The warnings from this are quite promising.
>
> When you're writing a check, you start with a simple idea and then try
> it and then filter out the common false positives.
>
> The first 10 warnings are from loops like:
>
> 	p = NULL;
>
> 	for (i = 0; i < limit; i++) {
> 		if (i == 0)
> 			p = non_null();
> 		else
> 			*p = something();
> 	}
>
> Smatch doesn't handle loops correctly.  (I know how to fix this but I've
> never gotten around to it because it would make Smatch slow)...
>
> So instead of that maybe I would do a hack to silence this type of
> warning.  Not sure what...
>
> drivers/usb/gadget/udc/amd5536udc_pci.c:61 udc_pci_remove() warn: pointer dereferenced without being set '&udc->gadget'
> This one is interesting.  Seems like a real bug.
>
> drivers/mtd/ubi/block.c:391 ubiblock_create() warn: pointer dereferenced without being set 'dev->gd'
>
> This one too.  So maybe we could make this a separate warning where
> NULL dereferences happen on error paths.  Or maybe when they happen in
> printks.
>
> So there are ways to take this first draft and massage it and get
> fewer false positives, by filtering false positives or taking things
> which work and creating new checks instead.

Hi Dan,

thanks for your efforts. After finishing the current task list, we can 
first ask senior students to check this result quickly and then assign 
highly-to-be True Positive to students.

BTW, do you have any plans to improve the code readability, directory 
orgranization, documentation etc. of Smatch? It's hard even for senior 
students to start with.

> Anyway, results attached.
>
> regards,
> dan carpenter
>
