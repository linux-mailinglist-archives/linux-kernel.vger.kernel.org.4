Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817826E156C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 21:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjDMTvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 15:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjDMTvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 15:51:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB06993CF
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 12:51:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0D14D75;
        Thu, 13 Apr 2023 12:52:21 -0700 (PDT)
Received: from bogus (unknown [10.57.57.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80B533F73F;
        Thu, 13 Apr 2023 12:51:35 -0700 (PDT)
Date:   Thu, 13 Apr 2023 20:50:32 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Radu Rendec <rrendec@redhat.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 2/4] cacheinfo: Check cache properties are present in
 DT
Message-ID: <20230413195032.bw3yu7a6puqziinx@bogus>
References: <20230413091436.230134-1-pierre.gondois@arm.com>
 <20230413091436.230134-3-pierre.gondois@arm.com>
 <4da53918-839b-4d28-0634-66fd7f38c8bd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4da53918-839b-4d28-0634-66fd7f38c8bd@gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 11:16:37AM -0700, Florian Fainelli wrote:
> On 4/13/23 02:14, Pierre Gondois wrote:
> > If a Device Tree (DT) is used, the presence of cache properties is
> > assumed. Not finding any is not considered. For arm64 platforms,
> > cache information can be fetched from the clidr_el1 register.
> > Checking whether cache information is available in the DT
> > allows to switch to using clidr_el1.
> > 
> > init_of_cache_level()
> > \-of_count_cache_leaves()
> > will assume there a 2 cache leaves (L1 data/instruction caches), which
> > can be different from clidr_el1 information.
> > 
> > cache_setup_of_node() tries to read cache properties in the DT.
> > If there are none, this is considered a success. Knowing no
> > information was available would allow to switch to using clidr_el1.
> > 
> > Fixes: de0df442ee49 ("cacheinfo: Check 'cache-unified' property to count cache leaves")
> > Reported-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > Link: https://lore.kernel.org/all/20230404-hatred-swimmer-6fecdf33b57a@spud/
> > Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> 
> Humm, it would appear that the cache levels and topology is still provided,
> despite the lack of cache properties in the Device Tree which is intended by
> this patch set however we lost the size/ways/sets information, could we not
> complement the missing properties here?
> 

I am confused. How and from where the information was fetched before this
change ?

> If this is out of the scope of what you are doing:
> 
> Tested-by: Florian Fainelli <f.fainelli@gmail.com>
>

Just looking at the lscpu output before and after, it looks something is
broken. What am I missing here ?

-- 
Regards,
Sudeep
