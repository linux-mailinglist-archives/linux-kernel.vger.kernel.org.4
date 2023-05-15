Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26707030F6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242094AbjEOPGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241849AbjEOPGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:06:32 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF751720
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 08:06:08 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7577a91cfd6so478712485a.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 08:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684163166; x=1686755166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Og220UowjXbjVmuC4TtBNxJbr3SzQPFOA/NQzEh0cHw=;
        b=PsQxGdFlzGbjKFy2PPDSEXHzCKtbZY3OM7I27XEzQGcEvqkOCN32mJVhGggHsG4DUU
         4Hk+XjWneKNJjQDhQD3Noi06fQmp6U6n4x0Wr8lULeWjGrvl3Bcl76EED2uoRF9pwMF+
         CQ2IuQbEJg5nThWiJrw1ytbpUMfPFfEYpwvas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684163166; x=1686755166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Og220UowjXbjVmuC4TtBNxJbr3SzQPFOA/NQzEh0cHw=;
        b=fcN2IGR8wBYXj0AH5vBfzesxAQsnqBrHYNDFXZUSakKBcHOFWdfFZ3QYh1sBgcBuLt
         a4bpU1B5zFMa1Ni/3NkPiMhkHsOZqMZOsUmaidKkrFqZIYLcM7C6F/e5f+yLWqJpM4OA
         wiOjPSxjtxi4pt1ei6POnbR4l6TVP192rqMQ1NIg3Rvo0awNopmNspe3amIZRHQWa1mW
         lCF+XvUVwBSisSZADrWNl4KKAlddDQpM/IQvrCXmYVKKWpoQvthK3FpRLokWX3BcC5v0
         afWfUEzBtuOVcz4scsREy+Kv1Sm59eL6cHG22yqVx+5pR0hOsFsCFBVDWG+oz28oKyHX
         gLgg==
X-Gm-Message-State: AC+VfDzYYhXzrxDJ6GyyYLvnYawNPT+Zc2aHhSfJai5CODqZSQgp3RHf
        mzBkZLu1ftgdT/ekK7mkEicli5Q1KOrmaf3NqkQ=
X-Google-Smtp-Source: ACHHUZ5W0rB7J5tTDWYm8TjnMxL8n6JIzkz1dU99LysfpUzkdqJpLH2kmZc3n7oIW0qCWrZxHudzpQ==
X-Received: by 2002:a05:6214:4107:b0:5ea:2575:dccb with SMTP id kc7-20020a056214410700b005ea2575dccbmr59481425qvb.46.1684163166270;
        Mon, 15 May 2023 08:06:06 -0700 (PDT)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com. [209.85.160.169])
        by smtp.gmail.com with ESMTPSA id t11-20020a0cf98b000000b005ea9156e72bsm5015480qvn.33.2023.05.15.08.06.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 08:06:05 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-3f51ea3a062so233471cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 08:06:05 -0700 (PDT)
X-Received: by 2002:ac8:5dd1:0:b0:3ef:3083:a437 with SMTP id
 e17-20020ac85dd1000000b003ef3083a437mr1183921qtx.18.1684163164854; Mon, 15
 May 2023 08:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230515145323.1693044-1-amit.pundir@linaro.org>
In-Reply-To: <20230515145323.1693044-1-amit.pundir@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 15 May 2023 08:05:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WXB9tJWTcQJ5zuJ0zNhBD0FYvQf1y+zDFFmY9CBd7CCw@mail.gmail.com>
Message-ID: <CAD=FV=WXB9tJWTcQJ5zuJ0zNhBD0FYvQf1y+zDFFmY9CBd7CCw@mail.gmail.com>
Subject: Re: [PATCH] Revert "regulator: qcom-rpmh: Revert "regulator:
 qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS""
To:     Amit Pundir <amit.pundir@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 15, 2023 at 7:53=E2=80=AFAM Amit Pundir <amit.pundir@linaro.org=
> wrote:
>
> This reverts commit ad44ac082fdff7ee57fe125432f7d9d7cb610a23.
>
> This patch restores the synchronous probing for
> qcom-rpmh-regulator because asynchronous probing broke
> Dragonboard 845c (SDM845) running AOSP. UFSHC fail to
> initialize properly and DB845c fails to boot regardless
> of "rootwait" bootarg being present or not
> https://bugs.linaro.org/show_bug.cgi?id=3D5975.
>
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> ---
>  drivers/regulator/qcom-rpmh-regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

As mentioned in the other thread [1], I'd rather at least do a little
debugging before jumping to a revert, just so we don't end up having
to do a revert of a revert for the same driver again.

[1] https://lore.kernel.org/r/CAD=3DFV=3DVSFDe445WEVTHXxU1WS_HGUV5jR5E8_Vgd=
4eyhn3rHyA@mail.gmail.com
