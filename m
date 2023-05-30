Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548D9716909
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjE3QR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjE3QR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:17:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045B7E5;
        Tue, 30 May 2023 09:17:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F22061B4A;
        Tue, 30 May 2023 16:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC285C433EF;
        Tue, 30 May 2023 16:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685463472;
        bh=NZCtGj23YyfoZNBDlOVpHJDJs2sd7pwkNJtRrSH9AbI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oXzx2PJXEDK6dQEql2b1WXznOy7mRtKk/XWd5/r5U5MixPapuJmg7JBVJkTiSuGbY
         VEKtPHdhP0Txmpb0Hitxmpos3r4hDO4/Rhr5htPtqBLXYxCnjLoP+1DAyUIknEb9Ee
         gJgHHBiCfW4pHvgEs7hDWKc+KjYtPZ4iQJb9sIH2mgfn4j6GX8UonmZDCSCQZ73KJb
         E98ANqd73K3/uNFT0DL2CaIzCwoyEyT0qZNcGqJRBvt58he08xcS+mLS1X9+2TpKj9
         QJVFtOel9Yu7nHKti7cyNco8+k/qYq1YiLO3pC/y4EmY7jjEDJn2/yrmqKu1Ror9Qa
         4MG/zojw7gZCw==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2af290cf9b7so48123071fa.3;
        Tue, 30 May 2023 09:17:51 -0700 (PDT)
X-Gm-Message-State: AC+VfDzX59bBHpU0gw7eMGLQ48kKkS2JfKbFn26oLzOInlaRWwQmyere
        3O5KyQAaHlBsZjGUk9EA1iqybf0IF5Ls1BM2/5c=
X-Google-Smtp-Source: ACHHUZ7u68ggq5zpXltoROmbLYGFi+eo1YBnyWeF5XMz3GcUl+ZOEYC1f5wxP63D1fBZ87TpRaleROLpjTKhCdTcB9w=
X-Received: by 2002:a2e:8018:0:b0:2ad:99b6:1728 with SMTP id
 j24-20020a2e8018000000b002ad99b61728mr1118768ljg.24.1685463469979; Tue, 30
 May 2023 09:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230528230351.168210-1-luzmaximilian@gmail.com>
 <20230528230351.168210-2-luzmaximilian@gmail.com> <202305300820.9B2154B@keescook>
 <3255010d-82d5-e8e8-2e11-7de25d538d72@gmail.com>
In-Reply-To: <3255010d-82d5-e8e8-2e11-7de25d538d72@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 30 May 2023 18:17:35 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGy1hfEyHBNmPkBFeGF9W5zx=+8z5deH3E7usdsHHB2=A@mail.gmail.com>
Message-ID: <CAMj1kXGy1hfEyHBNmPkBFeGF9W5zx=+8z5deH3E7usdsHHB2=A@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] lib/ucs2_string: Add UCS-2 strlcpy function
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Johan Hovold <johan@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2023 at 18:15, Maximilian Luz <luzmaximilian@gmail.com> wrote:
>
> On 5/30/23 17:25, Kees Cook wrote:
> > On Mon, May 29, 2023 at 01:03:48AM +0200, Maximilian Luz wrote:
> >> Add a ucs2_strlcpy() function for UCS-2 strings. The behavior is
> >> equivalent to the standard strlcpy() function, just for 16-bit character
> >> UCS-2 strings.
> >
> > Eek, no. strlcpy() is dangerous in multiple ways[1]. Please implement
> > strscpy() (i.e. use strnlen(), negative error on truncation, etc).
>
> Right, make sense, thanks. Somehow I missed that the kernel has a better
> function than the C stdlib for that...
>
> > Additionally, it'd be nice of the ucs2 helpers here also implemented the
> > rest of the CONFIG_FORTIFY_SOURCE mitigations (i.e. checking for source
> > and destination buffer size overflows at compile-time and run-time with
> > __builtin_object_size() and __builtin_dynamoc_object_size() respectively).
>
> I can certainly try that, but I think this might be better suited for a
> follow-up series, given that we then should also add those to the other
> helpers.
>

Agreed. Let's log the followup work as a kspp work item, no need to
make that part of this series.

Thanks,
