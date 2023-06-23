Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127B973AF34
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 05:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjFWD5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 23:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjFWD5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 23:57:38 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527FF1FE9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 20:57:33 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51beee8843eso105238a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 20:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687492651; x=1690084651;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TY0mjbjbbS57MnRjgQ9450/9TZ/oHz6bQ+SREUOCB9Q=;
        b=rfKGFbyEuaJFuHEcmCkHIpPiXwU8VA2v03oLHMwLdjXu3zmXYbY0I4r0KVPCsYqVRd
         x8NGNAPQ/d3XUK5e2wJguWYVNPOJpN9nRO+c86mHhEAmIuHTuNo2bGcQJMcu1Fw/YY1G
         LCMJcD08m5fR2qTqdpBp5SH19uNEvM0z2qQTiYrYpvUFyRXm4mmKU0XP/yBRv2gq9thw
         H2AqJfbNKBu7uyxJkel749D0jJMyAFbWT/b+haziWqae22loGbzHxLBw/y/4xzBNLKhc
         W9S2tDmGEt90jg36UhzHIe7AGirkfeD0/3TSyQL+9yAFQIzZ/S22a+lEC3W6qkyNvOpC
         taew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687492651; x=1690084651;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TY0mjbjbbS57MnRjgQ9450/9TZ/oHz6bQ+SREUOCB9Q=;
        b=R9GBFZ6K++Tjb1p3AjGWdmeMt2qahIUrssZz7QfzUbI8nB2yswi2oq74vjEw0fy+g0
         s0j8o5j9D1jTzLVt3ElmkWP0pjmeHfhfVyE+NxlaKqEqcHWBJ8vmTjfw3a+aAoHITJvX
         sSXUAzIIOg003YMZ+LKk39OmxycWO0gfSMf3wLFy8awlvo61+XNJbD1oA09T/q6inZus
         9wHdd9FtHDaec8aS/ezocch+Z5jCRtobfeZ2TZT8fs4m+BcrX1VY6csMKD6ak5bGXT5D
         6QJiROUkdObw/0StfwMrcy/p43JkRtnBFfJZ64w7kmR/R9I1j+2KkDfou0GLkB4JlU82
         8a7g==
X-Gm-Message-State: AC+VfDzCwRd9NTa8h/mptkVAcQqPvOLtfo/b1h3QF8wcDYEkFG8ZFOD/
        Vjn/SzzLUzaBLZ/CImxaf6P6me/aKJuI7BHM1/o=
X-Google-Smtp-Source: ACHHUZ4mebsJZpjcEgNJKNtEs2qtTeYEi5pJ4miClKHrHqj/tGKMh8USDcw+kCyQTLDtIBVknIphzfAyEpGuwx7pYy4=
X-Received: by 2002:a17:907:c25:b0:988:aa45:827 with SMTP id
 ga37-20020a1709070c2500b00988aa450827mr12730950ejc.11.1687492651207; Thu, 22
 Jun 2023 20:57:31 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 23 Jun 2023 13:57:19 +1000
Message-ID: <CAPM=9twNnV4zMCvrPkw3H-ajZOH-01JVh_kDrxdPYQErz8ZTdA@mail.gmail.com>
Subject: arm32 build warnings in workqueue.c
To:     Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure what changed (maybe I ended up with -Werror on recently), but
my 32-bit arm build started to fail. 6.4.0-rc7.

gcc version 13.1.1 20230519 (Red Hat Cross 13.1.1-2) (GCC)

/home/airlied/devel/kernel/dim/drm-fixes/kernel/workqueue.c: In
function =E2=80=98get_work_pwq=E2=80=99:
/home/airlied/devel/kernel/dim/drm-fixes/kernel/workqueue.c:713:24:
error: cast to pointer from integer of different size
[-Werror=3Dint-to-pointer-cast]
  713 |                 return (void *)(data & WORK_STRUCT_WQ_DATA_MASK);
      |                        ^
/home/airlied/devel/kernel/dim/drm-fixes/kernel/workqueue.c: In
function =E2=80=98get_work_pool=E2=80=99:
/home/airlied/devel/kernel/dim/drm-fixes/kernel/workqueue.c:741:25:
error: cast to pointer from integer of different size
[-Werror=3Dint-to-pointer-cast]
  741 |                 return ((struct pool_workqueue *)
      |                         ^
/home/airlied/devel/kernel/dim/drm-fixes/kernel/workqueue.c: In
function =E2=80=98get_work_pool_id=E2=80=99:
/home/airlied/devel/kernel/dim/drm-fixes/kernel/workqueue.c:763:25:
error: cast to pointer from integer of different size
[-Werror=3Dint-to-pointer-cast]
  763 |                 return ((struct pool_workqueue *)
      |                         ^

Just a drive-by, I'll disable Werror on my 32-bit arm build for now.

Dave.
