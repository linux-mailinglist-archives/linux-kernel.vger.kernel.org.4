Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAF865883A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 02:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiL2BF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 20:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiL2BF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 20:05:57 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E638164E6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 17:05:55 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id x25-20020a056830115900b00670932eff32so10767695otq.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 17:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DI97Fal4l3a4mIM8YI84buSF/5tfBrhRqOQY8iLVk3E=;
        b=WqJKhSzKCXSTIHOKuiqnICGlQ2V768y5ujY7ES9xnaetUxtaPIuRXmxyn5GTOLvmTs
         euOlBGNJOZFuXWJ5g4/zVDcXwYQ8NEHH5Y1H/tzKv3KR4GxDz0fAKssXzWZcgdr9kExT
         shynMeJfaJDToL3VS47mBGrKou5KObWIRy45vdjkHq61RMWw7xu5/GvS8NxbWs9Fy0tB
         nOJ6r/glZYIMdiX+J89429YRQwVwejnkCPqQ6HSK5pAOozgvqy87YktKyf4sJSVR6Lj6
         mVufRsTvOajl8TszrvC5WGdTPPLESJPZt0H+38QzfbD463xQ5BtUTZWLmKDc+ESkVc+u
         oCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DI97Fal4l3a4mIM8YI84buSF/5tfBrhRqOQY8iLVk3E=;
        b=C1DUVh5FykXmu+m5lz1E1G93UODfCEaay2cDaaGLv/0BPzTxW3xEGL0F/PaVbht4lp
         UozSnakFT3xGE3m6nnaMApexGj68qI7qf6hnDmI9VF6D6Dvq/eymmyNEQUdPoULTnx8O
         WJWyZjO5k4YP6lFseFA1sMdPdaOER1nmUyGf88PmP+Mi6EsSnui8K4LIYElCHJn9EoZm
         jy5iwX+jjhqsIU0Wr2k3TIOq17kZPgBu1Gi03SF1YEnr8dvun+Wrl1Ug3HXakjrM4MS9
         0FUZnkhjOUWBhiYKGi//75WxuSJfzY7LTNZABgGHAOMsL4FrtApHQvF0qZeBneOVxgKQ
         qk1g==
X-Gm-Message-State: AFqh2kq6Zh8NHBMclg57x0hMbro68+ByIqIiobsTyM7GDJSk+XmnyQXX
        sfabOc7Iov8FNaWTDZY44rT4QeW7qN3ygNDPG/S2Kw==
X-Google-Smtp-Source: AMrXdXuGricZfodTWWI6d98OVmw8h2ZdLRjQGI7lbMkCdFb3YcjCj9osLbpVJFSaqd6O0uA58CabL8j33av6dEorlaI=
X-Received: by 2002:a05:6830:3499:b0:66c:61c8:ceeb with SMTP id
 c25-20020a056830349900b0066c61c8ceebmr1795675otu.12.1672275955280; Wed, 28
 Dec 2022 17:05:55 -0800 (PST)
MIME-Version: 1.0
References: <20221215092128.3954-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20221215092128.3954-1-lukas.bulwahn@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 29 Dec 2022 02:07:49 +0100
Message-ID: <CACRpkdZyPP-wSuWLiKfhpnoQna-3_P1vjT_i7Rty3xGCq83nsQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mxs: avoid defines prefixed with CONFIG
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 10:30 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Defines prefixed with "CONFIG" should be limited to proper Kconfig options,
> that are introduced in a Kconfig file.
>
> Here, expressions to convert pin configurations to booleans for pull-up,
> voltage and mA are macro definitions that begin with "CONFIG".
>
> To avoid defines prefixed with "CONFIG", rename these defines to begin with
> "PIN_CONFIG" instead.
>
> No functional change.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Patch applied.

Yours,
Linus Walleij
