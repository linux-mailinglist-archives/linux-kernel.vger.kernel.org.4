Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDB472200D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjFEHuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjFEHuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:50:07 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C81D1A8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 00:50:06 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-39a55e5cfc0so4191955b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 00:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685951405; x=1688543405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4faFP8A0r0X78bHV6Nl0Xmhbz8/0jgKJObe45f18FIY=;
        b=oPVGhyaEEshqI+qZYk/QxcetvoJbpgt1Qfs5LkRLvOoqPcWQ8myJlJ9+AK8ToDqUT9
         PwQsqPL8s85zwhQGhORYcdzInmL6fCgTkOB2Rt9qbTog2hcv2AIq/dHqi7IGyen9s6yD
         D9Yx5Xcn45mH63QmYGvI36IFfmu5p2jc9n1jitmENvKtiQFEy8tW6qqjfWpL6AZfLES4
         CuUB3aRzqFS1xIV+A7/ghNtQ3hTBBOr//d6yMISx+sfJa6Jre8oNTi+8Py2XCtIpbQFQ
         YFV6e26ys5rD7McBkH4DCw+rlXfiwpCbMUm3TUj+AuYzbVcjn2jIGmfEX9dB60WJ2hwZ
         ihGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685951405; x=1688543405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4faFP8A0r0X78bHV6Nl0Xmhbz8/0jgKJObe45f18FIY=;
        b=GTlpj/ojf2i5HsWBJwSO2yoayNjdzRvMdIp0u83KVK9ZaQMLGDdY02xOImOTPxWdYh
         4c6pv0ZDRmTJMwIrNqmtxSHdWk38vbBeg1al6r9vKYywRHLX9YEAnh5x1CXGxAiPTGDd
         4Sw0Wvk2ORtIINNBE8q+4LbZnx9cWinKxfjl2UA5DtAwSmX2IdYJnQ8dE+ep15n6O1vb
         VyMkSL5G4+k8WXpcEVFru38iYgM0aC1jbcYZGJhaL5hy7p4tM5ZtNm58nnrcO+X7bFcW
         u7tnfgAibyRxkiICOWpE1Dpr4F6VUFYlvAzhwySXOuF5fSxBP7OxuL4TVhak+3HqHide
         dIqA==
X-Gm-Message-State: AC+VfDxEjOQaPI2/oa73aXKkzy6ub/tsGHAixakZlJ8YRMNFoVFcJLre
        I0R4p1tyn9qsYrgsRRrDnQEl6EwLsP1U0aRaPsY=
X-Google-Smtp-Source: ACHHUZ7MZ2VcyBXtDSPmFFZvu3octS0FxXw5m114X8R2/Nn68gej8qQH+MsLY3w52UcaSJOQ34FUCI2Uq3jB5eBRKoQ=
X-Received: by 2002:a05:6808:359:b0:39b:5968:deb9 with SMTP id
 j25-20020a056808035900b0039b5968deb9mr231404oie.39.1685951405589; Mon, 05 Jun
 2023 00:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230604075713.1027261-1-masahiroy@kernel.org>
In-Reply-To: <20230604075713.1027261-1-masahiroy@kernel.org>
From:   Ying Liu <gnuiyl@gmail.com>
Date:   Mon, 5 Jun 2023 15:49:54 +0800
Message-ID: <CAOcKUNXT9heNVCpqZqEy7MOx6=+oYZKXKQgsTLLWmffP-v8nhg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/bridge: imx: fix mixed module-builtin object
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Liu Ying <victor.liu@nxp.com>, linux-kernel@vger.kernel.org,
        Nick Terrell <terrelln@fb.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
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

On Sun, Jun 4, 2023 at 3:57=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
> With CONFIG_DRM_IMX8QM_LDB=3Dm and CONFIG_DRM_IMX8QXP_LDB=3Dy (or vice
> versa), imx-ldb-helper.o is linked to a module and also to vmlinux
> even though the expected CFLAGS are different between builtins and
> modules.
>
> This is the same situation as fixed by commit 637a642f5ca5 ("zstd:
> Fixing mixed module-builtin objects").
>
> Split imx-ldb-helper.c into a separate module.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> Changes in v2:
>  - Add a separate module instead of making the functions static inline
>
>  drivers/gpu/drm/bridge/imx/Kconfig          |  5 +++++
>  drivers/gpu/drm/bridge/imx/Makefile         |  5 +++--
>  drivers/gpu/drm/bridge/imx/imx-ldb-helper.c | 20 ++++++++++++++++++++
>  3 files changed, 28 insertions(+), 2 deletions(-)

[...]

Reviewed-by: Liu Ying <victor.liu@nxp.com>
