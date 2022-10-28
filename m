Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68947611628
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJ1PmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJ1PmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:42:02 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E8919E033
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666971722; x=1698507722;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qXogKb4zzReI2ctorcdoJz+JeQJBMnpuRbWp2opz5SE=;
  b=lWgTMcUWghN+W5TxF1wNuu+Sm4K8JdwhkPl67rIhGHvDNQkVxORFjoLn
   X8U6arLV9HfRIKkGy+p0XSJbBSgR0cupJ64HSh3G4ga1S8Bg5xcQfP/8F
   6V5+6uelj05Hkb1C3pkGQNWjIFeLF37rhPREJa8mQSSdPMWWROBObDUxE
   o3FmqmQvS23jKk0RIPpcnedby+fd/fuJNbP51RGz2TaJ7vEvRJ8MGWc/C
   yN/7iFceLWBLeU74Kxxp3PQOMyWjbAUFO8D4MqYKfrLbjqgOy24IxmFFL
   FtTSOVt5X4ym0EYmlqs270vdw/8RA3Acopwveal5bG6+n8uPgRItxk42f
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="295929638"
X-IronPort-AV: E=Sophos;i="5.95,221,1661842800"; 
   d="scan'208";a="295929638"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 08:42:01 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="738145639"
X-IronPort-AV: E=Sophos;i="5.95,221,1661842800"; 
   d="scan'208";a="738145639"
Received: from jbandiax-mobl.amr.corp.intel.com (HELO [10.209.126.71]) ([10.209.126.71])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 08:42:00 -0700
Message-ID: <1542cb57-7e3a-5881-a81c-031349ae8507@intel.com>
Date:   Fri, 28 Oct 2022 08:41:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] x86/tdx: Do not allow #VE due to EPT violation on the
 private memory
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, ak@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        seanjc@google.com, thomas.lendacky@amd.com,
        elena.reshetova@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20221028141220.29217-1-kirill.shutemov@linux.intel.com>
 <20221028141220.29217-3-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221028141220.29217-3-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/22 07:12, Kirill A. Shutemov wrote:
>  arch/x86/coco/tdx/tdx.c | 49 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)

The patch is good, but I'm not crazy about the changelog or the big ol'
comment.

Really, this would do:

	/*
	 * The kernel can not handle #VE's when accessing normal kernel
	 * memory.  Ensure that no #VE will be delivered for accesses to
	 * TD-private memory.  Only VMM-shared memory (MMIO) will #VE.
	 */
	if (!(td_attr & ATTR_SEPT_VE_DISABLE))
		panic("TD misconfiguration: SEPT_VE_DISABLE attibute must be set.\n");

I'll probably trim both of them down.  If I chop out something that's
critical, let me know, otherwise let's follow up and stick all of those
details in Documentation.
