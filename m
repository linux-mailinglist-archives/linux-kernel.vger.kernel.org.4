Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B550073C4E6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 01:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjFWXoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 19:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjFWXoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 19:44:21 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9482701
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 16:44:20 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b45a71c9caso20432791fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 16:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687563858; x=1690155858;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gVT3Ae52uNnNMAjvZ6ok3W1cvzQFVUDD1dzfpAkc+Ro=;
        b=FKr6y0D7M7n2ZF8m2cxTyTM2x+KAmirSuNycbvhe3F2dpHrILwlDgmG1wD+uBpH85d
         y9SaEcN/5s/p/BqAuuiEdmnSstGU0+ZYF5LuBmtmmPZTMeP5SEPorASF+frX0o66GKtF
         ZnlRv3nz7hNMgexnZC050NeSL4U6f0ecCaFs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687563858; x=1690155858;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gVT3Ae52uNnNMAjvZ6ok3W1cvzQFVUDD1dzfpAkc+Ro=;
        b=EJ/mn7mTgm4QvvSzYnhGU8LBpMvX4yQ/auZT/zXllAwmAzfgJzKcZOLSXWhSv/ygkm
         KCdVcHfKOpeshLOMXEsSqAaht0KdMIcP0Jkp1TufMu23fOzY0mNAhdCsveUubdyuT9eU
         wtXT2/H4F/sMH+U875FGDo5z4+Xv2m7mJUWw9uf+r/vvH8qTqCiNdLfyQjFr8h/ynSfr
         9m834LghW/8utESbj7sfTpxL1BC82WvhZmPvmmFBFZAeHfB/lW9RvXc9FBCWGL9JMVq0
         joK1BZnPrKhs4GzYw6nSivlakQnXqsew/jEJDiGsrQvrM4P28xWeJrPAZSKtTRn/6QAm
         Pd3g==
X-Gm-Message-State: AC+VfDx8LpKRnjwA/oJLpVn078GrT7h7UttT60UgT1yyIArEhT5JAM8v
        DQEglCCY3nx3hyP7Y/ikpx7OfJV6J0U97ryWvOHlXHRC
X-Google-Smtp-Source: ACHHUZ5B9eF6yR0rg4XLRNvj6y8BPu1OGFsACB5jmDE4bNWS31YJbSp3D0/+d3JI6H8QWZNpADpjvg==
X-Received: by 2002:a2e:9d0f:0:b0:2b5:8606:f834 with SMTP id t15-20020a2e9d0f000000b002b58606f834mr5901557lji.40.1687563858323;
        Fri, 23 Jun 2023 16:44:18 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id z20-20020a2e8e94000000b002af8aaebce4sm27573ljk.8.2023.06.23.16.44.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 16:44:17 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2b479d53d48so20642571fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 16:44:17 -0700 (PDT)
X-Received: by 2002:a2e:6e16:0:b0:2b5:950a:711c with SMTP id
 j22-20020a2e6e16000000b002b5950a711cmr3568282ljc.10.1687563857166; Fri, 23
 Jun 2023 16:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230623211808.7667-1-alexander.deucher@amd.com>
In-Reply-To: <20230623211808.7667-1-alexander.deucher@amd.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Jun 2023 16:44:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiOCgiwzVPOwORHPML9eBphnbtM2DhRcv+v=-tnRrgbYg@mail.gmail.com>
Message-ID: <CAHk-=wiOCgiwzVPOwORHPML9eBphnbtM2DhRcv+v=-tnRrgbYg@mail.gmail.com>
Subject: Re: [pull] amdgpu drm-fixes-6.4
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        airlied@gmail.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2023 at 14:18, Alex Deucher <alexander.deucher@amd.com> wrote:
>
> are available in the Git repository at:
>
>   https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-6.4-2023-06-23

That's not a valid signed tag.

Yes, it's a tag.  But it doesn't actually have any cryptographic
signing, and I'm not willing to pull random content from git sites
that I can't verify. In fact, these days I ask even kernel.org pull
requests to be proper signed tags, although I haven't really gotten to
the point where I *require* it.

So please sign your tags - use "git tag -s" (or "-u keyname" if you
have some specific key you want to use, rather than one described by
your regular git config file).

                  Linus
