Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6C064E2C5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 22:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiLOVJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 16:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLOVJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:09:14 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F7732BBA
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 13:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671138552; x=1702674552;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fYu3VSMSVSFNCj8pshMBFs+p2fAnlKCwaMc/dyMskqk=;
  b=NYeTcw9cTNABQ4ANHNTSfnRdu+C9WulJOrmb7nMF2A4VvHbdNEx3a+RW
   R1zeLVSgT2p8GI6KeIB0ouAEnKbP6PmCfL0LZ5UAXiMkMclXycTqMweA5
   aISqCM0gGFXjNGSQQcYJVS8bLz6jVtitJiHrNuOj5EUfQuHL/pP6jdscj
   2NoJENEcNQRIdO45l7XDWWQOm9Dhk5ltWOx+ywfCFyBneVYnK46Nabhs0
   K5H0th8/V7fImTM9tM6yijkvA0nxMsQC5yittOsr6l9lHHMGbm5adGuY4
   8vdyS/iyqOr3Wqwp0tzXtSXTWVPqnyRBhuYJ/3TXgHVukDj4HDDMb1lgY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="299144432"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="299144432"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 13:09:11 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="756495436"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="756495436"
Received: from ajanssen-mobl.amr.corp.intel.com (HELO [10.209.22.168]) ([10.209.22.168])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 13:09:11 -0800
Message-ID: <b19600bd-d5cf-3359-60d8-1ecd9c1ff4f5@intel.com>
Date:   Thu, 15 Dec 2022 13:09:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/4] x86/tdx: Use ReportFatalError to report missing
 SEPT_VE_DISABLE
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221209132524.20200-1-kirill.shutemov@linux.intel.com>
 <20221209132524.20200-3-kirill.shutemov@linux.intel.com>
 <3121847d-d334-67fc-43d8-0670c08c64b6@intel.com>
 <20221215171254.3v4maexfhkdnbfk2@box.shutemov.name>
 <795d6e1d-c79c-b079-3412-69ca2f8ee874@intel.com>
 <20221215185144.tjctmkwp5vodep3u@box>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221215185144.tjctmkwp5vodep3u@box>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/22 10:51, Kirill A. Shutemov wrote:
>>> So ReportFatalError() is no good for the task. And I don't have anything
>>> else :/
>> Do we *really* have to do a hard stop when SEPT_VE_DISABLE is missing?
>>
>> Wouldn't it be simpler to just defer the check until we can spit out a
>> sane error message about it?
>>
>> Or is there too much security exposure by continuing?
> Well, I guess we can. We always have attestation as a backstop. No
> sensitive user data has to be exposed to the TD before it passed
> the attestation.

OK, so let's just pretend that SEPT_VE_DISABLE=0 is a blatant root hole
that lets the VMM compromise the TDX guest (I know it's not, but let's
just pretend it is).

The guest starts up, the VMM compromises it after the attestation has
run.  The now compromised guest send along its report.  But, since the
report contains (or implies???) SEPT_VE_DISABLE=0, the guest will be
assumed to be compromised and won't get any secrets provisioned?

That assumes that the attestation service knows that SEPT_VE_DISABLE==0
plus Linux is bad.  Is that a good assumption?

> Do you prefer to have a separate initcall just to check SEPT_VE_DISABLE?

I don't feel strongly about where the check should be as long as it can
get a message out to the console.
