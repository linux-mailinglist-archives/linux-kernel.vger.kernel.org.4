Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1769D70AC0F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 04:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjEUCmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 22:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjEUCay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 22:30:54 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730CAE65
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 19:29:57 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-39212bf4ff0so2648557b6e.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 19:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684636197; x=1687228197;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WtEMOf3JrCKveF6lyb32kc2FMByQBRiQoupkRUHjn5A=;
        b=jejF8OW77xDHTTAeJGTsN+MDijfZQRXQsTjwEWrKN7NcoOnsKCwXAeTr+/n5uwEKGb
         JGqnjQJZVyAR02wKjxZAnrKAAywqdnND034dtIoQR0tMlz6+Tdupk8Ds338DSNplsGCQ
         xpSeVXkLdeyslFJqoN7FH5jOszyunHqv4jLBqaBz7lLjHLz0NCpKO5NqwYLzcx7o+r8t
         VBV5I2W+ao8bvGRPTV4HuGQCpuU4yBnWr2B4x4JrfqrrJNppB3tcmDozc9Pqj5zD2rU/
         nGCdD0iEBuXCEg9gmtisl1ceWTki8H5WXAIDhT9aFu15hq48X1f5MbOvC++WS0y23oHl
         1XUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684636197; x=1687228197;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WtEMOf3JrCKveF6lyb32kc2FMByQBRiQoupkRUHjn5A=;
        b=VfG1m67bK+DJ5leFKMzyWJSyyPW8Z033yDj363f8ptrFF2xNKZKVOERILZbUA4IKGV
         z6NzRETsjKcDvYla6qM/VNpMXK1PJjnNcJTKqOdMntj3+jEKt5Eny368MKbJ52/XfkHP
         8R2fwm+gNli/ZNZHkBvcgo8eSuYvDUAK8LBdbAE2RMSVFoYvKMgDr33UQBsE6ObyKFRE
         IzDY1ESFM+gDaH6qBoPIe9ddHzagfh4W6A9pEtWTDvynavqTrAmBRw7IhPOD/YnkDesn
         cwePztpLwcwGS2MQJyLtfJq3HO2ZteIWwVljvG0TymwrRN9vUZ5+T1sowJMp9TPKLW2v
         Ma8g==
X-Gm-Message-State: AC+VfDxtbo5xNTvpeNKyKMfCPkGqStGRrBYlSHhODFPdmh5xhOwgrb8b
        ix4M7u571Hqi7/x6zmMN0JQC1w5dZsAWvK1q0Qo=
X-Google-Smtp-Source: ACHHUZ7ZnQq/Ov5JR/S8smKExRfMUC/X2ZJTSlRTAkXP6a7k/6qIij8atCyYr0EH9S9ksj7WbYewYqyrEW4tFniVL7c=
X-Received: by 2002:a54:4196:0:b0:397:fa01:cd4 with SMTP id
 22-20020a544196000000b00397fa010cd4mr380591oiy.34.1684636196499; Sat, 20 May
 2023 19:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAJwHY9WVvV1aN-Wa5OnUrr_yvcD+RK+ykDgqpffKaOPvzXLiTg@mail.gmail.com>
 <a2feaf97-b9e4-4318-86e7-e7a654794f78@xianwang.io> <87a5xzz3lf.wl-tiwai@suse.de>
 <CAJwHY9WGRCdbb=vrbY1UwdiJ3mb28tk2S69i89CiPMJyHQa0=Q@mail.gmail.com> <CAJwHY9WgpL8KajHAS3Xb1=A=J5_Accm76p4W89j+K+wRjN7zQQ@mail.gmail.com>
In-Reply-To: <CAJwHY9WgpL8KajHAS3Xb1=A=J5_Accm76p4W89j+K+wRjN7zQQ@mail.gmail.com>
From:   Adam Stylinski <kungfujesus06@gmail.com>
Date:   Sat, 20 May 2023 22:29:45 -0400
Message-ID: <CAJwHY9VXeGEvvR8qL+DEB6anfR6ePW864UKftVStH0Wj_Das1g@mail.gmail.com>
Subject: Re: ca0132 patches
To:     Takashi Iwai <tiwai@suse.de>, perex@perex.cz
Cc:     linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000011af6105fc2aee21"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000011af6105fc2aee21
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, mutt's being insane uncooperative.  Here's the format-patch attached=
.

On Sat, May 20, 2023 at 11:21=E2=80=AFAM Adam Stylinski <kungfujesus06@gmai=
l.com> wrote:
>
> Mutt + SMTP + Gmail are acting up and I had to head out. I'll get this se=
nt out tonight, though. Did you want me to cc the mailing list too?
>
> On Sat, May 20, 2023, 10:27 AM Adam Stylinski <kungfujesus06@gmail.com> w=
rote:
>>
>> Correct.  A format-patch output is coming soon, I'm just waiting for a
>> proper clone to finish.
>>
>> On Sat, May 20, 2023 at 6:42=E2=80=AFAM Takashi Iwai <tiwai@suse.de> wro=
te:
>> >
>> > On Fri, 19 May 2023 05:53:09 +0200,
>> > Xian Wang wrote:
>> > >
>> > > On 18/05/2023 20:02, Adam Stylinski wrote:
>> > > > Hello,
>> > > >
>> > > > I noticed you patched in a quirk in basically the same place I am =
for
>> > > > a different EVGA board.  This quirk is needed for me as well but i=
t
>> > > > would seem the bugzilla and mailing lists are ignored.  I was hopi=
ng
>> > > > maybe I could draw your attention to this?
>> > > >
>> > > > https://bugzilla.kernel.org/show_bug.cgi?id=3D67071
>> > > >
>> > > > I suffer a similar issue (namely surround is disabled without enab=
ling
>> > > > this quirk).  I still have some temperamental behavior with the qu=
irk
>> > > > in place (the port mapping doesn't always seem consistent boot to
>> > > > boot, often needing several reboots before all channels are workin=
g).
>> > > > I'm not certain if this is a quirk of loading the firmware or what=
.
>> > > > At the very least, not having to patch this locally every kernel
>> > > > update would be nice.  I'm CC'ing the maintainer who signed off on=
 the
>> > > > patch as well, really hoping to get some attention on this.
>> > >
>> > > Hi Adam,
>> > >
>> > > Unfortunately I haven't experienced the flakiness of surround sound
>> > > mentioned in the bug. The channel mapping seems correct and is
>> > > consistent from boot to boot.
>> > >
>> > > For not patching locally every time there is a new kernel, are you
>> > > open to submit that one-line patch up?
>> >
>> > So you need only the addition of
>> >   SND_PCI_QUIRK(0x3842, 0x104b, "EVGA X299 Dark", QUIRK_R3DI)
>> > ?
>> >
>> > If so, I can submit a oneliner from my side, too.  But it's still
>> > better to be submitted from the person who actually tested the patch,
>> > of course.
>> >
>> >
>> > Takashi

--00000000000011af6105fc2aee21
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-ALSA-hda-ca0132-add-quirk-for-EVGA-X299-DARK.patch"
Content-Disposition: attachment; 
	filename="0001-ALSA-hda-ca0132-add-quirk-for-EVGA-X299-DARK.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lhwsut6l0>
X-Attachment-Id: f_lhwsut6l0

RnJvbSBmZDFmZjFhZmYzYTcwNzE2YjRkNmQ5OWE4OTkzNGFlYTVkNzE4Y2FkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBZGFtIFN0eWxpbnNraSA8a3VuZ2Z1amVzdXMwNkBnbWFpbC5j
b20+CkRhdGU6IFNhdCwgMjAgTWF5IDIwMjMgMTA6MzE6NTQgLTA0MDAKU3ViamVjdDogW1BBVENI
XSBBTFNBOiBoZGEvY2EwMTMyOiBhZGQgcXVpcmsgZm9yIEVWR0EgWDI5OSBEQVJLCgpUaGlzIHF1
aXJrIGlzIG5lY2Vzc2FyeSBmb3Igc3Vycm91bmQgYW5kIG90aGVyIERTUCBlZmZlY3RzIHRvIHdv
cmsKd2l0aCB0aGUgb25ib2FyZCBjYTAxMzIgYmFzZWQgYXVkaW8gY2hpcHNldCBmb3IgdGhlIEVW
R0EgWDI5OSBkYXJrCm1haW5ib2FyZC4KClNpZ25lZC1vZmYtYnk6IEFkYW0gU3R5bGluc2tpIDxr
dW5nZnVqZXN1czA2QGdtYWlsLmNvbT4KCi0tLQogc291bmQvcGNpL2hkYS9wYXRjaF9jYTAxMzIu
YyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvc291
bmQvcGNpL2hkYS9wYXRjaF9jYTAxMzIuYyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfY2EwMTMyLmMK
aW5kZXggMDk5NzIyZWJhZWQ4Li43NDhhM2M0MDk2NmUgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9o
ZGEvcGF0Y2hfY2EwMTMyLmMKKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9jYTAxMzIuYwpAQCAt
MTMwNiw2ICsxMzA2LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBzbmRfcGNpX3F1aXJrIGNhMDEz
Ml9xdWlya3NbXSA9IHsKIAlTTkRfUENJX1FVSVJLKDB4MTQ1OCwgMHhBMDI2LCAiR2lnYWJ5dGUg
RzEuU25pcGVyIFo5NyIsIFFVSVJLX1IzREkpLAogCVNORF9QQ0lfUVVJUksoMHgxNDU4LCAweEEw
MzYsICJHaWdhYnl0ZSBHQS1aMTcwWC1HYW1pbmcgNyIsIFFVSVJLX1IzREkpLAogCVNORF9QQ0lf
UVVJUksoMHgzODQyLCAweDEwMzgsICJFVkdBIFg5OSBDbGFzc2lmaWVkIiwgUVVJUktfUjNESSks
CisJU05EX1BDSV9RVUlSSygweDM4NDIsIDB4MTA0YiwgIkVWR0EgWDI5OSBEYXJrIiwgUVVJUktf
UjNESSksCiAJU05EX1BDSV9RVUlSSygweDM4NDIsIDB4MTA1NSwgIkVWR0EgWjM5MCBEQVJLIiwg
UVVJUktfUjNESSksCiAJU05EX1BDSV9RVUlSSygweDExMDIsIDB4MDAxMywgIlJlY29uM0QiLCBR
VUlSS19SM0QpLAogCVNORF9QQ0lfUVVJUksoMHgxMTAyLCAweDAwMTgsICJSZWNvbjNEIiwgUVVJ
UktfUjNEKSwKLS0gCjIuNDAuMQoK
--00000000000011af6105fc2aee21--
