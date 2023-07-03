Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623E3745DA4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjGCNou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjGCNor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:44:47 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAD5FF;
        Mon,  3 Jul 2023 06:44:46 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-767582c6c72so184847785a.2;
        Mon, 03 Jul 2023 06:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688391886; x=1690983886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7iro2GHx1a3c60XNEoVW/HAjkmFVpakGmamlmOOxIc=;
        b=cXdeXZ6GqAxqyH0uJjEn2RAg03TvsArQ75VrnIwnE7rIMi9uv6LBZ3RTnnxHADB4jj
         ovtvfWGwCKJGJEPojnhkw/tkjCaRp8IYZlHIysSFYjhbMsqOkyPNu2jFOx66yYityes8
         2mIIkdhokkQspRkk/7I7oDxl0/EZ5HQCG75Ve5Gdfhf5FuKCG0LuyUKCV4zM8f0Fwboz
         g5C2pz5/PsEtDKWBy6mS5jxFDGv8cwGGS959St0Z7WqVoUjQRzErOUmE1XB5p19hMn6l
         +2uocAspOrIKJz09Q/W6pl7blgTav0mYcPcKIn0L81EpzZhHnyrStinEYGg31KYSWxWa
         ZMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688391886; x=1690983886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7iro2GHx1a3c60XNEoVW/HAjkmFVpakGmamlmOOxIc=;
        b=gzfcQzkhPfA8vVzccBZ0zikXlVZRB05745KdK85o/XsvcFublGOOLKsLY4SkmyNBQ+
         Xh3ulIdP5ob3X4oTOi4/RVfrK9JFqoX2RJ8Yr4Svz7uL5jxKql8QVuujjF3Rx/Ez+a2b
         FHy4y+nWNYI4VPw9IMhNU8bm75pkaN1zOnLAN6jyyCGaXlg1M0zpTTa7P4Ttqrycw64O
         DyqiUNZ9WRc2EmdnwhLFif0WnOM3cdnHf4lGJ+eDSbSKK+yQdObvnhUxVyBLLB18T09C
         PKOI+k9COVWf9PoFz6ElWIRC1MknHGqeGrRpx+N9yFF5dYk4e/tKRIskQwl4PRMQAoqT
         J15w==
X-Gm-Message-State: ABy/qLZUc1KiQz6NF9liHXeEbHHTY2GoLSfEU7sPZ6nng95OCLzlXO3e
        Oc2sP7cOzR4OodM6lR93jHPcPexxD784jBzx7yfaFvbQYh628g==
X-Google-Smtp-Source: APBJJlENU0m+bm59PWE3lnOd/3BBVpgliodVhUrbnQ6Oe9WB+uCq0MJUIUqcUYZRvuBI9U8as07cVF/lcyc4f3a8sW4=
X-Received: by 2002:ad4:444c:0:b0:626:3a98:95a with SMTP id
 l12-20020ad4444c000000b006263a98095amr11116093qvt.22.1688391885920; Mon, 03
 Jul 2023 06:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230703092336.268371-1-zegao@tencent.com>
In-Reply-To: <20230703092336.268371-1-zegao@tencent.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 3 Jul 2023 21:44:10 +0800
Message-ID: <CALOAHbDrHtBe5LDPUqT2SPtK9P3+a+mDxLYOwQc2ea8T605=2A@mail.gmail.com>
Subject: Re: [PATCH v2] fprobe: add unlock to match a succeeded ftrace_test_recursion_trylock
To:     Ze Gao <zegao2021@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Ze Gao <zegao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 3, 2023 at 5:23=E2=80=AFPM Ze Gao <zegao2021@gmail.com> wrote:
>
> Unlock ftrace recursion lock when fprobe_kprobe_handler() is failed
> because of some running kprobe.
>
> Fixes: 3cc4e2c5fbae ("fprobe: make fprobe_kprobe_handler recursion free")
> Reported-by: Yafang <laoar.shao@gmail.com>
> Closes: https://lore.kernel.org/linux-trace-kernel/CALOAHbC6UpfFOOibdDiC7=
xFc5YFUgZnk3MZ=3D3Ny6we=3DAcrNbew@mail.gmail.com/
> Signed-off-by: Ze Gao <zegao@tencent.com>

Acked-by: Yafang Shao <laoar.shao@gmail.com>

> ---
>  kernel/trace/fprobe.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 18d36842faf5..93b3e361bb97 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -102,12 +102,14 @@ static void fprobe_kprobe_handler(unsigned long ip,=
 unsigned long parent_ip,
>
>         if (unlikely(kprobe_running())) {
>                 fp->nmissed++;
> -               return;
> +               goto recursion_unlock;
>         }
>
>         kprobe_busy_begin();
>         __fprobe_handler(ip, parent_ip, ops, fregs);
>         kprobe_busy_end();
> +
> +recursion_unlock:
>         ftrace_test_recursion_unlock(bit);
>  }
>
> --
> 2.40.1
>


--=20
Regards
Yafang
