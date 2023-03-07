Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DD06AD99F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjCGIxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjCGIxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:53:17 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB86C2A17D;
        Tue,  7 Mar 2023 00:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678179196; x=1709715196;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CkWIV2Sme/nIgVi1LRlIJJvdhICN9cwd5WczP5l0JHI=;
  b=HxpYKGg4QNLSFo0mipGKIWvT7AwxqhX17fR9w7L47sRdn8WuXgyYUtZN
   Ul9w2MK0BFxd41ZR6o0wqXNIu+XbNE+/P9xtzvdeZkRNlcwtHG0oGO86W
   roQvX+gbwEkLF5xUTD95ToR1jeH4JFq3qvKHngX0gOwiTf/ePdlSJt1cw
   A6nO4X6I5p4y8I5SzRpUqqn6L8+9ryIWGl6KifxJ913eboN4SC16dzlm+
   D5x4VKmZDJxjyiwm6RZS8jb87bia4plMlEP2SOomyfH56kpFLoG4XzKVZ
   1ybxLKnXxLVTb/aHaQEDWEIGDuAa25sqiecVN1s6RadPHk3lO5WQhCYjA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="398379590"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="398379590"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 00:53:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="850617900"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="850617900"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.252.46.26])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 00:53:03 -0800
Date:   Tue, 7 Mar 2023 09:52:58 +0100
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     "NeilBrown" <neilb@suse.de>
Cc:     "Song Liu" <song@kernel.org>,
        "Linux regressions mailing list" <regressions@lists.linux.dev>,
        Jes.Sorensen@gmail.com, "linux-raid" <linux-raid@vger.kernel.org>,
        "LKML" <linux-kernel@vger.kernel.org>,
        "Nikolay Kichukov" <hijacker@oldum.net>
Subject: Re: [regression] Bug 217074 - upgrading to kernel 6.1.12 from
 5.15.x can no longer assemble software raid0
Message-ID: <20230307095258.00001cb3@linux.intel.com>
In-Reply-To: <167805126796.8008.3635368722810568057@noble.neil.brown.name>
References: <a13cd3b5-cc41-bf2f-c8ac-e031ad0d5dd7@leemhuis.info>
        <CAPhsuW7ZWthh0PZt71hQh1_51C0yMSpOqWYJKc_+VzzTmW_r5A@mail.gmail.com>
        <167805126796.8008.3635368722810568057@noble.neil.brown.name>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Mar 2023 08:21:07 +1100
"NeilBrown" <neilb@suse.de> wrote:

> On Sat, 04 Mar 2023, Song Liu wrote:
> > + Jes.
> > 
> > It appeared to me that we can assemble the array if we have any of the
> > following:
> > 1. Enable CONFIG_BLOCK_LEGACY_AUTOLOAD;
> > 2. Have a valid /etc/mdadm.conf;
> > 3. Update mdadm to handle this case. (I tried some ugly hacks, which worked
> > but weren't clean).
> > 
> > Since we eventually would like to get rid of CONFIG_BLOCK_LEGACY_AUTOLOAD, I
> > think we need mdadm to handle this properly. But the logistics might
> > be complicated, as
> > mdadm are shipped separately.
> > 
> > Jes, what do you think about this? AFAICT, we need to update the logic in
> > mdopen.c:create_mddev().  
> 
> mdadm already handles this, but only if 
>    CREATE names=yes
> is present in /etc/mdadm.conf

Hi,

"CREATE names=yes" enforces creation of /dev/md_name arrays instead of
/dev/mdXXX. It is a large change for users, too aggressive IMO. It will destroy
many setups.

To resolve it, we need is to use create_named_array() but respect old naming
convention. We already have find_free_devnm(), and we are able to keep
consistency because we can create 'mdXXX':

/sys/module/md_mod/parameters # echo md125 > new_array

/sys/module/md_mod/parameters # ll /sys/block/md125
lrwxrwxrwx 1 root root 0 Mar  7 10:54 /sys/block/md125 ->
../devices/virtual/block/md125

That will require adjustments in mdadm, but I think that we can keep
names the same way. I created the test for verification of base creation flows,
we can use it to avoid regression:
https://git.kernel.org/pub/scm/utils/mdadm/mdadm.git/tree/tests/00createnames

Thoughts?

BTW. I wanted to get rid of this legacy "create_on_open" from mdadm anyway but
never had time to. If you agree, I can proceed with fixing it.

Thanks,
Mariusz
