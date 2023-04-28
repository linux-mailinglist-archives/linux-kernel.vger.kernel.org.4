Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0336F16E3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjD1Lhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 07:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjD1Lhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:37:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E662713
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 04:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682681855; x=1714217855;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r+lEb9TiFos67P+XBhpmGcYi3Yo9mEf1O2PfhzE4aek=;
  b=fXZlS5/9rKlGrGozdYxxYtKcYOwSkgQN2dCi142+OQkqjhG93niP26Vl
   zojcVeUUBzjCcniauVUYWonJ4a4tUWsQEFu2BTXoopGkdvvHsPFTTZYRh
   etZ0tPb/TZKSGGL/izLWTQn3UC7ebKMeTL3my1G4YKMHQFBaQrhsKTgbO
   2Ug1IvJJKv4YRpnblujdlFzOmesCq+sBp8h8cMv1/B7zwV4DRviQRvTsA
   DStZ3w23ZddjtyFtsHU5tiSQsQ4wraEWq4yFbO2ctI4RRLSdEv3mY56ZW
   nQh40si0CZ6PSQ/efUWNlv6V3NJ21/dzVwUtIwyQTa2pEq9Pfii8R++wy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="328059572"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="328059572"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 04:37:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="759629569"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="759629569"
Received: from ahermans-mobl1.ger.corp.intel.com (HELO intel.com) ([10.252.35.91])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 04:37:31 -0700
Date:   Fri, 28 Apr 2023 13:37:28 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Juergen Gross <jgross@suse.com>,
        linux-kernel@vger.kernel.org,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Chris Wilson <chris.p.wilson@linux.intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH] x86/mm: Fix PAT bit missing from page protection
 modify mask
Message-ID: <ZEuv+PoleXWAa4Nw@ashyti-mobl2.lan>
References: <20230424123524.17008-1-janusz.krzysztofik@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424123524.17008-1-janusz.krzysztofik@linux.intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janusz,

On Mon, Apr 24, 2023 at 02:35:24PM +0200, Janusz Krzysztofik wrote:
> Visible glitches have been observed when running graphics applications on
> Linux under Xen hypervisor.  Those observations have been confirmed with
> failures from kms_pwrite_crc Intel GPU test that verifies data coherency
> of DRM frame buffer objects using hardware CRC checksums calculated by
> display controllers, exposed to userspace via debugfs.  Affected
> processing paths have then been identified with new test variants that
> mmap the objects using different methods and caching modes.

BTW, are you going to update those tests in IGT?

Andi
