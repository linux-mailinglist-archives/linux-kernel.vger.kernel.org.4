Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E687C624698
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiKJQH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiKJQH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:07:56 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835873F043
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668096475; x=1699632475;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JPp5EDDddCIcW0tICeOFfz4HE4lQV+wPxVcAIA4+K6M=;
  b=jYTcli9wtE1KRyv0IWu/q8bxQ8O1xVAZqPd9CFfBj8iGe6CVsUNAjjcH
   jWwuCAsglVNEcWCHiygDDZOuGmqrKE7MYMwJRVwmtgH3DiBAtiEM/1h/m
   8dIYPwoad0cj8AVz8J4WS2pLjzOiyFyUFML34BGiu0F4oOd1TIdM9BdkO
   v65owuSpgIghRX93eo6T9cJVgP1TuMmaC14PbAO71EXAbxe+uO0Bj7yOZ
   oddp/U4mvA77b969jfi/4uK3XWfzyBmA4oZe1zXj4oEi4zyXpKASgNoQr
   jr7DZYRgHWYCxGuk9alAwvwGQ6ye/hcHE3oO6HNt6wFKP0DzuaG6vap63
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="338106872"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="338106872"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 08:07:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="631702730"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="631702730"
Received: from csalvo-mobl1.amr.corp.intel.com (HELO [10.212.217.97]) ([10.212.217.97])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 08:07:54 -0800
Message-ID: <8e62a029-f2fa-0627-1f71-4850a68ec6b6@intel.com>
Date:   Thu, 10 Nov 2022 08:07:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] x86: Check return values from early_memremap calls
Content-Language: en-US
To:     Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        dave.hansen@linux.intel.com, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com, jailhouse-dev@googlegroups.com,
        jan.kiszka@siemens.com, xen-devel@lists.xenproject.org,
        jgross@suse.com, boris.ostrovsky@oracle.com,
        andrew.cooper3@citrix.com
References: <20221110154521.613472-1-ross.philipson@oracle.com>
 <20221110154521.613472-2-ross.philipson@oracle.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221110154521.613472-2-ross.philipson@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/22 07:45, Ross Philipson wrote:
>  	dt = early_memremap(initial_dtb, map_len);
> +	if (!dt) {
> +		pr_warn("failed to memremap initial dtb\n");
> +		return;
> +	}

Are all of these new pr_warn/err()'s really adding much value?  They all
look pretty generic.  It makes me wonder if we should just spit out a
generic message in early_memremap() and save all the callers the trouble.

Oh, and don't we try to refer to functions() with parenthesis?
