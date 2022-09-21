Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67FA5C0542
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 19:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiIUR2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 13:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiIUR2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 13:28:07 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40958A0322
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 10:28:07 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1279948d93dso10056078fac.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 10:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=oIcVLFk7zmQbQSkhtXNMtiXqG0YYuFNHIOlQIXgkdXw=;
        b=IpQtuPeAaqwDBdNxq8AGBqSy7sk3hE4//SgQa9KtcKybm3kBqzMfOZ87h/cWoGMili
         5N9eOFmNgbGxtV7goomqVEG65TQXTTYoPpUfiGLeyvgCM6TRGFQeBQIi+/QJV8OAfvMh
         BQYj9iFOz0rdCkPj9BVrIcyuTv/Lz+F3ZtvgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=oIcVLFk7zmQbQSkhtXNMtiXqG0YYuFNHIOlQIXgkdXw=;
        b=y/jDi7R9X4JsTJtHTDMJhdReisOTovfk8jtKIp24DvH6WKr7dzLwmoE1pkgkoIQKYp
         jGFbT7UCikiqNajZr68wYf5/78XPe9+eZVXiRG8LAnL6EB9qCqIbj/oP3AcMoKlIJ7h4
         xwXhvny9IKrufow+c51UUAFG+hm13PeUP00esI74qsr1Gd8vDCvJOhZ5DKmdqrhMvgfb
         FiKN+GnKIdH5/49YJmaTKzJvQ/eC1IGpqNMHZoUkNNWBjVKKdrLXYhHpm5WUWlZ59Ex2
         /BqRlhna5/iypCXHIMDG8J5/oUJ9DRcKiEKRydvc8MR4WTY+yre+auWeJx1ptSDOvDCj
         2A3g==
X-Gm-Message-State: ACrzQf3oAzT+i39q924xln+DAN7e9Yb581K+TnzhPpeCXxUtfcHsSmya
        52wdWj+9+MysM5cDrk7fARraXprdOAnovA==
X-Google-Smtp-Source: AMsMyM5Xh/LtI7Czr838kPl9AsZgy2t9WS+6B6nlDYt50bBWvvP8Pz2/Fqc01XCzKibNbe3PwqbV9g==
X-Received: by 2002:a05:6870:ea8c:b0:12d:392c:18d7 with SMTP id s12-20020a056870ea8c00b0012d392c18d7mr5581243oap.281.1663781285954;
        Wed, 21 Sep 2022 10:28:05 -0700 (PDT)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com. [209.85.167.180])
        by smtp.gmail.com with ESMTPSA id r127-20020acada85000000b003431d9b3edfsm1515527oig.2.2022.09.21.10.28.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 10:28:04 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id r125so8918073oia.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 10:28:03 -0700 (PDT)
X-Received: by 2002:a05:6808:11cf:b0:34b:8f4f:314b with SMTP id
 p15-20020a05680811cf00b0034b8f4f314bmr4438561oiv.126.1663781283650; Wed, 21
 Sep 2022 10:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <2b0ca6254dd0102bf559b2a73e9b51da089afbe3.1663764627.git.robin.murphy@arm.com>
 <CAHk-=whdwG2LaaktZTYab2JO2TkPYEmSc-sOJ=qL5wtOWpRpKA@mail.gmail.com> <574fe371-033e-a316-4ace-8a3fd9b19329@arm.com>
In-Reply-To: <574fe371-033e-a316-4ace-8a3fd9b19329@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Sep 2022 10:27:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgMzxSF9=3MuUs_TcgDgkxDvWQzW9HG17wDLbDrYrXtBg@mail.gmail.com>
Message-ID: <CAHk-=wgMzxSF9=3MuUs_TcgDgkxDvWQzW9HG17wDLbDrYrXtBg@mail.gmail.com>
Subject: Re: [PATCH v2] iommu: Optimise PCI SAC address trick
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 10:01 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> If you do want to have a play though, compile-tested cherry-pick below.

Works for me.

Except for you having "format=flowed" and some whitespace damage. But
I fixed that up manually.

                Linus
