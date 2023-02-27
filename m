Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEF96A3A4F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 06:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjB0FVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 00:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjB0FU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 00:20:59 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FA21116D;
        Sun, 26 Feb 2023 21:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677475258; x=1709011258;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=PRmzNDPLW359VDJZq8Qx7txrVCvA7QawULc06bBKX3k=;
  b=cKih6w2gV45oqgwb4Bkk+/9Nxv7rfXX/F2tGoRMe97bGn2kvl96JTxBJ
   HDB8NRthkMRPNnLh/FTKs0GKkVIDNxUHWj1UMphqX7qz0sk/qWEcz+1y5
   n0rM8fty8QRbVQ/qZ0csCPnv1e37NJjEezbf4Mlt0Rjl23bcQERv40k6J
   Nn+/x/lepKdW0A8wiquw5DyQEXtOz9KAG6WREAdJynz2qYnWanqbsO5zC
   orN14pCnrkbn4knWVOEuRomGlXK95DqXZnTR+6PBDjetDDyE0DKPl0ku5
   OoUzZcPXJwIIB6UUMpXEnyCNOECrhk15DCPFGyPKMh/pMDVmwStHYoXYT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="336059868"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="336059868"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 21:20:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="673612760"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="673612760"
Received: from dkumarr-mobl2.gar.corp.intel.com ([10.213.123.7])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 21:18:17 -0800
Message-ID: <d5c82db4bf9aac71342a8e969ae2deb145d71280.camel@linux.intel.com>
Subject: Re: [PATCH] HID: intel-ish-hid: ipc: Fix potential use-after-free
 in work function
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Reka Norman <rekanorman@chromium.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Li Qiong <liqiong@nfschina.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 26 Feb 2023 21:18:14 -0800
In-Reply-To: <20230227024938.2265017-1-rekanorman@chromium.org>
References: <20230227024938.2265017-1-rekanorman@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAyLTI3IGF0IDEzOjQ5ICsxMTAwLCBSZWthIE5vcm1hbiB3cm90ZToKPiBX
aGVuIGEgcmVzZXQgbm90aWZ5IElQQyBtZXNzYWdlIGlzIHJlY2VpdmVkLCB0aGUgSVNSIHNjaGVk
dWxlcyBhIHdvcmsKPiBmdW5jdGlvbiBhbmQgcGFzc2VzIHRoZSBJU0hUUCBkZXZpY2UgdG8gaXQg
dmlhIGEgZ2xvYmFsIHBvaW50ZXIKPiBpc2h0cF9kZXYuIElmIGlzaF9wcm9iZSgpIGZhaWxzLCB0
aGUgZGV2bS1tYW5hZ2VkIGRldmljZSByZXNvdXJjZXMKPiBpbmNsdWRpbmcgaXNodHBfZGV2IGFy
ZSBmcmVlZCwgYnV0IHRoZSB3b3JrIGlzIG5vdCBjYW5jZWxsZWQsIGNhdXNpbmcKPiBhCj4gdXNl
LWFmdGVyLWZyZWUgd2hlbiB0aGUgd29yayBmdW5jdGlvbiB0cmllcyB0byBhY2Nlc3MgaXNodHBf
ZGV2LiBVc2UKPiBkZXZtX3dvcmtfYXV0b2NhbmNlbCgpIGluc3RlYWQsIHNvIHRoYXQgdGhlIHdv
cmsgaXMgYXV0b21hdGljYWxseQo+IGNhbmNlbGxlZCBpZiBwcm9iZSBmYWlscy4KPiAKPiBTaWdu
ZWQtb2ZmLWJ5OiBSZWthIE5vcm1hbiA8cmVrYW5vcm1hbkBjaHJvbWl1bS5vcmc+CkFja2VkLWJ5
OiBTcmluaXZhcyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNv
bT4KCj4gLS0tCj4gCj4gwqBkcml2ZXJzL2hpZC9pbnRlbC1pc2gtaGlkL2lwYy9pcGMuYyB8IDkg
KysrKysrKystCj4gwqAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaGlkL2ludGVsLWlzaC1oaWQvaXBjL2lwYy5j
IGIvZHJpdmVycy9oaWQvaW50ZWwtCj4gaXNoLWhpZC9pcGMvaXBjLmMKPiBpbmRleCAxNWUxNDIz
OWFmODI5Li5hNDljNmFmZmQ3YzRjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvaGlkL2ludGVsLWlz
aC1oaWQvaXBjL2lwYy5jCj4gKysrIGIvZHJpdmVycy9oaWQvaW50ZWwtaXNoLWhpZC9pcGMvaXBj
LmMKPiBAQCAtNSw2ICs1LDcgQEAKPiDCoCAqIENvcHlyaWdodCAoYykgMjAxNC0yMDE2LCBJbnRl
bCBDb3Jwb3JhdGlvbi4KPiDCoCAqLwo+IMKgCj4gKyNpbmNsdWRlIDxsaW51eC9kZXZtLWhlbHBl
cnMuaD4KPiDCoCNpbmNsdWRlIDxsaW51eC9zY2hlZC5oPgo+IMKgI2luY2x1ZGUgPGxpbnV4L3Nw
aW5sb2NrLmg+Cj4gwqAjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4KPiBAQCAtNjIxLDcgKzYyMiw2
IEBAIHN0YXRpYyB2b2lkwqByZWN2X2lwYyhzdHJ1Y3QgaXNodHBfZGV2aWNlICpkZXYsCj4gdWlu
dDMyX3QgZG9vcmJlbGxfdmFsKQo+IMKgwqDCoMKgwqDCoMKgwqBjYXNlIE1OR19SRVNFVF9OT1RJ
Rlk6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoIWlzaHRwX2Rldikgewo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlzaHRwX2Rl
diA9IGRldjsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oElOSVRfV09SSygmZndfcmVzZXRfd29yaywgZndfcmVzZXRfd29ya19mbik7Cj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBzY2hlZHVsZV93b3JrKCZmd19yZXNldF93b3JrKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGJyZWFrOwo+IEBAIC05NDAsNiArOTQwLDcgQEAgc3RydWN0IGlzaHRwX2Rldmlj
ZSAqaXNoX2Rldl9pbml0KHN0cnVjdCBwY2lfZGV2Cj4gKnBkZXYpCj4gwqB7Cj4gwqDCoMKgwqDC
oMKgwqDCoHN0cnVjdCBpc2h0cF9kZXZpY2UgKmRldjsKPiDCoMKgwqDCoMKgwqDCoMKgaW50wqDC
oMKgwqDCoGk7Cj4gK8KgwqDCoMKgwqDCoMKgaW50wqDCoMKgwqDCoHJldDsKPiDCoAo+IMKgwqDC
oMKgwqDCoMKgwqBkZXYgPSBkZXZtX2t6YWxsb2MoJnBkZXYtPmRldiwKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNpemVvZihzdHJ1Y3QgaXNo
dHBfZGV2aWNlKSArCj4gc2l6ZW9mKHN0cnVjdCBpc2hfaHcpLAo+IEBAIC05NzUsNiArOTc2LDEy
IEBAIHN0cnVjdCBpc2h0cF9kZXZpY2UgKmlzaF9kZXZfaW5pdChzdHJ1Y3QgcGNpX2Rldgo+ICpw
ZGV2KQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbGlzdF9hZGRfdGFpbCgmdHhf
YnVmLT5saW5rLCAmZGV2LT53cl9mcmVlX2xpc3QpOwo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqAK
PiArwqDCoMKgwqDCoMKgwqByZXQgPSBkZXZtX3dvcmtfYXV0b2NhbmNlbCgmcGRldi0+ZGV2LCAm
ZndfcmVzZXRfd29yaywKPiBmd19yZXNldF93b3JrX2ZuKTsKPiArwqDCoMKgwqDCoMKgwqBpZiAo
cmV0KSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl9lcnIoZGV2LT5kZXZj
LCAiRmFpbGVkIHRvIGluaXRpYWxpc2UgRlcgcmVzZXQKPiB3b3JrXG4iKTsKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIE5VTEw7Cj4gK8KgwqDCoMKgwqDCoMKgfQo+ICsK
PiDCoMKgwqDCoMKgwqDCoMKgZGV2LT5vcHMgPSAmaXNoX2h3X29wczsKPiDCoMKgwqDCoMKgwqDC
oMKgZGV2LT5kZXZjID0gJnBkZXYtPmRldjsKPiDCoMKgwqDCoMKgwqDCoMKgZGV2LT5tdHUgPSBJ
UENfUEFZTE9BRF9TSVpFIC0gc2l6ZW9mKHN0cnVjdCBpc2h0cF9tc2dfaGRyKTsKCg==

