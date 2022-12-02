Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0165E640A80
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbiLBQVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbiLBQUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:20:54 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83074ECE60;
        Fri,  2 Dec 2022 08:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669997914; x=1701533914;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7kU26MIub+cu0n7tSsFLX1XdaUFcNgPBdV26TZeWYFY=;
  b=AU2ei758bfK60quDnQQa1GBEtu8uYf2Y321bLfHv6MlhKbWiobiXzdjx
   fcq/3L7WOccKokMDzrF3FnJg4wl2jputZkjLJBgoBApbWp6vfyEan7H1P
   EQdp3KbpH2HxXalk/8RJYjlC8Z6Ln24HsFytyK0AxGiWcuFgx+MKWaxWE
   HWgTcj0E5D1pgErVyk8yqjtsWp3EedNMTDDX8aIAdISDkAZsA3NTtGoBN
   6jL09Izd9GXQeRXAn65XhMSfSKCxxtV9vCQdPvkBnqY0hJFsD/UjXNUhJ
   iP0Mr9mOzNnKYyL5X7rKLiOAtGlIrcBF+y4BQF8VJjaZoUR9Ercl2vDpj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="380274543"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="380274543"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 08:17:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="595493381"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="595493381"
Received: from rsnyder-mobl.amr.corp.intel.com (HELO [10.209.68.71]) ([10.209.68.71])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 08:17:57 -0800
Message-ID: <93fd7ed0-5311-d6db-4d8b-b992a8f78ada@intel.com>
Date:   Fri, 2 Dec 2022 08:17:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/3] acpi/processor: fix evaluating _PDC method when
 running as Xen dom0
Content-Language: en-US
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        jgross@suse.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
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
 <6b212148-4e3f-3ef6-7922-901175746d44@intel.com>
 <Y4d8cm97hn5zuRQ1@Air-de-Roger>
 <4a0e9f91-8d8b-84bc-c9db-7265f5b65b63@intel.com>
 <Y4nugxKV1J/BqhBt@Air-de-Roger>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Y4nugxKV1J/BqhBt@Air-de-Roger>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/22 04:24, Roger Pau Monné wrote:
> On the implementation side, is the proposed approach acceptable?
> Mostly asking because it adds Xen conditionals to otherwise generic
> ACPI code.

That's a good Rafael question.

But, how do other places in the ACPI code handle things like this?
