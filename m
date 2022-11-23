Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588D4635A10
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237100AbiKWKcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237445AbiKWKcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:32:07 -0500
Received: from 2.mo552.mail-out.ovh.net (2.mo552.mail-out.ovh.net [178.33.105.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B0DD08A6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:17:21 -0800 (PST)
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.131])
        by mo552.mail-out.ovh.net (Postfix) with ESMTPS id E0BA92D985;
        Wed, 23 Nov 2022 10:17:19 +0000 (UTC)
Received: from kaod.org (37.59.142.110) by DAG4EX2.mxp5.local (172.16.2.32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Wed, 23 Nov
 2022 11:17:18 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-110S00488af439b-a047-4893-a0cb-b1339694b13f,
                    044850B998F460D31CAC33A40C0E65C93B21D494) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <62cfdcff-9323-5007-67e2-54178e43b21e@kaod.org>
Date:   Wed, 23 Nov 2022 11:17:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] virtio_console: Introduce an ID allocator for virtual
 console numbers
Content-Language: en-US
To:     Amit Shah <amit@infradead.org>, Amit Shah <amit@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Thomas Huth <thuth@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <20221114173811.1977367-1-clg@kaod.org>
 <6293fd7d415950979c55c3f09254a6f52eba708b.camel@infradead.org>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <6293fd7d415950979c55c3f09254a6f52eba708b.camel@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.110]
X-ClientProxiedBy: DAG4EX2.mxp5.local (172.16.2.32) To DAG4EX2.mxp5.local
 (172.16.2.32)
X-Ovh-Tracer-GUID: 4e208e97-b4dd-44d3-8d1b-272a85f3d51f
X-Ovh-Tracer-Id: 17523224676612606828
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvgedriedugdduudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepffdufeeliedujeeffffhjeffiefghffhhfdvkeeijeehledvueffhfejtdehgeegnecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrdduuddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeotghlgheskhgrohgurdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopegrmhhithesihhnfhhrrgguvggrugdrohhrghdprghmihhtsehkvghrnhgvlhdrohhrghdprghrnhgusegrrhhnuggsrdguvgdpghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhvihhrthhurghlihiirghtihhonheslhhishhtshdrlhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpthhhuhhthhesrhgvughhrghtrdgtohhmpdhmshhtsehrvgguhhgrthdrtghomhdpoffvte
 fjohhsthepmhhoheehvddpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Amit,

On 11/22/22 18:03, Amit Shah wrote:
> On Mon, 2022-11-14 at 18:38 +0100, Cédric Le Goater wrote:
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
>> Replace the next_vtermno global with an ID allocator and start the
>> allocation at 1 as it is today. Also recycle IDs when a console port
>> is removed.
> 
> When the original virtio_console module was written, it didn't have
> support for multiple ports to be used this way.  So the oddity you're
> seeing is left there deliberately: VMMs should not be instantiating
> console ports this way.
> 
> I don't know if we should take in this change, but can you walk through
> all combinations of new/old guest and new/old hypervisor and ensure
> nothing's going to break -- and confirm with the spec this is still OK
> to do?  It may not be a goal to still ensure launches of a new guest on
> a very old (say) Centos5 guest still works -- but that was the point of
> maintaining backward compat...

'next_vtermno' was introduced by d8a02bd58ab6 ("virtio: console:
remove global var") to differentiate the underlying kernel hvc console
associated with each virtio console port. Some drivers, like XEN,
simply use a magic/cookie number for instance.

This number is not related to the virtio specs. It is not exposed to
QEMU nor the guest (a part from debugfs). It's an internal identifier
related to the implementation in the kernel. I don't understand how
this could break compatibility. The change even keeps the allocated
range the same in case some assumption is made on vtermno 0. Am I
missing something ?

In the virtio console driver case, we could also generate a unique
number from the tuple { virtio device index, virtio console port }.
The ID allocator approach is simpler.

Thanks,

C.

