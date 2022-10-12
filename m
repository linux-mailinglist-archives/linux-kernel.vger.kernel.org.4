Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87585FCB29
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiJLS4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiJLSz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:55:59 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FCC103257;
        Wed, 12 Oct 2022 11:55:41 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id l1so17047792pld.13;
        Wed, 12 Oct 2022 11:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+dAMi5/mvpnx7OR0d/iFkXATxA1PKTD2Ztpj7qqwBAk=;
        b=pS2iTkA5/q2REoYlw8Qrmn1Bx5rUg5ha3eAyUVdps/c7ALpArkDFtHb0jd7Gz/78Et
         dwcwRKGXRgl7YZvir+ErSb/SkwmyeSzTKfPBM5A+DEnqCSW5VkAs8bpOLnGY8uWuatZD
         MHB2TBO28THLzO67ncguwpoIvO858LqQB4nXOFz9bB0q0uMuFogQ5oNlQTkONipFTIn2
         NmmiQj4zPAqASQZi4P/7IyKbYocplFtpLsjGuhO4AOYR13DthHGUYWIh/01y2bys1ssV
         sdOjPzUvD3gF2PnMz5q+xUTqRkf6+L/hGgl7A1aGxXKX25MgTQs3Asuv0L8xSn350DOq
         Av4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dAMi5/mvpnx7OR0d/iFkXATxA1PKTD2Ztpj7qqwBAk=;
        b=EuVSiFHUnSV4IvIXPHjnZ/BszLE13Xb1CK8dFZxytrHev7w78YIW8b2FtE/mtlly7t
         av4i2HJk8VCt1FT4eKWykvQx18kWN1m/0aHtv741DZAaNrMt9aT/uO7WQU9i36bTyOIl
         qyEtXx6jZkUoQbXz8SfhyTpiczMW2pbDcs+8N0Flrz+o2ykhbvnYaDdbidNrKBo5T5nk
         xG2I5Ff+WPdY12JQnzkGUIsgqdrjhpRmzlZTDhGjPyo9yr2FYHtKRRNsyetUnNNzaJTK
         lcqdzwAv3AMmq6Otv83+3w/9cF7UNGdW7Uw04P0ZpxDmmS3D6CHo0FSrpCCO7qGO7rD6
         EGlA==
X-Gm-Message-State: ACrzQf1P6hgI7XwXLNrxc/dAx7u3STJ20iChFlgJH7708DVAxUrUBUPM
        gY7SH9PSkm+3cH1aMHh3dqA=
X-Google-Smtp-Source: AMsMyM5BtLR/wWpb3iG+V7bZPXJJH1Ke340SVWfrNV2hX11yO3vwimGboY7ERjAASJbUBDyar7bHXw==
X-Received: by 2002:a17:902:7894:b0:178:bb0b:5740 with SMTP id q20-20020a170902789400b00178bb0b5740mr32414920pll.65.1665600939579;
        Wed, 12 Oct 2022 11:55:39 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d4c1:686c:5489:5df9])
        by smtp.gmail.com with ESMTPSA id d18-20020a170902f15200b00174f7d10a03sm10914153plb.86.2022.10.12.11.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 11:55:39 -0700 (PDT)
Date:   Wed, 12 Oct 2022 11:55:36 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 4/7] gpiolib: of: add a quirk for reset line for Marvell
 NFC controller
Message-ID: <Y0cNqBKm7LhZd28t@google.com>
References: <20221011-gpiolib-quirks-v1-0-e01d9d3e7b29@gmail.com>
 <20221011-gpiolib-quirks-v1-4-e01d9d3e7b29@gmail.com>
 <Y0aW7vDxfNa/8bAk@maple.lan>
 <Y0cLLraNFVXtD2/k@google.com>
 <Y0cMibfIomw3S5dc@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0cMibfIomw3S5dc@maple.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 07:50:49PM +0100, Daniel Thompson wrote:
> On Wed, Oct 12, 2022 at 11:45:02AM -0700, Dmitry Torokhov wrote:
> > On Wed, Oct 12, 2022 at 11:29:02AM +0100, Daniel Thompson wrote:
> > > On Tue, Oct 11, 2022 at 03:19:32PM -0700, Dmitry Torokhov wrote:
> > > > The controller is using non-standard "reset-n-io" name for its reset
> > > > gpio property, whereas gpiod API expects "<name>-gpios". Add a quirk
> > > > so that gpiod API will still work on unmodified DTSes.
> > > >
> > > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > >
> > > How/when has/will the DT bindings documentation for this hardware be
> > > updated to describe the new bindings?
> > >
> > > Delivering the quirks ahead of driver updates is great for avoiding
> > > merge conflicts but it also conceals the rename from reviewers so
> > > risks neglecting to update the bindings.
> >
> > I was planning on sending binding updates once driver patches land.
> 
> I'd have a (weak) preference for them being shared in the same patchset.
> Maintainers can either ack or the changes can land seperately but
> having them in the same patchset helps avoid having to quibble or check!

OK, so how about once we agree and land this patchset to gpiolib I can
blast driver patches + binding patches together?

Thanks.

-- 
Dmitry
