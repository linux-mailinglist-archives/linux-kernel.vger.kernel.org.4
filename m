Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0226C680512
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 05:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbjA3EgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 23:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjA3EgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 23:36:00 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7106410A;
        Sun, 29 Jan 2023 20:35:59 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id c124so6835076pfb.8;
        Sun, 29 Jan 2023 20:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5+JwJ2M5LnegZU3pg7JX4aEC8AFeBV1IQ1z0IKVMJEE=;
        b=YYTvw4Cn4u6EcZjW6eGJvR4r4ir1yAnYTsTB3a/RAr/aSPz+r8gg/9G8ZssXXNlBd7
         Jy5oSoX2R1NlrpVkq0cK/EMs4k0RuvpvsaAQBvxWe7DTnmMfYZL29ItdFelywcBfCkrO
         O3FQU9D62QjRAE1sdpofo9mWAiB6bSDDGxNfPuiJmd8PtuRBgoU/6R9Hm9CodwRS13z4
         0rHKn+wGyfaiYDctPHdw/dOV3YcVdBG1Z6/3tT2DjY01y2UnQK+eNaS0mnWy4qNGR0yj
         TjojXZDrskz4sppT2r91AqNQ/o3UwBQp52tNfdDU5uejEO6odyKpj/Sm5lbicPtdWKjh
         6MIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+JwJ2M5LnegZU3pg7JX4aEC8AFeBV1IQ1z0IKVMJEE=;
        b=D6JJ7HDR+/q8rXH2WtqDRaYAYly2OLi2Ra1rn7ncVvg7iQy3vcDgtymwJHL2LEW67f
         1I1RxgUmdcuhlZ0FXng0lbPvdqN8WAV8c9ZyibaUdwN1wDp6wJ/cLPgFHyHLc4XLMpd8
         nipqecEfYwO4GL1FbkxVFnelqEyjVEuZArsCVhAT2UaXUKKLC8cPvsm/AZZ92zgBBAZQ
         bbsXr8rXdrK+RWH7FVfmeAghat/UXeikiMGGSh/MJOuKxNVzlhp1PoRSmFCvD39T8rY0
         Dp9ONBVSHoXCjNh51BYZRqkuGRFQb+ociCxaMn5IDLSWPhFhPVa9YYGOPsI1r0ExMEQa
         EMEg==
X-Gm-Message-State: AO0yUKXJpaa3LYwJOLWMELjgxRnIxLvJT0Lad/wt7C69s76JHd8++Rct
        WIXEhQ03HrUF2WvRNpWjL9Y=
X-Google-Smtp-Source: AK7set9bNwZvB7+bN1dOI8ZuzSeOWhzNGdZ6nxIgW/oSb/pGnDRna0UmUnSZGjlH7himeadwb+JVRA==
X-Received: by 2002:aa7:8e01:0:b0:593:9265:3963 with SMTP id c1-20020aa78e01000000b0059392653963mr6517976pfr.31.1675053358760;
        Sun, 29 Jan 2023 20:35:58 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:6882:174b:bc70:101])
        by smtp.gmail.com with ESMTPSA id i13-20020a62870d000000b00593adfa8694sm1994666pfe.37.2023.01.29.20.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 20:35:58 -0800 (PST)
Date:   Sun, 29 Jan 2023 20:35:54 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Luca Ellero <l.ellero@asem.it>
Cc:     daniel@zonque.org, m.felsch@pengutronix.de,
        andriy.shevchenko@linux.intel.com, u.kleine-koenig@pengutronix.de,
        mkl@pengutronix.de, miquel.raynal@bootlin.com, imre.deak@nokia.com,
        luca.ellero@brickedbrain.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] Input: ads7846 - fix support for ADS7845
Message-ID: <Y9dJKkAFybkVn0FY@google.com>
References: <20230126105227.47648-1-l.ellero@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126105227.47648-1-l.ellero@asem.it>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 11:52:24AM +0100, Luca Ellero wrote:
> ADS7845 support is buggy in this driver.
> These patches fix various issues to get it work properly.

Applied the lot, thank you.

-- 
Dmitry
