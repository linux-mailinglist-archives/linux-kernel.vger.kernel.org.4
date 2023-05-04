Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB876F709A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjEDRNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjEDRNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:13:36 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC723E77
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:13:15 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ab14cb3aaeso5491735ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 10:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683220395; x=1685812395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZZBXQcPWAT9VDLt86aSAOWK05En/ty3UkgMboGhsYM=;
        b=Y6RrftnbHlFXWZfdktclhOS3xsNtKMCtPqaw6Bz0iS1KQSQ5IsL7JDVum1rdeO7iXS
         CJiazY/eAQH3lVi1WNp+q3fc9HrISL9mLcI4rULQZONA4r3tAmkcOGsk0U9vi+DxTi4B
         ckewujMTJyGglHEzQDx0Rx9DjsyR1ysHjgfxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683220395; x=1685812395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZZBXQcPWAT9VDLt86aSAOWK05En/ty3UkgMboGhsYM=;
        b=MIrX/OAo8a0y13vMjiadfkey4lCcOhKZFkBVhYnZdZWuYVP2jtgnxzxNTXwU5j7XrQ
         TljYJD/87lHlOmHAkAvCfGSkLMn6JXTf/uU6tqkKGQ11g1mwM9xlqjRKqloWs1eqDbBd
         KigoQX5K5HKrhLrhRjmvajmw7QKg1uPrVZPv2u6LXZBjrV2M5ghhXak5XOFaf1J8ljrv
         cxWA3AD+ShwicmAnYsIMQCaA+0GvcJy3EJTNTtqNB7cK97ew58bYnUN/Jm50aUiS9amN
         0mlhc9DFopSJagS1HSmYzmDlO5ZLTtwz7cVgsMX9YbI4L6vRco3uVzzgmd51u/i8iuKd
         5hGA==
X-Gm-Message-State: AC+VfDw3JiXUAff+XBDOOAa+0WAPlEdwAUiOym8xuG271PVObcIy05nX
        yFPpvjoteDKE79SdZ5BZ/7jVM43oUCMcEBC3elrlHemraRqda2tO92Y=
X-Google-Smtp-Source: ACHHUZ7Ca2tNfQ+7SUqYOkauIBnweRX6s9q7AJxcxYU16KAxS+pX0Akt30c+9l9/3CqaXjOE2xdxpXWanD3up6AcG7w=
X-Received: by 2002:a17:903:24e:b0:1a6:37a6:f41a with SMTP id
 j14-20020a170903024e00b001a637a6f41amr4858676plh.45.1683220395059; Thu, 04
 May 2023 10:13:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230504170942.822147-1-revest@chromium.org> <20230504170942.822147-3-revest@chromium.org>
In-Reply-To: <20230504170942.822147-3-revest@chromium.org>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 4 May 2023 19:13:04 +0200
Message-ID: <CABRcYm+xcGuyGOUhrMpH_9RMPA3oADCdOQbgHN4bSGcRFSsmQg@mail.gmail.com>
Subject: Re: [PATCH 2/4] kselftest: vm: Fix mdwe's mmap_FIXED test case
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, peterx@redhat.com,
        izbyshev@ispras.ru, nd@arm.com, broonie@kernel.org,
        szabolcs.nagy@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 4, 2023 at 7:10=E2=80=AFPM Florent Revest <revest@chromium.org>=
 wrote:
>
> I checked with the original author, the mmap_FIXED test case wasn't
> properly tested and fails. Currently, it maps two consecutive (non
> overlapping) pages and expects the second mapping to be denied by MDWE
> but these two pages have nothing to do with each other so MDWE is
> actually out of the picture here.
>
> What the test actually intended to do was to remap a virtual address
> using MAP_FIXED. However, this operation unmaps the existing mapping and
> creates a new one so the va is backed by a new page and MDWE is again
> out of the picture, all remappings should succeed.
>
> This patch keeps the test case to make it clear that this situation is
> expected to work.
>
> Signed-off-by: Florent Revest <revest@chromium.org>

Ah, snap, I hit send to fast and forgot to add:

Fixes: 4cf1fe34fd18 ("kselftest: vm: add tests for memory-deny-write-execut=
e")

I will do it in the next iteration (surely there'll be other things to
fix... :))
