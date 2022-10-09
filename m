Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF6C5F88C1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 04:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiJICBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 22:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiJICBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 22:01:46 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4D933E2B
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 19:01:42 -0700 (PDT)
Date:   Sun, 09 Oct 2022 02:01:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1665280901; x=1665540101;
        bh=bOWJkhZwbLAJZMmQNK1Ow6lvYBOieY03TLORKHEfn/g=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=FhTwH0n7qn2+H2uKLzIQPteezEzwymqG+rxxbJ4phr0L3Hoy3451eo7+5tWdPmtic
         Y4fgo2XG+BNuwQ9dhmtqkmDVN13/xwdLmJBGh+X1LwBkRE/bAl+ey1ZDplIoJYnoQQ
         7h9WlHaWIHryVugSsw5lBBLfjwTTjYOEyg7jE22k=
To:     Dylan Van Assche <me@dylanvanassche.be>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2] sound: soc: codecs: wcd-mbhc-v2: expose ALSA control for jack
Message-ID: <b06ef62e-7409-b347-fc6e-9e42bcd44419@connolly.tech>
In-Reply-To: <20221007155716.10594-1-me@dylanvanassche.be>
References: <20221007155716.10594-1-me@dylanvanassche.be>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on a OnePlus 6 running postmarketOS!

On 07/10/2022 16:57, Dylan Van Assche wrote:
> Jack detection is currently fully functional via the input
> interface together with multimedia buttons, but is not exposed
> as an ALSA control. Therefore, ALSA clients such as PulseAudio
> do not pick up the jack detection events as they only support
> one of the possible interface (ALSA control or input interface,
> but not both). Expose the jack events as an ALSA control and input
> interface to provide ALSA clients both interfaces.
>
> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>

Tested-by: Caleb Connolly <caleb@connolly.tech>

> ---
>   sound/soc/codecs/wcd-mbhc-v2.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/sound/soc/codecs/wcd-mbhc-v2.c b/sound/soc/codecs/wcd-mbhc-v=
2.c
> index 1911750f7445..1b75f49b2858 100644
> --- a/sound/soc/codecs/wcd-mbhc-v2.c
> +++ b/sound/soc/codecs/wcd-mbhc-v2.c
> @@ -725,6 +725,10 @@ static int wcd_mbhc_initialise(struct wcd_mbhc *mbhc=
)
>
>   =09mutex_lock(&mbhc->lock);
>
> +=09ret =3D snd_jack_add_new_kctl(mbhc->jack->jack, "Headset Jack", WCD_M=
BHC_JACK_MASK);
> +=09if (ret)
> +=09=09dev_warn(component->dev, "failed creating Headset Jack kctl with e=
rr: %d\n", ret);
> +
>   =09/* enable HS detection */
>   =09if (mbhc->mbhc_cb->hph_pull_up_control_v2)
>   =09=09mbhc->mbhc_cb->hph_pull_up_control_v2(component,
> --
> 2.37.3
>

--
Kind Regards,
Caleb

