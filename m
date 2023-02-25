Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7196A2A1B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 14:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjBYNvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 08:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjBYNvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 08:51:45 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F1614983
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 05:51:43 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id bj35so602545qkb.8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 05:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fDEOKBLxVt4XI6LHqy/jkVAOmYwz/nUQYhcof9UI6Ik=;
        b=TRYtyxD475zo2BDSyGiRfYlroFOyUIRCQHEJFtuTHqG9g38lMuquY+Dot48Z4lSim9
         wTyjsYf1ABYDjSHh/5Wmu8+wVJve5D5NrnxJrkcFaoNb0W/VjujKNj0bQ/xQWDY7ZRey
         iqP+X6xjWBeBrCCUghnmWkrwx8Q+y0vA8nt1KqCrIxKTcE4wClnFDSqjefPdOc/4G0S2
         rI5iH6sG69iNlgshQJCzePiRzQjdg5TEAXCwXLHctxpm+k88eqjyRessFQqADkxn+bcm
         29ltyJKCzuk3lapWfs/ZaZpDZiBF6nrRkbydulyMHCQSxdV9EY28c8wQsQn/JdSmWUiC
         5EjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fDEOKBLxVt4XI6LHqy/jkVAOmYwz/nUQYhcof9UI6Ik=;
        b=JyEF2+XEJiVhYznmQu2rms4HZ7pKVD/O7HKiaeUdlALAc42mS5RjOo/MfSEwMfCOk/
         V2mavigQwWpoYDhtzNRe9W1sKzVg7c1Q16oe3qaqk/yoHWEHoD/d80YPDX0h5UD5g96l
         sZjxVXaRvIkeY5g4dgsDWbAp86pl+G5LRSAUwQkj2qRbdi5FHjVekHrhEhTn1OtBVQIp
         7iQlE1nYIaLgTL+ss1/yTd9tie4yUojrIBH2ridJXdOqnMl3A0uB0P3SyLoMcEpSZrpK
         9xMQDrPWKj509MVuHr6z2ZlcAQo7ekWTEB1qPlWKJr+CGx7yG/hH2GkPsoZrgX/EQdss
         78Gw==
X-Gm-Message-State: AO0yUKX+Q0p0rBkeRX06f2FEbLB5Pj6z2y3nHSGiVXR1x2L5zTziQ3b0
        dL4xZ9iUWoxkOWhGqMQSi5oGM+cmTfbiKsrFvP33d85OUhipuWpeuf8=
X-Google-Smtp-Source: AK7set/fxQZKfHBRnm5VbbYeGh8ZZB4txN3uwEx4RgVT3DabV0ylBYqKPm0MnYxSnjokdSHlwasnV/DhmI2ms+U4rf0=
X-Received: by 2002:a37:ef11:0:b0:742:412d:1dc6 with SMTP id
 j17-20020a37ef11000000b00742412d1dc6mr2464660qkk.14.1677333102347; Sat, 25
 Feb 2023 05:51:42 -0800 (PST)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Sat, 25 Feb 2023 18:51:31 +0500
Message-ID: <CABXGCsO4=qKBF=2FRPVwW8FA4iLFh0Dt9n1BLMec3k10GUorpg@mail.gmail.com>
Subject: [6.3][regression] after commit 7170b7ed6acbde523c5d362c8978c60df4c30f30
 my system stuck in initramfs forever
To:     davidgow@google.com, rmoar@google.com, brendanhiggins@google.com,
        skhan@linuxfoundation.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
new kernel release cycle returning with new bugs
Today my system got stuck in initramfs environment after updating to
commit d2980d8d826554fa6981d621e569a453787472f8.

I still do not understand how to configure the network inside the
initramfs environment to grab the logs.
Since an attempt to rebuild the initramfs with all modules (dracut
--no-hostonly --force) leads to the stuck initramfs environment and
impossible entering into initramfs console.

But I can bisect the problem and bisection blames this commit:

=E2=9D=AF git bisect good
7170b7ed6acbde523c5d362c8978c60df4c30f30 is the first bad commit
commit 7170b7ed6acbde523c5d362c8978c60df4c30f30
Author: David Gow <davidgow@google.com>
Date:   Sat Jan 28 15:10:07 2023 +0800

    kunit: Add "hooks" to call into KUnit when it's built as a module

    KUnit has several macros and functions intended for use from non-test
    code. These hooks, currently the kunit_get_current_test() and
    kunit_fail_current_test() macros, didn't work when CONFIG_KUNIT=3Dm.

    In order to support this case, the required functions and static data
    need to be available unconditionally, even when KUnit itself is not
    built-in. The new 'hooks.c' file is therefore always included, and has
    both the static key required for kunit_get_current_test(), and a table
    of function pointers in struct kunit_hooks_table. This is filled in wit=
h
    the real implementations by kunit_install_hooks(), which is kept in
    hooks-impl.h and called when the kunit module is loaded.

    This can  be extended for future features which require similar
    "hook" behaviour, such as static stubs, by simply adding new entries to
    the struct, and the appropriate code to set them.

    Fixed white-space errors during commit:
    Shuah Khan <skhan@linuxfoundation.org>

    Resolved merge conflicts with:
    db105c37a4d6 ("kunit: Export kunit_running()")
    This patch supersedes the above.
    Shuah Khan <skhan@linuxfoundation.org>

    Signed-off-by: David Gow <davidgow@google.com>
    Reviewed-by: Rae Moar <rmoar@google.com>
    Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
    Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

 Documentation/dev-tools/kunit/usage.rst | 15 ++++++---------
 include/kunit/test-bug.h                | 28 ++++++++++------------------
 lib/Makefile                            |  8 ++++++++
 lib/kunit/Makefile                      |  3 +++
 lib/kunit/hooks-impl.h                  | 27 +++++++++++++++++++++++++++
 lib/kunit/hooks.c                       | 21 +++++++++++++++++++++
 lib/kunit/test.c                        | 15 +++++++--------
 7 files changed, 82 insertions(+), 35 deletions(-)
 create mode 100644 lib/kunit/hooks-impl.h
 create mode 100644 lib/kunit/hooks.c

Unfortunately I couldn't revert this commit staying on
d2980d8d826554fa6981d621e569a453787472f8 because of conflicts:
=E2=9D=AF git revert 7170b7ed6acbde523c5d362c8978c60df4c30f30 -n
Auto-merging include/kunit/test-bug.h
CONFLICT (content): Merge conflict in include/kunit/test-bug.h
Auto-merging lib/Makefile
Auto-merging lib/kunit/Makefile
CONFLICT (modify/delete): lib/kunit/hooks-impl.h deleted in parent of
7170b7ed6acb (kunit: Add "hooks" to call into KUnit when it's built as
a module) and modified in HEAD.  Version HEAD of
lib/kunit/hooks-impl.h left in tree.
Auto-merging lib/kunit/test.c
CONFLICT (content): Merge conflict in lib/kunit/test.c
error: could not revert 7170b7ed6acb... kunit: Add "hooks" to call
into KUnit when it's built as a module
hint: after resolving the conflicts, mark the corrected paths
hint: with 'git add <paths>' or 'git rm <paths>'

--=20
Best Regards,
Mike Gavrilov.
