Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E2460D4CD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 21:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJYTjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 15:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbiJYTje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 15:39:34 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E19228
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 12:39:31 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id a13so38034653edj.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 12:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KO4jYktTVlE4tPrXjK/e9XeWuNWY6QxpH8jzqQKB8q4=;
        b=Tg/pZVEKhlBVoyA2jinR/rTmorWbG6k16SdM2i53Q9zn6kQnqPdi6bOfnyP3OFYfzy
         2/4Hm9OiwRN8k15sj6sljo0XoZy6QIv5B901LDWdVFrBLOJ244WD9Plh337cI7iglRw5
         abxm0O73GgHNkMntQriim9vqLl5kNYeQ6WfoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KO4jYktTVlE4tPrXjK/e9XeWuNWY6QxpH8jzqQKB8q4=;
        b=57edL92jN7zp/MytQ1EW6n0S0Axnj0VKg3UUqakgeYcLSKfGC1ioph+SGE5WX6opCR
         n3zVPgKfPdyC4KOfBjyjA5jiL8M36KrrheQgnx+XpZApfM+QLs4hXQHkVb6brtUH0LGd
         gk0a8OKXFTPydvP+DfS7RkLzvwtFlranK7Xka9FdcRDlunG1PYx5bpRTh/4PD6gxSIDY
         iSw24P4A9qgl7zaqbEU4J1bss8TkkwTDuJet6x095bKi0hiIg6TNPFW2DwberzL6FJSN
         mq3L3Iaq793r1qM7FZfQaIdv87pFyhzMF0VCjYxf+BGZ3Z6Cm/fs0CFFwIMLOclx8vve
         OWKA==
X-Gm-Message-State: ACrzQf1HraxIRffBLn5lH4PjVtHZF13Uf10BBqhDVD6XJYGhYnCJPGAy
        0wHJi4KoAXIZFHJwASAM8UosG2OthX2uEXvD
X-Google-Smtp-Source: AMsMyM7Q5sGA2OUTS422r0+wcL90CF8bJuM8d2pZAjWKIYoINabU8KMfEOq6B3ETeJrghfjLioB0kw==
X-Received: by 2002:a05:6402:40cc:b0:462:555e:5f73 with SMTP id z12-20020a05640240cc00b00462555e5f73mr441172edb.259.1666726770151;
        Tue, 25 Oct 2022 12:39:30 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id n9-20020a1709061d0900b0078c213ad441sm1844657ejh.101.2022.10.25.12.39.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 12:39:29 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so12416542wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 12:39:29 -0700 (PDT)
X-Received: by 2002:a05:600c:5493:b0:3c9:c18:87d5 with SMTP id
 iv19-20020a05600c549300b003c90c1887d5mr12934748wmb.188.1666726768937; Tue, 25
 Oct 2022 12:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221025180703.1806234-1-swboyd@chromium.org>
In-Reply-To: <20221025180703.1806234-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 Oct 2022 12:39:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VArrvWtxbrT_t=kUqX54MM1_TvTv7pA2PuAhT2QHmF0g@mail.gmail.com>
Message-ID: <CAD=FV=VArrvWtxbrT_t=kUqX54MM1_TvTv7pA2PuAhT2QHmF0g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: Remove fingerprint node from herobrine-r1
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 25, 2022 at 11:07 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> It turns out that only a few people have the fingerprint sensor hooked
> up on their board. Leaving this enabled is slowing down boot for
> everyone else because the driver slowly fails to probe while trying to
> communicate with a sensor that isn't there. Remove the node to speed up
> boot, developers with the board can manually enable it themselves.
>
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
