Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5899B64AEA5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 05:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbiLME0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 23:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiLME0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 23:26:43 -0500
Received: from forward502o.mail.yandex.net (forward502o.mail.yandex.net [37.140.190.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911BD1AD83
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 20:26:41 -0800 (PST)
Received: from vla1-62318bfe5573.qloud-c.yandex.net (vla1-62318bfe5573.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:3819:0:640:6231:8bfe])
        by forward502o.mail.yandex.net (Yandex) with ESMTP id 04B3125D449C;
        Tue, 13 Dec 2022 07:18:29 +0300 (MSK)
Received: by vla1-62318bfe5573.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id QIV8sJaY6uQ1-fxO2YiFE;
        Tue, 13 Dec 2022 07:18:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1670905109;
        bh=idiNl1j/MK9FVPg4fRiGJYQoEIte4QmSOGFnBA0X0+I=;
        h=In-Reply-To:Cc:Date:References:To:Subject:Message-ID:From;
        b=UJfike5hU+OUASPhqXOXg2XO+coxYD+S30dgzcIw8DiDDmUZIKacEoPus5hCxqS8V
         zDe1+ZlqOjcAkC27qWRohXg/yCdSDCUjnEkJKXN9oj++xGYQn0eSxMWuJM3tVWe1CA
         LKe0WCOYeBq1jr4bBcXTyxHqAFSDJrE0pbiT+BU8=
Authentication-Results: vla1-62318bfe5573.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Content-Type: multipart/mixed; boundary="------------pvK00QZuIngFMzJlcaJw6ZqH"
Message-ID: <6ecb3a57-f552-500f-c853-023f95304bc2@yandex.ru>
Date:   Tue, 13 Dec 2022 09:18:25 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: strange behavior with sigreturn() to 32bit
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, luto@kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
References: <85ca9ae1-d319-ee77-4a71-bc9c7874f2cb@yandex.ru>
 <87zgbsno9y.ffs@tglx>
From:   stsp <stsp2@yandex.ru>
In-Reply-To: <87zgbsno9y.ffs@tglx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------pvK00QZuIngFMzJlcaJw6ZqH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

13.12.2022 05:24, Thomas Gleixner пишет:
> Your observation that running this under GDB changes the behaviour of
> the error is completely correct because BX/SI are subject to context. So
> depending where the combo points to it results in random behaviour.
>
> So nothing strange to see here, really. You got what you asked for:
Thanks for checking, so some problems
were not valid ones, but lets remove the
mov to eax from the test.

Without gdb:
err=0 trapno=d ax=0 ip=100000003

With gdb:
err=18a trapno=d ax=0 ip=403003

Without high RIP poison:
err=18a trapno=d ax=0 ip=3
This case is perfectly valid now, thanks.

Without high RIP poison and with gdb:
err=18a trapno=d ax=0 ip=403003

So under gdb we still see the wrong RIP
value and high RIP part breaks things
only without gdb (gdb "fixes" it).

Attaching the new diff that doesn't do
the mov to eax, so should be correct now.
--------------pvK00QZuIngFMzJlcaJw6ZqH
Content-Type: text/x-patch; charset=UTF-8; name="a.diff"
Content-Disposition: attachment; filename="a.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3g4Ni9zaWdyZXR1cm4uYyBi
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3g4Ni9zaWdyZXR1cm4uYwppbmRleCA1ZDc5NjFh
NWY3ZjYuLjYwNTMyZmQ4MjRlNCAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMveDg2L3NpZ3JldHVybi5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3g4Ni9z
aWdyZXR1cm4uYwpAQCAtMTAxLDkgKzEwMSwxMyBAQCBhc20gKCIucHVzaHNlY3Rpb24gLnRl
eHRcblx0IgogICAgICAibW92ICVzcywlZWN4XG5cdCIKICAgICAgImludDNcblx0IgogICAg
ICAiLnNpemUgaW50MywgLiAtIGludDNcblx0IgorICAgICAiLnR5cGUgaW50MzEsIEBmdW5j
dGlvblxuXHQiCisgICAgICJpbnQzMTpcblx0IgorICAgICAiaW50ICQweDMxXG5cdCIKICAg
ICAgIi5hbGlnbiA0MDk2LCAweGNjXG5cdCIKICAgICAgIi5wb3BzZWN0aW9uIik7CiBleHRl
cm4gY2hhciBpbnQzWzQwOTZdOworZXh0ZXJuIGNoYXIgaW50MzFbXTsKIAogLyoKICAqIEF0
IHN0YXJ0dXAsIHdlIHByZXBhcHJlOgpAQCAtMjk2LDYgKzMwMCw3IEBAIHN0YXRpYyB2b2xh
dGlsZSBzaWdfYXRvbWljX3Qgc2lnX2NvcnJ1cHRfZmluYWxfc3M7CiAjIGRlZmluZSBSRUdf
SVAgUkVHX1JJUAogIyBkZWZpbmUgUkVHX1NQIFJFR19SU1AKICMgZGVmaW5lIFJFR19DWCBS
RUdfUkNYCisjIGRlZmluZSBSRUdfQVggUkVHX1JBWAogCiBzdHJ1Y3Qgc2VsZWN0b3JzIHsK
IAl1bnNpZ25lZCBzaG9ydCBjcywgZ3MsIGZzLCBzczsKQEAgLTMxNiw2ICszMjEsNyBAQCBz
dGF0aWMgdW5zaWduZWQgc2hvcnQgKmNzcHRyKHVjb250ZXh0X3QgKmN0eCkKICMgZGVmaW5l
IFJFR19JUCBSRUdfRUlQCiAjIGRlZmluZSBSRUdfU1AgUkVHX0VTUAogIyBkZWZpbmUgUkVH
X0NYIFJFR19FQ1gKKyMgZGVmaW5lIFJFR19BWCBSRUdfRUFYCiAKIHN0YXRpYyBncmVnX3Qg
KnNzcHRyKHVjb250ZXh0X3QgKmN0eCkKIHsKQEAgLTQ0NCw5ICs0NTAsMTIgQEAgc3RhdGlj
IHZvaWQgc2lndXNyMShpbnQgc2lnLCBzaWdpbmZvX3QgKmluZm8sIHZvaWQgKmN0eF92b2lk
KQogCSpzc3B0cihjdHgpID0gc2lnX3NzOwogCiAJY3R4LT51Y19tY29udGV4dC5ncmVnc1tS
RUdfSVBdID0KLQkJc2lnX2NzID09IGNvZGUxNl9zZWwgPyAwIDogKHVuc2lnbmVkIGxvbmcp
JmludDM7CisJCXNpZ19jcyA9PSBjb2RlMTZfc2VsID8gKCh1bnNpZ25lZCBsb25nKSZpbnQz
MSAtCisJCQkodW5zaWduZWQgbG9uZykmaW50MykgfCAweDEwMDAwMDAwMCA6CisJCSh1bnNp
Z25lZCBsb25nKSZpbnQzOwogCWN0eC0+dWNfbWNvbnRleHQuZ3JlZ3NbUkVHX1NQXSA9ICh1
bnNpZ25lZCBsb25nKTB4OGJhZGYwMGQ1YWFkYzBkZVVMTDsKIAljdHgtPnVjX21jb250ZXh0
LmdyZWdzW1JFR19DWF0gPSAwOworCWN0eC0+dWNfbWNvbnRleHQuZ3JlZ3NbUkVHX0FYXSA9
IDA7CiAKICNpZmRlZiBfX2kzODZfXwogCS8qCkBAIC01MTUsNiArNTI0LDIwIEBAIHN0YXRp
YyB2b2lkIHNpZ3RyYXAoaW50IHNpZywgc2lnaW5mb190ICppbmZvLCB2b2lkICpjdHhfdm9p
ZCkKIAlzaWdfdHJhcHBlZCA9IHNpZzsKIH0KIAorc3RhdGljIHZvaWQgc2lnc2VndihpbnQg
c2lnLCBzaWdpbmZvX3QgKmluZm8sIHZvaWQgKmN0eF92b2lkKQoreworCXVjb250ZXh0X3Qg
KmN0eCA9ICh1Y29udGV4dF90KiljdHhfdm9pZDsKKworCXZhbGlkYXRlX3NpZ25hbF9zcyhz
aWcsIGN0eCk7CisKKwlzaWdfZXJyID0gY3R4LT51Y19tY29udGV4dC5ncmVnc1tSRUdfRVJS
XTsKKwlzaWdfdHJhcG5vID0gY3R4LT51Y19tY29udGV4dC5ncmVnc1tSRUdfVFJBUE5PXTsK
KwlwcmludGYoImVycj0leCB0cmFwbm89JXggYXg9JXggaXA9JWxseFxuIiwgc2lnX2Vyciwg
c2lnX3RyYXBubywKKwkJKHVuc2lnbmVkKWN0eC0+dWNfbWNvbnRleHQuZ3JlZ3NbUkVHX0FY
XSwKKwkJKHVuc2lnbmVkIGxvbmcgbG9uZyljdHgtPnVjX21jb250ZXh0LmdyZWdzW1JFR19J
UF0pOworCV9leGl0KDApOworfQorCiAjaWZkZWYgX194ODZfNjRfXwogLyogVGVzdHMgcmVj
b3ZlcnkgaWYgIVVDX1NUUklDVF9SRVNUT1JFX1NTICovCiBzdGF0aWMgdm9pZCBzaWd1c3Iy
KGludCBzaWcsIHNpZ2luZm9fdCAqaW5mbywgdm9pZCAqY3R4X3ZvaWQpCkBAIC03NzcsNiAr
ODAwLDcgQEAgaW50IG1haW4oKQogCiAJc2V0aGFuZGxlcihTSUdVU1IxLCBzaWd1c3IxLCAw
KTsKIAlzZXRoYW5kbGVyKFNJR1RSQVAsIHNpZ3RyYXAsIFNBX09OU1RBQ0spOworCXNldGhh
bmRsZXIoU0lHU0VHViwgc2lnc2VndiwgU0FfT05TVEFDSyk7CiAKIAkvKiBFYXN5IGNhc2Vz
OiByZXR1cm4gdG8gYSAzMi1iaXQgU1MgaW4gZWFjaCBwb3NzaWJsZSBDUyBiaXRuZXNzLiAq
LwogCXRvdGFsX25lcnJzICs9IHRlc3RfdmFsaWRfc2lncmV0dXJuKDY0LCBmYWxzZSwgLTEp
Owo=

--------------pvK00QZuIngFMzJlcaJw6ZqH--
