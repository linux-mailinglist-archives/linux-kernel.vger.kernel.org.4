Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4183367A016
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbjAXRYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjAXRYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:24:16 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C874402FD
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:24:15 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id v127so17134280vsb.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YpHopE2ZPOxbhd78MKx6My/SyU6gg1nJCvHGtO4kRJ0=;
        b=dft5SOzhAdOiwh0GEt4UMrIANEnHSFvkqGOXxRvmV64KB9t7imcdz8WvnLPflsnAsz
         CwwNfy7URBWJryFH22WZYz88yd/VAgsW7WM5ERkPmwOdSXV/lj+dQmaYBQ0X7knaqrt9
         wPA2UIxmyEDk49ib5qUh8FPv4czQ2cxT6kvMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YpHopE2ZPOxbhd78MKx6My/SyU6gg1nJCvHGtO4kRJ0=;
        b=bp7HufF7nAxkbS9UPcpP4HkNTwYk1ZNMJuGhPgiIaZc9fdCMbjuJhyXEZwd1EoPDVL
         yY9vsQXCTZHVlqjwksWV9US1oaIqr1BI+CO4ZqZ2eKMtuuO/NNzXwBBpAenuoa96cuS5
         V1dOtaG+KDUJz8tS53Nki+4RUs01UxIDkGTAp+QoNrCb69BP1ve2/9PY2oJbWjNBfjJG
         PwUT9z2S9MX4ZmX4JzZTW9vvx8cIkLkgJkwtLGxqHrsF0nN5vEOhgJjoXicQWTa4PBAi
         oADNspkU4smYFlmFhA1lyHhfrVmG78S2iMz8YB+fx9lErI+L8K/iiW1/4cnSIyyklkA2
         3rwA==
X-Gm-Message-State: AFqh2koRpSrz3XELlhGxG1kSytZ7rQt4l06ehxM4ApFl3bf4K4pDinLA
        MXDWMdsTca72R/PVk/CV7EIkDEolsZNreMj3
X-Google-Smtp-Source: AMrXdXtAxHXQxZFBEC1Hbi6gCLmYYjKgnBcDQmdf5OwoeqEWhbaJCpoMEtjWafa+x+m6bNm9V714Jw==
X-Received: by 2002:a05:6102:f98:b0:3d3:f012:c8b6 with SMTP id e24-20020a0561020f9800b003d3f012c8b6mr20084580vsv.25.1674581053927;
        Tue, 24 Jan 2023 09:24:13 -0800 (PST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com. [209.85.219.54])
        by smtp.gmail.com with ESMTPSA id k6-20020a05620a0b8600b00705b4001fbasm1704816qkh.128.2023.01.24.09.24.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 09:24:13 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id w15so1411610qvs.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:24:13 -0800 (PST)
X-Received: by 2002:a05:6214:5504:b0:535:2538:c972 with SMTP id
 mb4-20020a056214550400b005352538c972mr1495160qvb.43.1674581052894; Tue, 24
 Jan 2023 09:24:12 -0800 (PST)
MIME-Version: 1.0
References: <20230124134131.637036-1-sashal@kernel.org> <20230124134131.637036-35-sashal@kernel.org>
 <CAHk-=wjZmzuHP10Trg_7EBnix4mFLfODPM+FsZz0Jjj+YAFDeg@mail.gmail.com>
In-Reply-To: <CAHk-=wjZmzuHP10Trg_7EBnix4mFLfODPM+FsZz0Jjj+YAFDeg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Jan 2023 09:23:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi5GPS3poC_YRy93X38AqkvsFENAviMXHWjgOgo5k7p3g@mail.gmail.com>
Message-ID: <CAHk-=wi5GPS3poC_YRy93X38AqkvsFENAviMXHWjgOgo5k7p3g@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.1 35/35] ext4: deal with legacy signed xattr
 name hash values
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Andreas Dilger <adilger@dilger.ca>,
        "Theodore Ts'o" <tytso@mit.edu>, Jason Donenfeld <Jason@zx2c4.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000ce80af05f305c800"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000ce80af05f305c800
Content-Type: text/plain; charset="UTF-8"

On Tue, Jan 24, 2023 at 8:50 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This patch does not work correctly without '-funsigned-char', and I
> don't think that has been back-ported to stable kernels.
>
> That said, the patch *almost* works.

So I'm  not convinced this should be back-ported at all, but it's
certainly true that going back and forth between the two cases would
be problematic.

Maybe the right thing to do would be for me to just do that explicit
'unsigned char' even in kernels that don't need it, and also add a
'pr_warn_once()' to make people aware of this case if it ever happens
outside of the xfstests.

So a more complete patch might be something like the attached (which
also changes the polarity of the signed hash test, in order to make
the pr_warn_once() simpler).

            Linus

--000000000000ce80af05f305c800
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ldaib7gp0>
X-Attachment-Id: f_ldaib7gp0

IGZzL2V4dDQveGF0dHIuYyB8IDExICsrKysrKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNl
cnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL2V4dDQveGF0dHIuYyBi
L2ZzL2V4dDQveGF0dHIuYwppbmRleCA2OWExYjhjNmEyZWMuLmEyZjA0YTM4MDhkYiAxMDA2NDQK
LS0tIGEvZnMvZXh0NC94YXR0ci5jCisrKyBiL2ZzL2V4dDQveGF0dHIuYwpAQCAtNDgyLDExICs0
ODIsMTIgQEAgZXh0NF94YXR0cl9pbm9kZV92ZXJpZnlfaGFzaGVzKHN0cnVjdCBpbm9kZSAqZWFf
aW5vZGUsCiAJCSAqLwogCQllX2hhc2ggPSBleHQ0X3hhdHRyX2hhc2hfZW50cnlfc2lnbmVkKGVu
dHJ5LT5lX25hbWUsIGVudHJ5LT5lX25hbWVfbGVuLAogCQkJCQkJCSZ0bXBfZGF0YSwgMSk7Ci0J
CWlmIChlX2hhc2ggPT0gZW50cnktPmVfaGFzaCkKLQkJCXJldHVybiAwOwotCiAJCS8qIFN0aWxs
IG5vIG1hdGNoIC0gYmFkICovCi0JCXJldHVybiAtRUZTQ09SUlVQVEVEOworCQlpZiAoZV9oYXNo
ICE9IGVudHJ5LT5lX2hhc2gpCisJCQlyZXR1cm4gLUVGU0NPUlJVUFRFRDsKKworCQkvKiBMZXQg
cGVvcGxlIGtub3cgYWJvdXQgb2xkIGhhc2ggKi8KKwkJcHJfd2Fybl9vbmNlKCJleHQ0OiBmaWxl
c3lzdGVtIHdpdGggc2lnbmVkIHhhdHRyIG5hbWUgaGFzaCIpOwogCX0KIAlyZXR1cm4gMDsKIH0K
QEAgLTMwOTYsNyArMzA5Nyw3IEBAIHN0YXRpYyBfX2xlMzIgZXh0NF94YXR0cl9oYXNoX2VudHJ5
KGNoYXIgKm5hbWUsIHNpemVfdCBuYW1lX2xlbiwgX19sZTMyICp2YWx1ZSwKIAl3aGlsZSAobmFt
ZV9sZW4tLSkgewogCQloYXNoID0gKGhhc2ggPDwgTkFNRV9IQVNIX1NISUZUKSBeCiAJCSAgICAg
ICAoaGFzaCA+PiAoOCpzaXplb2YoaGFzaCkgLSBOQU1FX0hBU0hfU0hJRlQpKSBeCi0JCSAgICAg
ICAqbmFtZSsrOworCQkgICAgICAgKHVuc2lnbmVkIGNoYXIpKm5hbWUrKzsKIAl9CiAJd2hpbGUg
KHZhbHVlX2NvdW50LS0pIHsKIAkJaGFzaCA9IChoYXNoIDw8IFZBTFVFX0hBU0hfU0hJRlQpIF4K
--000000000000ce80af05f305c800--
