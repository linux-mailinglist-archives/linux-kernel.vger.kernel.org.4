Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EE6619AE6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbiKDPEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiKDPET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:04:19 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFA265CB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 08:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667574259; x=1699110259;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Jw3Y9otHji7QTX5CGBkw7V4WGp0ZcL6hQNZS7M1jLPk=;
  b=dJ3hudH0eL4qPjdZ4uEnx5DdAaK3Iogbz63Fbhzn0nhDjwEP9UrN+pXd
   f8+xVOMFYmRukaQDAb/Sc/SYd6bETZBVh4HLJz+P4jGp6mVv+A2gdp508
   31lcYg8rkta890wYXKjV+5i2CyFjVjLIaB6gjc+r02YJd6Yujci61NLKW
   nRbbkur5KLK7QL00e9us9NYx9PJAV/UqkFHX88FXri7Rxhgrk8R2HgUKW
   FVXHRcdW4vaJ0qc9/QXWN5qncrzy94B8biUPgWDBMfEDkwikqBEMOvkGX
   7NJJS9UBxSuK1u8qIBkFfsPcffIrCgGXuCjJqonWBJHaT+KuWi5prE4Iz
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="374224164"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="374224164"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 08:04:18 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="698672785"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="698672785"
Received: from anantsin-mobl2.amr.corp.intel.com (HELO [10.209.97.57]) ([10.209.97.57])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 08:04:16 -0700
Message-ID: <8b5e9d9d-b55b-7af0-7ea7-f7130f6a1886@intel.com>
Date:   Fri, 4 Nov 2022 08:04:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 3/5] x86: drop 32-bit Xen PV guest code in
 update_task_stack()
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20221104072701.20283-1-jgross@suse.com>
 <20221104072701.20283-4-jgross@suse.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221104072701.20283-4-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/22 00:26, Juergen Gross wrote:
> Testing for Xen PV guest mode in a 32-bit only code section can be
> dropped, as Xen PV guests are supported in 64-bit mode only.
> 
> While at it switch from boot_cpu_has() to cpu_feature_enabled() in the
> 64-bit part of the code.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
