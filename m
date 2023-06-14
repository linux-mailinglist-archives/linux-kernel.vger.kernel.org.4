Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BE272F8BA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243908AbjFNJLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243726AbjFNJK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:10:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A435810D5;
        Wed, 14 Jun 2023 02:10:55 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qh04g3LXWz6H7tc;
        Wed, 14 Jun 2023 17:10:11 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 10:10:52 +0100
Date:   Wed, 14 Jun 2023 10:10:51 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <alison.schofield@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Len Brown" <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Jiang <dave.jiang@intel.com>,
        "Mike Rapoport" <rppt@kernel.org>, <x86@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] CXL: Apply SRAT defined PXM to entire CFMWS
 window
Message-ID: <20230614101051.00006602@Huawei.com>
In-Reply-To: <20230614083240.GC1639749@hirez.programming.kicks-ass.net>
References: <cover.1686712819.git.alison.schofield@intel.com>
        <20230614083240.GC1639749@hirez.programming.kicks-ass.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
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

On Wed, 14 Jun 2023 10:32:40 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Jun 13, 2023 at 09:35:23PM -0700, alison.schofield@intel.com wrote:
> > The CXL subsystem requires the creation of NUMA nodes for CFMWS  
> 
> The thing is CXL some persistent memory thing, right? But what is this
> CFMWS thing? I don't think I've ever seen that particular combination of
> letters together.
> 
Hi Peter,

To save time before the US based folk wake up.

Both persistent and volatile memory found on CXL devices (mostly volatile on
early devices).

CXL Fixed Memory Window (structure) (CFMWS - defined in 9.17.1.3 of CXL r3.0
- via an ACPI table (CEDT).  CFMWS, as a term, is sometimes abused in the kernel
(and here) for the window rather than the structure describing the window
(the S on the end).

CFMWS - A region of Host Physical Address (HPA) Space which routes accesses to CXL Host
bridges. A CFMWS describes interleaving as well (so multiple target host bridges).
If multiple interleave setups are available, then you'll see multiple CFMWS entries
- so different statically regions of HPA can route to same host bridges with different
interleave setups (decoding via the configurable part to hit different actual memory
on the downstream devices). 
Where accesses are routed after that depends on the configurable parts
of the CXL topology (Host-Managed Device Memory (HDM) decoders in host bridges,
switches etc).  Note that a CFMWS address may route to nowhere if downstream
devices aren't available / configured yet.

CFMWS is the CXL specification avoiding defining interfaces for controlling
the host address space to CXL host bridge mapping as those vary so much across
host implementations + not always configurable at runtime anyway. Also includes
a bunch of other details about the region (too many details perhaps!)

Who does the configuration (BIOS / kernel) varies across implementations
and we have OS managed hotplug so the OS always has to do some of it
(personally I prefer the kernel doing everything :)
It's made messier by CXL 1.1 hosts where a lot less was discoverable so
generally the BIOS has to do the heavy lifting. For CXL 2.0 onwards the OS
'might' do everything except whatever is needed on the host to configure
the CXL Fixed Memory Windows it is advertising.

Note there is no requirement that the access characteristics of memory mapped
into a given CFMWS should be remotely consistent across the whole window
 - some of the window may route through switches, and to directly connected
   devices.
That's a simplifying assumption made today as we don't yet know the full
scope of what people are building.

Hope that helps (rather than causing confusion!)

Jonathan
