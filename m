Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8927290D1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjFIHT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238333AbjFIHTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:19:15 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF361734
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 00:19:07 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-bab8f66d3a2so1422677276.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 00:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686295147; x=1688887147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOnQny2umDrk1smK2zGM40DSipRaq+yaONPV/kg+jes=;
        b=Q2ZeCh/kiBwRYajWH6H2lX7Tqx8slH9n01ZbvULiY0+FLiPuy0UPSJwhNF85mtdA1x
         ygo3wjOrWzzqc46K+yMjHp2NLV7Bn9ibwQDIzwXq6p36FJ5UUvViiqMKTI3TCbm/WgLm
         BRSGVf5ZVLN3BWI3oANYPl4um6vbJ5GkR4VcH6zXQb9J3QWntxOWZxnzdnmzekg5L1WX
         JAj2VbzGsI9BBF9TuBr5fLckF26aAKBjC8B722yhWwbd4SnK9mvZxMmXYzSxd79v61xU
         9EBXJIALhm26kekKS/SsP2lzptr6n8kXpUxLDrSFlSDZt0K18XMqxwj/pNVuQFXYW8L2
         NhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686295147; x=1688887147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOnQny2umDrk1smK2zGM40DSipRaq+yaONPV/kg+jes=;
        b=lvv06ODoN44I8c75emmBH3NReCyGTjcbNXYJIuKd6GSlSEoV1Xxo3vuoFLzp3w1Zub
         3boKgbFTTPqRL4j8DtGBcEHtO2nPvvPUd36Gf6VncmrK096czxuxI5pNV2COKLG8ZgMF
         qXjatLbHXRkLw6/1M9BMcJvskiUuQ8YRsPxMAC9+slERQM64UYN+9ilBNTKeFCbKbjJt
         TmQLIiEFlltUE2GH7a9wN3odOzOjwH9O/I0OEO7w73O88pBM9GQlbudtibY7pHm1woPt
         DcCp8KY79Qpq1MFNzZKyXXWqyLOpClqIUQ44pwC8IQofeWtkqNvsMfXgjIbSl3PDO+rK
         xMNQ==
X-Gm-Message-State: AC+VfDxqpendYL20n75cOEdMHHFUuX2vj0ydDCdwyeS+Agp7/LHC91L7
        gO8bA7esGvvhDxrlZBBHlkca59rJ7yDh3WpF4vwv/e5mMMWk10Si
X-Google-Smtp-Source: ACHHUZ5/A4sqbElurOLrxvngAAGU5+a732xM1IRjBEuxN/qGJstSrqSESlmH+Vfwt26rChyYHG+EOPw3RPZeMqTtKt0=
X-Received: by 2002:a25:2509:0:b0:bb8:9a96:3e05 with SMTP id
 l9-20020a252509000000b00bb89a963e05mr258713ybl.48.1686295146827; Fri, 09 Jun
 2023 00:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230606071717.8088-1-pshete@nvidia.com>
In-Reply-To: <20230606071717.8088-1-pshete@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Jun 2023 09:18:55 +0200
Message-ID: <CACRpkda_FjWO6SEW_upvZhYxc1=SzMgrfBXwDmVnYJCG+XJZyA@mail.gmail.com>
Subject: Re: [PATCH] gpio: tegra186: Check PMC driver status before any request
To:     Prathamesh Shete <pshete@nvidia.com>
Cc:     brgl@bgdev.pl, thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, smangipudi@nvidia.com,
        Manish Bhardwaj <mbhardwaj@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023 at 9:17=E2=80=AFAM Prathamesh Shete <pshete@nvidia.com>=
 wrote:

> This patch fixes the issue where even if PMC driver status is
> disabled still we are trying to look up for the IRQ domain
> that PMC driver would've registered if it had been enabled.
>
> Signed-off-by: Manish Bhardwaj <mbhardwaj@nvidia.com>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>

Patch applied!

Yours,
Linus Walleij
