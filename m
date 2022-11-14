Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0796274C6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 03:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbiKNCy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 21:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbiKNCy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 21:54:26 -0500
Received: from mp-relay-01.fibernetics.ca (mp-relay-01.fibernetics.ca [208.85.217.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537FFDF66;
        Sun, 13 Nov 2022 18:54:25 -0800 (PST)
Received: from mailpool-fe-02.fibernetics.ca (mailpool-fe-02.fibernetics.ca [208.85.217.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mp-relay-01.fibernetics.ca (Postfix) with ESMTPS id 901B4E167E;
        Mon, 14 Nov 2022 02:54:23 +0000 (UTC)
Received: from localhost (mailpool-mx-02.fibernetics.ca [208.85.217.141])
        by mailpool-fe-02.fibernetics.ca (Postfix) with ESMTP id 758CB60325;
        Mon, 14 Nov 2022 02:54:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at 
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from mailpool-fe-02.fibernetics.ca ([208.85.217.145])
        by localhost (mail-mx-02.fibernetics.ca [208.85.217.141]) (amavisd-new, port 10024)
        with ESMTP id awx6DM8mRke9; Mon, 14 Nov 2022 02:54:23 +0000 (UTC)
Received: from [192.168.48.17] (host-45-78-203-98.dyn.295.ca [45.78.203.98])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail.ca.inter.net (Postfix) with ESMTPSA id 5C2B260253;
        Mon, 14 Nov 2022 02:54:19 +0000 (UTC)
Message-ID: <c9106b58-677b-31e3-5c4e-5cbef5b1fe63@interlog.com>
Date:   Sun, 13 Nov 2022 21:54:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: dgilbert@interlog.com
Subject: Re: [RFC PATCH 0/5] scsi:scsi_debug:Add error injection for single
 lun
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Wenchao Hao <haowenchao@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221109155950.3536976-1-haowenchao@huawei.com>
 <58472d12-c1e4-59f3-bb37-a98db17ef2ba@interlog.com>
 <50e1411a-54c4-d9d2-7567-2388219c5bb1@opensource.wdc.com>
Content-Language: en-CA
From:   Douglas Gilbert <dgilbert@interlog.com>
In-Reply-To: <50e1411a-54c4-d9d2-7567-2388219c5bb1@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-13 19:30, Damien Le Moal wrote:
> On 11/14/22 06:48, Douglas Gilbert wrote:
>> On 2022-11-09 10:59, Wenchao Hao wrote:
>>> The original error injection mechanism was based on scsi_host which
>>> could not inject fault for a single SCSI device.
>>>
>>> This patchset provides the ability to inject errors for a single
>>> SCSI device. Now we supports inject timeout errors, queuecommand
>>> errors, and hostbyte, driverbyte, statusbyte, and sense data for
>>> specific SCSI Command
>>>
>>> The first patch add an sysfs interface to add and inquiry single
>>> device's error injection info; the second patch defined how to remove
>>> an injection which has been added. The following 3 patches use the
>>> injection info and generate the related error type.
>>>
>>> Wenchao Hao (5):
>>>     scsi:scsi_debug: Add sysfs interface to manager single devices' error inject
>>>     scsi:scsi_debug: Add interface to remove injection which has been added
>>>     scsi:scsi_debug: make command timeout if timeout error is injected
>>>     scsi:scsi_debug: Return failed value for specific command's queuecommand
>>>     scsi:scsi_debug: fail specific scsi command with result and sense data
>>>
>>>    drivers/scsi/scsi_debug.c | 295 ++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 295 insertions(+)
>>
>> Hi,
>> This patchset seems to assume all scsi_debug devices will be disk (-like) SCSI
>> devices. That leaves out other device types: tapes, enclosures, WLUNs, etc.
>>
>> Have you considered putting these device specific additions under:
>>      /sys/class/scsi_device/<hctl>/device/error_inject/
>> instead of
>>      /sys/block/sdb/device/error_inject/
> 
> But these are the same, no ?
> At least on my Fedora box, I see:
> 
> /sys/block/sdp/device/ being
> /sys/devices/pseudo_0/adapter0/host19/target19:0:0/19:0:0:0
> 
> and /sys/class/scsi_device/19:0:0:0/device being
> /sys/devices/pseudo_0/adapter0/host19/target19:0:0/19:0:0:0

Well the patch descriptions are all in terms of /sys/block/sd<letter>/
which will not exist if scsi_debug is called like this:
   $ modprobe scsi_debug ptype=1

That creates a pseudo host with an attached (virtual) tape drive. If
the patchset works for other peripheral device types (i.e. that don't
use the sd driver) then the description should at least mention the
more general case (i.e. /sys/class/scsi_device/<hctl>/device ) IMO.

Doug Gilbert

