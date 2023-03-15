Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C306BBBBE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjCOSML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjCOSMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:12:09 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812B064236
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:12:08 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id op8so17190796qvb.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1678903927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PS5OB3AO5CNPuv7NYq4FqsiUlkdNQVwkaY5HT7lJGkE=;
        b=bFcK1BVVp+Fpmx62ppND1CCgS30Nof0np8KQcOy5IwENwvc4ZHxk6oVKnu01TssBc4
         Y3CuOpANJjRF+ciAo6WX0LrExb3onjgODmH2L23lV7cHe7h31wGOFQw5Q1+Bj+VEx8Mb
         etj6Y18ekY2Rcl9UUtQMUnwgoacI2SzmSETf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678903927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PS5OB3AO5CNPuv7NYq4FqsiUlkdNQVwkaY5HT7lJGkE=;
        b=gRlChiJdpQ0mdIAVDMQblBAzzol4kBc4TC/y2kNvnV9sYDPt0cHD/PnWzuAfJF8mD+
         ubWIaLO3AnhgMqfMeiryo1LIfEGR9dQIe3HJzfJThDTj1y/NECcGrRgxOmyAzJIM7gDt
         FRu0rL8ukoMJqsvXHMfhpR58zyJC19/DeeSVuHhIgghS7tk3uE5fl8PUdZ1CYBQN72Dr
         dQ7Sare/urI0d1I+M2cBnjJukxUdlmG4oc/+P5yIVXAEofvH2vABMwrja4nA3bNfja9f
         LUiLpzxDC39ZMpdYJFiSS0UjrZF4Wxq2K1/4mSfV9PWkIGBtL7uL2d8AXJj617lfK18z
         1T9w==
X-Gm-Message-State: AO0yUKXocwfZqFtIoiF53T8g53E4iT0z1K/cnnPaR3i09C0S7oLQiavX
        fXMUDATmarRUrHVZ6ZPl183W/g==
X-Google-Smtp-Source: AK7set9rrNpfb0/qEWxFOnB6R5Sm+ReQx329l+TzH4ao5UaiZyCVwdLD9M7+YcA+iA9IRzAmUxnvDg==
X-Received: by 2002:a05:6214:130b:b0:5a3:79cd:8ef7 with SMTP id pn11-20020a056214130b00b005a379cd8ef7mr27365952qvb.23.1678903927652;
        Wed, 15 Mar 2023 11:12:07 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-7.dsl.bell.ca. [209.226.106.7])
        by smtp.gmail.com with ESMTPSA id a20-20020a05622a065400b003bfd8e2ab40sm4299551qtb.16.2023.03.15.11.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 11:12:07 -0700 (PDT)
Date:   Wed, 15 Mar 2023 14:12:05 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Kai =?utf-8?Q?Wasserb=C3=A4ch?= <kai@dev.carbon-project.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        mptcp@lists.linux.dev
Subject: Re: [PATCH 1/2] docs: process: allow Closes tags with links
Message-ID: <20230315181205.f3av7h6owqzzw64p@meerkat.local>
References: <20230314-doc-checkpatch-closes-tag-v1-0-1b83072e9a9a@tessares.net>
 <20230314-doc-checkpatch-closes-tag-v1-1-1b83072e9a9a@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230314-doc-checkpatch-closes-tag-v1-1-1b83072e9a9a@tessares.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 06:44:56PM +0100, Matthieu Baerts wrote:
> Note that thanks to this "Closes" tag, the mentioned bug trackers can
> also locate where a patch has been applied in different branches and
> repositories. If only the "Link" tag is used, the tracking can also be
> done but the ticket will not be closed and a manual operation will be
> needed.

We will soon gain this ability on bugzilla.kernel.org as one of the features
of the bugbot integration tool (which is still WIP). So, if it helps, I
support making this a recognized trailer.

Acked-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

-K
