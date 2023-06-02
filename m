Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAFF71F8B4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 05:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbjFBDGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 23:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbjFBDGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 23:06:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30291A1;
        Thu,  1 Jun 2023 20:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685675207; x=1717211207;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=2cE+KTjr+h27o0R7ESMpLr0xWTkD5U4bzxRV15o3RtU=;
  b=WioZqYSOmHxOR69En3SZRZANm/3cFaD8QE2DbYIo8W+NLACn+rNFKozH
   rgB3JwZT+E5KzE6g3jg65dweYHfBvAWPoMYNAuKgPl+NGN8rTJG3DGbY1
   ZsAeixjAqR3pRVe2APIj6eGzLRk8O4qxl69rSuf3+1t4/Ij7vjHfUsgSZ
   uZM1VAhMLnfUjEVT6Ic9h3RhypRtV/tR3XAdl9jwMSmS+vom+8JjHl0JR
   +OpAwWIR5VbEszbT9lrRRx1IgQCmvlhnseyQDDHydFpgMKWqhzogBHOQ2
   nmuhDOF91yNQXX223htC21qVBq8iEKYH+nqo8C73xnXFu8L9WEsYDpNDQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="421570163"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="421570163"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 20:06:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="831801964"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="831801964"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 01 Jun 2023 20:06:47 -0700
Received: from pnukala-mobl1.amr.corp.intel.com (pnukala-mobl1.amr.corp.intel.com [10.251.22.94])
        by linux.intel.com (Postfix) with ESMTP id EE9E8580BF6;
        Thu,  1 Jun 2023 20:06:46 -0700 (PDT)
Message-ID: <05162d36a009a1669870a2c82bd0b2b65458b244.camel@linux.intel.com>
Subject: Re: [PATCH] ACPI: x86: Adjust Microsoft LPS0 _DSM handling sequence
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     "Limonciello, Mario" <mario.limonciello@amd.com>, rafael@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Date:   Thu, 01 Jun 2023 20:06:46 -0700
In-Reply-To: <b0e0abc0-26ba-d104-ff73-b89745510be8@amd.com>
References: <20230601233953.1332-1-mario.limonciello@amd.com>
         <d1e0d5fc837753c292f78a5357fd9ba4531f06d2.camel@linux.intel.com>
         <b0e0abc0-26ba-d104-ff73-b89745510be8@amd.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA2LTAxIGF0IDIwOjQ2IC0wNTAwLCBMaW1vbmNpZWxsbywgTWFyaW8gd3Jv
dGU6Cj4gCj4gT24gNi8xLzIwMjMgODozMSBQTSwgRGF2aWQgRS4gQm94IHdyb3RlOgo+ID4gT24g
VGh1LCAyMDIzLTA2LTAxIGF0IDE4OjM5IC0wNTAwLCBNYXJpbyBMaW1vbmNpZWxsbyB3cm90ZToK
PiA+ID4gSW4gV2luZG93cyB0aGUgTWljcm9zb2Z0IF9EU00gZG9lc24ndCBjYWxsIGZ1bmN0aW9u
cyAzLT41LT43IGZvciBzdXNwZW5kCj4gPiA+IGFuZCA4LT42LT40IGZvciByZXN1bWUgbGlrZSBM
aW51eCBjdXJyZW50bHkgZG9lcy4KPiA+ID4gCj4gPiA+IFJhdGhlciBpdCBjYWxscyAzLT43LT41
IGZvciBzdXNwZW5kIGFuZCA2LT44LT40IGZvciByZXN1bWUuCj4gPiA+IEFsaWduIHRoaXMgY2Fs
bGluZyBvcmRlciBmb3IgTGludXggYXMgd2VsbC4KPiA+ID4gCj4gPiA+IExpbms6Cj4gPiA+IGh0
dHBzOi8vbGVhcm4ubWljcm9zb2Z0LmNvbS9lbi11cy93aW5kb3dzLWhhcmR3YXJlL2Rlc2lnbi9k
ZXZpY2UtZXhwZXJpZW5jZXMvbW9kZXJuLXN0YW5kYnktc3RhdGVzCj4gPiBJIGRpZG4ndCBjYXRj
aCB0aGUgb3JkZXJpbmcgaW4gdGhlIGxpbmsuCj4gCj4gWWVhaCBpdCdzIHRvdWdoIHRvIGludGVy
cHJldCBmcm9tIHRoZSBsaW5rLCBiZWNhdXNlIHRoZSBwaWN0dXJlIGF0IHRoZSAKPiBib3R0b20K
PiBpcyBtaXNzaW5nIGFubm90YXRpb25zLgo+IAo+IEJhc2ljYWxseSBpZiB5b3UgbG9vayBhdCB0
aGUgcGljdHVyZSB0aGUgYmx1ZSBwYXJ0IGlzIHRoZSBzY3JlZW4gb24vb2ZmLgo+IAo+IFRoZSBn
cmVlbiBwYXJ0IGlzICJtb2Rlcm4gc3RhbmRieSIgYW5kIHRoZW4gdGhlIGxpdHRsZSAiaHVtcHMi
IGFyZSBMUFMwIAo+IGVudGVyL2V4aXQuCj4gCj4gPiBXYXMgdGhlcmUgYW55IGlzc3VlIHRoYXQg
cHJvbXB0ZWQgdGhpcwo+ID4gY2hhbmdlPwo+IAo+IAo+IFdlIHdlcmUgZGVidWdnaW5nIGFuIHVu
cmVsYXRlZCBwcm9ibGVtIGFuZCBub3RpY2VkIHRoZSBkaWZmZXJlbmNlIAo+IGNvbXBhcmluZyB0
aGUKPiAKPiBCSU9TIGRlYnVnZ2luZyBsb2cgZnJvbSBXaW5kb3dzIGFuZCBMaW51eC4KPiAKPiBJ
ZiBhbiBPRU0gZGVwZW5kcyBvbiB0aGlzIGNhbGwgb3JkZXIgaW4gdGhhdCBjb2RlIHVzZWQgaW4g
TFBTMCBwaGFzZSAKPiByZXF1aXJlcwo+IGNoYW5nZXMgZnJvbSBNUyBwaGFzZSBJIGNvdWxkIGh5
cG90aGVzaXplIHRoaXMgZml4ZXMgaXQuCj4gCj4gCj4gPiBEYXZpZAo+IAo+IEJUVyAtIGlzIHRo
ZXJlIGludGVyZXN0IGluIHN1cHBvcnRpbmcgdGhlIE1pY3Jvc29mdCBfRFNNIEdVSUQgZm9yIElu
dGVsIAo+IHNpZGUgdG9vPwo+IAo+IEl0J3MgYW4gaW5jb25ncnVpdHkgdG9kYXkgdGhhdCB3ZSBy
dW4gYm90aCBBTUQgR1VJRCBhbmQgTWljcm9zb2Z0IEdVSUQgCj4gZm9yIEFNRCBzeXN0ZW1zCj4g
YnV0IG9ubHkgcnVuIEludGVsIEdVSUQgZm9yIEludGVsIHN5c3RlbXMuCgpUaGVyZSBoYXNuJ3Qg
YmVlbiBhIG5lZWQgeWV0LiBSYWZhZWwgaGF2ZSB5b3UgbG9vayBhdCBpdD8KCkRhdmlkCgo+IAo+
ID4gCj4gPiA+IFNpZ25lZC1vZmYtYnk6IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNp
ZWxsb0BhbWQuY29tPgo+ID4gPiAtLS0KPiA+ID4gwqDCoGRyaXZlcnMvYWNwaS94ODYvczJpZGxl
LmMgfCAxNCArKysrKysrLS0tLS0tLQo+ID4gPiDCoMKgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0
aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKPiA+ID4gCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2FjcGkveDg2L3MyaWRsZS5jIGIvZHJpdmVycy9hY3BpL3g4Ni9zMmlkbGUuYwo+ID4gPiBpbmRl
eCBlNDk5YzYwYzQ1NzkuLjcyMTQxOTdjMTVhMCAxMDA2NDQKPiA+ID4gLS0tIGEvZHJpdmVycy9h
Y3BpL3g4Ni9zMmlkbGUuYwo+ID4gPiArKysgYi9kcml2ZXJzL2FjcGkveDg2L3MyaWRsZS5jCj4g
PiA+IEBAIC00ODUsMTEgKzQ4NSwxMSBAQCBpbnQgYWNwaV9zMmlkbGVfcHJlcGFyZV9sYXRlKHZv
aWQpCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBBQ1BJX0xQUzBfRU5UUlksCj4gPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBscHMwX2RzbV9mdW5jX21hc2ssCj4gPiA+IGxwczBf
ZHNtX2d1aWQpOwo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqBpZiAobHBzMF9kc21fZnVuY19tYXNr
X21pY3Jvc29mdCA+IDApIHsKPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGFj
cGlfc2xlZXBfcnVuX2xwczBfZHNtKEFDUElfTFBTMF9FTlRSWSwKPiA+ID4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbHBzMF9k
c21fZnVuY19tYXNrX21pY3Jvc29mdCwKPiA+ID4gbHBzMF9kc21fZ3VpZF9taWNyb3NvZnQpOwo+
ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyogbW9kZXJuIHN0YW5kYnkg
ZW50cnkgKi8KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGFjcGlfc2xl
ZXBfcnVuX2xwczBfZHNtKEFDUElfTFBTMF9NU19FTlRSWSwKPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbHBzMF9k
c21fZnVuY19tYXNrX21pY3Jvc29mdCwKPiA+ID4gbHBzMF9kc21fZ3VpZF9taWNyb3NvZnQpOwo+
ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYWNwaV9zbGVlcF9ydW5fbHBzMF9k
c20oQUNQSV9MUFMwX0VOVFJZLAo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBscHMwX2RzbV9mdW5jX21hc2tfbWljcm9z
b2Z0LAo+ID4gPiBscHMwX2RzbV9ndWlkX21pY3Jvc29mdCk7Cj4gPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoH0KPiA+ID4gwqAgCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoGxpc3RfZm9yX2VhY2hfZW50
cnkoaGFuZGxlciwgJmxwczBfczJpZGxlX2Rldm9wc19oZWFkLCBsaXN0X25vZGUpCj4gPiA+IHsK
PiA+ID4gQEAgLTUyNCwxMSArNTI0LDYgQEAgdm9pZCBhY3BpX3MyaWRsZV9yZXN0b3JlX2Vhcmx5
KHZvaWQpCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoaGFuZGxl
ci0+cmVzdG9yZSkKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBoYW5kbGVyLT5yZXN0b3JlKCk7Cj4gPiA+IMKgIAo+ID4gPiAtwqDCoMKgwqDC
oMKgwqAvKiBNb2Rlcm4gc3RhbmRieSBleGl0ICovCj4gPiA+IC3CoMKgwqDCoMKgwqDCoGlmIChs
cHMwX2RzbV9mdW5jX21hc2tfbWljcm9zb2Z0ID4gMCkKPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGFjcGlfc2xlZXBfcnVuX2xwczBfZHNtKEFDUElfTFBTMF9NU19FWElULAo+
ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBscHMwX2RzbV9mdW5jX21hc2tfbWljcm9zb2Z0LAo+ID4gPiBscHMwX2RzbV9n
dWlkX21pY3Jvc29mdCk7Cj4gPiA+IC0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgLyogTFBTMCBl
eGl0ICovCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoGlmIChscHMwX2RzbV9mdW5jX21hc2sgPiAw
KQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYWNwaV9zbGVlcF9ydW5f
bHBzMF9kc20oYWNwaV9zMmlkbGVfdmVuZG9yX2FtZCgpID8KPiA+ID4gQEAgLTUzOSw2ICs1MzQs
MTEgQEAgdm9pZCBhY3BpX3MyaWRsZV9yZXN0b3JlX2Vhcmx5KHZvaWQpCj4gPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhY3BpX3NsZWVwX3J1bl9scHMwX2RzbShBQ1BJX0xQ
UzBfRVhJVCwKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbHBzMF9kc21fZnVuY19tYXNrX21pY3Jvc29mdCwKPiA+
ID4gbHBzMF9kc21fZ3VpZF9taWNyb3NvZnQpOwo+ID4gPiDCoCAKPiA+ID4gK8KgwqDCoMKgwqDC
oMKgLyogTW9kZXJuIHN0YW5kYnkgZXhpdCAqLwo+ID4gPiArwqDCoMKgwqDCoMKgwqBpZiAobHBz
MF9kc21fZnVuY19tYXNrX21pY3Jvc29mdCA+IDApCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBhY3BpX3NsZWVwX3J1bl9scHMwX2RzbShBQ1BJX0xQUzBfTVNfRVhJVCwKPiA+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgbHBzMF9kc21fZnVuY19tYXNrX21pY3Jvc29mdCwKPiA+ID4gbHBzMF9kc21fZ3Vp
ZF9taWNyb3NvZnQpOwo+ID4gPiArCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoC8qIFNjcmVlbiBv
biAqLwo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqBpZiAobHBzMF9kc21fZnVuY19tYXNrX21pY3Jv
c29mdCA+IDApCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhY3BpX3Ns
ZWVwX3J1bl9scHMwX2RzbShBQ1BJX0xQUzBfU0NSRUVOX09OLAoK

