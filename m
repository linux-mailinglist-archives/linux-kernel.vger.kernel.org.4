Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDCD6C6EBD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjCWRZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCWRY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:24:56 -0400
Received: from mp-relay-02.fibernetics.ca (mp-relay-02.fibernetics.ca [208.85.217.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F552686C;
        Thu, 23 Mar 2023 10:24:52 -0700 (PDT)
Received: from mailpool-fe-02.fibernetics.ca (mailpool-fe-02.fibernetics.ca [208.85.217.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mp-relay-02.fibernetics.ca (Postfix) with ESMTPS id 8D76675C90;
        Thu, 23 Mar 2023 17:24:50 +0000 (UTC)
Received: from localhost (mailpool-mx-01.fibernetics.ca [208.85.217.140])
        by mailpool-fe-02.fibernetics.ca (Postfix) with ESMTP id 733B060AE0;
        Thu, 23 Mar 2023 17:24:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at 
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
Received: from mailpool-fe-02.fibernetics.ca ([208.85.217.145])
        by localhost (mail-mx-01.fibernetics.ca [208.85.217.140]) (amavisd-new, port 10024)
        with ESMTP id X4If3C_OIL3F; Thu, 23 Mar 2023 17:24:50 +0000 (UTC)
Received: from [192.168.48.17] (host-184-164-23-94.dyn.295.ca [184.164.23.94])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail.ca.inter.net (Postfix) with ESMTPSA id 834B460ADC;
        Thu, 23 Mar 2023 17:24:49 +0000 (UTC)
Message-ID: <fd810b7f-5520-1054-735f-8434a237c6e4@interlog.com>
Date:   Thu, 23 Mar 2023 13:24:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH 0/5]scsi:scsi_debug: Add error injection for single device
Content-Language: en-CA
To:     John Garry <john.g.garry@oracle.com>,
        "haowenchao (C)" <haowenchao2@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linfeilong@huawei.com, louhongxiang@huawei.com
References: <20230323115601.178494-1-haowenchao2@huawei.com>
 <b5f8240e-f46a-b83b-ed16-66c2d8c5571f@oracle.com>
 <c9d213e2-5ab4-0db2-f87a-247519debbbb@huawei.com>
 <750a4b24-6122-6faa-fed4-25e3167ea376@oracle.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
In-Reply-To: <750a4b24-6122-6faa-fed4-25e3167ea376@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-23 12:25, John Garry wrote:
> On 23/03/2023 13:13, haowenchao (C) wrote:
>> On 2023/3/23 20:40, John Garry wrote:
>>> On 23/03/2023 11:55, Wenchao Hao wrote:
>>>> The original error injection mechanism was based on scsi_host which
>>>> could not inject fault for a single SCSI device.
>>>>
>>>> This patchset provides the ability to inject errors for a single
>>>> SCSI device. Now we supports inject timeout errors, queuecommand
>>>> errors, and hostbyte, driverbyte, statusbyte, and sense data for
>>>> specific SCSI Command.
>>>
>>> There is already a basic mechanism to generate errors - like timeouts - on 
>>> "nth" command. Can you say why you want this new interface? What special 
>>> scenarios are you trying to test/validate (which could not be achieved based 
>>> on the current mechanism)?
>>>
>>
>> I am testing a new error handle policy which is based on single scsi_device
>> without set host to RECOVERY. So I need a method to generate errors for
>> single SCSI devices.
>>
>> While we can not generate errors for single device with current mechanism
>> because it is designed for host-wide error generation.
>>
>>> With this series we would have 2x methods to inject errors, which is less 
>>> than ideal, and they seem to possibly conflict as well, e.g. I set timeout 
>>> for nth command via current interface and then use the new interface to set 
>>> timeout for some other cadence. What behavior to expect ...?
>>
>> I did not take this issue in consideration. I now assume the users would
>> not use these 2 methods at same time.
>>
>> What's more, I don not know where to write the usage of this newly added
>> interface, maybe we can explain these in doc?
> 
> sysfs entries are described in Documentation/ABI, but please don't add elaborate 
> programming interfaces in sysfs files (like in these patches) - a sysfs file 
> should be just for reading or writing a single value

Hi,
Maybe this link might help for scsi_debug documentation:
     https://doug-gilbert.github.io/scsi_debug.html

And rather than sysfs for complicated, per (pseudo_ device
settings, perhaps we could think about a SCSI mechanism like
the "Unit Attention" mode page [0x0] which is vendor specific
and used by Seagate and WDC for this sort of thing.
A framework is already in the scsi_debug driver to change
some mode page settings:

# sdparm /dev/sg0
     /dev/sg0: Linux     scsi_debug        0191
Read write error recovery mode page:
   AWRE          1  [cha: n, def:  1]
   ARRE          1  [cha: n, def:  1]
   PER           0  [cha: n, def:  0]
Caching (SBC) mode page:
   WCE           1  [cha: y, def:  1]
   RCD           0  [cha: n, def:  0]
Control mode page:
   SWP           0  [cha: n, def:  0]
Informational exceptions control mode page:
   EWASC         0  [cha: n, def:  0]
   DEXCPT        1  [cha: n, def:  1]
   MRIE          0  [cha: y, def:  0]

As can be seen WCE and MRIE are changeable, so

# sdparm --clear=WCE /dev/sg0
# sdparm --get=WCE /dev/sg0
     /dev/sg0: Linux     scsi_debug        0191
WCE           0  [cha: y, def:  1]


Doug Gilbert


>>> I'm not saying that I am a huge fan of the current inject mechanism, but at 
>>> the very least you need to provide more justification for this series.
>>>>>
>>>> The first patch add an sysfs interface to add and inquiry single
>>>> device's error injection info; the second patch defined how to remove
>>>> an injection which has been added. The following 3 patches use the
>>>> injection info and generate the related error type.
>>>>
>>>> Wenchao Hao (5):
>>>>    scsi:scsi_debug: Add sysfs interface to manage scsi devices' error
>>>>      injection
>>>>    scsi:scsi_debug: Define grammar to remove added error injection
>>>>    scsi:scsi_debug: timeout command if the error is injected
>>>>    scsi:scsi_debug: Return failed value if the error is injected
>>>>    scsi:scsi_debug: set command's result and sense data if the error is
>>>>      injected
>>>>
>>>>   drivers/scsi/scsi_debug.c | 296 ++++++++++++++++++++++++++++++++++++++
>>>>   1 file changed, 296 insertions(+)
>>>>
>>>
>>>
>>
> 

