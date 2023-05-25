Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13D97108DF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239852AbjEYJ3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239801AbjEYJ3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:29:02 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAE01A1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:29:00 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f6d01d390bso3760975e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685006939; x=1687598939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TZxjisxdb+ifIN0MftEgTGuODfOpHrk3qWAFjHOGXrw=;
        b=IJHudluyVTcVXD34T/H93aoYhBj/y8hT0t3S2Q3sSRTPQKWeGFJCeC1Ww02Nzc3w6s
         MFdOkfa70kPKEAM98RHv174UWnZsOWU/g1xr3Bn8SZQR9kh/z4pxP2DFRgbBlbZAxpAC
         WZ1FM+Knvn0jxPPTNwBhYz1Qs489J9v/0/5Ec5lAtgiH0wjUE6x4ZNbdLVd224mMzW7B
         dfiJHqpr8VcAdz10kRFbqMV9UeIs+30L+qZ++AmEyesdLDRUYKoWLV6K22Uq3cJ6otvC
         LsCKYZvwHptIYLJJeLscnugr4EKO1ZU5I1RQBO8qZhJ+U1pcTxYtnL89XrzqMXWWWhte
         pT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685006939; x=1687598939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZxjisxdb+ifIN0MftEgTGuODfOpHrk3qWAFjHOGXrw=;
        b=GF54rplfujeo0u2QfWyqBn2zp0nlkVkmBcfp4s1L6IYbXjL66FtZDgQyiA9nqcdp2N
         srzkmyWucH4b+/hlzrt5KxXn02bZHMY5oXYy46rUpNXsvmKs50JuRE+vMrT9ys+8kCKa
         8kcHyiTCSMqqbC+0ALDGtxDNqpFb1/TptTD2En4THPT+4dhr4RBvlbG9OYFu3ccd5y3i
         dHc4n6W3hVw+5EE9CbvjVc+x9EUVAf/00jH90n/h4axT4B7LDGjROyjjavGiBXS52ygY
         /Qt9tWv1sphEuPOaqJL59Zir8yME4rrneS+tu+RWq8KOrLQw1WyJLX7WfXwkoKP2HSUD
         u8Ww==
X-Gm-Message-State: AC+VfDxsZlQW/jJvlr2BuIb2bclPVrgwVO5JavMDNksa21NZdSRkjlwo
        bNWrD/pex1ZJF75RFoXG6ycoag==
X-Google-Smtp-Source: ACHHUZ60ihUJaY7ZYa1Tg8X/+3FwaOjBSRfgPnL1oZbXWKcnMnOGO5VULYv0bMZ1vfB+Z0LFHqJkjA==
X-Received: by 2002:a5d:58d4:0:b0:309:5029:b075 with SMTP id o20-20020a5d58d4000000b003095029b075mr1959331wrf.13.1685006939203;
        Thu, 25 May 2023 02:28:59 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r18-20020a056000015200b002f7780eee10sm1139409wrx.59.2023.05.25.02.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 02:28:57 -0700 (PDT)
Date:   Thu, 25 May 2023 12:28:55 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Wang Zhang <silver_code@hust.edu.cn>
Cc:     Peter Korsgaard <peter@korsgaard.com>,
        Andrew Lunn <andrew@lunn.ch>,
        hust-os-kernel-patches@googlegroups.com, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] i2c: ocores: use devm_ managed clks
Message-ID: <34eaac7a-993a-4f87-968d-1e3f683784cc@kili.mountain>
References: <5572a733.abc0.18846f13b0b.Coremail.m202171703@hust.edu.cn>
 <20230524154318.2259-1-silver_code@hust.edu.cn>
 <2ca66dae-8424-4382-a0ed-ff742921c495@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ca66dae-8424-4382-a0ed-ff742921c495@kili.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 08:02:02AM +0300, Dan Carpenter wrote:
> On Wed, May 24, 2023 at 11:43:18PM +0800, Wang Zhang wrote:
> > @@ -780,19 +768,18 @@ static int ocores_i2c_resume(struct device *dev)
> >  {
> >  	struct ocores_i2c *i2c = dev_get_drvdata(dev);
> >  
> > -	if (!IS_ERR(i2c->clk)) {
> > -		unsigned long rate;
> > -		int ret = clk_prepare_enable(i2c->clk);
> > +	unsigned long rate;
> > +	int ret = clk_prepare_enable(i2c->clk);
> 
> Don't put functions which can fail in the declaration block.  Generally
> the declaration block is for preliminary stuff, and the important
> actions should be in the code block.  There should not be a blank line
> before the function call and the error checking.

s/before/between/.

regards,
dan carpenter

