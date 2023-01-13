Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DC5669324
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 10:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240721AbjAMJnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 04:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239679AbjAMJmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:42:25 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359947FEFC;
        Fri, 13 Jan 2023 01:31:34 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id a25so11478761qto.10;
        Fri, 13 Jan 2023 01:31:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SC0846x6bM2/0xxkG/f8yzedsbqUJvfQyAhjPvVKhSI=;
        b=MESp9vB2/tfZXwaVMs+yM6uQSBcX+RKWOLsuyVhY1egeoWRcMtO3bq4+4T/+gXfUyP
         YOve+2uwHU1A0JjEfRuF7F6qM9MV5raLrKlOpzYRVf2L4LOsZvQGJ63BAzVXb5tEIc0b
         7AZn3k70rKqf8/BPdDEIXzFI3L+Juv2t0vIIYutQ+fPufXV07eFuDXKzfV3Z2kTQrYfI
         RLzY6Wiih4Hu9ThFgl8xo/+GGFHjFIP85QAsYhT7402U3VRKiRMwEDVEHynKgVIUwAhA
         xmR8340vQ4upkLhU6Sz9syErh8VeZUuXPJuoJt1XApx2T4JCqD4WGzI3zlJi6dRf+fHv
         fwow==
X-Gm-Message-State: AFqh2kr4gv0cAWsfnHFuAnxtdlM5CXrpa0AQZW4eViyaaXx5OU8Qx875
        r4yC3fyriY0SeX06vWPp4r8szXLAxr5Vxg==
X-Google-Smtp-Source: AMrXdXu5c59y9fd9PsUGioebA3EcIwihUMxf/UHOT+NmIekO6cPPaQlU61s9pi+LC/xlW8GaYMOZtg==
X-Received: by 2002:ac8:4552:0:b0:3a8:a1f:6999 with SMTP id z18-20020ac84552000000b003a80a1f6999mr109872208qtn.52.1673602293681;
        Fri, 13 Jan 2023 01:31:33 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id i17-20020a05620a405100b006cfc01b4461sm12545750qko.118.2023.01.13.01.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 01:31:33 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id 9so4258801ybn.6;
        Fri, 13 Jan 2023 01:31:32 -0800 (PST)
X-Received: by 2002:a25:3143:0:b0:77a:b5f3:d0ac with SMTP id
 x64-20020a253143000000b0077ab5f3d0acmr5751463ybx.202.1673602292739; Fri, 13
 Jan 2023 01:31:32 -0800 (PST)
MIME-Version: 1.0
References: <20230109180717.58855-1-casey@schaufler-ca.com> <20230109180717.58855-8-casey@schaufler-ca.com>
In-Reply-To: <20230109180717.58855-8-casey@schaufler-ca.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 13 Jan 2023 10:31:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXiXr6+wi53RAa4GZgHmem52oNWiw3PnH3w=qwRjhcGOw@mail.gmail.com>
Message-ID: <CAMuHMdXiXr6+wi53RAa4GZgHmem52oNWiw3PnH3w=qwRjhcGOw@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] LSM: wireup Linux Security Module syscalls
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 9, 2023 at 7:15 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> Wireup lsm_get_self_attr, lsm_set_self_attr and lsm_module_list
> system calls.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: linux-api@vger.kernel.org

>  arch/m68k/kernel/syscalls/syscall.tbl               |  3 +++

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> [m68k]

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
