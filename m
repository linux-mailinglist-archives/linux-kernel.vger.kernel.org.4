Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2466BE689
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 11:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjCQKXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 06:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjCQKXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 06:23:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A824590B76;
        Fri, 17 Mar 2023 03:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679048587; x=1710584587;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=+Cxq+enE7gfxkijORsOhk3oEYP+Z4v+5j0Oidn1pDvM=;
  b=kU4KRGF2xV9HIDTFqLNzE8gDrS4An+EeRAq9o7T+/ovXYOcakdNOhSV5
   6xJT9bhCIQ0vRQQF+jtqdk0+dOrugI5elX1kaMQlnL491yYA5hWlGZ91g
   B/b1kxuKzEXzwgApl81NKgdVZiaNod+6QU8TkTt924HhKQ0DvieuUJkED
   joJX9gA9RjezK3f6BcM5IprcKNb8BE3S8R1F8P4k/aF8w5OCdeslHs8HH
   whFMlb6HmjbsFjbDwLzayngulypGfqleHwtpHcCit4BEMcNFuuyKybPqz
   D2r5Sbe0eM/At9x4PczDC9kUbj8divF/u545zeUlg/5Tw4BMNAjGdzXPX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="322078949"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="322078949"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 03:23:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="630246122"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="630246122"
Received: from yeonbokl-mobl1.amr.corp.intel.com ([10.212.99.82])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 03:23:04 -0700
Message-ID: <795de1449650c1c2293f4b52edcfd0cc2d12ca69.camel@linux.intel.com>
Subject: Re: [PATCH linux-next v2 1/3] platform/x86/intel/tpmi: Fix double
 free in tpmi_create_device()
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 17 Mar 2023 03:23:02 -0700
In-Reply-To: <7d535885-0bf1-bbeb-7a7e-89e67aaafa1e@redhat.com>
References: <20230309040107.534716-1-dzm91@hust.edu.cn>
         <20230309040107.534716-2-dzm91@hust.edu.cn>
         <dd36a2ab-d465-f857-30c6-3c0094babd31@redhat.com>
         <559654bbef8483fcd53458824f23814236b0c9e0.camel@linux.intel.com>
         <40d7cb19-5712-9754-b7bd-2b582055c929@hust.edu.cn>
         <7d535885-0bf1-bbeb-7a7e-89e67aaafa1e@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksCgouLi4KLi4uCgo+ID4gCgo+ID4gSGkgU3Jpbml2YXMgYW5kIEhhbnMsCj4gPiAKPiA+IEhv
dyBhYm91dCBmb2xkaW5nIHRoZXNlIHRocmVlIHBhdGNoZXMgaW50byBvbmUgcGF0Y2ggYW5kIHJl
c2VuZCBhCj4gPiB2MyBwYXRjaD8KPiA+IAo+ID4gVGhpcyB3aWxsIGdldCBhbGwgcGVvcGxlIHRv
Z2V0aGVyIGFuZCBhdm9pZCB0aGUgcHJldmlvdXMKPiA+IGVtYmFycmFzc2luZyBzaXRhdGlvbi4K
PiAKPiBJZiBJIHVuZGVyc3RhbmQgdGhpbmdzIGNvcnJlY3RseSB0aGVuIHBhdGNoIDEvMyBuZWVk
cyAzLzMgdG8gZnVuY3Rpb24KPiBjb3JyZWN0bHksIHJpZ2h0ID8KPiAKPiBJIHdvdWxkIG5vdCBm
b2xkIHRoZW0gdG9nZXRoZXIsIHNtYWxsZXIgcGF0Y2hlcyBhcmUgZWFzaWVyIHRvIHJldmlldwo+
IC8gdW5kZXJzdGFuZCwgYnV0IG1heWJlIGNoYW5nZSB0aGUgb3JkZXIgYW5kIHB1dCBwYXRjaCAz
LzMgZmlyc3Q/IChzbwo+IG1ha2UgaXQgMS8zKSA/CgpUaGF0IHNob3VsZCBiZSBjb3JyZWN0IG9y
ZGVyLiBUaGUgcGF0Y2ggMy8zIHNob3VsZCBiZSB0aGUgZmlyc3QuCgo+IAo+IEkgY2FuIGV2ZW4g
ZG8gdGhhdCB3aGVuIGFwcGx5aW5nIGlmIHlvdSBhZ3JlZSB0aGF0IGlzIHRoZSBiZXR0ZXIKPiBv
cmRlci4KQWdyZWUuCgpUaGFua3MsClNyaW5pdmFzCgo+IAo+IFJlZ2FyZHMsCj4gCj4gSGFucwo+
IAo+IAo+IAo+ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiDCoMKgZHJpdmVycy9wbGF0Zm9ybS94ODYv
aW50ZWwvdHBtaS5jIHwgMTcgKysrKy0tLS0tLS0tLS0tLS0KPiA+ID4gPiA+IMKgwqAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkKPiA+ID4gPiA+IAo+ID4g
PiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL3RwbWkuYwo+ID4g
PiA+ID4gYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC90cG1pLmMKPiA+ID4gPiA+IGluZGV4
IGM5OTk3MzJiMGYxZS4uODgyZmU1ZTQ3NjNmIDEwMDY0NAo+ID4gPiA+ID4gLS0tIGEvZHJpdmVy
cy9wbGF0Zm9ybS94ODYvaW50ZWwvdHBtaS5jCj4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3BsYXRm
b3JtL3g4Ni9pbnRlbC90cG1pLmMKPiA+ID4gPiA+IEBAIC0yMTUsOCArMjE1LDggQEAgc3RhdGlj
IGludCB0cG1pX2NyZWF0ZV9kZXZpY2Uoc3RydWN0Cj4gPiA+ID4gPiBpbnRlbF90cG1pX2luZm8g
KnRwbWlfaW5mbywKPiA+ID4gPiA+IMKgIMKgwqDCoMKgwqDCoMKgwqDCoGZlYXR1cmVfdnNlY19k
ZXYgPQo+ID4gPiA+ID4ga3phbGxvYyhzaXplb2YoKmZlYXR1cmVfdnNlY19kZXYpLAo+ID4gPiA+
ID4gR0ZQX0tFUk5FTCk7Cj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoIWZlYXR1cmVf
dnNlY19kZXYpIHsKPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXQg
PSAtRU5PTUVNOwo+ID4gPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8g
ZnJlZV9yZXM7Cj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKga2ZyZWUo
cmVzKTsKPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVO
T01FTTsKPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoH0KPiA+ID4gPiA+IMKgIMKgwqDCoMKg
wqDCoMKgwqDCoHNucHJpbnRmKGZlYXR1cmVfaWRfbmFtZSwgc2l6ZW9mKGZlYXR1cmVfaWRfbmFt
ZSksCj4gPiA+ID4gPiAidHBtaS0KPiA+ID4gPiA+ICVzIiwgbmFtZSk7Cj4gPiA+ID4gPiBAQCAt
MjQyLDE3ICsyNDIsOCBAQCBzdGF0aWMgaW50IHRwbWlfY3JlYXRlX2RldmljZShzdHJ1Y3QKPiA+
ID4gPiA+IGludGVsX3RwbWlfaW5mbyAqdHBtaV9pbmZvLAo+ID4gPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgICogZmVhdHVyZV92c2VjX2RldiBtZW1vcnkgaXMgYWxzbyBmcmVlZCBhcyBwYXJ0IG9m
Cj4gPiA+ID4gPiBkZXZpY2UKPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoCAqIGRlbGV0ZS4K
PiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+ID4gPiA+ID4gLcKgwqDCoMKgwqDCoMKg
cmV0ID0gaW50ZWxfdnNlY19hZGRfYXV4KHZzZWNfZGV2LT5wY2lkZXYsICZ2c2VjX2Rldi0KPiA+
ID4gPiA+ID4gYXV4ZGV2LmRldiwKPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmZWF0dXJlX3ZzZWNfZGV2LAo+
ID4gPiA+ID4gZmVhdHVyZV9pZF9uYW1lKTsKPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoGlmIChy
ZXQpCj4gPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBmcmVlX3Jl
czsKPiA+ID4gPiA+IC0KPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoHJldHVybiAwOwo+ID4gPiA+
ID4gLQo+ID4gPiA+ID4gLWZyZWVfcmVzOgo+ID4gPiA+ID4gLcKgwqDCoMKgwqDCoMKga2ZyZWUo
cmVzKTsKPiA+ID4gPiA+IC0KPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoHJldHVybiByZXQ7Cj4g
PiA+ID4gPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gaW50ZWxfdnNlY19hZGRfYXV4KHZzZWNfZGV2
LT5wY2lkZXYsCj4gPiA+ID4gPiAmdnNlY19kZXYtCj4gPiA+ID4gPiA+IGF1eGRldi5kZXYsCj4g
PiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBmZWF0dXJlX3ZzZWNfZGV2LAo+ID4gPiA+ID4gZmVhdHVyZV9pZF9u
YW1lKTsKPiA+ID4gPiA+IMKgwqB9Cj4gPiA+ID4gPiDCoCDCoMKgc3RhdGljIGludCB0cG1pX2Ny
ZWF0ZV9kZXZpY2VzKHN0cnVjdCBpbnRlbF90cG1pX2luZm8KPiA+ID4gPiA+ICp0cG1pX2luZm8p
Cj4gCgo=

