Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8223570719D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjEQTMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjEQTMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:12:18 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FBBA5D3;
        Wed, 17 May 2023 12:12:10 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-24e2b2a27ebso1224864a91.3;
        Wed, 17 May 2023 12:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684350729; x=1686942729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=belPChGY/La7XkZuio4MlHHNDT6JFtoyF+AdNUmOvSE=;
        b=Y6p8Nx4GqfvFrtaGTVMQK/7Dp9vAmEtEXDMpT5L6tZQUjXtmHDgy2cgheNR/vGvIkr
         UbSZbCuJcF7FVEBDwMv1dXfY258bYy8SVF8J7XqFIEZ2+tMdOn2GX8aLIxurHlZ8npcN
         TIN1hJKbdBR24rwj8P852JroKawQLl/5yXPhPw5jJ/1Id7woRfFT4y+PX5rkAyXu+cbI
         Il67x0OVh1C60eIDJ1T1tJcdqyEL7pPoTuZnH6/YQ1CT5aepni237X03kgojUiv5YT/c
         6b2vKeoQqLH2UWxQju7I2+MlLGk3Idz5wLFaAst8xS0ydi/nRHk0HXiHg6ugSZl9tK3o
         wq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684350729; x=1686942729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=belPChGY/La7XkZuio4MlHHNDT6JFtoyF+AdNUmOvSE=;
        b=DDcTXeffYN9Cbv2MglPvo/4DlN6uzBtPDRDc73OuXCdIMoHJssuefjHyCkqu0KIw2i
         0uKe6fJRS/Gu3ObQIFj25VteL3M5ow0or1JBGVtHtKi6Z3X207oX3/TQU+xbe28BMmwW
         1h7KJ67U/hAvqAXXaRGDuwkqMmL3ke8Hba0X/L8w2a4TpxgfEuGqfl6yNEQZohXibXvJ
         pISRLEiMIksYJm1QwOT0+JDpOdV95/t5kxkC/IijMm+3nFHf8DbCI/c7YFmhqgVjuK/D
         dbiDYilUHdsK2AhYcAunpRvjZX4qyvW5p0obHtCN/hA3UHNcDrZNpzRWHyK+mUTL6DkD
         ytDw==
X-Gm-Message-State: AC+VfDzSQjoMZtDKSW9V3f2dUj5Uan30/K0znfLYtBubeb5xNJAierPu
        2SjKgv4a031uL1IqyvKbIeNUuL4Y62k=
X-Google-Smtp-Source: ACHHUZ6tMu01Q4ai0Y2K2iB2vTJD+vZhid6eNXamnu078f1AaaN9TgIVFyPhAOxUuwhUAN3cEu/YxA==
X-Received: by 2002:a17:90a:2fcf:b0:24e:1f5:2e05 with SMTP id n15-20020a17090a2fcf00b0024e01f52e05mr721049pjm.13.1684350729404;
        Wed, 17 May 2023 12:12:09 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:6ecb:b01b:2e2e:6c1])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090a890d00b0024dee5cbe29sm1975303pjn.27.2023.05.17.12.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:12:08 -0700 (PDT)
Date:   Wed, 17 May 2023 12:12:05 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Hugues Fruchet <hugues.fruchet@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: c8sectpfe: convert to gpio descriptors
Message-ID: <ZGUnBfqBLWkD7ZgD@google.com>
References: <20230130131003.668888-1-arnd@kernel.org>
 <ZGUbDFssUwXKTiDt@valkosipuli.retiisi.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGUbDFssUwXKTiDt@valkosipuli.retiisi.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 09:21:00PM +0300, Sakari Ailus wrote:
> Hi Arnd,
> 
> On Mon, Jan 30, 2023 at 02:09:47PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The gpio usage in the function is fairly straightforward,
> > but the normal gpiod_get() interface cannot be used here
> > since the gpio is referenced by a child node of the device.
> > 
> > Using devm_fwnode_gpiod_get_index() is the best alternative
> > here.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> I've picked
> <URL:https://patchwork.linuxtv.org/project/linux-media/patch/20230130131003.668888-1-arnd@kernel.org/>
> instead. I hope that's fine. Also cc Dmitry.

What do you mean "instead"? This is the exact patch that started this
thread, and it is broken (uses wrong name of the GPIO and wrong polarity).

I'd much rather you picked up
https://lore.kernel.org/all/Y92VLGLQJZ%2FUDRx1@google.com/

Thanks.

-- 
Dmitry
