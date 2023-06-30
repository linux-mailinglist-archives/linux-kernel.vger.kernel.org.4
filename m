Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA827443AF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 22:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjF3U5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 16:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjF3U5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 16:57:15 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C43C3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 13:57:12 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fb7589b187so3778180e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 13:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688158629; x=1690750629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u15VNGIEnyJtLjVOKUkj2c2i24i64I8f65ANMrqewQM=;
        b=dnByYCOshHUJxjdw5Htc8cbC31xXL9PEqS8iS7pamOLlh9hmrTFiOGMp1HjZzmIorX
         +3Q/zyMlOBTdnmbu5ePaDkoOroQgnnEf/uhS9ISVyaso8BiMkGx+Fq4Puazqo6Nso34u
         Ah+6FE+0BzL+JWQAN50BUSqMf9Ekm+JhNYuMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688158629; x=1690750629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u15VNGIEnyJtLjVOKUkj2c2i24i64I8f65ANMrqewQM=;
        b=CEKMT90twjNml6zPS3yUAfuIP+Q4pwGTmWYoTk83nzfqYC7IzrF82VcfzESMrnsrjV
         OvuxB8kqUH4zBADbDopoUjrb8FmHy91LBSexViWW+Bhyxd88g6t4vhQH63MI50DQ6mEQ
         I64ua6Hdw8n5Ud842zJYd1IDLpq0h0ezfI71z2vnwYFElWP7hj7rsZywjvTFYHzOBaYF
         Zei2gMs8snMGLhZsGuwIneyO+OaRxUt5IvnRdXlJ9UfdyYTiuJjtBbc1LyNO2skVA3nV
         dKIwyYpd0+FEn54NXVcN9NxWw1snYrOhtrV3HfPnh8ucUBPgLI7MtFaVXqeMnusGV/EA
         P3Qg==
X-Gm-Message-State: ABy/qLYgvvth1GXNhUZOakvgE7Z7aAtHKGJ0NrEHx7yJY+k3DCg5+tO7
        3prAg+I2ctMT2wUPVq6rTl93Dv2p6/vthgHH8UKHRA==
X-Google-Smtp-Source: APBJJlFwoVa1GrZKOPiDBvMgQxyVSWL0im8EjiyrvbTjLnhzkY4yZR+64ZhH7yF1b9MsQgMdZG6W+Q==
X-Received: by 2002:a05:6512:3d0f:b0:4f9:586b:dba1 with SMTP id d15-20020a0565123d0f00b004f9586bdba1mr3584596lfv.4.1688158629574;
        Fri, 30 Jun 2023 13:57:09 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id y20-20020aa7ccd4000000b005166663b8dcsm7017931edt.16.2023.06.30.13.57.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 13:57:08 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-51ddbf83ff9so2846a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 13:57:07 -0700 (PDT)
X-Received: by 2002:a50:d544:0:b0:50b:c48c:8a25 with SMTP id
 f4-20020a50d544000000b0050bc48c8a25mr23065edj.6.1688158627455; Fri, 30 Jun
 2023 13:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230630201206.2396930-1-daniel.thompson@linaro.org>
In-Reply-To: <20230630201206.2396930-1-daniel.thompson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 30 Jun 2023 13:56:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WCa5LugcNwosHOPG8GSVfUEnDB9hbXWEop0z0ner12Yg@mail.gmail.com>
Message-ID: <CAD=FV=WCa5LugcNwosHOPG8GSVfUEnDB9hbXWEop0z0ner12Yg@mail.gmail.com>
Subject: Re: [PATCH] kdb: move kdb_send_sig() declaration to a better header file
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Kees Cook <keescook@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 30, 2023 at 1:12=E2=80=AFPM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> kdb_send_sig() is defined in the signal code and called from kdb,
> but the declaration is part of the kdb internal code.
> Move the declaration to the shared header to avoid the warning:
>
> kernel/signal.c:4789:6: error: no previous prototype for 'kdb_send_sig' [=
-Werror=3Dmissing-prototypes]
>
> Reported-by: Arnd Bergmann <arnd@arndb.de>

FWIW: these days, I think checkpatch yells at you for a bare
"Reported-by" like above. It ideally wants a "Closes" tag to follow
immediately with a link to the report, or in the very least a "Link"
tag if this doesn't fully address the issue.

> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

Reviewed-by: Douglas Anderson <dianders@chromium.org>
