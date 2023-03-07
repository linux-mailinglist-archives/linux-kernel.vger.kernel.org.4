Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B686AE6CC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjCGQhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjCGQfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:35:47 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA0E96F1D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:34:27 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id i19so194213ila.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 08:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678206862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nhxUdlMqxNbyOW/Z24Evrx37DDz/B6TitMQXvC2VtM=;
        b=g2LIbtLrj+L/WKOA8GX+2IUdMVUKkBweSob15yWJOwfj33998em/ox9InOrkzR/aoR
         P77Rf+soqi1AiUPo7uDGEw1+Kyp6L0OyBW2ZRau00O0juAxl2Nr2nKjdIqWnhzBn4Gd8
         gQXN8CqnkXLb6gT2uIF2LfiR/h457IS0WaO/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678206862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3nhxUdlMqxNbyOW/Z24Evrx37DDz/B6TitMQXvC2VtM=;
        b=5byG1hHFYlZ7ar0iyPgOa3Nc5aa5q1WuJ+hGgu4uv/moIQyvtmH9Na1c6RTLqlM3/+
         YwtttENIc0DwdLD90aDJtP09ZtiruP7o30gaZMcWpCZlTRDuoxuLPiQTZ7R92H0eEfR1
         mXyJEEOW0H19EttmNOZDUuTLYiKXQgHk5Q22O4zsjqvw3B1IkNruddFQOU16FW/fzCXQ
         /g7+B+twJ3ae0vSCokrnw4SgxzUssR1Zqqh2T93BtD1wvshk+thDh1lflYNuwLihqz19
         aCo/yMBlGlsUr7kxPaY1tZeKbaql5im74bR6jY1JPS6HIEg/TVQMDQ0dOjADpBfp6zBm
         Nxvw==
X-Gm-Message-State: AO0yUKVQ3aQAK/StcJ7XeEqQfnzUqafECCfM6S25Be58Q/j11OpxIBDw
        rKghBk1QN2RUPskh0Xw2wzFCQH0COf6GRnB1urQ=
X-Google-Smtp-Source: AK7set//MCFEkb+z6Zd8n5fuI5Egr6Zzq5lEwi7N2H/HlafoT6tgvTB9abqySLAjaerfWTnlDl5NIw==
X-Received: by 2002:a05:6e02:1c23:b0:316:e793:9dba with SMTP id m3-20020a056e021c2300b00316e7939dbamr12313752ilh.26.1678206861930;
        Tue, 07 Mar 2023 08:34:21 -0800 (PST)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id f13-20020a056e0204cd00b003179d4bd50asm3865449ils.75.2023.03.07.08.34.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 08:34:21 -0800 (PST)
Received: by mail-io1-f45.google.com with SMTP id y140so5626241iof.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 08:34:20 -0800 (PST)
X-Received: by 2002:a02:7310:0:b0:3e0:6875:f5e2 with SMTP id
 y16-20020a027310000000b003e06875f5e2mr7264173jab.6.1678206860373; Tue, 07 Mar
 2023 08:34:20 -0800 (PST)
MIME-Version: 1.0
References: <20230302195618.156940-1-john.ogness@linutronix.de> <20230302195618.156940-2-john.ogness@linutronix.de>
In-Reply-To: <20230302195618.156940-2-john.ogness@linutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 7 Mar 2023 08:34:08 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V1akD6NpV=XePGRiyKs0z-esjMYpBkE4-TZfq__x2m_w@mail.gmail.com>
Message-ID: <CAD=FV=V1akD6NpV=XePGRiyKs0z-esjMYpBkE4-TZfq__x2m_w@mail.gmail.com>
Subject: Re: [PATCH printk v1 01/18] kdb: do not assume write() callback available
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 2, 2023 at 11:57=E2=80=AFAM John Ogness <john.ogness@linutronix=
.de> wrote:
>
> It is allowed for consoles to provide no write() callback. For
> example ttynull does this.
>
> Check if a write() callback is available before using it.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/debug/kdb/kdb_io.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 5c7e9ba7cd6b..e9139dfc1f0a 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -576,6 +576,8 @@ static void kdb_msg_write(const char *msg, int msg_le=
n)
>                         continue;
>                 if (c =3D=3D dbg_io_ops->cons)
>                         continue;
> +               if (!c->write)
> +                       continue;

Reviewed-by: Douglas Anderson <dianders@chromium.org>
