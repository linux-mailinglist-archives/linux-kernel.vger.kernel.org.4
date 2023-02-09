Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8910568FDD9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjBIDTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 22:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjBIDTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:19:02 -0500
Received: from m1391.mail.163.com (m1391.mail.163.com [220.181.13.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4D768684
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 19:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=YA15XLC0VVo5tNloxJysyKzaxJcygr33RclZiJom4uc=; b=X
        vseCVf24oe2+WS5D92qEjiTPsaWK2HRYeuGp64PK/BiieamugGmhWt/cIaqD+xSx
        d5iIVv3Hb7lJ5LkP0htq6c84Cq0nuWTilfby3rOzgRDBEafXQwgYabCeV+qY5A0D
        zRfdxeZ2pjqDoDxBYC+8HDqiJ6f6rVSaExxNPx5K18=
Received: from zyytlz.wz$163.com ( [111.206.145.21] ) by
 ajax-webmail-wmsvr91 (Coremail) ; Thu, 9 Feb 2023 11:18:54 +0800 (CST)
X-Originating-IP: [111.206.145.21]
Date:   Thu, 9 Feb 2023 11:18:54 +0800 (CST)
From:   =?GBK?B?zfXV9w==?= <zyytlz.wz@163.com>
To:     "Tianjia Zhang" <tianjia.zhang@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        alex000young@gmail.com
Subject: Re:Re: [PATCH] lib/mpi: Fix poential NULL pointer dereference in
 mpi_fdiv_q
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220708(c4627114)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <83391944-e0bf-288f-f50e-cc1a28b89a34@linux.alibaba.com>
References: <20230203084302.589017-1-zyytlz.wz@163.com>
 <83391944-e0bf-288f-f50e-cc1a28b89a34@linux.alibaba.com>
X-NTES-SC: AL_QuycB/WavU8o4iCRbekXmkYVhOk/Wcu2uPov2IBVO5E0pirQ2TsAQ1BFBV7x2+SpAi+DnzeWXTF12PZLRY1xf7/ryTO2KFW1txtjq6sluBjf
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <f2d33c3.4b76.186342ee594.Coremail.zyytlz.wz@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: W8GowAB3UPkeZuRjOcEUAA--.17640W
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/xtbBzhoQU2I0XRU8wgACs1
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKCgoKCgoKCgoKCgoKCkF0IDIwMjMtMDItMDcgMDk6NDE6MzUsICJUaWFuamlhIFpoYW5nIiA8
dGlhbmppYS56aGFuZ0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj5IaSBaaGVuZyBXYW5nLAo+
Cj5PbiAyLzMvMjMgNDo0MyBQTSwgWmhlbmcgV2FuZyB3cm90ZToKPj4gaW4gbGliL21waSwgdGhl
cmUgaXMgbXVsdGlwbGUgZnVuY3Rpb24gdGhhdCBub3QgY2hlY2sgdGhlIHJldHVybgo+PiB2YWx1
ZSBvZiBtcGlfYWxsb2MuIE9uZSBjYXNlIGlzIG1waV9mZGl2X3EsIGlmIHRtcCA9PSBOVUxMLAo+
PiB0bXAtPm5saW1icyBpbiBtcGlfZmRpdl9xciB3aWxsIGNhdXNlIE5VTEwgcG9pbnRlciBkZXJl
ZmVyZW5jZS4KPj4gQXMgdGhlIGNvZGUgaXMgdG9vIG11Y2gsIGhlcmUgSSBvbmx5IGZpeCBvbmUg
b2YgdGhlbS4gT3RoZXIKPj4gZnVuY3Rpb24gbGlrZSBtcGlfYmFycmV0dF9pbml0IG1waV9jb3B5
IG1waV9hbGxvY19saWtlIG1waV9zZXQKPj4gbXBpX3NldF91aSBtcGlfYWxsb2Nfc2V0X3VpIGhh
cyB0aGUgc2FtZSBwcm9ibGVtLgo+PiAKPj4gUGxlYXNlIGxldCBtZSBrbm93IGlmIHRoZXJlIGlz
IGEgYmV0dGVyIHdheSB0byBmaXggdGhlCj4+IHByb2JsZW0uCj4+IAo+PiBOb3RlIHRoYXQsIGFz
IGEgYnVnIGZvdW5kIGJ5IHN0YXRpYyBhbmFseXNpcywgaXQgY2FuIGJlIGEgZmFsc2UKPj4gcG9z
aXRpdmUgb3IgaGFyZCB0byB0cmlnZ2VyLgo+Cj5UaGFua3MgZm9yIHlvdXIgcGF0Y2gsIGxpYi9t
cGkgaXMgcG9ydGVkIGZyb20gbGliZ2NyeXB0LCBhcyBhbgo+YXBwbGljYXRpb24gbGF5ZXIgbGli
cmFyeSwgc3VjaCBlcnJvciBoYW5kbGluZyBpcyBubyBwcm9ibGVtLCBidXQgZm9yCj50aGUga2Vy
bmVsLCB0aGVzZSByZXR1cm4gdmFsdWVzIHNob3VsZCBiZSBjaGVja2VkLCBldmVuIGlmIHRoZXNl
IGVycm9ycwo+YXJlIGRpZmZpY3VsdCB0byB0cmlnZ2VyLgo+Cj5BcyB5b3Ugc2FpZCwgdGhlcmUg
YXJlIG1hbnkgcGxhY2VzIHdoZXJlIHRoaXMgY2hlY2sgaXMgaWdub3JlZCwgYW5kIGV2ZW4KPnRo
ZSBlcnJvciByZXR1cm4gdmFsdWUgbmVlZHMgdG8gYmUgcGFzc2VkIHVwd2FyZHMsIHdoaWNoIHNo
b3VsZCBiZQo+dXBncmFkZWQgYW5kIGZpeGVkIHVuaWZvcm1seSwgZXZlbiBzb21lIGNhbGxlcnMg
bmVlZCBzdWNoIGEgY2hlY2ssIHN1Y2gKPmFzIHRoZSBTTTIgYWxnb3JpdGhtLiBUaGVzZSBjaGVj
a3Mgd2VyZSBpbml0aWFsbHkgaWdub3JlZCBpbiB0aGUKPmludGVyZXN0IG9mIGNvZGUgYnJldml0
eSBhbmQgcmFwaWQgZGV2ZWxvcG1lbnQsIGFuZCBpdCBsb29rcyBsaWtlIGl0J3MKPnRpbWUgdG8g
Zml4IHRoZW0uCj4KClRoYW5rIHlvdSBmb3IgdGFraW5nIHRoZSB0aW1lIHRvIGNvbnNpZGVyIG15
IHF1ZXN0aW9uLiBIb3BlIGl0IGNhbiBiZQpmaXhlZCBxdWlja2x5LgoKPj4gCj4+IEZpeGVzOiBh
OGVhOGJkZDlkZjkgKCJsaWIvbXBpOiBFeHRlbmQgdGhlIE1QSSBsaWJyYXJ5IikKPj4gU2lnbmVk
LW9mZi1ieTogWmhlbmcgV2FuZyA8enl5dGx6Lnd6QDE2My5jb20+Cj4+IC0tLQo+PiAgIGxpYi9t
cGkvbXBpLWRpdi5jIHwgMyArKy0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pCj4+IAo+PiBkaWZmIC0tZ2l0IGEvbGliL21waS9tcGktZGl2LmMgYi9s
aWIvbXBpL21waS1kaXYuYwo+PiBpbmRleCA0NWJlYWI4YjllOWUuLmU4NjQyMjY1ZDdkNCAxMDA2
NDQKPj4gLS0tIGEvbGliL21waS9tcGktZGl2LmMKPj4gKysrIGIvbGliL21waS9tcGktZGl2LmMK
Pj4gQEAgLTQzLDcgKzQzLDggQEAgdm9pZCBtcGlfZmRpdl9yKE1QSSByZW0sIE1QSSBkaXZpZGVu
ZCwgTVBJIGRpdmlzb3IpCj4+ICAgdm9pZCBtcGlfZmRpdl9xKE1QSSBxdW90LCBNUEkgZGl2aWRl
bmQsIE1QSSBkaXZpc29yKQo+PiAgIHsKPj4gICAJTVBJIHRtcCA9IG1waV9hbGxvYyhtcGlfZ2V0
X25saW1icyhxdW90KSk7Cj4+IC0JbXBpX2ZkaXZfcXIocXVvdCwgdG1wLCBkaXZpZGVuZCwgZGl2
aXNvcik7Cj4+ICsJaWYgKHRtcCkKPj4gKwkJbXBpX2ZkaXZfcXIocXVvdCwgdG1wLCBkaXZpZGVu
ZCwgZGl2aXNvcik7Cj4+ICAgCW1waV9mcmVlKHRtcCk7Cj4+ICAgfQo+PiAgIAo+Cj5BcyBmYXIg
YXMgdGhpcyBpcyBjb25jZXJuZWQsIHRoZSBhbGxvY2F0aW9uIGZhaWx1cmUgc2hvdWxkIHBhc3Mg
dGhlCj5FTk9NRU0gZXJyb3IgdXB3YXJkcywgbm90IHRoZSB2b2lkIHR5cGUuCgpZZXMsIEkgdGhp
bmsgdGhlIGdvb2Qgd2F5IGlzIHRvIHJlZmFjdG9yIHRoZSBwcm90b3R5cGUgb2YgZnVuY3Rpb24s
Cm1ha2luZyBpdCBhdmFpbGFibGUgdG8gcmVjZWl2ZXIgZXJyb3IgY29kZSBhbmQgcGFzcyBpdCB0
byB0aGUgY2FsbGVyCmZ1bmN0aW9uLCB1bnRpbCB0aGVyZSBpcyBhbiBlcnJvciBoYW5kbGVyIHRv
IGhhbmRsZSBpdC4KCkJlc3QgcmVnYXJkcywKWmhlbmcgV2FuZw==
