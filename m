Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715FB637045
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 03:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiKXCL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 21:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiKXCL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 21:11:26 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320B67A36B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 18:11:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9DBD8CE2900
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD92CC433D7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669255881;
        bh=aWddWUx0AZ/iMRswl/0aJwc4jU1YZ8q4N7G5Olz8gEs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S4xD2m5JrTTjrTdGB6OufjM9XBq7qn/3lBTvfG3yofNOlwL8lnYzlFvbqJ2Hj2Nvl
         XEOHQLniFly5xkxC2gEHiIdgyEuk3C747UaRB9vPlFD73ompgIssfUQ+/Q6SbreRVK
         eolI6M4JPbk9A/pNO6anI+Ecm8GpaJzPD1c+FLojThH+YVzICFhkVWiSsJiLxboNfh
         kIO43vwKFgQQBVEIHikQxb2zjGXMM7xWHxSP5FsEAYM6YjqVLfj0KYVsCwHMORK9Jn
         PFeLqFVcOSK+WDCP8iMMM0gb9RLGznyp/JvUQTRUZh6g6lMuRpOo2UbSxvwcHRJHQ2
         pFIcshfXjrGrg==
Received: by mail-ej1-f43.google.com with SMTP id m22so1110806eji.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 18:11:21 -0800 (PST)
X-Gm-Message-State: ANoB5plc2lUQ4+/+qycBzyO1DYMeKndoG+z8Pl7sKWeCG/H/nwk8FP+J
        sRN4XaJ0HvqV5/H2/6A9gqzTdCjXCRjZ7A7stIo=
X-Google-Smtp-Source: AA0mqf5HyUyBtc97QMSmbkfZYL/PjOOZssuhtU70mcua2SSk0jy0TtUGzulL3B4h0bIny8vcZtw/J1eS7m19LkKkuUw=
X-Received: by 2002:a17:906:6a8e:b0:78d:a136:7332 with SMTP id
 p14-20020a1709066a8e00b0078da1367332mr25742071ejr.355.1669255880060; Wed, 23
 Nov 2022 18:11:20 -0800 (PST)
MIME-Version: 1.0
References: <20221123153950.2911981-1-guoren@kernel.org> <20221123153950.2911981-4-guoren@kernel.org>
 <Y35783GmAtJ+JuGW@spud>
In-Reply-To: <Y35783GmAtJ+JuGW@spud>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 24 Nov 2022 10:11:08 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ1mpa3a9s4T-Q52Z6tugp0jMN4utdrT77ibXv3b52bQw@mail.gmail.com>
Message-ID: <CAJF2gTQ1mpa3a9s4T-Q52Z6tugp0jMN4utdrT77ibXv3b52bQw@mail.gmail.com>
Subject: Re: [PATCH V3 3/5] riscv: ftrace: Reduce the detour code size to half
To:     Conor Dooley <conor@kernel.org>
Cc:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, rostedt@goodmis.org,
        mhiramat@kernel.org, jolsa@redhat.com, bp@suse.de,
        jpoimboe@kernel.org, suagrfillet@gmail.com, andy.chiu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 4:00 AM Conor Dooley <conor@kernel.org> wrote:
>
> On Wed, Nov 23, 2022 at 10:39:48AM -0500, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Use a temporary register to reduce the size of detour code from
> > 16 bytes to 8 bytes. The previous implementation is from
> > afc76b8b8011 ("riscv: Using PATCHABLE_FUNCTION_ENTRY instead of
> > MCOUNT").
> >
> > Before the patch:
> > <func_prolog>:
> >  0: REG_S  ra, -SZREG(sp)
> >  4: auipc  ra, ?
> >  8: jalr   ?(ra)
> > 12: REG_L  ra, -SZREG(sp)
> >  (func_boddy)
> >
> > After the patch:
> > <func_prolog>:
> >  0: auipc  t0, ?
> >  4: jalr   t0, ?(t0)
> >  (func_boddy)
> >
> > Link: https://lore.kernel.org/linux-riscv/20221122075440.1165172-1-suagrfillet@gmail.com/
> > Co-developed-by: Song Shuai <suagrfillet@gmail.com>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
>
> FYI missing a sign-off from Song Shuai. They were happy with you folding
> their patch in during the discussion linked above - so I suppose that is
> an accidental omission?
My fault, I missed that.

>
> Thanks,
> Conor.
>


-- 
Best Regards
 Guo Ren
