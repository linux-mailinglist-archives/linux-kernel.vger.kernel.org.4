Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F6D6CEC0D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjC2OqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjC2Opq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:45:46 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75818769B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:43:31 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id i7so19649770ybt.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680101010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZF3AgcFtqgGpO60iEgE/VpjMgkSPsUVITQ8vjVr8tw=;
        b=bYHVBrYbjFKnwVQc+oSbH0aO1boPvLUHwnJakgPZubdfvnrzgXeWZOrvVbu8fqfPp8
         PMJ2EIoo4Ryf6hAzSweHqHCs7iLOsu69lUxBkU+yM6Q+hy59Nhjm67PT4HPvpwlqS+nF
         C78uiy2AEdagKFyXjciEjHqiGI28n5s2Bnu8t9RX5mDICPbIqT3JG9bHzs9OsXHoWWS8
         SfdgrZcb0o+fLljQPD4/PsGOE4LoGzbSyD6u7Kpr2QHyufPJ/OvhxQ/GvTr07K7IFVyu
         s+UPbi7PZ0NTNVy/veH8A3qN9ZKfb+Dg9ElP9YbqVLtzfEMh3Xc6De9YhVbLmbWRGoSL
         YemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680101010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZF3AgcFtqgGpO60iEgE/VpjMgkSPsUVITQ8vjVr8tw=;
        b=vjG35sussgfPu5mdEJdkKdWYlz6DFMvI3K9GNYkFiVr5SzKcKVt2pxhWDdJ8at/Kgt
         45M25G7jmSeA2np8CHBsw8b/Tr2A/RQQSakO0zLmusIfGl/WWX7rtb1JqzErQmeIsEA9
         P1amnN+AoeHLfYfdm4MVt8zmUIk1k2SZXDzMa4BU7zyWfyJdBa/l8psWsVqp+LCQ8xTy
         Y8kOnKyEz9IibRSDhWYURaLVkuRcxQr2gB/2ZDYLRetZam57D4V2UxX7YVJWXoBHoqwr
         DjUKUsv2hNlGPBS/UW3gnge2kGdLWmJVS345Dc3Hso+aPlw/2/xj72c+4PFLvt6bYjhf
         RoLg==
X-Gm-Message-State: AAQBX9dI1RIt/bDUbQhUC/7x4wB+2sgqZBrar/0I7H12HjI8/JMuzmne
        l53ESEiyUi5qG56WzrWXCR/j5EfY8g2tpS4x0HYRPw==
X-Google-Smtp-Source: AKy350bkVJFUGOJ4fGvEYsgcY1FSLfwT3yDuK+YuUkzV6Xv7XLerocMrkLsc9rq8nKymjJM/AyAgSB2kNV5hYHQ1HbI=
X-Received: by 2002:a05:6902:120c:b0:b74:77fa:581d with SMTP id
 s12-20020a056902120c00b00b7477fa581dmr10308565ybu.4.1680101010667; Wed, 29
 Mar 2023 07:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <0dcc1aac-9a6a-4d17-be68-a895cb6120da@app.fastmail.com>
In-Reply-To: <0dcc1aac-9a6a-4d17-be68-a895cb6120da@app.fastmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Mar 2023 16:43:19 +0200
Message-ID: <CACRpkdZSJCZZEkD0V_wint+a1XKsbCQFuArFvPdFP8RSDsGLMQ@mail.gmail.com>
Subject: Re: power_supply_show_property Kernel Oops
To:     Alistair <alistair@alistair23.me>
Cc:     ye.xingchen@zte.com.cn, sebastian.reichel@collabora.com,
        sre@kernel.org, pali@kernel.org, sravanhome@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 1:16=E2=80=AFPM Alistair <alistair@alistair23.me> w=
rote:

> [    2.466136]  string from vsnprintf+0x158/0x424
> [    2.470603]  vsnprintf from vscnprintf+0x10/0x24
> [    2.475241]  vscnprintf from sysfs_emit+0x50/0xac
> [    2.479975]  sysfs_emit from power_supply_show_property+0x1d0/0x26c
> [    2.486269]  power_supply_show_property from add_prop_uevent+0x30/0x8c
> [    2.492815]  add_prop_uevent from power_supply_uevent+0xb4/0xe4
> [    2.498753]  power_supply_uevent from dev_uevent+0xc4/0x21c
> [    2.504352]  dev_uevent from kobject_uevent_env+0x1cc/0x510
> [    2.509953]  kobject_uevent_env from power_supply_changed_work+0x7c/0x=
b4
> [    2.516675]  power_supply_changed_work from process_one_work+0x1e8/0x3=
e8
> [    2.523396]  process_one_work from worker_thread+0x2c/0x504
> [    2.528986]  worker_thread from kthread+0xcc/0xec
> [    2.533716]  kthread from ret_from_fork+0x14/0x24
> [    2.538443] Exception stack(0xf0dadfb0 to 0xf0dadff8)

This looks like running a worker before something this worker is accessing
has been set up.

> As it's on a consumer device I don't have a way to connect a debugger. So=
 I'm
> a little stuck on what the problem is. The only related change I see betw=
een
> 6.2 and 6.3-rc4 is commit a441f3b90a340e5c94df36c33fb7000193ee0aa7
> "power: supply: use sysfs_emit() instead of sprintf() for sysfs show()", =
but
> that doesn't look like it would cause this oops.

Did you try reverting it?

Yours,
Linus Walleij
