Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB81748483
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjGEM72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGEM71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:59:27 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C92ADA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 05:59:26 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-78f6a9800c9so2278739241.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 05:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688561965; x=1691153965;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nZHZeidSk3mCWY3MjBsM3AN+Ta4vT4cFL5EZs5XXzbA=;
        b=zEPk98CbLgRIo6KWsJzebatVSmlnm02J0D9GYEKh/nD075S0msWT0ErETzOONu23Oj
         pMqLLOqRCpJIkOmIH+lARvTV/SnEdujhvpzcLUql9GiAII+k5SCyjRH2q8oGGuQn2x2A
         XCqXgY3LNJVWRPijQwn/NN7kQ0QDVTN0lviR4dXM6UtD7O4xuzOoXYViGTvziVAUjiHb
         87JjN+y+Q71olXZRKL5JsbyCHsABicarfn5V+jJ/V3blpWOSkigFLS760Im+6gjtDIcj
         +dFHL79JRyJdD2UcXtxcj33GUXLdIJEEQ1569Lc8veptXyRrZ5vFfZLHoPoi09wA2OsW
         g0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688561965; x=1691153965;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZHZeidSk3mCWY3MjBsM3AN+Ta4vT4cFL5EZs5XXzbA=;
        b=f7I4TyHWyfrWnThRhQonA1tzH6mjF+t8nhYcBEAByz/OYb8ojvtwV9/j3VmR5NEIiw
         2ZVqiUmRY6PsrrV+aDn/44QiC6J0d+MGeK1fL026qKbPA1kgOtM6yu3KFsgx5AnLfyDK
         IVQaCFd0x29X+7AuSzEAsXNYR4J2/MbgN+CyEpCBQx57OfdPZvYfD4zJHdcrKTUaSdZC
         1scJKrLagzeblENvckRvM6qTJgWJqKNs1pB2VIa8TqXWOZyrirzlTsUCylhoy3GOMosr
         Pnhja7INNIlViJxUUvdDqJHDILaXwMT53EQqYnVr9jp7+/yWWHH885YQAh0BMjJOeRYJ
         S6MQ==
X-Gm-Message-State: ABy/qLYbACg+vPnTUDUFP1dtZlGSXTFmft1iNm5DTQHk/5kuJRiaK3Ks
        UE3sSBqO1xByrCLVrlcBmupojTqz+l4uFvtwVWVmIg==
X-Google-Smtp-Source: APBJJlF2cytqWVzR5MRGWFqYl0PN+/hU8lNQBqczzpcm9IC1mTIREpURJudjlLv3fff1c8uiVHFuMc4y6+sQnYI97Q0=
X-Received: by 2002:a67:f041:0:b0:443:6c53:e26b with SMTP id
 q1-20020a67f041000000b004436c53e26bmr6325396vsm.10.1688561965702; Wed, 05 Jul
 2023 05:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230705124850.40069-1-srinivas.kandagatla@linaro.org>
In-Reply-To: <20230705124850.40069-1-srinivas.kandagatla@linaro.org>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Wed, 5 Jul 2023 18:28:49 +0530
Message-ID: <CAMi1Hd28mRKJqpCSNxvixA+H=5cyVWHyTQ8w2He5qBE_nbpu+g@mail.gmail.com>
Subject: Re: [PATCH] ASoC: qcom: q6afe-dai: fix Display Port Playback stream name
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2023 at 18:18, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> With recent changes to add more display ports did not change the Stream
> name in q6afe-dai. This results in below error
> "ASoC: Failed to add route DISPLAY_PORT_RX -> Display Port Playback(*)"
> and sound card fails to probe.
>
> Fix this by adding correct stream name.

Tested-by: Amit Pundir <amit.pundir@linaro.org> # tested on Dragonboard 845c

>
> Fixes: 90848a2557fe ("ASoC: qcom: q6dsp: add support to more display ports")
> Reported-by: Amit Pundir <amit.pundir@linaro.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/qdsp6/q6afe-dai.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
> index 31e0bad71e95..dbff55a97162 100644
> --- a/sound/soc/qcom/qdsp6/q6afe-dai.c
> +++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
> @@ -476,7 +476,7 @@ static int q6afe_mi2s_set_sysclk(struct snd_soc_dai *dai,
>
>  static const struct snd_soc_dapm_route q6afe_dapm_routes[] = {
>         {"HDMI Playback", NULL, "HDMI_RX"},
> -       {"Display Port Playback", NULL, "DISPLAY_PORT_RX"},
> +       {"DISPLAY_PORT_RX_0 Playback", NULL, "DISPLAY_PORT_RX"},
>         {"Slimbus Playback", NULL, "SLIMBUS_0_RX"},
>         {"Slimbus1 Playback", NULL, "SLIMBUS_1_RX"},
>         {"Slimbus2 Playback", NULL, "SLIMBUS_2_RX"},
> --
> 2.25.1
>
