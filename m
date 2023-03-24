Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240CB6C77B0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 07:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjCXGMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 02:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCXGMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 02:12:48 -0400
X-Greylist: delayed 917 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Mar 2023 23:12:45 PDT
Received: from m1360.mail.163.com (m1360.mail.163.com [220.181.13.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7AAD15147
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 23:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=YwRZQgLssuEVHqSJNlLh2ATcMxHte0Lp0qjfaDXiK1E=; b=j
        DWz4F229Onu5Cj/FKIp+meNAuYAKoxym9DFXwhIz4FmmnXa1r4iLKbyo8QadGTgj
        7DBUnXqkX3GnwrMKZg/KtHwuBbBXk+NN67yk1U5keWVqaNDoEwk8SYg+Bs3RD4vw
        TPXf2miF+zBicFKl9WrczpScqklVf/cSdGBC8Ndrzg=
Received: from jhb_ee$163.com ( [113.105.127.219] ) by ajax-webmail-wmsvr60
 (Coremail) ; Fri, 24 Mar 2023 13:56:42 +0800 (CST)
X-Originating-IP: [113.105.127.219]
Date:   Fri, 24 Mar 2023 13:56:42 +0800 (CST)
From:   =?GBK?B?tefX0w==?= <jhb_ee@163.com>
To:     rppt@kernel.org
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re:[PATCH] memblock: Correct calculation method for overflowing
 range @size
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <20230324052351.31106-1-jhb_ee@163.com>
References: <20230324052351.31106-1-jhb_ee@163.com>
X-NTES-SC: AL_QuycC/qYuEwr5CWdZukXn0oUhOs2XMq5s/4k2INTP5k0vCr89zAMXWFAEEv56vOXEB+grgabewlP2NVBdqd9Y50bWySHdvXd5MQ8MjCx36CC
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <2032a48e.3206.1871230d3bb.Coremail.jhb_ee@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: PMGowAB3mDSaOx1k3eIAAA--.9128W
X-CM-SenderInfo: 5mkesvrh6rljoofrz/1tbiRRM8fGDuzJsGygABsC
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ClNvcnJ5LCB0aGUgc2l6ZSBoZXJlIG1heSBiZSBjYWxjdWxhdGVkIGFjY29yZGluZyB0byB0aGlz
IGZvcm11bGEsIGNhbmNlbCB0aGlzIHBhdGNoCgoKCgpBdCAyMDIzLTAzLTI0IDEzOjIzOjUxLCAi
SG9uZ2JpbiBKaSIgPGpoYl9lZUAxNjMuY29tPiB3cm90ZToKPldoZW4gbWVtYmxvY2sgdXNlcnMg
dG8gc3BlY2lmeSByYW5nZSB3aGVyZSBAYmFzZSArIEBzaXplIG92ZXJmbG93cwo+YW5kIGF1dG9t
YXRpY2FsbHkgY2FwIGl0IGF0IG1heGltdW0sIFRoZSBuZXcgc2l6ZSBzaG91bGQgYmUKPlBIWVNf
QUREUl9NQVggLSBAYmFzZSArIDEuCj4KPkFzc3VtaW5nIHRoYXQgYmFzZSBpcyAwLCBQSFlTX0FE
RFJfTUFYIGlzIDB4ZmYsIHdoaWNoIGlzIDI1NSBpbiBkZWNpbWFsLAo+dGhlbiBAc2l6ZSBzaG91
bGQgYmUgMjU2IGluc3RlYWQgb2YgMjU1Cj4KPlNpZ25lZC1vZmYtYnk6IEhvbmdiaW4gSmkgPGpo
Yl9lZUAxNjMuY29tPgo+LS0tCj4gbW0vbWVtYmxvY2suYyB8IDIgKy0KPiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+ZGlmZiAtLWdpdCBhL21tL21lbWJs
b2NrLmMgYi9tbS9tZW1ibG9jay5jCj5pbmRleCAyNWZkMDYyNmE5ZTcuLmYxNjgzZDFkYWU2NSAx
MDA2NDQKPi0tLSBhL21tL21lbWJsb2NrLmMKPisrKyBiL21tL21lbWJsb2NrLmMKPkBAIC0xNjks
NyArMTY5LDcgQEAgc3RhdGljIGVudW0gbWVtYmxvY2tfZmxhZ3MgX19pbml0X21lbWJsb2NrIGNo
b29zZV9tZW1ibG9ja19mbGFncyh2b2lkKQo+IC8qIGFkanVzdCAqQHNpemUgc28gdGhhdCAoQGJh
c2UgKyAqQHNpemUpIGRvZXNuJ3Qgb3ZlcmZsb3csIHJldHVybiBuZXcgc2l6ZSAqLwo+IHN0YXRp
YyBpbmxpbmUgcGh5c19hZGRyX3QgbWVtYmxvY2tfY2FwX3NpemUocGh5c19hZGRyX3QgYmFzZSwg
cGh5c19hZGRyX3QgKnNpemUpCj4gewo+LQlyZXR1cm4gKnNpemUgPSBtaW4oKnNpemUsIFBIWVNf
QUREUl9NQVggLSBiYXNlKTsKPisJcmV0dXJuICpzaXplID0gbWluKCpzaXplLCBQSFlTX0FERFJf
TUFYIC0gYmFzZSArIDEpOwo+IH0KPiAKPiAvKgo+LS0gCj4yLjM0LjEK
