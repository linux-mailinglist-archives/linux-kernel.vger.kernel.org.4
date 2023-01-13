Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB6D668932
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 02:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240644AbjAMBeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 20:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236952AbjAMBeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 20:34:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790345D6B7;
        Thu, 12 Jan 2023 17:34:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13F18621F2;
        Fri, 13 Jan 2023 01:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74AFBC43392;
        Fri, 13 Jan 2023 01:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673573644;
        bh=uAe0TW8jOz9f27C1vokHG0MwHUso/UUcKfiQLqjyUXM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HWB70OkY1dWbiil0vmxVHZRR7qX8lsk0a3afiNBl0kddYNCoUwCSq2O2ODNlFFyBx
         2/qTVbVJjj5hDRXMQpZZJQY8CX1aUMymRcoZ6dgOwIerCou9QbUBQcf3P8CsSDEfWr
         /i/s1qeZiiK2eRsqCJmyiYBICi4Ntd5ohHDk9Ftce7jiJQDfUCphRmqA12DNvQW6pv
         Evr9j5cFpCuQO4Ay9SzZ0I5PNoWgQz0gw0zf2pBOZf8sFedjo6WrID70j15XT3/xce
         cmTP4LJU1lh9I7rwuMisR6mZ2oC1VtKyCJMNUQiUO7ZPRYrmc01V6C+WpeBpL7GSqB
         z8tzJNbs7jb/A==
Received: by mail-vk1-f177.google.com with SMTP id b81so9600498vkf.1;
        Thu, 12 Jan 2023 17:34:04 -0800 (PST)
X-Gm-Message-State: AFqh2kqPHBNPd/furJgNlKPuZ2AXwg4WOVnnCPSupjtttX6SCigJ7CYD
        vDUcbfglVUxiNaRygMPL1+9vby2wqka4tdljwg==
X-Google-Smtp-Source: AMrXdXtT6sqwXnMgYU60uSmZrZF/kQL4OdT2OmrnO0NSkThwYepDA6SjGOb+qafRFI1qtJ4dOzJYZbAoA29rFN06NlM=
X-Received: by 2002:a1f:1e50:0:b0:3c1:1c3b:c4d9 with SMTP id
 e77-20020a1f1e50000000b003c11c3bc4d9mr10446237vke.19.1673573643326; Thu, 12
 Jan 2023 17:34:03 -0800 (PST)
MIME-Version: 1.0
References: <20230110233056.3490942-1-michael@walle.cc> <167357352392.592020.6790951746345716129.robh@kernel.org>
In-Reply-To: <167357352392.592020.6790951746345716129.robh@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 12 Jan 2023 19:33:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLN0jd0nT7rC7SBMh2zLsAvGCafknnS_oqJJj+=c1m9pg@mail.gmail.com>
Message-ID: <CAL_JsqLN0jd0nT7rC7SBMh2zLsAvGCafknnS_oqJJj+=c1m9pg@mail.gmail.com>
Subject: Re: [PATCH] of: property: fix #nvmem-cell-cells parsing
To:     Michael Walle <michael@walle.cc>
Cc:     Robert Marko <robimarko@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Peng Fan <peng.fan@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, Aisheng Dong <aisheng.dong@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 7:32 PM Rob Herring <robh@kernel.org> wrote:
>
>
> On Wed, 11 Jan 2023 00:30:56 +0100, Michael Walle wrote:
> > Commit 67b8497f005f ("of: property: make #.*-cells optional for simple
> > props") claims to make the cells-name property optional for simple
> > properties, but changed the code for the wrong property, i.e. for
> > DEFINE_SUFFIX_PROP(). Fix that.
> >
> > Fixes: 67b8497f005f ("of: property: make #.*-cells optional for simple props")
> > Reported-by: Peng Fan <peng.fan@nxp.com>
> > Signed-off-by: Michael Walle <michael@walle.cc>
> > Tested-by: Robert Marko <robimarko@gmail.com>
> > ---
> >  drivers/of/property.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
>
> Applied, thanks!

Or not. 67b8497f005f is not in my tree, so

Acked-by: Rob Herring <robh@kernel.org>
