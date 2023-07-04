Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9FC7472D6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjGDNiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjGDNhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:37:55 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2E5E76
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 06:37:53 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b69923a715so86748841fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 06:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688477871; x=1691069871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EWjiYG4F/kbaY9p70oD/qnrdrEEhJODCTs1UK2rFBxM=;
        b=bxLpR4ALYRmG+aCvJDksDttDYWMqIrJZDZI2j9l8p4yTFGwl3BbSG1ieqQKQU1dNHe
         SHm5tr8JdebPTgdbTYIGWgkQNkVGbdANkd80NcmNGobpJD0DCwbyfquiOtFXUGQ1iXQK
         oUdx7FpiBUFG2N5liNFEXImfUvv7avX5nADcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688477871; x=1691069871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWjiYG4F/kbaY9p70oD/qnrdrEEhJODCTs1UK2rFBxM=;
        b=Nv1UPhsKHM7jxFpa/lDGhJNlZ1e79qaABM+MhgxuUXe+zY9hLMB7NebnXakVJKpii0
         4nJHOOO7QNn5ZIpxaudAMjnwworPrcLnw4KpADRrszCWsC2AL5WAw241tdLqg5NMzIDw
         3NvfYMO9wMZmvcv88eB6FPxTUhhgjVl4RcYAxYMq/47bFZQdeog3dAeqpG2bYd1sZbgp
         ZEhUvk0gk/1ts80dCORqt7dWiNz9wgnKxaZ3Z9ooXtJMuo3cRK5JQKOdKknxOerKSBRq
         LNO3O+KVRglVP/Dis3tttj1Gx028kRvR5YVMhVVkqos8XLheIihIOZ/5d1y3dEY/vJPh
         ukCA==
X-Gm-Message-State: ABy/qLbFu4e4UVjlRonMhXRb6LIK2NQSq9hdHGvpMUyzMXYI/+xXFmXn
        NhlYKb057b63nmnmuhBGT0gMKiKhv5sEWQWfDBMlhztL
X-Google-Smtp-Source: APBJJlGCEqNQ5zNhqZ93g8c1Fy0rtfobXSIy4zcoALFgLKzr0szya7okF8UKA9iZEyIQycYL6Z5kDg==
X-Received: by 2002:a2e:3c0a:0:b0:2b5:97a3:3ba5 with SMTP id j10-20020a2e3c0a000000b002b597a33ba5mr10343509lja.10.1688477870822;
        Tue, 04 Jul 2023 06:37:50 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id sb22-20020a170906edd600b00982a92a849asm13378072ejb.91.2023.07.04.06.37.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 06:37:49 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-51d9c71fb4bso5376618a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 06:37:49 -0700 (PDT)
X-Received: by 2002:aa7:c14b:0:b0:51a:265a:8fca with SMTP id
 r11-20020aa7c14b000000b0051a265a8fcamr8535529edp.27.1688477869051; Tue, 04
 Jul 2023 06:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230704092309.22669-1-vegard.nossum@oracle.com> <20230704100852.23452-1-vegard.nossum@oracle.com>
In-Reply-To: <20230704100852.23452-1-vegard.nossum@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Jul 2023 06:37:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgy2q9viwq-bAqaq8X_WQHNqDsu1AzfeYXAcDQRZmCoAw@mail.gmail.com>
Message-ID: <CAHk-=wgy2q9viwq-bAqaq8X_WQHNqDsu1AzfeYXAcDQRZmCoAw@mail.gmail.com>
Subject: Re: [PATCH] module: always complete idempotent loads
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        George Kennedy <george.kennedy@oracle.com>,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        syzbot+9c2bdc9d24e4a7abe741@syzkaller.appspotmail.com,
        Johan Hovold <johan@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Rudi Heitbaum <rudi@heitbaum.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: multipart/mixed; boundary="00000000000098f0ae05ffa96368"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000098f0ae05ffa96368
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Jul 2023 at 03:09, Vegard Nossum <vegard.nossum@oracle.com> wrote:
>
> Commit 9b9879fc0327 added a hashtable storing lists of concurrent module
> loads. However, it didn't fix up all the error paths in
> init_module_from_file(); this would lead to leaving the function while an
> on-stack 'struct idempotent' element is still in the hash table, which
> leads to all sorts of badness as spotted by syzkaller:

You are of course 100% right.

However, I'd rather just use a wrapper function and make this thing
much clearer. Like I should have done originally.

So I'd be inclined towards a patch like the attached instead. Works for you?

                   Linus

--00000000000098f0ae05ffa96368
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ljoc43bs0>
X-Attachment-Id: f_ljoc43bs0

IGtlcm5lbC9tb2R1bGUvbWFpbi5jIHwgMzIgKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0KIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9rZXJuZWwvbW9kdWxlL21haW4uYyBiL2tlcm5lbC9tb2R1bGUvbWFpbi5jCmlu
ZGV4IDgzNGRlODZlYmUzNS4uNTAwYTZhM2MyOTg3IDEwMDY0NAotLS0gYS9rZXJuZWwvbW9kdWxl
L21haW4uYworKysgYi9rZXJuZWwvbW9kdWxlL21haW4uYwpAQCAtMzA5Miw3ICszMDkyLDcgQEAg
c3RhdGljIGJvb2wgaWRlbXBvdGVudChzdHJ1Y3QgaWRlbXBvdGVudCAqdSwgY29uc3Qgdm9pZCAq
Y29va2llKQogICogcmVtb3ZlIGV2ZXJ5Ym9keSAtIHdoaWNoIGluY2x1ZGVzIG91cnNlbHZlcyAt
IGZpbGwgaW4gdGhlIHJldHVybgogICogdmFsdWUsIGFuZCB0aGVuIGNvbXBsZXRlIHRoZSBvcGVy
YXRpb24uCiAgKi8KLXN0YXRpYyB2b2lkIGlkZW1wb3RlbnRfY29tcGxldGUoc3RydWN0IGlkZW1w
b3RlbnQgKnUsIGludCByZXQpCitzdGF0aWMgaW50IGlkZW1wb3RlbnRfY29tcGxldGUoc3RydWN0
IGlkZW1wb3RlbnQgKnUsIGludCByZXQpCiB7CiAJY29uc3Qgdm9pZCAqY29va2llID0gdS0+Y29v
a2llOwogCWludCBoYXNoID0gaGFzaF9wdHIoY29va2llLCBJREVNX0hBU0hfQklUUyk7CkBAIC0z
MTA5LDIzICszMTA5LDE4IEBAIHN0YXRpYyB2b2lkIGlkZW1wb3RlbnRfY29tcGxldGUoc3RydWN0
IGlkZW1wb3RlbnQgKnUsIGludCByZXQpCiAJCWNvbXBsZXRlKCZwb3MtPmNvbXBsZXRlKTsKIAl9
CiAJc3Bpbl91bmxvY2soJmlkZW1fbG9jayk7CisJcmV0dXJuIHJldDsKIH0KIAogc3RhdGljIGlu
dCBpbml0X21vZHVsZV9mcm9tX2ZpbGUoc3RydWN0IGZpbGUgKmYsIGNvbnN0IGNoYXIgX191c2Vy
ICogdWFyZ3MsIGludCBmbGFncykKIHsKLQlzdHJ1Y3QgaWRlbXBvdGVudCBpZGVtOwogCXN0cnVj
dCBsb2FkX2luZm8gaW5mbyA9IHsgfTsKIAl2b2lkICpidWYgPSBOVUxMOwotCWludCBsZW4sIHJl
dDsKKwlpbnQgbGVuOwogCiAJaWYgKCFmIHx8ICEoZi0+Zl9tb2RlICYgRk1PREVfUkVBRCkpCiAJ
CXJldHVybiAtRUJBREY7CiAKLQlpZiAoaWRlbXBvdGVudCgmaWRlbSwgZmlsZV9pbm9kZShmKSkp
IHsKLQkJd2FpdF9mb3JfY29tcGxldGlvbigmaWRlbS5jb21wbGV0ZSk7Ci0JCXJldHVybiBpZGVt
LnJldDsKLQl9Ci0KIAlsZW4gPSBrZXJuZWxfcmVhZF9maWxlKGYsIDAsICZidWYsIElOVF9NQVgs
IE5VTEwsIFJFQURJTkdfTU9EVUxFKTsKIAlpZiAobGVuIDwgMCkgewogCQltb2Rfc3RhdF9pbmMo
JmZhaWxlZF9rcmVhZHMpOwpAQCAtMzE0Niw5ICszMTQxLDIyIEBAIHN0YXRpYyBpbnQgaW5pdF9t
b2R1bGVfZnJvbV9maWxlKHN0cnVjdCBmaWxlICpmLCBjb25zdCBjaGFyIF9fdXNlciAqIHVhcmdz
LCBpbnQKIAkJaW5mby5sZW4gPSBsZW47CiAJfQogCi0JcmV0ID0gbG9hZF9tb2R1bGUoJmluZm8s
IHVhcmdzLCBmbGFncyk7Ci0JaWRlbXBvdGVudF9jb21wbGV0ZSgmaWRlbSwgcmV0KTsKLQlyZXR1
cm4gcmV0OworCXJldHVybiBsb2FkX21vZHVsZSgmaW5mbywgdWFyZ3MsIGZsYWdzKTsKK30KKwor
c3RhdGljIGludCBpZGVtcG90ZW50X2luaXRfbW9kdWxlKHN0cnVjdCBmaWxlICpmLCBjb25zdCBj
aGFyIF9fdXNlciAqIHVhcmdzLCBpbnQgZmxhZ3MpCit7CisJc3RydWN0IGlkZW1wb3RlbnQgaWRl
bTsKKworCS8qIFNlZSBpZiBzb21lYm9keSBlbHNlIGlzIGRvaW5nIHRoZSBvcGVyYXRpb24/ICov
CisJaWYgKGlkZW1wb3RlbnQoJmlkZW0sIGZpbGVfaW5vZGUoZikpKSB7CisJCXdhaXRfZm9yX2Nv
bXBsZXRpb24oJmlkZW0uY29tcGxldGUpOworCQlyZXR1cm4gaWRlbS5yZXQ7CisJfQorCisJLyog
T3RoZXJ3aXNlLCB3ZSdsbCBkbyBpdCBhbmQgY29tcGxldGUgb3RoZXJzICovCisJcmV0dXJuIGlk
ZW1wb3RlbnRfY29tcGxldGUoJmlkZW0sCisJCWluaXRfbW9kdWxlX2Zyb21fZmlsZShmLCB1YXJn
cywgZmxhZ3MpKTsKIH0KIAogU1lTQ0FMTF9ERUZJTkUzKGZpbml0X21vZHVsZSwgaW50LCBmZCwg
Y29uc3QgY2hhciBfX3VzZXIgKiwgdWFyZ3MsIGludCwgZmxhZ3MpCkBAIC0zMTY4LDcgKzMxNzYs
NyBAQCBTWVNDQUxMX0RFRklORTMoZmluaXRfbW9kdWxlLCBpbnQsIGZkLCBjb25zdCBjaGFyIF9f
dXNlciAqLCB1YXJncywgaW50LCBmbGFncykKIAkJcmV0dXJuIC1FSU5WQUw7CiAKIAlmID0gZmRn
ZXQoZmQpOwotCWVyciA9IGluaXRfbW9kdWxlX2Zyb21fZmlsZShmLmZpbGUsIHVhcmdzLCBmbGFn
cyk7CisJZXJyID0gaWRlbXBvdGVudF9pbml0X21vZHVsZShmLmZpbGUsIHVhcmdzLCBmbGFncyk7
CiAJZmRwdXQoZik7CiAJcmV0dXJuIGVycjsKIH0K
--00000000000098f0ae05ffa96368--
