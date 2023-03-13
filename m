Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6576C6B6F41
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 06:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjCMFqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 01:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCMFqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 01:46:15 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7F02BED8;
        Sun, 12 Mar 2023 22:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678686374; x=1710222374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xOVX04NMGm21cJ3YIo/0A8ze3aZruPEgVWV5otmS3KA=;
  b=Bf9UflqRkBgCcggOvM0liOlfrN5pC4rw7YQ3QyrXQZxevN4QwAPAVi38
   dpT/fKICTDC3h+ORdsGB/WxCE/WwUIwn4iIuq9qL71145uPLsHWBHoa6F
   sBAvf3jnCX+wgphdIYGslpysEUIQQAT0WHoTMoBOX+tpb2zvwYNriZ4Qu
   s/x147XjXVq6mDXQkdZfOk1cSXaVhyVcN5ze1resLrGyMvjJo1Btjr8GL
   aoF4hTnulh+mi6Iaq0cU072NoqHLz5rgl8KpYTdrRpPDLf5IZ04NvgC6L
   fM6dILNVnDRjDEW6B/yu1HWGOPZiYNfPgqCS54jmir/EiYyNB0hG4EIJy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="337086643"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="337086643"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 22:46:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="628514255"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="628514255"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 12 Mar 2023 22:46:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id A060D143; Mon, 13 Mar 2023 07:46:54 +0200 (EET)
Date:   Mon, 13 Mar 2023 07:46:54 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Sanjay R Mehta <sanju.mehta@amd.com>, anson.tsao@amd.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] thunderbolt: Disable interrupt auto clear for rings
Message-ID: <20230313054654.GC62143@black.fi.intel.com>
References: <20230310172050.1394-1-mario.limonciello@amd.com>
 <20230310172050.1394-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230310172050.1394-3-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

On Fri, Mar 10, 2023 at 11:20:50AM -0600, Mario Limonciello wrote:
> When interrupt auto clear is programmed, any read to the interrupt
> status register will clear all interrupts.  If two interrupts have
> come in before one can be serviced then this will cause lost interrupts.
> 
> On AMD USB4 routers this has manifested in odd problems particularly
> with long strings of control tranfers such as reading the DROM via bit
> banging.

Nice catch! Does this mean we can drop [1] now?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git/commit/?h=next&id=8d7f459107f74fbbdde3dd5b3874d2e748cb8a21

I would still like to keep the nice refactor you did for the DROM
parsing, though.
