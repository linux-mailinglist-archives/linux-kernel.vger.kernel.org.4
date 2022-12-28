Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7670C6571AD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbiL1Bmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiL1Bme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:42:34 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541E1DE88
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:42:33 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id 20so1321485plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g6bjfzIsOTMHvB0nO+i4beQ5Ky8CnGEgnwaSzt1eO1w=;
        b=glOWut5AkVu+Koo4rLs/qj4V37l+tRBeeir9MhYk/NSQOecfiGnY5wdlQVhTcZrTjl
         GHhTA+wX6oXi5gfQU3nn+ds7IngrXKA68BHyKgIUgHCPZYmcCbE4h3q/oZ481oEsAbfD
         w/vISmmDIZovcR4wwChoJXpZEojz43H/3Db0CDOSKL4d72S/qmu/LGW3lMt20Uhedqaw
         VydHS0bk9ivcinxJqaEofKrCBVciq0W+koKRjaF3GdyWwni1hTH42OqwWS1qUgDHIdtx
         8RdToxei/XMKx+t+1LedFahihjM4mTRB4h2e5Y8MkjL39pZm/CDltsLXQFAMsRtzwmlj
         L2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g6bjfzIsOTMHvB0nO+i4beQ5Ky8CnGEgnwaSzt1eO1w=;
        b=5Vmts3Hls/dSee9h1wEgRSV9pvTNYf3m9aq7gO1EhTyiMIlZ31BMg+HvrgxRLfWVkv
         O9qY6QCSgilvhHwDDGqKCDTCA0unVkIVfj2t6ziWyPda1Firpqgzj5/LwYYffRHiwLII
         DLa9AapEnlS71JIx2Oa+T84d4aDf3B5046tibpXc5Lm4SZg/dE0HdSh1fo8oOgdxXyNm
         5JMLA+je+QUiB7Af0Zt4P6z60/Ey6K/rwBJqYz7FpeJa1XAb1dvRI2SdXRGIWgqDAZT5
         q5NYWIJhlvajh0CToiLXSos0yjwfitMsD7oSQDkpsKKutxqkOII6Vz1qpcMEaP4WlEGF
         Z1oA==
X-Gm-Message-State: AFqh2kpZdkXajocHmDr3r+Y0fZouRnJZl5IC7vr36ayfQFKBtYkXpD3q
        3kMzli+v5+tjreKu8YpjPhsIfg==
X-Google-Smtp-Source: AMrXdXujpU46wTD3VGXU6Bxn51go3JRMyXI0wVeypnzw7aT4SiYD2PY577jSNi33KXhieOTRpVmxYw==
X-Received: by 2002:a05:6a20:7f59:b0:ac:af5c:2970 with SMTP id e25-20020a056a207f5900b000acaf5c2970mr1637909pzk.3.1672191752691;
        Tue, 27 Dec 2022 17:42:32 -0800 (PST)
Received: from [2620:15c:29:203:93f7:84:3b7b:8294] ([2620:15c:29:203:93f7:84:3b7b:8294])
        by smtp.gmail.com with ESMTPSA id n8-20020a654cc8000000b00478dad38eacsm8545514pgt.38.2022.12.27.17.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 17:42:31 -0800 (PST)
Date:   Tue, 27 Dec 2022 17:42:31 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
cc:     Peter Gonda <pgonda@google.com>, Andy Nguyen <theflow@google.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, John Allen <john.allen@amd.com>,
        "Thomas . Lendacky" <thomas.lendacky@amd.com>
Subject: Re: [PATCH] crypto: ccp - Limit memory allocation in SEV_GET_ID2
 ioctl
In-Reply-To: <Y5rxd6ZVBqFCBOUT@gondor.apana.org.au>
Message-ID: <762d33dc-b5fd-d1ef-848c-7de3a6695557@google.com>
References: <20221214202046.719598-1-pgonda@google.com> <Y5rxd6ZVBqFCBOUT@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Dec 2022, Herbert Xu wrote:

> On Wed, Dec 14, 2022 at 12:20:46PM -0800, Peter Gonda wrote:
> > Currently userspace can ask for any uint32 size allocation for the
> > SEV_GET_ID2. Limit this allocation size to the max physically
> > contiguously allocation: MAX_ORDER.
> 
> This is just to silence the alloc_pages warning, right? If so
> how about adding __GFP_NOWARN instead?
> 

The goal was to be more explicit about that, but setting __GFP_NOWARN 
would result in the same functional behavior.  If we're to go that route, 
it would likely be best to add a comment about the limitation.

That said, if AMD would prefer this to be an EINVAL instead of a ENOMEM by 
introducing a more formal limitation on the length that can be used, that 
would be preferred so that we don't need to rely on the page allocator's 
max length to enforce this arbitrarily.
