Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7726A2CA8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 01:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjBYX4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 18:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBYX4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 18:56:19 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C172812F3F
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 15:56:18 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id p20so2036340plw.13
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 15:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tDKprFvgNc5twSfIIDLl4/nq5YN7YTD1AuisIZ9iJYo=;
        b=fTEVxRdSyC8ILa4ISRU4IH47tyaCnGNd/N7Kg0MK5nDsNnN6AJwNv1trv3blJmN/PV
         DN9m7qanxvVRKip2jH/AntyrxqTCWoWIKLNIS931v/5yG4n7iDEezxswxUMdaVqRJuJF
         57Dp0tRW0oJg9kZTcf/BHXeEaO2MQASYCgZKiTsfezO9VzK/0hWyWmFaKAKQzVh+WUaN
         q0P648WqkNmjuQg4DbQocktE0+GcSz0CLRCXJzuqo60Kov1rF8e3mi8hioWNbyiwBZUL
         TAt+we/vThgN0ZnzWZSoMzLxyjs74rPGb9h3N6m4agvY0WB4oEJVkj3ga/WZtLDIhNWp
         eq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDKprFvgNc5twSfIIDLl4/nq5YN7YTD1AuisIZ9iJYo=;
        b=dRWSzRdxr+ekQmsY4PhIw6h+ueRbYdSjqPikPIAGuWhe+BNIPnAxcKZCor21WVWMlY
         BLp5TfUV5OoaFj9FKY1h3YWiXSYjOlEB0oXgC41rv2SCYncPa94KQLgUdY20mzV6bP6d
         +KE2cpFvXqcT7w/gsJGQt9NCol9LPkMLLoNLFPnrjg2xcfn2eM/ZEttoNyBX1p5HNg6M
         FpQj6TBbZbH2mFXvc7S30VN3E4AT2v55VrKGnANS4mcAUBCGH3orKUGKhdY6++u73AsU
         JAU6DnLcCZqgD60HNM7nleRcUY3voLibXfbwCxoWxRoSKQXMM/oKmQYcmJjuk9/pBjS8
         yXmg==
X-Gm-Message-State: AO0yUKUPvX4lNHGAvycEIrAEm/iV5JKrcPB3X6eke+XvKjNvlu5ZKukI
        7mIAlcQPU8MU8M4WVsBfeq3MFSm8HMBnrhhfgtfWrA==
X-Google-Smtp-Source: AK7set/oZ6Qfje9fztilgFUqPO/dtjuFinittroi95mUhKzFm0Vn3y1pWAMBfrIhxpq1zSVnJVUNQWtcSz4SWziHH98=
X-Received: by 2002:a17:90a:d258:b0:234:1887:b46d with SMTP id
 o24-20020a17090ad25800b002341887b46dmr3077608pjw.8.1677369377750; Sat, 25 Feb
 2023 15:56:17 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdamxDX6EBVjKX5=D3rkHp17f5pwGdBVhzFU90-0MHY6dQ@mail.gmail.com>
In-Reply-To: <CACRpkdamxDX6EBVjKX5=D3rkHp17f5pwGdBVhzFU90-0MHY6dQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Sat, 25 Feb 2023 15:55:39 -0800
Message-ID: <CAGETcx-Ws4zZJ-KWoOLM6ELpyM6pWh7cfRWaYB1zrtTn5sov+w@mail.gmail.com>
Subject: Re: Regression in probing some AMBA devices possibly devlink related
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: multipart/mixed; boundary="000000000000ebfbab05f58efdcb"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000ebfbab05f58efdcb
Content-Type: text/plain; charset="UTF-8"

On Sat, Feb 25, 2023 at 6:29 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Hi Saravana,
>
> I have a boot regression for Ux500 on mainline, but bisecting mainline
> isn't quite working for misc reasons :/
>
> I'm not sure about this regression, but it smells like devlink-related.
>
> Ux500 have a bunch of normal and some AMBA devices. After
> boot this happens and we hang waiting for rootfs (which is on eMMC):

Hmmm... my recent changes were definitely tested on systems with AMBA
devices and it worked.

> [   31.849586] amba 80126000.mmc: deferred probe pending
> [   31.854801] amba 80118000.mmc: deferred probe pending
> [   31.859895] amba 80005000.mmc: deferred probe pending
> [   31.870297] amba 80120000.uart: deferred probe pending
> [   31.875472] amba 80121000.uart: deferred probe pending
> [   31.880689] amba 80004000.i2c: deferred probe pending
> [   31.885799] amba 80128000.i2c: deferred probe pending
> [   31.890932] amba 80110000.i2c: deferred probe pending
> [   51.688361] vmem_3v3: disabling

What does /debug/devices_deferred say about these? That should tell us
exactly what's blocking it.

Also if you convert all the pr_debug and dev_dbg in
drivers/base/core.c that should give us enough of an idea of what's
happening. Can you do that too and send it as an attachment (I logs
are hard to read when they get word wrapped)?

> The last regulator (vmem_3v3) is something the eMMC that didn't
> probe was supposed to use.
>
> All the failing drivers are AMBA PrimeCell devices:
> drivers/mmc/host/mmci.c
> drivers/tty/serial/amba-pl011.c
> drivers/i2c/busses/i2c-nomadik.c
>
> This makes me suspect something was done for ordinary (platform)
> devices that didn't happen for AMBA devices?
>
> This is the main portion of the device tree containing these
> devices and their resources:
> arch/arm/boot/dts/ste-dbx5x0.dtsi

I'll take a closer look on Monday. Btw, I always prefer the dts file
because there's always some property that adds a dependency and that
might be the clue to whatever is broken. But I'll take a look at this.

It's unlikely the patch attached might fix it, but can you give it a shot?

-Saravana

--000000000000ebfbab05f58efdcb
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-add-class-support-to-device-links.patch"
Content-Disposition: attachment; 
	filename="0001-add-class-support-to-device-links.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lekmdy6k0>
X-Attachment-Id: f_lekmdy6k0

RnJvbSA1Y2M3NGRiNjgxNTVjOGViM2UxNGI2ZDU0ODk1ZjRmYzExMzkwZGNlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYXJhdmFuYSBLYW5uYW4gPHNhcmF2YW5ha0Bnb29nbGUuY29t
PgpEYXRlOiBNb24sIDEzIEZlYiAyMDIzIDEzOjQwOjQzIC0wODAwClN1YmplY3Q6IFtQQVRDSF0g
YWRkIGNsYXNzIHN1cHBvcnQgdG8gZGV2aWNlIGxpbmtzCgpTaWduZWQtb2ZmLWJ5OiBTYXJhdmFu
YSBLYW5uYW4gPHNhcmF2YW5ha0Bnb29nbGUuY29tPgotLS0KIGRyaXZlcnMvYmFzZS9jb3JlLmMg
fCAxOCArKysrKysrKysrKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9iYXNlL2NvcmUuYyBiL2RyaXZl
cnMvYmFzZS9jb3JlLmMKaW5kZXggYWJjNmZkMjg2OGE1Li5hM2NjNTE2ZGMyNmIgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvYmFzZS9jb3JlLmMKKysrIGIvZHJpdmVycy9iYXNlL2NvcmUuYwpAQCAtMTM5
Myw3ICsxMzkzLDE1IEBAIHZvaWQgZGV2aWNlX2xpbmtzX2RyaXZlcl9ib3VuZChzdHJ1Y3QgZGV2
aWNlICpkZXYpCiAJCQljb250aW51ZTsKIAogCQlXQVJOX09OKGxpbmstPnN0YXR1cyAhPSBETF9T
VEFURV9ET1JNQU5UKTsKLQkJV1JJVEVfT05DRShsaW5rLT5zdGF0dXMsIERMX1NUQVRFX0FWQUlM
QUJMRSk7CisKKwkJLyoKKwkJICogQSAiY2xhc3MiIGRldmljZSBkb2Vzbid0IHJlYWxseSBwcm9i
ZS4gQ29uc2lkZXIgdGhlIGxpbmsgYXMKKwkJICogYWN0aXZlIGFzIHNvb24gYXMgdGhlIHN1cHBs
aWVyIHByb2Jlcy4KKwkJICovCisJCWlmIChsaW5rLT5jb25zdW1lci0+Y2xhc3MpCisJCQlXUklU
RV9PTkNFKGxpbmstPnN0YXR1cywgRExfU1RBVEVfQUNUSVZFKTsKKwkJZWxzZQorCQkJV1JJVEVf
T05DRShsaW5rLT5zdGF0dXMsIERMX1NUQVRFX0FWQUlMQUJMRSk7CiAKIAkJaWYgKGxpbmstPmZs
YWdzICYgRExfRkxBR19BVVRPUFJPQkVfQ09OU1VNRVIpCiAJCQlkcml2ZXJfZGVmZXJyZWRfcHJv
YmVfYWRkKGxpbmstPmNvbnN1bWVyKTsKQEAgLTM1OTksNiArMzYwNywxNCBAQCBpbnQgZGV2aWNl
X2FkZChzdHJ1Y3QgZGV2aWNlICpkZXYpCiAJCWRldnRtcGZzX2NyZWF0ZV9ub2RlKGRldik7CiAJ
fQogCisJLyoKKwkgKiBPbmNlIGEgZGV2aWNlIGlzIGFkZGVkIHRvIGEgY2xhc3MsIGNvbnNpZGVy
IGl0IGFzIGJvdW5kIHRvIGEgZHJpdmVyCisJICogZnJvbSBhIGRldmljZSBsaW5rcyBwZXJzcGVj
dGl2ZS4gVGhpcyB3YXksIHdlIHdvdWxkbid0IGJsb2NrIGFueQorCSAqIGNvbnN1bWVycyBvZiB0
aGlzIGRldmljZSBmcm9tIHByb2JpbmcuCisJICovCisJaWYgKGRldi0+Y2xhc3MpCisJCWRldi0+
bGlua3Muc3RhdHVzID0gRExfREVWX0RSSVZFUl9CT1VORDsKKwogCS8qIE5vdGlmeSBjbGllbnRz
IG9mIGRldmljZSBhZGRpdGlvbi4gIFRoaXMgY2FsbCBtdXN0IGNvbWUKIAkgKiBhZnRlciBkcG1f
c3lzZnNfYWRkKCkgYW5kIGJlZm9yZSBrb2JqZWN0X3VldmVudCgpLgogCSAqLwotLSAKMi4zOS4y
LjYzNy5nMjFiMDY3OGQxOS1nb29nCgo=
--000000000000ebfbab05f58efdcb--
