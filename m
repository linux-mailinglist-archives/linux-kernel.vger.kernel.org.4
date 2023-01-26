Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999E167C69A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 10:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbjAZJFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 04:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236713AbjAZJFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 04:05:00 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A4D1420D;
        Thu, 26 Jan 2023 01:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674723899; x=1706259899;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TY/aWE2nfCuOuBHa/VOThoHRZo+0adbfLFqd2D/Jfrg=;
  b=MlyH6IBR1fOU/o4kglxPCpd2uySAK1LG/CXIwRYevE+bSmGr0Mdd0k9M
   4Dg9MuQ8A+ZxOLxPWYlnZy/U2GYtxV2PNVuFa7448NmQCFuh9uAll/Dqr
   L6I1bqxQ6y0J1kG6d8KsPxGitqau0St8laHSz0n44FT3xKc0ChF1NZQd2
   ypmvMflJtk1l44xU42pO5V7kxDekcQJMIQF9PyzGSkxJruFit6khRUcme
   /MJIVdZOSaFUF/vvcAoXxCBM2LFxtqWs9OWDmorv/MDgmJeIqcJVTKQVp
   uJO57WAM3Y7kCsCKTRKAYAYoU6NNri0+flaSkgjXT5s7/soiEl3mPznZa
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="328019707"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="328019707"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 01:04:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="805314102"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="805314102"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 26 Jan 2023 01:04:56 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 26 Jan 2023 11:04:55 +0200
Date:   Thu, 26 Jan 2023 11:04:55 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Fan Chengwei <fancieux@outlook.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: BUG: crash after suspending
Message-ID: <Y9JCN/a5TAtEcO+i@kuha.fi.intel.com>
References: <SG2PR02MB4090B1F3E5EC0B7FCCC01807D7CE9@SG2PR02MB4090.apcprd02.prod.outlook.com>
 <Y9DpQGj+9FZglZjo@kuha.fi.intel.com>
 <SG2PR02MB40905C54F83BE73B4E6E17EFD7CE9@SG2PR02MB4090.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR02MB40905C54F83BE73B4E6E17EFD7CE9@SG2PR02MB4090.apcprd02.prod.outlook.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 12:26:52AM +0800, Fan Chengwei wrote:
> 
> 
> On 1/25/23 16:33, Heikki Krogerus wrote:
> > Hi,
> > 
> > The information you just gave is very useful. Thank you!
> > 
> > I'm still not completely sure if I understand the problem, but I'm
> > attaching a patch. Can you test it?
> > 
> > I'll also attach it to the bug.
> > 
> > thanks,
> > 
> It looks like the patch worked, and the original bug doesn't show up on my
> laptop. Thank you.

Okay, thanks. I'll clean up the patch and send it out.

Br,

-- 
heikki
