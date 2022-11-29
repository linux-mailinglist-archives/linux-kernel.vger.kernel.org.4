Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB7A63B67C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 01:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbiK2AUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 19:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234781AbiK2AUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 19:20:14 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831DA3123A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 16:20:12 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id gu23so11790701ejb.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 16:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=afOr2fmIQC6dBJfLAFZ1lEeNOcz8tKXWZ8GJTXwEGZg=;
        b=YyohEtJ6qLap4dyHJjxB9q2A69k7/SoCS0qeZMEZLc1ZFBUVRVGlQ33xoNkciPPQ56
         x5DP20xjts37dK6LNApMJpL4S8D49y38crgVO+gt38n7cXyWChhanVz4BFjZkpVFGVP6
         OiwfsSQKDsFq3Bxwfk0h8k9bAO9hOq4Ues8Rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=afOr2fmIQC6dBJfLAFZ1lEeNOcz8tKXWZ8GJTXwEGZg=;
        b=YDjvvs7G/Y25gADRgwspSaBK+/wWF0475euSQUb0C8yRT+e5H0o0aZ1HGKVYSpR45y
         hQcuen5nMFZQcJ45NgZv0GXdGiHj90B8/8Lz3g4woa9zkugJFVNVrGCMKuiE4fGSUL67
         BLDZyDFYDD4o/FJaw2BsyPm4/+M7p8WQaHNUPhmIcFwk6U9T+MCX9qKnZ0i58qEL6VIN
         KCqB9t04wrRvkvoBMDWZfle29VEYc/3fejtvWuIPkVxu5ajrMH2tt6rmtD/iba4M3ZMK
         YgnrzOIlm5/h5ZwNKrghVfRGYuWmgjsGGTvkKB8voA1t4PwWB3XyBJED2m9qBCUspexq
         675w==
X-Gm-Message-State: ANoB5plhdqCKSMlOUogMkfP+cihW5bdcm2sUwfkuSfDGgfKChPs/+ExC
        yIAA5FHtGHsGFiosPy72ReHbUrw1CelHkosq
X-Google-Smtp-Source: AA0mqf735FayllB8qyuUMTJouOQ+J9rV1B4zPLhhxRWWmAaN+Zgv1p+0KiE3FPxMbTC8z77oE9TblA==
X-Received: by 2002:a17:906:d20a:b0:7a9:8d8e:c3df with SMTP id w10-20020a170906d20a00b007a98d8ec3dfmr30102887ejz.519.1669681210113;
        Mon, 28 Nov 2022 16:20:10 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id la18-20020a170907781200b007b2b98e1f2dsm5450686ejc.122.2022.11.28.16.20.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 16:20:08 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso13074512wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 16:20:07 -0800 (PST)
X-Received: by 2002:a05:600c:3109:b0:3cf:5731:53db with SMTP id
 g9-20020a05600c310900b003cf573153dbmr43823918wmo.85.1669681207310; Mon, 28
 Nov 2022 16:20:07 -0800 (PST)
MIME-Version: 1.0
References: <20221129001633.v2.1.I8d1993f41f0da1eac0ecba321678ac489f9c0b9b@changeid>
In-Reply-To: <20221129001633.v2.1.I8d1993f41f0da1eac0ecba321678ac489f9c0b9b@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 28 Nov 2022 16:19:55 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W3yB8ZGQ6QmBy7wxRSE4TdqOuM5LzM6wtiF9wtenNyXw@mail.gmail.com>
Message-ID: <CAD=FV=W3yB8ZGQ6QmBy7wxRSE4TdqOuM5LzM6wtiF9wtenNyXw@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: qcom: lpass-sc7180: Delete redundant error log
 from _resume()
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Judy Hsiao <judyhsiao@google.com>,
        Banajit Goswami <bgoswami@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 28, 2022 at 4:16 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> sc7180_lpass_dev_resume() logs an error if clk_bulk_prepare_enable()
> fails. The clock framework already generates error logs if anything
> goes wrong, so the logging in _resume() is redundant, drop it.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
> Changes in v2:
> - removed the log in the error path (requested by Doug)
> - updated subject (was "ASoC: qcom: lpass-sc7180: Return 0 instead
>   of 'ret' at the end of _resume()") and commit message
>
>  sound/soc/qcom/lpass-sc7180.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
