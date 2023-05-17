Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE8A706D1A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjEQPoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjEQPn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:43:57 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC201558B
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:43:55 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3f4fc2a4622so6296081cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684338234; x=1686930234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xeS9KwC8vW2y0J+xxczH/UzoaJDpNT/4GWb3cUgqXk=;
        b=NSBvzMpq5pGZtSDvil9rUpMWJrztHiWlRnPH36fwzsewLZ3mIEFCC2DdNHo6G7SWvH
         /5c8NN3nXBhzI7pCSPOESZo8D2Zzdt8gMbOTwxLgwy35KBRX3PD5s0puTlqgfTIlQZlI
         1/82g13Qqbxd+Z+BQAwEPXsxaYg4rfnvYIbtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684338234; x=1686930234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xeS9KwC8vW2y0J+xxczH/UzoaJDpNT/4GWb3cUgqXk=;
        b=TpBxijT9fCPKwI3By1GKpq+nnIMinhMdH7h2m0cGCrNlVNK6GYh/nUL/fS/0Gy0v/A
         Iyksz5yq4XrYjGo+TMNDpN9bwbbktLXa79hqw5VmwLZ+7Oz1K8o1or9jg5KOomPsWmwl
         mo8sWzZa1IpA9XBQ454wmmUH/eenqVOswpf04qebeNklfKX/O13U/5bTaJU9KWs75zB8
         Y8jZQYXCbHRqPGx+nR9DYuqxqTPC85oHa+SvUFzXGm4sVZuXdJN2SGq5D+UaVKn7pqde
         ZxWQXJ3JlbCJgdjth0+yLlYX6KPSdFvuFQh+Yj3o0it0O+wPq+ConWNGNCnRa4OfxMGj
         HilA==
X-Gm-Message-State: AC+VfDwk7txMw0bpDVpYrGe3/n9YfuCVcRo5o1+lCFeWCAoIYj7o3yxK
        ZFzkAuAeP3t3GxrwAMg0rOffCBVoR/gXbT+pKTw=
X-Google-Smtp-Source: ACHHUZ7UuhKImX14ei6WVrXCSunTftnebCAd8WmsYm+zQk+roHD9JGLYTDH5GpB/gYPWvM05BWoLLA==
X-Received: by 2002:a05:622a:11c3:b0:3f5:3852:83c6 with SMTP id n3-20020a05622a11c300b003f5385283c6mr226499qtk.8.1684338234435;
        Wed, 17 May 2023 08:43:54 -0700 (PDT)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id g6-20020a37e206000000b007577c68be4csm686837qki.117.2023.05.17.08.43.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 08:43:53 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-3f396606ab0so207651cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:43:53 -0700 (PDT)
X-Received: by 2002:a05:622a:144b:b0:3ef:31a5:13c with SMTP id
 v11-20020a05622a144b00b003ef31a5013cmr262636qtx.3.1684338233391; Wed, 17 May
 2023 08:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230517124802.929751-1-arnd@kernel.org>
In-Reply-To: <20230517124802.929751-1-arnd@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 17 May 2023 08:43:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X8pAgFUngLd475d9-zkF13Fzs35-O4tCSHR+jX4YBBXw@mail.gmail.com>
Message-ID: <CAD=FV=X8pAgFUngLd475d9-zkF13Fzs35-O4tCSHR+jX4YBBXw@mail.gmail.com>
Subject: Re: [PATCH] kdb: include kdb_private.h for function prototypes
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
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

On Wed, May 17, 2023 at 5:48=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The kdb_kbd_cleanup_state() is called from another file through
> the kdb_private.h file, but that is not included before the
> definition, causing a W=3D1 warning:
>
> kernel/debug/kdb/kdb_keyboard.c:198:6: error: no previous prototype for '=
kdb_kbd_cleanup_state' [-Werror=3Dmissing-prototypes]
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/debug/kdb/kdb_keyboard.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
