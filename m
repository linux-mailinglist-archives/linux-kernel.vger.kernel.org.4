Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2FD63B8D3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 04:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbiK2Dl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 22:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235281AbiK2DlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 22:41:24 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B044B773
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 19:41:24 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-13bd2aea61bso15632593fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 19:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z926gEIhUBmcwO9Tiiu77ZbEmq6ukCnSLWfWT6xVNEc=;
        b=ECBUfnT8XnfBtXlim0SAPGvedycUZb1ej4nKGGBSV/5NUZqufXKzNQ9jTbyhzPOTGX
         SWrIDQokJcybwIs2+cNPm+/TbiFgpyVgMNrzi1z62KLArszH23YXJJKVkmh9e5xsWBeH
         9CsW9o5JhIvHBgUrc6+wCvN4OnChqgYMaNZ2//gFI0j+qfK/Jv3UkWLZ29e7iso6mbpy
         sr57VUbIygeHZ+QF7MRjh2kXEdltfH+0mumV/scI31d1A5g+n2TQDyrHif0TxFat6gVf
         ZNIQMK1Mixz7yiVNcqpmIg9rGD+2MpUu7QcKvVDLMnmDml1pkKW1/c8URhl8+rX3X1Dp
         LNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z926gEIhUBmcwO9Tiiu77ZbEmq6ukCnSLWfWT6xVNEc=;
        b=b9+qGNVC2PbzHoraLaEf4I3ZATqaM0QRDpnDx/rOGdrd3TGC1UsGvNJ6NHbbSEpIi/
         ixqhzK9kW/i27ooqkcJlkqcY+CECAT3UEswCq62l9pbF5mACbqIopPly6VC7dt0HVeX8
         AzO68dr1N5FrSkGjUg3P9Lc7gj/ZuW24jlp+63vXx2pHTLuOVHkir5W5cW9Vm7r560WZ
         9a7d+FyAOBbeSCWy15xVWdQubv1mqxjmauJHjqFnLLqXLfznZ/Z5DyyjdTPKY2rFDzGN
         3RcY4FcTfWHQbd8VmjE1xpkvqjZlj0wL979Ed2QI1F9YYSwZH/Jk1B7YjppHH2S78XGD
         3Xyw==
X-Gm-Message-State: ANoB5pnynm6gtrwdoozD/S6knon/zZNzQZKz2RSQrUnDL9vd3sLr9byl
        HCi22yMYEflqfZF/WVpkqRG9EQlzKyxMjY/yqg==
X-Google-Smtp-Source: AA0mqf64pSmWJFKWNeS5hrXRU7NZT6cJSwYuagx6oWqELFowH7+KxUF8Ax+7yklB//3b1WZJOkqrpVH39XBYwma+V3c=
X-Received: by 2002:a05:6870:c388:b0:13c:10c6:7645 with SMTP id
 g8-20020a056870c38800b0013c10c67645mr29212823oao.243.1669693283388; Mon, 28
 Nov 2022 19:41:23 -0800 (PST)
MIME-Version: 1.0
References: <20221104124546.196077-1-ubizjak@gmail.com> <Y4U0GwlLgAuxu3WF@zn.tnic>
In-Reply-To: <Y4U0GwlLgAuxu3WF@zn.tnic>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Mon, 28 Nov 2022 22:41:11 -0500
Message-ID: <CAMzpN2jY+m5amE-6JB_eYswG2tx1aT6U3EBdYEtc-KdXSHec0A@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: Remove x86_32 PIC using ebx workaround
To:     Borislav Petkov <bp@alien8.de>
Cc:     Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
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

On Mon, Nov 28, 2022 at 5:57 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Nov 04, 2022 at 01:45:46PM +0100, Uros Bizjak wrote:
> > Current minimum required version of GCC is version 5.1 which allows
> > reuse of PIC hard register on x86/x86-64 targets [1]. Remove
> > obsolete workaround that was needed for earlier GCC versions.
> >
> > [1] https://gcc.gnu.org/gcc-5/changes.html
>
> Thanks for the doc pointer.
>
> Lemme see if I understand this commit message correctly:
>
> SysV i386 ABI says that %ebx is used as the base reg in PIC. gcc 5 and
> newer can handle all possible cases properly where inline asm could
> clobber the PIC reg. I.e., it is able to deal with the "=b" constraint
> where an insn can overwrite %ebx and it'll push and pop around that
> statement.
>
> So far so good.
>
> Why then does this matter for x86-64 where PIC addressing is done
> rip-relative so %rbx is normal reg there?

x86-64 uses a PIC register for the medium and large PIC code models,
where offsets can be larger than +/- 2GB.

--
Brian Gerst
