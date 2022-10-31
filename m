Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18C0613160
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 08:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiJaHtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 03:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJaHtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 03:49:41 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99596764F;
        Mon, 31 Oct 2022 00:49:40 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N14wl1JlLzJnMG;
        Mon, 31 Oct 2022 15:46:47 +0800 (CST)
Received: from [10.174.176.82] (10.174.176.82) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 15:49:38 +0800
Message-ID: <ccfe9c8d-5dc9-594a-a4c5-d5a9efef4dc9@huawei.com>
Date:   Mon, 31 Oct 2022 15:49:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Subject: Re: [PATCH RFC] ACPI: container: Add power domain control methods
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <lenb@kernel.org>, <patchwork@huawei.com>,
        <wangkefeng.wang@huawei.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <guohanjun@huawei.com>,
        <wanghuiqiang@huawei.com>
References: <20221025061437.17571-1-zhangzekun11@huawei.com>
 <CAJZ5v0hpYodc_fd1DtBM-VEmhxepq7eQcQkbDXvWn0uMQ_yGNA@mail.gmail.com>
From:   "zhangzekun (A)" <zhangzekun11@huawei.com>
In-Reply-To: <CAJZ5v0hpYodc_fd1DtBM-VEmhxepq7eQcQkbDXvWn0uMQ_yGNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.82]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rafael J

This patch wants to put some generic control logic in container, and 
these logic can
cover a batch of scenarios similar to ours. ACPI power resources 
interface is not confilct
with this patch and can be used inside the container for more 
complicated scenarios.

In our secenaio, we need to control the power of some HBM memory device, 
each of it
will be configured as a PNP0C80, HBM devices in one socket are in the 
same power
domain and need to power on/off together. Every HBM memory device 
represent a numa
node and have no cpu on it. The topology in one socket can be simplifed 
and represented as

         +---------+
         |  node0  |
         |  CPUs   |
         |  DRAM   |
         +---------+
              |
       +------+-------+
       |              |
  +---------+    +---------+
  |  node1  |    |  node2  |
  |  no-cpu |    |  no-cpu |
  |  HBM    |    |  HBM    |
  +---------+    +---------+

To use ACPI power domain management interface, we need to develop a 
specialized
driver to maintain the relationship between socket id and numa nodes to 
tell the
userspace which socket does this numa node belong to. Note that the numa 
node in
the same socket will be power on/off together.

Socket id of a memory device can be reported by BIOS via DSDT or other 
ACPI tables,
but we can just skip this step by put all of the devices belongs to the 
same socket
in a container. And, we can call each child devices' "_PXM" function to 
expose numa
nodes of HBM devices to userspace.

Besides, To power off the devices we need first to offline these ACPI 
devices, and then
call the ACPI function "_EJ0" to finally remove it. This are also 
generic logic that can be
used to remove ejectable devices.

what we really need is a place to support these generic control logic, 
rather than the
interfaces to implement our requirements.

Best Regards,
Zekun, Zhang


在 2022/10/29 1:07, Rafael J. Wysocki 写道:
> On Tue, Oct 25, 2022 at 8:17 AM Zhang Zekun <zhangzekun11@huawei.com> wrote:
>> Platform devices which supports power control are often required to be
>> power off/on together with the devices in the same power domain. However,
>> there isn't a generic driver that support the power control logic of
>> these devices.
> Not true.
>
> There is the ACPI power resources interface designed to represent
> power domains that is well supported and used in the industry.
>
> If it doesn't work for you, explain why.
>

