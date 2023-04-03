Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5566D3C7D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 06:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjDCEku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 00:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDCEks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 00:40:48 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6098A4A;
        Sun,  2 Apr 2023 21:40:47 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so29210306pjb.0;
        Sun, 02 Apr 2023 21:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680496847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=agyl9pNXNvbaNwQwfiQ30HYhuh0VP1fCUWLtFvhHSws=;
        b=l0iTAlQZA49O55zJpMhBjWFVpJnHqoAi97I4XxTnoXtf+E9NgXOeyl7Fmu0XlxdaJN
         Ix7RNpjVYwFwVBkftN/xQ17cvKB8WMRpsw1K4YNQCaU0GzdecYX67eysWfbszHkhvD9I
         7qzus4LLxLw+8uG6gS1y6nJev+9ARyajX8KiogwVeZWojwLv6mHjO8T+kDT8yI/nWQ08
         tdJW+ndyGXfJ/G6YK5toYFl7BYt55sMM3pL2408TbQ0gEcQPO7u2sHqYN1x6X+g+RimP
         /j9YZFAVibBYYOWJEuRRCpR9+cAFUgWwh74DhiZiqU+U3oNjFAz6RSdsAeOrbwDiBIJd
         oxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680496847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agyl9pNXNvbaNwQwfiQ30HYhuh0VP1fCUWLtFvhHSws=;
        b=3d1+RSfOxZmEZMwGastD0EHHrAQSDDVumLEp3Vnj6cLz07vwwk1ItC8C41kk7BQhzm
         AzDLPciuhG02GLitssiqHPPzPAuxQLdxSe5nvfyDH0LFEhzroVExM2gNOnomn2x0h0mp
         9DOojjQApASY1es0wiAwX5DsxmZqUWfkpcLcHoDEP9WCbr4av81nHDDeH1Y3SpAw16N5
         if0QQtRJ7dHCzVdbrN4x6SAP6k6s+H4Og31T9fMwAuZozkbh9G+pUCtZIvZ/lPfMLmfi
         gHfpPNhx2jc+eYnHI2UIu4/6ECO4k5Oi2gtsu4BrRmJen7wRL6UOrtg1r+qii+Rm6rkv
         fdYg==
X-Gm-Message-State: AO0yUKW/Euhr+z15Q3EU3rKwKW8mBsSPY1SRoYWDjp09VDzWGtd1e3mZ
        zar0wREfHTfNAoFgwfb3wxo=
X-Google-Smtp-Source: AK7set8LR9NfsmXTc0xrmBsbF5ga7JuHoX4k5dzmfgi5fPv8CDRkEObErLpxqrBJpekMDRquC4KcgA==
X-Received: by 2002:a05:6a20:4f88:b0:d3:78ab:77c3 with SMTP id gh8-20020a056a204f8800b000d378ab77c3mr31650627pzb.48.1680496847080;
        Sun, 02 Apr 2023 21:40:47 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9a1d:5e0:d8f3:bc01])
        by smtp.gmail.com with ESMTPSA id bw11-20020a056a00408b00b0056283e2bdbdsm5698077pfb.138.2023.04.02.21.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 21:40:46 -0700 (PDT)
Date:   Sun, 2 Apr 2023 21:40:43 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, michael@amarulasolutions.com,
        linux-amarula@amarulasolutions.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 0/9] Input: edt-ft5x06 - convert to use regmap API
Message-ID: <ZCpYy1f/84nC1Tx8@google.com>
References: <20230402200951.1032513-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230402200951.1032513-1-dario.binacchi@amarulasolutions.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2023 at 10:09:42PM +0200, Dario Binacchi wrote:
> 
> This series converts the driver to use the regmap API for accessing the
> registers of the different models it manages, making the driver code more
> generic.
> The series has been tested on the following touchscreen models:
> - M06
> - M09
> - M12
> - EP0430MLF0M
> - generic ft5x06 (05)
> 
> The series also includes some code cleaning and optimization patches.

Applied the lot, thank you.

-- 
Dmitry
