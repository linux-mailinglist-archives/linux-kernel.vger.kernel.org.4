Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263F46C9B50
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 08:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjC0GUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 02:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjC0GUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 02:20:09 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57064483
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 23:20:07 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id c4so4835730pfl.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 23:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1679898007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pVT8M+/flEwAqhJLSL+f9Jg5Iv3C+7AfVQ0msHJJA4=;
        b=m6BNLiHFWxAsN12NtQw/TVLjkOMZFT8qdyvsveq1/XZvvQsEmkx/fi0R/5H/iW2v9l
         76iUL12CVEhjmIV4t4Qceab3dv6CNdX6vNIgMw0Y1x0WRh4uEMvHGxmsWzwboFESGQOR
         K8P+zG/hOUkUPwhdxo2sZsLfOled5RZ/ctLmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679898007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+pVT8M+/flEwAqhJLSL+f9Jg5Iv3C+7AfVQ0msHJJA4=;
        b=NETFh8LuVLrsUVH8tloKnMUxHd8fQTRetkwEkzGkVWXTuiwOMTJxHD747W9kVacaWr
         i4FV8oRGpTRW1UwCc6/rlJbW4XZW6U2TpYdETtkry7EHITgQqmHH0c0vWjk83hqlxpY5
         q3NGOEZwtmnwROGDcs0gx0bIrHGXWKxXS0knIxqjpY0u3ssqMkUrPdI2tyfSB8bAiL34
         8+YjMbcj+ln3fktzVy/Kh7oBr5XqxVkPQrtWjwV13DG7RXGrxp9LjExVPexmgD9y7szM
         QFkfIFKCtJJ26+t/nKP6NHB+VZffhljf49z6wL5x7s1FGT+kTWH4/uC+ddroXiVPqGI8
         VKig==
X-Gm-Message-State: AAQBX9dgk5mGnJpQXve+CBR+PR9R9UwQW1/uSO2idmwxSsIcz7jm8+Tb
        T7JTZfXVo1bW8pK6F2YxVyUaDP5X09xeNndrPBSYHQ==
X-Google-Smtp-Source: AKy350YyFoSiUh+lCyVC5ztyl+nuxTPkRvalkOyA/Bve+vJHQVCDMZXkc6kT7BhejAi+91Lyc9YjSOmgAhCfdnL5qQY=
X-Received: by 2002:a63:da02:0:b0:513:290b:7516 with SMTP id
 c2-20020a63da02000000b00513290b7516mr2471387pgh.3.1679898007229; Sun, 26 Mar
 2023 23:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230322102006.780624-1-liushixin2@huawei.com>
 <20230322102006.780624-3-liushixin2@huawei.com> <CAM4kBBJT1xSGe7KthBvBLstZ43cPP-PDKE7a-6hC5Fn6TneL0g@mail.gmail.com>
 <20230323075927.GB20444@lst.de>
In-Reply-To: <20230323075927.GB20444@lst.de>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Mon, 27 Mar 2023 08:19:56 +0200
Message-ID: <CAM4kBBKdz4oSXpACw=ntwSUi4yH7H65Bu4T+5-NSFtqmUp6SoQ@mail.gmail.com>
Subject: Re: [PATCH -next v6 2/2] mm/zswap: delay the initializaton of zswap
To:     Christoph Hellwig <hch@lst.de>
Cc:     Liu Shixin <liushixin2@huawei.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 8:59=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Wed, Mar 22, 2023 at 06:17:12PM +0100, Vitaly Wool wrote:
> > On Wed, Mar 22, 2023 at 10:30=E2=80=AFAM Liu Shixin <liushixin2@huawei.=
com> wrote:
> > >
> > > Since some users may not use zswap, the zswap_pool is wasted. Save me=
mory
> > > by delaying the initialization of zswap until enabled.
> >
> > To be honest, I'm not a huge fan of this. Would enabling zswap module
> > build instead solve your problem?
>
> making zswap build modular would be a mess.  It is core MM infrastructure
> and now we'd need to start dealing with adding and removing it at
> runtime as well as module refcounting.

Since when is it a core MM infrastructure? It is basically just a
frontswap frontend.

~Vitaly
