Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC5D5BB3FA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 23:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiIPVhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 17:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIPVhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 17:37:34 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3560AB42D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 14:37:33 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id m3so13514086eda.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 14:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=tLTAlYfvaHrk+9u9ocXQkz9mEsfCQJ1QT1HsDrR/qyA=;
        b=HDIpKQQIFIpVoPm7Lg42ASPlpBGI3l4UtfkM20xWcRRJZyT1kOuBBmuVb3P72UefuH
         tKsczmGkYRjvD4AlQ0RO44zoKzDRZghdbK7gehjy6zdaqggMUP8aRK9BI9Y+hQ8yfmWw
         80zwWYmaATWOeXqI4vw6hubRMOsufpAiywqqr8ksK0o13ltmZXad4iOBXXxUnnFABLdm
         v95oOQz2HeWXGRJSut10Th3bk+0lJG7XVnZlO3qK7qP1cDGVmsO2SX5cMCwf5U2FGzgX
         FxiZl1BJfT111k6wEJNx0tf95ALcHy1ViCVCsIvmdur5wj/X5zRH8d4XlGwijmWARZCl
         Jaow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=tLTAlYfvaHrk+9u9ocXQkz9mEsfCQJ1QT1HsDrR/qyA=;
        b=2JXzbFZ0AdWIFi2ysBUjDU1HyQbvY6S6iVnYMmUWFvF7Oikg/Qo4Hrrn9mXC2sTc2i
         8CBIqLVe2SZkwAFRIbUBqyNF3Gws/9WcWr20tUivjfoaX9OHXIfy3k3Bya5mwWVGfsmD
         BDWRMNKdcCv+qN6UvqgdrEC8kxiFXXqaNPhFLh0Wb4K5K1lcghnkL2MejDXWwkRbnUmO
         kEaUSoD84/5db0dyNThmDBBxSJRvfk4YOMEcX9GLX/CqSAWJM00as7zb7SLzp3VGO0B0
         Ircovi3EtUvhYUZmD9POmK7wuAEetYYeskJB0hNJf2XEF4B4E2q9tso8L6KdmyjxdIax
         aisA==
X-Gm-Message-State: ACrzQf3cjGxzGA5+KH5H8zmNrJNbDR/PTcJ2T26ZGbdHOq2DHT8pn9oI
        tVy13MV14kHHYN9TeQEM93PAVwpTQMeIyqH6Og4=
X-Google-Smtp-Source: AMsMyM7+1/RqCylb+SR+E0eEju7Na2gTIRMPlPCN4ftGZrHJ9sLjj8gghQBlSg/GYiYUJBs/xaaLZphpCyAsNAim6cY=
X-Received: by 2002:a05:6402:3224:b0:44f:e1ff:8027 with SMTP id
 g36-20020a056402322400b0044fe1ff8027mr5407176eda.284.1663364252302; Fri, 16
 Sep 2022 14:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220829033743.2698606-1-peng.fan@oss.nxp.com> <cee07cc1-4972-df69-0451-1f345c0d16f3@oss.nxp.com>
In-Reply-To: <cee07cc1-4972-df69-0451-1f345c0d16f3@oss.nxp.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Fri, 16 Sep 2022 16:37:20 -0500
Message-ID: <CABb+yY3mDMvPd7jui9cR81y2ut9zHpW8D-0fvaTjYVwCCbw04A@mail.gmail.com>
Subject: Re: [PATCH] mailbox: imx: fix RST channel support
To:     Peng Fan <peng.fan@oss.nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>, Liu Ying <victor.liu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 7:36 PM Peng Fan <peng.fan@oss.nxp.com> wrote:
>
> Hi Jassi,
>
> On 8/29/2022 11:37 AM, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Because IMX_MU_xCR_MAX was increased to 5, some mu cfgs were not updated
> > to include the CR register. Add the missed CR register to xcr array.
> >
> > Fixes: 3d38ac9c40bd ("mailbox: imx: fix RST channel support")
> > Reported-by: Liu Ying <victor.liu@nxp.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
>
Fixes: 3d38ac9c40bd ("mailbox: imx: fix RST channel support")   seems wrong.

-j
