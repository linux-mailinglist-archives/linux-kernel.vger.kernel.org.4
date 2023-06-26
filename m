Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BCE73D583
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 03:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjFZBVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 21:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFZBVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 21:21:32 -0400
X-Greylist: delayed 41526 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 25 Jun 2023 18:21:30 PDT
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 775EE194
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 18:21:30 -0700 (PDT)
Received: from linma$zju.edu.cn ( [42.120.103.48] ) by
 ajax-webmail-mail-app4 (Coremail) ; Mon, 26 Jun 2023 09:20:57 +0800
 (GMT+08:00)
X-Originating-IP: [42.120.103.48]
Date:   Mon, 26 Jun 2023 09:20:57 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Lin Ma" <linma@zju.edu.cn>
To:     "Alexey Dobriyan" <adobriyan@gmail.com>
Cc:     steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, simon.horman@corigine.com
Subject: Re: [PATCH v2] net: xfrm: Fix xfrm_address_filter OOB read
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <8a80ec0b-154a-4e6c-8fb8-916f506cd26d@p183>
References: <8a80ec0b-154a-4e6c-8fb8-916f506cd26d@p183>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <55aca58a.a2c0e.188f54a2741.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgBHTQr555hk63x8Bw--.28789W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwISEmSYV+MGPwAAsw
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gQWxleGV5LAoKKHNvcnJ5IGxhc3QgbWFpbCBqdXN0IHJlcGx5IHRvIG9uZSAuLikKCj4g
Cj4gPiArIGlmIChmaWx0ZXItPnNwbGVuID49IChzaXplb2YoeGZybV9hZGRyZXNzX3QpIDw8IDMp
IHx8Cj4gPiArIAlmaWx0ZXItPmRwbGVuID49IChzaXplb2YoeGZybV9hZGRyZXNzX3QpIDw8IDMp
KSB7Cj4gCj4gUGxlYXNlIG11bHRpcGx5IGJ5IDggaWYgeW91IHdhbnQgdG8gbXVsdGlwbHkgYnkg
OC4KPiAKClRoYW5rcyBmb3IgcmVtaW5kaW5nLgoKQXMgSSB0b2xkIGluIHRoZSBjb21taXQgbWVz
c2FnZSwgdGhpcyBjaGVja2luZyBjb2RlIGlzIGp1c3QgY29weSBmcm9tIHRoZSBmdW5jdGlvbiBw
ZmtleV9kdW1wIChuZXQva2V5L2FmX2tleS5jKSwgd2hpY2ggbGlrZQoKCWlmICgoeGZpbHRlci0+
c2FkYl94X2ZpbHRlcl9zcGxlbiA+PQoJCShzaXplb2YoeGZybV9hZGRyZXNzX3QpIDw8IDMpKSB8
fAoJICAgICh4ZmlsdGVyLT5zYWRiX3hfZmlsdGVyX2RwbGVuID49CgkJKHNpemVvZih4ZnJtX2Fk
ZHJlc3NfdCkgPDwgMykpKSB7CgkJbXV0ZXhfdW5sb2NrKCZwZmstPmR1bXBfbG9jayk7CgkJcmV0
dXJuIC1FSU5WQUw7Cgl9CgpJIHRoaW5rIHRoZSBsZWZ0IHNoaWZ0IDMgaXMgb2theSBhcyB0aGUg
YWN0dWFsIGNhbGN1bGF0aW9uIG9uIHRob3NlIGxlbmd0aHMgaXMgcmlnaHQgc2hpZnQgKyBsZWZ0
IHNoaWZ0IChzZWUgaW4gYWRkcl9tYXRjaCgpIGZ1bmN0aW9uKS4KCj4gU2hvdWxkIGl0IGJlICJz
cGxlbiA+IDggKiBzaXplb2YoKSIgPwoKR29vZCBxdWVzdGlvbi4gSXQgc2VlbXMgdGhhdCB0aGUg
ZmlsdGVyIGxlbmd0aCBpcyBsZWdhbCB0byByZWFjaCB0aGUgbWF4aW11bSBsZW5ndGguIFNvIHNo
b3VsZCBJIHNlbmQgYW5vdGhlciBwYXRjaCB0aGF0IGFsbG93cyB0aGUgY2hlY2tpbmcgY29kZSBp
biBwZmtleV9kdW1wIChuZXQva2V5L2FmX2tleS5jKSB0byBjaGFuZ2UgdG8gPiBpbnN0ZWFkIG9m
ID49ID8KClJlZ2FyZHMKTGlu
