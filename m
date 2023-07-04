Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595A6746AD2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjGDHjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjGDHjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:39:52 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9DBAD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 00:39:51 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5700b15c12fso63157797b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 00:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688456390; x=1691048390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xp+QKEk7TTS2IiTonm6ANj4/wmZQdWj2NqG5aVXpncM=;
        b=bHYWYL8i4lzh8sEhz5VZ8+QaouZrpUmg2mnnB9W2cInPjOz7hlnDoU+HGYgvKXBVjm
         mytGluOUKmL28Mxr3kXdWQIcLu+ZI6M1RV/LyiNYkJizaECi4u1c2HBrkYjW4UViirN1
         ZB+kzmzWoNlT6DMXJJzMfNPahkMge+5q5qOenf8yORBDkr4oHl06HX2XEWkroMSb5TdW
         Ha74K4JQds9cf4q4KuV+Ay1sBb+IV2zRzSEOy83eTYtyFhY5zUPjo8hy3SoOpZLF8YH+
         3nIA8dM07vcG7lUiwsEgxO+WmO2oM9sQhyNQXyAwU0u34iE71/eY28Eb0wHJbA0h17nU
         ngwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688456390; x=1691048390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xp+QKEk7TTS2IiTonm6ANj4/wmZQdWj2NqG5aVXpncM=;
        b=aQ+2LHlYgWK06rsM8UXQBDvsqEbOOp4DNUiYw3YOeLJgfF+IkjIGw1Zkc5ZIpoO9rb
         KZ4R3dnJaTckU1GMCvPL4pfdT9OdWYM8bvOZ7Ge78eZuRaAWAi9FOvCxXZ3RpGNim4pA
         l6Ixp+g6ghqMrrErziw3gvwaFEojpSsjtMgk6GDWQmUXFRUbKoWByPQf+4uqSOdy6IP3
         SkhXPdz1lIWBADkKYRiWiAgjXaAXQy5DVY9BVyaKyfqXCFxmrP7WIHppDkgdn+G9Sq7E
         vKSxIITz/VBpZLuF8H4T+fCy/WeT2zrutM8ZipTSOZQUk1RbHeU2zRir4qJeAP8RjzU4
         wF3w==
X-Gm-Message-State: ABy/qLbf4T2EjuROcejdvKXAiRvG7GkVrv7+wzzjYHgZOTWIjEm8vJOU
        l+wY+0MuHTMyQu2nStLc5FpVhkzsv8Jhk/T3Xq1YcvvbunAviAj4
X-Google-Smtp-Source: APBJJlHDKKwZ79lFPkNzLD0TjSMaB69YfKzURQNSkXUvL8aTFXOSk+TSkTezVMXogst0zaQgctBCu8vKcQH5YGpdOw8=
X-Received: by 2002:a25:8142:0:b0:c02:e455:e2c0 with SMTP id
 j2-20020a258142000000b00c02e455e2c0mr10207480ybm.11.1688456390657; Tue, 04
 Jul 2023 00:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230627050148.2045691-1-yangcong5@huaqin.corp-partner.google.com>
 <CAD=FV=WR=fnhCxC37Eo3hinh2MV=eTNuXG+GrwgR6K_pV4Rbaw@mail.gmail.com> <CAD=FV=UcFn7Wq_Ock6RCT0mPhgjpJwF7dJjcbwcoESW9nni62Q@mail.gmail.com>
In-Reply-To: <CAD=FV=UcFn7Wq_Ock6RCT0mPhgjpJwF7dJjcbwcoESW9nni62Q@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Jul 2023 09:39:39 +0200
Message-ID: <CACRpkdb_6n+CKUHYu5nAtCEKK_VwO2hGUUCHny56oSYt_vTfLw@mail.gmail.com>
Subject: Re: [v2] drm/panel: Fine tune Starry-ili9882t panel HFP and HBP
To:     Doug Anderson <dianders@chromium.org>
Cc:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        neil.armstrong@linaro.org, devicetree@vger.kernel.org,
        sam@ravnborg.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, hsinyi@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 2:42=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:

> ...this means that it lands in drm-misc-next-fixes, so I've pushed it the=
re.
>
> 59bba51ec2a5 drm/panel: Fine tune Starry-ili9882t panel HFP and HBP

I guess that means we need to merge drm-misc-next-fixes back to the
drm-misc-next branch so that I can rebase my series breaking out the
ili9882t driver to its own file?

Yours,
Linus Walleij
