Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574856B2D55
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 20:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjCITFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 14:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjCITFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 14:05:39 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69642E681B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 11:05:38 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id bx14so1922046uab.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 11:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678388737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABPFEshIWi6btxmwjN/J9tsnrtcZ5E4ZFNt35MshmM0=;
        b=X6XndTs8w+LqSolBW5itG+oaRY7iA2G+t0K7tGI06zskVXnalWX4mn5z0EUn6+GsIM
         xAQDGAbzfoew/FzZIkhLcFkMGq/mbIMZd6wvDQmIY4iWUF+2aFSJBLzttN9pHV0BRZHM
         8F/5+e7ZZ0oZN7LZNibzwIWOb2a79XJyzhnb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678388737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABPFEshIWi6btxmwjN/J9tsnrtcZ5E4ZFNt35MshmM0=;
        b=F1X8qbj8oljzjR/LW+x4jgLcEOJU1gjnAPqYM9q5Iwm+P5I5ZvVwamhat/suY7KhtI
         bZWnOE1nRTIg8CLydUOdqcBZToOLAFo8MYL2xdDY47aNDYL7aWl6zfpUHHeC7B6r1RrL
         pFtP4UlKh6u1kc+J2qhx4NoJfY1gaGm2a+9gHNpbXcwidghqpGg0K6Wfz2fmjMbsKYh8
         N/q4gBKm6foDgkfUikAZXNUMjQCTUhtQszx2pi8ES8GikVO4MADj6FiyoMufKFcqPM0q
         y/k3kcQoeBurFDPZ2tlTE6Ml8nIrg+ErAzdx4dWSgL7YQ7OV8WFPBQYMgY5inUHz/Bvo
         a5Yg==
X-Gm-Message-State: AO0yUKX36OLWQVEze712ITWDA5zryFTL6Rhwdo9pWY1KmH9tKCNs9b6c
        MhtaEmblgESXjrQS2xtHP2xYtjKL1tsrF8+M7WHrlw==
X-Google-Smtp-Source: AK7set+L/tBChmlcsaEc/ayoD9GD6K3/ye1nLTSstWEdEKlu3wuUIKA1dGj89rDW0zmHFc6fOw9guic0KPApWgR53Ss=
X-Received: by 2002:a1f:46c6:0:b0:42d:7181:7c63 with SMTP id
 t189-20020a1f46c6000000b0042d71817c63mr4230868vka.1.1678388737330; Thu, 09
 Mar 2023 11:05:37 -0800 (PST)
MIME-Version: 1.0
References: <20230308202159.2419227-1-grundler@chromium.org>
 <20230308202159.2419227-2-grundler@chromium.org> <ZAnBCQsv7tTBIUP1@nanopsycho>
In-Reply-To: <ZAnBCQsv7tTBIUP1@nanopsycho>
From:   Grant Grundler <grundler@chromium.org>
Date:   Thu, 9 Mar 2023 11:05:26 -0800
Message-ID: <CANEJEGuK-=tTBXG6FpC4aBb7KbsNZng2-Rmi0k6BJJ7An=Pyxw@mail.gmail.com>
Subject: Re: [PATCHv3 net 2/2] net: asix: init mdiobus from one function
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     Grant Grundler <grundler@chromium.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Eizan Miyamoto <eizan@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023 at 3:20=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Wed, Mar 08, 2023 at 09:21:59PM CET, grundler@chromium.org wrote:
> >Make asix driver consistent with other drivers (e.g. tg3 and r8169) whic=
h
> >use mdiobus calls: setup and tear down be handled in one function each.
> >
> >Signed-off-by: Grant Grundler <grundler@chromium.org>
>
> This is not fixing a bug. You should send it separatelly to net-next.

Jiro,
Thanks for reviewing both patches. Agreed that it's not fixing a bug.

The patch depends on the previous patch. It wouldn't apply on a
different branch.

I hope the maintainers can apply both to net-next and only apply the
first to net branch.

cheers,
grant
