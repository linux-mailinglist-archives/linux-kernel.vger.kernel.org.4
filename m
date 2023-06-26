Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC49473EEB9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 00:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjFZWlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 18:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFZWla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 18:41:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1669E5A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 15:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687819289; x=1719355289;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=8/m1xDTML3SNSnfRs3fLNjoB1vRmrSY2CPIGGu/dmz8=;
  b=UMY/vAoQBU1ncB04dapfW0mzwIxpojh4TVDPFGmOVUtBI5fvp0D56eQq
   OXr0HVJHQxmLw8RgKcjpV9cJsZuG20Io+UL6dyIihKHt6SzKjWutyGcK2
   AMLIUvoxc1wnbEA/EFscTDgGdKSwXqqD6aOpVZOa0A9bX8r3pDPyfgXvD
   hWs34Tn9WtwPV+MZhiL9wLxT9JiFGnsflOZ791gHlv20hdWb0UDizR1Rx
   zhfdFNIU+mSV1dwc/r595ShoADeuSCk7QdNDwPqTsIMrCY/zIqYLwhaWV
   nKN76Ol6f+JeTxp02tEMJHWWHAcGwN5BT/QxBzTu4RRbX+yXcwUxrEYUn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="351192298"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="351192298"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 15:41:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="806240616"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="806240616"
Received: from mshindo-mobl5.amr.corp.intel.com (HELO [10.212.198.145]) ([10.212.198.145])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 15:41:28 -0700
Content-Type: multipart/mixed; boundary="------------zZi90UpyOni7zEgX10gMwGUA"
Message-ID: <02b36386-a18c-8bfb-2c70-c398f6fc964b@intel.com>
Date:   Mon, 26 Jun 2023 15:41:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Bug report] __arch_hweight32/64 x86
Content-Language: en-US
To:     Sebastian Sumpf <Sebastian.Sumpf@genode-labs.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <cb18590f-686e-cc53-7781-1a36e91faade@genode-labs.com>
 <20230626210604.GLZJn9vA3gcMAuy/eP@fat_crate.local>
 <ce1cc0a5-3393-d16f-eaaf-5e7149d5164f@genode-labs.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <ce1cc0a5-3393-d16f-eaaf-5e7149d5164f@genode-labs.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------zZi90UpyOni7zEgX10gMwGUA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/23 14:42, Sebastian Sumpf wrote:
> 
>>> Therefore, these registers will not be restored
>>> upon function return by the compiler. This leads to varying
>>> exceptions/bad behavior caused by the thus corrupted registers later
>>> on.
>>
>> How do I reproduce what you're observing so that I can take a look?
> 
> This is hard to tell, I would disable the " X86_FEATURE_POPCNT" feature
> and use the ' CONFIG_ARCH_HAS_FAST_MULTIPLIER' option in order to use
> the multiplier implementation in '__sw_hweight64' in 'lib/hweight.c' At
> least that is what triggered it here.

Looks like you'd also have to be using UML:

$ grep hweight lib/Makefile
obj-$(CONFIG_GENERIC_HWEIGHT) += hweight.o
$ grep -r GENERIC_HWEIGHT arch/x86
arch/x86/um/Kconfig:config GENERIC_HWEIGHT

I'm not even sure that UML needs GENERIC_HWEIGHT.  From a quick glance,
it looks like x86 used to use GENERIC_HWEIGHT, but got arch-specific
versions later.  UML just never moved over to the arch-specific versions.

I _think_ the attached patch might just fix the problems with the C
version and bring the x86/UML implementation back in line with the rest
of x86.

Thoughts?
--------------zZi90UpyOni7zEgX10gMwGUA
Content-Type: text/x-patch; charset=UTF-8; name="um-hweight.patch"
Content-Disposition: attachment; filename="um-hweight.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L3VtL0tjb25maWcgYi9hcmNoL3g4Ni91bS9LY29uZmln
CmluZGV4IDE4NmYxMzI2ODQwMS4uNzZkNTA3ODYwYmU0IDEwMDY0NAotLS0gYS9hcmNoL3g4
Ni91bS9LY29uZmlnCisrKyBiL2FyY2gveDg2L3VtL0tjb25maWcKQEAgLTQ0LDYgKzQ0LDMg
QEAgY29uZmlnIEFSQ0hfSEFTX1NDX1NJR05BTFMKIAogY29uZmlnIEFSQ0hfUkVVU0VfSE9T
VF9WU1lTQ0FMTF9BUkVBCiAJZGVmX2Jvb2wgITY0QklUCi0KLWNvbmZpZyBHRU5FUklDX0hX
RUlHSFQKLQlkZWZfYm9vbCB5Cg==

--------------zZi90UpyOni7zEgX10gMwGUA--
