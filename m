Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452357492A8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 02:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjGFAej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 20:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjGFAeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 20:34:37 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF1D19B2;
        Wed,  5 Jul 2023 17:34:35 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666e64e97e2so164252b3a.1;
        Wed, 05 Jul 2023 17:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688603675; x=1691195675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ybX/bwtG0CmtH+U4NpvKW0NQGOexYoxkE3fuma27f0I=;
        b=k1iHycX+tCjJBIBV+Ri3x6SJuYwjEIOT7ffQdj+CuDwgn8UMypxzJHmmd0FdpQHPKC
         XfSxqoCG7hzYbfbsAkGXvgmvBwyYi0L+OsHD2e2J2+3GpNOg5omDCXuW46oGSdSrOXjw
         4sBYFGd4qw5o6h0jadlbCYy7SY4IiUhffKWyhZ+du/L/MHX8gOzL2qMUc1+4bevSEW4w
         a+2o6DYOVZOyWttWSRWV31e+QRLxhSg5dqRk/JD+s84pQOXE942BX5Bjopb+OP64aZ1w
         TcEnNnBJif39U4goOOCmQsxrWcQwNVHmQDoxWDnLX2OEmD+ycqVV0G6yUBYaDlorDTWa
         6onQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688603675; x=1691195675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybX/bwtG0CmtH+U4NpvKW0NQGOexYoxkE3fuma27f0I=;
        b=G9dCRFARWrcuOn+vr7foOaqVvoma+IdIH3oYjMMzxb17j++huuXu6GBQK5xOqmxHoT
         JJHEYiyuV5Y5G9hZ5iiAdbYmm5ZvtPHthrp9E5ur4iF+1EgzyFXXh3gCvY/6XKx6hzCV
         PBEuViD8CvZlWaU+ZMPLflgZN39zCozPyZHVYyMdJQChbbqeHIl8m3alMRQLePBWFPEJ
         NjhhW336tz00lfCsq7k76QIxVMIFo1f61ltINKRTIaIU56PxMkH+41Vu7LRWvGjZTFHu
         QvXVlT8RSX8mXxOugPclZFdxsthBsiU8gjowerliQjGQabndH6GKnIYjVRT4eoE9nAc5
         ohAw==
X-Gm-Message-State: ABy/qLYzarDFIA0/HJI+vd7maOLy1HXGAUU0mgBqt1jdkTo1jVHZfrTA
        D9Y7V/sNyplbffvGtaW7SE5vIqoWC0s=
X-Google-Smtp-Source: APBJJlEnVjFEZxCyfzfN+p9VRkkkRB8RDzv8+t5HS1o6EnM+JhadmVZrv104FgWsN7sk8Cq2bHm2tg==
X-Received: by 2002:a05:6a00:1915:b0:64a:2dd6:4f18 with SMTP id y21-20020a056a00191500b0064a2dd64f18mr419956pfi.13.1688603675180;
        Wed, 05 Jul 2023 17:34:35 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9fac:a99f:7f0a:397])
        by smtp.gmail.com with ESMTPSA id z12-20020aa785cc000000b0064928cb5f03sm112281pfn.69.2023.07.05.17.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 17:34:34 -0700 (PDT)
Date:   Wed, 5 Jul 2023 17:34:32 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/1] Input: gameport: add ISA and HAS_IOPORT
 dependencies
Message-ID: <ZKYMGMKuYC0/wOLN@google.com>
References: <20230703152355.3897456-1-schnelle@linux.ibm.com>
 <20230703152355.3897456-2-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703152355.3897456-2-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niklas,

On Mon, Jul 03, 2023 at 05:23:55PM +0200, Niklas Schnelle wrote:
> +static void gameport_setup_default_handlers(struct gameport *gameport)
> +{
> +	if (gameport->trigger && gameport->read)
> +		return;
> +
> +	if (!IS_ENABLED(CONFIG_HAS_IOPORT))
> +		dev_err(&gameport->dev,
> +			"I/O port access is required for %s (%s) but is not available\n",
> +			gameport->phys, gameport->name);

I combined these 2 conditions into one and applied, thank you.

-- 
Dmitry
