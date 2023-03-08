Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A150E6B0222
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjCHI4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCHIz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:55:57 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFDE98842;
        Wed,  8 Mar 2023 00:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678265756; x=1709801756;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v0FORj2NWSyCCoGql/X/Kg/LiWaknEsTJEy6ke6X/Fk=;
  b=YqPsQfysKLW0HwBv4X8b+sMPh0NDH+7wzDNVO3MQA4x3l1fEAAAq+i/5
   MRwA+q8dnZhGq0H0dYLsTSBGMtCddefvfEyFx2sEDrCInbue7q9v6jxEr
   rvwt40Ud7DdtMdmnPZ8pNLj17Nd500WhyxB9wam6GLe4XDVUpHngvQ4GV
   BmE12EKPlInD2haCzuIRwsPTPpt8HnxYMwaWJMc+vvY2E72JmBv4D9kcz
   pmolITqAvOsR+yif/iDDi6uctlCyaqJfK1huumcP/dJNAzxiauegSnoXa
   8c3rwtDpbFOClV0qhjOMFgi+4hM9ZDycmcDatx7RPEd4ricwS7VtWqmtd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="400930509"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="400930509"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 00:55:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="670246262"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="670246262"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.252.59.114])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 00:55:47 -0800
Date:   Wed, 8 Mar 2023 09:55:42 +0100
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     "NeilBrown" <neilb@suse.de>
Cc:     "Song Liu" <song@kernel.org>,
        "Linux regressions mailing list" <regressions@lists.linux.dev>,
        Jes.Sorensen@gmail.com, "linux-raid" <linux-raid@vger.kernel.org>,
        "LKML" <linux-kernel@vger.kernel.org>,
        "Nikolay Kichukov" <hijacker@oldum.net>
Subject: Re: [regression] Bug 217074 - upgrading to kernel 6.1.12 from
 5.15.x can no longer assemble software raid0
Message-ID: <20230308095542.00001bba@linux.intel.com>
In-Reply-To: <167822843274.8008.1142380266687607670@noble.neil.brown.name>
References: <a13cd3b5-cc41-bf2f-c8ac-e031ad0d5dd7@leemhuis.info>
        <CAPhsuW7ZWthh0PZt71hQh1_51C0yMSpOqWYJKc_+VzzTmW_r5A@mail.gmail.com>
        <167805126796.8008.3635368722810568057@noble.neil.brown.name>
        <20230307095258.00001cb3@linux.intel.com>
        <167822843274.8008.1142380266687607670@noble.neil.brown.name>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Mar 2023 09:33:52 +1100
"NeilBrown" <neilb@suse.de> wrote:

> On Tue, 07 Mar 2023, Mariusz Tkaczyk wrote:
> > On Mon, 06 Mar 2023 08:21:07 +1100
> > "NeilBrown" <neilb@suse.de> wrote:
> >   
> > > On Sat, 04 Mar 2023, Song Liu wrote:  
> > > > + Jes.
> > > > 
> > > > It appeared to me that we can assemble the array if we have any of the
> > > > following:
> > > > 1. Enable CONFIG_BLOCK_LEGACY_AUTOLOAD;
> > > > 2. Have a valid /etc/mdadm.conf;
> > > > 3. Update mdadm to handle this case. (I tried some ugly hacks, which
> > > > worked but weren't clean).
> > > > 
> > > > Since we eventually would like to get rid of
> > > > CONFIG_BLOCK_LEGACY_AUTOLOAD, I think we need mdadm to handle this
> > > > properly. But the logistics might be complicated, as
> > > > mdadm are shipped separately.
> > > > 
> > > > Jes, what do you think about this? AFAICT, we need to update the logic
> > > > in mdopen.c:create_mddev().    
> > > 
> > > mdadm already handles this, but only if 
> > >    CREATE names=yes
> > > is present in /etc/mdadm.conf  
> > 
> > Hi,
> > 
> > "CREATE names=yes" enforces creation of /dev/md_name arrays instead of
> > /dev/mdXXX. It is a large change for users, too aggressive IMO. It will
> > destroy many setups.
> > 
> > To resolve it, we need is to use create_named_array() but respect old naming
> > convention. We already have find_free_devnm(), and we are able to keep
> > consistency because we can create 'mdXXX':
> > 
> > /sys/module/md_mod/parameters # echo md125 > new_array
> > 
> > /sys/module/md_mod/parameters # ll /sys/block/md125
> > lrwxrwxrwx 1 root root 0 Mar  7 10:54 /sys/block/md125 ->
> > ../devices/virtual/block/md125
> > 
> > That will require adjustments in mdadm, but I think that we can keep
> > names the same way. I created the test for verification of base creation
> > flows, we can use it to avoid regression:
> > https://git.kernel.org/pub/scm/utils/mdadm/mdadm.git/tree/tests/00createnames
> > 
> > Thoughts?  
> 
> Yes, that is probably sensible.
> 
> It would be nice to have a way to expose the "names=yes" functionality
> more obviously.  I think people would generally prefer it (/proc/mdstat
> becomes more meaningful) but I agree that forcing it on people is the
> the best approach.
> 
> Maybe a super-block flag that enables it for that array, and we start
> setting that flag when creating new arrays?
> 

That is controversial. I don't feel that using metadata to resolve Linux issue
is as a good way. It will work for native for sure but for IMSM it is not such
simple.

I think that we can handle it by config file.
When we set "ARRAY /dev/mdXXX" then it is honored. I'm familiar with such
cases, that works. In such case link may or may not be generated so far I
remember but... nobody cares if array name is meaningful and we can fix that
too. It seems to not be a big deal.

I would like to propose doing same for 'names'.
If there is no config or name is set to "/dev/md/name" it should work as now.
So, if someone would need backward compatibility we can add flag to --detail
and --examine breifs forces that, let say --use-link-as-name. By default
"ARRAY /dev/md_name" entry will be generated.

My PoV is based on IMSM, there may be small differences between IMSM and native
but I think that it applies everywhere.

Thanks,
Mariusz
