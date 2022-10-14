Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F975FEE61
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 15:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiJNNKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 09:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJNNKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 09:10:08 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B46C33871
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 06:10:03 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y8so4834144pfp.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 06:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fk/quJ74rHsZ1Ova6EOCJyFmRO49mfECzgwRXnhSG1A=;
        b=ZRkmvozIwo645mpwwMu4mp3tF84LY+GPL8yWcxrGv1qS0rondxJtdP0IeMnZ5EP7aw
         YaK57ihpkHyopJb6ZAVbiOnw1G/8bTf+Z9UHBeERJm6BdVucXItAtfHX1xUP6AAYZZjE
         7mKpkV28NKxmkrcZengef5RDU4Bq8LHuNW62xm8wZFxqcTf0kS2BMGZAlGX2j3zA5IFH
         zNeoeRCI4A58mbNmpqBXNo/ullgoOZb5l07HqUmBMC9iSOR5GjjUkEzb+0L1oRzk81Sk
         QbL63GA//2mKJH8hOG26P853DiPJuNZZ49Mq0LKIOh3ORYPgg0aEZJs+Lss7BjMfB2HC
         6Z5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fk/quJ74rHsZ1Ova6EOCJyFmRO49mfECzgwRXnhSG1A=;
        b=E5xnP3RgZDntSrKizdRaD/hdz+XwJ+lWRSh4qPPfkawsCddCHlRXvsKoZpELQdA5sJ
         PKctXXYN46xN8oY8hAMA04e03+5k0J1b92nOFm16XX8DSnveRqXz4+4VUScifFYsz1mQ
         xLm87roBqeYixrON4F6x7hyLdSD1rRL9oEtK2FfJ2EnlI93kxJZxyKS2M6HMNoogtFSp
         ZUR/+moqrQ6WbjaV5R2NwSV79f13Kk72WcqaAXWl9NG85hYSKyv1yzUyWiErDkt+UXFG
         hh1/rlPCFG5E81zIVwDjceyhSKmkcSnbcAxfgyce0R8Vs5Lc/qZpMjiOq/q8Shh5vHfp
         nB2w==
X-Gm-Message-State: ACrzQf2zAAqyKB/PiIpP2koaigH1Wq6lAaHP4LaJvXz+iMA7kn1td79P
        BohKq/Q+D5HCQB8MqXytGc4=
X-Google-Smtp-Source: AMsMyM6xAq9RgZN2LCCOb22a75WNSCP88vtz1QUopMhxkikXWXWenwgCLge9OZVmkw9h9v5Uvw7ftg==
X-Received: by 2002:a05:6a02:202:b0:42b:d711:f27c with SMTP id bh2-20020a056a02020200b0042bd711f27cmr4523490pgb.246.1665753002879;
        Fri, 14 Oct 2022 06:10:02 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-8.three.co.id. [180.214.232.8])
        by smtp.gmail.com with ESMTPSA id f7-20020a631007000000b0045935b12e97sm1436760pgl.36.2022.10.14.06.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 06:10:02 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id C1360103F3B; Fri, 14 Oct 2022 20:09:59 +0700 (WIB)
Date:   Fri, 14 Oct 2022 20:09:59 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] clocksource/drivers/timer-ti-dm: Fix some
 kernel-doc comments
Message-ID: <Y0lfpxXZZZuiI4A8@debian.me>
References: <20221014091357.64504-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qqNtyi/bdFWrjAqo"
Content-Disposition: inline
In-Reply-To: <20221014091357.64504-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qqNtyi/bdFWrjAqo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 14, 2022 at 05:13:57PM +0800, Yang Li wrote:
> Fix some kernel-doc comments.
>=20
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D2399

What fix are you doing below? Please describe (should contain warning
messages from bugzilla link above).

---- ranting ----
When I see social media posts, I often see "Link in bio" phrase. That
is, instead of posting the full link, the link is placed on URL section
of a poster's bio and a pointer to it is phrased in relevant posts. What
if such "link in bio" link changes? The older posts which points to
different link than in the bio become irrelevant.

I would rather just spell the full link in my posts instead for
posterity.
---- end ranting ----

> diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/time=
r-ti-dm.c
> index cad29ded3a48..574c88584fbf 100644
> --- a/drivers/clocksource/timer-ti-dm.c
> +++ b/drivers/clocksource/timer-ti-dm.c
> @@ -181,8 +181,7 @@ static inline u32 dmtimer_read(struct dmtimer *timer,=
 u32 reg)
>  /**
>   * dmtimer_write - write timer registers in posted and non-posted mode
>   * @timer:      timer pointer over which write operation is to perform
> - * @reg:        lowest byte holds the register offset
> - * @value:      data to write into the register
> + * @val:      data to write into the register
>   *
>   * The posted mode bit is encoded in reg. Note that in posted mode, the =
write
>   * pending bit must be checked. Otherwise a write on a register which ha=
s a
> @@ -925,7 +924,7 @@ static int omap_dm_timer_set_int_enable(struct omap_d=
m_timer *cookie,
> =20
>  /**
>   * omap_dm_timer_set_int_disable - disable timer interrupts
> - * @timer:	pointer to timer handle
> + * @cookie:	pointer to omap dm timer handle
>   * @mask:	bit mask of interrupts to be disabled
>   *
>   * Disables the specified timer interrupts for a timer.

Seems like two different fixes, right? These should be splitted into its
own patch.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--qqNtyi/bdFWrjAqo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY0lfpwAKCRD2uYlJVVFO
o3csAQCWz9VFu9TGcgBSLP9v85LV+TmGBJjg9g+6qNxBmR3PHgEAuMJnfWmCDGLx
py8SAfX5G1u4AiGNzxZ3GFg3hz3kYQw=
=GOSp
-----END PGP SIGNATURE-----

--qqNtyi/bdFWrjAqo--
