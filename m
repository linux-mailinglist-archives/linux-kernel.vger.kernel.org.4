Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F606BE6B8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 11:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjCQK2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 06:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjCQK2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 06:28:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325E6E503A;
        Fri, 17 Mar 2023 03:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679048870; x=1710584870;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=b3uJJp2j4SXI+kVglBWomd4R/1qVyPfgtkR2mvNBq5I=;
  b=iSWJIB6B1MJfTh7sNk2F5SI6b5WWdGAEtXjwqnSgxK67/smdEjh8/mkx
   w/4Mz8B+Cvl52luqEgn/Jbl8QI4tkhRX7aJz61LSEHVm/U6IRq6sOYhAP
   XTwPVd1v3xlgiB3yzwo8M44ha00yPu4P8Pu4zXSBNfbdorGRQkgNp2d0Y
   m1e8h5YwReReanUcuBlRVwdnv0EHqYoNZ4TBYiHYSpHTSD2NPV2/Y01jf
   YUOLI6MTOQ1B0HmXXtSNcCXBvWc/gTuBH8zQxRqsRTwypWqRCzZD1g+LF
   +2dtC/B4R6FB3dfQs3RxPASPWmvgFtcrd8qRV9j0dENyZ0MQQ/nX4M9PZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="424502773"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="424502773"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 03:27:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="680259233"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="680259233"
Received: from yeonbokl-mobl1.amr.corp.intel.com ([10.212.99.82])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 03:27:48 -0700
Message-ID: <41c9e613d718095e31674f625f48c60fe493d658.camel@linux.intel.com>
Subject: Re: [PATCH linux-next v2 1/3] platform/x86/intel/tpmi: Fix double
 free in tpmi_create_device()
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Dongliang Mu <dzm91@hust.edu.cn>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 17 Mar 2023 03:27:47 -0700
In-Reply-To: <40d7cb19-5712-9754-b7bd-2b582055c929@hust.edu.cn>
References: <20230309040107.534716-1-dzm91@hust.edu.cn>
         <20230309040107.534716-2-dzm91@hust.edu.cn>
         <dd36a2ab-d465-f857-30c6-3c0094babd31@redhat.com>
         <559654bbef8483fcd53458824f23814236b0c9e0.camel@linux.intel.com>
         <40d7cb19-5712-9754-b7bd-2b582055c929@hust.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRG9uZ2xpYW5nLAoKPiAKLi4uCi4uLgoKCj4gSGkgU3Jpbml2YXMgYW5kIEhhbnMsCj4gCj4g
SG93IGFib3V0IGZvbGRpbmcgdGhlc2UgdGhyZWUgcGF0Y2hlcyBpbnRvIG9uZSBwYXRjaCBhbmQg
cmVzZW5kIGEgdjMKPiBwYXRjaD8KPiAKPiBUaGlzIHdpbGwgZ2V0IGFsbCBwZW9wbGUgdG9nZXRo
ZXIgYW5kIGF2b2lkIHRoZSBwcmV2aW91cyBlbWJhcnJhc3NpbmcKPiBzaXRhdGlvbi4KClRoaXMg
aXMgTk9UIGFuIGVtYmFycmFzc2luZyBzaXR1YXRpb24uClRoYW5rcyBmb3IgZmluZGluZyBhbmQg
Zml4aW5nIHRoZSBpc3N1ZS4KClRoYW5rcywKU3Jpbml2YXMKCgo+IAo+IERvbmdsaWFuZyBNdQo+
IAo+ID4gCj4gPiA+IFJlZ2FyZHMsCj4gPiA+IAo+ID4gPiBIYW5zCj4gPiA+IAo+ID4gPiAKPiA+
ID4gCj4gPiA+IAo+ID4gPiA+IC0tLQo+ID4gPiA+IMKgwqBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9p
bnRlbC90cG1pLmMgfCAxNyArKysrLS0tLS0tLS0tLS0tLQo+ID4gPiA+IMKgwqAxIGZpbGUgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkKPiA+ID4gPiAKPiA+ID4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvdHBtaS5jCj4gPiA+ID4gYi9k
cml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC90cG1pLmMKPiA+ID4gPiBpbmRleCBjOTk5NzMyYjBm
MWUuLjg4MmZlNWU0NzYzZiAxMDA2NDQKPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4
Ni9pbnRlbC90cG1pLmMKPiA+ID4gPiArKysgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC90
cG1pLmMKPiA+ID4gPiBAQCAtMjE1LDggKzIxNSw4IEBAIHN0YXRpYyBpbnQgdHBtaV9jcmVhdGVf
ZGV2aWNlKHN0cnVjdAo+ID4gPiA+IGludGVsX3RwbWlfaW5mbyAqdHBtaV9pbmZvLAo+ID4gPiA+
IMKgIAo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoGZlYXR1cmVfdnNlY19kZXYgPSBremFsbG9j
KHNpemVvZigqZmVhdHVyZV92c2VjX2RldiksCj4gPiA+ID4gR0ZQX0tFUk5FTCk7Cj4gPiA+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgaWYgKCFmZWF0dXJlX3ZzZWNfZGV2KSB7Cj4gPiA+ID4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IC1FTk9NRU07Cj4gPiA+ID4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gZnJlZV9yZXM7Cj4gPiA+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGtmcmVlKHJlcyk7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHJldHVybiAtRU5PTUVNOwo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoH0K
PiA+ID4gPiDCoCAKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqBzbnByaW50ZihmZWF0dXJlX2lk
X25hbWUsIHNpemVvZihmZWF0dXJlX2lkX25hbWUpLAo+ID4gPiA+ICJ0cG1pLQo+ID4gPiA+ICVz
IiwgbmFtZSk7Cj4gPiA+ID4gQEAgLTI0MiwxNyArMjQyLDggQEAgc3RhdGljIGludCB0cG1pX2Ny
ZWF0ZV9kZXZpY2Uoc3RydWN0Cj4gPiA+ID4gaW50ZWxfdHBtaV9pbmZvICp0cG1pX2luZm8sCj4g
PiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgICogZmVhdHVyZV92c2VjX2RldiBtZW1vcnkgaXMgYWxz
byBmcmVlZCBhcyBwYXJ0IG9mCj4gPiA+ID4gZGV2aWNlCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgICogZGVsZXRlLgo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+ID4gPiA+IC3CoMKg
wqDCoMKgwqDCoHJldCA9IGludGVsX3ZzZWNfYWRkX2F1eCh2c2VjX2Rldi0+cGNpZGV2LCAmdnNl
Y19kZXYtCj4gPiA+ID4gPiBhdXhkZXYuZGV2LAo+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmZWF0dXJlX3ZzZWNf
ZGV2LAo+ID4gPiA+IGZlYXR1cmVfaWRfbmFtZSk7Cj4gPiA+ID4gLcKgwqDCoMKgwqDCoMKgaWYg
KHJldCkKPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBmcmVlX3Jl
czsKPiA+ID4gPiAtCj4gPiA+ID4gLcKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4gPiA+ID4gLQo+
ID4gPiA+IC1mcmVlX3JlczoKPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqBrZnJlZShyZXMpOwo+ID4g
PiA+IC0KPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Owo+ID4gPiA+ICvCoMKgwqDC
oMKgwqDCoHJldHVybiBpbnRlbF92c2VjX2FkZF9hdXgodnNlY19kZXYtPnBjaWRldiwgJnZzZWNf
ZGV2LQo+ID4gPiA+ID4gYXV4ZGV2LmRldiwKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmZWF0dXJlX3ZzZWNf
ZGV2LAo+ID4gPiA+IGZlYXR1cmVfaWRfbmFtZSk7Cj4gPiA+ID4gwqDCoH0KPiA+ID4gPiDCoCAK
PiA+ID4gPiDCoMKgc3RhdGljIGludCB0cG1pX2NyZWF0ZV9kZXZpY2VzKHN0cnVjdCBpbnRlbF90
cG1pX2luZm8KPiA+ID4gPiAqdHBtaV9pbmZvKQoK

