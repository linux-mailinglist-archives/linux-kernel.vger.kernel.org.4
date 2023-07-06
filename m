Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF2674A675
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 00:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjGFWAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 18:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGFWA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 18:00:29 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8825CE1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 15:00:28 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-682a5465e9eso199992b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 15:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688680828; x=1691272828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8F/Vz/JYKZUR7Pz5q1oBdNBG9fKmk/mb5bJHRVCY9Kw=;
        b=htCzr6cIPX9PDnqhu74yLiUYcdYliDEsN3nu1sZBVzcxA52VvBHGtrlzn3uM5hb5UG
         5FJcswVJm5ZYNNYJjq9yjJgREKDS33htkOsq3JI3QSs23+XL1N8OWd5o1BL7U9mHT5CT
         F3nPs4NO9SocDJviSKIETlxQdjxgMhTPdcn0IYLOzfQTPWmn17kildwyS3oZZhJ6h9AS
         v1K3bWCk7Fu1Se2LcqyPawcFmPyB0zuoAkRI535bUz43LYeo4GYIsAm9ocJNI+M0r0K4
         J4I8N7PoGhWSihFHkUcfs+/U7u2x3ROb468rxy4IOk9g4iors7yy1e/0ePUzofbcQXxd
         4K+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688680828; x=1691272828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8F/Vz/JYKZUR7Pz5q1oBdNBG9fKmk/mb5bJHRVCY9Kw=;
        b=MB+ahPKzd0UmDK2rGT7D/4I5aHEr3CS/iyz3MFDKnponm/naR2CXZQgiSk7SqnOsIv
         JoUcnW+e5db1btZx99+kc0f7mKwgLQ7un0vDOqxqCtdgXN+pD8gWT0oAxTPsFId4odPK
         k8ZakND4IwDFxEdDknYTyZn+jaf48rLMdo9vO3LS54Druy0cvNAtQZ5pz9At/SwUgmGI
         /pAOvxIIDCYdZ/0bPlWDN+/NbiVLL2ZnHGxDU66W1knzaodfgzW947QX5T9/Sc4XA2Xt
         Qvj5Uo0/GN8wkIWLkb1pfQMEdkPMfcOKhQ4DvMLfIzvpgN36SZGFp3+Wc++1wQROfY57
         SUcg==
X-Gm-Message-State: ABy/qLbPhPxfi+bn9nW50JRKIiRJXAdklG+4B6od7u7ygFlhjcE1P+SZ
        k1OAj4Z83DiQ6tPCj4H8k5Q7j+2rcEUWZL71Qbk=
X-Google-Smtp-Source: APBJJlEiE2PjbiYsEKl3M8g1bnilSPcnnFTyA3koOOaWRTk6CKBXAXx6b56t8c9U+73ojunwVjmr/nE0y5iBpAM8Sj8=
X-Received: by 2002:a05:6a00:39a1:b0:67d:308b:97ef with SMTP id
 fi33-20020a056a0039a100b0067d308b97efmr3169625pfb.2.1688680827849; Thu, 06
 Jul 2023 15:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <1652963808-14515-1-git-send-email-shengjiu.wang@nxp.com>
 <CAOMZO5DtpoH0dLDX3=Sv4UUpX_=66VEZPsJUWQNnYviApfMLKQ@mail.gmail.com>
 <20230706084706.bzwsbi3zisx5m5rl@fatal.se> <CAOMZO5CCdaodWQrHUQgMizoES=jfEtw-sNJZG-DJMpRD8tZW9g@mail.gmail.com>
 <CAA+D8ANAg7bs0A35c7Af3_-5sLaqvT1RoKfCbzYi=z=t_q9LUw@mail.gmail.com>
In-Reply-To: <CAA+D8ANAg7bs0A35c7Af3_-5sLaqvT1RoKfCbzYi=z=t_q9LUw@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 6 Jul 2023 19:00:14 -0300
Message-ID: <CAOMZO5D_1cjZVpMvRrtcEGupAUn3EVU_G-p0Ju9gC2TaJh8G9A@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Enable MCTL_MCLK_EN bit for master mode
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Andreas Henriksson <andreas@fatal.se>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Hans_S=C3=B6derlund?= <hans.soderlund@realbit.se>
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

On Thu, Jul 6, 2023 at 8:19=E2=80=AFAM Shengjiu Wang <shengjiu.wang@gmail.c=
om> wrote:

> The clean way for fixing is to remove the code in fsl_sai_set_bclk()
> and add "fsl,sai-mclk-direction-output;" property in dts for some
> node.

Yes, after thinking more about it, I agree.

So what you are proposing is basically a revert of the patch in
Subject and I assume that the
reason you did the original patch was that you missed passing
fsl,sai-mclk-direction-output in DT.

I will send the revert.

Thanks
