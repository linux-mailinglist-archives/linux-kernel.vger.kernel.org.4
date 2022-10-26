Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538F560EBD9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 00:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbiJZWsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 18:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbiJZWsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 18:48:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F267193E2;
        Wed, 26 Oct 2022 15:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666824517; x=1698360517;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IjLRYN8mTWR5u8at5ErLhw4tGxntLfjvcJ1Tgvk5bBI=;
  b=Yr92t2uHunSuMuoGnwdxINpfgdYbyytNGEVuxEKq0nJ/dzVWbVjetZyr
   IUfx2amyYJLzUXGXftrJ1w7jm//7bqt/TOZxQyAN1nTHW5jIkErQfGNsP
   Ja00uXvMJtU1Un+5w4l7bGzC5kLjbQAf0DtS3XkYQp3Ck7sGBehPNHZwo
   z+kHE49GUD3JnXcAV5JMunOB+Twq1O0bKfZsoKLXj/IG1iMLBjl70D+JE
   7w8ytC2qwEaars0BbZrp+X4fvS3kl/Yf48eQQlMmksxhlQIVI0L7W9gyR
   DQbZeIm0TGERnjKeHo56vaDh0QOlaMPgNW7a53f+SLqrW/5Pf8ojAe4Tm
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="295487043"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="295487043"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 15:48:36 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="877360641"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="877360641"
Received: from irebhi-mobl.ger.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.44.122])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 15:48:36 -0700
Message-ID: <180b1a4fb9cf78c8905f275e0373e009224d4639.camel@linux.intel.com>
Subject: Re: BUG: bisected: thermald regression (MEMLEAK) in commit
 c7ff29763989bd09c433f73fae3c1e1c15d9cda4
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        LKML <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net
Cc:     regressions@lists.linux.dev, regressions@leemhuis.info,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Robert Moore <robert.moore@intel.com>, devel@acpica.org
Date:   Wed, 26 Oct 2022 15:48:35 -0700
In-Reply-To: <6c2f47c8-d6b5-074a-4c8f-e9cd04f62ef4@alu.unizg.hr>
References: <e0f06714-5a49-a4e6-24e6-c4103c820819@alu.unizg.hr>
         <9ef3674afd370050b86a68e44c97e4f0257f1adf.camel@linux.intel.com>
         <bd1f0d2a-d456-92cc-ecca-23e480aea4b1@alu.unizg.hr>
         <e5d3d561bb3a9c68bc903cfc35c27629a4a9225c.camel@linux.intel.com>
         <d034dbbc-613c-1a5e-df64-d0251453c8eb@alu.unizg.hr>
         <6c2f47c8-d6b5-074a-4c8f-e9cd04f62ef4@alu.unizg.hr>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-10-26 at 19:52 +0200, Mirsad Goran Todorovac wrote:
> Dear all,
> 
> On 24. 10. 2022. 20:56, Mirsad Goran Todorovac wrote:
> > On 24. 10. 2022. 20:39, srinivas pandruvada wrote:
> > 
> > > > Thank you for the patch. Unfortunately, when applied to v6.0.3
> > > > it
> > > > didn't
> > > > fix the issue.
> > > Thanks for the test. I copied to acpi and acpica mailing list.
> > > Someone
> > > can tell us what is this call doing wrong here. 
> 
> I have worse news: after every
> 
> # systemctl stop thermald
> # systemctl start thermald
> 
> the number of leaks increases by one allocated block (apparently 80 
> bytes). The effect appears to be
> cummulative.
> 
> Please find the results of the MEMLEAK scan in the attachment.
> 
> In theory, motivated adversary could theoretically exhaust  i.e. 8
> GiB 
> in a loop of 10 million thermald stops/starts,
Of course it needs to be debugged. To start/stop systemctl service you
need root access. If you have root access, there are other worse things
can be done.

Thanks,
Srinivas

> on my laptop and 2 sec for stop+start, it would be approx. 230 days.
> 
> Hope this helps.
> 
> Mirsad
> 
> -- 
> 
> Mirsad Goran Todorovac
> Sistem inženjer
> Grafički fakultet | Akademija likovnih umjetnosti
> Sveučilište u Zagrebu

