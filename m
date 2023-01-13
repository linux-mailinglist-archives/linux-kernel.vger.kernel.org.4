Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EC46698CA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240363AbjAMNix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241720AbjAMNiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:38:06 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6F93E0C9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:32:13 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-4bf16baa865so283440067b3.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=No+5RPSlt/2AA9DS36alYfiIviplsrD4U7z1/DjK3kw=;
        b=VJodeieRVB3/PNGRPY0aEuQS+oK4CIr7AMdUy5heO7OE7pVFTK1A164V81193yuMKY
         o0oUSJN0YXwRO9v+Ezx7Gqn/ryTWa//kwbqXH3tngvFiYZGyvgx8YIiykr/aNB1DW48e
         N0GbzuKPFr92tZyDVjjUmcOMVYyyySKxOlloYTGTinRJW/jHY6W1Ks5OY2dsvq2+RNlC
         zByCYr+/SoxFMEY29qhMwONLMsOUIXHsGRC0yYIZO6xlP9PwBZYL/QzSCItRcijl/ECw
         d67/fCqKvUg15ic9ZBUdQDMG1O2qlcwbgzC0LiRIPvIv+3nnIOosPA/oyQqI12S6iRlD
         98PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=No+5RPSlt/2AA9DS36alYfiIviplsrD4U7z1/DjK3kw=;
        b=5Qqj8272dLz+EuUDkWmCwh4NqnQGIbEdeodSTix1oEslnRPsARtvmfLGi2dvUI950u
         Blg8xb7X4tH2egPL0FAxmjRKJXzssOI4zDhBMlg2DOenxjscefnFyJ4NQ/f1enJlKYYy
         lxBcK8nOWlhBaEMpDKSo+VPKk9Q4tT0nSekhWO78PNcnxwAoFlVrfyY1qr1YlNs6OHIU
         WYJQmPmXaq7JrQR/7Gx8DyTsH2ZwhPgrZXwjWF3O52ncyWTNiNno3dY2MNT4Cticp3WQ
         vGRTGT7I/Lo0y4mmti0v8V8FmLSraIbjG44PTCsUJ6guO2l5VCCudGPvjThrWyw6Phu3
         3/Jg==
X-Gm-Message-State: AFqh2kr5r/FtesasCaNdYtSqL+vDCOyfTyPQxW7kC57soa/uEVvk8LJc
        fXZrcp132C1necVMEiNgDWQgxqEBhXBcMWo5uokcnA==
X-Google-Smtp-Source: AMrXdXuSKQsOMei1jTS5XnCajfRHRM/lBu1DeqBAVORpif81/tgq+9lb2f2D2pRAJV8vNH24eG1wgdez+fAcuOgg8ic=
X-Received: by 2002:a81:6d85:0:b0:3f2:e8b7:a6ec with SMTP id
 i127-20020a816d85000000b003f2e8b7a6ecmr2828684ywc.332.1673616732259; Fri, 13
 Jan 2023 05:32:12 -0800 (PST)
MIME-Version: 1.0
References: <f2277af8951a51cfee2fb905af8d7a812b7beaf4.1673616357.git.piergiorgio.beruto@gmail.com>
In-Reply-To: <f2277af8951a51cfee2fb905af8d7a812b7beaf4.1673616357.git.piergiorgio.beruto@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 13 Jan 2023 14:32:01 +0100
Message-ID: <CANn89iJajiWoi4qv6=VvcrgBFhRHFbc7Dy7Mbic+j=gBsWgt3g@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/1] plca.c: fix obvious mistake in checking retval
To:     Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
        mailhol.vincent@wanadoo.fr, sudheer.mogilappagari@intel.com,
        sbhatta@marvell.com, linux-doc@vger.kernel.org,
        wangjie125@huawei.com, corbet@lwn.net, lkp@intel.com,
        gal@nvidia.com, gustavoars@kernel.org, bagasdotme@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 2:26 PM Piergiorgio Beruto
<piergiorgio.beruto@gmail.com> wrote:
>
> Revert a wrong fix that was done during the review process. The
> intention was to substitute "if(ret < 0)" with "if(ret)".
> Unfortunately, the intended fix did not meet the code.
> Besides, after additional review, it was decided that "if(ret < 0)"
> was actually the right thing to do.
>
> Fixes: 8580e16c28f3 ("net/ethtool: add netlink interface for the PLCA RS")
> Signed-off-by: Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Eric Dumazet <edumazet@google.com>
