Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFCA7384E7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjFUNYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbjFUNYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:24:36 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9C0191
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:24:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3111547c8f9so6869780f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687353872; x=1689945872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mF/025lHMkEmRtTPFqKcm0Vi5RzrrdiwBpzJM5RkWZ8=;
        b=Jr9bfIAKQrvaxFa4rQoB4iHF8uY03ENM5OyAxuR6kuc6ipsREZE/7ifr74zl2QfhV+
         C9Bcwu0EnxVmK8drtToETGjGveagQG5FXv70MzTefjuuFPtdhfWxCA2lDDrKQA1yZofb
         kSBXaBmGEGzUIRJzxYBGmUpqpHqOIFESvXFyXTUD9onvIMxL9uKbZs4qaC4bRJtMoAYE
         pk0lTzJDWf1lJlfxPc/fjr+E8Ipck1Ni1m7Db8Zgt1/3cotxRD/p/5B3q+hzeMBrTOb9
         E7g8MvoLZdGIpZQBDNGe+04yNACmz8mvjxAgJOhfvK6NE1C6PjeEI0EXcCvd/ZgWR7TC
         16KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687353872; x=1689945872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mF/025lHMkEmRtTPFqKcm0Vi5RzrrdiwBpzJM5RkWZ8=;
        b=IwzIVpwu/yXcKna1fjDjpF+YE61epR84WoxPLkzMwqde6JdBcjJ63GJ99T4N3cBcv6
         9EdV/BV/M07ExwTKYvgnnskQuRrSAw32JYKnGRhB/78Cd1br3ne+g8DjIsgApK/y8R+n
         4kBNj1QEtrmvmlkBIuxoKm7wk6lKi+Dkk4e952oMjU01ibkGr+LVJIMH/ImqKq+zJwx8
         BVQrq+2BvwY+fcMTwnztlr43xEhpejRdwW03cVHRIydmnY/o3p9MrN6AOYAzVLUpLj0o
         ccoveD+1ZmLjbfZaWrunULBIfjYTTFtxJMpzVFKOIvS4B69HQEnxhm4maGy4lSP+RsMK
         uiGA==
X-Gm-Message-State: AC+VfDzMmCUt7o4ahZ0GmY8HnK7dt4Pz7M2n+glrfI9CgaT7eUgiZnqT
        ecgTypY3KIL4iWUJvs9nXXA=
X-Google-Smtp-Source: ACHHUZ7BkaCdarEza9XZkyLaO/bP6fh/v4JDjRWZbX+bMSH9YMPiGIo4DpyCzRVH8akPG23G65oX/w==
X-Received: by 2002:a5d:4643:0:b0:30e:4a21:808b with SMTP id j3-20020a5d4643000000b0030e4a21808bmr12971936wrs.55.1687353871739;
        Wed, 21 Jun 2023 06:24:31 -0700 (PDT)
Received: from suse.localnet (host-79-50-220-240.retail.telecomitalia.it. [79.50.220.240])
        by smtp.gmail.com with ESMTPSA id w18-20020a5d4b52000000b003127a21e986sm4447046wrs.104.2023.06.21.06.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 06:24:31 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Sumitra Sharma <sumitraartsy@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Thomas =?ISO-8859-1?Q?Hellstr=F6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH v2] drm/i915: Replace kmap() with kmap_local_page()
Date:   Wed, 21 Jun 2023 15:24:29 +0200
Message-ID: <13316568.uLZWGnKmhe@suse>
In-Reply-To: <79e1f37f-3ffa-0195-860b-08cc890d810e@shipmail.org>
References: <20230620180759.GA419158@sumitra.com>
 <79e1f37f-3ffa-0195-860b-08cc890d810e@shipmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On mercoled=EC 21 giugno 2023 11:06:51 CEST Thomas Hellstr=F6m (Intel) wrot=
e:
>=20
> I think one thing worth mentioning in the context of this patch is that
> IIRC kmap_local_page() will block offlining of the mapping CPU until
> kunmap_local(),

Migration is disabled.

> so while I haven't seen any guidelines around the usage
> of this api for long-held mappings,

It would be advisable to not use it for long term mappings, if possible. Th=
ese=20
"local" mappings should better be help for not too long duration.=20

> I figure it's wise to keep the
> mapping duration short, or at least avoid sleeping with a
> kmap_local_page() map active.

Nothing prevents a call of preempt_disable() around the section of code=20
between kmap_local_page() / kunmap_local(). If it is needed, local mappings=
=20
could also be acquired under spinlocks and/or with disabled interrupts.

I don't know the code, however, everything cited above could be the subject=
 of=20
a subsequent patch.

Regards,

=46abio

> I figured, while page compression is probably to be considered "slow"
> it's probably not slow enough to motivate kmap() instead of
> kmap_local_page(), but if anyone feels differently, perhaps it should be
> considered.
>=20
> With that said, my Reviewed-by: still stands.
>=20
> /Thomas
>=20



