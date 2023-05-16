Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301C9704D57
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbjEPMFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbjEPMFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:05:35 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBEB59C0;
        Tue, 16 May 2023 05:05:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VioIoq8_1684238723;
Received: from 30.240.108.124(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VioIoq8_1684238723)
          by smtp.aliyun-inc.com;
          Tue, 16 May 2023 20:05:27 +0800
Message-ID: <e1242268-e7b6-d77c-a94f-edd913845ca7@linux.alibaba.com>
Date:   Tue, 16 May 2023 20:05:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 0/2] capability: Introduce CAP_BLOCK_ADMIN
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
Content-Language: en-US
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <b645e195-7875-9fc3-a8de-6676dfe800b8@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.6 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Casey,

On 5/12/23 12:17 AM, Casey Schaufler wrote:
> On 5/11/2023 12:05 AM, Tianjia Zhang wrote:
>> Separated fine-grained capability CAP_BLOCK_ADMIN from CAP_SYS_ADMIN.
>> For backward compatibility, the CAP_BLOCK_ADMIN capability is included
>> within CAP_SYS_ADMIN.
>>
>> Some database products rely on shared storage to complete the
>> write-once-read-multiple and write-multiple-read-multiple functions.
>> When HA occurs, they rely on the PR (Persistent Reservations) protocol
>> provided by the storage layer to manage block device permissions to
>> ensure data correctness.
>>
>> CAP_SYS_ADMIN is required in the PR protocol implementation of existing
>> block devices in the Linux kernel, which has too many sensitive
>> permissions, which may lead to risks such as container escape. The
>> kernel needs to provide more fine-grained permission management like
>> CAP_NET_ADMIN to avoid online products directly relying on root to run.
>>
>> CAP_BLOCK_ADMIN can also provide support for other block device
>> operations that require CAP_SYS_ADMIN capabilities in the future,
>> ensuring that applications run with least privilege.
> 
> Can you demonstrate that there are cases where a program that needs
> CAP_BLOCK_ADMIN does not also require CAP_SYS_ADMIN for other operations?
> How much of what's allowed by CAP_SYS_ADMIN would be allowed by
> CAP_BLOCK_ADMIN? If use of a new capability is rare it's difficult to
> justify.
> 

For the previous non-container scenarios, the block device is a shared
device, because the business-system generally operates the file system
on the block. Therefore, directly operating the block device has a high
probability of affecting other processes on the same host, and it is a
reasonable requirement to need the CAP_SYS_ADMIN capability.

But for a database running in a container scenario, especially a
container scenario on the cloud, it is likely that a container
exclusively occupies a block device. That is to say, for a container,
its access to the block device will not affect other process, there is
no need to obtain a higher CAP_SYS_ADMIN capability.

For a file system similar to distributed write-once-read-many, it is
necessary to ensure the correctness of recovery, then when recovery
occurs, it is necessary to ensure that no inflighting-io is completed
after recovery.

This can be guaranteed by performing operations such as SCSI/NVME
Persistent Reservations on block devices on the distributed file system.
Therefore, at present, it is only necessary to have the relevant
permission support of the control command of such container-exclusive
block devices.

Kind regards,
Tianjia
