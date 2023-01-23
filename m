Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915B9678444
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbjAWSPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjAWSPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:15:47 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119F7272C;
        Mon, 23 Jan 2023 10:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674497747; x=1706033747;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fCebxrq3wvFUCTQ6n7ODNVvPM0+JUTSbVVQl7ngMGaU=;
  b=WsOzdQONK7CyFiUqUUEyoNvndmt7I4xO/owq+izA4CQwjw0ylhU+oTtS
   QUvpUytI26odnIV41QY/3lVIzijd7FkEhKn9l0F1pIKn6FBKZbW4pF5Rz
   FBqvvC2R1nTazmy8VyjmrxWnGSF6NWu30Ox+miwFRQGLhxfp4JaKK2y86
   J7EXLag4KWdRprFIDdWQ5eJeZ3mipWKMAW8Gl8zAALn+J6M80aGUunpgT
   k8UDa56tSTY43sV7aPDKUQR3S8GMmWbkAoiqCzlvRIvwL3jxzKTBPDAag
   Nv3lPyGB9g1Uu3M0lfLCULHZSj3proA54FBOu4Cpr0ZgDXPMXgQ52S87p
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="390611361"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="390611361"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 10:15:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="611714969"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="611714969"
Received: from smmorton-mobl.amr.corp.intel.com (HELO [10.212.176.16]) ([10.212.176.16])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 10:15:45 -0800
Message-ID: <948c678b-5f26-2390-dd68-1b9b7b3fd50f@intel.com>
Date:   Mon, 23 Jan 2023 10:15:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3] x86/hibernate: Use fixmap for saving unmapped pages
Content-Language: en-US
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, x86@kernel.org, rafael@kernel.org, pavel@ucw.cz,
        len.brown@intel.com, rppt@kernel.org, peterz@infradead.org,
        luto@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230119235145.22740-1-rick.p.edgecombe@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230119235145.22740-1-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/23 15:51, Rick Edgecombe wrote:
> Hibernate uses the direct map to read memory it saves to disk. Since
> sometimes pages are not accessible on the direct map ("not present" on
> x86), it has special case logic to temporarily make a page present. On x86
> these direct map addresses can be mapped at various page sizes, but the
> logic works ok as long as the not present pages are always mapped as
> PAGE_SIZE such that they don't require a split to map the region as
> present. If the address was mapped not present by a larger page size, the
> split may fail and hibernate would then try to read an address mapped not
> present.

The "split" thing here kinda threw me a bit.

First, this code depends on having a 'struct page'.  On 64-bit, that
means that the pages at least have an address in the direct map.

But, that doesn't mean that there's an actual mapping in the direct map
for the page.  Lots of things zap the direct map.  To make up for this,
the hibernate code tries to temporarily restore a zapped mapping with
hibernate_map_page()->set_direct_map_default_noflush().

What's the actual failure mode here, though?  Does __change_page_attr()
just fail to find an existing PTE and fall over?  Or, does it actually
try to and fail to allocate the PTE page?


