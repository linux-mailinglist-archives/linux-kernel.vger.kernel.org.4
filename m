Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADB970B361
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 04:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjEVCx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 22:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjEVCxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 22:53:55 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F443A0;
        Sun, 21 May 2023 19:53:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vj6ZMpX_1684724027;
Received: from 30.240.108.216(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0Vj6ZMpX_1684724027)
          by smtp.aliyun-inc.com;
          Mon, 22 May 2023 10:53:49 +0800
Message-ID: <345a7cdc-e55b-7aaa-43d4-59b3f911ef18@linux.alibaba.com>
Date:   Mon, 22 May 2023 10:53:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 0/2] capability: Introduce CAP_BLOCK_ADMIN
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Serge Hallyn <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Frederick Lawler <fred@cloudflare.com>,
        Jens Axboe <axboe@kernel.dk>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        louxiao.lx@alibaba-inc.com
References: <20230511070520.72939-1-tianjia.zhang@linux.alibaba.com>
 <b645e195-7875-9fc3-a8de-6676dfe800b8@schaufler-ca.com>
 <e1242268-e7b6-d77c-a94f-edd913845ca7@linux.alibaba.com>
 <bcf4df59-3915-6df3-027b-8cb35b310650@schaufler-ca.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <bcf4df59-3915-6df3-027b-8cb35b310650@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Casey,

On 5/18/23 8:01 AM, Casey Schaufler wrote:
> On 5/16/2023 5:05 AM, Tianjia Zhang wrote:
>> Hi Casey,
>>
>> On 5/12/23 12:17 AM, Casey Schaufler wrote:
>>> On 5/11/2023 12:05 AM, Tianjia Zhang wrote:
>>>> Separated fine-grained capability CAP_BLOCK_ADMIN from CAP_SYS_ADMIN.
>>>> For backward compatibility, the CAP_BLOCK_ADMIN capability is included
>>>> within CAP_SYS_ADMIN.
>>>>
>>>> Some database products rely on shared storage to complete the
>>>> write-once-read-multiple and write-multiple-read-multiple functions.
>>>> When HA occurs, they rely on the PR (Persistent Reservations) protocol
>>>> provided by the storage layer to manage block device permissions to
>>>> ensure data correctness.
>>>>
>>>> CAP_SYS_ADMIN is required in the PR protocol implementation of existing
>>>> block devices in the Linux kernel, which has too many sensitive
>>>> permissions, which may lead to risks such as container escape. The
>>>> kernel needs to provide more fine-grained permission management like
>>>> CAP_NET_ADMIN to avoid online products directly relying on root to run.
>>>>
>>>> CAP_BLOCK_ADMIN can also provide support for other block device
>>>> operations that require CAP_SYS_ADMIN capabilities in the future,
>>>> ensuring that applications run with least privilege.
>>>
>>> Can you demonstrate that there are cases where a program that needs
>>> CAP_BLOCK_ADMIN does not also require CAP_SYS_ADMIN for other
>>> operations?
>>> How much of what's allowed by CAP_SYS_ADMIN would be allowed by
>>> CAP_BLOCK_ADMIN? If use of a new capability is rare it's difficult to
>>> justify.
>>>
>>
>> For the previous non-container scenarios, the block device is a shared
>> device, because the business-system generally operates the file system
>> on the block. Therefore, directly operating the block device has a high
>> probability of affecting other processes on the same host, and it is a
>> reasonable requirement to need the CAP_SYS_ADMIN capability.
>>
>> But for a database running in a container scenario, especially a
>> container scenario on the cloud, it is likely that a container
>> exclusively occupies a block device. That is to say, for a container,
>> its access to the block device will not affect other process, there is
>> no need to obtain a higher CAP_SYS_ADMIN capability.
> 
> If I understand correctly, you're saying that the process that requires
> CAP_BLOCK_ADMIN in the container won't also require CAP_SYS_ADMIN for
> other operations.
> 
> That's good, but it isn't clear how a process on bare metal would
> require CAP_SYS_ADMIN while the same process in a container wouldn't.
> 
>>
>> For a file system similar to distributed write-once-read-many, it is
>> necessary to ensure the correctness of recovery, then when recovery
>> occurs, it is necessary to ensure that no inflighting-io is completed
>> after recovery.
>>
>> This can be guaranteed by performing operations such as SCSI/NVME
>> Persistent Reservations on block devices on the distributed file system.
> 
> Does your cloud based system always run "real" devices? My
> understanding is that cloud based deployment usually uses
> virtual machines and virtio or other simulated devices.
> A container deployment in the cloud seems unlikely to be able
> to take advantage of block administration. But I can't say
> I know the specifics of your environment.
> 
>> Therefore, at present, it is only necessary to have the relevant
>> permission support of the control command of such container-exclusive
>> block devices.
> 
> This looks like an extremely special case in which breaking out
> block management would make sense.
> 
Our scenario is like this. In simply terms, a distributed database has
a read-write instance and one or more read-only instances. Each instance
runs in an isolated container. All containers share the same block device.

In addition to the database instance, there is also a control program
running on the control plane in the container. The database ensures
the correctness of the data through the PR (Persistent Reservations)
of the block device. This operation is also the only operation in the
container that requires CAP_SYS_ADMIN privileges.

This system as a whole, whether it is running on VM or bare metal, the
difference is not big.

In order to support the PR of block devices, we need to grant
CAP_SYS_ADMIN permissions to the container, which not only greatly
increases the risk of container escape, but also makes us have to
carefully configure the permissions of the container. Many container
escapes that have occurred are also caused by these reasons.

This is essentially a problem of permission isolation. We hope to
share the smallest possible permissions from CAP_SYS_ADMIN to support
necessary operations, and avoid providing CAP_SYS_ADMIN permissions
to containers as much as possible.

Kind regards,
Tianjia

