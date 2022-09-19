Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1045BD4BE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 20:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiISSaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 14:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiISSah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 14:30:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FB72B61F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 11:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663612236; x=1695148236;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=Gn5QeiWrMiahoSLBSm3/k0G4eI3kTGCsp0uJTykBkRs=;
  b=NCWZxrlnBAnUta6VxE9ysorL/qH2V5gq1XOX6SLra/zC9GsxudKdF9vR
   h+jzpp2CkaXtAtId4R3YkFwRIUtZ3KnYQ21W5qzj4INvxKsRSEasA0rMR
   ov2b4394xiO7Ni6V8DyOROzYe1eBuwYjFkvNY/oBiUtX6vUXeGP/NqjV7
   xT+WnViX66vppd+Uo+4W/Xy0IEEwdHmjmZ7xqiA66qR7L6JKb2tc2VsPL
   uDZszdHcRMW2iURF4AVtZL11B8qKsrvQqyLbxcp1Xd34PhXS70bNx+SyC
   slsrgEp7Fcx19AzbJfhxzcWAN48nU6QkxbMjk5BECmoUyVS0ECGN8ap4m
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="282511399"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="282511399"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 11:30:11 -0700
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="680962255"
Received: from dvanwage-mobl1.amr.corp.intel.com (HELO [10.209.74.97]) ([10.209.74.97])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 11:30:10 -0700
Content-Type: multipart/mixed; boundary="------------oCJ0Y9e0uXZlFEqiFZbruT0p"
Message-ID: <c83b4d34-8447-03dd-1068-99aaa159e04b@intel.com>
Date:   Mon, 19 Sep 2022 11:30:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/mm: Set NX bit when making pages present
Content-Language: en-US
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Liu, Yujie" <yujie.liu@intel.com>, "bp@alien8.de" <bp@alien8.de>
References: <20220909152721.1685334-1-dave.hansen@linux.intel.com>
 <14fea0e6809b42393388d20f5b62509108a87a71.camel@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <14fea0e6809b42393388d20f5b62509108a87a71.camel@intel.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------oCJ0Y9e0uXZlFEqiFZbruT0p
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/19/22 11:14, Edgecombe, Rick P wrote:
> Clearly somehow it is though. The original report has this in the log:
> Notice: NX (Execute Disable) protection cannot be enabled: non-PAE
> kernel!

Ah, crud.  Nice catch, btw.

So, the CPU has NX, making cpu_feature_enabled(X86_FEATURE_NX)==1, but
the page table mode does not have support.

I guess we can either clear X86_FEATURE_NX around the "protection cannot
be enabled" message, or do something like the attached patch and just do
the check at runtime.

I'm not sure we want to mess with X86_FEATURE_NX itself.  It seems to
get used for a few different things, including on the KVM side.

0day folks, can you see if _this_ one (totally untested) helps the
situation?  At least this is a real oddball case.  It's not something
that folks are very likely to hit at all.
--------------oCJ0Y9e0uXZlFEqiFZbruT0p
Content-Type: text/x-patch; charset=UTF-8; name="nx.patch"
Content-Disposition: attachment; filename="nx.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9zZXR1cC5jIGIvYXJjaC94ODYva2VybmVs
L3NldHVwLmMKaW5kZXggMjE2ZmVlNzE0NGVlLi4wMDU0OTIyNTdhYmIgMTAwNjQ0Ci0tLSBh
L2FyY2gveDg2L2tlcm5lbC9zZXR1cC5jCisrKyBiL2FyY2gveDg2L2tlcm5lbC9zZXR1cC5j
CkBAIC04NDQsNiArODQ0LDcgQEAgc3RhdGljIHZvaWQgX19pbml0IHg4Nl9yZXBvcnRfbngo
dm9pZCkKIAkJLyogMzJiaXQgbm9uLVBBRSBrZXJuZWwsIE5YIGNhbm5vdCBiZSB1c2VkICov
CiAJCXByaW50ayhLRVJOX05PVElDRSAiTm90aWNlOiBOWCAoRXhlY3V0ZSBEaXNhYmxlKSBw
cm90ZWN0aW9uICIKIAkJICAgICAgICJjYW5ub3QgYmUgZW5hYmxlZDogbm9uLVBBRSBrZXJu
ZWwhXG4iKTsKKwkJX19zdXBwb3J0ZWRfcHRlX21hc2sgJj0gfl9QQUdFX05YOwogI2VuZGlm
CiAJfQogfQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvbW0vcGF0L3NldF9tZW1vcnkuYyBiL2Fy
Y2gveDg2L21tL3BhdC9zZXRfbWVtb3J5LmMKaW5kZXggMWEyZDYzNzYyNTFjLi5mODE2MmZl
OTRiZDAgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L21tL3BhdC9zZXRfbWVtb3J5LmMKKysrIGIv
YXJjaC94ODYvbW0vcGF0L3NldF9tZW1vcnkuYwpAQCAtNTg3LDcgKzU4Nyw3IEBAIHN0YXRp
YyBpbmxpbmUgcGdwcm90X3QgdmVyaWZ5X3J3eChwZ3Byb3RfdCBvbGQsIHBncHJvdF90IG5l
dywgdW5zaWduZWQgbG9uZyBzdGFyCiB7CiAJdW5zaWduZWQgbG9uZyBlbmQ7CiAKLQlpZiAo
IWNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfTlgpKQorCWlmICghKF9fc3VwcG9y
dGVkX3B0ZV9tYXNrICYgX1BBR0VfTlgpKQogCQlyZXR1cm4gbmV3OwogCiAJaWYgKCEoKHBn
cHJvdF92YWwob2xkKSBeIHBncHJvdF92YWwobmV3KSkgJiAoX1BBR0VfUlcgfCBfUEFHRV9O
WCkpKQo=

--------------oCJ0Y9e0uXZlFEqiFZbruT0p--
