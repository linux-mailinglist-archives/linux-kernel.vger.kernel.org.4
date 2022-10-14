Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DD95FE78A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiJNDTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiJNDTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:19:23 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567501119CB;
        Thu, 13 Oct 2022 20:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665717556; x=1697253556;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CP7r4Um5+1qR+53fVUdJfLQyFttboCVnIx7/w/U+eTY=;
  b=AY0LneKOUhmcpumYh2tWV0pBz9Glwvtry61LYIdT3el4ZPTPsWhVM+k8
   N+Kx9zoi+FYufw/say9qcgmeD36QlRCeQUqDuqXGViq7U+ISQLl+VNLPd
   8a9DG8q/RWnPzplnNw2OA864vpr17pOKYFfDshcNKL7PI1rWBXiHuGYEC
   T2gSk0jWrjPsCT+yeGtTSiC79r9n3KIPkO/C5kXzfiNDTEwNL32qsGM9C
   5Bb1LjI8wFVn1Q6Yli/BZBuDwB3pYo+CO5PgABAoHG5A2VlwTYYKwlhXX
   Q0BHY1o+T9GLQ2IddJbY/JW+IIKXnEAQvYVXNvwAqZdtDALitLWfnqcrR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="391573192"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="391573192"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 20:19:16 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="622396134"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="622396134"
Received: from mkucejko-mobl.ger.corp.intel.com (HELO [10.213.24.166]) ([10.213.24.166])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 20:19:07 -0700
Message-ID: <147a619e-e595-90c5-7a2a-ffbc2d20be7c@intel.com>
Date:   Thu, 13 Oct 2022 20:19:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 0/8] x86/topology: Improve CPUID.1F handling
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        peterz@infradead.org, corbet@lwn.net, fenghua.yu@intel.com,
        jdelvare@suse.com, linux@roeck-us.net, len.brown@intel.com
References: <20220922133800.12918-1-rui.zhang@intel.com>
 <5af2d8bb-8591-78f6-8102-6f7d0df33d98@intel.com>
 <9a1ae0b5d7a5ee3c870195e942d58bdd9b3b71db.camel@intel.com>
 <CAJvTdKkYTQzY1UsH_o2QdN1bS4gVfT87bEwMvgUXYwd+VFD+=w@mail.gmail.com>
 <668e5126-f344-c30b-a743-877b1783cec7@intel.com>
 <0307a5881c875e0b104051792b0f5e7f0ff973c1.camel@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <0307a5881c875e0b104051792b0f5e7f0ff973c1.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/22 19:06, Zhang Rui wrote:
> Patch 4/8 ~ 5/8 are real fixes and they depends on patch 2/8 and 3/8 to
> avoid possible regressions. So patch 2/8 ~ 5/8 should be stable
> material.
> 
> patch 6/8 is also a bugfix, but we have not observed any functionality
> issues so far.

If you want to make this really easy on me, you could take the changelog
and comment revisions that I made in that testing branch that I shared,
integrate them, and send it out again, and *only* include the bugfixes.
