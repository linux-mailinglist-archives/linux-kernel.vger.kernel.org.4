Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C566D8A6D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 00:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjDEWPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 18:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDEWO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 18:14:59 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D7F55BA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 15:14:58 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54c061acbc9so24795047b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 15:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680732897; x=1683324897;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DkhXpIZUd3UwhU4/lPqmcT7Rq+/mxVouewhINmK6tsk=;
        b=pxsFvIdCQX5T8/WamHNGUFAQiy6rc/pB9Q0GGGcaNvOPupvECPHOmLok5F8qw7p4qq
         IaUplh2wRu+EtfPYS6faSsvuLVtXsnJ9FQs47dQIMqd3WkUMA+SJ1gR7m2eAv1m42bdV
         enqgCoZ0vw2bWPA5k+vPGImt7lJeW8s1Tyq5R2bMQ8ZelMtU9rC10akMY+MVJyLigyMe
         YDjg2V4MiIo7OS33ZXVF0BttVrevBgS8V0XkfyUViI+hxJ1gmUfiorUGQDgQMWwzo1cG
         9TOG2eqj94GSY+TOfBLRD84d3PwOG+u80k3oiRE66Qga68zG5r7qE8KLJGJ29UlC4rqY
         uydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680732897; x=1683324897;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DkhXpIZUd3UwhU4/lPqmcT7Rq+/mxVouewhINmK6tsk=;
        b=paFNEmmgRz38F8BBqSHtFDX4tTXSJJxUwVYYIy4IjMxeWqQ9APtIYNwDsPHzhDsKqD
         gxfpYodueiXA3ILWGadVoj18H8m2HYUHoqcmmT7SzNBdITBtnCjdpcDPGRz1pCCOAw5X
         UO7n6hb6nmKG4atmFcEkoMRV9/HrxHvKAAwD24cmNlbfje+wyErALq8U+rZFM3DhjQnd
         B6qGDpXsBuj1MrTJJkYthmGKfV539+WTjWouEGK8HBejLnM7T1RuoJRPZro2ckX9xSpE
         tuZWnP2DZY7s5jKcsZ6Gtb6EjCaQeLNUOi/T2mwjJP+ywM0CpFdzse+14nmi+hxISWYg
         RItQ==
X-Gm-Message-State: AAQBX9dk5xKQqJss1gJYQ2wals5si5mxCpomXzseU2L2rAfc0MrLnUhX
        dxCyZ2aefdmSLcrQHW9N1kz4lrkqF/btomRbdA==
X-Google-Smtp-Source: AKy350YvZzcCXznNAshm4nkhb+tXooHeeqMHJLSjyZ7eZ2GO7EoFf+dLZh7Nupu7xRx1Gh5tGbv86eg8x71I/HKO51M=
X-Received: by 2002:a81:b389:0:b0:545:5b2c:4bf6 with SMTP id
 r131-20020a81b389000000b005455b2c4bf6mr4470191ywh.7.1680732897657; Wed, 05
 Apr 2023 15:14:57 -0700 (PDT)
MIME-Version: 1.0
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Wed, 5 Apr 2023 23:14:45 +0100
Message-ID: <CALjTZvakMZQsqzzjjXh_fw4+Zra5y5o-fhc5gDVTYM1uM40RNQ@mail.gmail.com>
Subject: [BUG?] unchecked MSR access error: WRMSR to 0x19c
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, everyone,

I have a Haswell (Core i7-4770R) machine running Linux 6.3-rc5 on
which, after a while under load (say, compiling the kernel), I get
this trace=E2=80=A6

[  832.549630] unchecked MSR access error: WRMSR to 0x19c (tried to
write 0x000000000000aaa8) at rIP: 0xffffffff816f66a6
(throttle_active_work+0xa6/0x1d0)
[  832.549652] Call Trace:
[  832.549654]  <TASK>
[  832.549655]  process_one_work+0x1ab/0x300
[  832.549661]  worker_thread+0x4b/0x340
[  832.549664]  ? process_one_work+0x300/0x300
[  832.549676]  kthread+0xac/0xc0
[  832.549679]  ? kthread_exit+0x20/0x20
[  832.549682]  ret_from_fork+0x1f/0x30
[  832.549693]  </TASK>

=E2=80=A6 after which I get these from time to time in dmesg.

[  836.709562] CPU7: Core temperature is above threshold, cpu clock is
throttled (total events =3D 219)
[  836.709569] CPU3: Core temperature is above threshold, cpu clock is
throttled (total events =3D 219)
[ 1272.792138] CPU2: Core temperature is above threshold, cpu clock is
throttled (total events =3D 1)
[ 1272.792156] CPU6: Core temperature is above threshold, cpu clock is
throttled (total events =3D 1)

This is the microcode revision on the CPU.

[    0.000000] microcode: updated early: 0xe -> 0x1c, date =3D 2019-11-12

Note that I have the exact same issue on an Ivy Bridge (Core
i7-3720QM) machine, but not on an Ivy Bridge laptop (Celeron 1007U).
Maybe this is a legitimate warning, but please note that I've
thorughly cleaned the machines before retesting to see if, by
coincidence, I had any airway/cooling issues. The fact that it started
happening recently (since Linux 6.1, I believe), and the fact that
running stress-ng --cpu 16 before the unchecked WRMSR error happens
doesn't cause any thermal throttling events, lead me to believe this
is possibly some unintended oversight.

Please let me know if you need any additional information (.config, or
anything else).

Thanks in advance,
Rui
