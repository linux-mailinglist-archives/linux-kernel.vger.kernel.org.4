Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999F67262EA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241075AbjFGOgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbjFGOf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:35:57 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6868E1AE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 07:35:55 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f7e7fc9fe6so26988515e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 07:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686148554; x=1688740554;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=deFx223UAn6/3WPT3CB+BedQKRrIofGGQo7Oraihby4=;
        b=mYOEVqMXw3Q8wvGV5v2RZzRwA+4Mqjcm8fYX68tNivJRV3fglrj3h0DcBeYSamGejq
         ULZmGnjzhGkRqyROnr3h3tUWSqfdhmrlodjnU5PurkxosQcs+9Xs/B1kOCDfCBPwM0ob
         cwEGiwsDqLFApd9QD8kVF2hvKBgPSnUvGRf3MrHJ5QV7vsExHJgJBotMyJKJ6RdIB6gO
         97kw7YXhqniAjmMT9Pc8L5iL67j7UhaRR4Wq4AQB7V/EFovLVM7zr1ZuWRPA3cUZfXai
         PZP2NmBhNI8YcR4+lgb8NImAo1g17jDE+RSoPWX+j/fPBsVch9FNgb12N89oTBmtUM3l
         hWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686148554; x=1688740554;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=deFx223UAn6/3WPT3CB+BedQKRrIofGGQo7Oraihby4=;
        b=TGg66qnRM4Ez1jIeW4UxEchHGpzLO6rKljUhACbjXDlgqsO33P7zJ8bFVT9sH9oFYf
         lSxSLHjOJwBt8lmDikowmaTKGl2clibbHYbqTSa7LcBeRu7a3XVkbiBRaNDQSv1lsqiI
         Dc2EkKvmcfb4h5q/+uczrNWyOGaS1pMTq2sqepuolF4391ux/+yUqx/BPD5GQ/VzFAGM
         jWqiPufqBVaACJUCdOcUbwST27lOumxiq8Pd9Mpa+7wQumKj6kJ96F5QzIjBNm1JKxnI
         Jy2uD4dYA3LAwuVz8u6Qg88tX+7mnUM55Yt96ok368p7+dhou9bQtCBTZkPljPb+PTu4
         7b3w==
X-Gm-Message-State: AC+VfDzM5btK33P81T1VmwrNQJKefoHNkOP629aaCHljlcWT85/wyMoY
        yMqvQfAPMuK0GQePvjYjmKWEx4NJYnf8fmXvrdC9lg==
X-Google-Smtp-Source: ACHHUZ6rr+HgEVIoVLyykSTfTB2HiarNlmmYZrEKCS2/KijlnRwxvv+5UXoQuaCyA+JqF/Hdo4PK9o4GyOi/AVPIoAk=
X-Received: by 2002:a7b:cc93:0:b0:3f6:af2:8471 with SMTP id
 p19-20020a7bcc93000000b003f60af28471mr4912522wma.26.1686148553863; Wed, 07
 Jun 2023 07:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230601105904.3204260-1-danishanwar@ti.com> <ZH4aywQoA9gy2OWU@p14s>
 <20230605204552.x4ctuzos4rysldwj@sessions>
In-Reply-To: <20230605204552.x4ctuzos4rysldwj@sessions>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 7 Jun 2023 08:35:43 -0600
Message-ID: <CANLsYkyOhtaWbgKX9kkkLUtMkZbAp5t+JA7BNYULXf9r_FmNNw@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: pru: add support for configuring GPMUX based
 on client setup
To:     Nishanth Menon <nm@ti.com>
Cc:     MD Danish Anwar <danishanwar@ti.com>,
        Bjorn Andersson <andersson@kernel.org>, rogerq@kernel.org,
        vigneshr@ti.org, srk@ti.com, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2023 at 14:45, Nishanth Menon <nm@ti.com> wrote:
>
> On 11:26-20230605, Mathieu Poirier wrote:
> [...]
> > Here I have to suppose pruss_cfg_get_gpmux() has been added to Nishanth's tree.
> > As such the only way for me to apply your patch is if Nishanth sends me a pull
> > request for the patchset that introduced pruss_cfg_get_gpmux().  You can also
> > resend this in the next cycle.
>
> Yes, I had pulled this in [1] along with a few other driver fixes. I
> can send you an immutable tag to pull for your tree, if that helps the
> process along though, it might have a unrelated driver fixup patch as
> part of the series though..
>

MD has indicated he would rework his patch and send a new revision in
the next cycle.

> [1] https://lore.kernel.org/all/168434617580.1538524.11482827517408254591.b4-ty@ti.com/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git/log/?h=ti-drivers-soc-next
> --
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
