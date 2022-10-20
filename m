Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2586064DC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiJTPoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiJTPol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:44:41 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248623336F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666280678; x=1697816678;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7SZdyBX7xxcUhRS7HDXxhTEx3xF6C4DT8dJnxk0H35I=;
  b=nIF4MMUlhaxwHJ5De3OkU9HS+3JuhLLnJnpvgcg4ookcbGpfhSpnyr1X
   T2G4STPqTRRznCCTkYLI8bYu9z3pp7cURnAQ4NOFuhq3f+Xg3rPwdvct2
   /c5vQHcMNjY+e9677WERxdA/aEDH6URN+w7zsXq31Ux/d+4HkY+4m4o6I
   D0EKmtCCzeoCEmCOiC7cHSZQQBmF/iPmAsV9oTJ8+dh8SFNW79R99EwUl
   Oevvr3MRtD7ejd6F9yXG6aXx/bEOAY91PfUEBhDUwXjy8ky9BS8QJOKhC
   rkGog3fqY9KZQMGohYearIZPuHpdYgVhaH810PntkS5CD4yv6c+RVyRjq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="368795414"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="368795414"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 08:44:23 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="663117411"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="663117411"
Received: from amancuso-mobl.amr.corp.intel.com (HELO [10.209.121.211]) ([10.209.121.211])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 08:44:22 -0700
Message-ID: <8f84e984-c42b-b672-c9db-e7d4464b2a15@intel.com>
Date:   Thu, 20 Oct 2022 08:44:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] x86/e820: make e820 type string uniform
Content-Language: en-US
To:     Yajun Deng <yajun.deng@linux.dev>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com
Cc:     noodles@fb.com, ross.philipson@oracle.com, daniel.kiper@oracle.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20221020115609.223940-1-yajun.deng@linux.dev>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221020115609.223940-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/22 04:56, Yajun Deng wrote:
> /proc/iomem:
> ...
> 00000000-00000fff : Reserved
> 00001000-0005efff : System RAM
> 0005f000-0005ffff : Reserved
> 00060000-0009ffff : System RAM
> 000a0000-000fffff : Reserved
>   000a0000-000bffff : PCI Bus 0000:00
>   000c0000-000cddff : Video ROM
>   000f0000-000fffff : System ROM
> 00100000-80ff3017 : System RAM
> 80ff3018-81003e57 : System RAM (kernel)
> 81003e58-81004017 : System RAM
> 81004018-81023c57 : System RAM (kernel)
> 81023c58-87672fff : System RAM

I guess this is a pretty minimal change.  It definitely makes
/proc/iomem more human-readable.

Did you consider if this change might break any users of this file?
