Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA966E5772
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 04:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjDRCVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 22:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjDRCVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 22:21:33 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B828A7;
        Mon, 17 Apr 2023 19:21:31 -0700 (PDT)
X-UUID: fd0f252e83574171aca8818452e12339-20230418
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:d3425583-a400-4281-87c0-1e7fccebb94d,IP:5,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:-15
X-CID-INFO: VERSION:1.1.22,REQID:d3425583-a400-4281-87c0-1e7fccebb94d,IP:5,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-15
X-CID-META: VersionHash:120426c,CLOUDID:5b74a9a1-8fcb-430b-954a-ba3f00fa94a5,B
        ulkID:230418050923GEA6D6HB,BulkQuantity:3,Recheck:0,SF:24|17|19|44|102,TC:
        nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI
        :0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: fd0f252e83574171aca8818452e12339-20230418
X-User: zenghao@kylinos.cn
Received: from [172.20.12.253] [(116.128.244.169)] by mailgw
        (envelope-from <zenghao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1259229817; Tue, 18 Apr 2023 10:21:26 +0800
Message-ID: <09de34cfd7aec323e3841446c1bf41749909cf58.camel@kylinos.cn>
Subject: Re: [PATCH v3] cpupower:Fix resource leaks in sysfs_get_enabled()
From:   Hao Zeng <zenghao@kylinos.cn>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     trenn@suse.com, shuah@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 18 Apr 2023 10:21:09 +0800
In-Reply-To: <4eaae372-c312-6a77-f57f-dffc5f9aff02@linuxfoundation.org>
References: <20230417075617.10487-1-zenghao@kylinos.cn>
         <4eaae372-c312-6a77-f57f-dffc5f9aff02@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBTaHVhaDoKClRoYW5rIHlvdSBhZ2FpbiBmb3IgeW91ciBwYXRpZW5jZSBhbmQgZ3VpZGFu
Y2UuIFRoaXMgaGFzIGJlbmVmaXRlZCBtZSBhCmxvdC4gSSB3aWxsIGFwcGx5IHdoYXQgSSBoYXZl
IGxlYXJuZWQgdGhpcyB0aW1lIHRvIG15IHdvcmsgYW5kIGtlcm5lbApjb250cmlidXRpb24KCkJl
c3QgcmVnYXJkcwotLSBIYW8KCk9uIE1vbiwgMjAyMy0wNC0xNyBhdCAxNTowOSAtMDYwMCwgU2h1
YWggS2hhbiB3cm90ZToKPiBPbiA0LzE3LzIzIDAxOjU2LCBIYW8gWmVuZyB3cm90ZToKPiA+IFRo
ZSBzeXNmc19nZXRfZW5hYmxlZCgpIG9wZW5lZCBmaWxlIHByb2Nlc3NvciBub3QgY2xvc2VkLAo+
ID4gbWF5IGNhdXNlIGEgZmlsZSBoYW5kbGUgbGVhay4KPiA+IFB1dHRpbmcgZXJyb3IgaGFuZGxp
bmcgYW5kIHJlc291cmNlIGNsZWFudXAgY29kZSB0b2dldGhlcgo+ID4gbWFrZXMgdGhlIGNvZGUg
ZWFzeSB0byBtYWludGFpbiBhbmQgcmVhZC4KPiA+IFJlbW92ZWQgdGhlIHVubmVjZXNzYXJ5IGVs
c2UgaWYgYnJhbmNoIGZyb20gdGhlIG9yaWdpbmFsCj4gPiBmdW5jdGlvbiwgYXMgaXQgc2hvdWxk
IHJldHVybiBhbiBlcnJvciBpbiBjYXNlcyBvdGhlciB0aGFuICcwJy4KPiA+IAo+ID4gU2lnbmVk
LW9mZi1ieTogSGFvIFplbmcgPHplbmdoYW9Aa3lsaW5vcy5jbj4KPiA+IFN1Z2dlc3RlZC1ieTog
U2h1YWggS2hhbiA8c2toYW5AbGludXhmb3VuZGF0aW9uLm9yZz4KPiA+IC0tLQo+ID4gwqAgdG9v
bHMvcG93ZXIvY3B1cG93ZXIvbGliL3Bvd2VyY2FwLmMgfCAyMiArKysrKysrKysrKysrKy0tLS0t
LS0tCj4gPiDCoCAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMo
LSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2xpYi9wb3dlcmNh
cC5jCj4gPiBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2xpYi9wb3dlcmNhcC5jCj4gPiBpbmRleCAw
Y2UyOWVlNGMyZTQuLmYwMzM0YTVmMWFjZiAxMDA2NDQKPiA+IC0tLSBhL3Rvb2xzL3Bvd2VyL2Nw
dXBvd2VyL2xpYi9wb3dlcmNhcC5jCj4gPiArKysgYi90b29scy9wb3dlci9jcHVwb3dlci9saWIv
cG93ZXJjYXAuYwo+ID4gQEAgLTQwLDI1ICs0MCwzMSBAQCBzdGF0aWMgaW50IHN5c2ZzX2dldF9l
bmFibGVkKGNoYXIgKnBhdGgsIGludAo+ID4gKm1vZGUpCj4gPiDCoCB7Cj4gPiDCoMKgwqDCoMKg
wqDCoMKgaW50IGZkOwo+ID4gwqDCoMKgwqDCoMKgwqDCoGNoYXIgeWVzX25vOwo+ID4gK8KgwqDC
oMKgwqDCoMKgaW50IHJldCA9IDA7Cj4gPiDCoCAKPiA+IMKgwqDCoMKgwqDCoMKgwqAqbW9kZSA9
IDA7Cj4gPiDCoCAKPiA+IMKgwqDCoMKgwqDCoMKgwqBmZCA9IG9wZW4ocGF0aCwgT19SRE9OTFkp
Owo+ID4gLcKgwqDCoMKgwqDCoMKgaWYgKGZkID09IC0xKQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHJldHVybiAtMTsKPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChmZCA9PSAtMSkg
ewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IC0xOwo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0Owo+ID4gK8KgwqDCoMKgwqDCoMKgfQo+
ID4gwqAgCj4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgKHJlYWQoZmQsICZ5ZXNfbm8sIDEpICE9IDEp
IHsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjbG9zZShmZCk7Cj4gPiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC0xOwo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHJldCA9IC0xOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGdvdG8gb3V0X2Nsb3NlOwo+ID4gwqDCoMKgwqDCoMKgwqDCoH0KPiA+IMKgIAo+ID4gwqDC
oMKgwqDCoMKgwqDCoGlmICh5ZXNfbm8gPT0gJzEnKSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCptb2RlID0gMTsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqByZXR1cm4gMDsKPiAKPiBZb3UgY2FuIGp1c3QgYWRkIGdvdG8gb3V0X2Nsb3NlIGhlcmUKPiAK
PiA+IC3CoMKgwqDCoMKgwqDCoH0gZWxzZSBpZiAoeWVzX25vID09ICcwJykgewo+ID4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAwOwo+IAo+IEtlZXAgPT0gJzAnIGNoZWNr
IGFuZCBhZGQgZ290byBvdXRfY2xvc2UgaGVyZQo+ID4gK8KgwqDCoMKgwqDCoMKgfSBlbHNlIGlm
ICh5ZXNfbm8gIT0gJzAnKSB7Cj4gCj4gVGhpcyBjYW4gYmUganVzdCBlbHNlIHdpdGggdGhlIGFi
b3ZlIGNoYW5nZS4KPiAKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXQgPSAt
MTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dF9jbG9zZTsKPiA+
IMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiAtwqDCoMKgwqDCoMKgwqByZXR1cm4gLTE7Cj4gPiArb3V0
X2Nsb3NlOgo+ID4gK8KgwqDCoMKgwqDCoMKgY2xvc2UoZmQpOwo+ID4gK291dDoKPiA+ICvCoMKg
wqDCoMKgwqDCoHJldHVybiByZXQ7Cj4gPiDCoCB9Cj4gPiDCoCAKPiA+IMKgIGludCBwb3dlcmNh
cF9nZXRfZW5hYmxlZChpbnQgKm1vZGUpCj4gCj4gdGhhbmtzLAo+IC0tIFNodWFoCgo=

