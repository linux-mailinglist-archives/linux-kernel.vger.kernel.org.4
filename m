Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160D3726588
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241585AbjFGQMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 12:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241568AbjFGQMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:12:05 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350681BE2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 09:12:04 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-77807e43b7cso138164339f.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 09:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686154322; x=1688746322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UaVt71w97+WhGKDKIxvnNRAAH6Y2h7zhhmiqlnDleJI=;
        b=GFYggc9BVycvIGE2fI2CwPL3Setd6k0P3T1HUOxR2LYJlwoJR7gNYBYpk1rH37AdjI
         mpakD6MKzCKSU0nvWCsGFdIari2n2ZQaOJjG4YPN0xjKMNDJestKpZPa6KlVGklw1a4W
         eviDZOMM/iHRBu1lEzAzDHZvZdbHNY1hFA/yY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686154322; x=1688746322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UaVt71w97+WhGKDKIxvnNRAAH6Y2h7zhhmiqlnDleJI=;
        b=VzP2SEx6l+RHGelDaF63kPN3wP7b+uEm5DHXZxyhpGy9ZFT5QXiObfIaZ4KcAalJmB
         GRdRQMIi8g1OYgEc5aTJqgtNgsx5GUg13DrS8+Z8hi94FS4EtBQSPd6aecTRE+SfbpPv
         F2VXckK47n77dJMra7XF8cLN67tANzj62aKXs99cuQkeMLBWuLtSkc3azbvvoOGEeWgE
         R4MxvjB0HGF3QuptgQltJjgRYOWtUOyPCYyeLWrYAO76Ndb1Knc++m32k+4ugWlC1h3g
         H/rkiy0M72/5UqVt2ZGktejJzY4dp5m5eYsbL3GmgtmXrWkDqTsE1yCoNjaVIdXp9DQX
         InUg==
X-Gm-Message-State: AC+VfDytol+QLJ4sxamFBycYVFKmmCklNAreSDgjdh7FqXB+0A4EYafd
        JaSV8VjkH8kQpxh37V8/NpHuMAN9H3i5hIjf07U=
X-Google-Smtp-Source: ACHHUZ7APraAWE/ol+2Su3hzlFG4OSxh29psyga8zsrXYvf3Ihz/yHy492cgUnxA6RH7J4M/oSp80A==
X-Received: by 2002:a5e:cb44:0:b0:774:8d99:184c with SMTP id h4-20020a5ecb44000000b007748d99184cmr9180809iok.11.1686154322459;
        Wed, 07 Jun 2023 09:12:02 -0700 (PDT)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id q9-20020a02cf09000000b0041aaebd2017sm2930705jar.82.2023.06.07.09.12.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 09:12:01 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-33b7f217dd0so155405ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 09:12:01 -0700 (PDT)
X-Received: by 2002:a05:6e02:1bc1:b0:33d:cebd:e34d with SMTP id
 x1-20020a056e021bc100b0033dcebde34dmr270004ilv.12.1686154320941; Wed, 07 Jun
 2023 09:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <1685729609-26871-1-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1685729609-26871-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Jun 2023 09:11:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uy=ELwg2jhtFSrpndw-GxUO=0NTKotNymi3sqwG=ggnQ@mail.gmail.com>
Message-ID: <CAD=FV=Uy=ELwg2jhtFSrpndw-GxUO=0NTKotNymi3sqwG=ggnQ@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: geni-se: Do not bother about enable/disable of
 interrupts in secondary sequencer for non-uart modes
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msavaliy@quicinc.com, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com
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

On Fri, Jun 2, 2023 at 11:13=E2=80=AFAM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> The select_fifo/dma_mode() functions in geni driver enable/disable
> interrupts (secondary included) conditionally for non-uart modes, while
> uart is supposed to manage this internally.
> However, only uart uses secondary IRQs while spi, i2c do not care about
> these at all making their enablement (or disablement) totally unnecessary
> for these protos.
>
> Drop enabling/disabling secondary IRQs for non-uart modes.
> This doesn't solve any observed problem but only gets rid of code pieces
> that are not required.
>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  drivers/soc/qcom/qcom-geni-se.c | 24 ++++--------------------
>  1 file changed, 4 insertions(+), 20 deletions(-)

This seems like a nice cleanup to me. It's still odd that the general
code has a special case for UART, but I guess the alternative is to
duplicate the exact same logic for both the i2c and SPI drivers. I
won't insist on that, though I wouldn't be opposed to it either.

I guess one comment, though: should we also remove the code that
messes with "SE_GENI_S_IRQ_EN" in geni_se_select_gpi_mode()?

-Doug
