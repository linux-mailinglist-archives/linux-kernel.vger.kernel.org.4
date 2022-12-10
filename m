Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD51648DD9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 10:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiLJJPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 04:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiLJJO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 04:14:56 -0500
X-Greylist: delayed 337 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 10 Dec 2022 01:14:05 PST
Received: from forward106p.mail.yandex.net (forward106p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210162710;
        Sat, 10 Dec 2022 01:14:04 -0800 (PST)
Received: from sas8-d2832c3b6ed7.qloud-c.yandex.net (sas8-d2832c3b6ed7.qloud-c.yandex.net [IPv6:2a02:6b8:c1b:2a09:0:640:d283:2c3b])
        by forward106p.mail.yandex.net (Yandex) with ESMTP id 813A32FC21E3;
        Sat, 10 Dec 2022 12:08:23 +0300 (MSK)
Received: by sas8-d2832c3b6ed7.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id L8X4Vd8YGa61-pBBFfpeV;
        Sat, 10 Dec 2022 12:08:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1670663303;
        bh=qfTbbs5wGTfTJ4tPkL8vGo/Ec4Ffv9XAZVjHA8GXlwI=;
        h=Subject:Cc:To:Message-ID:Date:From;
        b=izWNDftH4f8HIlVhxqcGt4kQv0R/ZDeF8uG7RA5jsQwq9DbfOVXZjJYWfl134YGAp
         O6BGpN90yQGlSPOJ4CglIq9bmx0KHr/aN2zXV5QYm9oXPQrNGefe3rszRXx4fImjHq
         m7KJJlTwAtTt4h2sa4LjJ3cN0ZwPU30FrMHNDXCg=
Authentication-Results: sas8-d2832c3b6ed7.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Content-Type: multipart/mixed; boundary="------------qW63JCDkk7b99GaKgpIQ2H7J"
Message-ID: <85ca9ae1-d319-ee77-4a71-bc9c7874f2cb@yandex.ru>
Date:   Sat, 10 Dec 2022 14:08:21 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     linux-x86_64@vger.kernel.org, luto@kernel.org
From:   stsp <stsp2@yandex.ru>
Subject: strange behavior with sigreturn() to 32bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------qW63JCDkk7b99GaKgpIQ2H7J
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

I am playing with 32bit compatibility segments,
and I am observing something very strange.
To demonstrate the problem, I did the change
to the kernel sigreturn test-case, and it is attached.
The change just moves the magic value to EAX
and calls an interrupt that produces a SIGSEGV.
The SIGSEGV handler prints the needed regs.
This patch intentionally adds 0x100000000 to
the RIP register, because AFAIK the high part
or 64bit regs are irrelevant in compatibility mode.
Now with high part of RIP non-zero, we see this:
$ ./sigreturn_64
err=0 trapno=d ax=0 ip=100000003

OK, obviously our asm code didn't execute -
why is so? How does the high part of RIP
affect compatibility mode?
Then lets start the same example under gdb:
Program received signal SIGSEGV, Segmentation fault.
0x0000000000403008 in int31 ()
(gdb)
Continuing.
err=18a trapno=d ax=a5f3 ip=403008

Wow! Much better now: error code is correct,
ax is correct, but ip is invalid.

Now lets remove that high-part trashing from
source and recompile, then run again:
$ ./sigreturn_64
err=0 trapno=d ax=a5f3 ip=6

This time error code is incorrect! All other
values are good.
Lets see under gdb:
err=18a trapno=d ax=a5f3 ip=403008

Cool, under gdb the err code fixed itself but
IP is wrong...

Can anyone make any sense out of this? :)
To me it seems completely chaotic and I
suspect both sigreturn() and ptrace() are
somehow "broken" here.

--------------qW63JCDkk7b99GaKgpIQ2H7J
Content-Type: text/x-patch; charset=UTF-8; name="a.diff"
Content-Disposition: attachment; filename="a.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3g4Ni9zaWdyZXR1cm4uYyBi
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3g4Ni9zaWdyZXR1cm4uYwppbmRleCA1ZDc5NjFh
NWY3ZjYuLjZjOGYyNDMxZDc3ZCAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMveDg2L3NpZ3JldHVybi5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3g4Ni9z
aWdyZXR1cm4uYwpAQCAtMTAxLDkgKzEwMSwxNCBAQCBhc20gKCIucHVzaHNlY3Rpb24gLnRl
eHRcblx0IgogICAgICAibW92ICVzcywlZWN4XG5cdCIKICAgICAgImludDNcblx0IgogICAg
ICAiLnNpemUgaW50MywgLiAtIGludDNcblx0IgorICAgICAiLnR5cGUgaW50MzEsIEBmdW5j
dGlvblxuXHQiCisgICAgICJpbnQzMTpcblx0IgorICAgICAibW92bCAkMHhhNWYzLCAlZWF4
XG5cdCIKKyAgICAgImludCAkMHgzMVxuXHQiCiAgICAgICIuYWxpZ24gNDA5NiwgMHhjY1xu
XHQiCiAgICAgICIucG9wc2VjdGlvbiIpOwogZXh0ZXJuIGNoYXIgaW50M1s0MDk2XTsKK2V4
dGVybiBjaGFyIGludDMxW107CiAKIC8qCiAgKiBBdCBzdGFydHVwLCB3ZSBwcmVwYXByZToK
QEAgLTI5Niw2ICszMDEsNyBAQCBzdGF0aWMgdm9sYXRpbGUgc2lnX2F0b21pY190IHNpZ19j
b3JydXB0X2ZpbmFsX3NzOwogIyBkZWZpbmUgUkVHX0lQIFJFR19SSVAKICMgZGVmaW5lIFJF
R19TUCBSRUdfUlNQCiAjIGRlZmluZSBSRUdfQ1ggUkVHX1JDWAorIyBkZWZpbmUgUkVHX0FY
IFJFR19SQVgKIAogc3RydWN0IHNlbGVjdG9ycyB7CiAJdW5zaWduZWQgc2hvcnQgY3MsIGdz
LCBmcywgc3M7CkBAIC0zMTYsNiArMzIyLDcgQEAgc3RhdGljIHVuc2lnbmVkIHNob3J0ICpj
c3B0cih1Y29udGV4dF90ICpjdHgpCiAjIGRlZmluZSBSRUdfSVAgUkVHX0VJUAogIyBkZWZp
bmUgUkVHX1NQIFJFR19FU1AKICMgZGVmaW5lIFJFR19DWCBSRUdfRUNYCisjIGRlZmluZSBS
RUdfQVggUkVHX0VBWAogCiBzdGF0aWMgZ3JlZ190ICpzc3B0cih1Y29udGV4dF90ICpjdHgp
CiB7CkBAIC00NDQsOSArNDUxLDEyIEBAIHN0YXRpYyB2b2lkIHNpZ3VzcjEoaW50IHNpZywg
c2lnaW5mb190ICppbmZvLCB2b2lkICpjdHhfdm9pZCkKIAkqc3NwdHIoY3R4KSA9IHNpZ19z
czsKIAogCWN0eC0+dWNfbWNvbnRleHQuZ3JlZ3NbUkVHX0lQXSA9Ci0JCXNpZ19jcyA9PSBj
b2RlMTZfc2VsID8gMCA6ICh1bnNpZ25lZCBsb25nKSZpbnQzOworCQlzaWdfY3MgPT0gY29k
ZTE2X3NlbCA/ICgodW5zaWduZWQgbG9uZykmaW50MzEgLQorCQkJKHVuc2lnbmVkIGxvbmcp
JmludDMpIHwgMHgxMDAwMDAwMDAgOgorCQkodW5zaWduZWQgbG9uZykmaW50MzsKIAljdHgt
PnVjX21jb250ZXh0LmdyZWdzW1JFR19TUF0gPSAodW5zaWduZWQgbG9uZykweDhiYWRmMDBk
NWFhZGMwZGVVTEw7CiAJY3R4LT51Y19tY29udGV4dC5ncmVnc1tSRUdfQ1hdID0gMDsKKwlj
dHgtPnVjX21jb250ZXh0LmdyZWdzW1JFR19BWF0gPSAwOwogCiAjaWZkZWYgX19pMzg2X18K
IAkvKgpAQCAtNTE1LDYgKzUyNSwyMCBAQCBzdGF0aWMgdm9pZCBzaWd0cmFwKGludCBzaWcs
IHNpZ2luZm9fdCAqaW5mbywgdm9pZCAqY3R4X3ZvaWQpCiAJc2lnX3RyYXBwZWQgPSBzaWc7
CiB9CiAKK3N0YXRpYyB2b2lkIHNpZ3NlZ3YoaW50IHNpZywgc2lnaW5mb190ICppbmZvLCB2
b2lkICpjdHhfdm9pZCkKK3sKKwl1Y29udGV4dF90ICpjdHggPSAodWNvbnRleHRfdCopY3R4
X3ZvaWQ7CisKKwl2YWxpZGF0ZV9zaWduYWxfc3Moc2lnLCBjdHgpOworCisJc2lnX2VyciA9
IGN0eC0+dWNfbWNvbnRleHQuZ3JlZ3NbUkVHX0VSUl07CisJc2lnX3RyYXBubyA9IGN0eC0+
dWNfbWNvbnRleHQuZ3JlZ3NbUkVHX1RSQVBOT107CisJcHJpbnRmKCJlcnI9JXggdHJhcG5v
PSV4IGF4PSV4IGlwPSVsbHhcbiIsIHNpZ19lcnIsIHNpZ190cmFwbm8sCisJCSh1bnNpZ25l
ZCljdHgtPnVjX21jb250ZXh0LmdyZWdzW1JFR19BWF0sCisJCSh1bnNpZ25lZCBsb25nIGxv
bmcpY3R4LT51Y19tY29udGV4dC5ncmVnc1tSRUdfSVBdKTsKKwlfZXhpdCgwKTsKK30KKwog
I2lmZGVmIF9feDg2XzY0X18KIC8qIFRlc3RzIHJlY292ZXJ5IGlmICFVQ19TVFJJQ1RfUkVT
VE9SRV9TUyAqLwogc3RhdGljIHZvaWQgc2lndXNyMihpbnQgc2lnLCBzaWdpbmZvX3QgKmlu
Zm8sIHZvaWQgKmN0eF92b2lkKQpAQCAtNzc3LDYgKzgwMSw3IEBAIGludCBtYWluKCkKIAog
CXNldGhhbmRsZXIoU0lHVVNSMSwgc2lndXNyMSwgMCk7CiAJc2V0aGFuZGxlcihTSUdUUkFQ
LCBzaWd0cmFwLCBTQV9PTlNUQUNLKTsKKwlzZXRoYW5kbGVyKFNJR1NFR1YsIHNpZ3NlZ3Ys
IFNBX09OU1RBQ0spOwogCiAJLyogRWFzeSBjYXNlczogcmV0dXJuIHRvIGEgMzItYml0IFNT
IGluIGVhY2ggcG9zc2libGUgQ1MgYml0bmVzcy4gKi8KIAl0b3RhbF9uZXJycyArPSB0ZXN0
X3ZhbGlkX3NpZ3JldHVybig2NCwgZmFsc2UsIC0xKTsK

--------------qW63JCDkk7b99GaKgpIQ2H7J--
