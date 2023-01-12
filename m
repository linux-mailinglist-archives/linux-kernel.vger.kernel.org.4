Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4F2667EB8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240329AbjALTIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239769AbjALTHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:07:21 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6587BC96
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 10:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673549354; x=1705085354;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=10RfZkZb5SV9PwBP5TlGcgRhGBrbMjAk6DG5J/1Q6Iw=;
  b=duE1bCU0A8omxOVlXyTbKFfFdYnDBvMocJKlJykzn27qRskSmsXFVGtG
   M3uSII2rhyQ3bS8baDvHa0/iyuaUHZwxXf89olSbWxMF4zPfo2ICRT+gI
   KwNFCAYODK3VMXHEMGQuv9FjXMqLT5nbFiR06BmYl7cy6/3z19zOHxmJR
   IX93L8n19Xf6+KhxMZBWi3yH+j6CKlJutKFP1zNJuElwCMpbpg/O//V68
   FmKLzWmf0Tv13Ox+zLNsoavK0ITGwqQbw0uWHbaVnrCwmpEW/R8UHRXpR
   rtNl0pY06Sb25/UpEWI6ovcCdPx4/vEw+nh6TYUdghl6S23reV7tLZZaS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="303491672"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="303491672"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 10:48:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="746646078"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="746646078"
Received: from mdarpino-mobl.amr.corp.intel.com (HELO [10.209.117.208]) ([10.209.117.208])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 10:48:34 -0800
Message-ID: <f8352c29-6b9f-2711-ddf4-223a6806f42f@intel.com>
Date:   Thu, 12 Jan 2023 10:48:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/7] x86/cpu: Disable kernel LASS when patching kernel
 alternatives
Content-Language: en-US
To:     "Chen, Yian" <yian.chen@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Paul Lai <paul.c.lai@intel.com>
References: <20230110055204.3227669-1-yian.chen@intel.com>
 <20230110055204.3227669-4-yian.chen@intel.com>
 <693d8332-3b86-3dcf-fc87-5c3a08a752db@intel.com>
 <ad2da884-c8c8-bc57-e21f-452a08cb10cc@intel.com>
 <b9e73d06-bd95-7c54-3ff1-f9e43c9967a4@intel.com>
 <9e0a8b20-cb76-b06d-67fb-f8942df5a2f7@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <9e0a8b20-cb76-b06d-67fb-f8942df5a2f7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/23 10:36, Chen, Yian wrote:
> On 1/11/2023 4:37 PM, Dave Hansen wrote:
>> On 1/11/23 16:27, Chen, Yian wrote:
>>>> It seems we are implicitly relying on the on stac() and clac()
>>>> calls that are added for SMAP. Have you tried running with SMAP
>>>> disabled i.e "clearcpuid=smap"?
>>>>
>>> Yes, I tested with clearcpuid=smap.
>> It works by accident, then.
>>
>> clearcpuid=smap means that the kernel should be running as if
>> CPUID.(EAX=07H,ECX=0H):EBX.SMAP[bit 20]==0.  STAC/CLAC should #UD in
>> that case.
>>
> It could be something wrong in my Simics simulation environment.

Also, Andy Cooper made a very good point: when the kernel enables
paging, it's running with a low address so that the instruction pointer
stays valid as paging becomes enabled.

But, if LASS were enabled and enforced at that point, you'd get a LASS
fault and go kablooey.  Can you see what simics does in that case, and
also make sure we're clearing CR4.LASS when enabling paging?  That would
obviate the need to do it later in C code too.
