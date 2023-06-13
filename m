Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CEC72EB25
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjFMSlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjFMSl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:41:28 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CDD19BC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:41:26 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b1b72dc2feso73269911fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686681685; x=1689273685;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FdT67fKucfyqLof8pjePvycJSeZz/0hJjuTHyY9IUKM=;
        b=VAH9jlwMkv8XQJGyD4wIrvQtTomQuaRcXoVjeuqDuR/vdl0iQpUITtyOjSo8ia/q6I
         MMR8+c/X/f5SIx8C1CeVjam0rOeJViMBaeS4MlKAJVjrWn3jXEa9auMPu0MoBXFDK0RA
         AdNOdlr1WXnmWpY+0AT1JBKrk2/yDdcjIWRiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686681685; x=1689273685;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdT67fKucfyqLof8pjePvycJSeZz/0hJjuTHyY9IUKM=;
        b=W4eWUOCehDhTbV7laOVmRrPmg4MKtzwy38Zo3/JTrfYfZHwwv+28zBEKL8xxtLwLtA
         +t9eDEn3gjwxRh9vld0pKbzDEr7yq6sMmodm5+JcgKhOfA0RbKtClT+rOOZ1c6jHiJ5W
         UvyjXFpIlYb9zvxviIf9ULspQLo4L733Vgsrp72qeNJF6Z1kd2/j5mFJBDwgc1wLlbBa
         TKX5h6cw/ULf+TrPrmdRogi8hyfB3l0WoFI9NaJ3D8gozQgZzDFNJ0EQ1sJzgp8C/Yj4
         Iy1KyKf4BXZcA64paXSQ0byzvwbrpNjqxQjjautaNj5YDNvXBUO9yq1sjagG/UmE8/IO
         kLzA==
X-Gm-Message-State: AC+VfDzrWMgos3HkD0ztO4qC3D2eJFyqrNO2megLr+V1gRKBPEUcYK5K
        KqB0W9ZMSxNujostkkgRlMdnv44z5C/OKhaCKvRYYQ==
X-Google-Smtp-Source: ACHHUZ5twIRLMsNYAqsbiwGsP6jZQb3rUvX+RJR4V3HQjUTdHbwI5IDzQFtLAlmAacz9JWEA8JTRY/i22CNlVbJN2uM=
X-Received: by 2002:a2e:3801:0:b0:2b2:a6:6132 with SMTP id f1-20020a2e3801000000b002b200a66132mr5527545lja.25.1686681684721;
 Tue, 13 Jun 2023 11:41:24 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 13 Jun 2023 11:41:24 -0700
MIME-Version: 1.0
In-Reply-To: <20230613065812.v2.1.I24b838a5b4151fb32bccd6f36397998ea2df9fbb@changeid>
References: <20230613065812.v2.1.I24b838a5b4151fb32bccd6f36397998ea2df9fbb@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 13 Jun 2023 11:41:24 -0700
Message-ID: <CAE-0n51fbLvobz-R_3LWPZBRg7SNOxgFQ_DYqMo820W_4UOhDA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: ti-sn65dsi86: Fix auxiliary bus lifetime
To:     Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2023-06-13 06:58:13)
> Memory for the "struct device" for any given device isn't supposed to
> be released until the device's release() is called. This is important
> because someone might be holding a kobject reference to the "struct
> device" and might try to access one of its members even after any
> other cleanup/uninitialization has happened.
>
> Code analysis of ti-sn65dsi86 shows that this isn't quite right. When
> the code was written, it was believed that we could rely on the fact
> that the child devices would all be freed before the parent devices
> and thus we didn't need to worry about a release() function. While I
> still believe that the parent's "struct device" is guaranteed to
> outlive the child's "struct device" (because the child holds a kobject
> reference to the parent), the parent's "devm" allocated memory is a
> different story. That appears to be freed much earlier.
>
> Let's make this better for ti-sn65dsi86 by allocating each auxiliary
> with kzalloc and then free that memory in the release().
>
> Fixes: bf73537f411b ("drm/bridge: ti-sn65dsi86: Break GPIO and MIPI-to-eDP bridge into sub-drivers")
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
