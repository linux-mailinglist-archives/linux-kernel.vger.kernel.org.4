Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479955E8799
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 04:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiIXCrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 22:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiIXCrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 22:47:14 -0400
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98404AA3DD;
        Fri, 23 Sep 2022 19:47:12 -0700 (PDT)
Received: by ajax-webmail-mail-app2 (Coremail) ; Sat, 24 Sep 2022 10:46:58
 +0800 (GMT+08:00)
X-Originating-IP: [10.162.98.155]
Date:   Sat, 24 Sep 2022 10:46:58 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   duoming@zju.edu.cn
To:     "Jason Yan" <yanaijie@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, kuba@kernel.org,
        john.garry@huawei.com, gregkh@linuxfoundation.org,
        davem@davemloft.net
Subject: Re: [PATCH] scsi: libsas: fix use-after-free bug in
 smp_execute_task_sg
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <9cd0b0ae-c6c7-a5bc-a834-a84010702bbc@huawei.com>
References: <20220920144213.10536-1-duoming@zju.edu.cn>
 <9cd0b0ae-c6c7-a5bc-a834-a84010702bbc@huawei.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <5e739c0a.f33e7.1836d641313.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgAXz1qiby5jUWdFBg--.16137W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgMDAVZdtbnvSwACsi
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sCgpPbiBUaHUsIDIyIFNlcCAyMDIyIDIyOjA2OjMwICswODAwIEphc29uIFlhbiB3cm90
ZToKCj4gT24gMjAyMi85LzIwIDIyOjQyLCBEdW9taW5nIFpob3Ugd3JvdGU6Cj4gPiBXaGVuIGV4
ZWN1dGluZyBTTVAgdGFzayBmYWlsZWQsIHRoZSBzbXBfZXhlY3V0ZV90YXNrX3NnKCkKPiA+IGNh
bGxzIGRlbF90aW1lcigpIHRvIGRlbGV0ZSB0aGUgInNsb3dfdGFzay0+dGltZXIiLiBIb3dldmVy
LAo+ID4gaWYgdGhlIHRpbWVyIGhhbmRsZXIgc2FzX3Rhc2tfaW50ZXJuYWxfdGltZWRvdXQoKSBp
cyBydW5uaW5nLAo+ID4gdGhlIGRlbF90aW1lcigpIGluIHNtcF9leGVjdXRlX3Rhc2tfc2coKSB3
aWxsIG5vdCBzdG9wIGl0Cj4gPiBhbmQgdGhlIFVBRiBidWcgd2lsbCBoYXBwZW4uIFRoZSBwcm9j
ZXNzIGlzIHNob3duIGJlbG93Ogo+ID4gCj4gPiAgICAgICAgKHRocmVhZCAxKSAgICAgICAgICAg
ICAgIHwgICAgICAgICh0aHJlYWQgMikKPiA+IHNtcF9leGVjdXRlX3Rhc2tfc2coKSAgICAgICAg
ICB8IHNhc190YXNrX2ludGVybmFsX3RpbWVkb3V0KCkKPiA+ICAgLi4uICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfAo+ID4gICBkZWxfdGltZXIoKSAgICAgICAgICAgICAgICAgICB8Cj4gPiAg
IC4uLiAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIC4uLgo+ID4gICBzYXNfZnJlZV90YXNr
KHRhc2spICAgICAgICAgICB8Cj4gPiAgICBrZnJlZSh0YXNrLT5zbG93X3Rhc2spIC8vRlJFRXwK
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgdGFzay0+c2xvd190YXNrLT4u
Li4gLy9VU0UKPiA+IAo+ID4gRml4IGJ5IGNhbGxpbmcgZGVsX3RpbWVyX3N5bmMoKSBpbiBzbXBf
ZXhlY3V0ZV90YXNrX3NnKCksCj4gPiB3aGljaCBtYWtlcyBzdXJlIHRoZSB0aW1lciBoYW5kbGVy
IGhhdmUgZmluaXNoZWQgYmVmb3JlCj4gPiB0aGUgInRhc2stPnNsb3dfdGFzayIgaXMgZGVhbGxv
Y2F0ZWQuCj4gPiAKPiA+IEZpeGVzOiAyOTA4ZDc3OGFiM2UgKCJbU0NTSV0gYWljOTR4eDogbmV3
IGRyaXZlciIpCj4gPiBTaWduZWQtb2ZmLWJ5OiBEdW9taW5nIFpob3UgPGR1b21pbmdAemp1LmVk
dS5jbj4KPiA+IC0tLQo+ID4gICBkcml2ZXJzL3Njc2kvbGlic2FzL3Nhc19leHBhbmRlci5jIHwg
MiArLQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkK
PiA+IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9saWJzYXMvc2FzX2V4cGFuZGVyLmMg
Yi9kcml2ZXJzL3Njc2kvbGlic2FzL3Nhc19leHBhbmRlci5jCj4gPiBpbmRleCBmYTIyMDkwODBj
Yy4uNWNlMjUxODMwMTAgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3Njc2kvbGlic2FzL3Nhc19l
eHBhbmRlci5jCj4gPiArKysgYi9kcml2ZXJzL3Njc2kvbGlic2FzL3Nhc19leHBhbmRlci5jCj4g
PiBAQCAtNjcsNyArNjcsNyBAQCBzdGF0aWMgaW50IHNtcF9leGVjdXRlX3Rhc2tfc2coc3RydWN0
IGRvbWFpbl9kZXZpY2UgKmRldiwKPiA+ICAgCQlyZXMgPSBpLT5kZnQtPmxsZGRfZXhlY3V0ZV90
YXNrKHRhc2ssIEdGUF9LRVJORUwpOwo+ID4gICAKPiA+ICAgCQlpZiAocmVzKSB7Cj4gPiAtCQkJ
ZGVsX3RpbWVyKCZ0YXNrLT5zbG93X3Rhc2stPnRpbWVyKTsKPiA+ICsJCQlkZWxfdGltZXJfc3lu
YygmdGFzay0+c2xvd190YXNrLT50aW1lcik7Cj4gPiAgIAkJCXByX25vdGljZSgiZXhlY3V0aW5n
IFNNUCB0YXNrIGZhaWxlZDolZFxuIiwgcmVzKTsKPiA+ICAgCQkJYnJlYWs7Cj4gPiAgIAkJfQo+
ID4gCj4gCj4gVGhlIHRpbWVyIHNob3VsZCBiZSB0cmlnZ2VyZWQgMTAgc2Vjb25kcyBsYXRlci4g
SSBhbSBjdXJpb3VzIHdoeSB3ZSBzdGF5Cj4gdGhpcyBsb25nIGJlZm9yZSBkZWxfdGltZXIoKS4K
CkkgdGhpbmsgdGhlIGhhY2tlciBtYXkgY3JlYXRlIGEgbGFyZ2UgbnVtYmVyIG9mIGhhcmR3YXJl
IGludGVycnVwdHMgdG8KaW5jcmVhc2UgdGhlIGRlbGF5ZWQgdGltZS4KCj4gSG93ZXZlciB0aGlz
IGNoYW5nZSBsb29rcyBnb29kIHRvIG1lLgo+IFJldmlld2VkLWJ5OiBKYXNvbiBZYW4gPHlhbmFp
amllQGh1YXdlaS5jb20+CgpUaGFuayB5b3UhCgpCZXN0IHJlZ2FyZHMsCkR1b21pbmcgWmhvdQo=

