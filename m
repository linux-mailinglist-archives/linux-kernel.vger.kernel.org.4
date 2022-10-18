Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB9A60273A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiJRIkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiJRIj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:39:57 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBCF29368
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666082396; x=1697618396;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=yRwREJZ6WW5Zu2uLpSYw5X7MeZzm/Wb7ut6LwZ5B140=;
  b=BXIQ9ShSnpOjRrdkn7YJSt/dU2YtZK3JQ4lSw+nHm+ibbWmh/n55Tcru
   cZNlhr8XmbTy5V4RNBYiWaVBCAyJnLa6mHm6jPXRN+eSs5DfQb8lKm5f5
   fnL39ypBLxvJLtkiAYnBEz4Txk/GfIMuYliOtV5hbw7Rm+bATKXqXp0st
   QZefrX5K6dYeyG0fLJi23li1Ir8jaZqIUoyU30RARh4nuCcOqkz0Lb8mz
   d/ML3ey6kPCwYCFzRXNcT+sr9grf6efvBg2QPecI4Tl/AnpHTKp9zFhRY
   LpcgnRUhmFmMQopVC96hl/qPVttVgJ2+XWMjDgX/e6m0xBdQZzMYwaOCs
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="285762531"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="285762531"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 01:39:54 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="957674218"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="957674218"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 01:39:50 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Wei Xu <weixugc@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Alistair Popple <apopple@nvidia.com>,
        Bharata B Rao <bharata@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Jagdish Gediya <jvgediya.oss@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>, Yang Shi <shy828301@gmail.com>
Subject: Re: [RFC] memory tier, sysfs: rename attribute "nodes" to "nodes_list"
References: <20221018052541.265708-1-ying.huang@intel.com>
        <CAAPL-u-9MBPuCrkHf1jzBApukpWCvzqFc-2f5ffEpBDZ3kE3tw@mail.gmail.com>
Date:   Tue, 18 Oct 2022 16:39:11 +0800
In-Reply-To: <CAAPL-u-9MBPuCrkHf1jzBApukpWCvzqFc-2f5ffEpBDZ3kE3tw@mail.gmail.com>
        (Wei Xu's message of "Mon, 17 Oct 2022 23:27:18 -0700")
Message-ID: <8735blsez4.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Xu <weixugc@google.com> writes:

> How about "nodelist", instead of "nodes_list"?  It is more concise and
> follows the convention of:
>
> /sys/devices/system/nodes/node0/cpulist

Sounds good to me.

It seems that cpumap/cpulist is another pair of mask/list.

/sys/devices/system/node/node0/cpumap
/sys/devices/system/node/node0/cpulist

/sys/devices/system/cpu/cpu0/cache/index1/shared_cpu_map
/sys/devices/system/cpu/cpu0/cache/index1/shared_cpu_list

Best Regards,
Huang, Ying

> On Mon, Oct 17, 2022 at 10:26 PM Huang Ying <ying.huang@intel.com> wrote:
>>
>> In sysfs, we use attribute name "cpus" for cpu mask and "cpus_list"
>> for cpu list.  For example, in my system,
>>
>>  $ cat /sys/devices/system/cpu/cpu2/topology/core_cpus
>>  0,00100004
>>  $ cat /sys/devices/system/cpu/cpu2/topology/core_cpus_list
>>  2,20
>>
>> It looks reasonable to use "nodes" for node mask and "nodes_list" for
>> node list.  So, rename the attribute to follow the naming convention.
>>
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: Bharata B Rao <bharata@amd.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Dave Hansen <dave.hansen@intel.com>
>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>> Cc: Hesham Almatary <hesham.almatary@huawei.com>
>> Cc: Jagdish Gediya <jvgediya.oss@gmail.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Tim Chen <tim.c.chen@intel.com>
>> Cc: Wei Xu <weixugc@google.com>
>> Cc: Yang Shi <shy828301@gmail.com>
>> ---
>>  Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers | 4 ++--
>>  mm/memory-tiers.c                                      | 8 ++++----
>>  2 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers b/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
>> index 45985e411f13..af07e166f559 100644
>> --- a/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
>> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
>> @@ -10,7 +10,7 @@ Description:  A collection of all the memory tiers allocated.
>>
>>
>>  What:          /sys/devices/virtual/memory_tiering/memory_tierN/
>> -               /sys/devices/virtual/memory_tiering/memory_tierN/nodes
>> +               /sys/devices/virtual/memory_tiering/memory_tierN/nodes_list
>>  Date:          August 2022
>>  Contact:       Linux memory management mailing list <linux-mm@kvack.org>
>>  Description:   Directory with details of a specific memory tier
>> @@ -21,5 +21,5 @@ Description:  Directory with details of a specific memory tier
>>                 A smaller value of N implies a higher (faster) memory tier in the
>>                 hierarchy.
>>
>> -               nodes: NUMA nodes that are part of this memory tier.
>> +               nodes_list: NUMA nodes that are part of this memory tier.
>>
>> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>> index f116b7b6333e..8dbfe9ec87d5 100644
>> --- a/mm/memory-tiers.c
>> +++ b/mm/memory-tiers.c
>> @@ -131,8 +131,8 @@ static void memory_tier_device_release(struct device *dev)
>>         kfree(tier);
>>  }
>>
>> -static ssize_t nodes_show(struct device *dev,
>> -                         struct device_attribute *attr, char *buf)
>> +static ssize_t nodes_list_show(struct device *dev,
>> +                              struct device_attribute *attr, char *buf)
>>  {
>>         int ret;
>>         nodemask_t nmask;
>> @@ -143,10 +143,10 @@ static ssize_t nodes_show(struct device *dev,
>>         mutex_unlock(&memory_tier_lock);
>>         return ret;
>>  }
>> -static DEVICE_ATTR_RO(nodes);
>> +static DEVICE_ATTR_RO(nodes_list);
>>
>>  static struct attribute *memtier_dev_attrs[] = {
>> -       &dev_attr_nodes.attr,
>> +       &dev_attr_nodes_list.attr,
>>         NULL
>>  };
>>
>> --
>> 2.35.1
>>
