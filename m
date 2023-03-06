Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502546ABD6C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 11:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjCFKzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 05:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjCFKzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:55:09 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C1215145;
        Mon,  6 Mar 2023 02:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678100108; x=1709636108;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=/TIgeCfWFJlJ6em1rKJ0RE3ltK53jlMLsH29ltUGH68=;
  b=b1rBFV8v1TTZOcSS5OMO3Sj680vDyOVv8o3i7apOBFOIJk6PSXQnAQZy
   MRAjBgsM3UemBEcGi1bHcOYt7IGuW8v/K4oTEJ30FfCKXsTEaiIz2xchk
   7dyyj30B6wMgOojtg9Dq0xwlcKyZnD9SSBNAubcIKT0NBxVQPjHPnUuIq
   GxtXXL76KHUIBdOAy2iVV55eJJmVWgR/PGfhnhkfB3kDmaYAKeHhHxjQM
   4p08xWgGEPmgTWORxgiwZeXpMRMHcEvdvhn8UECtm0MnWCmYm9y6pRkSz
   8O29JXgX60i0DUtXJB0kzuj+b8+ddvT2UM+PhEOWngeIFIavuWev2zOtK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="337042610"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="337042610"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 02:55:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="653567874"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="653567874"
Received: from bholthau-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.58.77])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 02:55:02 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Intel GFX Mailing List <intel-gfx@lists.freedesktop.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: Linux 6.2.1 hits a display driver bug (list_del corruption,
 ffff88811b4af298->next is NULL)
In-Reply-To: <ZAOTU5CRwdEC1lGH@biznet-home.integral.gnuweeb.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <6feae796-db3f-1135-a607-cfefb0259788@gnuweeb.org>
 <ZAGqet3U8AMm4Uf1@debian.me>
 <ZAOTU5CRwdEC1lGH@biznet-home.integral.gnuweeb.org>
Date:   Mon, 06 Mar 2023 12:54:59 +0200
Message-ID: <87v8jetaik.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Mar 2023, Ammar Faizi <ammarfaizi2@gnuweeb.org> wrote:
> On Fri, Mar 03, 2023 at 03:06:18PM +0700, Bagas Sanjaya wrote:
>> Can you please try v6.1?
>
> It's reproducible in v6.1.9. I finally can reliably reproduce it, it
> only happens when I start a VM with qemu.
>
> Specifically adding this device to the qemu instance:
>
>   <hostdev mode="subsystem" type="pci" managed="yes">
>     <source>
>       <address domain="0x0000" bus="0x00" slot="0x02" function="0x0"/>
>     </source>
>     <address type="pci" domain="0x0000" bus="0x04" slot="0x00" function="0x0"/>
>   </hostdev>
>
> And that slot is used by this hardware:
>
>   0000:00:02:0 Intel Corporation TigerLake-LP GT2 [Iris Xe Graphics]
>
> Removing it from the qemu instance solves the issue. But it's still a
> kernel bug anyway.

Please file a bug at fdo gitlab:

https://gitlab.freedesktop.org/drm/intel/wikis/How-to-file-i915-bugs


BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
