Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA8C67208E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjARPHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjARPHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:07:24 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806DB3C21
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:07:23 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id 3so36015055vsq.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C8wyUQXeegRLF3CuYjsfzh5QAgXDnILh78T7CIz6G4s=;
        b=mOEc+THH3zT9L2WiC02QNm4zeY1Um5JRy2avTZO4y87DVKj2sBsz8+qZ1lMyR8CCVy
         9BkRO9J7IQ73de0qb8ppWkmpkWfN/2zMyeWDSMQ+Ej2ZVMPaT4GKFF374OdHJJ1v9i3t
         2+JuddVGOB2bUclkYEovh9lngTJN9MsvBYSQqVdlD38u8l+Q2UwGgTXMVIYa7HifZYHt
         v1yk442Cga29dvZryyV9pOk5H0BYQnSXQLEMZpXIWd+QIuUpVlBGzuB3nv1I9gxzyAml
         u7qsPAnAVRTOa7FBesy5z1QTXf2p7NFNVD++gbemYkHnpDk0UoTXT+kbbpzAo+G/TACS
         k51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C8wyUQXeegRLF3CuYjsfzh5QAgXDnILh78T7CIz6G4s=;
        b=nyPkr4oFktYyXJzQHFPThFSPNT9E1g6T396LKh6FfCUHr3DeaUge1xBiatRX42IUVj
         IMLwitYKDkF8eqEJpLnhoqaxY3IEoWH7Gc4613Ts10VRdeNSjadqbwwhQyNH9rWUzIV+
         eTSTJCD0vOLXCpQ7lVFf5sfSVR1QXYQYUJYjnMWkT4B1Rs0dkiQKWgsvBg4fSQ6MlfQF
         edDQpNP+Aslyfu0J5KhNopAh1lnEI3StIqA5zJzdWNdoOrNfhMrv+UzDvHMdoFIAy7CY
         ZL9/7TYGKJfyjwL8I7du6HqoAGQeqKFCPql2MBcIJODc26TQ2jO2Q11lppAyp4js5tTu
         2YjQ==
X-Gm-Message-State: AFqh2kpgMjyqAKYSs+9uIjDE9CfiaMu5ViKo/o+boZSpAVoczJftQ5Z1
        nv+jqPbOAC5GrulBwzM3ccq55+dfA9dzbPmKpx6zexGFxhnvcQ==
X-Google-Smtp-Source: AMrXdXsHb+tGKpWdSSf463JrNN2O0LaBnWELi296lJmMtCCVOKE2FWiOCt1XJ35HbQ777p3fpErRvSty/Yc9trCHk5A=
X-Received: by 2002:a67:c387:0:b0:3d2:3577:2d05 with SMTP id
 s7-20020a67c387000000b003d235772d05mr912178vsj.9.1674054442628; Wed, 18 Jan
 2023 07:07:22 -0800 (PST)
MIME-Version: 1.0
References: <20221229160045.535778-1-brgl@bgdev.pl> <20221229160045.535778-3-brgl@bgdev.pl>
 <20230118145914.3012-1-hdanton@sina.com>
In-Reply-To: <20230118145914.3012-1-hdanton@sina.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 18 Jan 2023 16:07:11 +0100
Message-ID: <CAMRc=MfEt50RE3KWE5_4g509bbUgZcCrtEFvikskuKYaGLQU0w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] i2c: dev: don't allow user-space to deadlock the kernel
To:     Hillf Danton <hdanton@sina.com>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 3:59 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On Thu, 29 Dec 2022 17:00:45 +0100 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > @@ -44,8 +45,14 @@ struct i2c_dev {
> >       struct i2c_adapter *adap;
> >       struct device dev;
> >       struct cdev cdev;
> > +     struct rw_semaphore sem;
>
>         int                     state;
> #define STATE_RELEASED 1
> #define STATE_DETACHED 2
> >  };
>
> Because syscalls like read, write and ioctl have completed upon release,
> serializing the release and detach pathes is a cure to the issue.
>

Please elaborate because I have no idea what you mean by that.

Bart
