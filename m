Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088F36E426E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjDQIVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjDQIVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:21:33 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4572049D7;
        Mon, 17 Apr 2023 01:21:29 -0700 (PDT)
X-UUID: b3eec3e8513144168bf202958215a741-20230417
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:36a9524f-64dc-4f97-9eec-23d6688bce3b,IP:5,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:-15
X-CID-INFO: VERSION:1.1.22,REQID:36a9524f-64dc-4f97-9eec-23d6688bce3b,IP:5,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-15
X-CID-META: VersionHash:120426c,CLOUDID:36fa34eb-db6f-41fe-8b83-13fe7ed1ef52,B
        ulkID:230417162124UZBCA1A6,BulkQuantity:0,Recheck:0,SF:24|17|19|44|102,TC:
        nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: b3eec3e8513144168bf202958215a741-20230417
X-User: zenghao@kylinos.cn
Received: from [172.20.12.253] [(116.128.244.169)] by mailgw
        (envelope-from <zenghao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1607147331; Mon, 17 Apr 2023 16:21:21 +0800
Message-ID: <f4bdacff84b251728ba9fa2528ec011b6c7c6d15.camel@kylinos.cn>
Subject: Re: [PATCH v2] cpupower:Fix resource leaks in sysfs_get_enabled()
From:   Hao Zeng <zenghao@kylinos.cn>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     trenn@suse.com, shuah@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 17 Apr 2023 16:21:14 +0800
In-Reply-To: <4c04ae6d-f8db-0a2d-0bd5-97c4ec828a59@linuxfoundation.org>
References: <20230414030830.3829332-1-zenghao@kylinos.cn>
         <4c04ae6d-f8db-0a2d-0bd5-97c4ec828a59@linuxfoundation.org>
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

SGkgU2h1YWggLCBUaGFua3MgdmVyeSBtdWNoIGZvciB5b3VyIHJldmlldyEKSSB0cmllZCB0byB1
bmRlcnN0YW5kIHdoYXQgeW91IHNhaWQgYXMgYmVzdCBJIGNvdWxkIGFuZCBwcm92aWRlZCBWMy4K
SSBsb29rIGZvcndhcmQgdG8geW91ciByZXZpZXcgYWdhaW4sIGl0IHdpbGwgaGVscCBtZSBhIGxv
dCEKCkJlc3QgcmVnYXJkcwotLSBIYW8KCk9uIEZyaSwgMjAyMy0wNC0xNCBhdCAxMDo0MSAtMDYw
MCwgU2h1YWggS2hhbiB3cm90ZToKPiBPbiA0LzEzLzIzIDIxOjA4LCBIYW8gWmVuZyB3cm90ZToK
PiA+IFdoZW4gdGhlIHJlYWQgcmV0dXJuIHZhbHVlIGlzIGVxdWFsIHRvIDEsIGEgZmlsZSBoYW5k
bGUgbGVhayB3aWxsCj4gPiBvY2N1cgo+ID4gCj4gCj4gV291bGQgbGlrZSBhIGJpdCBtb3JlIGlu
Zm9ybWF0aW9uIG9uIGhvdyB0aGUgZXJyb3IgcGF0aHMgYXJlCj4gcmVkb25lLCBzaW5jZSBtZW1v
cnkgbGVhayBpc24ndCB0aGUgb25seSBvbmUgdGhhdCBpcyBmaXhlZC4KPiAKPiA+IFNpZ25lZC1v
ZmYtYnk6IEhhbyBaZW5nIDx6ZW5naGFvQGt5bGlub3MuY24+Cj4gPiBTdWdnZXN0ZWQtYnk6IFNo
dWFoIEtoYW4gPHNraGFuQGxpbnV4Zm91bmRhdGlvbi5vcmc+Cj4gPiAtLS0KPiA+IMKgIHRvb2xz
L3Bvd2VyL2NwdXBvd2VyL2xpYi9wb3dlcmNhcC5jIHwgMTkgKysrKysrKysrKy0tLS0tLS0tLQo+
ID4gwqAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCj4g
PiAKPiA+IGRpZmYgLS1naXQgYS90b29scy9wb3dlci9jcHVwb3dlci9saWIvcG93ZXJjYXAuYwo+
ID4gYi90b29scy9wb3dlci9jcHVwb3dlci9saWIvcG93ZXJjYXAuYwo+ID4gaW5kZXggMGNlMjll
ZTRjMmU0Li4wMmVjNWIwYmZmNmIgMTAwNjQ0Cj4gPiAtLS0gYS90b29scy9wb3dlci9jcHVwb3dl
ci9saWIvcG93ZXJjYXAuYwo+ID4gKysrIGIvdG9vbHMvcG93ZXIvY3B1cG93ZXIvbGliL3Bvd2Vy
Y2FwLmMKPiA+IEBAIC00MCw3ICs0MCw3IEBAIHN0YXRpYyBpbnQgc3lzZnNfZ2V0X2VuYWJsZWQo
Y2hhciAqcGF0aCwgaW50Cj4gPiAqbW9kZSkKPiA+IMKgIHsKPiA+IMKgwqDCoMKgwqDCoMKgwqBp
bnQgZmQ7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgY2hhciB5ZXNfbm87Cj4gPiAtCj4gPiArwqDCoMKg
wqDCoMKgwqBpbnQgcmV0ID0gMDsKPiA+IMKgwqDCoMKgwqDCoMKgwqAqbW9kZSA9IDA7Cj4gPiDC
oCAKPiA+IMKgwqDCoMKgwqDCoMKgwqBmZCA9IG9wZW4ocGF0aCwgT19SRE9OTFkpOwo+ID4gQEAg
LTQ4LDE3ICs0OCwxOCBAQCBzdGF0aWMgaW50IHN5c2ZzX2dldF9lbmFibGVkKGNoYXIgKnBhdGgs
IGludAo+ID4gKm1vZGUpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVy
biAtMTsKPiA+IMKgIAo+ID4gwqDCoMKgwqDCoMKgwqDCoGlmIChyZWFkKGZkLCAmeWVzX25vLCAx
KSAhPSAxKSB7Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY2xvc2UoZmQpOwo+
ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtMTsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXQgPSAtMTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBnb3RvIGVycjsKPiA+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiDCoCAKPiA+IC3C
oMKgwqDCoMKgwqDCoGlmICh5ZXNfbm8gPT0gJzEnKSB7Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgKm1vZGUgPSAxOwo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHJldHVybiAwOwo+ID4gLcKgwqDCoMKgwqDCoMKgfSBlbHNlIGlmICh5ZXNfbm8gPT0gJzAnKSB7
Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4gPiArwqDCoMKg
wqDCoMKgwqBpZiAoeWVzX25vICE9ICcxJyB8fCB5ZXNfbm8gIT0gJzAnKSB7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0ID0gLTE7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgZ290byBlcnI7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgfQo+ID4gLcKgwqDCoMKg
wqDCoMKgcmV0dXJuIC0xOwo+ID4gK8KgwqDCoMKgwqDCoMKgKm1vZGUgPSB5ZXNfbm8gLSAnMCc7
Cj4gCj4gSSBhbSBub3Qgc2VlaW5nIG11Y2ggdmFsdWUgaW4gY2hhbmdpbmcgdGhlIGFib3ZlIHBh
dGhzLgo+IExlYXZlIHRoZW0gdW5jaGFuZ2VkLgo+IAo+ID4gK2VycjoKPiA+ICvCoMKgwqDCoMKg
wqDCoGNsb3NlKGZkKTsKPiA+ICvCoMKgwqDCoMKgwqDCoHJldHVybiByZXQ7Cj4gPiDCoCB9Cj4g
PiDCoCAKPiA+IMKgIGludCBwb3dlcmNhcF9nZXRfZW5hYmxlZChpbnQgKm1vZGUpCj4gCj4gdGhh
bmtzLAo+IC0tIFNodWFoCgo=

