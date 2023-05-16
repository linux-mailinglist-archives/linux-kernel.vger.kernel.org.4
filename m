Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EE37045D0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjEPHLG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 16 May 2023 03:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjEPHLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:11:03 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4C52697
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:11:02 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-559debdedb5so202966157b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684221061; x=1686813061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLKEBtcsn7izVRwefw1phNZul3WTWfMY8k8wmlvyiKA=;
        b=fvJCPZe4EB2fX4elok6dO9nruMgku+AsbyZMuNJncB30gAoD9lVukmc9I86FUmsjoI
         LhW42he8UtqGVAuLJF2LuzMkfsab0AmWtLSxOX9I0kIPIdIQSBQOAkaFzvouBHVCAWRd
         /iUUa3K6bKbWyP5oELsK4JStofZrmHjiRkyRei0ddgm27yVu0ZEUralY+jMIXhwXsNe6
         xxdlzDFaOUXTty2ELm4TRoiW58c7kOPSNQxcLMXhodZMyH4+BhPpCoXmuauJ2NmDU3Gc
         aOLot4U1wRO8JI1KnG7mcxmRs11VP+0K3ICibkQvdGC/whQclNpXzVBGiq5CAWjOwLyf
         rY8A==
X-Gm-Message-State: AC+VfDwfgPuqsTn+ymX25DoWndG588G6DLbdKIRjhn+gQpb8QbxG2H6L
        RQtTwDdMF/p8bCR6K4GqG7Ui57tbC1IpNw==
X-Google-Smtp-Source: ACHHUZ6lr56Ab2z1sCArr+45EoscY2ZwPcEqQALqYgOhnLSJm9Cik2sfkuHaAwePVoepWszTfeWp6g==
X-Received: by 2002:a0d:d182:0:b0:55a:4f00:b05c with SMTP id t124-20020a0dd182000000b0055a4f00b05cmr32696311ywd.33.1684221060993;
        Tue, 16 May 2023 00:11:00 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id i2-20020a815402000000b00545a08184cesm402562ywb.94.2023.05.16.00.11.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 00:11:00 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-ba7854ff5abso4366019276.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:11:00 -0700 (PDT)
X-Received: by 2002:a05:6902:18d6:b0:ba7:b446:f5a4 with SMTP id
 ck22-20020a05690218d600b00ba7b446f5a4mr6935547ybb.8.1684221059889; Tue, 16
 May 2023 00:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <71ed7fb234a5f7381a50253b0d841a656d53e64c.1684200125.git.fthain@linux-m68k.org>
In-Reply-To: <71ed7fb234a5f7381a50253b0d841a656d53e64c.1684200125.git.fthain@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 16 May 2023 09:10:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVi_vtqCD9QA-WqTya=GyPvXg0Ey3sTywcRy0HKCutHAg@mail.gmail.com>
Message-ID: <CAMuHMdVi_vtqCD9QA-WqTya=GyPvXg0Ey3sTywcRy0HKCutHAg@mail.gmail.com>
Subject: Re: [PATCH v5] nubus: Don't list slot resources by default
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Brad Boyer <flar@allandria.com>, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 4:05 AM Finn Thain <fthain@linux-m68k.org> wrote:
> Some Nubus card ROMs contain many slot resources. A single Radius video
> card produced well over a thousand entries under /proc/bus/nubus/.
> Populating /proc/bus/nubus/ on a slow machine with several such cards
> installed takes long enough that the user may think that the system is
> wedged. All those procfs entries also consume significant RAM though
> they are not normally needed (except by developers).
> Omit these resources from /proc/bus/nubus/ by default and add a kernel
> parameter to enable them when needed.
> On the test machine, this saved 300 kB and 10 seconds.
>
> Cc: Brad Boyer <flar@allandria.com>
> Reviewed-by: Brad Boyer <flar@allandria.com>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
> Changed since v4:
>  - Renamed the new global variable and adopted module_param_named().

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v6.5 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
