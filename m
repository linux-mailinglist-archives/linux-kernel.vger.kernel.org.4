Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90CC6A3580
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 00:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjBZXHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 18:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjBZXHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 18:07:42 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569F31353C
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 15:07:40 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id h3so4630888lja.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 15:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5x0vQDpxWguEQIXMoOtNR062YwVBVQqRtTi8dw0538=;
        b=e+37hKxoFgCJcsF8oMRhepTAxSEt8aZedQfrEOQdSzxNbFrU/rcd85OjBJWX2f1AKW
         d3Ff3jfZXD24TnCD9j19HGyIo41k8gYv+gHND72hmvEZyxSwcO8ruiU/zWypihPyPJYe
         K6JCVsMeegfR2k3Ahs8wkNR9IQWIoBd9qbYJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5x0vQDpxWguEQIXMoOtNR062YwVBVQqRtTi8dw0538=;
        b=aBrDoV3o4KaSSe9rEs4/ZmqjUQuZmNu0iLdEKwB/pfz4nXwPtyI70JTzPWb2p6xixr
         95zDBsch+eT9eExQ0cF46aJVgTMM3Q1xtrw2sQ7P00/QnhG3QvH5ewbcc8ZAw8xPABdj
         BwpWmWC8g4xj/OGYbQCyRECVog0v7J8Y9szyGFweGgAycG3fFjDXCC1UVWxIzg1oZwe8
         qW3B765BS4zu4YiF8Cw64rDUTHe1cms700rEqePWXEdG5pitnzQ3TUZOo5Y3wBa1aDmx
         ThTZvTo5TcNmQW2gnfKJP87aL3IibMdy8xd30MVDyVL+t0+GKhFeYr7tfFEqaXpY/ULp
         LA9w==
X-Gm-Message-State: AO0yUKXaY6w2m2pgC5XMekRmtZBVe6tWOBtiqrn/9MDUyy1adOhXGiV2
        XUEM5GnPJhWQvNNOSsSicXXZQ0guMcm2D5RwHSy43zauom6HkA==
X-Google-Smtp-Source: AK7set+8UsGBpYY6QUwiYxRipQYljLsgmxgXJrZkOzmONJTh5Pi4Hpd1aUxyRgx7rhliUkyNHfOLwfoqN5d03Qg99J0=
X-Received: by 2002:a2e:8e7c:0:b0:293:2d18:36a0 with SMTP id
 t28-20020a2e8e7c000000b002932d1836a0mr6727596ljk.3.1677452858413; Sun, 26 Feb
 2023 15:07:38 -0800 (PST)
MIME-Version: 1.0
References: <20230225033421.3323164-1-joel@joelfernandes.org> <Y/u2xK8FHwKMsJNh@lothringen>
In-Reply-To: <Y/u2xK8FHwKMsJNh@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 26 Feb 2023 18:07:26 -0500
Message-ID: <CAEXW_YT7v42_AcJfOKDxbXoWxfMkfK1-sU8E=nMiSZTk0b2krA@mail.gmail.com>
Subject: Re: [PATCH RFC v2] rcu: Add a minimum time for marking boot as completed
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 2:45=E2=80=AFPM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> On Sat, Feb 25, 2023 at 03:34:21AM +0000, Joel Fernandes (Google) wrote:
> > On many systems, a great deal of boot happens after the kernel thinks t=
he boot
> > has completed. It is difficult to determine if the system has really bo=
oted
> > from the kernel side.
>
> Is this only about kernel booting? What makes it hard to determine if the
> system has really booted?

Yes, I should probably clarify in the change log. It is more than the
kernel booting, it is all OS userspace code that runs as well during
which the CPU load is high (init spawning new programs such as shells,
daemons setup etc). The kernel does not know when that will complete
per-se. A timer based approach is not ideal, but it does not hurt
either IMHO. In other words, it is a "something better than nothing"
patch which reduces risk of slowness.


Thanks,

 - Joel
