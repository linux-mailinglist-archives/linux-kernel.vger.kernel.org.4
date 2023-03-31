Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309436D248A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbjCaP6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 11:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjCaP6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:58:45 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13FBD51A;
        Fri, 31 Mar 2023 08:58:44 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso25905217pjb.0;
        Fri, 31 Mar 2023 08:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680278324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxJeRCNlob7RdsmYmplWDSRv896kgREUT/PanUMpg+I=;
        b=df94nsGP/LSbkeu4EwTcd6OWf4bwFCVeTX2AV6GGuJjRqHHCAMue+ucZDrKHUhmKYG
         rF1GcVAwowFS+Lw4R2ZOUyVGlohHcI6cjfHM7qK93vDDAl7K4QkmPtop0JyXgqtHXc7H
         /5vLStTMRgLSeUXBayN0bKd/AONKgI/U1KUKS5/OQNcRAufgEZpwDgrUSWGMu6Y857ge
         adjCqeJIwjNQ9e0ozCbwL/KW0l7dQvZWabnDNyAgsHKLIX9dRbhWd87DZu9ExUYc0qUd
         3JnEV11La2lDBJeuBzAsXlD+zwvLmegtNhi0v+YBndpY86p8Vd75hORyoRDkG0cpykNS
         EsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680278324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxJeRCNlob7RdsmYmplWDSRv896kgREUT/PanUMpg+I=;
        b=AvyOfyGJYel+Cq0qttoEmJ9Q/pNCMBOEDdRu48h0Rmu/+BjLeODHIoz+XqNtSxxlhk
         ZYu9z/TG1gi6sSHiEPPfiZ7I/EU7eXLLqbLA7ddt8uJVqHwbzPtsJxa1+MFO+dZGJ+tn
         Csm5sJFXj8q9IVe3SxmxlaSbNLpF6dGcW1tzXPH8Ta1Z7TARrqPe4C0GOsnltnnqrw93
         2vYWJkrjAnDcMS9Q3539mlnUCFfvdraLmVkWPdDHk3T+fAnP3ouJyE+0izuKY2M0IAIG
         gMFc5xGIsmprNxLEFNrWXQJUUiw9o8j0l4Gt+t2LLE4XFIOqhXNhCRiq3uzTvkOygPTL
         4mIw==
X-Gm-Message-State: AAQBX9f3Mbi91F4AXC00VoCJJRL/vJR8TRVON5CIi28AYvsrxHz2fKHr
        x1MxlzJONjpJ9ZZlL6XOBqhqKsnDWq8U4LtYjZc=
X-Google-Smtp-Source: AKy350bz/tztNwieqBPr0YpIGhRToLQzKICehLEvyBJaRV3QsLjS5DSIpsQJaRhwDGwOw8j+ci7/+u06sPwz0OatqIU=
X-Received: by 2002:a17:902:b48e:b0:1a1:dfd6:b0f0 with SMTP id
 y14-20020a170902b48e00b001a1dfd6b0f0mr9675817plr.11.1680278324230; Fri, 31
 Mar 2023 08:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230328111714.2056-1-zhangqing@loongson.cn> <CA+fCnZevgYh7CzJ9gOWJ80SwY4Y9w8UO2ZiFAXEnAhQhFgrffA@mail.gmail.com>
 <dccfbff3-7bad-de33-4d96-248bdff44a8b@loongson.cn> <CA+fCnZddt50+10SZ+hZRKBudsmMF0W9XpsDG6=58p1ot62LjXQ@mail.gmail.com>
 <2360000f-7292-9da8-d6b5-94b125c5f2b0@loongson.cn>
In-Reply-To: <2360000f-7292-9da8-d6b5-94b125c5f2b0@loongson.cn>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 31 Mar 2023 17:58:33 +0200
Message-ID: <CA+fCnZfoTszdoy7o_EfPXOc4QYo_Jgw9Qf0ua2JoNp0PXdrTPA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add kernel address sanitizer support
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Huacai Chen <chenhuacai@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 6:32=E2=80=AFAM Qing Zhang <zhangqing@loongson.cn> =
wrote:
>
> > I get that, but you already added a special case for
> > __HAVE_ARCH_SHADOW_MAP to addr_has_metadata, so you can just call it?
> >
> ok, all the changes are going to be in v2.

Could you also please put changes to the common KASAN code into a
separate patch/patches? This will simplify any potential backporting
of common KASAN code changes in the future.

Thanks!
