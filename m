Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9F66EF7E9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 17:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240731AbjDZPqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 11:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240440AbjDZPql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 11:46:41 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC4065B7;
        Wed, 26 Apr 2023 08:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682524000; x=1714060000;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ugyCHnG3qWOKkCCGCjpOitlzjFnC6K3seMcmfNep8vw=;
  b=OTtGfo+7m/8lapFAN//rRFG9gzvMZG6GtwsV1ApECqtuePKtQDJYkh3C
   uraoLrTLXDfnxYgT7tWnK0z1IEjEbykTfM8H9QgJ24qM+YUh/H2u1n5dk
   JoTRJa0WvnlIMep46OXmSGcRpSOhhIsTU7B6wbPD79rMuOYm8oDHHmcBH
   GtVcZ42vsu5JIXxaebvdxBgiwsVne2pFPIid0C0JOAdrHgvYwxTO0BYJu
   H8V63dYYYPFAcDw+JvFcqWzAsH4DSPSJ2mnbhfg9NbsaRHN7YpuQb2LgS
   3gNj1ogcKrTx5uoov8sBaDOTA/VLcv3mK9Kn4DiT8Dw7RfE1NGBsGhjwb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="410151758"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="410151758"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 08:46:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="940280452"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="940280452"
Received: from kdaneshi-mobl2.amr.corp.intel.com (HELO [10.209.15.204]) ([10.209.15.204])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 08:46:37 -0700
Message-ID: <da1c807e-66b7-7e9f-143d-44b6f7389b50@intel.com>
Date:   Wed, 26 Apr 2023 08:46:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] docs: security: Confidential computing intro and threat
 model
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ardb@kernel.org, kraxel@redhat.com,
        dovmurik@linux.ibm.com, elena.reshetova@intel.com,
        dave.hansen@linux.intel.com, Dhaval.Giani@amd.com,
        michael.day@amd.com, pavankumar.paluri@amd.com,
        David.Kaplan@amd.com, Reshma.Lal@amd.com, Jeremy.Powell@amd.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        alexander.shishkin@linux.intel.com, thomas.lendacky@amd.com,
        tglx@linutronix.de, dgilbert@redhat.com,
        gregkh@linuxfoundation.org, dinechin@redhat.com,
        linux-coco@lists.linux.dev, berrange@redhat.com, mst@redhat.com,
        tytso@mit.edu, jikos@kernel.org, joro@8bytes.org, leon@kernel.org,
        richard.weinberger@gmail.com, lukas@wunner.de, jejb@linux.ibm.com,
        cdupontd@redhat.com, jasowang@redhat.com, sameo@rivosinc.com,
        bp@alien8.de, security@kernel.org
References: <20230327141816.2648615-1-carlos.bilbao@amd.com>
 <ZEfrjtgGgm1lpadq@google.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <ZEfrjtgGgm1lpadq@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/23 08:02, Sean Christopherson wrote:
>> +While the traditional hypervisor has unlimited access to guest data and
>> +can leverage this access to attack the guest, the CoCo systems mitigate
>> +such attacks by adding security features like guest data confidentiality
>> +and integrity protection. This threat model assumes that those features
>> +are available and intact.
> Again, if you're claiming integrity is a key tenant, then SEV and SEV-ES can't be
> considered CoCo.

This document is clearly trying to draw a line in the sand and say:

	CoCo on one side, non-CoCo on the other

I think it's less important to name that line than it is to realize what
we need to do on one side versus the other.

For instance, if the system doesn't have strong guest memory
confidentiality protection, then it's kinda silly to talk about the
guest's need to defend against "CoCo guest data attacks".

Sure, the mitigations for "CoCo guest data attacks" are pretty sane even
without all this CoCo jazz. But if your goal is to mitigate damage that
a VMM out of the TCB can do, then they don't do much if there isn't
VMM->guest memory confidentiality in the first place.

So, sure, CoCo implementations exist along a continuum.  SGX is in there
(with and without integrity protection), as are SEV=>SEV-ES=>SEV and
MKTME=>TDX.

This document is making the case that the kernel should go to some new
(and extraordinary) lengths to defend itself against ... something.
Those defenses don't make much sense unless we've crossed that line in
the sand.

So, let's not quibble about where CoCo starts or ends, but let's _do_
make a list of things that we need before we do all the nonsense that
this doc suggests.

You're totally right that this doc forgot to mention guest registers
(whoops).
