Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358AE6471C3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 15:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiLHO1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 09:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiLHO1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 09:27:05 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC22A9D2DB
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 06:26:31 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id bj12so4384985ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 06:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WG+56Z3TVRrxEPIxBZiy2gX7tIWbzFIIdfT6FtjtWvE=;
        b=WN2X7CswpsMtAuwkX7IDc11VxiQWqLC1ZToC4WYuBAB4CDX8WU/zAucKuooMNbPsB5
         34Gf9TJHTnOJoYAnlnZJtg2MQ+WWzBEg5v1GW3au1T+iYFjxpQypq7caW7EHvv7u3Vj3
         hN1KdAwezCLIF7m6lQy88uPs65cRtdJ/UR+aQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WG+56Z3TVRrxEPIxBZiy2gX7tIWbzFIIdfT6FtjtWvE=;
        b=J5z7If/KVsjkait9moRJ8CLVeLoXVUwgVTZFIvglDraW+oT9Q62AfHlTboVcmuVPn2
         IQhxa7HkWWBIpld4aZ4IuV6ZK7ef4Z0h/XyO42us91BGAfcQXINbcbxwB0Vlo66ho2Aj
         IAd171y0CEf5M28CMHg9mH2NfWVV596bcmcP4GtsSLGAY3Vw1mxPLfM+GIzmUlY1Unin
         878xU3FWmzQeO6EJk3b3x8Bar7RVwzbIa/fu0V8JqBCIyB1v2bUqkWYL7KvRod1E8Avp
         zY7qPLbcrK6TscDnpxSTkebGjHUiGri4ZT1e0RkqjUqF3AvXIE9Ra8hSHTDF0E/XcoRo
         8MLA==
X-Gm-Message-State: ANoB5pkxO0d6hlmNyVJywz3PtpgLxWUlUCNahun8kV4efMkDuQFD6+gh
        514uNAU4985OP9patNb/7RG+68M87MQCXoXWSzgMWQ==
X-Google-Smtp-Source: AA0mqf5sfaHaY+BCTcrTCFTAFsmwUqjwfOvqcwRtbf8YqXUa5OfvxzoV7Ii9iRxmWeI5egYjc7gpVCvKt8jB5qnByuk=
X-Received: by 2002:a17:906:3ad6:b0:7ae:40b7:7fbe with SMTP id
 z22-20020a1709063ad600b007ae40b77fbemr76760198ejd.371.1670509590418; Thu, 08
 Dec 2022 06:26:30 -0800 (PST)
MIME-Version: 1.0
References: <CAJfpegvrd2nsydG26stcmeEkdO1JLyeu69KrZs4dvVxXtoz42Q@mail.gmail.com>
 <20221114160209.1229849-1-tycho@tycho.pizza> <Y4TNI8+QVHFuzeZC@tycho.pizza>
In-Reply-To: <Y4TNI8+QVHFuzeZC@tycho.pizza>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 8 Dec 2022 15:26:19 +0100
Message-ID: <CAJfpegtckCReg7V6ET4a8EW_X-WfmANQdc4hP26bV9zoRrk7Wg@mail.gmail.com>
Subject: Re: [PATCH v3] fuse: In fuse_flush only wait if someone wants the
 return code
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        "Serge E . Hallyn" <serge@hallyn.com>
Content-Type: multipart/mixed; boundary="000000000000bb56bc05ef51d27b"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000bb56bc05ef51d27b
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Nov 2022 at 16:01, Tycho Andersen <tycho@tycho.pizza> wrote:
>
> Hi Milkos,
>
> On Mon, Nov 14, 2022 at 09:02:09AM -0700, Tycho Andersen wrote:
> > v3: use schedule_work() to avoid other sleeps in inode_write_now() and
> >     fuse_sync_writes(). Fix a UAF of the stack-based inarg.
>
> Thoughts on this version?

Skipping attr invalidation on success is wrong.  And there's still too
much duplication, IMO.

How about the attached (untested) patch?

Thanks,
Miklos

--000000000000bb56bc05ef51d27b
Content-Type: text/x-patch; charset="US-ASCII"; name="fuse-flush-async-if-exiting.patch"
Content-Disposition: attachment; 
	filename="fuse-flush-async-if-exiting.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lbf676tf0>
X-Attachment-Id: f_lbf676tf0

LS0tCiBmcy9mdXNlL2ZpbGUuYyB8ICAgODkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNjMgaW5zZXJ0aW9u
cygrKSwgMjYgZGVsZXRpb25zKC0pCgotLS0gYS9mcy9mdXNlL2ZpbGUuYworKysgYi9mcy9mdXNl
L2ZpbGUuYwpAQCAtMTgsNiArMTgsNyBAQAogI2luY2x1ZGUgPGxpbnV4L2ZhbGxvYy5oPgogI2lu
Y2x1ZGUgPGxpbnV4L3Vpby5oPgogI2luY2x1ZGUgPGxpbnV4L2ZzLmg+CisjaW5jbHVkZSA8bGlu
dXgvZmlsZS5oPgogCiBzdGF0aWMgaW50IGZ1c2Vfc2VuZF9vcGVuKHN0cnVjdCBmdXNlX21vdW50
ICpmbSwgdTY0IG5vZGVpZCwKIAkJCSAgdW5zaWduZWQgaW50IG9wZW5fZmxhZ3MsIGludCBvcGNv
ZGUsCkBAIC00NzcsNDggKzQ3OCwzNiBAQCBzdGF0aWMgdm9pZCBmdXNlX3N5bmNfd3JpdGVzKHN0
cnVjdCBpbm9kCiAJZnVzZV9yZWxlYXNlX25vd3JpdGUoaW5vZGUpOwogfQogCi1zdGF0aWMgaW50
IGZ1c2VfZmx1c2goc3RydWN0IGZpbGUgKmZpbGUsIGZsX293bmVyX3QgaWQpCi17Ci0Jc3RydWN0
IGlub2RlICppbm9kZSA9IGZpbGVfaW5vZGUoZmlsZSk7Ci0Jc3RydWN0IGZ1c2VfbW91bnQgKmZt
ID0gZ2V0X2Z1c2VfbW91bnQoaW5vZGUpOwotCXN0cnVjdCBmdXNlX2ZpbGUgKmZmID0gZmlsZS0+
cHJpdmF0ZV9kYXRhOworc3RydWN0IGZ1c2VfZmx1c2hfYXJncyB7CisJc3RydWN0IGZ1c2VfYXJn
cyBhcmdzOwogCXN0cnVjdCBmdXNlX2ZsdXNoX2luIGluYXJnOwotCUZVU0VfQVJHUyhhcmdzKTsK
LQlpbnQgZXJyOwotCi0JaWYgKGZ1c2VfaXNfYmFkKGlub2RlKSkKLQkJcmV0dXJuIC1FSU87CisJ
c3RydWN0IHdvcmtfc3RydWN0IHdvcms7CisJc3RydWN0IGZpbGUgKmZpbGU7Cit9OwogCi0JaWYg
KGZmLT5vcGVuX2ZsYWdzICYgRk9QRU5fTk9GTFVTSCAmJiAhZm0tPmZjLT53cml0ZWJhY2tfY2Fj
aGUpCi0JCXJldHVybiAwOworc3RhdGljIGludCBmdXNlX2RvX2ZsdXNoKHN0cnVjdCBmdXNlX2Zs
dXNoX2FyZ3MgKmZhKQoreworCWludCBlcnI7CisJc3RydWN0IGlub2RlICppbm9kZSA9IGZpbGVf
aW5vZGUoZmEtPmZpbGUpOworCXN0cnVjdCBmdXNlX21vdW50ICpmbSA9IGdldF9mdXNlX21vdW50
KGlub2RlKTsKIAogCWVyciA9IHdyaXRlX2lub2RlX25vdyhpbm9kZSwgMSk7CiAJaWYgKGVycikK
LQkJcmV0dXJuIGVycjsKKwkJZ290byBvdXQ7CiAKIAlpbm9kZV9sb2NrKGlub2RlKTsKIAlmdXNl
X3N5bmNfd3JpdGVzKGlub2RlKTsKIAlpbm9kZV91bmxvY2soaW5vZGUpOwogCi0JZXJyID0gZmls
ZW1hcF9jaGVja19lcnJvcnMoZmlsZS0+Zl9tYXBwaW5nKTsKKwllcnIgPSBmaWxlbWFwX2NoZWNr
X2Vycm9ycyhmYS0+ZmlsZS0+Zl9tYXBwaW5nKTsKIAlpZiAoZXJyKQotCQlyZXR1cm4gZXJyOwor
CQlnb3RvIG91dDsKIAogCWVyciA9IDA7CiAJaWYgKGZtLT5mYy0+bm9fZmx1c2gpCiAJCWdvdG8g
aW52YWxfYXR0cl9vdXQ7CiAKLQltZW1zZXQoJmluYXJnLCAwLCBzaXplb2YoaW5hcmcpKTsKLQlp
bmFyZy5maCA9IGZmLT5maDsKLQlpbmFyZy5sb2NrX293bmVyID0gZnVzZV9sb2NrX293bmVyX2lk
KGZtLT5mYywgaWQpOwotCWFyZ3Mub3Bjb2RlID0gRlVTRV9GTFVTSDsKLQlhcmdzLm5vZGVpZCA9
IGdldF9ub2RlX2lkKGlub2RlKTsKLQlhcmdzLmluX251bWFyZ3MgPSAxOwotCWFyZ3MuaW5fYXJn
c1swXS5zaXplID0gc2l6ZW9mKGluYXJnKTsKLQlhcmdzLmluX2FyZ3NbMF0udmFsdWUgPSAmaW5h
cmc7Ci0JYXJncy5mb3JjZSA9IHRydWU7Ci0KLQllcnIgPSBmdXNlX3NpbXBsZV9yZXF1ZXN0KGZt
LCAmYXJncyk7CisJZXJyID0gZnVzZV9zaW1wbGVfcmVxdWVzdChmbSwgJmZhLT5hcmdzKTsKIAlp
ZiAoZXJyID09IC1FTk9TWVMpIHsKIAkJZm0tPmZjLT5ub19mbHVzaCA9IDE7CiAJCWVyciA9IDA7
CkBAIC01MzEsOSArNTIwLDU3IEBAIHN0YXRpYyBpbnQgZnVzZV9mbHVzaChzdHJ1Y3QgZmlsZSAq
ZmlsZSwKIAkgKi8KIAlpZiAoIWVyciAmJiBmbS0+ZmMtPndyaXRlYmFja19jYWNoZSkKIAkJZnVz
ZV9pbnZhbGlkYXRlX2F0dHJfbWFzayhpbm9kZSwgU1RBVFhfQkxPQ0tTKTsKKworb3V0OgorCWZw
dXQoZmEtPmZpbGUpOworCWtmcmVlKGZhKTsKIAlyZXR1cm4gZXJyOwogfQogCitzdGF0aWMgdm9p
ZCBmdXNlX2ZsdXNoX2FzeW5jKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKK3sKKwlzdHJ1Y3Qg
ZnVzZV9mbHVzaF9hcmdzICpmYSA9IGNvbnRhaW5lcl9vZih3b3JrLCB0eXBlb2YoKmZhKSwgd29y
ayk7CisKKwlmdXNlX2RvX2ZsdXNoKGZhKTsKK30KKworc3RhdGljIGludCBmdXNlX2ZsdXNoKHN0
cnVjdCBmaWxlICpmaWxlLCBmbF9vd25lcl90IGlkKQoreworCXN0cnVjdCBmdXNlX2ZsdXNoX2Fy
Z3MgKmZhOworCXN0cnVjdCBpbm9kZSAqaW5vZGUgPSBmaWxlX2lub2RlKGZpbGUpOworCXN0cnVj
dCBmdXNlX21vdW50ICpmbSA9IGdldF9mdXNlX21vdW50KGlub2RlKTsKKwlzdHJ1Y3QgZnVzZV9m
aWxlICpmZiA9IGZpbGUtPnByaXZhdGVfZGF0YTsKKworCWlmIChmdXNlX2lzX2JhZChpbm9kZSkp
CisJCXJldHVybiAtRUlPOworCisJaWYgKGZmLT5vcGVuX2ZsYWdzICYgRk9QRU5fTk9GTFVTSCAm
JiAhZm0tPmZjLT53cml0ZWJhY2tfY2FjaGUpCisJCXJldHVybiAwOworCisJZmEgPSBremFsbG9j
KHNpemVvZigqZmEpLCBHRlBfS0VSTkVMKTsKKwlpZiAoIWZhKQorCQlyZXR1cm4gLUVOT01FTTsK
KworCWZhLT5pbmFyZy5maCA9IGZmLT5maDsKKwlmYS0+aW5hcmcubG9ja19vd25lciA9IGZ1c2Vf
bG9ja19vd25lcl9pZChmbS0+ZmMsIGlkKTsKKwlmYS0+YXJncy5vcGNvZGUgPSBGVVNFX0ZMVVNI
OworCWZhLT5hcmdzLm5vZGVpZCA9IGdldF9ub2RlX2lkKGlub2RlKTsKKwlmYS0+YXJncy5pbl9u
dW1hcmdzID0gMTsKKwlmYS0+YXJncy5pbl9hcmdzWzBdLnNpemUgPSBzaXplb2YoZmEtPmluYXJn
KTsKKwlmYS0+YXJncy5pbl9hcmdzWzBdLnZhbHVlID0gJmZhLT5pbmFyZzsKKwlmYS0+YXJncy5m
b3JjZSA9IHRydWU7CisJZmEtPmZpbGUgPSBnZXRfZmlsZShmaWxlKTsKKworCS8qIERvbid0IHdh
aXQgaWYgdGhlIHRhc2sgaXMgZXhpdGluZyAqLworCWlmIChjdXJyZW50LT5mbGFncyAmIFBGX0VY
SVRJTkcpIHsKKwkJSU5JVF9XT1JLKCZmYS0+d29yaywgZnVzZV9mbHVzaF9hc3luYyk7CisJCXNj
aGVkdWxlX3dvcmsoJmZhLT53b3JrKTsKKwkJcmV0dXJuIDA7CisJfQorCisJcmV0dXJuIGZ1c2Vf
ZG9fZmx1c2goZmEpOworfQorCiBpbnQgZnVzZV9mc3luY19jb21tb24oc3RydWN0IGZpbGUgKmZp
bGUsIGxvZmZfdCBzdGFydCwgbG9mZl90IGVuZCwKIAkJICAgICAgaW50IGRhdGFzeW5jLCBpbnQg
b3Bjb2RlKQogewo=
--000000000000bb56bc05ef51d27b--
