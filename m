Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF267428DC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjF2Ov4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 10:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjF2Ovy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:51:54 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83EB1FE9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 07:51:51 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-bd6446528dcso645918276.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 07:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688050311; x=1690642311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CuHzXkYO6WktZgqacN2d5anxPEIavrmgRvj43sdSK0=;
        b=gQDMIvF9nEZ3GOEvvjYsAl+wO8ap0ZOwZONa35Ym2Ueh6U/pEmU1ita5M5/7dT3QvR
         s4zHKf5EDOYRCwUHhaj6r2myj7LJ4RReYvhN86iayjux84ZxcKKmD3fzl2/58KHtzTlm
         b+R3haSxoWeIpmnlW1PeN9K1fL27sSDSMNau8Nqia4Jg2S2WnsLvICdNfAc20fg9AjTW
         op63vCFGRyeD3i5ek8RmB6T6vXGbrUzmTq9l92DktWETFUbrHEYqW/WE2LdFxx8PQSZ/
         qSb5f3TaNT/0x+auBdjkOx6Ph4GVm/eB+Uu7m2RXPnd43ucwfh4pmY7bDP+MBpoumOqC
         DdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688050311; x=1690642311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8CuHzXkYO6WktZgqacN2d5anxPEIavrmgRvj43sdSK0=;
        b=GIcCYdAhn4R/y1aiVQqAzQxiwM6Zp1FJtnAUvExhK+SDzBRv6KpYDIbPmTpJZrpPUC
         l6uGZITk+5AKj7kXmt5kOA9iGchB0b1iuB6W/CtxjTnwkSeRwBlbRry9WxvQ3C8wqbMo
         cIpciMazRYFRUUTezHOcar/T9DffQH3UO5efFoxHkXxZpMNmvI8CAH4UoWRWOkQxefop
         CZQ50DMWDecty0yOC4tpodBUAH5Na6Vwa4kpZ/Pd4OU6kV6+VEsRpsva2ZPvZPFwR/Vw
         Ng8g4JHx8O/eeaPNpXpitW42WEEPd7TbCgI1MzHOQmMWJKaJo6mtW1NW/X8SVq2crZT8
         jcpw==
X-Gm-Message-State: ABy/qLa7K8xKkIeiSLMyvbPTZIPAEDJWcdX5jTIgYl6mLL8BtuGVtQrC
        kaZFqqFxJv71Izt1S0Z8Ii+6jhEkjfVjxBIVe8/QBQ==
X-Google-Smtp-Source: APBJJlFSPqbJQOrS23qwdk4QL183t2gN/97lUZISRcM/UeHJMFD8MJoc6FfDNNrNHqbDJEGA7DtguUjE5QVh9EEpFLI=
X-Received: by 2002:a25:ae84:0:b0:bb1:6e29:a84d with SMTP id
 b4-20020a25ae84000000b00bb16e29a84dmr75966ybj.53.1688050310911; Thu, 29 Jun
 2023 07:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230621100151.6329-1-victorshihgli@gmail.com> <CAK00qKDgViDf=i5F2NNKBWO6HEeFtDcTQWSVbpLVFMkfKKi+1g@mail.gmail.com>
In-Reply-To: <CAK00qKDgViDf=i5F2NNKBWO6HEeFtDcTQWSVbpLVFMkfKKi+1g@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 29 Jun 2023 16:51:14 +0200
Message-ID: <CAPDyKFp4zM+r_SMAbCM6Sk9LvoAOGVsw56zn6P3z2zG2t86CEg@mail.gmail.com>
Subject: Re: [PATCH V8 00/23] Add support UHS-II for GL9755
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 at 12:24, Victor Shih <victorshihgli@gmail.com> wrote:
>
> Hi, Ulf and Adrian
>
> Excuse me, may I know the patch's status?
>
> If you already have a closer look at a paragraph in the series,
> could you let me know your comments first, let me check it first.
>
> I look forward to your reply.

I started the review but got sidetracked with some other things, but I
will get back to the review on Monday.

No matter what, I think you should send a new version as soon as
v6.5-rc1 is out - incorporating those comments you have received.

Br
Uffe

>
> Thanks, Victor Shih
>
> On Wed, Jun 21, 2023 at 6:01=E2=80=AFPM Victor Shih <victorshihgli@gmail.=
com> wrote:
> >
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> > These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup
> >   Sequence[2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence
> >   [2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include
> >   Section 3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II
> >   Setting Register Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Leg=
acy
> >   SD compatibility and preserve Legacy SD infrastructures (Section 7.1.=
1
> >   Packet Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-=
II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2])=
.
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the origina=
l
> >   interrupt registers.
> >
> > Patch structure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > patch#1-#6:  for core
> > patch#7-#22: for sdhci
> > patch#23:    for GL9755
> >
> > Changes in v8 (June. 21, 2023)
> > * rebased to the linux-kernel-v6.4.0-rc6 in Ulf Hansson next branch.
> > * fix most of checkpatch warnings/errors.
> > * according to the comments provided by Adrian Hunter to modify the
> >   patches base on the [V7 00/23] Add support UHS-II for GL9755.
> > * Patch#6: Add MMC_UHS2_SUPPORT to be cleared in sd_uhs2_detect().
> >            Modify return value in sd_uhs2_attach().
> > * Patch#7: Use tabs instead of spaces.
> > * Patch#8: Modify MODULE_LICENSE from "GPL v2" to "GPL".
> > * Patch#10: Adjust the position of matching brackets.
> > * Patch#11: Adjust the position of matching brackets.
> >             Add the initial value of the pwr in sdhci_uhs2_set_power().
> > * Patch#13: Initialization be combined with declaration and realigned
> >             in sdhci_calc_timeout_uhs2().
> >             Forward declare struct mmc_command in sdhci_uhs2.h.
> > * Patch#14: Add the judgment formula for MMC_TIMING_SPEED_A_HD,
> >             MMC_TIMING_SPEED_B and MMC_TIMING_SPEED_B_HD in
> >             __sdhci_uhs2_set_ios().
> >             Add the switch case for MMC_TIMING_SPEED_A_HD,
> >             MMC_TIMING_SPEED_B and MMC_TIMING_SPEED_B_HD in
> >             sdhci_get_preset_value().
> >             mmc_opt_regulator_set_ocr() to instead of
> >             mmc_regulator_set_ocr() in sdhci_uhs2_set_ios().
> > * Patch#15: usleep_range() to instead of udelay() in
> >             sdhci_uhs2_interface_detect().
> >             read_poll_timeout() to instead of read_poll_timeout_atomic(=
)
> >             in sdhci_uhs2_interface_detect().
> >             Modify return value in sdhci_uhs2_do_detect_init().
> > * Patch#16: Remove unnecessary include file.
> >             read_poll_timeout() to instead of read_poll_timeout_atomic(=
)
> >             in sdhci_uhs2_enable_clk().
> >             Put the comment on the end and put the lines in descending
> >             line length in sdhci_uhs2_enable_clk().
> >             Modify return value in sdhci_uhs2_enable_clk().
> > * Patch#17: Reorder the definitions and lose the parentheses in
> >             sdhci_uhs2_set_config().
> >             read_poll_timeout() to instead of read_poll_timeout_atomic(=
)
> >             in sdhci_uhs2_check_dormant().
> > * Patch#18: Adjust the position of matching brackets in
> >             sdhci_uhs2_send_command_retry().
> >             Modify CameCase definition in __sdhci_uhs2_finish_command()=
.
> >             Modify error message in __sdhci_uhs2_finish_command().
> >             sdhci_uhs2_send_command_retry() to instead of
> >             sdhci_uhs2_send_command() in sdhci_uhs2_request().
> >             Use sdhci_uhs2_mode() to simplify code in
> >             sdhci_uhs2_request_atomic().
> >             Add forward declaration for sdhci_send_command().
> > * Patch#19: Forward declare struct mmc_request in sdhci_uhs2.h.
> >             Remove forward declaration of sdhci_send_command().
> >             Use mmc_dev() to simplify code in sdhci_request_done_dma().
> > * Patch#20: Change return type to void for __sdhci_uhs2_add_host_v4().
> >             Remove unused variables in __sdhci_uhs2_add_host_v4().
> > * Patch#22: Add config select MMC_SDHCI_UHS2 in Kconfig.
> > * Patch#23: Use sdhci_get_vdd_value() to simplify code in
> >             gl9755_set_power().
> >             Use read_poll_timeout_atomic() to simplify code in
> >             sdhci_wait_clock_stable().
> >             Use read_poll_timeout_atomic() to simplify code in
> >             sdhci_gl9755_reset().
> >
> > Reference
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [1] https://gitlab.com/VictorShih/linux-uhs2.git
> > [2] SD Host Controller Simplified Specification 4.20
> > [3] UHS-II Simplified Addendum 1.02
> > [4] https://patchwork.kernel.org/project/linux-mmc/cover/20230331105546=
.13607-1-victor.shih@genesyslogic.com.tw/
> >
> > ----------------- original cover letter from v7 -----------------
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> > These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup Se=
quence
> >   [2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence=
[2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include=
 Section
> >   3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Setting R=
egister
> >   Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Leg=
acy SD
> >   compatibility and preserve Legacy SD infrastructures (Section 7.1.1 P=
acket
> >   Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-=
II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2])=
.
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the origina=
l
> >   interrupt registers.
> >
> > Patch structure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > patch#1-#6:  for core
> > patch#7-#22: for sdhci
> > patch#23:    for GL9755
> >
> > Changes in v7 (Mar. 31, 2023)
> > * rebased to the linux-kernel-v6.3.0-rc3 in Ulf Hansson next branch.
> > * according to the guidance and overall architecture provided
> >   by Ulf Hansson, Ben Chuang and Jason Lai to implement the
> >   UHS-2 Core function based on the patches of the [V4,0/6]
> >   Preparations to support SD UHS-II cards[5].
> > * according to the guidance and comments provided by
> >   Adrian Hunter, Ben Chuang and AKASHI Takahiro to implement
> >   the UHS-2 Host function based on the patches of the
> >   [RFC,v3.1,00/27] Add support UHS-II for GL9755[4].
> > * implement the necessary function to let the UHS-2 Core/Host
> >   work properly.
> > * fix most of checkpatch warnings/errors.
> > * according to the guidance and comments provided by
> >   Adrian Hunter, Ben Chuang to implement the UHS-2
> >   Host function based on the patches of the
> >   [V5,00/26] Add support UHS-II for GL9755[6].
> > * according to the guidance and comments provided by
> >   Ulf Hanssion, Adrian Hunter, Ben Chuang to implement the UHS-2
> >   Host function based on the patches of the
> >   [V6,00/24] Add support UHS-II for GL9755[7].
> > * The uhs2_post_attach_sd() function is no longer needed so drop
> >   the V6 version of the Patch#22.
> > * Modifies the usage of the flags used by the sdhci host for
> >   MMC_UHS2_INITIALIZED.
> > * Patch#1: Drop unnecessary bracket.
> > * Patch#2: Drop sd_uhs2_set_ios function.
> >            Used ->uhs2_control() callback for uhs2_set_ios
> >            in sd_uhs2_power_up().
> >            Used ->uhs2_control() callback for uhs2_set_ios
> >            in sd_uhs2_power_off().
> >            Drop MMC_TIMING_SD_UHS2 in favor of MMC_TIMING_UHS2_SPEED_A.
> >            Modify sd_uhs2_legacy_init to avoid the
> >            sd_uhs2_reinit cycle issue.
> > * Patch#5: Drop unnecessary definitions.
> > * Patch#6: Drop unnecessary function.
> >            Drop uhs2_state in favor of ios->timing.
> > * Patch#7: Reorder values and positions of definitions.
> > * Patch#9: Used sdhci_uhs2_mode function to simplify.
> > * Patch#11: Drop pwr variable in sdhci_uhs2_set_power function.
> > * Patch#14: Modify some descriptions.
> >             Drop unnecessary function.
> > * Patch#15: Drop using uhs2_reset ops and use sdhci_uhs2_reset function
> >             in the sdhci_do_detect_init function.
> > * Patch#17: Drop unnecessary function.
> > * Patch#18: Drop unnecessary whitespace changes.
> >             Cancel the export state of some functions.
> > * Patch#19: Drop unnecessary function.
> >             Used sdhci_uhs2_mode function to simplify.
> >             Modify some descriptions.
> >             Cancel the export state of some functions.
> > * Patch#20: Drop using __sdhci_uhs2_host function and use
> >             __sdhci_add_host function in sdhci_uhs2_add_host function.
> >             Cancel the export state of some functions.
> > * Patch#23: Drop using uhs2_post_attach_sd function.
> >
> > Reference
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [1] https://gitlab.com/ben.chuang/linux-uhs2-gl9755.git
> > [2] SD Host Controller Simplified Specification 4.20
> > [3] UHS-II Simplified Addendum 1.02
> > [4] https://patchwork.kernel.org/project/linux-mmc/cover/20201106022726=
.19831-1-takahiro.akashi@linaro.org/
> > [5] https://patchwork.kernel.org/project/linux-mmc/cover/20220418115833=
.10738-1-jasonlai.genesyslogic@gmail.com/
> > [6] https://patchwork.kernel.org/project/linux-mmc/cover/20221019110647=
.11076-1-victor.shih@genesyslogic.com.tw/
> > [7] https://patchwork.kernel.org/project/linux-mmc/cover/20221213090047=
.3805-1-victor.shih@genesyslogic.com.tw/
> >
> > ----------------- original cover letter from v6 -----------------
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> > These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup Se=
quence
> >   [2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence=
[2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include=
 Section
> >   3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Setting R=
egister
> >   Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Leg=
acy SD
> >   compatibility and preserve Legacy SD infrastructures (Section 7.1.1 P=
acket
> >   Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-=
II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2])=
.
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the origina=
l
> >   interrupt registers.
> >
> > Patch structure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > patch#1-#6:  for core
> > patch#7-#23: for sdhci
> > patch#24:    for GL9755
> >
> > Changes in v6 (Dec. 12, 2022)
> > * rebased to the linux-kernel-v6.1.0-rc8 in Ulf Hansson next branch.
> > * according to the guidance and overall architecture provided
> >   by Ulf Hansson, Ben Chuang and Jason Lai to implement the
> >   UHS-2 Core function based on the patches of the [V4,0/6]
> >   Preparations to support SD UHS-II cards[5].
> > * according to the guidance and comments provided by
> >   Adrian Hunter, Ben Chuang and AKASHI Takahiro to implement
> >   the UHS-2 Host function based on the patches of the
> >   [RFC,v3.1,00/27] Add support UHS-II for GL9755[4].
> > * implement the necessary function to let the UHS-2 Core/Host
> >   work properly.
> > * fix most of checkpatch warnings/errors.
> > * according to the guidance and comments provided by
> >   Adrian Hunter, Ben Chuang to implement the UHS-2
> >   Host function based on the patches of the
> >   [V5,00/26] Add support UHS-II for GL9755[6].
> > * The uhs2_post_attach_sd() has implemented in Patch#6 and
> >   Patch#17 so drop the V5 version of the Patch#23.
> > * Modifies the usage of the flags used by the sdhci host for
> >   MMC_UHS2_INITIALIZED.
> > * Patch#5: Drop unused definitions and functions.
> > * Patch#7: Rename definitions.
> >            Use BIT() GENMASK() in some cases.
> > * Patch#8: Merge V5 version of Patch[7] and Patch[9] into
> >            V6 version of Patch[8].
> > * Patch#9: Drop unnecessary function.
> >            Rename used definitions.
> > * Patch#10: Drop unnecessary function and simplify some code.
> > * Patch#11: Drop unnecessary function.
> >             Add new mmc_opt_regulator_set_ocr function.
> > * Patch#13: Drop unnecessary function.
> >             Use GENMASK() and FIELD_PREP() in some cases.
> > * Patch#14: Drop unnecessary function.
> >             Modify return value in some function.
> >             Use GENMASK() and FIELD_PREP() in some cases.
> > * Patch#15: Drop unnecessary function.
> >             Rename used definitions.
> >             Use GENMASK() and FIELD_GET() in some cases.
> >             Wrap at 100 columns in some functions.
> > * Patch#16: Drop unnecessary function.
> > * Patch#17: Drop unnecessary function.
> >             Drop the unnecessary parameter when call the DBG()
> >             function.
> >             Rename used definitions.
> >             Cancel the export state of some functions.
> >             Use GENMASK() and FIELD_PREP() in some cases.
> > * Patch#18: Drop unnecessary function.
> >             Add uhs2_dev_cmd function to simplify some functions.
> >             Rename used definitions.
> >             Cancel the export state of some functions.
> >             Use GENMASK() and FIELD_PREP() in some cases.
> > * Patch#19: Drop unnecessary function.
> >             Add sdhci_uhs2_mode() in some functions.
> >             Rename used definitions.
> >             Cancel the export state of some functions.
> > * Patch#20: Add new complete_work_fn/thread_irq_fn variables in
> >             struct sdhci_host.
> >             Use complete_work_fn/thread_irq_fn variables in
> >             sdhci_alloc_host()/sdhci_uhs2_add_host().
> >             Rename used definitions.
> > * Patch[24]: Rename used definitions.
> >
> > Reference
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [1] https://gitlab.com/ben.chuang/linux-uhs2-gl9755.git
> > [2] SD Host Controller Simplified Specification 4.20
> > [3] UHS-II Simplified Addendum 1.02
> > [4] https://patchwork.kernel.org/project/linux-mmc/cover/20201106022726=
.19831-1-takahiro.akashi@linaro.org/
> > [5] https://patchwork.kernel.org/project/linux-mmc/cover/20220418115833=
.10738-1-jasonlai.genesyslogic@gmail.com/
> > [6] https://patchwork.kernel.org/project/linux-mmc/cover/20221019110647=
.11076-1-victor.shih@genesyslogic.com.tw/
> >
> > ----------------- original cover letter from v5 -----------------
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> > These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup Se=
quence
> >   [2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence=
[2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include=
 Section
> >   3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Setting R=
egister
> >   Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Leg=
acy SD
> >   compatibility and preserve Legacy SD infrastructures (Section 7.1.1 P=
acket
> >   Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-=
II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2])=
.
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the origina=
l
> >   interrupt registers.
> >
> > Patch structure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > patch#1-#6:  for core
> > patch#7-#25: for sdhci
> > patch#26:    for GL9755
> >
> > Changes in v5 (Oct. 19, 2022)
> > * rebased to the linux-kernel-v6.1-rc1 in Ulf Hansson next branch.
> > * according to the guidance and overall architecture provided
> >   by Ulf Hansson, Ben Chuang and Jason Lai to implement the
> >   UHS-2 Core function based on the patches of the [V4,0/6]
> >   Preparations to support SD UHS-II cards[5].
> > * according to the guidance and comments provided by
> >   Adrian Hunter, Ben Chuang and AKASHI Takahiro to implement
> >   the UHS-2 Host function based on the patches of the
> >   [RFC,v3.1,00/27] Add support UHS-II for GL9755[4].
> > * implement the necessary function to let the UHS-2 Core/Host
> >   work properly.
> > * fix most of checkpatch warnings/errors
> >
> > Reference
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [1] https://gitlab.com/ben.chuang/linux-uhs2-gl9755.git
> > [2] SD Host Controller Simplified Specification 4.20
> > [3] UHS-II Simplified Addendum 1.02
> > [4] https://patchwork.kernel.org/project/linux-mmc/cover/20201106022726=
.19831-1-takahiro.akashi@linaro.org/
> > [5] https://patchwork.kernel.org/project/linux-mmc/cover/20220418115833=
.10738-1-jasonlai.genesyslogic@gmail.com/
> >
> > ----------------- original cover letter from v3.1 -----------------
> > This is an interim snapshot of our next version, v4, for enabling
> > UHS-II on MMC/SD.
> >
> > It is focused on 'sdhci' side to address Adrian's comments regarding
> > "modularising" sdhci-uhs2.c.
> > The whole aim of this version is to get early feedback from Adrian (and
> > others) on this issue. Without any consensus about the code structure,
> > it would make little sense to go further ahead on sdhci side.
> > (Actually, Adrian has made no comments other than "modularising" so far=
.)
> >
> > I heavily reworked/refactored sdhci-uhs2.c and re-organised the patch
> > set to meet what I believe Adrian expects; no UHS-II related code in
> > Legacy (UHS-I) code or sdhci.c.
> >
> > Nevertheless, almost of all changes I made are trivial and straightforw=
ard
> > in this direction, and I believe that there is no logic changed since v=
3
> > except sdhci_uhs2_irq(), as ops->irq hook, where we must deal with UHS-=
II
> > command sequences in addition to UHS-II errors. So I added extra handli=
ngs.
> >
> > I admit that there is plenty of room for improvements (for example,
> > handling host->flags), but again the focal point here is how sdhci-uhs2=
.c
> > should be built as a module.
> >
> > Please review this series (particularly Patch#8-#26 and #27) from this
> > viewpoint in the first place.
> > (Ben is working on 'host' side but there is no change on 'host' side
> > in this submission except a minor tweak.)
> >
> > Thanks,
> > -Takahiro Akashi
> >
> > ------ original cover letter from v3 ------
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> > These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup Se=
quence
> >   [2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence=
[2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include=
 Section
> >   3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Setting R=
egister
> >   Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Leg=
acy SD
> >   compatibility and preserve Legacy SD infrastructures (Section 7.1.1 P=
acket
> >   Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-=
II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2])=
.
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the origina=
l
> >   interrupt registers.
> >
> > Patch structure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > patch#1-#7: for core
> > patch#8-#17: for sdhci
> > patch#18-#21: for GL9755
> >
> > Tests
> > =3D=3D=3D=3D=3D
> > Ran 'dd' command to evaluate the performance:
> > (SanDisk UHS-II card on GL9755 controller)
> >                              Read    Write
> > UHS-II disabled (UHS-I): 88.3MB/s 60.7MB/s
> > UHS-II enabled         :  206MB/s   80MB/s
> >
> > TODO
> > =3D=3D=3D=3D
> > - replace some define with BIT macro
> >
> > Reference
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [1] https://gitlab.com/ben.chuang/linux-uhs2-gl9755.git
> > [2] SD Host Controller Simplified Specification 4.20
> > [3] UHS-II Simplified Addendum 1.02
> >
> > Changes in v3 (Jul. 10, 2020)
> > * rebased to v5.8-rc4
> > * add copyright notice
> > * reorganize the patch set and split some commits into smaller ones
> > * separate uhs-2 headers from others
> > * correct wrong spellings
> > * fix most of checkpatch warnings/errors
> > * remove all k[cz]alloc() from the code
> > * guard sdhci-uhs2 specific code with
> >       'if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2))'
> > * make sdhci-uhs2.c as a module
> > * trivial changes, including
> >   - rename back sdhci-core.c to sdhci.c
> >   - allow vendor code to disable uhs2 if v4_mode =3D=3D 0
> >       in __sdhci_add_host()
> >   - merge uhs2_power_up() into mmc_power_up()
> >   - remove flag_uhs2 from mmc_attach_sd()
> >   - add function descriptions to EXPORT'ed functions
> >   - other minor code optimization
> >
> > Changes in v2 (Jan. 9, 2020)
> > * rebased to v5.5-rc5
> >
> > Victor Shih (23):
> >   mmc: core: Cleanup printing of speed mode at card insertion
> >   mmc: core: Prepare to support SD UHS-II cards
> >   mmc: core: Announce successful insertion of an SD UHS-II card
> >   mmc: core: Extend support for mmc regulators with a vqmmc2
> >   mmc: core: Add definitions for SD UHS-II cards
> >   mmc: core: Support UHS-II card control and access
> >   mmc: sdhci: add UHS-II related definitions in headers
> >   mmc: sdhci: add UHS-II module and add a kernel configuration
> >   mmc: sdhci-uhs2: dump UHS-II registers
> >   mmc: sdhci-uhs2: add reset function and uhs2_mode function
> >   mmc: sdhci-uhs2: add set_power() to support vdd2
> >   mmc: sdhci-uhs2: skip signal_voltage_switch()
> >   mmc: sdhci-uhs2: add set_timeout()
> >   mmc: sdhci-uhs2: add set_ios()
> >   mmc: sdhci-uhs2: add detect_init() to detect the interface
> >   mmc: sdhci-uhs2: add clock operations
> >   mmc: sdhci-uhs2: add uhs2_control() to initialise the interface
> >   mmc: sdhci-uhs2: add request() and others
> >   mmc: sdhci-uhs2: add irq() and others
> >   mmc: sdhci-uhs2: add add_host() and others to set up the driver
> >   mmc: sdhci-uhs2: add pre-detect_init hook
> >   mmc: sdhci-pci: add UHS-II support framework
> >   mmc: sdhci-pci-gli: enable UHS-II mode for GL9755
> >
> >  drivers/mmc/core/Makefile         |    2 +-
> >  drivers/mmc/core/block.c          |   18 +-
> >  drivers/mmc/core/bus.c            |   38 +-
> >  drivers/mmc/core/core.c           |   25 +-
> >  drivers/mmc/core/core.h           |    1 +
> >  drivers/mmc/core/host.h           |    7 +
> >  drivers/mmc/core/mmc_ops.c        |   25 +-
> >  drivers/mmc/core/mmc_ops.h        |    1 +
> >  drivers/mmc/core/regulator.c      |   34 +
> >  drivers/mmc/core/sd.c             |   13 +-
> >  drivers/mmc/core/sd.h             |    4 +
> >  drivers/mmc/core/sd_ops.c         |   11 +
> >  drivers/mmc/core/sd_ops.h         |   18 +
> >  drivers/mmc/core/sd_uhs2.c        | 1367 +++++++++++++++++++++++++++++
> >  drivers/mmc/host/Kconfig          |   10 +
> >  drivers/mmc/host/Makefile         |    1 +
> >  drivers/mmc/host/sdhci-pci-core.c |   16 +-
> >  drivers/mmc/host/sdhci-pci-gli.c  |  233 ++++-
> >  drivers/mmc/host/sdhci-pci.h      |    3 +
> >  drivers/mmc/host/sdhci-uhs2.c     | 1321 ++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-uhs2.h     |  192 ++++
> >  drivers/mmc/host/sdhci.c          |  278 +++---
> >  drivers/mmc/host/sdhci.h          |   75 +-
> >  include/linux/mmc/card.h          |   36 +
> >  include/linux/mmc/core.h          |   13 +
> >  include/linux/mmc/host.h          |   89 ++
> >  include/linux/mmc/sd_uhs2.h       |  240 +++++
> >  27 files changed, 3911 insertions(+), 160 deletions(-)
> >  create mode 100644 drivers/mmc/core/sd_uhs2.c
> >  create mode 100644 drivers/mmc/host/sdhci-uhs2.c
> >  create mode 100644 drivers/mmc/host/sdhci-uhs2.h
> >  create mode 100644 include/linux/mmc/sd_uhs2.h
> >
> > --
> > 2.25.1
> >
