Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6D575099D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjGLNaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGLNaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:30:19 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92080199D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:30:15 -0700 (PDT)
Date:   Wed, 12 Jul 2023 13:29:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1689168610; x=1689427810;
        bh=IMV+oy2qN0Q8CoNfZ6wVwUYQLPGCoo5SMxI5O2mWNcg=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=OlMprFkR9CGrijBxrGoyIxkXHojOYVmGOcz9BiOVoHtIvWWpMtszlTCALSEaotTi6
         z51ashPlpLXFhPKFiHu48u7zimkth5an5gQzmLL+NttG2zwfhBQV5Nk1TpfGhjy3SB
         EgfGbP2ldC5ffdLB6pn1hA6f8Cu6PixAX7/A4CRQgpHDqLTRgFuXlgQNilHSo7Fjmk
         CbIy3XZb2lpTfAUpEB8jQIOeA40vpQRhZpV7xUEhfRuN8wCcIFimyhim9oagOKkV6N
         hJLyh1y/+8Bh7S4rux8kYyQQrWccZJpfAoMjbvFMHXNILBJK1EjTjcQ2AvYESQKXBw
         1+Rw5Pv+WJFcA==
To:     =?utf-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wayland-devel@lists.freedesktop.org,
        kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        Rob Clark <robdclark@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniel@fooishbar.org>,
        =?utf-8?Q?=27Marek_Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        =?utf-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Randy Dunlap <rdunlap@infradead.org>, hwentlan@amd.com,
        joshua@froggi.es, ville.syrjala@linux.intel.com,
        Pekka Paalanen <pekka.paalanen@collabora.com>
Subject: Re: [PATCH v5 6/6] drm/doc: Define KMS atomic state set
Message-ID: <c5ojpE6h8oU8ewp3vGknvW6QW88KRiDjpHzvQZNmAUiu9aBmaDAsiE5MF_4BaTm3sk6Ys1jOEYyMvfoHa1s3wJVQDwic5aeFoYXbgeU6F4Q=@emersion.fr>
In-Reply-To: <20230707224059.305474-7-andrealmeid@igalia.com>
References: <20230707224059.305474-1-andrealmeid@igalia.com> <20230707224059.305474-7-andrealmeid@igalia.com>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, July 8th, 2023 at 00:40, Andr=C3=A9 Almeida <andrealmeid@igali=
a.com> wrote:

> +KMS atomic state
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +An atomic commit can change multiple KMS properties in an atomic fashion=
,
> +without ever applying intermediate or partial state changes.  Either the=
 whole
> +commit succeeds or fails, and it will never be applied partially. This i=
s the
> +fundamental improvement of the atomic API over the older non-atomic API =
which is
> +referred to as the "legacy API".  Applying intermediate state could unex=
pectedly
> +fail, cause visible glitches, or delay reaching the final state.
> +
> +An atomic commit can be flagged with DRM_MODE_ATOMIC_TEST_ONLY, which me=
ans the

Can we linkify these #defines? This can be done like so:

    =E2=80=A6 flagged with :c:macro:`DRM_MODE_ATOMIC_TEST_ONLY`, which mean=
s =E2=80=A6

This should create a link to the docs for this flag.
