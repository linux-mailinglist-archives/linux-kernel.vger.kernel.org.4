Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D056B8E3B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 10:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjCNJLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 05:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjCNJLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 05:11:36 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAED99C16;
        Tue, 14 Mar 2023 02:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678785081; x=1710321081;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WQVGzguMektICAtYLmM/lI9Il8wjM/11GOkoaszAIec=;
  b=ljrl56em+YKFU758HNg552Vsd5Oaz99DUFANE8D7vQLxW9ZJFhUk066a
   gTWuuPirnoeywoyiWpWvfTtqVjWmzLDi5lyOvskqubGwQOhYsZNlT435S
   Hkl4w9NHDzpXQQLeHdgkRjdrn7qgo0QDJlMkAWwxTHWLJ40UqN7n3Xa0g
   HBuHtoE8BLPMQD7FDbirTPLCGhx10+gfEThRA8OcJV5Zrl49ToXfYbC5s
   7ksfKYkElK0GQchqHV/KyBFSvKskDIh0hgojm/SZcZs293y2Lvo1q7dbB
   OhoE0yo6sBNwuG/LBKOWlXRhast1Td3EotypwRni00em5Jf2lRd760WZ+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="334853029"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="334853029"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 02:11:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="628977176"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="628977176"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.252.32.139])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 02:11:18 -0700
Date:   Tue, 14 Mar 2023 10:11:13 +0100
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     "NeilBrown" <neilb@suse.de>
Cc:     Jes Sorensen <jes@trained-monkey.org>,
        "Song Liu" <song@kernel.org>,
        "Linux regressions mailing list" <regressions@lists.linux.dev>,
        "linux-raid" <linux-raid@vger.kernel.org>,
        "LKML" <linux-kernel@vger.kernel.org>,
        "Nikolay Kichukov" <hijacker@oldum.net>
Subject: Re: [PATCH - mdadm] mdopen: always try create_named_array()
Message-ID: <20230314101113.000001fa@linux.intel.com>
In-Reply-To: <167875238571.8008.9808655454439667586@noble.neil.brown.name>
References: <167875238571.8008.9808655454439667586@noble.neil.brown.name>
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

On Tue, 14 Mar 2023 11:06:25 +1100
"NeilBrown" <neilb@suse.de> wrote:

> mdopen() will use create_named_array() to ask the kernel to create the
> given md array, but only if it is given a number or name.
> If it is NOT given a name and is required to choose one itself using
> find_free_devnm() it does NOT use create_named_array().
> 
> On kernels with CONFIG_BLOCK_LEGACY_AUTOLOAD not set, this can result in
> failure to assemble an array.  This can particularly seen when the
> "name" of the array begins with a host name different to the name of the
> host running the command.
> 
> So add the missing call to create_named_array().
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217074
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  mdopen.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mdopen.c b/mdopen.c
> index d18c931996d2..810f79a3d19a 100644
> --- a/mdopen.c
> +++ b/mdopen.c
> @@ -370,6 +370,7 @@ int create_mddev(char *dev, char *name, int autof, int
> trustworthy, }
>  		if (block_udev)
>  			udev_block(devnm);
> +		create_named_array(devnm);
>  	}
>  
>  	sprintf(devname, "/dev/%s", devnm);

Hi Neil,
Thanks for handling that. I didn't have time to get into this topic yet.
I trust you and I believe that it is a good fix but I cannot verify it by
standard code review- the code is to complex. Could you please add test for it
to prove it works this way at least for following cases?
- mdadm -CR /dev/md/name
- mdadm -CR name
- mdadm -CR /dev/md_name
- mdadm -CR /dev/mdX, where X is a number.

You can disable creation via open temporarily by changing value in
/sys/module/md_mod/parameters/new_array that should be enough for verification.

For code:
Acked-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>

Thanks,
Mariusz
