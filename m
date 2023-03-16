Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10866BCCF4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjCPKhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjCPKhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:37:02 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B554ECE0;
        Thu, 16 Mar 2023 03:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678963021; x=1710499021;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KEJY126tKd15SR9i/ZzZ9+b8kulIpPc0L6Pe52dUhZU=;
  b=ivg8f812dt0srxGHWV4iZUuGrdbX/3HQ8TxKmuzo9dHDE8yihgnHTHlv
   cT62sWO++vm1+maU/RecDCv0NRH3g6+psXG9yYofs/xueJ30Z6SXvlQyG
   KvZfM41cUZagkCB52VGgvuBXcTL/g78Hw36P7heEJtFn2KDlEsn/j6/uT
   9xulQNXWxRW7t4SsY1xkXde3Pq4rzxkeK0sGw4Y/vPJcuWBpAZ6/B+9IY
   95ZOz7FMFK0cR/ZShoZsYT9iw1IbBmq8BCEk7PKZNQj4H08H5vODLyeis
   KBH6HOtGXKQXggKrAf11FKmQqEDjPz5Cj9iKoIQElElUjgtoAL+yw6neZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="424223766"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="424223766"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 03:37:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="679850494"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="679850494"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 16 Mar 2023 03:36:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 753951CC; Thu, 16 Mar 2023 12:37:44 +0200 (EET)
Date:   Thu, 16 Mar 2023 12:37:44 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] thunderbolt: rename shadowed variables bit to
 interrupt_bit and auto_clear_bit
Message-ID: <20230316103744.GS62143@black.fi.intel.com>
References: <20230315220450.1470815-1-trix@redhat.com>
 <20230316102048.GR62143@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230316102048.GR62143@black.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 12:20:48PM +0200, Mika Westerberg wrote:
> +Cc Mario
> 
> On Wed, Mar 15, 2023 at 06:04:50PM -0400, Tom Rix wrote:
> > cppcheck reports
> > drivers/thunderbolt/nhi.c:74:7: style: Local variable 'bit' shadows outer variable [shadowVariable]
> >   int bit;
> >       ^
> > drivers/thunderbolt/nhi.c:66:6: note: Shadowed declaration
> >  int bit = ring_interrupt_index(ring) & 31;
> >      ^
> > drivers/thunderbolt/nhi.c:74:7: note: Shadow variable
> >   int bit;
> >       ^
> > For readablity rename the outer to interrupt_bit and the innner
> > to auto_clear_bit.
> 
> Thanks for the patch! Yeah, this did not show up in any of the kbuild
> tests perhaps they are missing cppcheck :(
> 
> I'm thinking that I'll just move the two commits from "fixes" to "next"
> and add this one on top (and drop the stable tags) as the code that we
> should be sending to stable should not need additional fixes IMHO. I
> know Mario is on vacation so probably cannot answer here so let's deal
> with this when he is back.

Applied to thunderbolt.git/next (along with the two commits from Mario).
