Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43866BAE09
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjCOKp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjCOKpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:45:06 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96391CF47
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 03:44:34 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so773886wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 03:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678877072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I5w307rWmgryop5gmMyN+pVKpaqhUM4imOkVri/jWj8=;
        b=PpveHZTtHgwOpRpiv8XfWncVaUopLpJaLcCIRxWd+VSfAzE7Aj4c25z0jKYxNhvUJt
         KGIeDfsFW9tgy7rPoiRutjMEOK9zY3OXxVRVo/dVDg9m8n1K4vnjhxCKLz5IgrPaVw4G
         /9OZSgVPD8oFi5YkF8+evYaND9IXT2rPHy1lwDNcuc/RfVEVAcWMre7vy8zxr6KtL/DL
         ovypciI9uf/3sdxK64MK0YAfuPBBvcA4ZvdlD9LAbtnjiV+1bewhf14GvmOmbd8YepVM
         u7Cehm4B3p9cl7CuASSsOcThQGEZE5NEu25ZGVPdIUYxCzPaYi9wk6RA+l2vo3AWOG1O
         o1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678877072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5w307rWmgryop5gmMyN+pVKpaqhUM4imOkVri/jWj8=;
        b=bge2bLXCkZdyGs/x+IOTxIJooa6/LBd2CJA4tijbFCSIBkIAjzPLgHLQqeVdIS42/0
         DVcBs8KS+PQRuF/puCPgu2l2CU4l7LKygL9sACMilTR6N7AShG5avR5EdylPU4Jfv3z1
         8QE8fUUxsyf7t2IDP3v5wC4g8zolOBWjne8qJfzNvZNk7lUmaawntVm/q5E/a/AiZNJZ
         ZONxQuC3YY6AcdbcSXNJNRVa2cDMwQ+/LsPY3aVtWA6CshvvnsjMg8BxhpM07BdKoDEN
         orJGLfv0QGeotTB/j9aAA4VK8SjVmqR6tMDN/CTp2AuilfhWBdF8Xv8c7H0ddyxxbkoF
         SfGQ==
X-Gm-Message-State: AO0yUKXI5yFlHvaPwxkgHVxdWg3Gj7BX7A1d7fzC5iVFm329fvbPBAiI
        tXv86OjrCSto/jGizJ5iukkh4w==
X-Google-Smtp-Source: AK7set9AENzO58n901CYx+STwtwt9velomv9LpAyWxcfODReIXx5iAtinpK4tJEBKI+uOV38mW1ccw==
X-Received: by 2002:a05:600c:4ecf:b0:3eb:29fe:70ec with SMTP id g15-20020a05600c4ecf00b003eb29fe70ecmr18972129wmq.27.1678877072523;
        Wed, 15 Mar 2023 03:44:32 -0700 (PDT)
Received: from blmsp ([2001:4090:a247:8056:be7d:83e:a6a5:4659])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c3b1000b003dc4a47605fsm1504944wms.8.2023.03.15.03.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 03:44:32 -0700 (PDT)
Date:   Wed, 15 Mar 2023 11:44:31 +0100
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Michal Kubiak <michal.kubiak@intel.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] can: tcan4x5x: Introduce tcan4552/4553
Message-ID: <20230315104431.xv7md4jcmpw4tkdr@blmsp>
References: <20230314151201.2317134-1-msp@baylibre.com>
 <ZBC8cw/yLiv9L9OM@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZBC8cw/yLiv9L9OM@localhost.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Tue, Mar 14, 2023 at 07:26:59PM +0100, Michal Kubiak wrote:
> On Tue, Mar 14, 2023 at 04:11:56PM +0100, Markus Schneider-Pargmann wrote:
> > Hi Marc and everyone,
> > 
> > This series introduces two new chips tcan-4552 and tcan-4553. The
> > generic driver works in general but needs a few small changes. These are
> > caused by the removal of wake and state pins.
> > 
> > I included two patches from the optimization series and will remove them
> > from the optimization series. Hopefully it avoids conflicts and not
> > polute the other series with tcan4552/4553 stuff.
> > 
> > Best,
> > Markus
> > 
> > optimization series:
> > https://lore.kernel.org/lkml/20221221152537.751564-1-msp@baylibre.com
> > 
> > Markus Schneider-Pargmann (5):
> >   dt-bindings: can: tcan4x5x: Add tcan4552 and tcan4553 variants
> >   can: tcan4x5x: Remove reserved register 0x814 from writable table
> >   can: tcan4x5x: Check size of mram configuration
> >   can: tcan4x5x: Rename ID registers to match datasheet
> >   can: tcan4x5x: Add support for tcan4552/4553
> > 
> >  .../devicetree/bindings/net/can/tcan4x5x.txt  |  11 +-
> >  drivers/net/can/m_can/m_can.c                 |  16 +++
> >  drivers/net/can/m_can/m_can.h                 |   1 +
> >  drivers/net/can/m_can/tcan4x5x-core.c         | 122 ++++++++++++++----
> >  drivers/net/can/m_can/tcan4x5x-regmap.c       |   1 -
> >  5 files changed, 121 insertions(+), 30 deletions(-)
> >
> 
> The logic and coding style looks OK to me, but CAN-specific stuff should
> be reviewed by someone else.
> Just one nitpick in the last patch.
> 
> Thanks,
> Michal
> 
> For entire series:
> Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

Thanks for your review, I fixed the nitpick.

Best,
Markus
