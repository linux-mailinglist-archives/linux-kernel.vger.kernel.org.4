Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2C66CEBDE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjC2OlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjC2Ok7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:40:59 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4F98A46;
        Wed, 29 Mar 2023 07:38:06 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so16367327pjz.1;
        Wed, 29 Mar 2023 07:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680100686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MraKaJyT3BxLWbc/N8gjzZ9ahqVsNJ0TWzuq+OChN70=;
        b=Vd7ndb2ZBTIVZPajT7DIVOKDlUwy3KQZaqVIqSZGlHtMS//uATg2SK5sMuGL1LslZb
         zwB8VYdD4ZIN0A2dSqN7nbBcGwxKbtMytevBSU2LQ6iYSH3G4z42T1eCLNvOCcziVZSw
         K5XP/yg+clTm2hH3qb2tiwlKD63EjCsYgNrijs2s/Jca8ukp1EuZQF3IBPeFqJQrSCSO
         a/w/6sla+BgMTBnNbdkJS/Mi62uqsbj5FO5oMYrVYpLEOBsmjnxZwuHpPS2aMWu1Eut9
         TlFYubwSzWoXo7pEcvoYfQOueVKt6XE5PCpzHKDfMdCW79CsGDkFEua2ZUlkD39LrlPt
         4x2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680100686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MraKaJyT3BxLWbc/N8gjzZ9ahqVsNJ0TWzuq+OChN70=;
        b=Sj6uJHkKiL1mrcS7SVjwALlu7XfDurUpwtpGNAxYx8OEdXehSf3UhLnjeyeZQsVjMU
         fVlc7qHsqUndR3kACNuwcK5DWlTtlhe1Ydgp9O6gZ132sb0QCSG46/OF7nSY3ytwFo8l
         ocnbTD1pRGpgN0sdPce7diodwWBZprwEb+Vv8IuzdVjSWLMXCfnJcpxm1ojXWl779dex
         G8bu/KyABsHe2wyOajWi/GaxJCvfJ7VB7d82jv5Ma+4PQFXB0e2cmYFc6cWzkfTg4lKp
         qpRAGcC/gAaJKxkiMuxNsuHOk5AvEhxHyObrjN8yDaWidrzDUsBCjHBegMcAZH8ju8Dg
         bFrQ==
X-Gm-Message-State: AO0yUKXsHSJxjaqHVRiUHK8Y3lI8ni7ZYoeePbqsC8aSTKeVVmAY6q7o
        EZKHaeaaFwzpsOrz5NgUN+8=
X-Google-Smtp-Source: AK7set/GjyQPCIf6KPRezVqHBp6kJIQQzh01GsQSpzJTlJuXy3kQls3oCILpoBTcCMTPnEhr8vkXbA==
X-Received: by 2002:a05:6a20:7921:b0:d4:b24b:4459 with SMTP id b33-20020a056a20792100b000d4b24b4459mr16274401pzg.13.1680100685823;
        Wed, 29 Mar 2023 07:38:05 -0700 (PDT)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id a3-20020aa780c3000000b00628e9871c24sm14512864pfn.183.2023.03.29.07.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 07:38:05 -0700 (PDT)
Date:   Wed, 29 Mar 2023 22:37:58 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH] Asoc: wm_adsp: Add support for loading firmware with
 prefix name
Message-ID: <ZCRNRhI3+6jUbqvy@Gentoo>
References: <20230329130525.15830-1-lujianhua000@gmail.com>
 <20230329140524.GU68926@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329140524.GU68926@ediswmail.ad.cirrus.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 02:05:24PM +0000, Charles Keepax wrote:
> 
> This direction seems slightly problematic, especially in the
> context of amps (which I presume this relates to, please let know
> if that is wrong). It would probably be better to be fixing
> things up such that the amp in question sets system_name when
> registered through DT. Generally speaking the idea is the amp
I also consider setting system_name when registered by DT, but I don't
known setting what name to it. Card name or something else?
> tuning is going to be specific to the enclosure/speaker involved,
> so a generic tuning for say left amps doesn't really make a lot
> of sense.
I don't known about amp tuning much, my need just is loading firmware for
more than 1 speaker amp at the platform using fdt.

One of the both way is good to me.
> 
> Thanks,
> Charles
