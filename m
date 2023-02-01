Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8573C686A72
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjBAPeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjBAPeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:34:09 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383682A14A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:33:58 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id qw12so36609422ejc.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 07:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FDt/fXK3xlImEm4AnpyFiZiyZ5/aLHdhtcx/5MB1rdc=;
        b=dUVu1E4hy8GExcS4r0+MaGM3+umrVVMfZLXrIkD0uIAiIKI2c+sY+YPjOCq09+Agwo
         VeLFI9bF8IjVe3myHp58Zvy42dlyosUainAo0IJbKfem7JsPlDZvncycoOeuD/tgFEKN
         rGXpJtx1rMBZ95T+ZKOKiakopFThF8HB/WbDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDt/fXK3xlImEm4AnpyFiZiyZ5/aLHdhtcx/5MB1rdc=;
        b=i2ZpE4ZgPZRScq2rWhgVjcOaRRA/VWQdVhUUHjPkfp4DNWbJ6VKS66Fdp+GxO6FxZ5
         Iz43owokpmkYih/NaKl1Gb/Cy0c5H0IEPTNH34CjKqWd6t4Xz7slmEcqCdhrYrObkm00
         VnSsH2G/bt/ys9GH8rTbgqAVmeolf3Kq+nmcC2zCzXWw4m84phogRZZ5Uef/nUQjVImt
         4wrV75GApfMbG33jT0BQhe0vJ75cXu/T3USzGTveOOfYgtJT3965sFZC6zxvw4S32uj2
         /Rx9/rV/tMxalPPOyERnSSzDEy1S3xPvhjUKJLCuAgZdUf/CmdlUmsyPpwY2XpiTeWJB
         +8NQ==
X-Gm-Message-State: AO0yUKUxwcDJAg7g5Cy7wlx7HOvDThvleo65rRgVXvkcpE+0HN65AsGH
        3I1ejuwmF6ain5faflivbRGJ5xsglZ/FGWb+dv2ylQ==
X-Google-Smtp-Source: AK7set85fgyjXCJs6yqaaGT+Y1bXaa6IOeamyPGpgzCszz6TU8+O1Y+mr32yKdHRCVaKuIKkoP0EEeZJlI2yIiCRwYM=
X-Received: by 2002:a17:906:c411:b0:887:7d91:d016 with SMTP id
 u17-20020a170906c41100b008877d91d016mr803397ejz.110.1675265636832; Wed, 01
 Feb 2023 07:33:56 -0800 (PST)
MIME-Version: 1.0
References: <20221213115147.26629-1-zyfjeff@linux.alibaba.com>
In-Reply-To: <20221213115147.26629-1-zyfjeff@linux.alibaba.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 1 Feb 2023 16:33:45 +0100
Message-ID: <CAJfpegvuwrAszXF31hy_6L92opE-TZef-km6HiMvU0Cf4krFXA@mail.gmail.com>
Subject: Re: [PATCH] fuse: remove duplicate check for nodeid
To:     zyfjeff <zyfjeff@linux.alibaba.com>
Cc:     linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2022 at 12:52, zyfjeff <zyfjeff@linux.alibaba.com> wrote:
>
> before this check, the nodeid has already been checked once, so
> the check here doesn't make an sense, so remove the check for
> nodeid here.
>
>             if (err || !outarg->nodeid)
>                     goto out_put_forget;
>
>             err = -EIO;
>     >>>     if (!outarg->nodeid)
>                     goto out_put_forget;
>
> Signed-off-by: zyfjeff <zyfjeff@linux.alibaba.com>

Applied, thanks.

Miklos
