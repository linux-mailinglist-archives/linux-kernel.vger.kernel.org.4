Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22DA729E8F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241482AbjFIPce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjFIPcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:32:33 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63A23596
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686324748; x=1717860748;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v51RHSTw8xEjQxppc1XRi8stX/tlHpxTk03qUolx73Y=;
  b=Mq9O4tqkAzCmTj7rhN5nQ9WG5kP0gxT8mOd1UQLQX3pZSfMYJnhZIg99
   TwN4oUgnIVxLajlby0kIDCSMYwsmAHMFS6PyhWxVmyLVZL2cs6+AEZ0Jj
   pHM0yAh0vGMCrJqn+f8KjEsYbp8+GvPZthtAcYX38plEEELETUMDwjdY2
   rS/AHiEpM08jgFb40TIbx+op3R2lNvF3Ngd7gjKvQgVXB59D7fdruzOB5
   M3rMXuTtm4OYrK9IWVFmfYxOk5uCy+aC2M1CBaS+wsXJSKUCFjMQ6VDwE
   wHB3pl76fg8+pOo1aTPu89DyQu8CImFNDMU0wzbIDx3wo2110TZQiRrOw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="385988578"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="385988578"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 08:32:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="884633183"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="884633183"
Received: from mdeisher-mobl3.amr.corp.intel.com (HELO [10.212.149.144]) ([10.212.149.144])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 08:32:23 -0700
Message-ID: <74ec3164-1d1d-7546-6008-9d028354e50a@intel.com>
Date:   Fri, 9 Jun 2023 08:32:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] iscsi_ibft: Fix finding the iBFT under Xen Dom 0
Content-Language: en-US
To:     konrad@darnok.org, Juergen Gross <jgross@suse.com>
Cc:     Ross Lagerwall <ross.lagerwall@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        xen-devel@lists.xenproject.org, Jan Beulich <jbeulich@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Peter Jones <pjones@redhat.com>,
        Konrad Rzeszutek Wilk <konrad@kernel.org>
References: <20230605102840.1521549-1-ross.lagerwall@citrix.com>
 <f2ccd563-4fac-084f-bd11-e6819dff5710@suse.com>
 <CAPbh3ruFn1to+t9QiuYM7h8CqL-fs2q73Rscj6PWGZuBkS8FEw@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAPbh3ruFn1to+t9QiuYM7h8CqL-fs2q73Rscj6PWGZuBkS8FEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/23 08:22, Konrad Rzeszutek Wilk wrote:
> Dave, are you OK with the change in where the reserve call is made?

The move makes logical sense.  I'm not 100% confident it won't regress
anything, but the blast radius should be limited to iSCSI.  But, yeah,
I'm OK with it.
