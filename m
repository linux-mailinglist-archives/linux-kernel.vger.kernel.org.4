Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC68C606D29
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 03:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiJUBrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 21:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiJUBrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 21:47:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2FF22C612
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 18:47:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E43A8B82A0F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F38EC43470;
        Fri, 21 Oct 2022 01:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666316857;
        bh=yo1hIJweKZLTj72/NxaxGf4naDTPS65T5o8RZ3WKDto=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RM+5ExGYW/2f2vhpN6L0I2Nh4MV381nomxc/RpYkXGT034io0Tc5nZdGkpDMD2qS6
         Lpgl9fJAdP15zgPWmaBOCC1Vtnq+SKWcoi6CgQW07+mPOlQ+sj1zMgNbFIYW6/d9aI
         yrYsJ1FZsOum+8x5c7P1CwxiQrfUpgnITOkIhbaw=
Date:   Thu, 20 Oct 2022 18:47:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
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
        Tim Chen <tim.c.chen@intel.com>, Wei Xu <weixugc@google.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH] memory tier, sysfs: rename attribute "nodes" to
 "nodelist"
Message-Id: <20221020184735.aaddd0899bad4f0bb796ebde@linux-foundation.org>
In-Reply-To: <20221020015122.290097-1-ying.huang@intel.com>
References: <20221020015122.290097-1-ying.huang@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2022 09:51:22 +0800 Huang Ying <ying.huang@intel.com> wrote:

> In sysfs, we use attribute name "cpumap" or "cpus" for cpu mask and
> "cpulist" or "cpus_list" for cpu list.  For example, in my system,
> 
>  $ cat /sys/devices/system/node/node0/cpumap
>  f,ffffffff
>  $ cat /sys/devices/system/cpu/cpu2/topology/core_cpus
>  0,00100004
>  $ cat cat /sys/devices/system/node/node0/cpulist
>  0-35
>  $ cat /sys/devices/system/cpu/cpu2/topology/core_cpus_list
>  2,20
> 
> It looks reasonable to use "nodemap" for node mask and "nodelist" for
> node list.  So, rename the attribute to follow the naming convention.

I'll add

Fixes: 9832fb87834e2b ("mm/demotion: expose memory tier details via sysfs")

to this to reduce the risk that someone will backport 9832fb87834e2b
but will miss this alteration.

