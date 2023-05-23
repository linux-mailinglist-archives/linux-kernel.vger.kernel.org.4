Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164E970D46F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbjEWG73 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 23 May 2023 02:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjEWG70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:59:26 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5D811A;
        Mon, 22 May 2023 23:59:25 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-ba80dc46972so10174654276.2;
        Mon, 22 May 2023 23:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684825165; x=1687417165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNsVXRmG+EgAtae57+cQUpNnpmiDiZt+9c6Bhc+ZY20=;
        b=jLK18kV4BXbqNB/UGAw8tWdbvZF6Xf++nIL0Q/UQfMrJb3l2YT0ZrVgwvPMHBcpKxp
         R5MQuBIY4PtFhPZPM0aN65gq24/fNOt45bJdnIf5VvIal+jSbMRqGmkW3XVKx64Q5cLL
         /8Lu59UW4dOPx1G9hCnqtowGpklEzDHlYOeN2eT9FkjhRLsEQyhAS4qTm48kWRjUcHfA
         aAKp2EXypaouY6R71VwU7GgzSI883HW/47jO4QPAawEWVLNIhYaNwyUMOp2zUrBhNqKt
         tkvZEm5fwBxuj485MGFcUThlAVe68rU3uTSq+/27BE8C5btk1KknygSANso7qD2lvR42
         hheg==
X-Gm-Message-State: AC+VfDwhDXL6CvW6NK5pnwAEnCgvigKHtPj5gvBeuUTqa2vA5VPiZHYO
        F2fyk8FgQNBwBuiBmsQHBAfBp1dcxZVXDw==
X-Google-Smtp-Source: ACHHUZ7MwoTjROpUJONFKLvrZBYoA/P03RqohdlWTIaJ0jIojhWspKe3UJVFWoncld+3/KnINMgHpA==
X-Received: by 2002:a25:5105:0:b0:b9d:853e:5ceb with SMTP id f5-20020a255105000000b00b9d853e5cebmr12171723ybb.47.1684825164695;
        Mon, 22 May 2023 23:59:24 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id b10-20020a81670a000000b00555d2944284sm2664885ywc.67.2023.05.22.23.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 23:59:23 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-ba80dc46972so10174597276.2;
        Mon, 22 May 2023 23:59:22 -0700 (PDT)
X-Received: by 2002:a0d:f407:0:b0:559:ea89:7c2c with SMTP id
 d7-20020a0df407000000b00559ea897c2cmr12284559ywf.33.1684825162595; Mon, 22
 May 2023 23:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683365892.git.fthain@linux-m68k.org> <9e66262a754fcba50208aa424188896cc52a1dd1.1683365892.git.fthain@linux-m68k.org>
 <CAMuHMdX_0F0hSZKqBBCN3876BmfwbQb1_+N3h-V8xs5ouRXF=A@mail.gmail.com> <14e09781-6ffd-0834-fba4-427e5030f2be@gmail.com>
In-Reply-To: <14e09781-6ffd-0834-fba4-427e5030f2be@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 23 May 2023 08:59:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXnofe1F3EJMkhjUb-hhFD5z0QERLHzpo0R7Ej05W=OWg@mail.gmail.com>
Message-ID: <CAMuHMdXnofe1F3EJMkhjUb-hhFD5z0QERLHzpo0R7Ej05W=OWg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] m68k: Move signal frame following exception on 68020/030
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Finn Thain <fthain@linux-m68k.org>,
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

Hi Michael,

On Tue, May 23, 2023 at 3:11 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> On 22/05/23 23:41, Geert Uytterhoeven wrote:
> > On Sat, May 6, 2023 at 11:36 AM Finn Thain <fthain@linux-m68k.org> wrote:
> >> On 68030/020, an instruction such as, moveml %a2-%a3/%a5,%sp@- may cause
> >> a stack page fault during instruction execution (i.e. not at an
> >> instruction boundary) and produce a format 0xB exception frame.
> >>
> >> In this situation, the value of USP will be unreliable. If a signal is to
> >> be delivered following the exception, this USP value is used to calculate
> >> the location for a signal frame. This can result in a corrupted user
> >> stack.
> >>
> >> The corruption was detected in dash (actually in glibc) where it showed
> >> up as an intermittent "stack smashing detected" message and crash
> >> following signal delivery for SIGCHLD.
> >>
> >> It was hard to reproduce that failure because delivery of the signal
> >> raced with the page fault and because the kernel places an unpredictable
> >> gap of up to 7 bytes between the USP and the signal frame.
> >>
> >> A format 0xB exception frame can be produced by a bus error or an address
> >> error. The 68030 Users Manual says that address errors occur immediately
> >> upon detection during instruction prefetch. The instruction pipeline
> >> allows prefetch to overlap with other instructions, which means an
> >> address error can arise during the execution of a different instruction.
> >> So it seems likely that this patch may help in the address error case also.
> >>
> >> Reported-and-tested-by: Stan Johnson <userm57@yahoo.com>
> >> Link: https://lore.kernel.org/all/CAMuHMdW3yD22_ApemzW_6me3adq6A458u1_F0v-1EYwK_62jPA@mail.gmail.com/
> >> Cc: Michael Schmitz <schmitzmic@gmail.com>
> >> Cc: Andreas Schwab <schwab@linux-m68k.org>
> >> Cc: stable@vger.kernel.org
> >> Co-developed-by: Michael Schmitz <schmitzmic@gmail.com>
> >> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> >> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > i.e. will queue as a fix in the m68k for-v6.4 branch.
> >
> > I plan to send this upstream later this week, so any additional
> > testing would be appreciated.
>
> I've given this some lengthy stress testing, and haven't seen it fail once.
>
> In contrast, various attempts of mine to improve on the concept (by only
> moving the signal frame away from the USP in case it's likely to clash)
> sometimes came up against a kernel bus error in setup_frame() when
> copying the signo to the signal frame. I must be making some incorrect
> assumptions still ...
>
> Limiting the signal frame shift to bus fault exceptions that happen
> mid-instruction is not too much of an overhead even in low memory
> settings, and using 256 bytes (the largest possible operand size, i.e.
> the largest adjustment to USP that might occur on completion of the
> interrupted instruction) did not seem to cause any issues with stack
> growth either.
>
> I can give this some more testing in ARAnyM (extending the stack shift
> to format 7 frames) but I'd say it's got as much testing on 030 hardware
> as we can do.

Thank you for your continued testing!
And thanks a lot to anyone involved in nailing this issue!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
