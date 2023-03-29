Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961AE6CED5C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjC2Pt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjC2Pt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:49:27 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70664EE6;
        Wed, 29 Mar 2023 08:49:25 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id jy12so338453plb.8;
        Wed, 29 Mar 2023 08:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680104965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+vL/Z2hUHOoRNlZ8vK1peaG8u3Hz3sYl8UlPc5uVwYo=;
        b=b3Vl4oK8IImeQKY80tYxKC8IbJrOpjTAU8OSMK8zTlThaX1Tmx2ZT6ZdO/wWRHrZZV
         0GgbMPHw9ztqIrW5OimlCMppP/IB2rlEJP9ZNNUC392AfLAuGp7rbzpimRVsr0qPxMHd
         7R9SnUt0zQiR1sX9EbIurdPC7d7xcHj/P7F8XW8G0n8IpO+qDzzN10eMqaaxEbIdQbRG
         vNKowQmJZ+w5mbMMxib8k57gfmR9hn2+Y0xIXlMeTY/QHfflUt2q8MbHPzoXTd3fweNQ
         +dXS89GUFJnTiM0ubBM83msg/CyYiNy3nyw/Q8fSJJwEX3yB5HgeKKb8SaqW3LSYPr+5
         Yn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680104965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vL/Z2hUHOoRNlZ8vK1peaG8u3Hz3sYl8UlPc5uVwYo=;
        b=L4D+tW2S700bGotfvB/TJAa5ZZR45hxJNsem1ZWYyY2Z6Qfhxneb9VZcEunXTxQrTv
         Rn8dLjEVUdvEETSg2bWXG14W0HuHdwSwadV20FxLp9oh4q3ER9wRYg8xLJfg+b+QVE91
         dpik8UNu6e2TduuQVTxf90YqDrC/XQXoukMBOyp5X9hUfgq4Hy1mIPTDA8CGB1Ca9gA/
         maV7tbWZP4yt+7uPAPq+L7TMj0cG0cG/k4+kVrIzNLqr3EXx43uvmxBFBZpUKW9qfjxj
         mFjUaBYjmH6Xcf3A9UP22G9tDBYxFpdgkw22CPKfDKIO6fdMmUmxVgJ8IeYXv4MaJvkb
         j3Jg==
X-Gm-Message-State: AO0yUKX7XiYzZiH9mJf7rE2VVl/w7XPhuVO1bUGsu4zJnnTCVgR1tvP2
        B5Ca3XWfP/CIvCSG+0WG8mc=
X-Google-Smtp-Source: AK7set++hCqmKovdelYiJ5+jJFzodnQekyeY7x/9RhGU2tIB+qRGmT1PcNtVFnyvuqMh+sEPgj3cAw==
X-Received: by 2002:a05:6a20:1e4d:b0:da:f525:e629 with SMTP id cy13-20020a056a201e4d00b000daf525e629mr17412798pzb.53.1680104964912;
        Wed, 29 Mar 2023 08:49:24 -0700 (PDT)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id u15-20020a62ed0f000000b0062a474cd46asm12813979pfh.137.2023.03.29.08.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 08:49:24 -0700 (PDT)
Date:   Wed, 29 Mar 2023 23:49:17 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH] Asoc: wm_adsp: Add support for loading firmware with
 prefix name
Message-ID: <ZCRd/Uph/BY6tkc/@Gentoo>
References: <20230329130525.15830-1-lujianhua000@gmail.com>
 <20230329140524.GU68926@ediswmail.ad.cirrus.com>
 <ZCRNRhI3+6jUbqvy@Gentoo>
 <51cdc8df-9472-a604-3cca-ebaa7ae5d899@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51cdc8df-9472-a604-3cca-ebaa7ae5d899@opensource.cirrus.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 04:38:07PM +0100, Richard Fitzgerald wrote:
> On 29/3/23 15:37, Jianhua Lu wrote:
> > On Wed, Mar 29, 2023 at 02:05:24PM +0000, Charles Keepax wrote:
> >>
> >> This direction seems slightly problematic, especially in the
> >> context of amps (which I presume this relates to, please let know
> >> if that is wrong). It would probably be better to be fixing
> >> things up such that the amp in question sets system_name when
> >> registered through DT. Generally speaking the idea is the amp
> > I also consider setting system_name when registered by DT, but I don't
> > known setting what name to it. Card name or something else?
> 
> It just has to be a unique string.
> The normal process is that Cirrus would release the firmware with the
> correct name for the platform, so the system-name matches the string in
> those release firmware files.
> 
> Do you have an official firmware for your platform?
My device is Xiaomi Pad 5 Pro, vendor releases wmfw firmware with
default name, coeff firmware with prefix name(TL, TR and BL, BR....),
don't contain a unique string in firmware name.
> 
> >>
> >> Thanks,
> >> Charles
