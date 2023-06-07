Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43402726A80
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjFGUQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjFGUP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:15:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8961988
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 13:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686168956; x=1717704956;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PoRZzBbj2EpbllNo6rsPa775ECJXNOEiJAZONjo3nJc=;
  b=VWs+DEccGmJhoR6TlGXtwBYCwoV/Ut3i5bjpbdo5kpET4j9ork7M+nhC
   iivaL7i8lIDBr6Yv+FjjVAbZYFqVqrX1YWTb0Tfrx1UtQXd6Yd/4MYOdz
   DGITTixbjZC/IxiNv4u6rc7qZTeho+Yoh1aj6391MlDR8CNHakdJ6dIm7
   KTqyqh1UZs0GenwxqRlNj0/xDQrtW6qrTuPfMEhogKve0xCZj+WKVI59n
   8gtZxAfL805K1NkO1w88vJ8gdD2I1ICAW6wVD+5MgTMAVffe1tuLMapBZ
   SVsj2F2Pw5RPOmy4IngCBgyzIuaWpvA6lxU14jFFpL6Fzo4MbgZYwZyLN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="359565532"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="359565532"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 13:15:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="779591850"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="779591850"
Received: from vsmyers-mobl2.amr.corp.intel.com (HELO [10.212.146.233]) ([10.212.146.233])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 13:15:42 -0700
Message-ID: <12a12721-239b-457e-1ff7-f98c02cb7abe@intel.com>
Date:   Wed, 7 Jun 2023 13:15:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] x86/microcode/AMD: Load late on both threads too
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        stable@kernel.org
References: <20230605141332.25948-1-bp@alien8.de>
 <d3be3b2b-7c58-36eb-cd25-acea494e608d@intel.com>
 <20230607200339.GDZIDim1s0FYkoeNDK@fat_crate.local>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230607200339.GDZIDim1s0FYkoeNDK@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 6/7/23 13:03, Borislav Petkov wrote:
> On Wed, Jun 07, 2023 at 12:36:53PM -0700, Dave Hansen wrote:
>> What's the benefit of doing the loading on both threads?  I would have
>> naively thought it was just wasted work.
> I have the perfect example for this, see:
> 
> e7ad18d1169c ("x86/microcode/AMD: Apply the patch early on every logical thread")
> 
> so it is for reasons like that.

Yikes, so the second CMT thread reports a bumped version but not all the
_effects_ of that version?  That's, uh ... fun???

>> I think I even have a back-burnered Intel patch around somewhere that
>> ensures that we *never* load on both threads.
> Interesting - I guess there are considerable differences in microcode
> architecture between the two. 😄

Yeah, sure seems that way.
