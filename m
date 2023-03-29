Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8016CD232
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 08:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjC2Glv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 02:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjC2Glt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 02:41:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75BC183
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 23:41:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A1E2B81E53
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77237C433D2;
        Wed, 29 Mar 2023 06:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680072106;
        bh=qWDRJnnYuR0GjKRjNRpAxR1QmdQilRFjC7Syg6Qq3Nk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xOcwJETa+hrXF2Jnd3SFvOC5zwVoGcw38L+pn5iOjnM2+qKEUDyHuUrw1Vm8+EtbK
         bHkKTnG+PF3LPXnCNcWVQ7VPjjOeYEVJGfUKjp+TMg3aGcZWiiZXg34cGMGm5xLaT3
         zVDzUyqbK2q7tGJAhAyJ3MCqfd+Nj0Zntw9w8J1w=
Date:   Wed, 29 Mar 2023 08:41:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Yicong Yang <yangyicong@huawei.com>, rafael@kernel.org,
        pierre.gondois@arm.com, palmer@rivosinc.com,
        linux-kernel@vger.kernel.org, prime.zeng@hisilicon.com,
        linuxarm@huawei.com, yangyicong@hisilicon.com
Subject: Re: [PATCH v2] cacheinfo: Fix LLC is not exported through sysfs
Message-ID: <ZCPdpybRVEuEkqHC@kroah.com>
References: <20230328114915.33340-1-yangyicong@huawei.com>
 <20230328124721.f65amn4v5qmdg64g@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328124721.f65amn4v5qmdg64g@bogus>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 01:47:21PM +0100, Sudeep Holla wrote:
> On Tue, Mar 28, 2023 at 07:49:15PM +0800, Yicong Yang wrote:
> > From: Yicong Yang <yangyicong@hisilicon.com>
> > 
> > After entering 6.3-rc1 the LLC cacheinfo is not exported on our ACPI
> 
> I would have preferred the commit causing the issue as you know and have
> it in the fixes tag, but info is there so I don't think it is worth another
> version churn. Sorry my bad for missing it earlier.
> 
> > based arm64 server. This is because the LLC cacheinfo is partly reset
> > when secondary CPUs boot up. On arm64 the primary cpu will allocate
> > and setup cacheinfo:
> > init_cpu_topology()
> >   for_each_possible_cpu()
> >     fetch_cache_info() // Allocate cacheinfo and init levels
> > detect_cache_attributes()
> >   cache_shared_cpu_map_setup()
> >     if (!last_level_cache_is_valid()) // not valid, setup LLC
> >       cache_setup_properties() // setup LLC
> > 
> > On secondary CPU boot up:
> > detect_cache_attributes()
> >   populate_cache_leaves()
> >     get_cache_type() // Get cache type from clidr_el1,
> >                      // for LLC type=CACHE_TYPE_NOCACHE
> >   cache_shared_cpu_map_setup()
> >     if (!last_level_cache_is_valid()) // Valid and won't go to this branch,
> >                                       // leave LLC's type=CACHE_TYPE_NOCACHE
> > 
> > The last_level_cache_is_valid() use cacheinfo->{attributes, fw_token} to
> > test it's valid or not, but populate_cache_leaves() will only reset
> > LLC's type, so we won't try to re-setup LLC's type and leave it
> > CACHE_TYPE_NOCACHE and won't export it through sysfs.
> > 
> > This patch tries to fix this by not re-populating the cache leaves if
> > the LLC is valid.
> >
> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> Hi Greg,
> 
> Can you pick this up in your next round of fixes for v6.3 please ?

Will do, thanks!
