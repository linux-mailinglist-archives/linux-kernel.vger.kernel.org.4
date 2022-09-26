Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB745E9798
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 03:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbiIZBEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 21:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiIZBEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 21:04:33 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C1B124
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 18:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664154270; x=1695690270;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=ewrjyWVMkrf0F3lb0gU9athQ8P36/hdOKSpNw/dHgsc=;
  b=Mi6qTqsgffohmMZpodJXagQjeEmk8OqDTeaFdXTHm6OSBEWqGwK7Yi5U
   CvZ4LrOl4UPqY4gn6bHCWcYSuhaF58PmqvURhTCf0NXKD25OMkKwmrnXn
   g5Q8oXgmKxI35LCII6GsBLO1/NjRhp2recmQBRXLIBcq4DDTU8iJuk/9e
   hbIdsDSf/AzGRihp7yZ+4yAd0U2dCYOB9VW0s2N7e7cmNJjOZRtVI/hkl
   67BW6EVzMCAW62vJDNKZJYGI5WyKLcNqyyerpcx8lcxyDb+/9p6EsU59B
   joRlB07ITLS6ctAyv+8Y8smoOH38HUqPnSF82TEAmSa/pMcJkn7aTDlcR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10481"; a="284027796"
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="284027796"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2022 18:04:29 -0700
X-IronPort-AV: E=Sophos;i="5.93,345,1654585200"; 
   d="scan'208";a="796142485"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2022 18:04:25 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com,
        Bharata B Rao <bharata@amd.com>
Subject: Re: [PATCH v4] mm/demotion: Expose memory tier details via sysfs
References: <20220922102201.62168-1-aneesh.kumar@linux.ibm.com>
        <874jwyjyy9.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <3a966604-77c5-e6fc-1541-2fed7c71cc0c@linux.ibm.com>
Date:   Mon, 26 Sep 2022 09:04:16 +0800
In-Reply-To: <3a966604-77c5-e6fc-1541-2fed7c71cc0c@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Fri, 23 Sep 2022 16:05:30 +0530")
Message-ID: <87zgenhrov.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:

> On 9/23/22 1:37 PM, Huang, Ying wrote:
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>=20
>>> This patch adds /sys/devices/virtual/memory_tiering/ where all memory t=
ier
>>> related details can be found. All allocated memory tiers will be listed
>>> there as /sys/devices/virtual/memory_tiering/memory_tierN/
>>>
>>> The nodes which are part of a specific memory tier can be listed via
>>> /sys/devices/virtual/memory_tiering/memory_tierN/nodes
>>=20
>> It appears that XXXs is used for mask while XXXs_list is used for list?
>> For example,
>>=20
>> # cat /sys/devices/system/cpu/cpu2/topology/core_cpus
>> 0,00100004
>> # cat /sys/devices/system/cpu/cpu2/topology/core_cpus_list
>> 2,20
>>=20
>> It's better to follow the this convention?
>>=20
>
> That is not followed in other parts of the kernel. I was loking at cpuset=
=20
>
> $cat cpuset.cpus.effective=20
> 0-7

Per my understanding, cpuset isn't sysfs, but cgroupfs?

I did some research in my system,

$ grep . $(find /sys/devices | grep 'list$')

and

$ grep . $(find /sys/devices | grep 'cpus$')

I found that the cpus/cpus_list convention is used in

- pci

  /sys/devices/pci0000:64/0000:64:0d.2/local_cpulist:0-35
  /sys/devices/pci0000:64/0000:64:0c.2/local_cpus:f,ffffffff

- system

  /sys/devices/system/cpu/cpu7/topology/core_cpus_list:7,25
  /sys/devices/system/cpu/cpu7/topology/core_cpus:0,02000080

- block

  /sys/devices/virtual/block/loop1/mq/0/cpu_list:0, 1, 2, ...

- net

  /sys/devices/virtual/net/lo/queues/rx-0/rps_cpus:0,00000000

And I haven't found any exception in sysfs of my system.  Can you find
some?

Best Regards,
Huang, Ying

>>> A directory hierarchy looks like
>>> :/sys/devices/virtual/memory_tiering$ tree memory_tier4/
>>> memory_tier4/
>>> =E2=94=9C=E2=94=80=E2=94=80 nodes
>>> =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../../../bus/memory_tiering
>>> =E2=94=94=E2=94=80=E2=94=80 uevent
>>>
>>> :/sys/devices/virtual/memory_tiering$ cat memory_tier4/nodes
>>> 0,2
>>>
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>=20
>> Best Regards,
>> Huang, Ying
>>=20
>> [snip]
