Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B89267B5EB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbjAYP3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbjAYP3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:29:35 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B066546733
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 07:29:32 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id v19so3643218qtq.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 07:29:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3g/bTcIABXhuOTGEfGmYgpildLrwGp+xtHqxezjbAIo=;
        b=n3udKgQdMP4pzkzNTyzAZ8aA4cXK/Wr696HNOYfmxGhfSHnA7GysozYmADxTuy3bQ5
         G9sqO79szHSCm+/z6pb7m2PydCzBXwuDNsykOWBjywBH2/waEek0FcLbvF9JQxWHccom
         RWPiJFQ7yKcOU6/CC7CaAOB23rXkakoeO2kqP+yRuwV2imqNgVshjjulK7E2aIHksHyu
         Zcu/+wUsZABfe382eTh1WNs/LefIwWfNf3iYm1lKcAnPyiZ6oUBC80hlCUVdp7M0kHds
         aJAdRFdw95k6YpC7KZ1b8bOvAx9LeQg9VQ4Rqne4/uqRollA3Ey5SAt8if8gmCEowFkD
         parQ==
X-Gm-Message-State: AFqh2krVFpVIZGkaFSuibtMkIEsZuzu9fUpdsG6KKVSNvoD78ASu5MK1
        GEyZ9z83N/XWFg63eoxYcLtwuJ+CyaNBiA==
X-Google-Smtp-Source: AMrXdXsTM4Px1fobhacOBtaZf4DhDWUGv+jMbuEqTev+8AAUdPhvAWBCOkQsbKRdIiQqrRdgtDl2hg==
X-Received: by 2002:ac8:754f:0:b0:3b6:3a95:e012 with SMTP id b15-20020ac8754f000000b003b63a95e012mr46610542qtr.53.1674660571650;
        Wed, 25 Jan 2023 07:29:31 -0800 (PST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id y27-20020a05620a09db00b006cfc9846594sm3686812qky.93.2023.01.25.07.29.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 07:29:31 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-50112511ba7so209548937b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 07:29:30 -0800 (PST)
X-Received: by 2002:a81:1216:0:b0:506:6b5d:523c with SMTP id
 22-20020a811216000000b005066b5d523cmr193364yws.283.1674660570612; Wed, 25 Jan
 2023 07:29:30 -0800 (PST)
MIME-Version: 1.0
References: <20230105033705.3946130-1-leyfoon.tan@starfivetech.com>
In-Reply-To: <20230105033705.3946130-1-leyfoon.tan@starfivetech.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 25 Jan 2023 16:29:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWo=6jR5WEWkdDWVCs0bUPFL3gyTVM_3HWh+SLCxQV5Gw@mail.gmail.com>
Message-ID: <CAMuHMdWo=6jR5WEWkdDWVCs0bUPFL3gyTVM_3HWh+SLCxQV5Gw@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: Move call to init_cpu_topology() to later
 initialization stage
To:     Ley Foon Tan <leyfoon.tan@starfivetech.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ley Foon Tan <lftan.linux@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>
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

Hi Ley,

On Thu, Jan 5, 2023 at 4:45 AM Ley Foon Tan
<leyfoon.tan@starfivetech.com> wrote:
> If "capacity-dmips-mhz" is present in a CPU DT node,
> topology_parse_cpu_capacity() will fail to allocate memory.
> ARM64, with which this code path is shared, does not call
> topology_parse_cpu_capacity() until later in boot where memory allocation
> is available.
>
> Move init_cpu_topology(), which calls topology_parse_cpu_capacity(), to a
> later initialization stage, to match ARM64.
>
> Tested on Qemu platform.
>
> Fixes: 03f11f03dbfe ("RISC-V: Parse cpu topology during boot.")
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
>
> ---
> Changes:
> v2:
> - Update commit description with suggestion from Conor.
> - Added Reviewed-by.
> - Added Fixes.

This also fixes the error message

    Early cacheinfo failed, ret = -12

seen during early boot on all my RV64 platforms.

Fixes: 5944ce092b97caed ("arch_topology: Build cacheinfo from primary CPU")
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
