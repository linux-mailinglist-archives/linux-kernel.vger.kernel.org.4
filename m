Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13832677C39
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjAWNPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjAWNPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:15:47 -0500
X-Greylist: delayed 40246 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Jan 2023 05:15:42 PST
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id D571424101;
        Mon, 23 Jan 2023 05:15:42 -0800 (PST)
Received: by ajax-webmail-mail-app3 (Coremail) ; Mon, 23 Jan 2023 21:15:37
 +0800 (GMT+08:00)
X-Originating-IP: [112.254.167.99]
Date:   Mon, 23 Jan 2023 21:15:37 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   duoming@zju.edu.cn
To:     "Sean Young" <sean@mess.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        maximlevitsky@gmail.com, mchehab@kernel.org
Subject: Re: [PATCH] media: rc: Fix use-after-free bugs caused by
 ene_tx_irqsim()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2023 www.mailtech.cn zju.edu.cn
In-Reply-To: <Y85O6XqiiyRZqHnE@gofer.mess.org>
References: <20230123011223.23804-1-duoming@zju.edu.cn>
 <Y85O6XqiiyRZqHnE@gofer.mess.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <12da9ba8.218f7.185dec51aa9.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cC_KCgC3vQx5iM5j9hE2DA--.55287W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAg4EAVZdtdU8igADsX
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sCgpPbiBNb24sIDIzIEphbiAyMDIzIDA5OjEwOjAxLCBTZWFuIFlvdW5nIHdyb3RlOgoK
PiBPbiBNb24sIEphbiAyMywgMjAyMyBhdCAwOToxMjoyM0FNICswODAwLCBEdW9taW5nIFpob3Ug
d3JvdGU6Cj4gPiBXaGVuIHRoZSBlbmUgZGV2aWNlIGlzIGRldGFjaGluZywgZnVuY3Rpb24gZW5l
X3JlbW92ZSgpIHdpbGwKPiA+IGJlIGNhbGxlZC4gQnV0IHRoZXJlIGlzIG5vIGZ1bmN0aW9uIHRv
IGNhbmNlbCB0eF9zaW1fdGltZXIKPiA+IGluIGVuZV9yZW1vdmUoKSwgdGhlIHRpbWVyIGhhbmRs
ZXIgZW5lX3R4X2lycXNpbSgpIGNvdWxkIHJhY2UKPiA+IHdpdGggZW5lX3JlbW92ZSgpLiBBcyBh
IHJlc3VsdCwgdGhlIFVBRiBidWdzIGNvdWxkIGhhcHBlbiwKPiA+IHRoZSBwcm9jZXNzIGlzIHNo
b3duIGJlbG93Lgo+ID4gCj4gPiAgICAgKGNsZWFudXAgcm91dGluZSkgICAgICAgICAgfCAgICAg
ICAgKHRpbWVyIHJvdXRpbmUpCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCBt
b2RfdGltZXIoJmRldi0+dHhfc2ltX3RpbWVyLCAuLikKPiA+IGVuZV9yZW1vdmUoKSAgICAgICAg
ICAgICAgICAgICB8ICh3YWl0IGEgdGltZSkKPiA+ICAga2ZyZWUoZGV2KSAvL0ZSRUUgICAgICAg
ICAgICB8Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCBlbmVfdHhfaXJxc2lt
KCkKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgZGV2LT5od19sb2NrIC8v
VVNFCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIGVuZV90eF9zYW1wbGUo
ZGV2KSAvL1VTRQo+ID4gCj4gPiBGaXggYnkgYWRkaW5nIGRlbF90aW1lcl9zeW5jKCZkZXYtPnR4
X3NpbV90aW1lcikgaW4gZW5lX3JlbW92ZSgpLAo+ID4gVGhlIHR4X3NpbV90aW1lciBjb3VsZCBz
dG9wIGJlZm9yZSBlbmUgZGV2aWNlIGlzIGRlYWxsb2NhdGVkLgo+ID4gCj4gPiBUaGlzIHByb2Js
ZW0gaXMgZm91bmQgYnkgc3RhdGljIGFuYWx5c2lzLgo+ID4gCj4gPiBGaXhlczogOWVhNTNiNzRk
ZjljICgiVjRML0RWQjogU1RBR0lORzogcmVtb3ZlIGxpcmNfZW5lMDEwMCBkcml2ZXIiKQo+ID4g
U2lnbmVkLW9mZi1ieTogRHVvbWluZyBaaG91IDxkdW9taW5nQHpqdS5lZHUuY24+Cj4gPiAtLS0K
PiA+ICBkcml2ZXJzL21lZGlhL3JjL2VuZV9pci5jIHwgMSArCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3JjL2Vu
ZV9pci5jIGIvZHJpdmVycy9tZWRpYS9yYy9lbmVfaXIuYwo+ID4gaW5kZXggZTA5MjcwOTE2ZmIu
LjcxNmI3MmEwNDhmIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9tZWRpYS9yYy9lbmVfaXIuYwo+
ID4gKysrIGIvZHJpdmVycy9tZWRpYS9yYy9lbmVfaXIuYwo+ID4gQEAgLTExMTQsNiArMTExNCw3
IEBAIHN0YXRpYyB2b2lkIGVuZV9yZW1vdmUoc3RydWN0IHBucF9kZXYgKnBucF9kZXYpCj4gPiAg
CWZyZWVfaXJxKGRldi0+aXJxLCBkZXYpOwo+ID4gIAlyZWxlYXNlX3JlZ2lvbihkZXYtPmh3X2lv
LCBFTkVfSU9fU0laRSk7Cj4gPiAgCXJjX3VucmVnaXN0ZXJfZGV2aWNlKGRldi0+cmRldik7Cj4g
PiArCWRlbF90aW1lcl9zeW5jKCZkZXYtPnR4X3NpbV90aW1lcik7Cj4gCj4gR3JlYXQgY2F0Y2gh
Cj4gCj4gVGhlIHRpbWVyIGNhbiBjYWxsIGVuZV90eF9zYW1wbGUoKSB3aGljaCBjYW4gd3JpdGUg
dG8gdGhlIGlvIHBvcnRzLCBzbyB0aGUKPiBvcmRlcmluZyBzdGlsbCBpcyBub3QgcXVpdGUgcmln
aHQuIEkgdGhpbmsgdGhlIHJjX3VucmVnaXN0ZXJfZGV2aWNlKCkgYW5kCj4gZGVsX3RpbWVyX3N5
bmMoKSBzaG91bGQgYmUgY2FsbCBmaXJzdCBpbiBlbmVfcmVtb3ZlKCkuCgpUaGFuayB5b3UgZm9y
IHlvdXIgdGltZSBhbmQgc3VnZ2VzdGlvbnMhIEkgd2lsbCBwdXQgcmNfdW5yZWdpc3Rlcl9kZXZp
Y2UoKSBhbmQKZGVsX3RpbWVyX3N5bmMoKSBiZWZvcmUgcmVsZWFzZV9yZWdpb24oKSBpbiBvcmRl
ciB0aGF0IHRoZSB0eF9zaW1fdGltZXIgY291bGQKZmluaXNoIGJlZm9yZSBpbyBwb3J0cyBhcmUg
cmVsZWFzZWQuCgpCZXN0IHJlZ2FyZHMsCkR1b21pbmcgWmhvdQ==
