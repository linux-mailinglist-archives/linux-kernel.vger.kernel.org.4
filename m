Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1758170BC0C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbjEVLmA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 22 May 2023 07:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbjEVLlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:41:55 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2736491;
        Mon, 22 May 2023 04:41:54 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-bab8f66d3a2so4195931276.3;
        Mon, 22 May 2023 04:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684755713; x=1687347713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQM4CisG43A3UU9kY3EcQQPtrr37Ex7+82L60u0Ozu4=;
        b=LC08lqspjdG38GAzsFIr1jpeARXABreqOAOeWEnlOHIaQnPdri1Z25OIOvRvGROvS1
         wgrrhyJcGUupe185qx5hnwhrcMa8cPhVt50sG+OwEWufTsDrNN4irka17gj6ca/dc6IQ
         awrJeFaJ2M//hkcK2fn/dMiVlXJV78x0g+h88/dgVXfS2lSCPGLevdiHWEyGMiQCocTy
         p2RyqjJ/8DIaS3lpQIcTBuniwRlb9iPMpK0waUlXUyhubKog6ogpS7WBzYKzd1DU16M1
         VGHVJoYXqD+7LsSTDj0GZ/aVe1QCVjCB6ILxxC50i2UO9EbWTdCuEVcfZR6b51v7ETlT
         KPLg==
X-Gm-Message-State: AC+VfDyYe8G8/CXAmh694rZTvTmgaPmOH1wLOWx0u/w5Gt2Coz8u4bcK
        j2WzXNurEnlYIJWuxf58OwmWN+lDLgq1pA==
X-Google-Smtp-Source: ACHHUZ5VKvxtf6Kse2DGMCzYVvWNfgORAv2fVXZsosjW8b/YkDNF8g0HaTXPx3OcbCLCszcHjIyiTw==
X-Received: by 2002:a25:d2c4:0:b0:ba8:89c0:115d with SMTP id j187-20020a25d2c4000000b00ba889c0115dmr11307628ybg.58.1684755713200;
        Mon, 22 May 2023 04:41:53 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id o201-20020a2541d2000000b00b9e2ef25f1asm1453993yba.44.2023.05.22.04.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 04:41:53 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-561a7d96f67so77783297b3.3;
        Mon, 22 May 2023 04:41:52 -0700 (PDT)
X-Received: by 2002:a0d:ea43:0:b0:559:d3a0:4270 with SMTP id
 t64-20020a0dea43000000b00559d3a04270mr11018198ywe.34.1684755712500; Mon, 22
 May 2023 04:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683365892.git.fthain@linux-m68k.org> <9e66262a754fcba50208aa424188896cc52a1dd1.1683365892.git.fthain@linux-m68k.org>
In-Reply-To: <9e66262a754fcba50208aa424188896cc52a1dd1.1683365892.git.fthain@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 22 May 2023 13:41:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX_0F0hSZKqBBCN3876BmfwbQb1_+N3h-V8xs5ouRXF=A@mail.gmail.com>
Message-ID: <CAMuHMdX_0F0hSZKqBBCN3876BmfwbQb1_+N3h-V8xs5ouRXF=A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] m68k: Move signal frame following exception on 68020/030
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>, stable@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
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

On Sat, May 6, 2023 at 11:36 AM Finn Thain <fthain@linux-m68k.org> wrote:
> On 68030/020, an instruction such as, moveml %a2-%a3/%a5,%sp@- may cause
> a stack page fault during instruction execution (i.e. not at an
> instruction boundary) and produce a format 0xB exception frame.
>
> In this situation, the value of USP will be unreliable. If a signal is to
> be delivered following the exception, this USP value is used to calculate
> the location for a signal frame. This can result in a corrupted user
> stack.
>
> The corruption was detected in dash (actually in glibc) where it showed
> up as an intermittent "stack smashing detected" message and crash
> following signal delivery for SIGCHLD.
>
> It was hard to reproduce that failure because delivery of the signal
> raced with the page fault and because the kernel places an unpredictable
> gap of up to 7 bytes between the USP and the signal frame.
>
> A format 0xB exception frame can be produced by a bus error or an address
> error. The 68030 Users Manual says that address errors occur immediately
> upon detection during instruction prefetch. The instruction pipeline
> allows prefetch to overlap with other instructions, which means an
> address error can arise during the execution of a different instruction.
> So it seems likely that this patch may help in the address error case also.
>
> Reported-and-tested-by: Stan Johnson <userm57@yahoo.com>
> Link: https://lore.kernel.org/all/CAMuHMdW3yD22_ApemzW_6me3adq6A458u1_F0v-1EYwK_62jPA@mail.gmail.com/
> Cc: Michael Schmitz <schmitzmic@gmail.com>
> Cc: Andreas Schwab <schwab@linux-m68k.org>
> Cc: stable@vger.kernel.org
> Co-developed-by: Michael Schmitz <schmitzmic@gmail.com>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue as a fix in the m68k for-v6.4 branch.

I plan to send this upstream later this week, so any additional
testing would be appreciated.

Thanks!

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
