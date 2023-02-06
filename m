Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325BE68C579
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 19:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjBFSNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 13:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjBFSND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 13:13:03 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F49CDFC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 10:13:02 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id i38so1520232eda.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 10:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IbOerbB6Db4L6+uUF0dvyyeN+e3XbuhovaEigXR7JOo=;
        b=A/jcSkWXsSowAd58l8d13+VgQh9TsgzUaVo1nJSFX9naivnf9Yd6haYjw8kHzBe1z7
         UneVQ0rvM32DeaHE8jor/GQ3SBcTjQgik8aNzLu+itYqZmBvqop8MxyjkmB7XKB3zriR
         tCY2xJ6smzX7/eu07fFHqYc+xZ6Gf7IZQCw4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IbOerbB6Db4L6+uUF0dvyyeN+e3XbuhovaEigXR7JOo=;
        b=dMezRtRerblnaOAhPnAwEFk2AWlNOJEFvP884Y+maEtmwtTbsfmdk0rhfUvwjqX0hb
         4JqTZT9bTPJaihiE5aa8nM8i6UN3yBUWe/04QcYjlawuQvSlP1NyXA02pilBqP6OUVBo
         YQSlGlU3enEGJqk4CzY3tLVhOFeTgH6nqTNvIisarfDyCI5aKN/+WTaKk7+YpWFmUbDF
         2yeqT1iHXUS3wyygB2PTFXmRlb3Hs07nwbwMRvqQHNCJgm73zn3CddLnIoOBKCtgDdDp
         mFtlvwwsiVri7jrSigjTc6p5zdIB3eVu7Ok9Lkgouww4AYJSS3wgUeV6r60Xc0620I60
         G7kg==
X-Gm-Message-State: AO0yUKUFIxIK/65O5LXafZ05nuw89niH5H94hCQlNqk0k0VoAoWHx0sh
        Boqy1+zuXuE45mXS629PYMiqY2ClYkHWYlU6ijvcnw==
X-Google-Smtp-Source: AK7set9mE0Qlfe1xNNFa91Q9D2X5pDgitKr2icgw7U+B2rA2XENx3CgpOicMYxEWarJwpapPlGhfwg==
X-Received: by 2002:a50:8757:0:b0:4aa:a76a:c428 with SMTP id 23-20020a508757000000b004aaa76ac428mr561321edv.6.1675707180863;
        Mon, 06 Feb 2023 10:13:00 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id w16-20020a05640234d000b0046267f8150csm5366363edc.19.2023.02.06.10.13.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 10:13:00 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id e22so7348300ejb.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 10:13:00 -0800 (PST)
X-Received: by 2002:a17:906:4e46:b0:87a:7098:ca09 with SMTP id
 g6-20020a1709064e4600b0087a7098ca09mr69422ejw.78.1675707179872; Mon, 06 Feb
 2023 10:12:59 -0800 (PST)
MIME-Version: 1.0
References: <1675704844-17228-1-git-send-email-george.kennedy@oracle.com>
In-Reply-To: <1675704844-17228-1-git-send-email-george.kennedy@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Feb 2023 10:12:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi5h32VBgzYgFy8KoXbcDMa9K_ihDjfxD-iScy7L+M=QQ@mail.gmail.com>
Message-ID: <CAHk-=wi5h32VBgzYgFy8KoXbcDMa9K_ihDjfxD-iScy7L+M=QQ@mail.gmail.com>
Subject: Re: [PATCH] vc_screen: break from vcs_read() while loop if vcs_vc()
 returns NULL
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.cz, sfr@canb.auug.org.au,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000346cf405f40bfb2d"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000346cf405f40bfb2d
Content-Type: text/plain; charset="UTF-8"

On Mon, Feb 6, 2023 at 9:34 AM George Kennedy <george.kennedy@oracle.com> wrote:
>
>
> -               ret = -ENXIO;
>                 vc = vcs_vc(inode, &viewed);
> -               if (!vc)
> +               if (!vc) {
> +                       if (read)
> +                               break;
> +                       ret = -ENXIO;
>                         goto unlock_out;
> +               }

That works, but the whole "if (read)" thing is already done after the
loop, so instead of essentially duplicating that logic, I really think
the patch should be just a plain

                vc = vcs_vc(inode, &viewed);
                if (!vc)
-                       goto unlock_out;
+                       break;

and nothing else.

And yes, the pre-existing vcs_size() error handling has that same ugly pattern.

It might be worth cleaning up too, although right now that

                size = vcs_size(vc, attr, uni_mode);
                if (size < 0) {
                        if (read)
                                break;

pattern means that if we 'break' there, 'read' is non-zero, so 'ret'
doesn't matter. Which is also ugly, but works.

I *think* it could all be rewritten to just use 'break' everywhere in
the loop, and make 'ret' handling be saner.

Something like the attached patch, but while I tried to think about
it, I didn't spend a lot of effort on it, and I certainly didn't test
it. So I'm sending this out as a "Hmm. This _looks_ better to me, but
whatever" patch.

               Linus

--000000000000346cf405f40bfb2d
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ldt4rzjr0>
X-Attachment-Id: f_ldt4rzjr0

IGRyaXZlcnMvdHR5L3Z0L3ZjX3NjcmVlbi5jIHwgMTQgKysrKysrLS0tLS0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy90dHkvdnQvdmNfc2NyZWVuLmMgYi9kcml2ZXJzL3R0eS92dC92Y19zY3JlZW4uYwppbmRl
eCBmNTY2ZWIxODM5ZGMuLmM1OTliNDUyOTY5ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvdnQv
dmNfc2NyZWVuLmMKKysrIGIvZHJpdmVycy90dHkvdnQvdmNfc2NyZWVuLmMKQEAgLTQwNiwxOSAr
NDA2LDE3IEBAIHZjc19yZWFkKHN0cnVjdCBmaWxlICpmaWxlLCBjaGFyIF9fdXNlciAqYnVmLCBz
aXplX3QgY291bnQsIGxvZmZfdCAqcHBvcykKIAkJcmV0ID0gLUVOWElPOwogCQl2YyA9IHZjc192
Yyhpbm9kZSwgJnZpZXdlZCk7CiAJCWlmICghdmMpCi0JCQlnb3RvIHVubG9ja19vdXQ7CisJCQli
cmVhazsKIAogCQkvKiBDaGVjayB3aGV0aGVyIHdlIGFyZSBhYm92ZSBzaXplIGVhY2ggcm91bmQs
CiAJCSAqIGFzIGNvcHlfdG9fdXNlciBhdCB0aGUgZW5kIG9mIHRoaXMgbG9vcAogCQkgKiBjb3Vs
ZCBzbGVlcC4KIAkJICovCi0JCXNpemUgPSB2Y3Nfc2l6ZSh2YywgYXR0ciwgdW5pX21vZGUpOwot
CQlpZiAoc2l6ZSA8IDApIHsKLQkJCWlmIChyZWFkKQotCQkJCWJyZWFrOwotCQkJcmV0ID0gc2l6
ZTsKLQkJCWdvdG8gdW5sb2NrX291dDsKLQkJfQorCQlyZXQgPSB2Y3Nfc2l6ZSh2YywgYXR0ciwg
dW5pX21vZGUpOworCQlpZiAocmV0IDwgMCkKKwkJCWJyZWFrOworCQlzaXplID0gcmV0OworCQly
ZXQgPSAwOwogCQlpZiAocG9zID49IHNpemUpCiAJCQlicmVhazsKIAkJaWYgKGNvdW50ID4gc2l6
ZSAtIHBvcykK
--000000000000346cf405f40bfb2d--
