Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81F374E494
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 04:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjGKC6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 22:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjGKC6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 22:58:45 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE96FB;
        Mon, 10 Jul 2023 19:58:44 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51e5672d580so2791358a12.2;
        Mon, 10 Jul 2023 19:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689044323; x=1691636323;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rnYEIRHhki4Z3XM7hs+JBMiBd6mstq8jdoxe7LOSGFQ=;
        b=VekpqBoZS2Qca14fLYlmvzRoWQTI3Nq4Lm5SJY+hPouul3WcRhRXPRcosC2fsCLxcW
         dHToZzSgyjGW+0wG6WeYhWm+fTq7ie5KLIewI3Z1ogRZNoJb2PqftG56+zYBesXTpCyf
         hnuNE88llhmEKFkLy4/SGIaaEwfW9a0FAaluNHcJ56aOM7pxPsbEuo7VWPZ+9T/Snxyu
         sfXq7lPM0dELlLV3HCtXzkD0JUGL4wM3TpMgzkbTGgLUZxIO52miWXymDw1f5yRcMdlB
         RD1QIOujuM7lPOfjHthpXX+ttPi0wjISBqV2Lim650CQQTLQYlsLZVp2TTT+tig6gU0x
         Q6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689044323; x=1691636323;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rnYEIRHhki4Z3XM7hs+JBMiBd6mstq8jdoxe7LOSGFQ=;
        b=HDiPhg7bS7hlKmOnexPFsZSOdBbH9UClZEt6oUweBKPJ6MJ9EkC5YbRt/ordAPM7pC
         JDQXrCb3zI0eNg3HS4Km2+VpTmNekNyBupoG9FCo51COaTbviMDUE1yVDk84934l0Y9z
         OjLCkC1D1LUoDf7JnVbapRQuc1odeRvcCRi1MQL5pxDq4WmF4EVr7Cm1ywxRe1epGFiI
         K2JmxgjYN8zpnxVWFqMzF7KpbH96uVF1rKYx9ADTPwkm+bB4yGMsNQyFoIu/4kHPwxjD
         MU7P1IZWaRO4G9PIBMrAsjbg6hwPGbelWtrb+ULwASz/Vg1gNLKv7ptSNV9Weli4ZL0M
         R9xQ==
X-Gm-Message-State: ABy/qLZ6cffyoMhcl1ih0E7aKMi3Qu/1HPn5umMUCjr6GM5v4zlSXkdj
        EI6PFjvLJoRuHnLaMDhOEO+gXhQFhx2cnsmlsAU=
X-Google-Smtp-Source: APBJJlFKkdSihijox66hoIkTD9lkC3ZDgUccwc32wqaOfQzfWm+6KthANN4nducSyEVv/L2Epkdf3f9yfNM1vy5yxvU=
X-Received: by 2002:aa7:d6ce:0:b0:51e:1a47:3e3a with SMTP id
 x14-20020aa7d6ce000000b0051e1a473e3amr14094578edr.18.1689044322647; Mon, 10
 Jul 2023 19:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230710080348.4137875-2-chunyan.zhang@unisoc.com> <69d56da8-9530-e729-d527-89879d2bab06@web.de>
In-Reply-To: <69d56da8-9530-e729-d527-89879d2bab06@web.de>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 11 Jul 2023 10:58:05 +0800
Message-ID: <CAAfSe-sQ2xeSUCwsWW2OJn7t9a9YUsE00O20BLvah1JnV7yP8Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] serial: sprd: Fix DMA buffer leak issue
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023 at 19:36, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> > Release DMA buffer when _probe() returns fail to avoid memory leak.
>
> I would appreciate if this change description can be improved another bit.
>

I will try my best.

>
> Will a cover letter become helpful also for the presented small patch series?

These two patches are all fixes and describe the details in each,
that's why I didn't write a cover letter which I don't think can
provide more useful information.

Thanks for your review,
Chunyan

>
> Regards,
> Markus
