Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C326A95D9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjCCLOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCCLOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:14:19 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 140ED12076;
        Fri,  3 Mar 2023 03:14:12 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F9792F4;
        Fri,  3 Mar 2023 03:14:55 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 193F83F93E;
        Fri,  3 Mar 2023 03:14:09 -0800 (PST)
Date:   Fri, 3 Mar 2023 11:14:07 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "lihuisong (C)" <lihuisong@huawei.com>
Cc:     robbiek@xsightlabs.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        rafael.j.wysocki@intel.com, wanghuiqiang@huawei.com,
        zhangzekun11@huawei.com, wangxiongfeng2@huawei.com,
        tanxiaofei@huawei.com, guohanjun@huawei.com, xiexiuqi@huawei.com,
        wangkefeng.wang@huawei.com, huangdaode@huawei.com
Subject: Re: [PATCH 2/2] mailbox: pcc: Support shared interrupt for multiple
 subspaces
Message-ID: <20230303111407.zdgqdwqik4spnq2o@bogus>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20230216063653.1995-1-lihuisong@huawei.com>
 <20230216063653.1995-3-lihuisong@huawei.com>
 <20230301133626.gchca3fdaqijxwzq@bogus>
 <2a165476-2e96-17b1-a50b-c8749462e8a1@huawei.com>
 <20230302140216.m4m3452vexyrnuln@bogus>
 <020cc964-9938-7ebe-7514-125cd041bfcb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <020cc964-9938-7ebe-7514-125cd041bfcb@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 02:33:49PM +0800, lihuisong (C) wrote:
> Sorry for my resend. Because I found that my last reply email is not in the
> thread of this patch. I guess it may be send failed.
> 
> 在 2023/3/2 22:02, Sudeep Holla 写道:
> > No. I meant a comment saying it is not need since only one transfer can occur
> > at a time and mailbox takes care of locking. So chan_in_use can be accessed
> > without a lock.
> Got it. Agreed.

Thanks

> > > For types no need this flag, it is always hard to understand and redundant
> > > design.
> > But does it matter ? You can even support shared interrupt for type 1&2.
> BTW, type 1 subspaces do not support a level triggered platform interrupt as
> no method is provided to clear the interrupt.

Agreed but there is no harm using the flag, you can add a comment that it is
useful only if shared interrupts are supported. That will imply it is dummy
for type 1. I am avoiding too many type unnecessary checks especially in IRQ
handler.

> > They support level interrupt, so we can add them too. I understand you can
> > test only type 3, but this driver caters for all and the code must be generic
> > as much as possible. I don't see any point in check for type 3 only. Only
> I understand what you do.
> But type 2 also supports the communication flow from OSPM to Platfrom.
> In this case, this flag will get in the way of type 2.
>

How ?

> Whether the interrupt belongs to a type2 channel is only determined by
> the status field in Generic Communications Channel Shared Memory Region,
> which is done in rx_callback of PCC client.

Agreed, but do you see any issue using the flag even if it acts as dummy ?

--
Regards,
Sudeep
