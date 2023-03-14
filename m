Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646016BA3CF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 00:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjCNX5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 19:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjCNX5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 19:57:50 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED254D2A5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 16:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678838269; x=1710374269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xXyjZXsRkHq+WtyB+CeEXuj+S0q71iqnRVIqvixN/bk=;
  b=CK9n2yOiJvGIocfLLp8Bgw1Gc6tOY5XUwzfltdzzIspqoB+2XvwyLEan
   vccdgvJzjOwKhwzPQ6YbOdtxu2CHvq/xrZioz5ScPHwKkKDrGMIhrCSV6
   tZZp7hyFHrhTpBqemBWzpNKyuUOmOocVohO2F8G1eYnQZQPU4oPxN8rKX
   ToQybSdrNAMM7Rx34gHKMehmnC0GDLTLxybFRUom4AW24Np8yZy3tfM/1
   NZhWvnqcVNB0nyPwpfBEZC+pIzUpPDWQigTq3SabdBX7QbvgzJ3MZODWg
   NXF+huuLRHcIzEuvYtZA58TCDAAjY4bTBSTKr46NqU+9Cz0iajBqnxsJ3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="317966684"
X-IronPort-AV: E=Sophos;i="5.98,261,1673942400"; 
   d="scan'208";a="317966684"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 16:57:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="768296116"
X-IronPort-AV: E=Sophos;i="5.98,261,1673942400"; 
   d="scan'208";a="768296116"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.140.184])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 16:57:49 -0700
Date:   Tue, 14 Mar 2023 16:57:47 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: initialize timeouts in probe only
Message-ID: <ZBEJ+8DbhADSBTLr@aschofie-mobl2>
References: <ZA9mThZ7NyRrQAMX@khadija-virtual-machine>
 <ZBDcfNOXmGeN2tlb@aschofie-mobl2>
 <3376017.mWHT0XuiSF@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3376017.mWHT0XuiSF@suse>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 10:31:21PM +0100, Fabio wrote:
> On martedì 14 marzo 2023 21:43:40 CET Alison Schofield wrote:
> > On Mon, Mar 13, 2023 at 11:07:10PM +0500, Khadija Kamran wrote:
> > > Module parameter, read_timeout, can only be set at the loading time. As
> > > it can only be modified once, initialize read_timeout once in the probe
> > > function.
> > > As a result, only use read_timeout as the last argument in
> > > wait_event_interruptible_timeout() call.
> > > 
> > > Same goes for write_timeout.
> > > 
> > > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > > ---
> > 
> > Looks like this is [PATCH v5] and needs a changelog.
> >
> Alison,
> 
> In fact, this is only the second patch that addresses Greg's suggested 
> refactoring. 
> 
> Khadija moved from v3 of "staging: axis-fifo: remove tabs to align arguments" 
> to v4 of this completely independent patch. And then back to v1, because (at 
> the time of v4) I pointed out to her that she had started working on a project 
> that has a completely different purpose than the previous one.
> 
> The best course of action would have been to ask Greg to drop the previous 
> patches and then reset the numbering of the new job to v1. Unfortunately I did 
> not pay attention to how she then managed the numbering following my 
> observation.
> 
> What would be the best course of action at this point?

My guess is that this patch gets ignored because it has a lower version
number than a previous patch.

Take the feedback given here, and rev to
[PATCH v5] staging: axis-fifo: initialize timeouts in probe only

Be sure the Changelog, below the --- explains the journey.

Changes in v5:

Changes in v4:

Changes in v3:

Changes in v2:


> 
> Fabio
> 
> 
