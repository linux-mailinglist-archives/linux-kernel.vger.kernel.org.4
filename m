Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F2F6BD4EB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjCPQQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjCPQQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:16:40 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404A8B8557
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:15:57 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id h14so1025281pgj.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678983351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HepwIypvEnLuoj0+HiMExSZvgEasFz7NquYI01HwGdg=;
        b=CWgNGtlhYC8DEuBHMMd2BStoiOvVikGEgZb+qYscpsDE/YIApmrul8wiIWN6JgdTNC
         LUUyUeYyg+7hOIqL1YbaYCampVflEc+ZP2AzYSWxttUnxX4rxTfn9OWmjnOjPps6A0/b
         Oxj/Szlot1zZy7Fx1NYhRnvB5l+/x64KgOLj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678983351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HepwIypvEnLuoj0+HiMExSZvgEasFz7NquYI01HwGdg=;
        b=yLPKleQNtEC/GhvM+MT5wkLgW7Yz2BtZvkSWSPOlZMy6OrOU6znKOjt5EcbozlErYI
         jn4PaSWKxbckZz8AK8OmGTn9vIYASHXoVLUfXe56QwmNky1Or0+jo12NeQQzZsv2ItdA
         Vvq0MNG6Aw/60eOIkFEloJSCZzPyidsTeslVO2R4yT3s+WdUXRmrsrHaPBTxN/6vphDm
         PL0Whf3J7jfxppnFCFAi9emQ+1Xvi7ldEbx3P9JtG4WKMPi7rSuz+zxGY4TY+W8uQqQj
         LzBa7bUq4G824JwYMUpOQhZx2oS64dXcMn16hBCiHbFvHU958X0XnVb07SDhvvYnYQ0F
         RQpQ==
X-Gm-Message-State: AO0yUKX0EaFlw8GBYkqtMsxawrluYJ7Wpcxi1KUpvVXIoXTMe9qg3pVF
        8YabFTppI08R1D2t6ecLV53WT+iB4d1qwZAX818Q5g==
X-Google-Smtp-Source: AK7set+PPf5qUeCZ6RJ98pp/gNe+a3B3hrAIh4QNDlPLM4NS89S1BhQcuAuZPd9h/knHZdANGrQxoKhvZX8ZvOhgTNw=
X-Received: by 2002:a65:5c81:0:b0:503:7bcd:9806 with SMTP id
 a1-20020a655c81000000b005037bcd9806mr1032901pgt.4.1678983351532; Thu, 16 Mar
 2023 09:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230207182135.2671106-1-revest@chromium.org> <20230207182135.2671106-5-revest@chromium.org>
 <20230315194334.58eb56ab@gandalf.local.home> <CABRcYmLLbRGZXWwEpyLW1YFz87tTPA8pCL7oLd4K6Hp9Etr5LA@mail.gmail.com>
 <20230316114544.5db09039@gandalf.local.home>
In-Reply-To: <20230316114544.5db09039@gandalf.local.home>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 16 Mar 2023 17:15:40 +0100
Message-ID: <CABRcYmJESb9BHpJT9Ty-CCBcsou+CzdZK1myNPPyNvLmw51k3A@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] ftrace: Store direct called addresses in their ops
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, mhiramat@kernel.org,
        mark.rutland@arm.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com, lihuafei1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 4:45=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 16 Mar 2023 16:40:48 +0100
> Florent Revest <revest@chromium.org> wrote:
>
> > > > @@ -5466,6 +5467,7 @@ __modify_ftrace_direct(struct ftrace_ops *ops=
, unsigned long addr)
> > > >                       entry->direct =3D addr;
> > > >               }
> > > >       }
> > > > +     WRITE_ONCE(ops->direct_call, addr);
> > >
> > > I'm curious about the use of WRITE_ONCE(). It should not go outside t=
he
> > > mutex barrier.
> >
> > This WRITE_ONCE was originally suggested by Mark here:
> > https://lore.kernel.org/all/Y9vW99htjOphDXqY@FVFF77S0Q05N.cambridge.arm=
.com/#t
> >
> > My understanding is that it's not so much about avoiding re-ordering
> > but rather about avoiding store tearing since a ftrace_caller
> > trampoline could concurrently read ops->direct_call. Does that make
> > sense ?
>
> Yes, but a comment needs to be added:
>
>      /* Prevent store tearing on some archs */
>      WRITE_ONCE(ops->direct_call, addr);
>
> Or something to that affect. Otherwise I can see it confusing others in t=
he
> future. And probably me too, as I'll forget why it was a WRITE_ONCE() by
> next month. ;-)

Definitely :) I was myself confused after a few weeks of adding it so
I'll add a clarifying comment. Thanks!
