Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D3164E8EE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 10:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiLPJyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 04:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiLPJxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 04:53:48 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC79950D79;
        Fri, 16 Dec 2022 01:53:41 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 2D56D1C000D;
        Fri, 16 Dec 2022 09:53:37 +0000 (UTC)
Message-ID: <8f00ae9463b07fbd789af3840cd59a9e99caff34.camel@hadess.net>
Subject: Re: [PATCH] hid: Support for Litra Glow
From:   Bastien Nocera <hadess@hadess.net>
To:     Andreas Bergmeier <abergmeier@gmx.net>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 16 Dec 2022 10:53:37 +0100
In-Reply-To: <9fca69c7-cc24-63d0-98f6-80c28fc69a5@9300>
References: <9fca69c7-cc24-63d0-98f6-80c28fc69a5@9300>
Content-Type: multipart/mixed; boundary="=-Sr8f35irKMU9aZI4Whjo"
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-Sr8f35irKMU9aZI4Whjo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2022-12-15 at 22:09 +0100, Andreas Bergmeier wrote:
> Tries to implement as general support for Illumination Light as
> possible. Note that it is singular, which means by Logitech spec we
> are
> fine off with just handling one capability/device.

Your email client absolutely trashed the patch's indentation, it's
unreadable as-is.

> Implementation currently only exposes Brightness and On/Off controls.
> Does currently not expose Color Temperature because LEDs does not
> support it.
>=20
> Introduces HIDPP_QUIRK_CLASS_SIMPLE_START to prevent reconnect on
> startup. Could not get Glow to work with that.

I'd really rather we didn't introduce a new quirk, but instead fixed
the fact that we need to restart the HID transport to support 3 (!)
devices.

Would something like the attached patch work? I haven't tested it yet,
but if it works for you, I'll test it on the devices I have here.

Cheers

--=-Sr8f35irKMU9aZI4Whjo
Content-Disposition: attachment;
	filename*0=0001-HID-logitech-hidpp-Don-t-restart-communication-if-no.pat;
	filename*1=ch
Content-Type: text/x-patch;
	name="0001-HID-logitech-hidpp-Don-t-restart-communication-if-no.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSBlZDY2NmIwMjk4MzZiNjVjODJmNjFiN2EyMTE3YzJjMTQ0ZTJiZTVkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBCYXN0aWVuIE5vY2VyYSA8aGFkZXNzQGhhZGVzcy5uZXQ+CkRh
dGU6IEZyaSwgMTYgRGVjIDIwMjIgMTA6NDE6MTYgKzAxMDAKU3ViamVjdDogW1BBVENIXSBISUQ6
IGxvZ2l0ZWNoLWhpZHBwOiBEb24ndCByZXN0YXJ0IGNvbW11bmljYXRpb24gaWYgbm90CiBuZWNl
c3NhcnkKCkRvbid0IHN0b3AgYW5kIHJlc3RhcnQgY29tbXVuaWNhdGlvbiB3aXRoIHRoZSBkZXZp
Y2UgdW5sZXNzIHdlIG5lZWQgdG8KbW9kaWZ5IHRoZSBjb25uZWN0IGZsYWdzIHVzZWQgYmVjYXVz
ZSBvZiBhIGRldmljZSBxdWlyay4KLS0tCiBkcml2ZXJzL2hpZC9oaWQtbG9naXRlY2gtaGlkcHAu
YyB8IDMwICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE4
IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaGlk
L2hpZC1sb2dpdGVjaC1oaWRwcC5jIGIvZHJpdmVycy9oaWQvaGlkLWxvZ2l0ZWNoLWhpZHBwLmMK
aW5kZXggN2Y5MTg3MjAxOTEzLi4wNTUzMmVkZmEwMWEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaGlk
L2hpZC1sb2dpdGVjaC1oaWRwcC5jCisrKyBiL2RyaXZlcnMvaGlkL2hpZC1sb2dpdGVjaC1oaWRw
cC5jCkBAIC00MzEwLDYgKzQzMTAsNyBAQCBzdGF0aWMgaW50IGhpZHBwX3Byb2JlKHN0cnVjdCBo
aWRfZGV2aWNlICpoZGV2LCBjb25zdCBzdHJ1Y3QgaGlkX2RldmljZV9pZCAqaWQpCiAJYm9vbCBj
b25uZWN0ZWQ7CiAJdW5zaWduZWQgaW50IGNvbm5lY3RfbWFzayA9IEhJRF9DT05ORUNUX0RFRkFV
TFQ7CiAJc3RydWN0IGhpZHBwX2ZmX3ByaXZhdGVfZGF0YSBkYXRhOworCWJvb2wgd2lsbF9yZXN0
YXJ0ID0gZmFsc2U7CiAKIAkvKiByZXBvcnRfZml4dXAgbmVlZHMgZHJ2ZGF0YSB0byBiZSBzZXQg
YmVmb3JlIHdlIGNhbGwgaGlkX3BhcnNlICovCiAJaGlkcHAgPSBkZXZtX2t6YWxsb2MoJmhkZXYt
PmRldiwgc2l6ZW9mKCpoaWRwcCksIEdGUF9LRVJORUwpOwpAQCAtNDM2MCw2ICs0MzYxLDkgQEAg
c3RhdGljIGludCBoaWRwcF9wcm9iZShzdHJ1Y3QgaGlkX2RldmljZSAqaGRldiwgY29uc3Qgc3Ry
dWN0IGhpZF9kZXZpY2VfaWQgKmlkKQogCQkJcmV0dXJuIHJldDsKIAl9CiAKKwlpZiAoaGlkcHAt
PnF1aXJrcyAmIEhJRFBQX1FVSVJLX0RFTEFZRURfSU5JVCkKKwkJd2lsbF9yZXN0YXJ0ID0gdHJ1
ZTsKKwogCUlOSVRfV09SSygmaGlkcHAtPndvcmssIGRlbGF5ZWRfd29ya19jYik7CiAJbXV0ZXhf
aW5pdCgmaGlkcHAtPnNlbmRfbXV0ZXgpOwogCWluaXRfd2FpdHF1ZXVlX2hlYWQoJmhpZHBwLT53
YWl0KTsKQEAgLTQzNzQsNyArNDM3OCw3IEBAIHN0YXRpYyBpbnQgaGlkcHBfcHJvYmUoc3RydWN0
IGhpZF9kZXZpY2UgKmhkZXYsIGNvbnN0IHN0cnVjdCBoaWRfZGV2aWNlX2lkICppZCkKIAkgKiBQ
bGFpbiBVU0IgY29ubmVjdGlvbnMgbmVlZCB0byBhY3R1YWxseSBjYWxsIHN0YXJ0IGFuZCBvcGVu
CiAJICogb24gdGhlIHRyYW5zcG9ydCBkcml2ZXIgdG8gYWxsb3cgaW5jb21pbmcgZGF0YS4KIAkg
Ki8KLQlyZXQgPSBoaWRfaHdfc3RhcnQoaGRldiwgMCk7CisJcmV0ID0gaGlkX2h3X3N0YXJ0KGhk
ZXYsIHdpbGxfcmVzdGFydCA/IDAgOiBjb25uZWN0X21hc2spOwogCWlmIChyZXQpIHsKIAkJaGlk
X2VycihoZGV2LCAiaHcgc3RhcnQgZmFpbGVkXG4iKTsKIAkJZ290byBoaWRfaHdfc3RhcnRfZmFp
bDsKQEAgLTQ0MjUsMTkgKzQ0MjksMjEgQEAgc3RhdGljIGludCBoaWRwcF9wcm9iZShzdHJ1Y3Qg
aGlkX2RldmljZSAqaGRldiwgY29uc3Qgc3RydWN0IGhpZF9kZXZpY2VfaWQgKmlkKQogCiAJaGlk
cHBfY29ubmVjdF9ldmVudChoaWRwcCk7CiAKLQkvKiBSZXNldCB0aGUgSElEIG5vZGUgc3RhdGUg
Ki8KLQloaWRfZGV2aWNlX2lvX3N0b3AoaGRldik7Ci0JaGlkX2h3X2Nsb3NlKGhkZXYpOwotCWhp
ZF9od19zdG9wKGhkZXYpOworCWlmICh3aWxsX3Jlc3RhcnQpIHsKKwkJLyogUmVzZXQgdGhlIEhJ
RCBub2RlIHN0YXRlICovCisJCWhpZF9kZXZpY2VfaW9fc3RvcChoZGV2KTsKKwkJaGlkX2h3X2Ns
b3NlKGhkZXYpOworCQloaWRfaHdfc3RvcChoZGV2KTsKIAotCWlmIChoaWRwcC0+cXVpcmtzICYg
SElEUFBfUVVJUktfTk9fSElESU5QVVQpCi0JCWNvbm5lY3RfbWFzayAmPSB+SElEX0NPTk5FQ1Rf
SElESU5QVVQ7CisJCWlmIChoaWRwcC0+cXVpcmtzICYgSElEUFBfUVVJUktfTk9fSElESU5QVVQp
CisJCQljb25uZWN0X21hc2sgJj0gfkhJRF9DT05ORUNUX0hJRElOUFVUOwogCi0JLyogTm93IGV4
cG9ydCB0aGUgYWN0dWFsIGlucHV0cyBhbmQgaGlkcmF3IG5vZGVzIHRvIHRoZSB3b3JsZCAqLwot
CXJldCA9IGhpZF9od19zdGFydChoZGV2LCBjb25uZWN0X21hc2spOwotCWlmIChyZXQpIHsKLQkJ
aGlkX2VycihoZGV2LCAiJXM6aGlkX2h3X3N0YXJ0IHJldHVybmVkIGVycm9yXG4iLCBfX2Z1bmNf
Xyk7Ci0JCWdvdG8gaGlkX2h3X3N0YXJ0X2ZhaWw7CisJCS8qIE5vdyBleHBvcnQgdGhlIGFjdHVh
bCBpbnB1dHMgYW5kIGhpZHJhdyBub2RlcyB0byB0aGUgd29ybGQgKi8KKwkJcmV0ID0gaGlkX2h3
X3N0YXJ0KGhkZXYsIGNvbm5lY3RfbWFzayk7CisJCWlmIChyZXQpIHsKKwkJCWhpZF9lcnIoaGRl
diwgIiVzOmhpZF9od19zdGFydCByZXR1cm5lZCBlcnJvclxuIiwgX19mdW5jX18pOworCQkJZ290
byBoaWRfaHdfc3RhcnRfZmFpbDsKKwkJfQogCX0KIAogCWlmIChoaWRwcC0+cXVpcmtzICYgSElE
UFBfUVVJUktfQ0xBU1NfRzkyMCkgewotLSAKMi4zOC4xCgo=


--=-Sr8f35irKMU9aZI4Whjo--
