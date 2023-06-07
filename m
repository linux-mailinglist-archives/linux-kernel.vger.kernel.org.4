Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E207264CB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241275AbjFGPiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbjFGPiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:38:02 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E54125
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:38:00 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-77ac30e95caso40896939f.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 08:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686152279; x=1688744279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXbni84obcY16QzSHbrmnrA3al4OUUVujL7MZjdZlAQ=;
        b=QlRRUuotjnILQ4+DNDI9DI+GDIasRWsNs7Hbmqv09ZnktCAQ+aiFddLDqQSeQNg3Me
         Onemkt1uTxI+1GJVHRzez3Qpnkiq/VE5dJnaSg5YMHhh31WW86jlgc9UmRR6iNq4vecX
         YAJoxYu83yiqXJWLlFWeryPxYzQ7ORyONHtN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686152279; x=1688744279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXbni84obcY16QzSHbrmnrA3al4OUUVujL7MZjdZlAQ=;
        b=PQO+jBnUBMVATzFnqKa7wWfyon5b5i0xxd8LzxcC5FZ0MCI3PIzI+ATzcZOUJTEVV7
         PLUEuDzmUI1pG78HqNDn/g813TL6qOKwFYbxWoqGyjL9kufxVoRyQDaMq9+p/wbaCML2
         baO7b1OEV/jczSYOZRaxIt4AJtq9g3EmgWMNG+4PSh9ohfoi8Go37ne0WgBJGpMud/ki
         oAPcl+LOCVLVoy7ZGz/DytUw8L1FlsWY8lIUueOtgXt/zRawP+CbVkQan3QSf5Uxs5J0
         XQMy0QkoM8owRLV2aZWHHmcw/KwQfSjkUBoihhqnRHF3vezB+ksTA3sD/5iL0NeKhETx
         OP0g==
X-Gm-Message-State: AC+VfDz1dzIGLoK/l735Ebs6mhUqbjJEX65A/3xFKfGX+3EzaRA76zUg
        FBKa9juhVRc06L5vjxK4mMFxVNNi7h7BoTlIcR4=
X-Google-Smtp-Source: ACHHUZ5UGpTUbIyjc2kRjFaJm8m3q9J6VhSzk7kGCadprsBobyvprF/8ON7P0xuWRPPBAx6tqHD/fA==
X-Received: by 2002:a5e:dd09:0:b0:774:9c66:cbd6 with SMTP id t9-20020a5edd09000000b007749c66cbd6mr9164242iop.17.1686152279380;
        Wed, 07 Jun 2023 08:37:59 -0700 (PDT)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com. [209.85.166.179])
        by smtp.gmail.com with ESMTPSA id i3-20020a5e8503000000b00777b101cdc3sm2220873ioj.17.2023.06.07.08.37.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 08:37:58 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-33d928a268eso149145ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 08:37:58 -0700 (PDT)
X-Received: by 2002:a05:6e02:1a8b:b0:33b:5343:c1d6 with SMTP id
 k11-20020a056e021a8b00b0033b5343c1d6mr173474ilv.21.1686152278253; Wed, 07 Jun
 2023 08:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230607150615.241542-1-laura.nao@collabora.com>
In-Reply-To: <20230607150615.241542-1-laura.nao@collabora.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Jun 2023 08:37:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UH9WK6+gVGHyxMamCu1XqF8CKto1f6pegOFT+gGrg3yw@mail.gmail.com>
Message-ID: <CAD=FV=UH9WK6+gVGHyxMamCu1XqF8CKto1f6pegOFT+gGrg3yw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel-edp: Add AUO B116XAB01.4 edp panel entry
To:     Laura Nao <laura.nao@collabora.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 7, 2023 at 8:06=E2=80=AFAM Laura Nao <laura.nao@collabora.com> =
wrote:
>
> Add a panel entry for the AUO B116XAB01.4 edp panel, found in the Acer
> Chromebook Spin 311 (CP311-3H) laptop.
>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>
> Changes in v2:
> - Sorted by product ID
>
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

For simple updates to this table, there's not much reason to leave
them idling on the list, so pushed to drm-misc-next:

1ebc9f0365ef drm/panel-edp: Add AUO B116XAB01.4 edp panel entry
