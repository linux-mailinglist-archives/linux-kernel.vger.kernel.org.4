Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE9263C1C0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbiK2OES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbiK2ODz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:03:55 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46155987F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:03:51 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id j12so13485923plj.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Z+IcAbiLKvMQ/ifv4+wjr02j49KjulQRaKardeM4iU=;
        b=X1JUWSnB7jN8UPlhMUWuSe9NpQEFdBjqsTqKXathiY/4oPl8zKvNucEHGkEgR9ZFXa
         tMiTC/FsrpGedTA+VoPnC4VAKpHEUtRp+pUf6M97UNTDiMIM/aewUVPewHH1Qz7Zqtuw
         A/6d+S/wQYqFih/kPWM/X7NOPhGr5G5OvIUnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Z+IcAbiLKvMQ/ifv4+wjr02j49KjulQRaKardeM4iU=;
        b=Mi2lntLRVwdwAaksLGUzrn0W+joRfeipRBPwkYgQizxDk7V6TiHrQUw8DXN+5izWYz
         4AxSxatxG4j9UMvA4UI8h1vfGxsWv18p5y9xOl+E/o0l+gFY4Bh9Eyoe2WDqmL5LXerW
         DViHQmfODZb9sDcFDJyh9mRF+8jEesSyrgzoGojUq7GjkHqLLxBJ5I69JtKOMNAOHIJ6
         iXzoMNFYtBbu3Djr9Bz82/P/+cLgCwb1LJcwHsV1utOkNVAe+ErdSnFboVda9TQe5sFt
         K07DAPnoalGvgjE00SbB6is6wmKuYdqDtyIK/PkWDfZ4AA6YaVz+0qdKIWg3DFgBGkBe
         wnfA==
X-Gm-Message-State: ANoB5pkteFcZF6SOuILh7xZbrzB6qfx5u6Xa4iDamVmhvG5HUU2xvYZy
        kK1tfRIBIfjURLLu7za9VSQXYA==
X-Google-Smtp-Source: AA0mqf5G8dhoxdxdsNqbby49Z8R+DLxiw0BqTOB6vLWUPI74ZphiFYIDUsml1Fzl8YwZUOYfcWenCg==
X-Received: by 2002:a17:90a:990d:b0:212:d909:a41e with SMTP id b13-20020a17090a990d00b00212d909a41emr18042535pjp.48.1669730631347;
        Tue, 29 Nov 2022 06:03:51 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:9a17:1728:aa10:47a1])
        by smtp.gmail.com with ESMTPSA id k2-20020a170902d58200b00179e1f08634sm10864906plh.222.2022.11.29.06.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 06:03:50 -0800 (PST)
Date:   Tue, 29 Nov 2022 23:03:45 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org
Subject: Re: [PATCH v7 4/6] zsmalloc: Add a LRU to zs_pool to keep track of
 zspages in LRU order
Message-ID: <Y4YRQdOd55K7iC+q@google.com>
References: <20221128191616.1261026-1-nphamcs@gmail.com>
 <20221128191616.1261026-5-nphamcs@gmail.com>
 <CAM4kBB+7boz+PZfPODbS-KMGOPZpa2QO5xZMoP2q_ZfGyqmQTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM4kBB+7boz+PZfPODbS-KMGOPZpa2QO5xZMoP2q_ZfGyqmQTA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/29 12:53), Vitaly Wool wrote:
> I think the amount of #ifdefs here becomes absolutely overwhelming.
> Not that zsmalloc code was very readable before, but now it is
> starting to look like a plain disaster.

Presumably most of them will go away once LRU moved from
allocator to upper level.
