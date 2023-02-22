Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4105B69F996
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 18:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjBVRG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 12:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjBVRGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 12:06:25 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB043CE27
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:06:22 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-536b7ffdd34so125186647b3.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=11XupW6wyPZ/HYxPwYJLRczn0yGQLt5DSos6YX/pwXo=;
        b=qMSvxuebcg+DHsJ0AXEYFbkdy9T43JzTD/TCNTmJaGWhl4F/U2tGSieR0d/B8fk30n
         AJ6o0Hr+vSYilcTAKacUru/BJw2N7S6ds3+QlLMke1UWFUI5bzQe4kwdBFF1OiZ6de6r
         v/KTvSi6TPyZjisXV3JgFSD8p9DyAkagWvkIdckJUCrzKAOvxsZbW2dDFVcUOwLJJayb
         oXXvq8C9azMPtEO7WBWOlU9UgBzcURTpWRq7JjuswRKgBZ5H9tERec+z/ZSMGH4CMVje
         grXVadLzluQGvY4He46Pv3dBSDH+lCf90iPw4OSr4Ipk69Sl6RjlCTfOZCHzGla21kiz
         0D7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11XupW6wyPZ/HYxPwYJLRczn0yGQLt5DSos6YX/pwXo=;
        b=JWwlWKsEFOiZqt/otwQkTDaUj53MbZQIooSZLTh4HicRGHhxc18ULzYYLbZOnyp5JQ
         gs1HN3YCNYXFWV0cCoOFwQqebPJxU2HWI9zAdn2EE5Jao+FCkWD1CDaEaqxQecv+TnFX
         Xmu96c5DjFA9Xa7ZeTebtkQgJrI6zSTQEa53k0o3LpNZToCLFUgzZO1Gaby/mutLDfRE
         KZ4mn2dZRIlH0Qqw9k/c+cv/Ul7Mik6tlnt0K/Y+KkItz6VIud6eVBJzCkUi3gePgJ9M
         DdTWiK4xwcVfPnPUBCY21GDy3bogXC1yW/l48nF+pbFdqTYLVcFh3SfnBjYZuZCr+mMd
         qLDA==
X-Gm-Message-State: AO0yUKWGObHIUsejWgc7//8nMEdQU22b9ZsuH+zDZ/WwqLRaibG32WFP
        LLjK1pKhtDC2ZojpNXcKOHH1iA==
X-Google-Smtp-Source: AK7set/Ay5Wa5yGAu/9VyfLHZBGglZthPpOXII0dRVMRwRBwdo1mpClz7fcQBvrQBEik5MFtQh+3kg==
X-Received: by 2002:a05:7500:7204:b0:f7:f55b:6f27 with SMTP id kf4-20020a057500720400b000f7f55b6f27mr272212gab.1.1677085581219;
        Wed, 22 Feb 2023 09:06:21 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:5e17])
        by smtp.gmail.com with ESMTPSA id a186-20020a3798c3000000b0073b878e3f30sm2751844qke.59.2023.02.22.09.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 09:06:20 -0800 (PST)
Date:   Wed, 22 Feb 2023 12:06:20 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        David Stevens <stevensd@chromium.org>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: alloc_charge_hpage() take care of mem
 charge errors
Message-ID: <Y/ZLjF9Xe1F6Mu76@cmpxchg.org>
References: <20230221214344.609226-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221214344.609226-1-peterx@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Feb 21, 2023 at 04:43:44PM -0500, Peter Xu wrote:
> If memory charge failed, the caller shouldn't call mem_cgroup_uncharge().
> Let alloc_charge_hpage() handle the error itself and clear hpage properly
> if mem charge fails.

I'm a bit confused by this patch.

There isn't anything wrong with calling mem_cgroup_uncharge() on an
uncharged page, functionally. It checks and bails out.

It's an unnecessary call of course, but since it's an error path it's
also not a cost issue, either.

I could see an argument for improving the code, but this is actually
more code, and the caller still has the uncharge-and-put branch anyway
for when the collapse fails later on.

So I'm not sure I understand the benefit of this change.
