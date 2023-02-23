Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A21E6A05DE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbjBWKTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbjBWKTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:19:19 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F253D928;
        Thu, 23 Feb 2023 02:19:18 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id w42so10208601qtc.2;
        Thu, 23 Feb 2023 02:19:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hiSyPZd76dU3y97iocP4+7J5nmKEdq6xDxkhc6e2U4Y=;
        b=u8gh4vv4cQRT8kDj07i4Z0lgvsGsFjbAhUWJU0dUaGRG7FafUkfqr4CUaEsRwnqNVB
         eVtKU7mlJi/xgWX8/oV5/loPmhr0eJqmJZb6yXDwe5qVcJFi77Ih68hbADbOc0gvOkM/
         4aAUMYw3Nnjs4Rt+5+8TYCUzQVhvNfa44uQ6b/ahcfKdjZTVPrmoowvNoHDF10e/RSM9
         2vOCn10XIdXVCDq6U9igkXKCLfhuqKAXl79i0I4fukhWCbkSxT2nqAm4cU7UXgMhFhyO
         u5rThj8CaVu3uEl1n+kI822Id/1WeAoF3J+szSa02FPhsdrg9AJT4+yGdThSlUejCwO7
         dVvg==
X-Gm-Message-State: AO0yUKXuCCV/xRbUIOPz3zP/zwjiFoCXegMx9GUBpfT55r61C4chk/dv
        zNGs+ebtv4Z1Rxk0OWGKFc0UMAWLapIU1LqD
X-Google-Smtp-Source: AK7set9BvN12U2VTr2A/DbFOyw8HOlA5kjuiB3JeItJS0423kx0DOtMCBUzi5XLzL97F31WJvFW1HQ==
X-Received: by 2002:a05:622a:10:b0:3b8:4325:7610 with SMTP id x16-20020a05622a001000b003b843257610mr20623938qtw.67.1677147557715;
        Thu, 23 Feb 2023 02:19:17 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id a8-20020ac81088000000b003bd1a464346sm2931127qtj.9.2023.02.23.02.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 02:19:16 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-536cd8f6034so145891047b3.10;
        Thu, 23 Feb 2023 02:19:16 -0800 (PST)
X-Received: by 2002:a81:ae0c:0:b0:52e:cacb:d7c4 with SMTP id
 m12-20020a81ae0c000000b0052ecacbd7c4mr1883570ywh.5.1677147556298; Thu, 23 Feb
 2023 02:19:16 -0800 (PST)
MIME-Version: 1.0
References: <20230222200838.8149-1-casey@schaufler-ca.com> <20230222200838.8149-7-casey@schaufler-ca.com>
In-Reply-To: <20230222200838.8149-7-casey@schaufler-ca.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 23 Feb 2023 11:19:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWGVmdTD5vZW1ObsCsXSxDnYp6WvFtfpKQKPCdHfu7Zvw@mail.gmail.com>
Message-ID: <CAMuHMdWGVmdTD5vZW1ObsCsXSxDnYp6WvFtfpKQKPCdHfu7Zvw@mail.gmail.com>
Subject: Re: [PATCH v6 06/11] LSM: wireup Linux Security Module syscalls
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Casey,

On Wed, Feb 22, 2023 at 9:18 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> Wireup lsm_get_self_attr, lsm_set_self_attr and lsm_module_list
> system calls.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Thanks for your patch!

>  arch/m68k/kernel/syscalls/syscall.tbl               |  3 +++

Please collect tags given, and add them when reposting.
I'm providing my
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> [m68k]
for the third time.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
