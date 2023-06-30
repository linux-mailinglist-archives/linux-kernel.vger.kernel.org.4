Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A026C743E3F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbjF3PEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjF3PEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:04:38 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734561FFA
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:04:36 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-98df6bc0048so232419466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688137475; x=1690729475;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/dVLLykZP6WKd+6flq1FWTnG0laFtJyV7E0+T2ohxVg=;
        b=kIrWa0+hYI0FcC7ix0CNBMKmB9xK1fMznCXnzKSiJhDYobHbnTleEgtCTDTgs2VF4W
         mntb35Y8yrLec+xWh8vra3xEesOGbTJtgFXqK1I6blcOohIwFGe96uvZhFnK2vRjfP4p
         PfVt+XRvTDrS08UocxGk8VEg3daMPR+nwkLLD7f4uGV1pf4IARO0O3bZdAvmM3U/wufV
         o+I8dQFv6tiycn97AWClfzTwc1rWUa19dBiVIV2JheREI1kuVHNPmzCaFuCW64N1ltKq
         11AgB6GfhRO/EOCVacZF+B9BOLeoO0RHrv1jOrUcxTJ+E0c8xk4FpTG9wc6eb8pnUhlH
         8hRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688137475; x=1690729475;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/dVLLykZP6WKd+6flq1FWTnG0laFtJyV7E0+T2ohxVg=;
        b=AOnoLgiIIjfEsxv5sqmjFWd4olWARLLMKRysuIZUo6ahZ5W1Ilh+PJ2SmjyUVmOQlp
         RrtURqYVQt3b8M3TYJpDIoVAevrplfSf4g7kLXKgLalIUsyVvnqGBztrDlfFIhNBsB+G
         mbvFlE7xkHTGIlo/qisJT8abA5pvhrOBBL8+GOUj8Roe+VaDqEH1s0dzB9H5A5V0UjyZ
         CZtgkLghzHhbOsnS7Yw9B+OOOqXEp/d6kG6sbHeg1y8n1221K1afZH8ANh1PSXOdj4r1
         NC5g3caOnXS+91CowrYHR9bzdMJqGj9Uxlc+98qSreJ0UrYKFEdGXNjGNF/b1P9FXVDq
         xDBA==
X-Gm-Message-State: ABy/qLYHPw4KrVmP+ici5LwSah9iikozRDMUFkI/JTO9SXtcEi05ITwa
        zS0NShRTUoraMQRgTjpWt0QGwLKEY8jgYYnfoECDRw==
X-Google-Smtp-Source: APBJJlG9kOTBWqQJF3GG7lr98IJMS+YWNbQoJhPlnRsvrOFTNxORvcHSK3F7P7JfUN97vIcVVrfwUKYL4FjGrasKsDU=
X-Received: by 2002:a17:906:3453:b0:98d:cd3e:c193 with SMTP id
 d19-20020a170906345300b0098dcd3ec193mr1979573ejb.46.1688137474742; Fri, 30
 Jun 2023 08:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230629132711.1712536-1-matteorizzo@google.com>
 <20230629132711.1712536-2-matteorizzo@google.com> <87bkgyt8sq.fsf@suse.de>
In-Reply-To: <87bkgyt8sq.fsf@suse.de>
From:   Matteo Rizzo <matteorizzo@google.com>
Date:   Fri, 30 Jun 2023 17:04:23 +0200
Message-ID: <CAHKB1w+DgbZYNL83XFUCPuPvvP6YdgjAZqPc_uG_eHAj71a=6Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Add a new sysctl to disable io_uring system-wide
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        io-uring@vger.kernel.org, jordyzomer@google.com, evn@google.com,
        poprdi@google.com, corbet@lwn.net, axboe@kernel.dk,
        asml.silence@gmail.com, akpm@linux-foundation.org,
        keescook@chromium.org, rostedt@goodmis.org,
        dave.hansen@linux.intel.com, ribalda@chromium.org,
        chenhuacai@kernel.org, steve@sk2.org, gpiccoli@igalia.com,
        ldufour@linux.ibm.com, bhe@redhat.com, oleksandr@natalenko.name,
        Bart Van Assche <bvanassche@acm.org>, jmoyer@redhat.com,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 at 20:36, Gabriel Krisman Bertazi <krisman@suse.de> wrote:
>
> Thanks for adding the extra level for root-only rings.
>
> The patch looks good to me.
>
> Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>

Thanks everyone for the reviews! Unfortunately I forgot the subsystem name
in the commit message. Jann also pointed out to me internally that the
check in io_uring_allowed could race with another process that is trying to
change the sysctl. I will send a v3 that fixes both issues.

Thanks,
--
Matteo
