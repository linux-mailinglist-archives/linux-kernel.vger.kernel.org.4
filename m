Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9586BC192
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjCOXhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjCOXhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:37:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9096D9FBE9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 16:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678923324; x=1710459324;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NQJpa5UCmsYlmz1mfEg6+eiMHkbYcmvZUf1XJhtPzhU=;
  b=JtKBDiEoMqm0JfUGh8+cbYwZbzVkURu0By719FTc63rQhJHxdYqipiiJ
   biWVu5OTVvssDBCtfH7O5Z+GO7SztCAjdkvNejrOJGSSz+5t23dEpRIxY
   /qKgDJtG/8ZFYTPxpJvHy8Xhpq0aj6aTbi1jO1BxdvwAop3wlHou4H1Ce
   tLde7ry5t/gp248kEWqWpbFpRwEobnDRHpuyO68W5N2S3fp9GFjd6GKqP
   3f6p1VXrgt6IlMdZ+RE/wCnmN+uLsAbRlUcP9/sgfGX8YDKHvhl3rQg2t
   4hUJCIYCFx0XE5dE/sdC5mEnzF3M6rorXouOlxMPF09J1B2mTmisPKvh0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="400418395"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="400418395"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 16:34:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="790026004"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="790026004"
Received: from zlamorea-mobl.amr.corp.intel.com (HELO [10.209.109.244]) ([10.209.109.244])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 16:33:59 -0700
Message-ID: <3523ddf9-03f5-3179-9f39-cec09f79aa97@intel.com>
Date:   Wed, 15 Mar 2023 16:33:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/3] COVER: Remove memcpy_page_flushcache()
Content-Language: en-US
To:     Ira Weiny <ira.weiny@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
References: <20221230-kmap-x86-v1-0-15f1ecccab50@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221230-kmap-x86-v1-0-15f1ecccab50@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/23 16:20, Ira Weiny wrote:
> Commit 21b56c847753 ("iov_iter: get rid of separate bvec and xarray 
> callbacks") removed the calls to memcpy_page_flushcache().
> 
> kmap_atomic() is deprecated and used in the x86 version of
> memcpy_page_flushcache().
> 
> Remove the unnecessary memcpy_page_flushcache() call from all arch's.

Hi Ira,

Since the common code user is already gone these three patches seem
quite independent.  It seems like the right thing to do is have
individual arch maintainers cherry pick their arch patch and carry it
independently.

Is there a compelling reason to have someone pick up and carry these all
together that I'm missing?
