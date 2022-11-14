Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE95628519
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbiKNQX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237160AbiKNQXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:23:46 -0500
X-Greylist: delayed 1193 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Nov 2022 08:23:44 PST
Received: from smtpout1.mo529.mail-out.ovh.net (smtpout1.mo529.mail-out.ovh.net [178.32.125.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79289D9F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:23:42 -0800 (PST)
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.239])
        by mo529.mail-out.ovh.net (Postfix) with ESMTPS id DAC6313E67D75;
        Mon, 14 Nov 2022 17:03:46 +0100 (CET)
Received: from kaod.org (37.59.142.103) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Mon, 14 Nov
 2022 17:03:46 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-103G0055e59692f-5941-4c88-b1d4-5a7efb311b0d,
                    75464F94774268435EE9F43A7981E45EBBD3EAE1) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <b0503354-2d1e-a93d-a6a5-6f6a1f55f0e2@kaod.org>
Date:   Mon, 14 Nov 2022 17:03:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] virtio_console: Use an atomic to allocate virtual console
 numbers
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
References: <20221114080752.1900699-1-clg@kaod.org>
 <Y3IC3miVoiMROwaE@kroah.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <Y3IC3miVoiMROwaE@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG8EX1.mxp5.local (172.16.2.71) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 9113379b-40f4-4936-9eff-5b69c87971a3
X-Ovh-Tracer-Id: 7413487939237088163
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvgedrgedvgdehiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepffdufeeliedujeeffffhjeffiefghffhhfdvkeeijeehledvueffhfejtdehgeegnecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrddutdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeotghlgheskhgrohgurdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprghmihhtsehkvghrnhgvlhdrohhrghdprghrnhgusegrrhhnuggsrdguvgdpvhhirhhtuhgrlhhiiigrthhiohhnsehlihhsthhsrdhlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehvdelpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/22 09:57, Greg Kroah-Hartman wrote:
> On Mon, Nov 14, 2022 at 09:07:52AM +0100, Cédric Le Goater wrote:
>> When a virtio console port is initialized, it is registered as an hvc
>> console using a virtual console number. If a KVM guest is started with
>> multiple virtio console devices, the same vtermno (or virtual console
>> number) can be used to allocate different hvc consoles, which leads to
>> various communication problems later on.
>>
>> This is also reported in debugfs :
>>
>>    # grep vtermno /sys/kernel/debug/virtio-ports/*
>>    /sys/kernel/debug/virtio-ports/vport1p1:console_vtermno: 1
>>    /sys/kernel/debug/virtio-ports/vport2p1:console_vtermno: 1
>>    /sys/kernel/debug/virtio-ports/vport3p1:console_vtermno: 2
>>    /sys/kernel/debug/virtio-ports/vport4p1:console_vtermno: 3
>>
>> Fix the issue with an atomic variable and start the first console
>> number at 1 as it is today.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   drivers/char/virtio_console.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
>> index 9fa3c76a267f..253574f41e57 100644
>> --- a/drivers/char/virtio_console.c
>> +++ b/drivers/char/virtio_console.c
>> @@ -58,12 +58,13 @@ struct ports_driver_data {
>>   	 * We also just assume the first console being initialised was
>>   	 * the first one that got used as the initial console.
>>   	 */
>> -	unsigned int next_vtermno;
>> +	atomic_t next_vtermno;
>>   
>>   	/* All the console devices handled by this driver */
>>   	struct list_head consoles;
>>   };
>> -static struct ports_driver_data pdrvdata = { .next_vtermno = 1};
>> +
>> +static struct ports_driver_data pdrvdata = { .next_vtermno = ATOMIC_INIT(0) };
>>   
>>   static DEFINE_SPINLOCK(pdrvdata_lock);
>>   static DECLARE_COMPLETION(early_console_added);
>> @@ -1244,7 +1245,7 @@ static int init_port_console(struct port *port)
>>   	 * pointers.  The final argument is the output buffer size: we
>>   	 * can do any size, so we put PAGE_SIZE here.
>>   	 */
>> -	port->cons.vtermno = pdrvdata.next_vtermno;
>> +	port->cons.vtermno = atomic_inc_return(&pdrvdata.next_vtermno);
> 
> Why not use a normal ida/idr structure here?

yes that works.

> And why is this never decremented?

The driver would then need to track the id allocation ...

> and finally, why not use the value that created the "vportN" number
> instead?

yes. we could also encode the tuple (vdev->index, port) using a bitmask,
possibly using 'max_nr_ports' to reduce the port width. VIRTCONS_MAX_PORTS
seems a bit big for this device and QEMU sets the #ports to 31.

An ida might be simpler. One drawback is that an id can be reused for a
different device/port tuple in case of an (unlikely) unplug/plug sequence.

Thanks,
C.

> 
> thanks,
> 
> greg k-h

