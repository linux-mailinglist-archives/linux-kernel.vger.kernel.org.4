Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257366A9967
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 15:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjCCO2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 09:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjCCO2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 09:28:49 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C3B13D7C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 06:28:49 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id z5so1726757ilq.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 06:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677853728;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PRcr1qg5pQOktZ9kX0ziwdm9E4pyF51eI2ym5oRUyFE=;
        b=G5Osnu5hzYoVxhN4oaDmF5ViD0nXFxer6ZmbnkHX+XteHQB6w9jeCBHfe/lpiNZQkF
         TnXhJ4mCWNuKZoh1vLG+CLsLsS4dUZB+PTvJ44unjclgLGyq+MvLzUP3CQxG/U4mCF7p
         HjfW/RlyqqIpILTffO10FhS8wZCw9XF+H0CF09VXjfs7qqVp/AdfBdqFqzQLqaO+0KcY
         hCgjK4WySE5WFwwcxUYEVjwosYEi866GUTErjZuLnAH3haBJiNHO9BeYZXnhtnSWN5pO
         0bysOuL5OEvrXWBVTvinonfeYXGrf7OPLfqNCTAzMdpNLJwkOs/XTvfPv1Y/X5OoS1ml
         uDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677853728;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PRcr1qg5pQOktZ9kX0ziwdm9E4pyF51eI2ym5oRUyFE=;
        b=TqEQh3jz5mU7apBTnfvqPUWi78C+kOsc9r1WqqwnpYKn6CimMsMzIKx0dt+7QJaMW3
         kDuN3eJrM/1cRWoT32ZSkl3rgf8xUv/MJ9LyXNULnvZV9JVnGp8b87Y1F27jCC5uuWRK
         dkxCJ2uQmxAgdkrsLfL/XmXn34LT8da12E7EOY7TjIxcFm6+5nDiaiXQg8wjQbEFfBxz
         Qt3eQse2BAUEsyMyJW8YKtLIPGZqxt/ag4gmKTnWEGeciKkEPVOMrIxPxovNG2e8ww2x
         3pMxa5zAqVe5U9x3e9UYxi1EXhpXIrVmceL/07ntNV46+1FukBqFnGaU3txSk9J94jO+
         Oiow==
X-Gm-Message-State: AO0yUKV9HqsOElv2zkWKGeEy3HnDqHyKhPAgM6ovd9djkXC2GjcVtm7G
        faX82q2FtF8WtIBbklY0RdKz/u5TqYOElW7ZBHomG2u6sZ6w1WSgGIKZ+w==
X-Google-Smtp-Source: AK7set+HMBwA2uzkl25q517yrfjU68xIFglNvg4faUnDBtughiHcyxFIGYQcTPiaOodX1W7AzKuxYMhTzUmtC4uKzJI=
X-Received: by 2002:a05:6e02:130f:b0:315:9761:6965 with SMTP id
 g15-20020a056e02130f00b0031597616965mr931127ilr.5.1677853728379; Fri, 03 Mar
 2023 06:28:48 -0800 (PST)
MIME-Version: 1.0
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 3 Mar 2023 15:28:12 +0100
Message-ID: <CAG_fn=WZnBtRujLyhouz1AmerSKB71oPej442JDOw2OaORbWQg@mail.gmail.com>
Subject: Infinite loop in checkpatch.pl
To:     apw@canonical.com, Joe Perches <joe@perches.com>,
        dwaipayanray1@gmail.com, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000077b6b205f5ffc351"
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

--00000000000077b6b205f5ffc351
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi folks,

I've noticed that checkpatch.pl chokes on the following file (also attached=
):

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
$ cat test-checkpatch.txt
diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
@@ -504,6 +504,25 @@ static void
test_memcpy_aligned_to_unaligned2(struct kunit *test)
+ EXPECTATION_NO_REPORT(expect);                              \
+ volatile uint##size##_t uninit;                             \
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D


, getting into an infinite loop in annotate_values().
The following patch helps it to proceed:

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 78cc595b98ce1..01d998b416a51 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2240,8 +2240,13 @@ sub annotate_values {
                        print "C($1)\n" if ($dbg_values > 1);
                }
                if (defined $1) {
-                       $cur =3D substr($cur, length($1));
-                       $res .=3D $type x length($1);
+                       if (length($1)) {
+                               $cur =3D substr($cur, length($1));
+                               $res .=3D $type x length($1);
+                       } else {
+                               $res .=3D $cur;
+                               $cur =3D "";
+                       }
                }
        }

, but I have no idea how to test it properly.

Could you please take a look?


Thanks,
Alex

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

--00000000000077b6b205f5ffc351
Content-Type: text/plain; charset="US-ASCII"; name="test-checkpatch.txt"
Content-Disposition: attachment; filename="test-checkpatch.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lesmmnga0>
X-Attachment-Id: f_lesmmnga0

ZGlmZiAtLWdpdCBhL21tL2ttc2FuL2ttc2FuX3Rlc3QuYyBiL21tL2ttc2FuL2ttc2FuX3Rlc3Qu
YwpAQCAtNTA0LDYgKzUwNCwyNSBAQCBzdGF0aWMgdm9pZCB0ZXN0X21lbWNweV9hbGlnbmVkX3Rv
X3VuYWxpZ25lZDIoc3RydWN0IGt1bml0ICp0ZXN0KQorCQlFWFBFQ1RBVElPTl9OT19SRVBPUlQo
ZXhwZWN0KTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCisJCXZvbGF0aWxlIHVpbnQj
I3NpemUjI190IHVuaW5pdDsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwK
--00000000000077b6b205f5ffc351--
