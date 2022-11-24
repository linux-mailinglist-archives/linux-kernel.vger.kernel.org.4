Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408D26375B3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiKXJ5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiKXJ5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:57:47 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F7014001
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:57:46 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id e76so1274244yba.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r/inbI+y1fhrxyLW9sS+q/7x6KkspXDB7h9KT6wBhFI=;
        b=FsQyigU5X9Bj9xZiNwYg2vk1ek0GVhZG+zbSZ3vYiapFPlAQUN1xt3rSqtvzfV2J0o
         xn34AJ262EZYn2nnGIyRHGnlUbJL/Ecj+cE9/nguY3T/aDuwKpTUmTkCIShYtgNJoqJ6
         S+oSflzGcP2f6TMQwdf/Uqc3W+iufoDZ5qIrmRnn+wEJIxLZcDcvcGWYSRe8V3BNRzgl
         X5pfGd6YRxRlZWJBqxbiE5b9oBOh4m/QQneZJjN5a90umabI+6XNKCBALBGTsy86LiFl
         yhS7VqlNE1bn/uB9f0sMRct+oHhUAme3rh1NsgpPJVtF+ukY/BxuBNM+1XHkuRQJo8J9
         n07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/inbI+y1fhrxyLW9sS+q/7x6KkspXDB7h9KT6wBhFI=;
        b=CKiZIrMQ3MPJdAary6wA9DQ9ZvAT+Qt2HPK/K8zgErY3vhaEG1p4fNlrBK+FPspBgD
         oPtJDw2OeyCUUYp1v8bXdkvqvHFQn1d8Blv7vAZQkGIjlQ8W1GNjp2tBAzs32C7GeXIM
         2QoZWliXFfMigEtbdLPI1ka7NV1odYNipLQs8DbPM+6cQuM6ceCUecPiDlCexI5Mdab6
         IIjaNRu5a0XF6JwqkS+VNXD/ahBWQDtyFX/E5xXZ9AsVrWyHakVBSUxR3ALE4dqtuWWD
         HtgC3DwnLAWu5UFYXZLtjQwX35MWLnp5DLVb3t1o52kmJ192tmK2my+3iTjK9/kA2Ay6
         I8JQ==
X-Gm-Message-State: ANoB5pkp7RIWOi9XjUP83PcWdanqQUAbv9NFZ7NoHPNpqJDUjRAX2vk4
        Ekq6TyK3gQmA8celhKqXOgb85IaY68SebcD/uUzCB4e6iKygig==
X-Google-Smtp-Source: AA0mqf4qkrdY9iSNek494zZjiqDs6tUrY9sSvGelHCP42eGUIvgdfUL9wM1QFB3i6woY0JwsbG4QB5ulMunhWiUYhGg=
X-Received: by 2002:a25:f302:0:b0:6dd:4825:ba8f with SMTP id
 c2-20020a25f302000000b006dd4825ba8fmr30016399ybs.103.1669283865119; Thu, 24
 Nov 2022 01:57:45 -0800 (PST)
MIME-Version: 1.0
From:   Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>
Date:   Thu, 24 Nov 2022 10:57:34 +0100
Message-ID: <CABDcavYdsk-O4x3oPX4i4+T5wsoZV26_kpEq6JvpD8A_cAGHxg@mail.gmail.com>
Subject: SOC_DOUBLE_R_SX_TLV controls broken in cs24l51 driver
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?Q?Tan_Nay=C4=B1r?= <tannayir@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        James Schulman <james.schulman@cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am using a dev board with a Cirrus Logic cs24l51 codec.

This used to work fine prior to kernel version 5.x, however after 5.x
it is not possible to set certain values for ALSA controls from
userspace.

I believe this is related to the input validation that is mentioned in
this thread: https://lore.kernel.org/all/Yph8C3bRxcr6ogW7@sirena.org.uk/T/,
and possibly in this commit: 4f1e50d6a9cf9c1b8c859d449b5031cacfa8404e
("ASoC: ops: Reject out of bounds values in snd_soc_put_volsw_sx()")

For the cs24l51, all the controls that fail are using the
SOC_DOUBLE_R_SX_TLV macro.

I have traced this to the checks in snd_soc_put_volsw_sx, specifically
the (val > max - min) check:

pr_warn("Max: %d, Min: %d, Value: %d", max, min, val);
pr_warn("platform_max: %d", mc->platform_max);
if (mc->platform_max && val > mc->platform_max)
{
    return -EINVAL;
}
if (val > max - min){
    pr_warn("(val > max - min) check failed");
    return -EINVAL;
}
if (val < 0)
    return -EINVAL;

According to the datasheet of the CS24L51, section 6.13, page 61, the
PCMMIXX_VOL registers accept the following range of values:

Binary Code / Volume Setting
001 1000 / +12.0 dB
=C2=B7=C2=B7=C2=B7 =C2=B7=C2=B7=C2=B7
000 0000 / 0 dB
111 1111 / -0.5 dB
111 1110 / -1.0 dB
=C2=B7=C2=B7=C2=B7 =C2=B7=C2=B7=C2=B7
001 1001 / -51.5 dB

Minimum value is 0x19 (001 1001) corresponding to -51.5 dB, then there
are 127 possible gain settings from -51.5 dB to +12.0 dB, in 0.5 dB
steps.

This is declared in the driver as follows:

SOC_DOUBLE_R_SX_TLV("PCM Playback Volume",
CS42L51_PCMA_VOL, CS42L51_PCMB_VOL,
0, 0x19, 0x7F, adc_pcm_tlv),

0x19 =3D min value
0x7F =3D number of gain settings

This seems to be correct according to the semantics of the
SOC_DOUBLE_R_SX_TLV macro as described in commit
34198710f55b5f359f43e67d9a08fe5aadfbca1b ("ASoC: Add info callback for
SX_TLV controls").

However, the (val > max - min) check in snd_soc_put_volsw_sx fails in
the above example because val =3D 127, max - min =3D 127 - 25 =3D 102.

So I am not sure how this should be fixed. Is the SX_TLV macro being
used incorrectly here? Is the check in snd_soc_put_volsw_sx wrong?

Any pointers are welcome.

Thanks,

(If possible, please CC me in any replies)

Guillermo Rodriguez Garcia
guille.rodriguez@gmail.com
