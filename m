Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90246351B9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 08:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbiKWH7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 02:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236112AbiKWH7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 02:59:18 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C975F27CE1;
        Tue, 22 Nov 2022 23:59:05 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id vv4so31641544ejc.2;
        Tue, 22 Nov 2022 23:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f4Agszvcd8QQMAqioCrcTnE+poivJbc38QaNotksFdc=;
        b=Yb1k+KxH+C9om/ZZiZxwn8UcaOs8xPuuxdLRjtfa51vPSFh6T0K3v8kSl5eeXRQeQG
         38z2eE2a6ItpJftrkqbbTodr6uV5OEARhHmjX9Dt5t9Xb7GfTgo1dqv5Dl8aNcTVz6Cl
         1x9cZtYp4FDthDCjnTLq7xCGeG4saj20lEinVYtQ0b2/3SYkQop71IM6uQkNkNt8FEp+
         HohD7D9Iwn/sWDiA4pEyRnj5ZBr9x9REeE6VFRj6x3/JDqSF6p4U76JcIF/Hm2Hb5Gt2
         VUojEKlDmvsjGmaC4fDAuEgYXISGcWTLz1Cv9wAyMMYlvd0vF1EiCItCnIHEqHQj5Tp5
         HUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4Agszvcd8QQMAqioCrcTnE+poivJbc38QaNotksFdc=;
        b=BRM2Y1lg4O0VAvQEVQFZuRsLM/MemFFQDSVe5KEgEhVJF8IFKIoI60WGJ8ElcCAcuS
         78zHqa46nISSwVS7alGcIDC5qybp0Ig5o17gElBsT809ceTTU1TPpGcAE14cn7v4UKOY
         r/NoDe13G2Z/0EgKkKiRxPZc69ehUZ7xZEWN10ISzlqRyELgHgbUnjKWx4O7jBcxKtZU
         xLv7jm648UQgdudqwZ8y/Xa/MIp7fX7alTyMS3XOPSjgniw0zLRSTjO333b0hBJ1WN/0
         CC6EohBHgql/mzTnP07ARpwkGyFEakqe/8aOnknEqEgTzaYkAH8lqq2xx6UCPwqqQZ6f
         9Hcg==
X-Gm-Message-State: ANoB5pksy11zA+zfTXHfz5lHk4GBVLDJjkFh3EkRlAXfveH+5ZcaCskt
        6h1zurQhWwMU9imEqHV63/Y=
X-Google-Smtp-Source: AA0mqf6/FyQ5WmB597b5JSXc5L+Ov3fi7K3xXst75oUpGs2S8vauPO5uLf5krdfA5+X+Ciw5oeqhPQ==
X-Received: by 2002:a17:906:86c9:b0:78d:9324:6f18 with SMTP id j9-20020a17090686c900b0078d93246f18mr23171607ejy.664.1669190344265;
        Tue, 22 Nov 2022 23:59:04 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709061da900b0074136cac2e7sm3742089ejh.81.2022.11.22.23.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 23:59:03 -0800 (PST)
Date:   Wed, 23 Nov 2022 10:59:00 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: imx: remove code for non-existing config
 IMX_GPT_ICAP
Message-ID: <Y33SxLh9xD8fQHAo@kadam>
References: <20221122132330.30408-1-lukas.bulwahn@gmail.com>
 <20221122160937.GB39395@tom-ThinkPad-T14s-Gen-2i>
 <CAKXUXMxk-YoG4TdB8Em+cEMF8NA7rdMAboQz8nmhfVmVQ8oATA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKXUXMxk-YoG4TdB8Em+cEMF8NA7rdMAboQz8nmhfVmVQ8oATA@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 08:56:06AM +0100, Lukas Bulwahn wrote:
> 
> Strangely, my checkpatch invocation on next-20221116 did not show that
> warning and I am unaware that I made any specific changes to
> checkpatch or its configuration.
> 

I think you need to apply the patch and retest with the -f option.

regards,
dan carpenter

