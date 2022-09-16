Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60A75BABDE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 12:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiIPK7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 06:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiIPK6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 06:58:55 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B7D4661C;
        Fri, 16 Sep 2022 03:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663325213; x=1694861213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VMKSeL1s3oVRo2Dzgzr3C8yNq48d9P4cYGuFF06QwJ4=;
  b=XKI/dxb8hvi1E8X9nzTV8gKrhuGSgcHFaptuQy+gpAKI2AoOjVqiS6nP
   umZEqi2ZWXN8dJtNVWXvDTNjKKW75WxOTMIkYQZ5abXSwslI0Z0j0ExOL
   1G4H5zdacqJxgfURjbZf7FtzvZA/XL+I7Abzvap4UebqQ8tJzcRbpyRSR
   G9JyDdiYepCUoVZznoSC4kJomjAefbE9R9Bdis/Ynb689SGUZWDSINsEe
   Z18T6qurvUyS8bBF54ayRaMJjKIDnJzWSDSnrseGCP5boSlpyaS0d+coE
   OhVm9jPUKyYUaWKHKOAXtSXQvC4M4UFFELXFL9llwZtlQr9a1MNswa7cI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="385256354"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="385256354"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 03:46:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="760008114"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 16 Sep 2022 03:46:48 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 16 Sep 2022 13:46:47 +0300
Date:   Fri, 16 Sep 2022 13:46:47 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Bastian Rieck <bastian@rieck.me>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        grzegorz.alibozek@gmail.com, andrew.co@free.fr, meven29@gmail.com,
        pchernik@gmail.com, jorge.cep.mart@gmail.com,
        danielmorgan@disroot.org, bernie@codewiz.org,
        saipavanchitta1998@gmail.com, rubin@starset.net,
        maniette@gmail.com, nate@kde.org
Subject: Re: [RFC PATCH 0/2] usb: typec: ucsi: Check connection on resume
Message-ID: <YyRUF5cFGpe2xf+m@kuha.fi.intel.com>
References: <20220907115626.21976-1-heikki.krogerus@linux.intel.com>
 <27257661.hdJqBvvX10@nimue>
 <YxrbtWDR7XI4s+Q+@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YxrbtWDR7XI4s+Q+@kuha.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bastian,

On Fri, Sep 09, 2022 at 09:22:50AM +0300, Heikki Krogerus wrote:
> On Thu, Sep 08, 2022 at 07:01:34AM +0200, Bastian Rieck wrote:
> > Dear Heikki,
> > 
> > > I'm sending these as an RFC first because I'm not done testing.
> > > 
> > > I made a small modification to my original proposal (in the bug
> > > report). Now also connection during suspend should be covered.
> > > 
> > > I would appreciate if you guys could test these again. If
> > > everything works, and the bug is fixed, let me know, and I'll add
> > > your Tested-by tags to the patches.
> > >
> > 
> > Thanks so much for these changes—that's awesome! I have just finished 
> > testing this against 5.19.7 (Arch Linux) with a Lenovo X1 (Gen 9).
> > 
> > I am very happy to see that, as far as I can tell, the issue 
> > disappeared completely!
> > 
> > However, I am receiving additional warnings via `journalctl` that I 
> > did not receive before; I have attached this trace as an additional 
> > log file. Nothing in there seems critical and I can confirm that the 
> > system continues to operate normally. I merely wanted to provide you 
> > with this additional information in case it is of relevance.
> > 
> > Please let me know if there's anything else I can do here; I really 
> > appreciate the time you spent on this!
> 
> Thank you for the report. That warning certainly needs to be sorted
> out before I send the final versions. I'll try to reproduce that.

I'm not getting anywhere with this one. Could you provide me with the
trace output from both module and ucsi events?

To enable those events - assuming debugfs is mounted to
/sys/kernel/debug:

        % echo 1 > /sys/kernel/debug/tracing/events/ucsi/enable
        % echo 1 > /sys/kernel/debug/tracing/events/module/enable

Run the suspend resume cycle, and then dump the trace output to a
file:

        % cat /sys/kernel/debug/tracing/trace > ucsi_trace

thanks,

-- 
heikki
