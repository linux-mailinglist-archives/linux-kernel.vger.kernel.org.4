Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAFD63C6D8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbiK2Ryc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbiK2Ry3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 12:54:29 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848D545A0E;
        Tue, 29 Nov 2022 09:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669744467; x=1701280467;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lKETQwm8/AYRbtudWQgvt+s2fE4xcmiG++pU4pE+d6w=;
  b=DN42QkDy+C6shEKlUZUqF0G4/oESigpuf9wtreqpgfaM0b64GANWx5Xv
   NbMUHimRlWrY5w+Pga1+K/9VoyzCry/IZ/JX5FSO0N6Jx3vopWXXd2JSU
   l5ESMl6uo324uoB/e16bOFhLC8T1TsBpI49kQ79UkuFVcGzvANDOKkVTG
   v6XZNgXa92PwJbsmb7msj+oM4p05V55LJvMM3UdUHS2qsDhPtugYJc8gV
   /N5swXV/N+Wrm5Tp6eGNUBQJKsdcT1ZoRxqa67ziRxfOI1tUbEmN2RLVi
   U3zkjsw6WKIQhKiq0d3uIRfQEhpjgl1uku0Pl2GKtEefqqr8HtHiRHa9r
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="316335761"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="316335761"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 09:43:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="768512573"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="768512573"
Received: from wteng-mobl1.gar.corp.intel.com (HELO [10.209.83.194]) ([10.209.83.194])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 09:43:53 -0800
Message-ID: <6b212148-4e3f-3ef6-7922-901175746d44@intel.com>
Date:   Tue, 29 Nov 2022 09:43:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/3] acpi/processor: fix evaluating _PDC method when
 running as Xen dom0
Content-Language: en-US
To:     Roger Pau Monne <roger.pau@citrix.com>,
        linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, jgross@suse.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Alex Chiang <achiang@hp.com>,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        linux-acpi@vger.kernel.org
References: <20221121102113.41893-1-roger.pau@citrix.com>
 <20221121102113.41893-2-roger.pau@citrix.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221121102113.41893-2-roger.pau@citrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/22 02:21, Roger Pau Monne wrote:
> When running as a Xen dom0 the number of CPUs available to Linux can
> be different from the number of CPUs present on the system, but in
> order to properly fetch processor performance related data _PDC must
> be executed on all the physical CPUs online on the system.

How is the number of CPUs available to Linux different?

Is this a result of the ACPI tables that dom0 sees being "wrong"?

> The current checks in processor_physically_present() result in some
> processor objects not getting their _PDC methods evaluated when Linux
> is running as Xen dom0.  Fix this by introducing a custom function to
> use when running as Xen dom0 in order to check whether a processor
> object matches a CPU that's online.

What is the end user visible effect of this problem and of the solution?


