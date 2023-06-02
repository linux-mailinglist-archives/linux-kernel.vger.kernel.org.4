Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BC471F7EC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbjFBBbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 21:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjFBBbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:31:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE187198;
        Thu,  1 Jun 2023 18:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685669494; x=1717205494;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=8D8V7igw+9f4qtTzHIy+5OAo3ktpzRZhtQbr9zeJEFQ=;
  b=QGm4cZbrEcIwaWOviLUao1fa4aEoC0gu4O2x1uLOa9/F5JTKvzt3JClo
   uMGiLQjly3FvZ9q26+RH/X5G7mNu06K9jQhnHCEXCbEh6l9wF7RjTHvLC
   +zlLGvaJFjKS8sOleDt979dkTBQtrHcHAoTMqEWb/UWX70/EgUX1aGX6n
   VzF194nr0qw8LClAdztN4mwJ7dLwVCXbr5+6aG7A26YkOJzQF0yO1U4fF
   A2+lvtKH1V7bpk+tp4MQIHZyQSZitGFgl2tVhul3dvd4mk5+M4d3s2vqw
   AIl8g9u936xWnFkwG+2/9oGfKhIPOMTRvYyA3lTPGRPxkdUZAFwzZ9xfv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="336101112"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="336101112"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 18:31:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="685087723"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="685087723"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 01 Jun 2023 18:31:33 -0700
Received: from dkhamitk-mobl1.amr.corp.intel.com (dkhamitk-mobl1.amr.corp.intel.com [10.251.3.100])
        by linux.intel.com (Postfix) with ESMTP id 6054B580CD0;
        Thu,  1 Jun 2023 18:31:33 -0700 (PDT)
Message-ID: <d1e0d5fc837753c292f78a5357fd9ba4531f06d2.camel@linux.intel.com>
Subject: Re: [PATCH] ACPI: x86: Adjust Microsoft LPS0 _DSM handling sequence
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Mario Limonciello <mario.limonciello@amd.com>, rafael@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Date:   Thu, 01 Jun 2023 18:31:33 -0700
In-Reply-To: <20230601233953.1332-1-mario.limonciello@amd.com>
References: <20230601233953.1332-1-mario.limonciello@amd.com>
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

T24gVGh1LCAyMDIzLTA2LTAxIGF0IDE4OjM5IC0wNTAwLCBNYXJpbyBMaW1vbmNpZWxsbyB3cm90
ZToKPiBJbiBXaW5kb3dzIHRoZSBNaWNyb3NvZnQgX0RTTSBkb2Vzbid0IGNhbGwgZnVuY3Rpb25z
IDMtPjUtPjcgZm9yIHN1c3BlbmQKPiBhbmQgOC0+Ni0+NCBmb3IgcmVzdW1lIGxpa2UgTGludXgg
Y3VycmVudGx5IGRvZXMuCj4gCj4gUmF0aGVyIGl0IGNhbGxzIDMtPjctPjUgZm9yIHN1c3BlbmQg
YW5kIDYtPjgtPjQgZm9yIHJlc3VtZS4KPiBBbGlnbiB0aGlzIGNhbGxpbmcgb3JkZXIgZm9yIExp
bnV4IGFzIHdlbGwuCj4gCj4gTGluazoKPiBodHRwczovL2xlYXJuLm1pY3Jvc29mdC5jb20vZW4t
dXMvd2luZG93cy1oYXJkd2FyZS9kZXNpZ24vZGV2aWNlLWV4cGVyaWVuY2VzL21vZGVybi1zdGFu
ZGJ5LXN0YXRlcwoKSSBkaWRuJ3QgY2F0Y2ggdGhlIG9yZGVyaW5nIGluIHRoZSBsaW5rLiBXYXMg
dGhlcmUgYW55IGlzc3VlIHRoYXQgcHJvbXB0ZWQgdGhpcwpjaGFuZ2U/CgpEYXZpZAoKPiBTaWdu
ZWQtb2ZmLWJ5OiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4K
PiAtLS0KPiDCoGRyaXZlcnMvYWNwaS94ODYvczJpZGxlLmMgfCAxNCArKysrKysrLS0tLS0tLQo+
IMKgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKPiAKPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL3g4Ni9zMmlkbGUuYyBiL2RyaXZlcnMvYWNwaS94ODYv
czJpZGxlLmMKPiBpbmRleCBlNDk5YzYwYzQ1NzkuLjcyMTQxOTdjMTVhMCAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL2FjcGkveDg2L3MyaWRsZS5jCj4gKysrIGIvZHJpdmVycy9hY3BpL3g4Ni9zMmlk
bGUuYwo+IEBAIC00ODUsMTEgKzQ4NSwxMSBAQCBpbnQgYWNwaV9zMmlkbGVfcHJlcGFyZV9sYXRl
KHZvaWQpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBBQ1BJX0xQUzBfRU5UUlksCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBscHMwX2RzbV9mdW5jX21hc2ssIGxwczBfZHNtX2d1aWQpOwo+IMKg
wqDCoMKgwqDCoMKgwqBpZiAobHBzMF9kc21fZnVuY19tYXNrX21pY3Jvc29mdCA+IDApIHsKPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYWNwaV9zbGVlcF9ydW5fbHBzMF9kc20oQUNQ
SV9MUFMwX0VOVFJZLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGxwczBfZHNtX2Z1bmNfbWFza19taWNyb3NvZnQsCj4gbHBz
MF9kc21fZ3VpZF9taWNyb3NvZnQpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
LyogbW9kZXJuIHN0YW5kYnkgZW50cnkgKi8KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGFjcGlfc2xlZXBfcnVuX2xwczBfZHNtKEFDUElfTFBTMF9NU19FTlRSWSwKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
bHBzMF9kc21fZnVuY19tYXNrX21pY3Jvc29mdCwKPiBscHMwX2RzbV9ndWlkX21pY3Jvc29mdCk7
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGFjcGlfc2xlZXBfcnVuX2xwczBfZHNt
KEFDUElfTFBTMF9FTlRSWSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBscHMwX2RzbV9mdW5jX21hc2tfbWljcm9zb2Z0LAo+
IGxwczBfZHNtX2d1aWRfbWljcm9zb2Z0KTsKPiDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgCj4gwqDC
oMKgwqDCoMKgwqDCoGxpc3RfZm9yX2VhY2hfZW50cnkoaGFuZGxlciwgJmxwczBfczJpZGxlX2Rl
dm9wc19oZWFkLCBsaXN0X25vZGUpIHsKPiBAQCAtNTI0LDExICs1MjQsNiBAQCB2b2lkIGFjcGlf
czJpZGxlX3Jlc3RvcmVfZWFybHkodm9pZCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGlmIChoYW5kbGVyLT5yZXN0b3JlKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGhhbmRsZXItPnJlc3RvcmUoKTsKPiDCoAo+IC3CoMKgwqDCoMKg
wqDCoC8qIE1vZGVybiBzdGFuZGJ5IGV4aXQgKi8KPiAtwqDCoMKgwqDCoMKgwqBpZiAobHBzMF9k
c21fZnVuY19tYXNrX21pY3Jvc29mdCA+IDApCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGFjcGlfc2xlZXBfcnVuX2xwczBfZHNtKEFDUElfTFBTMF9NU19FWElULAo+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGxw
czBfZHNtX2Z1bmNfbWFza19taWNyb3NvZnQsCj4gbHBzMF9kc21fZ3VpZF9taWNyb3NvZnQpOwo+
IC0KPiDCoMKgwqDCoMKgwqDCoMKgLyogTFBTMCBleGl0ICovCj4gwqDCoMKgwqDCoMKgwqDCoGlm
IChscHMwX2RzbV9mdW5jX21hc2sgPiAwKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgYWNwaV9zbGVlcF9ydW5fbHBzMF9kc20oYWNwaV9zMmlkbGVfdmVuZG9yX2FtZCgpID8KPiBA
QCAtNTM5LDYgKzUzNCwxMSBAQCB2b2lkIGFjcGlfczJpZGxlX3Jlc3RvcmVfZWFybHkodm9pZCkK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGFjcGlfc2xlZXBfcnVuX2xwczBfZHNt
KEFDUElfTFBTMF9FWElULAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBscHMwX2RzbV9mdW5jX21hc2tfbWljcm9zb2Z0LAo+
IGxwczBfZHNtX2d1aWRfbWljcm9zb2Z0KTsKPiDCoAo+ICvCoMKgwqDCoMKgwqDCoC8qIE1vZGVy
biBzdGFuZGJ5IGV4aXQgKi8KPiArwqDCoMKgwqDCoMKgwqBpZiAobHBzMF9kc21fZnVuY19tYXNr
X21pY3Jvc29mdCA+IDApCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGFjcGlfc2xl
ZXBfcnVuX2xwczBfZHNtKEFDUElfTFBTMF9NU19FWElULAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGxwczBfZHNtX2Z1bmNf
bWFza19taWNyb3NvZnQsCj4gbHBzMF9kc21fZ3VpZF9taWNyb3NvZnQpOwo+ICsKPiDCoMKgwqDC
oMKgwqDCoMKgLyogU2NyZWVuIG9uICovCj4gwqDCoMKgwqDCoMKgwqDCoGlmIChscHMwX2RzbV9m
dW5jX21hc2tfbWljcm9zb2Z0ID4gMCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGFjcGlfc2xlZXBfcnVuX2xwczBfZHNtKEFDUElfTFBTMF9TQ1JFRU5fT04sCgo=

