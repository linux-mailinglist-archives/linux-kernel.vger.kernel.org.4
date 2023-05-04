Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44196F6ECE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 17:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjEDPXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 11:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjEDPXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 11:23:14 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08BB44A1;
        Thu,  4 May 2023 08:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683213793; x=1714749793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9TcAKdsolrTcyR7kRO2MnyaoQAF+RM8oAHRHOpZd1ms=;
  b=Sf5U85sA1Czn7mrT/KYLakQyLJNbqdykoNf/rwtmlDJuN3vIzsI1FiaC
   JRkGzlJ4S+Cm6yJuNPXRaralIxiKEvaAPOld5SN8BmdqEjUHdeWpPhrEb
   aNhRuQ2mPwtawMnbCVc7uomySolt4NdGkOcVVBmH4ivRegIyNhgfh/Zk7
   v7Vh0WPnYELR5p3U4aaQUlDway+O3bymHdrlKir0x4N8oZcVJnex0rWXy
   bQN9U/6yU3FCz0DhrTFSf1CKsulKsvECUdEbqzsHBaMQJwayEDbygF2oT
   qXvm4c1B2y+1TvIzxKp/vyB8tkc10TxG+aASOMKfzgaRBUnG0wUidcXkg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="346438604"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="346438604"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 08:23:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="674584461"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="674584461"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.168.201])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 08:23:12 -0700
Date:   Thu, 4 May 2023 08:23:11 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     raghuhack78@gmail.com, linux-cxl@vger.kernel.org,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cxl/mbox: Remove redundant dev_err() after failed
 mem alloc
Message-ID: <ZFPN340/UstRWtmR@aschofie-mobl2>
References: <20230428012235.119333-1-raghuhack78@gmail.com>
 <3235466.44csPzL39Z@suse>
 <ZFLaG8jHHXmRp67w@aschofie-mobl2>
 <2755196.BEx9A2HvPv@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2755196.BEx9A2HvPv@suse>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 12:46:37PM +0200, Fabio wrote:
> On giovedì 4 maggio 2023 00:03:07 CEST Alison Schofield wrote:
> > On Wed, May 03, 2023 at 08:32:37PM +0200, Fabio wrote:
> > > On venerdì 28 aprile 2023 03:22:34 CEST Raghu H wrote:
> 
> [...]
> 
> > > > 
> > > > Signed-off-by: Raghu H <raghuhack78@gmail.com>
> > > 
> > > Is "Raghu H" the name you sign legal documents with?
> > 
> > Fabio,
> > Rather than asking a specific question to determine if this is a
> > valid SOB, let's just point folks to the documentation to figure
> > it out themselves.
> > I'm aware that the 'sign legal documents' test
> > has been used in the past, but kernel only actually requires a
> > known identity.
> > 
> > https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#sign-you
> > r-work-the-developer-s-certificate-of-origin
> > https://github.com/cncf/foundation/blob/659fd32c86dc/dco-guidelines.md
> 
> Alison,
> 
> Thanks for your suggestions.
> 
> I have just a couple of questions about this issue...
> 
> 1) How do we know that the "real name", which the Linux official documentation 
> refers to, should be interpreted in accordance to the document pointed by the 
> second link you provided? 
> 
> I mean, how can we be sure that the official documentation should be 
> interpreted according to the second link, since it doesn't even cite that 
> document from CNCF? 
> 
> Can you provide links to documents / LKML's threads that state agreement of 
> our Community about the "relaxed" interpretation by CNCF?

Citation is hidden it git history. See:
d4563201f33a ("Documentation: simplify and clarify DCO contribution example language")

> 
> 2) It looks that some maintainers (e.g., Greg K-H) still interpret "[] using 
> your real name (sorry, no pseudonyms or anonymous contributions.)" in a 
> "strict" and "common" sense. 

See the commit log above. The language was updated to say
"using a known identity (sorry, no anonymous contributions.)"

> 
> Can you remember that Greg refused all patches from "Kloudifold" and why? If 
> not, please take a look at the following two questions / objections from Greg: 
> https://lore.kernel.org/linux-staging/ZCQkPr6t8IOvF6bk@kroah.com/ and 
> https://lore.kernel.org/linux-staging/ZBCjK2BXhfiFooeO@kroah.com/.

The second link above is Greg recognizing that known pseudonyms are
allowed. 

> 
> It seems that this issue it's not yet settled. 
> Am I overlooking something?

Hey, I'm not meaning to jump on you for asking Raghu the question.
I realize you are being helpful to someone who is submitting their first
patch. I'm just saying to make the submitter aware of the guideline and
put the burden on them to make sure they're using a known identity.

Sometimes, what one person thinks of as 'common' is not. Let's refer to
the docs and not add out personal or historical layers of interpretation
on top of it. (The legal doc signing question may not apply to everyone.)

Alison

> 
> Again thanks,
> 
> Fabio
> 
> > > If not, please send a new version signed-off-by your full legal name.
> > > Otherwise... sorry for the noise.
> > > 
> > > Thanks,
> > > 
> > > Fabio
> 
> 
> 
