Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D0F660B7C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 02:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbjAGB1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 20:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjAGB1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 20:27:48 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004B96E40C
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 17:27:47 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id h21so3548742qta.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 17:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YZmW57ZvRkRR4S/DXyoGDrnsp4/+X8umxttq9HRE8mw=;
        b=ZT39AOGH4oWdTOUwUMNz1C/sCmOKV8oI3/I+ZIQIT65hOVRjnbTbx/NqCGL+AD/Mmy
         sQkvFtaeUPVtoEvyIZClUSmQaI+xyqEBUWRiMC+ooXyWWVt6mZDnEw2yBYnZYKjn0OY3
         FxETHbWF0lc/oVngvKSRSXim4a5bVSRjedJ+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YZmW57ZvRkRR4S/DXyoGDrnsp4/+X8umxttq9HRE8mw=;
        b=Yt8sEAC4xwvrYagHeu/RrYT+krCZvMLuJ0UtiOKcCG0kENthieFTdNjYOJWWzJZpWK
         BpVl6UIbV+gWOTz7IVZs2oJZuusq/3xuFqpL8U/w5Mz3/6mrpL/Uco/8ROcTszBUoJQy
         zjG0j9Lk55SR0ePvUQewRt3urn1oJZYg/ITgUS10NK5OTDX4uzKFh++uVXBkfLEt8G+c
         iOfX7qD7egZ+B30Fv2/+eavMbdV+0xLWiVb7yVJuhyxJQ0NL80QaCB4+bdIMjqPRCsP5
         mnn/LnvSQJvhVTyW1sA11TaG0XZAPHYtoU7dxVjqR0W71tug//sMQfUfzdLBBkZ3bKeR
         cIOA==
X-Gm-Message-State: AFqh2kqkxN8qUXCDUTwGf3N1hz9LCEGlPbveWdtJP7rbFuZc1Wq7SXep
        KLAVyXVZi7JXS6TjQ875sL6+rA78B9ly1xY0
X-Google-Smtp-Source: AMrXdXuD42zcVFVJiIK82ntDGyxaPT3btmccSeH8Bm+YAA3dVIQdGovr8gKqiBCI8NC4w9FzfnIcDw==
X-Received: by 2002:a05:622a:997:b0:3a6:a750:7295 with SMTP id bw23-20020a05622a099700b003a6a7507295mr88319145qtb.4.1673054867034;
        Fri, 06 Jan 2023 17:27:47 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id v1-20020a05620a0f0100b006faf76e7c9asm1440545qkl.115.2023.01.06.17.27.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 17:27:45 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-4c24993965eso37897847b3.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 17:27:45 -0800 (PST)
X-Received: by 2002:a0d:d912:0:b0:36a:d4df:c6b6 with SMTP id
 b18-20020a0dd912000000b0036ad4dfc6b6mr752702ywe.18.1673054864827; Fri, 06 Jan
 2023 17:27:44 -0800 (PST)
MIME-Version: 1.0
References: <20230106172310.v2.1.I3904f697863649eb1be540ecca147a66e42bfad7@changeid>
In-Reply-To: <20230106172310.v2.1.I3904f697863649eb1be540ecca147a66e42bfad7@changeid>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 6 Jan 2023 17:27:33 -0800
X-Gmail-Original-Message-ID: <CA+ASDXNBDkzz_xRDbE9gNZZN5kSfxksh0EN01_CxNgyog_BZOg@mail.gmail.com>
Message-ID: <CA+ASDXNBDkzz_xRDbE9gNZZN5kSfxksh0EN01_CxNgyog_BZOg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/atomic: Allow vblank-enabled + self-refresh "disable"
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>
Cc:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Sandy Huang <hjc@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 6, 2023 at 5:23 PM Brian Norris <briannorris@chromium.org> wrote:
> v2:
>  * add 'ret != 0' warning case for self-refresh
>  * describe failing test case and relation to drm/rockchip patch better

Ugh, there's always something you remember right after you hit send: I
forgot to better summarize some of the other discussion from v1, and
alternatives we didn't entertain. I'll write that up now (not sure
whether in patch 1 or 2) and plan on sending a v3 for next week, in
case there are any other comments I should address at the same time.

Sorry for the noise,
Brian
