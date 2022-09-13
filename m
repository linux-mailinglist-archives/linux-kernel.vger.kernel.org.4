Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFCF5B7D06
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 00:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiIMWYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 18:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiIMWYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 18:24:03 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3252D74DEC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 15:24:00 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so12685891pjl.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 15:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Mn9WBo5vNNbs0NZJBbiO/Yi28wMF/lgC71dq4ukkoxE=;
        b=Dubdtf184nm84qSfvmgvXOaoKydU193nKrYzRylLXH5pTxCx/EiPSQhBryggNtpSPw
         7dhYt/5APvLYyi7HiY1eUJh4GW+Y1P6SbKRN4mFj8umVUMA/XAnIIxvgofSNBuk4Lc9z
         ejY8Jr+V8zRwa7zRzy5+ZzAMhRmrSW6mGEz0dMIY4SQhGrCvpPVmMHxv1HNChGiOb4b3
         F4rHo62tImNd98RCVCSodsXZrLh9NJqrKy1BF6m86EFHBG/LCQsil0p8qZZMPdviHgNQ
         rXCaImFIuECYoPeovbaFPCBiRi60XvRfm7I/HlUFGTSYcq4KIGNqr5+gq5OL92KZ0zYx
         xxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Mn9WBo5vNNbs0NZJBbiO/Yi28wMF/lgC71dq4ukkoxE=;
        b=DD6La+gnqgots6ylELaGUbT52vGNCdDN+MaI2wOq05KGHFHAnP6DDTO7dvX0xdqwnc
         O04oFAAVgkjip8rnL8p2W46yjYrNIuhyg4Nyg4gDUvhGUroovQy30Jn2MsPWLX9pP9l+
         +XoY6aH+o4adHRLJ88DsUUVKVCPqf9/4yG6VipuNkkwsMI+K6zF46jP3wPW0lczsrxsv
         uXEkZyfniLnbKdHr0TNASNkGJMOQmRuX6sYrJ6UU0kqcAI4CBJSvftCV1zM0jHhNIUND
         OZ5a8uWuCjYHWbvZHmH5NSZwEZlDP2mLuWh5ZbHm9Zkb1Iwf1NRZr1kjBohrvpoVQwLY
         Ts3Q==
X-Gm-Message-State: ACgBeo23VBqIJjX6bal/mnKbktFROpqI6o58LruQMopmuZZEe3HagHUi
        YlCn3PIJ4mk/sOzx0kqLMmHREQSNOhgJMIB0TjA=
X-Google-Smtp-Source: AA6agR6axQZpOW/L0c5XHtQuHfj2iBCzW+WtzyTHa/pa3vc6ipX86M2QMYAVLusKm7rTN+WViK7NZUzyaIPmTyNN9Rc=
X-Received: by 2002:a17:902:f782:b0:173:1206:cee0 with SMTP id
 q2-20020a170902f78200b001731206cee0mr33234283pln.130.1663107839649; Tue, 13
 Sep 2022 15:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220913205544.155106-1-nhuck@google.com>
In-Reply-To: <20220913205544.155106-1-nhuck@google.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 13 Sep 2022 19:23:46 -0300
Message-ID: <CAOMZO5CYaxdgn=Wh2CKsbJegb9hu40qEPOAEYy6x2qxpvPZseQ@mail.gmail.com>
Subject: Re: [PATCH] drm/imx: imx-tve: Fix return type of imx_tve_connector_mode_valid
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     Dan Carpenter <error27@gmail.com>, llvm@lists.linux.dev,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On Tue, Sep 13, 2022 at 5:55 PM Nathan Huckleberry <nhuck@google.com> wrote:
>
> The mode_valid field in drm_connector_helper_funcs is expected to be of
> type:
> enum drm_mode_status (* mode_valid) (struct drm_connector *connector,
>                                      struct drm_display_mode *mode);
>
> The mismatched return type breaks forward edge kCFI since the underlying
> function definition does not match the function hook definition.
>
> The return type of imx_tve_connector_mode_valid should be changed from
> int to enum drm_mode_status.
>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1703
> Cc: llvm@lists.linux.dev
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
