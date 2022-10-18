Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A63F60245D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 08:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiJRG1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 02:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiJRG1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 02:27:31 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101B489946
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 23:27:30 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id fw14so13073175pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 23:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q699QGXKZPP5tLSAWNbWZWtXZvr64ruvsRxzqBsxGlU=;
        b=d73puV54G7egHHTdlgFkNU8+FTggHwPVX8JVynh6lEG2Xe9FOo8qHw3AvkznqOVxej
         oGdymJyhqDd+G3J1AXWTZLkopAxAtLKMzHaITaltYQ39ymEt3w4oEAikzRhrkfDuM217
         87BZl+KScj+TRHXcw6RHtw83xWpSt3MuF66gzzl//yH+mv2wf/dM1jdkSWVr1fY9nOSQ
         xCm8q1TjHVvnZCM78RMp7A4Lg8I0kDpiu88a0cyRIqFJbcni2tCLP60VaFFXQWjdM8pC
         1ZR2QSpQ0ceHDAlQe5CsYlCnQvCq+nR4s5fOlEV9t7kINxCtsdtEcdvXNgFHFf0BJTgL
         u+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q699QGXKZPP5tLSAWNbWZWtXZvr64ruvsRxzqBsxGlU=;
        b=txwQpFEw/rhMT2ZOScJgb54EX5xxDy7qNX95+Kvl7yYlX/NxzszkJyVDdwCAy3zp4s
         eDGHFYELXkiViLnayqrL95A5SfnrdZ3SOtzE09PW9myWknEsYU+CZJanzk7LfdrwgySR
         uMB8gYGq1op247VEYvmhYcZNmmVD6rZbY22s637oJbkuuZ7d3vKhoqC/AsXWIfAWF4wK
         jEgwgE0sN3jAzEcRo30VxZy09vqHiTP73WAj3a7GJGQSxlN93n5z9Xd9M5ZvBzZtFtC8
         zASA/mIzZKR8bnj3RA+smqFzqjgRzp4hFZHeWWbGkEjQx29AK316d4D7griEdx3jxk/r
         BTfA==
X-Gm-Message-State: ACrzQf0l8XbXUCJN0zIM4R4PegFDJEvja+JZKdAoFtl/KUQnHMInUKCH
        /zOnW7krfMSdmpU9GqoAXobs0rXwJqnElr5WER6eeLnedrI=
X-Google-Smtp-Source: AMsMyM4bOfBo+4XlFvKJ//x0hzlMlaNtjxoBOdlKxPIe1HN1mfQj7okaMTNVNpvmRgnuZT/VL9tgB3RWCEEP070bo74=
X-Received: by 2002:a17:902:6b88:b0:17e:f177:400 with SMTP id
 p8-20020a1709026b8800b0017ef1770400mr1564149plk.72.1666074449309; Mon, 17 Oct
 2022 23:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <20221018052541.265708-1-ying.huang@intel.com>
In-Reply-To: <20221018052541.265708-1-ying.huang@intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Mon, 17 Oct 2022 23:27:18 -0700
Message-ID: <CAAPL-u-9MBPuCrkHf1jzBApukpWCvzqFc-2f5ffEpBDZ3kE3tw@mail.gmail.com>
Subject: Re: [RFC] memory tier, sysfs: rename attribute "nodes" to "nodes_list"
To:     Huang Ying <ying.huang@intel.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How about "nodelist", instead of "nodes_list"?  It is more concise and
follows the convention of:

/sys/devices/system/nodes/node0/cpulist

Wei

On Mon, Oct 17, 2022 at 10:26 PM Huang Ying <ying.huang@intel.com> wrote:
>
> In sysfs, we use attribute name "cpus" for cpu mask and "cpus_list"
> for cpu list.  For example, in my system,
>
>  $ cat /sys/devices/system/cpu/cpu2/topology/core_cpus
>  0,00100004
>  $ cat /sys/devices/system/cpu/cpu2/topology/core_cpus_list
>  2,20
>
> It looks reasonable to use "nodes" for node mask and "nodes_list" for
> node list.  So, rename the attribute to follow the naming convention.
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Bharata B Rao <bharata@amd.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Hesham Almatary <hesham.almatary@huawei.com>
> Cc: Jagdish Gediya <jvgediya.oss@gmail.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Tim Chen <tim.c.chen@intel.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Yang Shi <shy828301@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers | 4 ++--
>  mm/memory-tiers.c                                      | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers b/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
> index 45985e411f13..af07e166f559 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
> @@ -10,7 +10,7 @@ Description:  A collection of all the memory tiers allocated.
>
>
>  What:          /sys/devices/virtual/memory_tiering/memory_tierN/
> -               /sys/devices/virtual/memory_tiering/memory_tierN/nodes
> +               /sys/devices/virtual/memory_tiering/memory_tierN/nodes_list
>  Date:          August 2022
>  Contact:       Linux memory management mailing list <linux-mm@kvack.org>
>  Description:   Directory with details of a specific memory tier
> @@ -21,5 +21,5 @@ Description:  Directory with details of a specific memory tier
>                 A smaller value of N implies a higher (faster) memory tier in the
>                 hierarchy.
>
> -               nodes: NUMA nodes that are part of this memory tier.
> +               nodes_list: NUMA nodes that are part of this memory tier.
>
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index f116b7b6333e..8dbfe9ec87d5 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -131,8 +131,8 @@ static void memory_tier_device_release(struct device *dev)
>         kfree(tier);
>  }
>
> -static ssize_t nodes_show(struct device *dev,
> -                         struct device_attribute *attr, char *buf)
> +static ssize_t nodes_list_show(struct device *dev,
> +                              struct device_attribute *attr, char *buf)
>  {
>         int ret;
>         nodemask_t nmask;
> @@ -143,10 +143,10 @@ static ssize_t nodes_show(struct device *dev,
>         mutex_unlock(&memory_tier_lock);
>         return ret;
>  }
> -static DEVICE_ATTR_RO(nodes);
> +static DEVICE_ATTR_RO(nodes_list);
>
>  static struct attribute *memtier_dev_attrs[] = {
> -       &dev_attr_nodes.attr,
> +       &dev_attr_nodes_list.attr,
>         NULL
>  };
>
> --
> 2.35.1
>
