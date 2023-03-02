Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373326A8D2F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 00:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjCBXoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 18:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjCBXok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:44:40 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761753B86E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 15:44:37 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id da10so3734621edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 15:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677800675;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xv4aqNzW0df9Tu93QQQ99zBiZ6fJ3oheaLW9ritN8+4=;
        b=XYgo+sPbad0eHGrhvt3u05kDPYyOJ0tftxcXfDzT+UsAul90T3tTtf8jf4DS3z1+OX
         HGSH2tD6pvo5+FDtL2nP7rbAts9BBUsSJnikGCc+1TtNKic1YXoUPnHC1VGU0sXkmvzI
         B31VRHN34iIdOrKpsWvplj7WRQRyoinfDQJQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677800675;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xv4aqNzW0df9Tu93QQQ99zBiZ6fJ3oheaLW9ritN8+4=;
        b=yNHRI5RkFQ0ZZerVW2vkUA6ezVKJmapH5wj6U+BN52mZLLjhNoZDT2CPg7Q2o5qUKe
         +KPrOP9rP++2cZvvEv4eJ7inkjrPV/bYSmO5RXpQjBLXTTvZdMkHyvH47+sG9nJH18mo
         YNK7PMik6JCg2t6fjDfUezP/2ojtqkxfQTNsPMsVM1npatpgoqGRTZ2U8aI/Wnp82w9O
         0x29aDM+VVysEZrekS/t4gDJmPBpBMXULUDmnZoqA7frwW0pwOOHh1EI30htyV1798l+
         DD2oMpjezM6SHuB7WXciinVgUknSfLOCNB8+bQbtFKriRfqeXeSSZlP7BnF2PDly8UZh
         N5iA==
X-Gm-Message-State: AO0yUKXmsoo4wf/jLQu18/smWBUuSpimFOtLhdo08TbOsnv17ZtnNcoZ
        4O0pIHkLSGG22RzrS5sto/c/bXQ3eIGziIkVSOsyuQ==
X-Google-Smtp-Source: AK7set9RZ8qgnYgsaPAKsZoHfrQJ4aQlNg3MuE7S6SAm/l8djkwWMfF43qFqsPUB0dpLBevfsNOGyw==
X-Received: by 2002:a17:906:c792:b0:7c4:fa17:7203 with SMTP id cw18-20020a170906c79200b007c4fa177203mr12963965ejb.63.1677800675668;
        Thu, 02 Mar 2023 15:44:35 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id bi23-20020a170906a25700b008d356cafaedsm260261ejb.40.2023.03.02.15.44.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 15:44:34 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id f13so3669721edz.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 15:44:34 -0800 (PST)
X-Received: by 2002:a50:9f47:0:b0:4bc:13f5:68a5 with SMTP id
 b65-20020a509f47000000b004bc13f568a5mr39784edf.5.1677800674102; Thu, 02 Mar
 2023 15:44:34 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Mar 2023 15:44:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=whjmfvccPgFSfbpZ4nQ6fkYwTEAZhqZvfW8=rKMDsZarQ@mail.gmail.com>
Message-ID: <CAHk-=whjmfvccPgFSfbpZ4nQ6fkYwTEAZhqZvfW8=rKMDsZarQ@mail.gmail.com>
Subject: usermode-helper code oddity query..
To:     Luis Chamberlain <mcgrof@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000002f562105f5f369d2"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000002f562105f5f369d2
Content-Type: text/plain; charset="UTF-8"

So this is a bit out of the blue, but I cleaned up some really old
legacy capability code in commit f122a08b197d ("capability: just use a
'u64' instead of a 'u32[2]' array") and in the process I became the
last person to touch kernel/umh.c.

Tag, I'm clearly it. Not that I want to take that glory away from
PeterZ, who was the previous last person to touch that code. In fact,
I'm just cc'ing everybody who has been touching that file at all in
the last years, and a few /proc sysctl maintainers too.

Anyway, I wanted to try to keep the capability code cleanups clear,
and really only touched the data structure conversion, but I'm just
left staring at that code and wondering why we have those odd CAP_BSET
/ CAP_PI dummy pointers. They've been there since the whole /proc
interface was introduced, but they seem strangely pointless.

It would _seem_ like it would be a lot simpler and more
straightforward to just put the actual pointer to the usermodehelper
capability in there instead, and not have that odd fake pointer
enumeration at all.

IOW, I'm wondering what's wrong with a patch like the attached. I
might be missing something.

I also would have like that array to be an array of "u32" rather than
"unsigned long" (because that is, sadly, the interface we have, like
it or not), but we don't seem to have a proc_dou32vec_minmax(). I
guess "uint" is the same thing, but it's not pretty. Anyway, that's a
separate and independent issue from this.

And no, none of this is important. Just random cleanup of code I
happened to look at for other reasons.

           Linus

--0000000000002f562105f5f369d2
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lerr6nqt0>
X-Attachment-Id: f_lerr6nqt0

IGtlcm5lbC91bWguYyB8IDE4ICsrKysrLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEva2VybmVsL3VtaC5j
IGIva2VybmVsL3VtaC5jCmluZGV4IDJhNDcwODI3NzMzNS4uNjBhYTllNzY0YTM4IDEwMDY0NAot
LS0gYS9rZXJuZWwvdW1oLmMKKysrIGIva2VybmVsL3VtaC5jCkBAIC0zMiw5ICszMiw2IEBACiAK
ICNpbmNsdWRlIDx0cmFjZS9ldmVudHMvbW9kdWxlLmg+CiAKLSNkZWZpbmUgQ0FQX0JTRVQJKHZv
aWQgKikxCi0jZGVmaW5lIENBUF9QSQkJKHZvaWQgKikyCi0KIHN0YXRpYyBrZXJuZWxfY2FwX3Qg
dXNlcm1vZGVoZWxwZXJfYnNldCA9IENBUF9GVUxMX1NFVDsKIHN0YXRpYyBrZXJuZWxfY2FwX3Qg
dXNlcm1vZGVoZWxwZXJfaW5oZXJpdGFibGUgPSBDQVBfRlVMTF9TRVQ7CiBzdGF0aWMgREVGSU5F
X1NQSU5MT0NLKHVtaF9zeXNjdGxfbG9jayk7CkBAIC01MTIsMTYgKzUwOSwxMSBAQCBzdGF0aWMg
aW50IHByb2NfY2FwX2hhbmRsZXIoc3RydWN0IGN0bF90YWJsZSAqdGFibGUsIGludCB3cml0ZSwK
IAkvKgogCSAqIGNvbnZlcnQgZnJvbSB0aGUgZ2xvYmFsIGtlcm5lbF9jYXBfdCB0byB0aGUgdWxv
bmcgYXJyYXkgdG8gcHJpbnQgdG8KIAkgKiB1c2Vyc3BhY2UgaWYgdGhpcyBpcyBhIHJlYWQuCisJ
ICoKKwkgKiBMZWdhY3kgZm9ybWF0OiBjYXBhYmlsaXRpZXMgYXJlIGV4cG9zZWQgYXMgdHdvIDMy
LWJpdCB2YWx1ZXMKIAkgKi8KKwljYXAgPSB0YWJsZS0+ZGF0YTsKIAlzcGluX2xvY2soJnVtaF9z
eXNjdGxfbG9jayk7Ci0JaWYgKHRhYmxlLT5kYXRhID09IENBUF9CU0VUKQotCQljYXAgPSAmdXNl
cm1vZGVoZWxwZXJfYnNldDsKLQllbHNlIGlmICh0YWJsZS0+ZGF0YSA9PSBDQVBfUEkpCi0JCWNh
cCA9ICZ1c2VybW9kZWhlbHBlcl9pbmhlcml0YWJsZTsKLQllbHNlCi0JCUJVRygpOwotCi0JLyog
TGVnYWN5IGZvcm1hdDogY2FwYWJpbGl0aWVzIGFyZSBleHBvc2VkIGFzIHR3byAzMi1iaXQgdmFs
dWVzICovCiAJY2FwX2FycmF5WzBdID0gKHUzMikgY2FwLT52YWw7CiAJY2FwX2FycmF5WzFdID0g
Y2FwLT52YWwgPj4gMzI7CiAJc3Bpbl91bmxvY2soJnVtaF9zeXNjdGxfbG9jayk7CkBAIC01NTUs
MTQgKzU0NywxNCBAQCBzdGF0aWMgaW50IHByb2NfY2FwX2hhbmRsZXIoc3RydWN0IGN0bF90YWJs
ZSAqdGFibGUsIGludCB3cml0ZSwKIHN0cnVjdCBjdGxfdGFibGUgdXNlcm1vZGVoZWxwZXJfdGFi
bGVbXSA9IHsKIAl7CiAJCS5wcm9jbmFtZQk9ICJic2V0IiwKLQkJLmRhdGEJCT0gQ0FQX0JTRVQs
CisJCS5kYXRhCQk9ICZ1c2VybW9kZWhlbHBlcl9ic2V0LAogCQkubWF4bGVuCQk9IDIgKiBzaXpl
b2YodW5zaWduZWQgbG9uZyksCiAJCS5tb2RlCQk9IDA2MDAsCiAJCS5wcm9jX2hhbmRsZXIJPSBw
cm9jX2NhcF9oYW5kbGVyLAogCX0sCiAJewogCQkucHJvY25hbWUJPSAiaW5oZXJpdGFibGUiLAot
CQkuZGF0YQkJPSBDQVBfUEksCisJCS5kYXRhCQk9ICZ1c2VybW9kZWhlbHBlcl9pbmhlcml0YWJs
ZSwKIAkJLm1heGxlbgkJPSAyICogc2l6ZW9mKHVuc2lnbmVkIGxvbmcpLAogCQkubW9kZQkJPSAw
NjAwLAogCQkucHJvY19oYW5kbGVyCT0gcHJvY19jYXBfaGFuZGxlciwK
--0000000000002f562105f5f369d2--
