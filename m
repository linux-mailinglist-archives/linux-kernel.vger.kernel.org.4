Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4823C6FB2CC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbjEHO2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbjEHO2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:28:52 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8117C18B
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 07:28:50 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3ef34c49cb9so1463901cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 07:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683556129; x=1686148129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OXED9n55OxWngALNZf6Ma29Sbx2jeBepA9KK59dLuM=;
        b=uMdD8Gv/DiHKg3UTx8w50SiEO1INj2f5NWouy18nCDXkt6MuxF/1R2SPc29+sOotRM
         ZtRuJNg896/ywYdCGw21nMR91mhF6xtGip3ENDf1YWIrbHYNjnrexvJkwEFm53mAIbN9
         85H0RbE2SzSfiN1x/4f489xNwLM9p9ODIAo7siG0vZbpknS0JBH8pAPpP1BJJVUbRQz9
         HdmXhby6Jrgv0YidGLYxAlHGf8JAJO1txyun9lRekLz6S4DIl4VwFBZDwb8iFnX/W7ig
         76Hz7V6wXbrIKU8Wd6yRl7JsYLJmEqtafbuCtsjucMnErxVPSNt0qgZYXvAfzJvngvdJ
         VoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683556129; x=1686148129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OXED9n55OxWngALNZf6Ma29Sbx2jeBepA9KK59dLuM=;
        b=dmIJPb2epi7Fxq//hXC60uL/aU9ej+/iA+udmdra0hsRfxPAMA6JafMaMWTHzdI7oJ
         8xTXxbb5dWkjB2KWCeoYLpXs5ciUKG8b11xxmIiCeH8JJjAHtZSOCv4xqIRNOhSjcfnH
         0EDJDDsKNUJeBMDOKFI/L98uwsoYkBeGUnkQ/WbfXQrhx6twNjMBJjDnO9aMYDBwXac4
         wSMpy6gmq9R4Bx3ZBv7v5slTu6neL0dTY4/WkwLY1sDU6wtklksHgIoqHcsIrFyEwpI8
         EZXsyhrrGqStGQ/mbY9KaTOmwuXjZFaLF+vk6h774Dq7Erx8QTf3ezFgRPUgNaWKjC4t
         7DEA==
X-Gm-Message-State: AC+VfDxVmSJ/lQXUfhZ751xpVIuQX9EhRjljWtsrh9DBsQ+bCJW5zioN
        kJiElqqPLkGbOWh9ahgNj2L4ezHcn0yBGKYVb2N39A==
X-Google-Smtp-Source: ACHHUZ7vJmM50NByadABi4nEwTy5WkJIJgvxyyfBL32BsPAITEyEvNHrAPFBUNSoJYtzlqXDLgEfYJoDBy9geLoLL3s=
X-Received: by 2002:a05:622a:1813:b0:3bf:e4e0:26a0 with SMTP id
 t19-20020a05622a181300b003bfe4e026a0mr542577qtc.14.1683556129072; Mon, 08 May
 2023 07:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230506093243.540406-1-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20230506093243.540406-1-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@google.com>
Date:   Mon, 8 May 2023 07:28:37 -0700
Message-ID: <CAD=FV=WG9L-Fsq6wkmjk19bCPqVJgu41_hmQz0g6kLPvDrt_XQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: Modify innolux hj110iz panel inital code
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, hsinyi@google.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, May 6, 2023 at 2:32=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> Optimize flickering problem and power off sequence GOP timing at sleep in=
 mode.
> When display sleep in raise the potential of all GOP signals to VGHO and =
then
> lower to GND.
>
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 397 +++++++++++-------
>  1 file changed, 235 insertions(+), 162 deletions(-)

You sent two different patches with the exact same subject and the
same description but completely different contents. I can't land that.

Options:

1. Send a two-patch series where each patch has a different subject /
description.

2. Since these both touch the same file and (presumably) are trying to
address the same issue, just combine them into one patch and send
that.

Please make sure you document everything the patch is doing. I don't
think anything in the description explains why you need to change the
clock rate / blanking periods.

-Doug
