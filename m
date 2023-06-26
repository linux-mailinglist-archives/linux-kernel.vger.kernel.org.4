Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAC973D589
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 03:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjFZB2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 21:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjFZB2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 21:28:14 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D47194;
        Sun, 25 Jun 2023 18:28:11 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a1ba074dadso1076881b6e.1;
        Sun, 25 Jun 2023 18:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687742891; x=1690334891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KZNMyDXB/fy5OKIT9JHt+RgpT4vpVpO98zJF2YAzk0=;
        b=KBXKSMEvvc1sS0bTW7N9oqVp1u3NdVhbyxc+5nsvOVGQ1cvj+gMtXQukb1ZrvASdOd
         neeDFwOHMGSTtvMe5hgB6h1lNMLZk2DtvF7mR71gxD5GJUUwUpI5iEXg595HWVZ+7F/0
         s7Gwgzj0NmBUvbxsRGNnDJXbggxdI9aj0aGg10rbfgtU49ZRvtvSsWfcN+k/kryw7TF0
         Vw8Zzf9s8hFBxxlvUv3E/XfuiQrekNr62n9fJoUJicTcBeaNSLRs+2STUQ+gGWVFM8f7
         9GsM24SxZHXa7t+Eqh2MDy+zSDY7nXx1HGABBeuOBbemzLWn8eIL9hbId2aE5wDpnGxH
         X6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687742891; x=1690334891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KZNMyDXB/fy5OKIT9JHt+RgpT4vpVpO98zJF2YAzk0=;
        b=K+vUV22D1KLc7Djvkh8PaGg7EW9n2dWzcPa+fRyoWfN16bsZ4RRTOhPaDYBLZIBBsO
         ERa69h2iiYfcJ4g61dHn6tOfSrnKs88bnrFnHJ8DF1Vi/MPBvJeDREtTjxGLDzpyNxRD
         TXc2mHkBOG5m1SFe3Q+s1YIqcenycofXC2usqnJ9/B1thxd76poSYG1k+H0WPBh8ubCl
         mnWloViFVDSDoSMJtUJFD84YxbzzqfTHLaqIFQMCvuCUcg+T8NmQslSxz161HZQOLXVk
         DMRchPXrKggJB10ooDTyb8nyLMKF2XId/iCQ9MIgJAkdN/aN1qfL+8Ow71UQD25u8Qww
         1nuQ==
X-Gm-Message-State: AC+VfDw5Vb7R/qukJGn8WnqGDu/iTyPZteFlPC0TgmswN9kAvlAKc+kX
        wE7cP6O0XZLn3ccLcL1DuVjS1Q3rXgwN9KApYirIuBqD
X-Google-Smtp-Source: ACHHUZ7I1eYXh7yUSMkGZU/5hN3SoNfxGTarJARtmwKUb7YRrYzLwK2EKNtcr4Xzq0HJMxRDVZJ80V6v03BgamutDzQ=
X-Received: by 2002:a05:6808:13c1:b0:3a0:58f9:e982 with SMTP id
 d1-20020a05680813c100b003a058f9e982mr12732237oiw.27.1687742891144; Sun, 25
 Jun 2023 18:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230624133808.621805-1-jcmvbkbc@gmail.com> <562ff26d-df78-c1cb-6a34-b9a97efdc43e@web.de>
In-Reply-To: <562ff26d-df78-c1cb-6a34-b9a97efdc43e@web.de>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Sun, 25 Jun 2023 18:27:59 -0700
Message-ID: <CAMo8Bf+KeW8Gx22ddHjco2vJh1zanRaiHDvi0Jk0-rUpMX0kkg@mail.gmail.com>
Subject: Re: [PATCH] xtensa: dump userspace code around the exception PC
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, Chris Zankel <chris@zankel.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcus,

On Sun, Jun 25, 2023 at 9:36=E2=80=AFAM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> > In the absence of other debug facilities dumping user code around the
> > unhandled exception address may help debugging the issue.
>
> Please choose an imperative change suggestion.

The change itself is so small that it's fully described in the
subject, and I believe
that that description is imperative. This part is the rationale. From
my experience
I cannot guarantee that dumping user code will help, but sometimes it
does, hence
the 'may help'.
Please let me know if you have better wording.

--=20
Thanks.
-- Max
