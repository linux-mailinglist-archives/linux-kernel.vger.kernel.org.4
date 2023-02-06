Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D99868C7E2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjBFUpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBFUpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:45:51 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414403C05
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 12:45:50 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 7so9050008pgh.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 12:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igorinstitute-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qCgatFPRuUDhHayY+Kosg9sSQLTOPEXs34Upelph/fI=;
        b=DnQZWjpF/0iXmsltg1wtWSGxq7rViHImzl8JiNkEfLcwH/AQqWFShelBGku/1iT9n8
         P9lEhu4AqY5mWsVTK8YDGD/UoKk3EnQ3BH4kEo1y5zQe0I4+YODMgRuRJ5bR9z/c1IEu
         dGUm931cxzx5DEyQ5MJ407fEyxostxmE9D3bABshQTNL0qfMpCzt/i5BF0suHcisXWg3
         gOzeTO8clYBsUdFklrf2d2uWAovPn4cCTRsZ58I9wmFnu1oMZJ9GUTKKKjZDwZtQrVsB
         aaiGea5CV9K7s/sA8PlvlOZgEWdTAlQTo2fA2ZPkV8sysSyr3CpJ2KgBy+gm4vxwAWzj
         WD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCgatFPRuUDhHayY+Kosg9sSQLTOPEXs34Upelph/fI=;
        b=FehHyfqc08URk5tYwZP2nwcP+Lto0PQtbdYYuuTj7wEMKt9GaUYKENcAlL0myY9rIN
         mbPRVVSNdDLdtePSxF+7ohSr3zr7kxMMGoglPVLERmwas+ROuebsUburqLi/hSJlS+wI
         mcH9oAsw94nWiXPWLb7kHeVwfg5r/OtpCvbVH40A+4pB8eYUj38eRjwAC5iUniXEm/xX
         OPU/iq7/CCTjrTSywsAVZeNfDeI7OY3kM+ZgsmPGWSGXuww17ZFKKjS7mA15N6+NlYP5
         rK+BJ7vn7NgE2dsfWkWHox7tCsuH3HsdXAWfjofFLs8rF8ttPS9vrQ/GzAMjAKXYkD+K
         hFEQ==
X-Gm-Message-State: AO0yUKV/y/KU0V9j0pwBzq8k/GfVZ0fuvPMh7u2F5zqhQkQ8e+F7Ezi1
        vAUqSJ0O5KI15ubyUWzHwGWuiw==
X-Google-Smtp-Source: AK7set/KYnw5723a5WPz7p0YfkjaJ21x17ft2s3rs2EyPcRq72zbtf03BlRzh39rHPu/AHXo0iHghA==
X-Received: by 2002:a62:17d4:0:b0:592:5276:95df with SMTP id 203-20020a6217d4000000b00592527695dfmr719003pfx.2.1675716349752;
        Mon, 06 Feb 2023 12:45:49 -0800 (PST)
Received: from localhost ([121.99.145.49])
        by smtp.gmail.com with ESMTPSA id v18-20020a62a512000000b005938f5b7231sm558293pfm.201.2023.02.06.12.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 12:45:49 -0800 (PST)
Date:   Tue, 7 Feb 2023 09:45:46 +1300
From:   Daniel Beer <daniel.beer@igorinstitute.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Andy Liu <andy-liu@ti.com>
Subject: Re: [PATCH v3 2/2] ASoC: tas5805m: add missing page switch.
Message-ID: <20230206204546.GA233871@nyquist.nev>
References: <cover.1675497326.git.daniel.beer@igorinstitute.com>
 <1fea38a71ea6ab0225d19ab28d1fa12828d762d0.1675497326.git.daniel.beer@igorinstitute.com>
 <Y+D8bf/19aOL7Wzl@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+D8bf/19aOL7Wzl@sirena.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 01:11:09PM +0000, Mark Brown wrote:
> On Thu, Oct 27, 2022 at 09:38:38PM +1300, Daniel Beer wrote:
> > In tas5805m_refresh, we switch pages to update the DSP volume control,
> > but we need to switch back to page 0 before trying to alter the
> > soft-mute control. This latter page-switch was missing.
> 
> You should just use the register windowing support in regmap, it will
> take care of this for you, avoiding any further similar errors.

Hi Mark,

Thanks for reviewing.

We did discuss this a while back when the driver first went in.
Unfortunately the vendor software tools provide configuration for the
part in the form of a sequence of raw register writes, including
explicit page changes:

    https://lore.kernel.org/lkml/Yd85bjKEX9JnoOlI@sirena.org.uk/

Aside from this, I have two other practical issues.

The first is that I'm not sure how exactly to implement the paging
scheme in terms of regmap_range_cfg (assuming this is what you're
referring to). This chip has multi-level paging (books/pages), with the
book selection register itself requiring paging to access. A sequence of
three register writes is therefore required in the general case to
select the correct page. I had a quick look at a random assortment of
existing regmap_range_cfg uses, but didn't find anything that looked
like the same problem.

Secondly, the patches as submitted here have been tested, but I don't
currently have access to hardware. I'm very hesitant to make a
significant change without retesting and leave the driver in a broken
state again.

Cheers,
Daniel

-- 
Daniel Beer
Firmware Engineer at Igor Institute
daniel.beer@igorinstitute.com or +64-27-420-8101
Offices in Seattle, San Francisco, and Vancouver BC or (206) 494-3312
