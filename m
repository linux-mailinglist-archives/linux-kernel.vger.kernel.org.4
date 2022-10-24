Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461EC609D24
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJXIvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiJXIvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:51:07 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47CE4F692
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:51:03 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v27so6276252eda.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=48RogcYAddblRnrwwegwTV8L7KkpXpBRUanF9H4ZX04=;
        b=Mt4BNTviARWRqeEoVFmvLXAErFK2+IHQQ8hrJWYLW4IAjOmj8YOZjI2mcJYnFm9PG7
         B30YYlX0Cip1NK7gxjfWE7B8qymm72JXogMpRH6sD5/QtmK5daJQo03sC5lDDl6hvahp
         ggpMlxtLLPqnbjAYF6cN3yclnYgt2zm2qdRiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=48RogcYAddblRnrwwegwTV8L7KkpXpBRUanF9H4ZX04=;
        b=OoRRjDPIzpWFbFRcIgJNCBk8JM7XpzCADfmcEkVlfLUyjhXa5QZwD+fRS23Bm3hxpk
         CMRmG0h8EuyHBpI0RFPC8FHj928yK0jefrroiYZqwwMVEQnrRNq0pQq76Q3SNI3oSW6N
         3fzOUM6thEZdOmoPwjvWGtp+v1DUVJ14IcTp1LOOUG0w4UnJnMSUrFyVXIO7FyLEXW10
         NU/MH0XecAMRJ7DY47+XiI/nF6j2e6qHmvSpuLYZUGUiSsxTNTOH5v9lT1jisWA8bJAK
         HktzXVzvE0x8sAWWKOtLVE1Wsofpz8+dWVc4c1Mxnb4k9cDXM46UqEIfpylAOQGIK4G9
         jbpg==
X-Gm-Message-State: ACrzQf3RVuUtpgm0w3E4wqmrdImmG89T5Oz+ClW1Mf4HbfNIyQ7fn1+M
        74BvSbIQ+zts4QOpQPpqk7kATUNvbKIOtMebUhfxJQ==
X-Google-Smtp-Source: AMsMyM6iH131rcAchW3ZShlH0w+uAPCPW3uuAwqryut5H5gN8dmdqS5j27qGCV73XiNvasRcqV71S1SQk1ja+nYjvck=
X-Received: by 2002:a05:6402:370c:b0:453:9fab:1b53 with SMTP id
 ek12-20020a056402370c00b004539fab1b53mr30540317edb.28.1666601462322; Mon, 24
 Oct 2022 01:51:02 -0700 (PDT)
MIME-Version: 1.0
References: <166606025456.13363.3829702374064563472.stgit@donald.themaw.net> <166606036215.13363.1288735296954908554.stgit@donald.themaw.net>
In-Reply-To: <166606036215.13363.1288735296954908554.stgit@donald.themaw.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 24 Oct 2022 10:50:51 +0200
Message-ID: <CAJfpegsciAuJD-UAcW3Ns43G5m1G466opq6_Y6RG1G4iVHwcHQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kernfs: dont take i_lock on inode attr read
To:     Ian Kent <raven@themaw.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Minchan Kim <minchan@kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2022 at 04:32, Ian Kent <raven@themaw.net> wrote:
>
> The kernfs write lock is held when the kernfs node inode attributes
> are updated. Therefore, when either kernfs_iop_getattr() or
> kernfs_iop_permission() are called the kernfs node inode attributes
> won't change.
>
> Consequently concurrent kernfs_refresh_inode() calls always copy the
> same values from the kernfs node.
>
> So there's no need to take the inode i_lock to get consistent values
> for generic_fillattr() and generic_permission(), the kernfs read lock
> is sufficient.
>
> Signed-off-by: Ian Kent <raven@themaw.net>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
