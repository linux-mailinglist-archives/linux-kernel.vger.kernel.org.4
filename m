Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E4766999B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241483AbjAMOIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbjAMOHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:07:36 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A5384F82;
        Fri, 13 Jan 2023 06:04:00 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id d13so14850959qvj.8;
        Fri, 13 Jan 2023 06:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SdzFSY2pHRAwVA5rCzxoNBDTeMcD5Rygcime3xuIsUU=;
        b=bP5I1pqeJgWJmQTDpeuZQ27yhv83rCZJOlq8tNy0k3OJ3wlKccgop+31o10/0pUC3z
         rD9+LxSZIbO5s8n0l2KmJ2C0w8E/+tv028QfZXZEobodRoBSvct+8Tt75Y/r0xB6B4l+
         oBTogYdRZYNtvG09pL7uWngOk5Enu7H5zjgW2EAij5CP11TenyJYq21x1MJgf6v12bM7
         iZ/qTmGKxkkqOv2tDF/yw6gHT75K2DdrhoDFPNkIb9wBVJwbrMEF+KOHxKJ5Z9s0ik4D
         7P5gFxV1WRRQ9pXhJ1N8pWSNYPOuFBSLyxUIQ2zh0jssAw4zS3RPh8sHbeF3497xtL+K
         N8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SdzFSY2pHRAwVA5rCzxoNBDTeMcD5Rygcime3xuIsUU=;
        b=qNhXAKSqYFQNtzmdoNa26UlnRvNmk1hss2hfICuDeR0pkyJLrlgZ3Zaxb88YYPQtru
         Y8kN09qh5ptQmUTwCML7zbGRlaG2xiXaYYkLz2g9t5NLbXkWwWfzlOAOmES+rTVQ8UzA
         xVU+rWSw3++BX6ULVvtwLeCQ8uSlrpW1/8kZUCfNBFYJeZ08o4ayz+iIbYqSQWDitixI
         nF73XRxXyS1/ktQMCsLnep8cY7CZ/i5p+1FK5+pDyUqTdtGl1gj5ILls4mbokWaLOkZX
         cc8BTwM/Z0z0bJE3RjCnK+FoQoYS11VXSn69i2ezxw/FQSrA9IOJi25BqDkJL/p2i268
         5/Ow==
X-Gm-Message-State: AFqh2kqekCOuCyvn9UPnKowf3yAe7zeuQG+56stfSXIxtr5qeqftmA6I
        fsd9ksrFSSh/qLzQLHHNfS1WSULk5grrULuCa0HJL0A3rM8=
X-Google-Smtp-Source: AMrXdXtHldmOYFGNtG1bf70ouXk1Xb/h1Zq0MuhVrgbtceYEpeFlUxQCthXgaDT9pxwzOkA/fu2MiGHjNBuY29s9anQ=
X-Received: by 2002:ad4:5107:0:b0:534:3c7d:97fc with SMTP id
 g7-20020ad45107000000b005343c7d97fcmr353266qvp.11.1673618638533; Fri, 13 Jan
 2023 06:03:58 -0800 (PST)
MIME-Version: 1.0
References: <20230113133320.7531-1-abelova@astralinux.ru>
In-Reply-To: <20230113133320.7531-1-abelova@astralinux.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 13 Jan 2023 16:03:22 +0200
Message-ID: <CAHp75VfwMWQfZ49+OZU7wBCY8omFsm+u6_oy6Q2Dsxh4X-j-6g@mail.gmail.com>
Subject: Re: [PATCH] iio: chemical: scd30: Add check for NULL in scd30_i2c_command
To:     Anastasia Belova <abelova@astralinux.ru>
Cc:     Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
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

On Fri, Jan 13, 2023 at 3:33 PM Anastasia Belova <abelova@astralinux.ru> wrote:
>
> Check rsp for NULL-pointer before dereferencing.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

NAK.

-- 
With Best Regards,
Andy Shevchenko
