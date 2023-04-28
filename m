Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393746F1096
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 04:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344803AbjD1Czg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 22:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjD1Czd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 22:55:33 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596C61BFA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 19:55:32 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4efd6e26585so7917407e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 19:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682650530; x=1685242530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ualfMvExtTozDIP/l8jZPPafZ9WiF7PxQwbci2mErXQ=;
        b=B5PKgTSt6dytNApZzM3Hd9/noMKj2xBE7by7tTvCYPeE0ZTvrJLcLvxklouYBd8ya5
         /oO03xhl3neSxK3enZsfwhVQs3MeoxR+5NrWVZ2+60ikCTViAF9NnQm9xo/EdIFv0R5+
         LMLjoOpl6Cr/rAjsd2nrNcpBk2k7t/v+WkoBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682650530; x=1685242530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ualfMvExtTozDIP/l8jZPPafZ9WiF7PxQwbci2mErXQ=;
        b=Gs2mTm1/xFkEtrDZbZ+8jFyCJAW/8IJI5eCSuPICNA9+0+xrPgGFz3scHMIkXzzKW0
         QjqSt40WdwR/5tC3hISO+fSLhDqFKMuEjY/XhYNb85zfLkyODDQXpOOnm0dGE3Lb9y3O
         DiaUVeun3BQW+qEKf2nND0kunC9+PF4l/NHYAcVxuG42OJujkrghaGIk6vfRnIeBG7UU
         e/GziS6pmpzITSY1maMiUgotN92Nc7b8LlClWZZ/e/So7S1ysJz9dE364MxHfQAxU3WC
         F2oFLGZ8gePWYRj/FnhOI30lk3KycbJWOCUsDw4XCr0RsQiSPEJBnGhoEz3ICbVAejAY
         Y8MQ==
X-Gm-Message-State: AC+VfDyRGQlwM8jZHCLIg86dAcRYiVTVjItu8uawPKxL/UY8CxP75eHq
        KR/vaCbQ0BpzHCLwRJjna/6zJhRIZJra8noO+OBQHg==
X-Google-Smtp-Source: ACHHUZ5MkcpEVQoaA+FP0cUZC3QX7wDncbhBWd72bisOlv5caiRxn1XesrizvqMXXW28SdInPMhzfg==
X-Received: by 2002:a05:6512:71:b0:4ec:8615:303e with SMTP id i17-20020a056512007100b004ec8615303emr1182536lfo.33.1682650530429;
        Thu, 27 Apr 2023 19:55:30 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id g2-20020a19ac02000000b004ec87cf6b69sm3177931lfc.169.2023.04.27.19.55.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 19:55:29 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4efea87c578so16947e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 19:55:29 -0700 (PDT)
X-Received: by 2002:a05:6512:ea7:b0:4ea:e5e2:c893 with SMTP id
 bi39-20020a0565120ea700b004eae5e2c893mr44031lfb.1.1682650528920; Thu, 27 Apr
 2023 19:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230427023345.1369433-1-brpol@chromium.org> <CANiq72nxNtLvx1J-50F8D05QQjx4FBPkrhg6pysc25RL6--Zhw@mail.gmail.com>
 <CA+_b7DLoTEn6_2auTVN9Wj62ogOFXnhf7kTmh_KCZPkCBfJsSw@mail.gmail.com>
In-Reply-To: <CA+_b7DLoTEn6_2auTVN9Wj62ogOFXnhf7kTmh_KCZPkCBfJsSw@mail.gmail.com>
From:   Brandon Ross Pollack <brpol@chromium.org>
Date:   Fri, 28 Apr 2023 11:55:17 +0900
X-Gmail-Original-Message-ID: <CALWYx-bvyzN3nGtGpLKyoayWLtzKwJGCtdFMfg=6bJSP2qYNGg@mail.gmail.com>
Message-ID: <CALWYx-bvyzN3nGtGpLKyoayWLtzKwJGCtdFMfg=6bJSP2qYNGg@mail.gmail.com>
Subject: Re: [PATCH] .gitignore: ignore smatch generated files
To:     Dan Carpenter <error27@gmail.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        ojeda@kernel.org, alex.gaynor@gmail.com, keescook@chromium.org,
        nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 8:20=E2=80=AFPM Dan Carpenter <error27@gmail.com> w=
rote:
>
> Thanks for this.  To be honest, I hadn't remembered that Smatch
> still generates trinity_smatch.[ch].  I would prefer to just delete that
> stuff.  Another idea is maybe Smatch could put everything in a
> smatch/ directory?  That feels like maybe it would be nicer?

Sure, that'd be great as well.  I'm pretty sure that smatch outputs
these files from whatever directory you run from, that's why I did the
overall pattern rather than a path pattern.

Should we just patch smatch to not output trinity* files and output to
a directory and change this patch to mask out the directory?

>
> regards,
> dan carpenter
