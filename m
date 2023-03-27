Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6225D6C9B87
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 08:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjC0Gsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 02:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjC0Gse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 02:48:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A1249C5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 23:48:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 147E0B80DAF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C89C43443
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679899706;
        bh=qoCwbQa9yJKqGGJPhoYr2N4l5H+s4bPnSYnKpLsXKt0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GqRihggKLaHBnnuVWjeT43NOO8bAds3k1IG/YtRt4NGfn6xs6BmkW97Wx5RfyQpPf
         zYo4e4v1T1zCX2IEToC4jWhKtwz1L8uDwxSBrhoX7RBI0Y1Mjt8qjRnsBEeMDkDaU6
         ySGQs7vh6U+phOPLgkQugZHS20dM+H1kHpqqAtjmpJ/qyEfMScbMcS0BadnOfTvGCI
         txvFq70FppAtkt7kbLb9gVMbdUOKCubOYGCqu7da5jiNMhTywFEaxOGUZgIWrPVpGA
         fSFiyoozB/LZjqD6tD+KJ49+6rvuwkniSxhZRtd31b00ZZyINFzObjRRWJjGAe9e+F
         t7AzT9Tiw52kg==
Received: by mail-qk1-f179.google.com with SMTP id z33so2100645qko.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 23:48:26 -0700 (PDT)
X-Gm-Message-State: AO0yUKVHg9sBHGogJe2YlZoWLyWeCWTuXtCBhj9aFZK9qE+tuvgsbzt2
        BwtEV9//aqepSj5Azm5ET11+EGn/RkreD7vTp6c=
X-Google-Smtp-Source: AK7set8S6iCTqQhhwC/lflTHTfz7vlwdY+o6PFRAZ6lqhSrHl5LDlNFhVFVJnN1z0GFVzIfM6MJQpojCDgqQt9I/v4I=
X-Received: by 2002:a05:620a:1aa3:b0:72b:25b4:5660 with SMTP id
 bl35-20020a05620a1aa300b0072b25b45660mr4100144qkb.6.1679899705860; Sun, 26
 Mar 2023 23:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230323123924.3032174-1-suagrfillet@gmail.com> <20230323172403.nfrtgm5vea4qvinu@orel>
In-Reply-To: <20230323172403.nfrtgm5vea4qvinu@orel>
From:   Ley Foon Tan <lftan@kernel.org>
Date:   Mon, 27 Mar 2023 14:48:13 +0800
X-Gmail-Original-Message-ID: <CAFiDJ5-=X1z-WZz-BKpcUDU+yN93s5cDXy2YZD1HfMCBjPqKWA@mail.gmail.com>
Message-ID: <CAFiDJ5-=X1z-WZz-BKpcUDU+yN93s5cDXy2YZD1HfMCBjPqKWA@mail.gmail.com>
Subject: Re: [PATCH V2] riscv: export cpu/freq invariant to scheduler
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Song Shuai <suagrfillet@gmail.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 1:52=E2=80=AFAM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Thu, Mar 23, 2023 at 08:39:24PM +0800, Song Shuai wrote:
> > RISC-V now manages CPU topology using arch_topology which provides
> > CPU capacity and frequency related interfaces to access the cpu/freq
> > invariant in possible heterogeneous or DVFS-enabled platforms.
> >
> > Here adds topology.h file to export the arch_topology interfaces for
> > replacing the scheduler's constant-based cpu/freq invariant accounting.
> >
> > Signed-off-by: Song Shuai <suagrfillet@gmail.com>
Thanks for submitting this.

Reviewed-by: Ley Foon Tan <lftan@kernel.org>

Regards
Ley Foon
