Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A9573A1FB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjFVNiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjFVNh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:37:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D769719BE;
        Thu, 22 Jun 2023 06:37:56 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qn1Zp5kQNz67ZCK;
        Thu, 22 Jun 2023 21:35:14 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 22 Jun
 2023 14:37:54 +0100
Date:   Thu, 22 Jun 2023 14:37:53 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Vishal Verma <vishal.l.verma@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <nvdimm@lists.linux.dev>,
        <linux-cxl@vger.kernel.org>, Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 1/3] mm/memory_hotplug: Allow an override for the
 memmap_on_memory param
Message-ID: <20230622143753.00000282@Huawei.com>
In-Reply-To: <0ea4728a-8601-bf75-1921-bcde0818aac3@redhat.com>
References: <20230613-vv-kmem_memmap-v1-0-f6de9c6af2c6@intel.com>
        <20230613-vv-kmem_memmap-v1-1-f6de9c6af2c6@intel.com>
        <0ea4728a-8601-bf75-1921-bcde0818aac3@redhat.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2023 09:46:59 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 16.06.23 00:00, Vishal Verma wrote:
> > For memory hotplug to consider MHP_MEMMAP_ON_MEMORY behavior, the
> > 'memmap_on_memory' module parameter was a hard requirement.
> > 
> > In preparation for the dax/kmem driver to use memmap_on_memory
> > semantics, arrange for the module parameter check to be bypassed via the
> > appropriate mhp_flag.
> > 
> > Recall that the kmem driver could contribute huge amounts of hotplugged
> > memory originating from special purposes devices such as CXL memory
> > expanders. In some cases memmap_on_memory may be the /only/ way this new
> > memory can be hotplugged. Hence it makes sense for kmem to have a way to
> > force memmap_on_memory without depending on a module param, if all the
> > other conditions for it are met.  
> 
> Just let the admin configure it. After all, an admin is involved in 
> configuring the dax/kmem device to begin with. If add_memory() fails you 
> could give a useful hint to the admin.
> 

Agreed. If it were just the default then fine, but making it the only option
limits admin choices.

Jonathan
