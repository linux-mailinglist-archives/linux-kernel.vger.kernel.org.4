Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3811669CA2F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjBTLtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjBTLtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:49:07 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58D11B547;
        Mon, 20 Feb 2023 03:48:56 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pU4f4-0001yf-Vd; Mon, 20 Feb 2023 12:48:51 +0100
Message-ID: <99455c99-dd5c-4ab4-2c86-058aaf6d17c9@leemhuis.info>
Date:   Mon, 20 Feb 2023 12:48:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: scsi: Recent kernels drop into emergency shell
Content-Language: en-US, de-DE
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, hare@suse.de, hch@lst.de, ming.lei@redhat.com,
        sumanesh.samanta@broadcom.com, michael.christie@oracle.com,
        john.garry@huawei.com, johannes.thumshirn@wdc.com, axboe@kernel.dk,
        osandov@fb.com, kashyap.desai@broadcom.com,
        gregkh@linuxfoundation.org
References: <20230220061559.GJ159593@linux.vnet.ibm.com>
 <8489afbb-2391-c22f-41fc-21726f09e444@leemhuis.info>
 <20230220112328.GA803890@linux.vnet.ibm.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230220112328.GA803890@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1676893736;47f2d493;
X-HE-SMSGID: 1pU4f4-0001yf-Vd
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.02.23 12:23, Srikar Dronamraju wrote:
> * Linux regression tracking (Thorsten Leemhuis) <regressions@leemhuis.info> [2023-02-20 08:40:09]:
> 
>> [CCing the regression list, as it should be in the loop for regressions:
>> https://docs.kernel.org/admin-guide/reporting-regressions.html]
>>
>> On 20.02.23 07:15, Srikar Dronamraju wrote:
>>> On a freshly installed system, booting latest upstream kernels causes the
>>> system to drop into emergency shell. The reason for dropping into emergency
>>> shell is system is unable to mount /home partition.
>>
>> What kind of storage hardware do you have? Is this maybe related to this
>> fix, that afaics never was merged?
> 
> $ lsslot
> # Slot                     Description       Linux Name    Device(s)
> U9080.HEX.134C1E8-V9-C0    Virtual I/O Slot  30000000      vty
> U9080.HEX.134C1E8-V9-C2    Virtual I/O Slot  30000002      l-lan
> U9080.HEX.134C1E8-V9-C109  Virtual I/O Slot  3000006d      v-scsi
> 
> $ ls-vscsi
> host0 U9080.HEX.134C1E8-V9-C109-T0
> 
> $ lsscsi
> [0:0:1:0]    disk    AIX      VDASD            0001  /dev/sda
> [0:0:2:0]    cd/dvd  AIX      VOPTA                  /dev/sr0
> 
> Incase you need any other details please let me know.
> 
>> https://lore.kernel.org/all/20220928181350.9948-1-leeman.duncan@gmail.com/
> 
> Thanks that fixes the problem. I have added a tested-by for the same.

Great, thx. Hopefully that will revive the discussion to get this
finally solved.

#regzbot monitor:
https://lore.kernel.org/all/20220928181350.9948-1-leeman.duncan@gmail.com/

> Thanks for pointing out.

Yw. FWIW, I just found it by searching on lore for "c92a6b5d*".

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
