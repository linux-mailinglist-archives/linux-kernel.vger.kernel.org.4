Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A37B6109A3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 07:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJ1FN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 01:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJ1FN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 01:13:26 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF9F1ABEF6;
        Thu, 27 Oct 2022 22:13:25 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id v129so4144392vsb.3;
        Thu, 27 Oct 2022 22:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dm82la1bhnQQM/NPgA4OJFAqxsf61ZI1OYbb+W3nkWY=;
        b=NlsL0Zi0pgj3t8+As3JBuxUt9yjd9FG5XBdHyyHuGDonR6ULDq7sjSU7DfozcU3+MM
         8nJ0gjGRbYUBivKZIs593V5vcMn9bUi6756hdDOxepQjJPRNRWM10JhjEHuRp2PslnAR
         ExZoY3I7oEcS1L0SQG7zH6bNH7Pfq7YFywqYJpa6EeasnNOsYCSUVrQQzhORq2p65I9X
         uQJoVW60B54zO46gTkDv999aa/XKe1PzwiZvMJXgPn7labYPGhkMub6sFeX/OX+uzX93
         PBQ5BzClTxUBiVgsPi1u7ggg5OPXMcYk66+O/+8imZjc06mHNq3t3T7X2/MIqDKh8uGE
         GErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dm82la1bhnQQM/NPgA4OJFAqxsf61ZI1OYbb+W3nkWY=;
        b=vWivm3hiC08NMAXBdAOApmkXLxpNF2juFXJ5fHNz31+bw7nLpqTMJSBpxV7N8z5HDi
         SYTzUlN4ldnU5IkqtCh+fjUHyEYGH8anfk2+CbiBiV6QyQLIPsTsrvliN9s8IBOkBTpR
         gYXlX4QUzsYCpZlNhr1J2eLlsk7ix/vwj238b0CudyjG812mwUypbk7DZN4jIEuD1wOo
         165lQ0A+8+Z2fVBtvDLNbPtnCKuMze5lHAXuPVP32WkbIsaYimmAQf4BJxKjnf3pKgRR
         vBkZM1v4Y8YRJLAMtkv25fYWjJIOu7GzYEJZQwU0jpgjaGkmycwV78FXjHO9vzhvPhFB
         3R6g==
X-Gm-Message-State: ACrzQf0QQLP6WkPpW0fPy+PkeOA+WEBPPRWP2yslSmmUe41LDKa8HnMD
        47MskoXDvLxWuQsSRXO2RY+6QOu/IlTdBOiGEr/8tMrfaKg=
X-Google-Smtp-Source: AMsMyM4r2jz0o+yWzquAJQHB3wsLAuoYxh6wS+Nj7ljWCykZTVJs1U/JBd2TTpWzxnIG0exZGBDntiLZc/bxPN451kQ=
X-Received: by 2002:a67:a449:0:b0:3aa:4cd7:8ae9 with SMTP id
 p9-20020a67a449000000b003aa4cd78ae9mr5795192vsh.22.1666933985645; Thu, 27 Oct
 2022 22:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221027150525.753064657@goodmis.org> <20221027150930.513327801@goodmis.org>
In-Reply-To: <20221027150930.513327801@goodmis.org>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri, 28 Oct 2022 14:12:48 +0900
Message-ID: <CAKFNMok3sM7ytwCDQZjug2BLHDW9-g2aeBoV-jAMmanRLXQddQ@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 28/31] timers: fs/nilfs2: Use del_timer_shutdown()
 before freeing timer
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-nilfs@vger.kernel.org
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

On Fri, Oct 28, 2022 at 12:09 AM Steven Rostedt wrote:
>
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
> Before a timer is freed, del_timer_shutdown() must be called.
>
> Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home/
>
> Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Cc: linux-nilfs@vger.kernel.org
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  fs/nilfs2/segment.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
> index b4cebad21b48..1d3f89de1cd2 100644
> --- a/fs/nilfs2/segment.c
> +++ b/fs/nilfs2/segment.c
> @@ -2752,7 +2752,7 @@ static void nilfs_segctor_destroy(struct nilfs_sc_info *sci)
>
>         down_write(&nilfs->ns_segctor_sem);
>
> -       del_timer_sync(&sci->sc_timer);
> +       del_timer_shutdown(&sci->sc_timer);
>         kfree(sci);
>  }
>
> --
> 2.35.1

del_timer_shutdown()  is not yet in the mainline, so I reply with:

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

in the sense that I agree with the purpose of introducing the new
function and the place to apply it is correct in nilfs2.

Thanks,
Ryusuke Konishi
