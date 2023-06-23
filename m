Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B3273B49D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjFWKI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFWKIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:08:24 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AE33A85
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:07:07 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-4007b5bafceso147391cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687514787; x=1690106787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeE7xHGh5BoawYEOt4ThIFuaOS5BUT8iekYZGw863k4=;
        b=azRA7sL5R8qrN7SnHIeAC1LPHxysPAI7YWnaP3u1HWJrAh1332iiQcoVL+P65H6nP/
         PhFDe5EYZ6byvVrtb+hNxjpUa3OYAPcH7iOIJ/faDUUK57rHA3DfDjin4oEM3X4amZTV
         +OLXKbinCYRG59ojwCwTTXpkYVXt5jWenwc5s21BDx70/KOBj450gOWx6Sb6Aw7jNlHw
         QvyTDyXEFfuvT5AzF8Uxnc7B0Z5rPinV09sZuhiGeA2HGA1BxTURhZfD1mMZAb2aC7AJ
         aF824EZ6d3X4/ONa++Gg0L4UuUaDZklJwl7A+WVWH+egRDeyvdeXEJlF+OZvyMiGkx1f
         WrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687514787; x=1690106787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeE7xHGh5BoawYEOt4ThIFuaOS5BUT8iekYZGw863k4=;
        b=EkYNLu/4pZAwKAa0G+KPO0W4w5tSn0HTcNytD4gSI3x/r01AKlurjbPNqrDcCBKNvz
         abqjY4vlkAwCAOLSYr+1EReFW8e/SET4fshzSiliqjSC+PKv7rvDQwc5o97BlwSzvVal
         Wt8Z9pPgrmLUV13Tc7TOuJY5YzTSFpOwwAHTNWygR0LUqnL0RptgnkaMxv3lHrTg4tX4
         Rg3RPtJKBc4JTJKX+8kEB7GeGwHjnMHkc/hjLWuPzVywwin8mvRYbi4HirhCcseUDuX3
         HI+Z5pOJrDEZfHuU4Ps3C0OUdNaRgukzoMNPrnWTJLYe28muK8jv8tuAOVilS9IN2ZqM
         btpg==
X-Gm-Message-State: AC+VfDxVg8rwQBbH6Tt2N6XCL01HqkV1XX1HhlvupDBz7+u5lItzH6xN
        OMKpkgPBK8c+8oIqk4DZMNqKjiZJFdz9reaaxzzsRw==
X-Google-Smtp-Source: ACHHUZ4pBWQzbNhpU+SPC0BWsmXYyE3Pfd5hn3ounZJ4aKkWvw7a43GpcqQ18cKiSiQkZVs2wazXp4LpcA+PEtMPKkE=
X-Received: by 2002:a05:622a:1b92:b0:3f8:5b2:aef4 with SMTP id
 bp18-20020a05622a1b9200b003f805b2aef4mr82692qtb.28.1687514786611; Fri, 23 Jun
 2023 03:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230622150423.3726894-1-kyletso@google.com> <20230622150423.3726894-4-kyletso@google.com>
 <2023062345-hassle-septic-b8b4@gregkh>
In-Reply-To: <2023062345-hassle-septic-b8b4@gregkh>
From:   Kyle Tso <kyletso@google.com>
Date:   Fri, 23 Jun 2023 18:06:10 +0800
Message-ID: <CAGZ6i=3BP4ssx31roJoGL_VT=o3mq9Lj_VfZ_HSywzPOEt3v7g@mail.gmail.com>
Subject: Re: [PATCH 3/3] usb: typec: Use sysfs_emit_at when concatenating the string
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     heikki.krogerus@linux.intel.com, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 3:51=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Jun 22, 2023 at 11:04:23PM +0800, Kyle Tso wrote:
> > The buffer address used in sysfs_emit should be aligned to PAGE_SIZE.
>
> Why?  Are you getting warnings about this?
>
> thanks,
>
> greg k-h

Yes, here is the warning.

[  223.243123] invalid sysfs_emit: buf:00000000eda2d647
[  223.243197] WARNING: CPU: 4 PID: 8860 at fs/sysfs/file.c:735
sysfs_emit+0xb0/0xc0
[  223.244335] CPU: 4 PID: 8860 Comm: cat
[  223.244363] pstate: 62400005 (nZCv daif +PAN -UAO +TCO -DIT -SSBS BTYPE=
=3D--)
[  223.244378] pc : sysfs_emit+0xb0/0xc0
[  223.244394] lr : sysfs_emit+0xac/0xc0
...
[  223.244560] Call trace:
[  223.244568] sysfs_emit+0xb0/0xc0
[  223.244582] select_usb_power_delivery_show+0x134/0x18c
[  223.244626] dev_attr_show+0x38/0x74
[  223.244654] sysfs_kf_seq_show+0xb4/0x130
[  223.244668] kernfs_seq_show+0x44/0x54
[  223.244683] seq_read_iter+0x158/0x4ec
[  223.244727] kernfs_fop_read_iter+0x68/0x1b0
[  223.244739] vfs_read+0x1d8/0x2b0
[  223.244775] ksys_read+0x78/0xe8

The warning comes from
https://elixir.bootlin.com/linux/v6.3.9/source/fs/sysfs/file.c#L734

if (WARN(!buf || offset_in_page(buf), "invalid sysfs_emit: buf:%p\n", buf))
        return 0;

Kyle
