Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB14F6E112E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjDMPcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjDMPcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:32:45 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60A210F3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:32:44 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54fb615ac3dso76263967b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681399964; x=1683991964;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4Nc75iyNukd0UR0rxIxhX/z29BaqR72KzPmAyeHJwIc=;
        b=JAHnYmaeyTzRiLuZOeQwhE+KlzFkog2WLQuO5+Xkls1cIPq0GtTSILEI+jyF9oM1Lp
         7nliktTEq54GI2VPALYRdUSraMquQlNFMdAo10UETOI+Tz1TPQy6EV3j6fHm0vYHezZB
         o5hmHMXOcLAAW74yS2QsvKxM3CSBad619AN+HW1nXsfgeDb9NLbg4X4hDL7VMKmmAVol
         285REognpebbHdRDxuM9at/5EbEQLUN+x0k5pWd3yDm7e7DutIMVTPbEmSEzpCoF0yRC
         ijz9NVP7AkftSMBuH9k9IKN/kg8xJV1VAd5DzjidgGCZi9rkXWOOAwe3ziCQwGLAR6kt
         cbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681399964; x=1683991964;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Nc75iyNukd0UR0rxIxhX/z29BaqR72KzPmAyeHJwIc=;
        b=GgJ6Zlr4+DAPWBr9v1tcnQ3yO2si60hmnTDm53pwiQDiRjIJtGrGmMPCDnXveLeitb
         SnULeY0YQql8lkskEFnLnVXZVEKom1PHiRsF3Cn4DQF1orz31gInNsS81Kw9ZW/0ZcWJ
         kdywH7PXiWC8VtfZvSRhaaNBbgtTzzC+2G2kO9THTxUUQS1beIfbLMcxkItT3LSG00aw
         fowyvrUSnjhLmVOEMsD5WOH3UirdOx8ShCwGGqXFBFfO7PzgZ0Ka/w9oqu4yldiMmLMh
         3TFswGOS4ZkSLG54WX1HZh5/6IuqVqPl7nAfkVAi4aHj0PcMV8nzv5K4Zr/3gCwLzOUK
         ycww==
X-Gm-Message-State: AAQBX9diFDIo5Q5N1IPvhUvqaZOs8bdzk1x8T6BvFmU6VuStCUznIJjZ
        y28ZjCwlt3UVjj9rC2UGPO/Mp88yQTf0f1PdgPo1gmBXsQ==
X-Google-Smtp-Source: AKy350aW7/Rt5uV9WGKym2asTJbmxp7nWKlm8h8QUtBJ9JRBKTw2Rz6Yer8O3p7N71ttmVpgZM2dMRD0CuuQdndOY0g=
X-Received: by 2002:a81:1b8e:0:b0:533:a15a:d33e with SMTP id
 b136-20020a811b8e000000b00533a15ad33emr5024977ywb.5.1681399964024; Thu, 13
 Apr 2023 08:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvZ=Y1psyd0nmfzm6GhqMKvq5V_NQCWb_X02nasp1CpfcQ@mail.gmail.com>
 <87r0spcuvi.fsf@intel.com> <CALjTZvao=N7wxyj_DpqzWUhdJwEsWSKUo3ddi-3ubgMp8BXi_Q@mail.gmail.com>
 <CALjTZvaf1cwcZc9O8g24SnZXsoQaWB97UVQW=g6M0coaudLr6w@mail.gmail.com> <2495408f-a644-4e56-aaca-e6915cbda179@paulmck-laptop>
In-Reply-To: <2495408f-a644-4e56-aaca-e6915cbda179@paulmck-laptop>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Thu, 13 Apr 2023 16:32:32 +0100
Message-ID: <CALjTZva=JHsckrBeHgJcd-_TDMgYgmZGcXavJ=GhPr7VQCOF5g@mail.gmail.com>
Subject: Re: [BUG?] INFO: rcu_sched detected expedited stalls on CPUs/tasks: {
 0-.... } 3 jiffies s: 309 root: 0x1/.
To:     paulmck@kernel.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Paul,

On Thu, 13 Apr 2023 at 15:43, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> My guess would be that you have CONFIG_RCU_EXP_CPU_STALL_TIMEOUT set to
> some small non-zero number, for example, you might have set up a recent
> Android .config or some such.  The default of zero would give you about
> 21 seconds rather than the three jiffies that you are seeing.
>
> Could you please check your .config?

Well, this is embarrassing. I can't fathom why/how, but I had it set
to 20, on this machine. That is, 20 millisseconds. I guess its a
miracle I haven't seen *more* expedited RCU traces. Sorry for the
noise, everyone.

Kind regards,
Rui
