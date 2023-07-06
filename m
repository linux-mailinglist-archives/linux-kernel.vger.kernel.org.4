Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19126749D54
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjGFNW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjGFNWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:22:25 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7670219A0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 06:22:24 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-682b1768a0bso147213b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 06:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688649744; x=1691241744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+D+QKK+V9y/nBwFyOGwDPW6/JU+V8a2ffx9sQ1ifyI=;
        b=E7s/Y1ty/VDpvP5mnN9k487LRb7Hk9ZnjhLCuopgu77+FR0Sj7RjoF7VVwK9F+XhtU
         luETDyvizGQdrKnIui4DnmxetSyME8aO+UybjP2VJFOB0mC2dlMr/x0MKPHBmG7R2Hwe
         fFH9oBBOAoSdOHSLNgqzwwTVGY3xOl+8JaoIn0Cr+kWvmOa2hMDYqLsUJLw3hq0QNTAN
         ZkkzgIzRrqSBmfEOaKIXoWwNEUBUI9nfmW8XyY7rsELySVd5pkoIDYQWxrjWRdMnhZoS
         isob8hZQSGU91B30eC/raUtaaKbMlCBwT5LXLzhQto/gVkqrsWS2xiPGlsF33Psqtf4u
         pRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688649744; x=1691241744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+D+QKK+V9y/nBwFyOGwDPW6/JU+V8a2ffx9sQ1ifyI=;
        b=MUR8/2bUfFZ4vw/hgOUz+M6EbQAz+ygk7JQO7tuWuNIfBX+lObaEC/dxE4A6sDpSJs
         3NV2x+frgXy5onnMM2L4NwQRk+KZHYNs/R9dBurL3yuNOdOwGwo8kqvkiSa7QKehzK6k
         CxcZ1Fw0Rvfl2PdNs+wQSfO1GBTiqmMWZ4ZphYUFoVxvLDn3P4XyhmXfyrI3Ge0QSxMJ
         872wqN16RxjfihFqvzFs0MCOAdrE9QGjuCm8jB4TnHqudTuQMVv/sU07OAER/7H2axok
         z2gKK6YZiGug19BvR1znBLY0Dq68qyo66c6eb/BufA+5XyNl6Gr2nDzH6PMHo734V2rp
         7Tbg==
X-Gm-Message-State: ABy/qLb86m2+plVwkDYfQJa02+LRkKWU5zJDnvbCKfl4UlatY4/+iod0
        z1MM4QeeO/f6qlWKGsp9FK/pwzfKP+64W0CKvDc=
X-Google-Smtp-Source: APBJJlFCKu7vaNfYYwvzzuc2kPB8Td6VMbpcT9KZ8a0UyW1X9PGMU8ri8DNniH1sa/11VCC1WLJc0mpnsXXsJuT0Id8=
X-Received: by 2002:aa7:8815:0:b0:67f:7403:1fe8 with SMTP id
 c21-20020aa78815000000b0067f74031fe8mr2110292pfo.3.1688649743851; Thu, 06 Jul
 2023 06:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <1652963808-14515-1-git-send-email-shengjiu.wang@nxp.com>
 <CAOMZO5DtpoH0dLDX3=Sv4UUpX_=66VEZPsJUWQNnYviApfMLKQ@mail.gmail.com>
 <20230706084706.bzwsbi3zisx5m5rl@fatal.se> <CAOMZO5CCdaodWQrHUQgMizoES=jfEtw-sNJZG-DJMpRD8tZW9g@mail.gmail.com>
 <CAA+D8ANAg7bs0A35c7Af3_-5sLaqvT1RoKfCbzYi=z=t_q9LUw@mail.gmail.com>
 <CAOMZO5BtrKwrMwrjVDbYn3ivt2uV9rzbSDxd8qfiYjOBMvKBgg@mail.gmail.com> <20230706123401.kctossjho26bry7e@fatal.se>
In-Reply-To: <20230706123401.kctossjho26bry7e@fatal.se>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 6 Jul 2023 10:22:12 -0300
Message-ID: <CAOMZO5AFjS+aGjHTYCvPO86ypXfcFnuKmU2qHZNTyDSQPxRHjQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Enable MCTL_MCLK_EN bit for master mode
To:     Andreas Henriksson <andreas@fatal.se>
Cc:     Shengjiu Wang <shengjiu.wang@gmail.com>,
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

Hi Andreas,

On Thu, Jul 6, 2023 at 9:34=E2=80=AFAM Andreas Henriksson <andreas@fatal.se=
> wrote:

> I think your initial review comment was spot on Fabio. There probably
> needs to be a(n imx8mm) specific flag that says when this workaround
> should be applied and gate the code in bclk function on that.
> Atleast that's the only thing I can think of if my interpretation of the
> problem for imx8mm is correct.

Yes, deciding whether MCLK_EN should act as a clock gate based on
the number of SAI registers seems fragile to me.

I have sent a proposal as RFC. Please give it a try if you have a chance.

I would like Shengjiu to confirm if imx8mn and imx93 should also
behave like imx8mm in this aspect.

Cheers
