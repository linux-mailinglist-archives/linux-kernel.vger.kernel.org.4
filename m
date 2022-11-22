Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E06633353
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 03:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbiKVC3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 21:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiKVC3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 21:29:10 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAB62F009
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 18:28:38 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id b21so12288169plc.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 18:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltL0LX3Mom0UCFI9PxEZC4WZgVaTqgqxhN2afiSBHaw=;
        b=d6RuB5TbLbcckuU6ZDzdOy/CFoA+nN0nD45TCaDh+laC8cQnowD57inxSM4+3KWMzT
         AOpXW84hu/1uPeBJHexSE1FsdamMs1ebzM2vaZiGKYR1j/eALNa3Z3i59tOfGA7VXAHF
         DrZVT4C8TZguf093IoV1ZcSqbymSAzWMOlvUeXU/7yH6VjeCd5EevafKetWWnzwkRNTf
         dKDmpl3q+PFKOgIxo0h5CdS5ao15Jtp4Y3Ubm7EPWKKYwJkEdNHBwWdtqlQNvZqYbZzu
         tJiyAJ4Dq9DrEu8QUqVk0oG5GD7+o2zdBJqZ4YeThCIvh0l92aM5Er/ZxaeEqysWLbrF
         EtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltL0LX3Mom0UCFI9PxEZC4WZgVaTqgqxhN2afiSBHaw=;
        b=DI+bO1lcHb6HI0kH/8UqFggYQgtaWep5Fh+xsOVAYyjWXVUcvSRUklPzKaq7P7scbu
         yqSq3b9didqT7njGzBDngjdXpm2Fc/lFZHF6vUyIWqA0PhVzkLXOg0Q/2VTF1XJGp58+
         WV2dIf/nnphGYn9oh3GzKKe9W1Q2P+GyQI/8xy1vvR385f/KzS/VydPp89UvOQZasash
         JwQSU9Hsj1zmRE2F9yHjorTiYrmba8E0FiBbfs0ZTMVmg/i0nZ8Db0phDTbIV/O7KR05
         iyQ6N01aPUTZ+ajarDSUWEG/UHcnlAoKfG4UL25kCYnlPGpx8ZJ5X6wtWwRQT9Re2JBx
         KfFQ==
X-Gm-Message-State: ANoB5pkZ+icMM5nHyafexLf9gqCNPjakkIWh4P7/d570pJZAa2Iq8J02
        +Cq3hZD25fvx3ncOdcgapGzOETDq3GDkfUtsqME=
X-Google-Smtp-Source: AA0mqf6bKDcYJ5yDSPgzEW3G9PcDk/8Z+yxPpozBl9tp8rnRgFUP8wifrsu4OHZMkaKJrs7ks+qcjnBfDIejiMMz6xE=
X-Received: by 2002:a17:90a:dc06:b0:218:9196:1cd1 with SMTP id
 i6-20020a17090adc0600b0021891961cd1mr16209331pjv.230.1669084117499; Mon, 21
 Nov 2022 18:28:37 -0800 (PST)
MIME-Version: 1.0
References: <20221026132039.2236233-1-suagrfillet@gmail.com>
In-Reply-To: <20221026132039.2236233-1-suagrfillet@gmail.com>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Tue, 22 Nov 2022 02:28:25 +0000
Message-ID: <CAAYs2=iOvP-TxLs+_QFMLQHG86xi2PYK_CN_rXUWHBx=kY+1aw@mail.gmail.com>
Subject: Re: [PATCH] ftrace: avoid replacing the list func with itself
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Song Shuai <suagrfillet@gmail.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=8826=E6=
=97=A5=E5=91=A8=E4=B8=89 13:20=E5=86=99=E9=81=93=EF=BC=9A
>
> The list func (ftrace_ops_list_func) will be patched first
> before the transition between old and new calls are set,
> which fixed the race described in this commit `59338f75`.
>
> While ftrace_trace_function changes from the list func to a
> ftrace_ops func, like unregistering the klp_ops to leave the only
> global_ops in ftrace_ops_list, the ftrace_[regs]_call will be
> replaced with the list func although it already exists. So there
> should be a condition to avoid this.
>
> This patch backups saved_ftrace_func by saved_ftrace_func_old
> which will be compared with the list func before trying to patch it.
>
Ping...

Thanks,
Song
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> ---
>  kernel/trace/ftrace.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index bc921a3f7ea8..56b1a42e1937 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -2755,6 +2755,8 @@ void __weak ftrace_arch_code_modify_post_process(vo=
id)
>  {
>  }
>
> +static ftrace_func_t saved_ftrace_func_old;
> +
>  void ftrace_modify_all_code(int command)
>  {
>         int update =3D command & FTRACE_UPDATE_TRACE_FUNC;
> @@ -2774,7 +2776,7 @@ void ftrace_modify_all_code(int command)
>          * to make sure the ops are having the right functions
>          * traced.
>          */
> -       if (update) {
> +       if (update && saved_ftrace_func_old !=3D ftrace_ops_list_func) {
>                 err =3D ftrace_update_ftrace_func(ftrace_ops_list_func);
>                 if (FTRACE_WARN_ON(err))
>                         return;
> @@ -2918,6 +2920,7 @@ static void ftrace_trampoline_free(struct ftrace_op=
s *ops)
>  static void ftrace_startup_enable(int command)
>  {
>         if (saved_ftrace_func !=3D ftrace_trace_function) {
> +               saved_ftrace_func_old =3D saved_ftrace_func;
>                 saved_ftrace_func =3D ftrace_trace_function;
>                 command |=3D FTRACE_UPDATE_TRACE_FUNC;
>         }
> @@ -3007,6 +3010,7 @@ int ftrace_shutdown(struct ftrace_ops *ops, int com=
mand)
>         ops->flags &=3D ~FTRACE_OPS_FL_ENABLED;
>
>         if (saved_ftrace_func !=3D ftrace_trace_function) {
> +               saved_ftrace_func_old =3D saved_ftrace_func;
>                 saved_ftrace_func =3D ftrace_trace_function;
>                 command |=3D FTRACE_UPDATE_TRACE_FUNC;
>         }
> @@ -8321,6 +8325,7 @@ static void ftrace_startup_sysctl(void)
>
>         /* Force update next time */
>         saved_ftrace_func =3D NULL;
> +       saved_ftrace_func_old =3D NULL;
>         /* ftrace_start_up is true if we want ftrace running */
>         if (ftrace_start_up) {
>                 command =3D FTRACE_UPDATE_CALLS;
> --
> 2.20.1
>
