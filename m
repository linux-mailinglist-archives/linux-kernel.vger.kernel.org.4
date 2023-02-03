Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC49689FA7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 17:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbjBCQuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 11:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbjBCQur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 11:50:47 -0500
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E7FA9132
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 08:50:20 -0800 (PST)
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 09DEC5F782;
        Fri,  3 Feb 2023 17:50:18 +0100 (CET)
Date:   Fri, 3 Feb 2023 17:50:17 +0100 (CET)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: External USB disks not recognized with v6.1.8 when using Xen
In-Reply-To: <CAHk-=wg1yXaX+Ut4uctf7x1WrZ4WW9hjSCr1VACwZtkZT9frFw@mail.gmail.com>
Message-ID: <4973310d-005b-5228-78c8-74cf353f05a9@nerdbynature.de>
References: <4fe9541e-4d4c-2b2a-f8c8-2d34a7284930@nerdbynature.de> <f22551ea-0694-2838-4a3f-f60d8d93fa64@leemhuis.info> <8f132803-f496-f33a-d2ab-b47fd5af0b88@nerdbynature.de> <0f441adb-f565-7a37-d9e5-3b14f6f7aea6@suse.com> <f02c49da-0377-97b9-9438-9e0ddbfbcc6d@nerdbynature.de>
 <CAHk-=wg1yXaX+Ut4uctf7x1WrZ4WW9hjSCr1VACwZtkZT9frFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=-1184995494175831724816754430182122481
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1184995494175831724816754430182122481
Content-Type: text/plain; charset=us-ascii

On Thu, 2 Feb 2023, Linus Torvalds wrote:
> So I think that commit should be reverted as broken, and then people
> should *maybe* look at something like this (intentionally whitespace
> damaged, and people should *really* think about what the
> MTRR_TYPE_INVALID case should be - returning UC- is probably what is

Not fully understanding what your proposal really does, I got curious and 
applied it to v6.2-rc6 with 90b926e68f50 (upstream) reverted. And it 
boots, and the disks are there, and the "ioremap error" is gone, but now 
I've got strange memory allocation errors, for like really small 
operations (I wanted to capture dmesg):

  $ dmesg -t | xz -9ec | base64 
  xz: (stdin): Out of memory

With v6.2-rc6 (vanilla, and also booted under Xen) there's no problem 
allocating much more memory than that, so something is still not right. 
Patch applied for reference, but as you said: nobody should apply this :-)

More details:

- https://nerdbynature.de/bits/usb_v6.1.8/dmesg.6.1.8.xen
- https://nerdbynature.de/bits/usb_v6.1.8/dmesg_xen-6.1.8_MTRR_TYPE_INVALID.txt
- https://nerdbynature.de/bits/usb_v6.1.8/meminfo_xen-6.1.8.txt
- https://nerdbynature.de/bits/usb_v6.1.8/meminfo_xen-6.1.8_MTRR_TYPE_INVALID.txt

Thanks,
Christian.
-- 
BOFH excuse #448:

vi needs to be upgraded to vii
---1184995494175831724816754430182122481
Content-Type: text/plain; name=MTRR_TYPE_INVALID.patch.txt
Content-Transfer-Encoding: BASE64
Content-ID: <9419be5e-e6f1-0c0a-e279-7b3b33c4ae64@trent.utfs.org>
Content-Description: 
Content-Disposition: attachment; filename=MTRR_TYPE_INVALID.patch.txt

Y29tbWl0IDU2YTE1OWVmZWJjMA0KQXV0aG9yOiBDaHJpc3RpYW4gS3VqYXUg
PGxpc3RzQG5lcmRieW5hdHVyZS5kZT4NCkRhdGU6ICAgRnJpIEZlYiAzIDE3
OjEzOjMzIDIwMjMgKzAxMDANCg0KICAgIE1UUlJfVFlQRV9JTlZBTElEIGZp
eGVzIGFzIHByb3Bvc2VkIGJ5IExpbnVzLg0KDQpkaWZmIC0tZ2l0IGEvYXJj
aC94ODYvaW5jbHVkZS9hc20vbXRyci5oIGIvYXJjaC94ODYvaW5jbHVkZS9h
c20vbXRyci5oDQppbmRleCBmMGVlYWY2ZTVmNWYuLjM4ZGVkMjc2Mjg0NyAx
MDA2NDQNCi0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL210cnIuaA0KKysr
IGIvYXJjaC94ODYvaW5jbHVkZS9hc20vbXRyci5oDQpAQCAtNTMsNyArNTMs
OCBAQCBzdGF0aWMgaW5saW5lIHU4IG10cnJfdHlwZV9sb29rdXAodTY0IGFk
ZHIsIHU2NCBlbmQsIHU4ICp1bmlmb3JtKQ0KIAkvKg0KIAkgKiBSZXR1cm4g
bm8tTVRSUnM6DQogCSAqLw0KLQlyZXR1cm4gTVRSUl9UWVBFX0lOVkFMSUQ7
DQorCSp1bmlmb3JtID0gMTsNCisJcmV0dXJuIE1UUlJfVFlQRV9JTlZBTElE
OyAvKiA/Pz8gKi8NCiB9DQogI2RlZmluZSBtdHJyX3NhdmVfZml4ZWRfcmFu
Z2VzKGFyZykgZG8ge30gd2hpbGUgKDApDQogI2RlZmluZSBtdHJyX3NhdmVf
c3RhdGUoKSBkbyB7fSB3aGlsZSAoMCkNCmRpZmYgLS1naXQgYS9hcmNoL3g4
Ni9rZXJuZWwvY3B1L210cnIvZ2VuZXJpYy5jIGIvYXJjaC94ODYva2VybmVs
L2NwdS9tdHJyL2dlbmVyaWMuYw0KaW5kZXggZWUwOWQzNTllMDhmLi4wZDc3
OTk4YjkwZWEgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L210
cnIvZ2VuZXJpYy5jDQorKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L210cnIv
Z2VuZXJpYy5jDQpAQCAtMjYxLDExICsyNjEsMTMgQEAgdTggbXRycl90eXBl
X2xvb2t1cCh1NjQgc3RhcnQsIHU2NCBlbmQsIHU4ICp1bmlmb3JtKQ0KIAkv
KiBNYWtlIGVuZCBpbmNsdXNpdmUgaW5zdGVhZCBvZiBleGNsdXNpdmUgKi8N
CiAJZW5kLS07DQogDQorCXR5cGUgPSBNVFJSX1RZUEVfSU5WQUxJRDsgLyog
Pz8/ICovDQogCWlmICghbXRycl9zdGF0ZV9zZXQpDQotCQlyZXR1cm4gTVRS
Ul9UWVBFX0lOVkFMSUQ7DQorCQlnb3RvIG91dDsNCiANCisJdHlwZSA9IG10
cnJfc3RhdGUuZGVmX3R5cGU7DQogCWlmICghKG10cnJfc3RhdGUuZW5hYmxl
ZCAmIE1UUlJfU1RBVEVfTVRSUl9FTkFCTEVEKSkNCi0JCXJldHVybiBNVFJS
X1RZUEVfSU5WQUxJRDsNCisJCWdvdG8gb3V0Ow0KIA0KIAkvKg0KIAkgKiBM
b29rIHVwIHRoZSBmaXhlZCByYW5nZXMgZmlyc3QsIHdoaWNoIHRha2UgcHJp
b3JpdHkgb3Zlcg0K

---1184995494175831724816754430182122481--
