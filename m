Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BEC603625
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 00:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiJRWn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 18:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiJRWn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 18:43:27 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BC07D7A7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 15:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666133006; x=1697669006;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qxulG9G/t9vwt+iUnsW6mUi/P6PmpV9ptb8IJUKW4BE=;
  b=dSKBetqZ6Z2lhffHOHqaVDvzBdzgiqOqRbQDnA4TsCqjFIayWhoAV3mr
   FnhrtefNXhiaOmRIuL95Lql6r9QHnUcHGaMNBY3w8WONFmsxAcs/pMUZn
   EjYHEdfvpGWwbBZ+7vIWVprlpAf9elA6CrqWZd58JDqKhXogUlydYpCwk
   OECTWUDi9Fv7C9QnqajEYARlw/oHCWUUFc51XD3SqFm++tMmlPFn0sXj+
   /kfIsfn/FkiPMyE+dEOnPrC3l7aI9B797eJUHyc0vzJjUEAb5UP3TyUUM
   EXM9j5zLpvikq5kcTiXkTPiNvw6+VXWWcud5Thm/iYz98cEkJMzYWeGTc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="307938741"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="307938741"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 15:43:26 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="660033283"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="660033283"
Received: from jjsopko-mobl.amr.corp.intel.com (HELO [10.213.163.40]) ([10.213.163.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 15:43:24 -0700
Message-ID: <3a0dd700-ce2e-e1ec-ee8b-74cd68c360b7@intel.com>
Date:   Tue, 18 Oct 2022 15:43:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCHv10 10/15] x86/mm, iommu/sva: Make LAM and SVM mutually
 exclusive
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20221018113358.7833-1-kirill.shutemov@linux.intel.com>
 <20221018113358.7833-11-kirill.shutemov@linux.intel.com>
 <eb590d2c-581a-03e0-863c-0a33a20ae772@intel.com>
 <20221018223341.tiyypudh6k63mnnb@box.shutemov.name>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221018223341.tiyypudh6k63mnnb@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/22 15:33, Kirill A. Shutemov wrote:
>> Is this #ifdef really necessary?  CONFIG_IOMMU_SVA selects IOASID,
>> without which pasid_valid() is just stubbed out to 0.
> mm->pasid is only defined for CONFIG_IOMMU_SVA=y.
> 
> Do you want me to add mm_has_valid_pasid()?

A quick grep makes it look like pasid_valid() could be *replaced* with
mm_has_pasid_valid() since all the places doing pasid_valid() do it with
mm->pasid.
