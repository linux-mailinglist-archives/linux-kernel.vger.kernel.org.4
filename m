Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D945735769
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 14:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjFSMza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 08:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjFSMz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 08:55:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A595DF4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 05:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687179280;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IDAKmsTrcdD3l8pnibAcUiFoVMKj0wINSNr7RXPEDVg=;
        b=LklUG5/ZF/bxymVjnbfLtHoN0BlFWZvXaOH+yIsXj1EotTfS0qCQR8bV71CmvoyDYTB9zv
        2PqxCVeQ5qTWw1s/XFAyMehS6jOr6EADyLhnU+j6BDt/J0ryVHA5+/+qyTwBpfC1oMWOm8
        Be641Cu301f6UOssKoT2OyZFz8hNx5A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-nNUxN8pvOWmNA_jJb9HNJg-1; Mon, 19 Jun 2023 08:54:39 -0400
X-MC-Unique: nNUxN8pvOWmNA_jJb9HNJg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f9b1ec2826so3474635e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 05:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687179278; x=1689771278;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:reply-to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IDAKmsTrcdD3l8pnibAcUiFoVMKj0wINSNr7RXPEDVg=;
        b=dWyeJf9k3cFv9bAZTWbMoK2O12I77+kGzl5DH83xKcqwbuNPOOlNoprDdA1RPOOvv8
         +BXHm9mq1nurBefkfS7XZGYyZC5/LT9owE3cj4UYDreNmZIZ/VmrFdIZXl1uP3tmEJHV
         IJzhs4CKqAhrn2p2e3l4X7k4eplPRcuv3Od8ilrFS46C3+YgDgS4BSw5lOMoyvQlXSVj
         SRHZF0sTVIpDlvL9z9jtdjqkp6OI9t5bj6E3C+ZNX8cLmZR4y5Fb61Znj2Z3d338IJkt
         sV8Sskv84R/mA2XDwdMSjtgngz6HIyBhxJK1ofkjyWLMHJl8ExuSLiOoSxrtyMIucO7n
         kZVg==
X-Gm-Message-State: AC+VfDwZalLJ2muBLePgfNRfvwojcL0TYPTvNRxwZma8733ff6Xlo7/e
        JyF3XiUnrqicKOSdpSY21Ke+VzvH6cGRGsmKa7bGLM4HZ0HcJwGUazFpBezcKaspO1A1aO92vkX
        w8t7kxHZBvSR9FCcNUQXyDG8P
X-Received: by 2002:a05:600c:10d1:b0:3f7:a20a:561d with SMTP id l17-20020a05600c10d100b003f7a20a561dmr8414865wmd.8.1687179278479;
        Mon, 19 Jun 2023 05:54:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7160EzcpU6GUnu3WmyfGfY9JI9z/xnbG2RL8pH0QnSQJ+kT4GV87sTRxcO7rsexfS+38fNlA==
X-Received: by 2002:a05:600c:10d1:b0:3f7:a20a:561d with SMTP id l17-20020a05600c10d100b003f7a20a561dmr8414839wmd.8.1687179278116;
        Mon, 19 Jun 2023 05:54:38 -0700 (PDT)
Received: from [192.168.2.56] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id h25-20020a1ccc19000000b003f42158288dsm10653889wmb.20.2023.06.19.05.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 05:54:37 -0700 (PDT)
Message-ID: <3fb062e5b86d70dff7a588a641bdc6d93dab4c2a.camel@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH net] ice: ice_vsi_release cleanup
From:   Petr Oros <poros@redhat.com>
Reply-To: poros@redhat.com
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc:     netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org,
        edumazet@google.com, anthony.l.nguyen@intel.com, kuba@kernel.org,
        pabeni@redhat.com, davem@davemloft.net,
        michal.swiatkowski@intel.com
Date:   Mon, 19 Jun 2023 14:54:35 +0200
In-Reply-To: <ZJBMSWygwtovyNgU@boxer>
References: <20230619084948.360128-1-poros@redhat.com>
         <ZJBMSWygwtovyNgU@boxer>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWFjaWVqIEZpamFsa293c2tpIHDDrcWhZSB2IFBvIDE5LiAwNi4gMjAyMyB2IDE0OjM4ICswMjAw
Ogo+IE9uIE1vbiwgSnVuIDE5LCAyMDIzIGF0IDEwOjQ5OjQ4QU0gKzAyMDAsIFBldHIgT3JvcyB3
cm90ZToKPiA+IFNpbmNlIGNvbW1pdCA2NjI0ZTc4MGE1NzdmYyAoImljZTogc3BsaXQgaWNlX3Zz
aV9zZXR1cCBpbnRvIHNtYWxsZXIKPiA+IGZ1bmN0aW9ucyIpIGljZV92c2lfcmVsZWFzZSBkb2Vz
IHRoaW5ncyB0d2ljZS4gVGhlcmUgaXMgdW5yZWdpc3Rlcgo+ID4gbmV0ZGV2IHdoaWNoIGlzIHVu
cmVnaXN0ZXJlZCBpbiBpY2VfZGVpbml0X2V0aCBhbHNvLgo+ID4gCj4gPiBJdCBhbHNvIHVucmVn
aXN0ZXJzIHRoZSBkZXZsaW5rX3BvcnQgdHdpY2Ugd2hpY2ggaXMgYWxzbwo+ID4gdW5yZWdpc3Rl
cmVkCj4gPiBpbiBpY2VfZGVpbml0X2V0aCgpLiBUaGlzIGRvdWJsZSBkZXJlZ2lzdHJhdGlvbiBp
cyBoaWRkZW4gYmVjYXVzZQo+ID4gZGV2bF9wb3J0X3VucmVnaXN0ZXIgaWdub3JlcyB0aGUgcmV0
dXJuIHZhbHVlIG9mIHhhX2VyYXNlLgo+ID4gCj4gPiBbwqDCoCA2OC42NDIxNjddIENhbGwgVHJh
Y2U6Cj4gPiBbwqDCoCA2OC42NTAzODVdwqAgaWNlX2RldmxpbmtfZGVzdHJveV9wZl9wb3J0KzB4
ZS8weDIwIFtpY2VdCj4gPiBbwqDCoCA2OC42NTU2NTZdwqAgaWNlX3ZzaV9yZWxlYXNlKzB4NDQ1
LzB4NjkwIFtpY2VdCj4gPiBbwqDCoCA2OC42NjAxNDddwqAgaWNlX2RlaW5pdCsweDk5LzB4Mjgw
IFtpY2VdCj4gPiBbwqDCoCA2OC42NjQxMTddwqAgaWNlX3JlbW92ZSsweDFiNi8weDVjMCBbaWNl
XQo+ID4gCj4gPiBbwqAgMTcxLjEwMzg0MV0gQ2FsbCBUcmFjZToKPiA+IFvCoCAxNzEuMTA5NjA3
XcKgIGljZV9kZXZsaW5rX2Rlc3Ryb3lfcGZfcG9ydCsweGYvMHgyMCBbaWNlXQo+ID4gW8KgIDE3
MS4xMTQ4NDFdwqAgaWNlX3JlbW92ZSsweDE1OC8weDI3MCBbaWNlXQo+ID4gW8KgIDE3MS4xMTg4
NTRdwqAgcGNpX2RldmljZV9yZW1vdmUrMHgzYi8weGMwCj4gPiBbwqAgMTcxLjEyMjc3OV3CoCBk
ZXZpY2VfcmVsZWFzZV9kcml2ZXJfaW50ZXJuYWwrMHhjNy8weDE3MAo+ID4gW8KgIDE3MS4xMjc5
MTJdwqAgZHJpdmVyX2RldGFjaCsweDU0LzB4OGMKPiA+IFvCoCAxNzEuMTMxNDkxXcKgIGJ1c19y
ZW1vdmVfZHJpdmVyKzB4NzcvMHhkMQo+ID4gW8KgIDE3MS4xMzU0MDZdwqAgcGNpX3VucmVnaXN0
ZXJfZHJpdmVyKzB4MmQvMHhiMAo+ID4gW8KgIDE3MS4xMzk2NzBdwqAgaWNlX21vZHVsZV9leGl0
KzB4Yy8weDU1ZiBbaWNlXQo+IAo+IEhpIFBldHIsCj4gY2FuIHlvdSB0ZWxsIHVzIHdoZW4gaW4g
cGFydGljdWxhciB0aGlzIGNhbGwgdHJhY2Ugd2FzIG9ic2VydmVkPwoKSSBmb3VuZCBvdXQgdGhh
dCB0aGUgZGV2bGluayBwb3J0IGlzIGRlcmVnaXN0ZXJlZCB0d2ljZS4gVGhpcyBjYWxsdHJhY2UK
d2FzIGdlbmVyYXRlZCBieSBkdW1wX3N0YWNrKCkgcGxhY2VkIGluIGRldmxpbmtfcG9ydF91bnJl
Z2lzdGVyIC0+IGl0CmlzIHRlc3RpbmcgdHJhY2UsIG5vdCBmcm9tIHByb2R1Y3Rpb24uCgpSZWdh
cmRzLApQZXRyCgoKPiAKPiBDQzogTWljaGFsIFN3aWF0a293c2tpIDxtaWNoYWwuc3dpYXRrb3dz
a2lAaW50ZWwuY29tPgo+IAo+ID4gCj4gPiBGaXhlczogNjYyNGU3ODBhNTc3ICgiaWNlOiBzcGxp
dCBpY2VfdnNpX3NldHVwIGludG8gc21hbGxlcgo+ID4gZnVuY3Rpb25zIikKPiA+IFNpZ25lZC1v
ZmYtYnk6IFBldHIgT3JvcyA8cG9yb3NAcmVkaGF0LmNvbT4KPiA+IC0tLQo+ID4gwqBkcml2ZXJz
L25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2xpYi5jIHwgMjcgLS0tLS0tLS0tLS0tLS0tLS0t
LS0KPiA+IC0tLS0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDI3IGRlbGV0aW9ucygtKQo+ID4gCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9saWIuYwo+
ID4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2xpYi5jCj4gPiBpbmRleCAx
MWFlMGU0MWY1MThhMS4uMjg0YTFmMGJmZGI1NDUgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL25l
dC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2xpYi5jCj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhl
cm5ldC9pbnRlbC9pY2UvaWNlX2xpYi5jCj4gPiBAQCAtMzI3MiwzOSArMzI3MiwxMiBAQCBpbnQg
aWNlX3ZzaV9yZWxlYXNlKHN0cnVjdCBpY2VfdnNpICp2c2kpCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRU5PREVWOwo+ID4gwqDCoMKgwqDCoMKgwqDCoHBmID0g
dnNpLT5iYWNrOwo+ID4gwqAKPiA+IC3CoMKgwqDCoMKgwqDCoC8qIGRvIG5vdCB1bnJlZ2lzdGVy
IHdoaWxlIGRyaXZlciBpcyBpbiB0aGUgcmVzZXQgcmVjb3ZlcnkKPiA+IHBlbmRpbmcKPiA+IC3C
oMKgwqDCoMKgwqDCoCAqIHN0YXRlLiBTaW5jZSByZXNldC9yZWJ1aWxkIGhhcHBlbnMgdGhyb3Vn
aCBQRiBzZXJ2aWNlCj4gPiB0YXNrIHdvcmtxdWV1ZSwKPiA+IC3CoMKgwqDCoMKgwqDCoCAqIGl0
J3Mgbm90IGEgZ29vZCBpZGVhIHRvIHVucmVnaXN0ZXIgbmV0ZGV2IHRoYXQgaXMKPiA+IGFzc29j
aWF0ZWQgdG8gdGhlCj4gPiAtwqDCoMKgwqDCoMKgwqAgKiBQRiB0aGF0IGlzIHJ1bm5pbmcgdGhl
IHdvcmsgcXVldWUgaXRlbXMgY3VycmVudGx5LiBUaGlzCj4gPiBpcyBkb25lIHRvCj4gPiAtwqDC
oMKgwqDCoMKgwqAgKiBhdm9pZCBjaGVja19mbHVzaF9kZXBlbmRlbmN5KCkgd2FybmluZyBvbiB0
aGlzIHdxCj4gPiAtwqDCoMKgwqDCoMKgwqAgKi8KPiA+IC3CoMKgwqDCoMKgwqDCoGlmICh2c2kt
Pm5ldGRldiAmJiAhaWNlX2lzX3Jlc2V0X2luX3Byb2dyZXNzKHBmLT5zdGF0ZSkgJiYKPiA+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoCAodGVzdF9iaXQoSUNFX1ZTSV9ORVRERVZfUkVHSVNURVJFRCwg
dnNpLT5zdGF0ZSkpKSB7Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdW5yZWdp
c3Rlcl9uZXRkZXYodnNpLT5uZXRkZXYpOwo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGNsZWFyX2JpdChJQ0VfVlNJX05FVERFVl9SRUdJU1RFUkVELCB2c2ktPnN0YXRlKTsKPiA+
IC3CoMKgwqDCoMKgwqDCoH0KPiA+IC0KPiA+IC3CoMKgwqDCoMKgwqDCoGlmICh2c2ktPnR5cGUg
PT0gSUNFX1ZTSV9QRikKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpY2VfZGV2
bGlua19kZXN0cm95X3BmX3BvcnQocGYpOwo+ID4gLQo+ID4gwqDCoMKgwqDCoMKgwqDCoGlmICh0
ZXN0X2JpdChJQ0VfRkxBR19SU1NfRU5BLCBwZi0+ZmxhZ3MpKQo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBpY2VfcnNzX2NsZWFuKHZzaSk7Cj4gPiDCoAo+ID4gwqDCoMKgwqDC
oMKgwqDCoGljZV92c2lfY2xvc2UodnNpKTsKPiA+IMKgwqDCoMKgwqDCoMKgwqBpY2VfdnNpX2Rl
Y2ZnKHZzaSk7Cj4gPiDCoAo+ID4gLcKgwqDCoMKgwqDCoMKgaWYgKHZzaS0+bmV0ZGV2KSB7Cj4g
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHRlc3RfYml0KElDRV9WU0lfTkVU
REVWX1JFR0lTVEVSRUQsIHZzaS0KPiA+ID5zdGF0ZSkpIHsKPiA+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdW5yZWdpc3Rlcl9uZXRkZXYodnNpLT5uZXRk
ZXYpOwo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBj
bGVhcl9iaXQoSUNFX1ZTSV9ORVRERVZfUkVHSVNURVJFRCwgdnNpLQo+ID4gPnN0YXRlKTsKPiA+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgaWYgKHRlc3RfYml0KElDRV9WU0lfTkVUREVWX0FMTE9DRCwgdnNpLT5zdGF0
ZSkpIHsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ZnJlZV9uZXRkZXYodnNpLT5uZXRkZXYpOwo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqB2c2ktPm5ldGRldiA9IE5VTEw7Cj4gPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNsZWFyX2JpdChJQ0VfVlNJX05FVERF
Vl9BTExPQ0QsIHZzaS0KPiA+ID5zdGF0ZSk7Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgfQo+ID4gLcKgwqDCoMKgwqDCoMKgfQo+ID4gLQo+ID4gwqDCoMKgwqDCoMKgwqDCoC8q
IHJldGFpbiBTVyBWU0kgZGF0YSBzdHJ1Y3R1cmUgc2luY2UgaXQgaXMgbmVlZGVkIHRvCj4gPiB1
bnJlZ2lzdGVyIGFuZAo+ID4gwqDCoMKgwqDCoMKgwqDCoCAqIGZyZWUgVlNJIG5ldGRldiB3aGVu
IFBGIGlzIG5vdCBpbiByZXNldCByZWNvdmVyeSBwZW5kaW5nCj4gPiBzdGF0ZSxcCj4gPiDCoMKg
wqDCoMKgwqDCoMKgICogZm9yIGV4OiBkdXJpbmcgcm1tb2QuCj4gPiAtLSAKPiA+IDIuNDEuMAo+
ID4gCj4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+
ID4gSW50ZWwtd2lyZWQtbGFuIG1haWxpbmcgbGlzdAo+ID4gSW50ZWwtd2lyZWQtbGFuQG9zdW9z
bC5vcmcKPiA+IGh0dHBzOi8vbGlzdHMub3N1b3NsLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVs
LXdpcmVkLWxhbgo+IAoK

