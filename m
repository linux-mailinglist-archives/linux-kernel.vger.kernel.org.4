Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D6C66A25F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjAMSs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjAMSsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:48:25 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B20327183;
        Fri, 13 Jan 2023 10:48:24 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id d16so6831781qtw.8;
        Fri, 13 Jan 2023 10:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=km2chU6Uz/sy/0UFbCpxcWmUeBDD1WA+yAZkjGgI1Lo=;
        b=SwXdZ/OcjODyj0kahdbYvA6ok6v2hzrOhYo/1Lsijf5KrYh9vH3rGCurdP0CIJTz+E
         fTGvnMACw6sr9xJ1dxnsXkdLyHFXPQJcl54JzKYnpWDq4hKTRlVYFEMwQtSG3+lIAmYW
         038kDrDiDIfNQnN7nzOuvpihuFIA2rFm9JOVY77eypYMJYvBBB8ygoANg/3fTsAq/VIN
         dN90mIJ2PMTnr+0NF6XuxzGeJd23v+vJ1oUn3L6FtGleeQ5xGG4t0LsNcVg5VOpD7wbE
         mPmVaHW3kycRSkYaHQzw3CM9oT2Tdln/gb3NPcGCbZjuI+eduDB2vpFfmtVvTxvqkYsE
         4SQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=km2chU6Uz/sy/0UFbCpxcWmUeBDD1WA+yAZkjGgI1Lo=;
        b=50l9eOPXf81Lqm/864rq+O7edgQEt3qYET5iCK0mEMQWCeGMvp1QpOstRW3rVf4S44
         WKAGsxFSYKQtUOxaCP+GfjESkBVzWHPD//7py7ysKKWTO6fNwzdjWkO4aV+cE3qZZOKG
         1Azz8tFh4CoFUsHv1XxVnjCF5hFjT5hQRB06E6ZJCQ00uAq6Ch/bShNQY6uMTa9soQ7R
         Rw/R3s0GcZVRJ06fXxiF/tQuG0uhPl1S/rWa1T0TZ4zS8FVTV6xRlkOTtrPsFGpmIkCB
         FPT22JDlB0cJw1znL0se7x96HcV+/NGK0XULqCO7lik8KohIdv8q1Bu6YiW6qzsEOWkD
         p3VQ==
X-Gm-Message-State: AFqh2kpFI2AN2SJfnj3Bdwns7YKmKzU74yfl3NJfARqWsat67F2c7ic/
        MDJwLjgMDR2UWr79mYrjTz83IiRqkhGn6ue5OG0=
X-Google-Smtp-Source: AMrXdXtE4oDa+XfbV5WsgM8B+Khqg6/6Rc5E5NQ20g3FwFNJ8nG/ZHMFP+iNLFrJPndbTGCVgZA7YpZh8YwYoMhgKXY=
X-Received: by 2002:ac8:1247:0:b0:3b1:328c:ff11 with SMTP id
 g7-20020ac81247000000b003b1328cff11mr283404qtj.195.1673635703313; Fri, 13 Jan
 2023 10:48:23 -0800 (PST)
MIME-Version: 1.0
References: <20230113133320.7531-1-abelova@astralinux.ru> <c0c7d2d7-648d-feb3-14ea-c2ab3baddfb1@ispras.ru>
In-Reply-To: <c0c7d2d7-648d-feb3-14ea-c2ab3baddfb1@ispras.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 13 Jan 2023 20:47:47 +0200
Message-ID: <CAHp75Vf3SZEFmXoqm8-ynyYq5p8Eme93Da87RbCP5-9hzAzrZg@mail.gmail.com>
Subject: Re: [lvc-project] [PATCH] iio: chemical: scd30: Add check for NULL in scd30_i2c_command
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Anastasia Belova <abelova@astralinux.ru>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        lvc-project@linuxtesting.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
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

On Fri, Jan 13, 2023 at 8:41 PM Alexey Khoroshilov
<khoroshilov@ispras.ru> wrote:
> On 13.01.2023 16:33, Anastasia Belova wrote:

> It seems it is better to put the whole validation loop under if (rsp)
> check.

No. The entire patch is redundant.
The code that calls this function is under the control of the same
driver, so we know how to avoid shooting in our foot.

-- 
With Best Regards,
Andy Shevchenko
