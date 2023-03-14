Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1B46BA179
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 22:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjCNVb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 17:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjCNVb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 17:31:26 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B37453D9E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 14:31:25 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id bi20so1396498wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 14:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678829483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kosGJCuIsihwp7ZxBszW88vqGjIeKCLRbMuquEChy4=;
        b=HUOEJ5wA0yJ5PRwx0qukCBhFgKN2xGPawh/iC/MFtyTHMcrBq/Ekxa4mWByyM71mFd
         GquEWoz0UpyAwyDay9Jxm6qAnoSvkyWQLY4g5DkCxzx4jsQns9O7u1jmHnksoQa2rBgu
         JNEJQjMUhvdHgdKw9GYvWFWoYluzM6HPtLuJZqtItuqHgnuU74mjoOHM3PZnOzaf6Ubb
         zSUMyRu8BzgKsesW8hhKylsYfkA9+KJPlVPSu0HeWXeZFjMeuIg2PCRxf4gy/YpAfZBI
         MggcplOCWEYU+Ji3Gl6sukiPqUQ0RKyDmHftnVjqyAxHf85+fzmrOto6741Ezo2C73V/
         MtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678829483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kosGJCuIsihwp7ZxBszW88vqGjIeKCLRbMuquEChy4=;
        b=thEjmbqmoCH9UXx2uCcqrvIl55MQM4/91nF2MOERa5mWP0cC9qCTF4ShvAGNmoRGpJ
         Igw/pRc6v9wRKx85WUscRaqsp4vL//BvyuCD065WF7ZR0ncAQv5cWrAYtM0iiZN9QAM+
         G+Q/334VVOxGpAYACJW8J1VgG6oLzRYUS2BFYfIPvLVdtmuWPzZF46q9PW4/0ULUgxzW
         WQdMD8VOh9v6Gi+3Q3axRJZlMSCEFJyTQAOMQ6liGmfbuO7HQZp+aIZHXh6J+VbyQgWC
         2iTT1opsGgc3NT3QG5NZZZoWft8XM0yQgWrWYA6lnL3L86h/6qku8+5gbQa46Ll4UY93
         l5ug==
X-Gm-Message-State: AO0yUKU58Q0VDXK1mGWW/h6RBilGMXffkL/m9hHk0GYtVbLAVs2JE+0n
        85FiC/8ZtupkYX1Bjn06nxDGw76RyJtOyw==
X-Google-Smtp-Source: AK7set9BMJIZWSpt2LeZg/JqmFIeOdAsbFqIMnDbl2gMHqQiodypTbMJRPuoI3GhGhoBCBi6tCGY6w==
X-Received: by 2002:a05:600c:4f91:b0:3ed:2c92:9f4f with SMTP id n17-20020a05600c4f9100b003ed2c929f4fmr3277198wmq.10.1678829483291;
        Tue, 14 Mar 2023 14:31:23 -0700 (PDT)
Received: from suse.localnet (host-79-35-102-94.retail.telecomitalia.it. [79.35.102.94])
        by smtp.gmail.com with ESMTPSA id z4-20020adff744000000b002c55de1c72bsm3058708wrp.62.2023.03.14.14.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 14:31:22 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>
Cc:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: initialize timeouts in probe only
Date:   Tue, 14 Mar 2023 22:31:21 +0100
Message-ID: <3376017.mWHT0XuiSF@suse>
In-Reply-To: <ZBDcfNOXmGeN2tlb@aschofie-mobl2>
References: <ZA9mThZ7NyRrQAMX@khadija-virtual-machine> <ZBDcfNOXmGeN2tlb@aschofie-mobl2>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On marted=EC 14 marzo 2023 21:43:40 CET Alison Schofield wrote:
> On Mon, Mar 13, 2023 at 11:07:10PM +0500, Khadija Kamran wrote:
> > Module parameter, read_timeout, can only be set at the loading time. As
> > it can only be modified once, initialize read_timeout once in the probe
> > function.
> > As a result, only use read_timeout as the last argument in
> > wait_event_interruptible_timeout() call.
> >=20
> > Same goes for write_timeout.
> >=20
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > ---
>=20
> Looks like this is [PATCH v5] and needs a changelog.
>
Alison,

In fact, this is only the second patch that addresses Greg's suggested=20
refactoring.=20

Khadija moved from v3 of "staging: axis-fifo: remove tabs to align argument=
s"=20
to v4 of this completely independent patch. And then back to v1, because (a=
t=20
the time of v4) I pointed out to her that she had started working on a proj=
ect=20
that has a completely different purpose than the previous one.

The best course of action would have been to ask Greg to drop the previous=
=20
patches and then reset the numbering of the new job to v1. Unfortunately I =
did=20
not pay attention to how she then managed the numbering following my=20
observation.

What would be the best course of action at this point?

=46abio


