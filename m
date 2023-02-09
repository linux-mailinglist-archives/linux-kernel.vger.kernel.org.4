Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD5A690219
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 09:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjBIIZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 03:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjBIIZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 03:25:54 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CEA4743D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 00:25:48 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id hx15so3982096ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 00:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/bO4j+DLyylB2j1yBXnbUgGYOqqcASTTebqyFZzLo94=;
        b=idKHavRbMjjjPb+RIanWdh0XMTemh77oL+/o2MMQ+7zqp/gkHrp3QD8VTlIeuXj7Yo
         PVLbScyoBNt3RDsIQUJpg8EkDH//COkdTSL5LewF6FpMAUWmwtTv2GLLdTe1hwAJE0WJ
         liBqnvdZN/Ufw2wqKoOXSkIY2cCL+C+iEZfcXMn2tghO184O1s7Pvrm+Wo1YQtT5mTzq
         7OVd21ayIO7hK59HtX93Ip8Ka6cTr88xfnOnRaE+pmKwPOprTnRT2tovbnXqR6EnZXRB
         iIcfBsoZTdS2zjyloy0BCE/tHkQp1gfrO4iTAQkd0PeqjLRBZIDMziGIOvUkxNcxVQvu
         VWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bO4j+DLyylB2j1yBXnbUgGYOqqcASTTebqyFZzLo94=;
        b=loZDGppFLIN8DU3B2zEtyU2F4EuLq+04h24UT8ZLvm9Gc2Rypwp2RKDM7JuPbOX57d
         ccTkZUc+sP/KCcYfGhEppsFd6lF1S2psJBRo7oMzj6eUhbLrlmySHnxsY00SXaeybYOl
         CdSeXiepQIMEfoXX9XO72v66hafHqXzuXv7fT1/rfs3XgzmIMBUtCR2KcK8H5ZI+2H16
         to03rAywbY7rDyEIfD5xVwbxe0iYXDFLNV6+jmIVBZnS6wd2qaM1yjPDQmKcxmexPfnz
         oYH0meneBU9DrvzyQ6fBDalfnF+IGBAWnlgHkuxw7ecry96PX2wh/da+CQJDDLZ2QMdE
         y8mg==
X-Gm-Message-State: AO0yUKUMblwDwe7q+oHeIK1CeNTU3LsBtzcWeqtNylovXJIsvXWoCpSb
        qAXfrVHIbY/IR73jse58XoB7Ig==
X-Google-Smtp-Source: AK7set8MvS+Zy+7bdl3fs/gQOS0hATDzzETiqnxAJHoM4rgsnMey8ZXwSeefsKK5PSw8wYO7JSU1mg==
X-Received: by 2002:a17:906:4408:b0:78d:f456:1ed0 with SMTP id x8-20020a170906440800b0078df4561ed0mr7073998ejo.33.1675931147216;
        Thu, 09 Feb 2023 00:25:47 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id g22-20020a170906199600b0087bd629e9e4sm558406ejd.179.2023.02.09.00.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 00:25:46 -0800 (PST)
Date:   Thu, 9 Feb 2023 09:25:45 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@rivosinc.com, conor@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH 2/2] RISC-V: improve string-function assembly
Message-ID: <20230209082545.bzqpx5hci6cyq6us@orel>
References: <20230208225328.1636017-1-heiko@sntech.de>
 <20230208225328.1636017-3-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208225328.1636017-3-heiko@sntech.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 11:53:28PM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> 
> Adapt the suggestions for the assembly string functions that Andrew
> suggested but that I didn't manage to include into the series that
> got applied.
> 
> This includes improvements to two comments, removal of unneeded labels
> and moving one instruction slightly higher to contradict an
> explanatory comment.
> 
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> ---
>  arch/riscv/lib/strcmp.S  |  6 ++++--
>  arch/riscv/lib/strlen.S  | 10 +++++-----
>  arch/riscv/lib/strncmp.S | 16 +++++++---------
>  3 files changed, 16 insertions(+), 16 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
