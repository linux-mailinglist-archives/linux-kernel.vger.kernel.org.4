Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77102723FC4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbjFFKiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236775AbjFFKhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:37:14 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E761710F0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 03:36:26 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51480d3e161so8598706a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 03:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1686047785; x=1688639785;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qd8uKMFm81vYRFqw2LDxc+4LQWMvwJ/7wVX2rL8bDEE=;
        b=FLE32HTMQXTPXIMgRym716RCPA5ZfaA426svAlixR6NT+JFwFi3wq9dhD5MTfGgcdS
         ydtKJDvXeYGZsCfd+Tpk4F1Ps9V0Sum8jeyo/vtelPtEMQ7X+FOslAzStxiS/F1qBha6
         7lhn3d9cM9dPtUfsVDGrEjsK1NUJDrPtoRc7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686047785; x=1688639785;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qd8uKMFm81vYRFqw2LDxc+4LQWMvwJ/7wVX2rL8bDEE=;
        b=ZgAayKYePBpQyHhd+JwywVpCnnI2mtDla09G6gp6MeKuH6sxjdrtwzZJzCOHHs2HSw
         Pn0mKkTJPRGX5J8RaIrZbKEzEGDGU7Fg3XgjYk4pdFCdaeyIQukulrlQ9E6aECLD79F3
         BqwtaGjNtpcN/jrBU42aKzrbZ5vtlNuk3SQHZUJnpPYfiX42FX8GC4kipBHXJ7j8vKew
         l+Rf1O7zwLJmuG2zlojHMGpIkbCRRo08EVSEpGelLZbrwz+4xjNeKJfcZKsugyoHD7Ic
         yjuijitPi5rAF4nYc6liZgYveOa2QBuHneY630wCYPyDyIqOXVYhQ+3WByli5YN8kgqU
         uFmQ==
X-Gm-Message-State: AC+VfDx4mnGKHz8Q+nq2sDo+TGSh2vp5RLoWOZN6WH8APJ2Mh2cpUVYO
        7LZc7rcxxS2Yhy1ZyIeIjBq2EXImClHxApuaIidzqA==
X-Google-Smtp-Source: ACHHUZ4DMm4EvB7MjP9b43pG7ppWOQ0n/9PE9z9PAfZkfaEzPc7VW24qLvfbEvgkodbFEfEf9pxMeDTJbxgOCc0lIso=
X-Received: by 2002:a17:907:2d13:b0:974:1e0e:9bd2 with SMTP id
 gs19-20020a1709072d1300b009741e0e9bd2mr2417597ejc.14.1686047785487; Tue, 06
 Jun 2023 03:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <amir73il@gmail.com> <20230506150911.1983249-1-gwj1235@yeah.net>
In-Reply-To: <20230506150911.1983249-1-gwj1235@yeah.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 6 Jun 2023 12:36:14 +0200
Message-ID: <CAJfpegs8HOreFpdVoBq9J5TLxOOPTXQ8BGa17Zg=JvejZdbzng@mail.gmail.com>
Subject: Re: [PATCH v2] overlayfs: clean error handling
To:     wenjun93 <gwj0511@gmail.com>
Cc:     linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        wenjun93 <gwj1235@yeah.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 May 2023 at 17:09, wenjun93 <gwj0511@gmail.com> wrote:
>
> Remove PTR_ERR from unused code path and
> assign error value where it exactly happens.
> This cleans the code and also helps to reduce
> the possibility of incorrect err settings
> when it's set globally and is forgotten to be
> overwrite in custom development.
>
> Signed-off-by: wenjun93 <gwj1235@yeah.net>

Nack.

This is a regularly used pattern across the kernel to unclutter error handling.

If you find a concrete bug, please submit a fix for that.

Thanks,
Miklos
