Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51751726995
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 21:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbjFGTRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 15:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjFGTRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 15:17:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123C91BF8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 12:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686165403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cZNWBgFagXc/NX64lSZGo0BDhqymiWiaab1rV7vOvEQ=;
        b=gwY+jmP1jUnlPFkTMg0vHw0WYiBVJhBldJCRko2elJA9qsrwAp9BMmeRcsmmFcZtNZ8Q2S
        F3hLGiTiutJ1PZ25QMG2jRcH3+zPmc+zv5dp5DRkolxVCnstn3zeZCdzOFXgQ0kzJl3e4e
        FqC/vlbXz8Q8pWNVbKcwdz9RJnKQN8E=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-2EuyWYTrNDys2-0u1CjtBQ-1; Wed, 07 Jun 2023 15:16:41 -0400
X-MC-Unique: 2EuyWYTrNDys2-0u1CjtBQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-97888ed1982so85819266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 12:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686165400; x=1688757400;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cZNWBgFagXc/NX64lSZGo0BDhqymiWiaab1rV7vOvEQ=;
        b=fYon9xbsSqbk4pVBaQrxWbRlFFgZwYUgl988cbnkryxsEpAFz+oXGy9YcTcSwpWz2r
         tqs/MafArKaEBuJgJUKAkEbmOt8+yDLkOC3CJ/3MgjgpWrIOEZtj8bDnWy/R85r+80hN
         4w0rbmTKpeoE1szC0hwuaYTj4GQMdMfzowdwfEUbskur6wFZeLkYW/UAqiCGzQI1//mv
         OCJn9WsrrJNVXCAJViR4oGlSLwGcw4G6MhiUWgBbYmMWh1MnHLsIzjXowN3LeQhGnT65
         6h/2jMFAxV7hM3yZwczVNKeiiHaK39wt3umCpUDN9dGECyCCVAYGYjAibmS6Gw1Lh67c
         tCoQ==
X-Gm-Message-State: AC+VfDxLdE7iK3uI21hPOpxpIxbcYMbv/NIGUDpmobQH3RRiAkFNjTIu
        TIOfbm9Z1qVyXJfVsfz2sPoMYf2xrg7JJ9Yh4XvVTK/xMRnoaxCbnBlhaIYV1CG70KFt18xJ2qh
        KX3CY5UHp/xtvP4iztcRyOW1W
X-Received: by 2002:a17:907:7e9f:b0:978:6e73:e833 with SMTP id qb31-20020a1709077e9f00b009786e73e833mr7227273ejc.45.1686165400475;
        Wed, 07 Jun 2023 12:16:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7TOrdMfH+uDvM1JCqZARTMzGMSeLSS/8e4tAp59DNw1viAJkLxxdYvH0Eb88FUvnG9o30pYg==
X-Received: by 2002:a17:907:7e9f:b0:978:6e73:e833 with SMTP id qb31-20020a1709077e9f00b009786e73e833mr7227254ejc.45.1686165400121;
        Wed, 07 Jun 2023 12:16:40 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id y11-20020a17090668cb00b00977eb9957e9sm3523793ejr.128.2023.06.07.12.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 12:16:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------vgbUXUgh5jkimy1I05UYkAvz"
Message-ID: <457e2a4a-e28a-cd24-c129-4ff6162ccc36@redhat.com>
Date:   Wed, 7 Jun 2023 21:16:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] platform/x86: dell-laptop: Add drm module soft dependency
To:     Matthew Garrett <mjg59@srcf.ucam.org>,
        AceLan Kao <acelan.kao@canonical.com>
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
References: <20230607034331.576623-1-acelan.kao@canonical.com>
 <20230607042032.GA28835@srcf.ucam.org>
 <CAFv23QmDNUFcPwvSQt5aUxtmHasfr8wrF72ObvcO-X19gfn=LA@mail.gmail.com>
 <20230607052724.GA29834@srcf.ucam.org>
 <CAFv23QkEdGnEz1q7vbyFCa9S9Dqh-zec72nRGyZ3wAz-8wpbvA@mail.gmail.com>
 <20230607062341.GA30618@srcf.ucam.org> <20230607065604.yaivqbbd3dkawxo4@pali>
 <CAFv23Q==r4newMXE3OWavRSRt-bEi5-qR0Vo-5HGLw4r9J36MA@mail.gmail.com>
 <20230607074732.GA31666@srcf.ucam.org>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230607074732.GA31666@srcf.ucam.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------vgbUXUgh5jkimy1I05UYkAvz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/7/23 09:47, Matthew Garrett wrote:
> On Wed, Jun 07, 2023 at 03:39:33PM +0800, AceLan Kao wrote:
> 
>> What do you think if we unregister backlight devices if the backlight type
>> is larger than the current registered one.
>> Do this check in backlight_device_register() and unregister backlight
>> devices by the order raw(1) > platform(2) > firmware(3)
>> And maybe introduce a sticky bit into the backlight device if the backlight
>> driver doesn't want to be removed.
> 
> Hans looked at doing this, but there were some awkward corner cases. 
> When we first introduced this functionality, firmware was preferred to 
> platform was preferred to raw - but on Intel, at least, this behaviour 
> changed with later versions of Windows. I don't think there's a single 
> static policy that works, I think you need to pay attention to the hints 
> the platform gives you. How does Windows know which interface to use on 
> this platform? The simplest solution may actually just be for 
> dell-laptop to refuse to register a backlight if the platform claims to 
> be Windows 8 or later.

I like that idea.

AceLan, I guess that you hit this easy while testing on a (development)
Meteor Lake platform ?

I have had other/similar reports about Meteor Lake platforms.

On hw from the last 10 years dell-laptop will not register
its vendor-type backlight class device because
acpi_video_get_backlight_type() will return acpi_backlight_video
there (1) so it does not matter if the GPU driver shows up only
later (2).

But it seems that on Meteor Lake the ACPI tables will no longer
contain acpi_video backlight control support which causes
acpi_video_get_backlight_type() to return acpi_backlight_vendor (2).
triggering the issue you are seeing.

Can you give the attached patch a try please ?

Regards,

Hans


1) Starting with kernel >= 6.2 acpi_video.c will only register
the /sys/class/backlight/acpi_video# node after a drm/kms drivers
asks it to register it.

2) The native GPU driver will tell the drivers/acpi/video_detect.c
code that native backlight control is available changing
the return of acpi_video_get_backlight_type() to native, which
is what loading the native GPU driver first also fixes this issue.

--------------vgbUXUgh5jkimy1I05UYkAvz
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-ACPI-video-Stop-trying-to-use-vendor-backlight-contr.patch"
Content-Disposition: attachment;
 filename*0="0001-ACPI-video-Stop-trying-to-use-vendor-backlight-contr.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA1OWY0OGE4ZGViNTI1ZDljNzUxM2UyYzBkZmZjN2YzMGE0MzU2MDMwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQu
Y29tPgpEYXRlOiBXZWQsIDcgSnVuIDIwMjMgMjA6MzM6MTIgKzAyMDAKU3ViamVjdDogW1BB
VENIXSBBQ1BJOiB2aWRlbzogU3RvcCB0cnlpbmcgdG8gdXNlIHZlbmRvciBiYWNrbGlnaHQg
Y29udHJvbCBvbgogbGFwdG9wcyBmcm9tIGFmdGVyIH4yMDEyCgpUaGVyZSBoYXZlIGJlZW4g
MiBzZXBhcmF0ZSByZXBvcnRzIG5vdyBhYm91dCBhIG5vbiB3b3JraW5nCiJkZWxsX2JhY2ts
aWdodCIgZGV2aWNlIGdldHRpbmcgcmVnaXN0ZXJlZCB1bmRlciAvc3lzL2NsYXNzL2JhY2ts
aWdodAp3aXRoIE1ldGVvckxha2UgKGRldmVsb3BtZW50KSBwbGF0Zm9ybXMuCgpPbiBodyBm
cm9tIHRoZSBsYXN0IDEwIHllYXJzIGRlbGwtbGFwdG9wIHdpbGwgbm90IHJlZ2lzdGVyICJk
ZWxsX2JhY2tsaWdodCIKYmVjYXVzZSBhY3BpX3ZpZGVvX2dldF9iYWNrbGlnaHRfdHlwZSgp
IHdpbGwgcmV0dXJuIGFjcGlfYmFja2xpZ2h0X3ZpZGVvCnRoZXJlIGlmIGNhbGxlZCBiZWZv
cmUgdGhlIEdQVS9rbXMgZHJpdmVyIGxvYWRzLiBTbyBpdCBkb2VzIG5vdCBtYXR0ZXIgaWYK
dGhlIEdQVSBkcml2ZXIncyBuYXRpdmUgYmFja2xpZ2h0IGdldHMgcmVnaXN0ZXJlZCBhZnRl
ciBkZWxsLWxhcHRvcCBsb2Fkcy4KCkJ1dCBpdCBzZWVtcyB0aGF0IG9uIE1ldGVvciBMYWtl
IHRoZSBBQ1BJIHRhYmxlcyB3aWxsIG5vIGxvbmdlcgpjb250YWluIGFjcGlfdmlkZW8gYmFj
a2xpZ2h0IGNvbnRyb2wgc3VwcG9ydCB3aGljaCBjYXVzZXMKYWNwaV92aWRlb19nZXRfYmFj
a2xpZ2h0X3R5cGUoKSB0byByZXR1cm4gYWNwaV9iYWNrbGlnaHRfdmVuZG9yIGNhdXNpbmcK
ImRlbGxfYmFja2xpZ2h0IiB0byBnZXQgcmVnaXN0ZXJlZCBpZiB0aGUgZGVsbC1sYXB0b3Ag
bW9kdWxlIGlzIGxvYWRlZApiZWZvcmUgdGhlIEdQVS9rbXMgZHJpdmVyLgoKVmVuZG9yIHNw
ZWNpZmljIGJhY2tsaWdodCBjb250cm9sIGxpa2UgdGhlICJkZWxsX2JhY2tsaWdodCIgZGV2
aWNlIGlzCm9ubHkgbmVjZXNzYXJ5IG9uIHF1aXRlIG9sZCBodyAoZnJvbSBiZWZvcmUgYWNw
aV92aWRlbyBiYWNrbGlnaHQgY29udHJvbAp3YXMgaW50cm9kdWNlZCkuIFdvcmsgYXJvdW5k
ICJkZWxsX2JhY2tsaWdodCIgcmVnaXN0ZXJpbmcgb24gdmVyeSBuZXcKaHcgKHdoZXJlIGFj
cGlfdmlkZW8gYmFja2xpZ2h0IGNvbnRyb2wgc2VlbXMgdG8gYmUgbm8gbW9yZSkgYnkgbWFr
aW5nCmFjcGlfdmlkZW9fZ2V0X2JhY2tsaWdodF90eXBlKCkgdXNlIGFjcGlfYmFja2xpZ2h0
X25vbmUgaW5zdGVhZApvZiBhY3BpX2JhY2tsaWdodF92ZW5kb3IgYXMgZmluYWwgZmFsbGJh
Y2sgd2hlbiB0aGUgQUNQSSB0YWJsZXMgaGF2ZQpzdXBwb3J0IGZvciBXaW5kb3dzIDggb3Ig
bGF0ZXIgKGxhcHRvcHMgZnJvbSBhZnRlciB+MjAxMikuCgpTdWdnZXN0ZWQtYnk6IE1hdHRo
ZXcgR2FycmV0dCA8bWpnNTlAc3JjZi51Y2FtLm9yZz4KUmVwb3J0ZWQtYnk6IEFjZUxhbiBL
YW8gPGFjZWxhbi5rYW9AY2Fub25pY2FsLmNvbT4KQ2xvc2VzOiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9wbGF0Zm9ybS1kcml2ZXIteDg2LzIwMjMwNjA3MDM0MzMxLjU3NjYyMy0xLWFj
ZWxhbi5rYW9AY2Fub25pY2FsLmNvbS8KU2lnbmVkLW9mZi1ieTogSGFucyBkZSBHb2VkZSA8
aGRlZ29lZGVAcmVkaGF0LmNvbT4KLS0tCiBkcml2ZXJzL2FjcGkvdmlkZW9fZGV0ZWN0LmMg
fCAyMSArKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL3ZpZGVvX2RldGVjdC5jIGIvZHJp
dmVycy9hY3BpL3ZpZGVvX2RldGVjdC5jCmluZGV4IGI4Nzc4M2M1ODcyZC4uZWIwMTRjMGVi
YTQyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2FjcGkvdmlkZW9fZGV0ZWN0LmMKKysrIGIvZHJp
dmVycy9hY3BpL3ZpZGVvX2RldGVjdC5jCkBAIC04NDQsNiArODQ0LDI3IEBAIGVudW0gYWNw
aV9iYWNrbGlnaHRfdHlwZSBfX2FjcGlfdmlkZW9fZ2V0X2JhY2tsaWdodF90eXBlKGJvb2wg
bmF0aXZlLCBib29sICphdXRvCiAJaWYgKG5hdGl2ZV9hdmFpbGFibGUpCiAJCXJldHVybiBh
Y3BpX2JhY2tsaWdodF9uYXRpdmU7CiAKKwkvKgorCSAqIFRoZSB2ZW5kb3Igc3BlY2lmaWMg
QklPUyBpbnRlcmZhY2VzIGFyZSBvbmx5IG5lY2Vzc2FyeSBmb3IKKwkgKiBsYXB0b3BzIGZy
b20gYmVmb3JlIH4yMDA4LgorCSAqCisJICogRm9yIGxhcHRvcHMgZnJvbSB+MjAwOCB0aWxs
IH4yMDIzIHRoaXMgcG9pbnQgaXMgbmV2ZXIgcmVhY2hlZAorCSAqIGJlY2F1c2Ugb24gdGhv
c2UgKHZpZGVvX2NhcHMgJiBBQ1BJX1ZJREVPX0JBQ0tMSUdIVCkgYWJvdmUgaXMgdHJ1ZS4K
KwkgKgorCSAqIExhcHRvcHMgZnJvbSBhZnRlciB+MjAyMyBubyBsb25nZXIgc3VwcG9ydCBB
Q1BJX1ZJREVPX0JBQ0tMSUdIVCwKKwkgKiBpZiB0aGlzIHBvaW50IGlzIHJlYWNoZWQgb24g
dGhvc2UsIHRoaXMgbGlrZWx5IG1lYW5zIHRoYXQKKwkgKiB0aGUgR1BVIGttcyBkcml2ZXIg
d2hpY2ggc2V0cyBuYXRpdmVfYXZhaWxhYmxlIGhhcyBub3QgbG9hZGVkIHlldC4KKwkgKgor
CSAqIFJldHVybmluZyBhY3BpX2JhY2tsaWdodF92ZW5kb3IgaW4gdGhpcyBjYXNlIGlzIGtu
b3duIHRvIHNvbWV0aW1lcworCSAqIGNhdXNlIGEgbm9uIHdvcmtpbmcgdmVuZG9yIHNwZWNp
ZmljIC9zeXMvY2xhc3MvYmFja2xpZ2h0IGRldmljZSB0bworCSAqIGdldCByZWdpc3RlcmVk
LgorCSAqCisJICogUmV0dXJuIGFjcGlfYmFja2xpZ2h0X25vbmUgb24gbGFwdG9wcyB3aXRo
IEFDUEkgdGFibGVzIHdyaXR0ZW4KKwkgKiBmb3IgV2luZG93cyA4IChsYXB0b3BzIGZyb20g
YWZ0ZXIgfjIwMTIpIHRvIGF2b2lkIHRoaXMgcHJvYmxlbS4KKwkgKi8KKwlpZiAoYWNwaV9v
c2lfaXNfd2luOCgpKQorCQlyZXR1cm4gYWNwaV9iYWNrbGlnaHRfbm9uZTsKKwogCS8qIE5v
IEFDUEkgdmlkZW8vbmF0aXZlIChvbGQgaHcpLCB1c2UgdmVuZG9yIHNwZWNpZmljIGZ3IG1l
dGhvZHMuICovCiAJcmV0dXJuIGFjcGlfYmFja2xpZ2h0X3ZlbmRvcjsKIH0KLS0gCjIuNDAu
MQoK

--------------vgbUXUgh5jkimy1I05UYkAvz--

