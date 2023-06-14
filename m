Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64827730118
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245319AbjFNOCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245303AbjFNOCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:02:14 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C71B1FDA;
        Wed, 14 Jun 2023 07:02:10 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f8cc042ea9so6191625e9.2;
        Wed, 14 Jun 2023 07:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686751329; x=1689343329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YalgAdoF4HFymEWC4l11A6+2Age3qqp8NisDolbvtPU=;
        b=QnybpKAUtanktW1NTqvXGot+AfHVNeU6AerpBHIo1fxIJFR/xJTHuQ1z1p/Vf+cb/G
         gEZIzy33cUC+FeFp+33YqtaRFviW9aINNTclbvSzNTUOFTFn5dKbvXA9IHPstlrOUNXy
         11//5umbCH2XMBlKN+v1oe2kXOcZnVHRiTXjtLfnwbcOC1Y3QMPK+v8uoAAr3IwXtl/2
         1JnHeStWibPkJNahcDotSTEYF1EZ2sjQuT8wSecgwIji5qRMVXMydmD0iLwPOjhuRn29
         yClCCcA2tDJfTQ4CGTVxKBkFDeOay5E2gOIVFeBWVZW6sGN8ETwhWTxlyOmtxqgMwnu1
         b8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686751329; x=1689343329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YalgAdoF4HFymEWC4l11A6+2Age3qqp8NisDolbvtPU=;
        b=KetymqZiKcI2nqhw5482YLJ/SVa0L7p5KBuN2Yx6pBFFHVpOWjku0Gd7NPcr0jftKZ
         A0x0EIrr6H/tObzAWT9X4rneA9HO9RE8rAW9VtFCrkclzRDv5F5TaGcSVJ/KDqU5UsJa
         MsOiqukMGs4z2ysZSVbWHvwlVdsst/V1l+xcWo0J173C//uHr7HORpCVuXQM3JwSzKrk
         jsq1VLcDqqz8ZZI4jm5xCNAqqyWtnALpebNUImM0LbFFIqc2hIJNXIwgmzikARsqJ08d
         UiI/a3eHSw0W/yTf0FbjU1Kxpe5bKca5GUzaQrz+NCg7usEl4cujv1vfb9Vd5cQNasnE
         mcwQ==
X-Gm-Message-State: AC+VfDzxwNiXIRIxMJDn+nWnvGtvL1YgeuKjcHtD0K6JnzIP9fx9Iy5M
        5xK2kX+ZAf6zcQVi+E/UOEYs06DVrkpK1Ldl4WHzGz9Z/QXbJQ==
X-Google-Smtp-Source: ACHHUZ5EaqveAacPXPNDJM4tjGLj5HuRAbt1AYBrTozys5NYQQW/PAONEGPCNpxSzbPnrafK+LtDyOTy/POM1L8ASbk=
X-Received: by 2002:adf:ec0c:0:b0:309:49e3:efb4 with SMTP id
 x12-20020adfec0c000000b0030949e3efb4mr8212615wrn.63.1686751328638; Wed, 14
 Jun 2023 07:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230613004125.3539934-1-azeemshaikh38@gmail.com> <202306131227.26F90584F7@keescook>
In-Reply-To: <202306131227.26F90584F7@keescook>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Wed, 14 Jun 2023 10:01:57 -0400
Message-ID: <CADmuW3WeRG-_WsFVCogRzRNXoqtVr+gA84ryqDZ2URUu3wh6Tg@mail.gmail.com>
Subject: Re: [PATCH] tracing/boot: Replace strlcpy with strscpy
To:     Kees Cook <keescook@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 3:27=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Tue, Jun 13, 2023 at 12:41:25AM +0000, Azeem Shaikh wrote:
> > strlcpy() reads the entire source buffer first.
> > This read may exceed the destination size limit.
> > This is both inefficient and can lead to linear read
> > overflows if a source string is not NUL-terminated [1].
> > In an effort to remove strlcpy() completely [2], replace
> > strlcpy() here with strscpy().
> >
> > Direct replacement is safe here since return value of -E2BIG
> > is used to check for truncation instead of sizeof(dest).
>
> This looks technically correct, but I wonder if "< 0" is a better test?

Agreed. "< 0" might more generically represent -errno. Happy to send
over a v2 if you prefer that instead of sticking with this patch.


>
> >
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strl=
cpy
> > [2] https://github.com/KSPP/linux/issues/89
> >
> > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
>
> Either way
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> -Kees
>
> > ---
> >  kernel/trace/trace_boot.c |    8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
> > index 778200dd8ede..5fe525f1b8cc 100644
> > --- a/kernel/trace/trace_boot.c
> > +++ b/kernel/trace/trace_boot.c
> > @@ -31,7 +31,7 @@ trace_boot_set_instance_options(struct trace_array *t=
r, struct xbc_node *node)
> >
> >       /* Common ftrace options */
> >       xbc_node_for_each_array_value(node, "options", anode, p) {
> > -             if (strlcpy(buf, p, ARRAY_SIZE(buf)) >=3D ARRAY_SIZE(buf)=
) {
> > +             if (strscpy(buf, p, ARRAY_SIZE(buf)) =3D=3D -E2BIG) {
> >                       pr_err("String is too long: %s\n", p);
> >                       continue;
> >               }
> > @@ -87,7 +87,7 @@ trace_boot_enable_events(struct trace_array *tr, stru=
ct xbc_node *node)
> >       const char *p;
> >
> >       xbc_node_for_each_array_value(node, "events", anode, p) {
> > -             if (strlcpy(buf, p, ARRAY_SIZE(buf)) >=3D ARRAY_SIZE(buf)=
) {
> > +             if (strscpy(buf, p, ARRAY_SIZE(buf)) =3D=3D -E2BIG) {
> >                       pr_err("String is too long: %s\n", p);
> >                       continue;
> >               }
> > @@ -486,7 +486,7 @@ trace_boot_init_one_event(struct trace_array *tr, s=
truct xbc_node *gnode,
> >
> >       p =3D xbc_node_find_value(enode, "filter", NULL);
> >       if (p && *p !=3D '\0') {
> > -             if (strlcpy(buf, p, ARRAY_SIZE(buf)) >=3D ARRAY_SIZE(buf)=
)
> > +             if (strscpy(buf, p, ARRAY_SIZE(buf)) =3D=3D -E2BIG)
> >                       pr_err("filter string is too long: %s\n", p);
> >               else if (apply_event_filter(file, buf) < 0)
> >                       pr_err("Failed to apply filter: %s\n", buf);
> > @@ -494,7 +494,7 @@ trace_boot_init_one_event(struct trace_array *tr, s=
truct xbc_node *gnode,
> >
> >       if (IS_ENABLED(CONFIG_HIST_TRIGGERS)) {
> >               xbc_node_for_each_array_value(enode, "actions", anode, p)=
 {
> > -                     if (strlcpy(buf, p, ARRAY_SIZE(buf)) >=3D ARRAY_S=
IZE(buf))
> > +                     if (strscpy(buf, p, ARRAY_SIZE(buf)) =3D=3D -E2BI=
G)
> >                               pr_err("action string is too long: %s\n",=
 p);
> >                       else if (trigger_process_regex(file, buf) < 0)
> >                               pr_err("Failed to apply an action: %s\n",=
 p);
> > --
> > 2.41.0.162.gfafddb0af9-goog
> >
> >
>
> --
> Kees Cook
