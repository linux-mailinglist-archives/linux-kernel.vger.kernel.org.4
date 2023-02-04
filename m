Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFAA68AA76
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 15:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbjBDOB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 09:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjBDOB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 09:01:26 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAE56A75;
        Sat,  4 Feb 2023 06:01:25 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id s8so3341504pgg.11;
        Sat, 04 Feb 2023 06:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1rk0vjjTSrdPO9DtPn9g2ifZW3sZZpADISnEZxtoFQ=;
        b=jSNYiH1k3WXK3P8rvhqh75aPiI+G/XoDlzs2AuXJrYfEwQXE+tS8k4UN2ax4ekAZqh
         Q4aWaHFDBL//kjeNufun9nzJzTNH4IQrRmLQpPElo19rFGQs2QVR6005J6JN1xucILa/
         JnrhFS22b0jinEdL+ASDkddGShx9C4WG504JT5m+e4gLdI+Dc1fhqS+BH8GWdyNXjetZ
         a3eHnntrN/HXDWeljb0evjS9D9lfw2vBGIrur+YmtTJ0HoFtod5UTpsKYyTu5OAakcRJ
         j6li6Sed8222GnutqZFVuSaetBAl1AHovWzMPf7PeVVqlcm7UveHpahAufEm7hLC3w+1
         bsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y1rk0vjjTSrdPO9DtPn9g2ifZW3sZZpADISnEZxtoFQ=;
        b=rlOYLWocdSLuh3Yserwr4EnIzqnW44oXEeDsbmfXKZyqRqcS/MxSKGHEJ2vzUt6JFz
         Reh4UIF5xgUGI2agpNUEg6hgzLmNt/3Szhub0uorgiSqd1sncWKwWwDzm8wKn9qPv52i
         gZGIIbuQGoY8n5FbaHDZlp+R9EJHLO+vrUbKTT/ZVoNLBB2Pc1xkf989ArJ9Fy5jBoqM
         sSirQ4eSgQsQjTlt5gyuTeKIvU9h7Nw1ONr+e4k6wldV+atn9Fai5w56vA+0+kIbzehD
         1Bo8eytI8iCgfeyJehSG8tkzXp6mB8myGkiFwBIrcPkxYW/xFL9Cpr/xNgb9t1N96953
         MmoQ==
X-Gm-Message-State: AO0yUKVcBUZjs5ceWC1RpIVGgNlZxs6Lo1ejLDWY3yP+GTjDy/EdwtDf
        Y1LZt5vKVsZFDtQi+23WlR+o4eg0UOwUZ4ZvB7E=
X-Google-Smtp-Source: AK7set82eHo9UmIAzit/YcrVkFeX6c9BbfWh8dIFzTX3vz8Q6BcGg+UJThK/RWpw9HAP8EUb13Cyf4dOB5NWR/TX3l8=
X-Received: by 2002:a63:cc0f:0:b0:4cf:122f:2102 with SMTP id
 x15-20020a63cc0f000000b004cf122f2102mr2164398pgf.98.1675519285223; Sat, 04
 Feb 2023 06:01:25 -0800 (PST)
MIME-Version: 1.0
References: <20230204134651.22569-1-namcaov@gmail.com> <Y95jtuMbcDiPRw/F@kroah.com>
In-Reply-To: <Y95jtuMbcDiPRw/F@kroah.com>
From:   Nam Cao <namcaov@gmail.com>
Date:   Sat, 4 Feb 2023 15:01:14 +0100
Message-ID: <CA+sZ8B9Wrr4yj3c6fiqFhKvZuYifV87EXBQ1pY_Km-p=3oE4ug@mail.gmail.com>
Subject: Re: [PATCH] USB: serial: whiteheat: use stack instead of heap memory
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sat, Feb 4, 2023 at 2:55 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Feb 04, 2023 at 02:46:51PM +0100, Nam Cao wrote:
> > Some buffers in whiteheat_attach() are small and only used locally. Move
> > them to the stack to avoid complications with heap memory.
> >
> > Compile-tested only.
>
> And that's the problem, you can't just compile test these things, the
> code will blow up if you make these changes :(
>
> All USB transfers need to come from memory that can be safely DMAed.
> Stack memory is not that type of memory, you HAVE to allocate it
> dynamically from the heap in order to have this guarantee.
>
> So no, this patch is not acceptable, sorry.  You will see this pattern
> in all USB drivers, all data must be dynamically allocated, even for 2
> byte commands.
>
> So yes, there was a reason we added this "complexity" to the driver, it
> is required :)

Thanks for "the lecture", and sorry for the broken patch.

Best regards,
Nam
