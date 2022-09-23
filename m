Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FC45E756C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 10:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiIWIHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 04:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiIWIHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 04:07:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE0612AEC7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 01:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663920467; x=1695456467;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=uBsTZao/V9u69Rkv2ClXIbFBUPJIjmVzZTRL2kTNlC8=;
  b=kqQRtQyhPFfaRvQZT3NFJdc5xuHNGGEABL4IyDrdr6UcLCqpW3sXsxu+
   LKEUy1c06GtbkPAE59zPTzN1QiGcqEx8vH2+33vyM/Kf2Rzb7VwGp9LtJ
   ouRBcwCtWrd0Ghmd6P52xDvAEuvy8GAMjArNw5lg2JJd12xmfv88S8XG4
   YCjnkC3wuRvLvIp6xIV7sHpKI/XAdRz5ZVfF6pmGLiriMRe9mS2x3xl94
   Nm/vdhIFvggD7MWr9GrID8E8bVNwVXm8qxG0uJfvPHQ4DZAfhmIKKHFfZ
   cYHZKc1UumfDujxDwS09DVqlFYw+TyvU/QKNWJOsQpOZD9Ybhv98RG6/V
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="300525842"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="300525842"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 01:07:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="762533962"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 01:07:43 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
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
Date:   Fri, 23 Sep 2022 16:07:42 +0800
In-Reply-To: <20220922102201.62168-1-aneesh.kumar@linux.ibm.com> (Aneesh Kumar
        K. V.'s message of "Thu, 22 Sep 2022 15:52:01 +0530")
Message-ID: <874jwyjyy9.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> This patch adds /sys/devices/virtual/memory_tiering/ where all memory tier
> related details can be found. All allocated memory tiers will be listed
> there as /sys/devices/virtual/memory_tiering/memory_tierN/
>
> The nodes which are part of a specific memory tier can be listed via
> /sys/devices/virtual/memory_tiering/memory_tierN/nodes

It appears that XXXs is used for mask while XXXs_list is used for list?
For example,

# cat /sys/devices/system/cpu/cpu2/topology/core_cpus
0,00100004
# cat /sys/devices/system/cpu/cpu2/topology/core_cpus_list
2,20

It's better to follow the this convention?

> A directory hierarchy looks like
> :/sys/devices/virtual/memory_tiering$ tree memory_tier4/
> memory_tier4/
> =E2=94=9C=E2=94=80=E2=94=80 nodes
> =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../../../bus/memory_tiering
> =E2=94=94=E2=94=80=E2=94=80 uevent
>
> :/sys/devices/virtual/memory_tiering$ cat memory_tier4/nodes
> 0,2
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Best Regards,
Huang, Ying

[snip]
