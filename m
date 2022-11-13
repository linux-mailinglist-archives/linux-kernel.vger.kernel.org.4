Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB6A6272BF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 22:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235431AbiKMVlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 16:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiKMVk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 16:40:59 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB35510B7B;
        Sun, 13 Nov 2022 13:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668375658; x=1699911658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bNlNZseaZnMODtk6Zs2b51a6AGQxczkjf9fhjdYuBHg=;
  b=JE6MOspZT43ya54e8BoQv18oqslVa4+6JArS2ttoFtmOBZRZ5z3Wahk6
   d1quU2UdGCosPVVh3arsfPkreuvVm0AuOLq8EVEgVaNWgp+qSUHp8z3Ta
   bLC7Kc+VM0ki+8RjbzBm/CIiIjiD9g3WIvIRfpfem4KKuLuBPwv8gJJGg
   jVzRsylqIn8Cume0+dzglWClDtFmNx58F8RAkoFtUtjKKGUgzhg3TMig3
   pgdPoq7OtWDhsXUbDiayoNtvf4ntIGbVCGp2rwstWzNZ9g2jJu6ApcDOf
   9kEDuvpO2dCNnkfp2pBohfaihQNuTstldQQ2tD8w/nmtRLiueCPZOkAwo
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="292242024"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="292242024"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 13:40:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="780701274"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="780701274"
Received: from perwin-mobl.amr.corp.intel.com (HELO tjmaciei-mobl5.localnet) ([10.212.163.208])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 13:40:57 -0800
From:   Thiago Macieira <thiago.macieira@intel.com>
To:     Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Jimenez Gonzalez, Athenas" <athenas.jimenez.gonzalez@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
Subject: Re: [PATCH v2 12/14] platform/x86/intel/ifs: Add current_batch sysfs entry
Date:   Sun, 13 Nov 2022 13:40:56 -0800
Message-ID: <1745359.VLH7GnMWUR@tjmaciei-mobl5>
Organization: Intel Corporation
In-Reply-To: <Y3EUPKWDefnkeObR@zn.tnic>
References: <20221021203413.1220137-1-jithu.joseph@intel.com> <Y3EJ93xzgC/1v0WV@a4bf019067fa.jf.intel.com> <Y3EUPKWDefnkeObR@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 13 November 2022 07:58:52 PST Borislav Petkov wrote:
> * simply try *all* files in a directory

By the way, we don't want that.

It's possible that different steppings of the same generation will have the 
same test scan files, with the extended signature informing that they are valid 
for this stepping too (see find_matching_signature())), because these files are 
going to be pretty big, in the order of a hundred MB each. That means we will 
either see symlinked or hardlinked files in the directory.

If you blindly try them all, you're going to spend twice or three times as 
long as necessary to complete the scan. With the timeout in question for at 
least Sapphire Rapids, we're talking about a difference measured in hours.
-- 
Thiago Macieira - thiago.macieira (AT) intel.com
  Cloud Software Architect - Intel DCAI Cloud Engineering



