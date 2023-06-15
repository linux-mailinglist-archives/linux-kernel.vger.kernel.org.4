Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FB97314BC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241726AbjFOKBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244619AbjFOKAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:00:50 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9855F26AA
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:00:23 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-54fb1bbc3f2so2364628a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686823223; x=1689415223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrYXbdWYYhjbwH7zdxPwu3/o/9ocDGDBTppaCziBp80=;
        b=US6vL2ldG7GZBsbXzwFGgphmtLGUZyEUPbWXN7KcMIU8pc/xJd919qtHpbZuk9o1nm
         42hyW6f2/ByQYQwFDWuc639l8TKUl9v+SZxeR1EJ/Mjm6j8+X9bJOjTUDt5zxZGAF58k
         Gxgq78NJwHiS7dFzzRGNgPo+JlZAPBG6nz2Vz1haJ/pQCrnDJOeqfPuOe92wUYhL+7kz
         QT1EQmRi3jU5o1sZ4/zXcXf4CvrnJLOxBak+L32GqX8zPolE6DI5Zdc8MJPZ3ccDdxWu
         CubMD2c18Wis0I6u5TowTIIGd1EOvisCDX0JWlK6xeHkpFv+Bk8VOR68t8IP5NmZs5W3
         z3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686823223; x=1689415223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrYXbdWYYhjbwH7zdxPwu3/o/9ocDGDBTppaCziBp80=;
        b=S/TjXXcNjH67GnYJ7Lkr14qfoufEJqSbs88S2YMqVTes6FSq9ChON/SVhHJimdJN12
         WPr36/yK7E2Ip1TNGFazjOvqa6yJLYBdZK/OCgZX+PtXyGeyGzdZp2HZltHWSjSXnQac
         EAijPh/c4TuMoApxF1RaMt/i0TbUZFV6lvlvGjxcobRWunFkw4lTgHgkrNdGMKQpXUWH
         ZOaNna+05Kp1S+wVe4h9xfd2AaX1Q/o54edcvD3vGx4V0dTWLxvmBYnaGv3qlzMXai8i
         gxQgYNLevSFJCWOb3QliP1SLOdiyiqr6CD6wW4CUz4T69sXS/2Yy7R8mJCT00zIWzx1m
         zTLA==
X-Gm-Message-State: AC+VfDyO9TOHM4UhzkkJtIRPTzm8jF6lauglhasYISFYKQdUhANc5RZb
        k1/I5keX0TIASKKf1od/BSnHxLv3jZFYLj2IQQGrSg==
X-Google-Smtp-Source: ACHHUZ75Rw8kyl4hHm1NSloD+KL0RgtR44dGrPbhodUj0cdJHpHHshwg9LtlkQUSv7tz4gS3x4lOznjZHl7l0AHNgZQ=
X-Received: by 2002:a17:90a:189:b0:25e:95a6:898f with SMTP id
 9-20020a17090a018900b0025e95a6898fmr1061445pjc.11.1686823223104; Thu, 15 Jun
 2023 03:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230615034830.1361853-1-hezhongkun.hzk@bytedance.com>
 <CAOUHufZBUEm1P7gm0nFkPSFkNg2fPbs3v3qhL-R9m5yFNoW2YA@mail.gmail.com> <CA+PVUaTqNTSYkTy9yCFF=Y+xkimgM+3YQRF7EYr1UruesQnJrg@mail.gmail.com>
In-Reply-To: <CA+PVUaTqNTSYkTy9yCFF=Y+xkimgM+3YQRF7EYr1UruesQnJrg@mail.gmail.com>
From:   =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Date:   Thu, 15 Jun 2023 18:00:11 +0800
Message-ID: <CACSyD1P=RtUtVOQrY9NVwn79=80zgC92NJyaqbjHXdrhZONx1A@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 1/3] zram: charge the compressed RAM to
 the page's memcgroup
To:     Fabian Deutsch <fdeutsch@redhat.com>
Cc:     Yu Zhao <yuzhao@google.com>, minchan@kernel.org,
        senozhatsky@chromium.org, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> While looking at this in the past weeks, I believe that there are two dis=
tinct problems:
> 1. Direct zram usage by process within a cg ie. a process writing to a zr=
am device
> 2. Indirect zram usage by a process within a cg via swap (described above=
)
>
> Both of them probably require different solutions.
> In order to fix #1, accounting a zram device should be accounted towards =
a cgroup. IMHO this is something that should be fixed.
>
> Yu Zhao and Yosry are probably much more familiar with the solution to #2=
.
> WRT per-cgrou-swapfile, to me this is addressing #2, but I agree with Yu =
Zhao, that there are probably better solutions to this.
>
> Lastly, this patchset, while it will possibly not address the swap issue =
(#2) completely, is it satisfying the needs of #1?
>
> - fabian

Thanks for your reply, fabian. According to the previous design and
test results, this patchset can meet the need of  direct and
indirect usage scenarios=EF=BC=8Ccharge the compressed memory to memory cgr=
oup.
