Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E52E60701F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 08:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiJUGci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 02:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiJUGcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 02:32:35 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD67423B692
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:32:33 -0700 (PDT)
Received: by ajax-webmail-mail-app2 (Coremail) ; Fri, 21 Oct 2022 14:32:12
 +0800 (GMT+08:00)
X-Originating-IP: [10.192.136.77]
Date:   Fri, 21 Oct 2022 14:32:12 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   duoming@zju.edu.cn
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        paskripkin@gmail.com, martin@kaiser.cx, straube.linux@gmail.com,
        kuba@kernel.org
Subject: Re: [PATCH] drivers: staging: r8188eu: Fix sleep-in-atomic-context
 bug in rtw_join_timeout_handler
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <Y1FtZzV9wRQRaTYk@kroah.com>
References: <20221018083424.79741-1-duoming@zju.edu.cn>
 <Y1FtZzV9wRQRaTYk@kroah.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <77ff753.140ebd.183f93dfb04.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgBHC7HsPFJj1p8gBw--.42190W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgoKAVZdtcBqRQADsR
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sCgpPbiBUaHUsIDIwIE9jdCAyMDIyIDE3OjQ2OjQ3ICswMjAwIEdyZWcgS0ggd3JvdGU6
Cgo+IE9uIFR1ZSwgT2N0IDE4LCAyMDIyIGF0IDA0OjM0OjI0UE0gKzA4MDAsIER1b21pbmcgWmhv
dSB3cm90ZToKPiA+IFRoZSBydHdfam9pbl90aW1lb3V0X2hhbmRsZXIoKSBpcyBhIHRpbWVyIGhh
bmRsZXIgdGhhdAo+ID4gcnVucyBpbiBhdG9taWMgY29udGV4dCwgYnV0IGl0IGNvdWxkIGNhbGwg
bXNsZWVwKCkuCj4gPiBBcyBhIHJlc3VsdCwgdGhlIHNsZWVwLWluLWF0b21pYy1jb250ZXh0IGJ1
ZyB3aWxsIGhhcHBlbi4KPiA+IFRoZSBwcm9jZXNzIGlzIHNob3duIGJlbG93Ogo+ID4gCj4gPiAg
ICAgIChhdG9taWMgY29udGV4dCkKPiA+IHJ0d19qb2luX3RpbWVvdXRfaGFuZGxlcgo+IAo+IFdh
aXQsIGhvdyBpcyB0aGlzIGFuIGF0b21pYyB0aW1lb3V0PwoKQmVjYXVzZSB0aGlzIGZ1bmN0aW9u
IGlzIGRlZmluZWQgYXMgYSB0aW1lciBoYW5kbGVyIG9mICJhc3NvY190aW1lciIuCgpUaGUgZm9s
bG93aW5nIGlzIHRoZSBkZXRhaWw6Cgp2b2lkIHJ0d19pbml0X21sbWVfdGltZXIoc3RydWN0IGFk
YXB0ZXIgKnBhZGFwdGVyKQp7CglzdHJ1Y3QJbWxtZV9wcml2ICpwbWxtZXByaXYgPSAmcGFkYXB0
ZXItPm1sbWVwcml2OwoKCXRpbWVyX3NldHVwKCZwbWxtZXByaXYtPmFzc29jX3RpbWVyLCBydHdf
am9pbl90aW1lb3V0X2hhbmRsZXIsIDApOwogICAgICAgIC4uLgp9CgpodHRwczovL2VsaXhpci5i
b290bGluLmNvbS9saW51eC9sYXRlc3Qvc291cmNlL2RyaXZlcnMvc3RhZ2luZy9yODE4OGV1L29z
X2RlcC9tbG1lX2xpbnV4LmMjTDM2Cgo+IFdoZW4gY2FuIHRoYXQgaGFwcGVuPwoKV2hlbiB0aGUg
YWRhcHRlciB0cnlzIHRvIGpvaW4gYW5kIHNlbGVjdHMgc2Nhbm5pbmcgcXVldWUgc3VjY2Vzc2Z1
bGx5LAp0aGUgYXNzb2NfdGltZXIgd2lsbCBiZSBhY3RpdmVkLiBJZiB0aGlzIHByb2Nlc3MgaXMg
dGltZW91dCwgdGhlIGNhbGxiYWNrCmZ1bmN0aW9uIHJ0d19qb2luX3RpbWVvdXRfaGFuZGxlciB3
aWxsIHJ1bi4KCj4gPiAgX3J0d19qb2luX3RpbWVvdXRfaGFuZGxlcgo+ID4gICBydHdfZG9fam9p
bgo+ID4gICAgcnR3X3NlbGVjdF9hbmRfam9pbl9mcm9tX3NjYW5uZWRfcXVldWUKPiA+ICAgICBy
dHdfaW5kaWNhdGVfZGlzY29ubmVjdAo+ID4gICAgICBydHdfbHBzX2N0cmxfd2tfY21kCj4gPiAg
ICAgICBscHNfY3RybF93a19oZGwKPiA+ICAgICAgICBMUFNfTGVhdmUKPiA+ICAgICAgICAgTFBT
X1JGX09OX2NoZWNrCj4gPiAgICAgICAgICBtc2xlZXAgLy9zbGVlcCBpbiBhdG9taWMgY29udGV4
dAo+IAo+IEhvdyB3YXMgdGhpcyBmb3VuZD8KPiAKPiA+IEZpeCBieSByZW1vdmluZyBtc2xlZXAo
KSBhbmQgcmVwbGFjaW5nIHdpdGggbWRlbGF5KCkuCj4gCj4gV291bGRuJ3QgcGVvcGxlIGhhdmUg
c2VlbiBhbiBlcnJvciBhbHJlYWR5IGlmIG1zbGVlcCgpIHdhcyByZWFsbHkgY2FsbGVkCj4gaW4g
YXRvbWljIGNvbnRleHQ/CgpJIGFtIHNvcnJ5LCBUaGlzIGlzIHRoZSBmYWxzZSBhbGFybS4KCnJ0
d19pbmRpY2F0ZV9kaXNjb25uZWN0KCkKICAtLT5ydHdfbHBzX2N0cmxfd2tfY21kKHBhZGFwdGVy
LCBMUFNfQ1RSTF9ESVNDT05ORUNULCAxKTsKCnU4IHJ0d19scHNfY3RybF93a19jbWQoc3RydWN0
IGFkYXB0ZXIgKnBhZGFwdGVyLCB1OCBscHNfY3RybF90eXBlLCB1OCBlbnF1ZXVlKQp7Ci4uLgpp
ZiAoZW5xdWV1ZSkgewouLi4KfWVsc2UgewogICAgbHBzX2N0cmxfd2tfaGRsKHBhZGFwdGVyLCBs
cHNfY3RybF90eXBlKTsKfQoKVGhlIGVucXVldWUgZXF1YWxzIHRvIDEgYW5kIHRoZSBscHNfY3Ry
bF93a19oZGwoKSB3aWxsIG5vdCBleGVjdXRlLgoKSSB3aWxsIGNoZWNrIGNhcmVmdWxseSBhbmQg
YXZvaWQgZmFsc2UgYWxhcm0gbmV4dCB0aW1lLiBUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuCgpC
ZXN0IHJlZ2FyZHMsCkR1b21pbmcgWmhvdQ==
