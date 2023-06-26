Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E180E73E33E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjFZP0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFZP0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:26:53 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C80D93;
        Mon, 26 Jun 2023 08:26:52 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-793f262b6a9so802110241.1;
        Mon, 26 Jun 2023 08:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687793211; x=1690385211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+89gfXmJ9PSf+Pt2D4c4GX0Uof4aHZCLD/OrH79jSsg=;
        b=AyjaD1eRoHDM50xgpG49ONEAd3ndFMRyHh0H5eO24TVgUJCPnnH4f6Awyv/KHFnBPJ
         thZLmikNpLEsYfzXkKEYVXFFqODOVhj7tOHNuQGoKmCUV5VHKortEVd1UA9lVRz4SVl7
         IZUQSyt3qgzmVnZPVC5S/fpIAABOxwJnEwn9FuURH2ratOjmKDIpYd7co/TPJlkFg+yy
         KoDcjOVoExNJWg5H9vP0ADy4ONVjdJ5q6gOSSu7o+0eKf4IC9lNVzJQ+d1a9TfT2LvpJ
         IGowrBkiM5MQKiFkQC8XTFacFVpF0luaGtl0ilvneRhDX/R7JP1msNJmZqx770MhW+Vx
         dG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687793211; x=1690385211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+89gfXmJ9PSf+Pt2D4c4GX0Uof4aHZCLD/OrH79jSsg=;
        b=SWJhHMsX6xuBtL4MubUfq5JyYOrzDfLh1kTugk7SSm7ZoiDFqLt2wp5qQi7a3/GJ7T
         bOoogb+j0W7J+vP7HYsj5lHIzhGaJG5poiLYK3Tyc6eeLPtUz9EsToW+chgS4Oei3d8c
         vjvexDipWBN12a289J5bOqh4ZxVftDeMMt1ZWmTlELY65l3lpB81x+Zrix5oOsqfHBa4
         AS+h1CFOeA1EagQILV1Hc1kEPnPIsBJghOBQFcr+9XIw1jPSwiT7qgOeObM0cA4vLSy2
         Z4mz9OOuqxLIvaMN1PWm2ENP6H2BKlyIz/s+1/cBy4RUHX8qLqR/VIKE3Yljl4Hwg5A6
         JH9g==
X-Gm-Message-State: AC+VfDy/k9LRbs2l1hW2BZgGv4azOMmpVhdKGvRYamCUIh/8HfGSzhay
        HFHo/91tfs5JOReZfdbI+SCvRB0fjojByJQAayg=
X-Google-Smtp-Source: ACHHUZ4RiG/DTgdfQPbpArWCdIJHV/cY2gZOEQovYMafvPkqF5riXU+HMYmna6zPL3NFxC2PSvt0riUqJEjniWElSfs=
X-Received: by 2002:a67:f15a:0:b0:440:b593:36c7 with SMTP id
 t26-20020a67f15a000000b00440b59336c7mr10567808vsm.34.1687793211326; Mon, 26
 Jun 2023 08:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230621144507.55591-1-jlayton@kernel.org> <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-46-jlayton@kernel.org>
In-Reply-To: <20230621144735.55953-46-jlayton@kernel.org>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Tue, 27 Jun 2023 00:26:34 +0900
Message-ID: <CAKFNMomCU54JHKZxcUFLwci5ntzdD7gTv6JADhg--rLHXCcC+g@mail.gmail.com>
Subject: Re: [PATCH 47/79] nilfs2: switch to new ctime accessors
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 11:48=E2=80=AFPM Jeff Layton wrote:
>
> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nilfs2/dir.c   |  6 +++---
>  fs/nilfs2/inode.c | 12 ++++++------
>  fs/nilfs2/ioctl.c |  2 +-
>  fs/nilfs2/namei.c |  8 ++++----
>  4 files changed, 14 insertions(+), 14 deletions(-)

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

As already mentioned in the s390 patch comment, the implementation of
inode_ctime_set_current() needs to be rewritten to use
inode_ctime_set() instead of inode_set_ctime(), but I agree with this
conversion patch for nilfs2 itself.

Thank you for your efforts.

Ryusuke Konishi
