Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9448F714B04
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjE2Nxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjE2Nw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:52:58 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A851B1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:52:43 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 3dIdqr1UCe9XV3dIeq7Nxy; Mon, 29 May 2023 15:52:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685368362;
        bh=ekUc6/kpoNVqqDDHA37r3P9ofoCJir8xdVgamOnTUws=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=LG8iRBb8j9/7yJeCsjr2RPI/UFdcVBgJkne3mBmtqwaKTuHbSMRzCW/3JNXco4Vl2
         h+GGvtqNJy6X0RrxtSXUMVFof37JY+onNWTpy11A8RbpTCvwkty1ynEWBPA5dJdJ7M
         8UmCXsobvUwfxQMNPw0TyRv4A8zWqoEgQgFBX9NtT36X8VQMCoVYRKwS0kfApyCqNL
         BXg7Us/6Zmav5cMnbYnLoc5m4aQZKnda1evhE0OTz3lrtH6xu39qGnzlkbuLOo+TT2
         bZPVy2a12TlpkcRXRV6Jm429amrrsZC8mfgcfF/Zq7II976s8Dn9+/TmWwUrDtilay
         KYrIVbQkYzS2A==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 29 May 2023 15:52:42 +0200
X-ME-IP: 86.243.2.178
Message-ID: <733f7cc6-a651-2457-3ffc-6ac116c27213@wanadoo.fr>
Date:   Mon, 29 May 2023 15:52:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] soc: xilinx: Fix a memory leak in zynqmp_pm_remove()
Content-Language: fr
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Michal Simek <michal.simek@amd.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <93ef923496b6c45a0baa59458099aed3a20b771a.1685346792.git.christophe.jaillet@wanadoo.fr>
 <8355a10b-e365-485f-810f-0c3001a0406a@kili.mountain>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <8355a10b-e365-485f-810f-0c3001a0406a@kili.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 29/05/2023 à 11:59, Dan Carpenter a écrit :
> On Mon, May 29, 2023 at 09:53:24AM +0200, Christophe JAILLET wrote:
>> 'rx_chan' is known to be NULL here.
>> Reverse the logic to free the mbox if it has been allocated.
>>
>> Fixes: ffdbae28d9d1 ("drivers: soc: xilinx: Use mailbox IPI callback")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> 'rx_chan' may be NULL, but mbox_free_channel() handles it.
>> Maybe it is more informative to keep a (useless) "if (rx_chan)" to tell
>> that it may not be allocated.
>>
>>
>> On my machine, compilation fails with gcc (Ubuntu 12.1.0-2ubuntu1~22.04):
>>
>>    CC      drivers/soc/xilinx/zynqmp_power.o
>> drivers/soc/xilinx/zynqmp_power.c: In function ‘zynqmp_pm_probe’:
>> drivers/soc/xilinx/zynqmp_power.c:193:12: error: ‘pm_api_version’ is used uninitialized [-Werror=uninitialized]
>>    193 |         if (pm_api_version < ZYNQMP_PM_VERSION)
>>        |            ^
>> drivers/soc/xilinx/zynqmp_power.c:187:13: note: ‘pm_api_version’ was declared here
>>    187 |         u32 pm_api_version;
>>        |             ^~~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
>>
>> I think that this warning is bogus and gcc is wrong.
>>
>> But I don't know what to do with it :/
>> Anyway, it is un-realated to this patch.
> 
> I bet GCC is correct.
> 
> Do you have CONFIG_ZYNQMP_FIRMWARE enabled in your .config?  This driver
> can only be compiled with that enabled, but I've seen some of your
> other patches depend on CONFIG_BROKEN so I think you're going outside of
> the Kconfig rules.
> 
> regards,
> dan carpenter
> 
> 

Ok, got it. This is for arm64.

make does not behave the same when you build a file or a directory.
Sometimes it is convenient, sometimes it is surprising.

On x86:
make -j7 drivers/soc/xilinx/zynqmp_power.o		--> fail
make -j7 drivers/soc/xilinx/				--> build nothing because I'm not on arm64


export ARCH=arm64
./make.cross -j7 drivers/soc/xilinx/zynqmp_power.o	--> OK

Thanks for the pointer.

CJ
