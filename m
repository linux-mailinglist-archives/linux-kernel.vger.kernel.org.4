Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310DD747813
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 19:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjGDR5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 13:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGDR5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 13:57:17 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8499910C8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 10:57:13 -0700 (PDT)
Date:   Tue, 04 Jul 2023 17:57:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1688493430; x=1688752630;
        bh=A2izVLmKnAOTqixZ0m4jX7wiQ2V2QLpbP3fSp42+WRM=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=jLOT0tTOSkxg8LjsDKwNgrKPXhldiiJRdpMIbXZkpOBkxXNeUOuZRywdmJQ3P5Iyj
         5gS9lyB8ymKw9JkTmUADEugrz8sXHNTeCwLtupS9/s7OeQgB1AQn78MreulGdGYQlP
         jeEnR3wNf2uCLNv5pbKuOXwfqjoNiqedMqpfxmLt5Ky4be6d9eGZmEVAMAiknPZ09x
         zf2Rpba1PK1XH0rt8t3qh5e4LQielBdGT/2IM1JpXdSAxhd0zc878dNGrRObqt96k8
         7TtIV+42MtycK7nRw24lo+YlCQTldLM2P7571yupf7SyqqynFLkf2W/fHsZ9qWtnlk
         MJwvS5XEUjwaA==
To:     Sebastian Wick <sebastian.wick@redhat.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     =?utf-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        pierre-eric.pelloux-prayer@amd.com,
        =?utf-8?Q?Marek_Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
        =?utf-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Italo Nicola <italonicola@collabora.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        wayland-devel@lists.freedesktop.org,
        Pekka Paalanen <ppaalanen@gmail.com>,
        dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
        alexander.deucher@amd.com, hwentlan@amd.com,
        christian.koenig@amd.com, joshua@froggi.es
Subject: Re: [PATCH v4 1/6] drm: allow DRM_MODE_PAGE_FLIP_ASYNC for atomic commits
Message-ID: <p-vKlt6LWsnO1-Ent-Y3sCt_NhITc2WrYQarRLJ2fIjxYFenrM9zCg6_YZxyh0gAaCXeBWGBnS5ww_aeT-EG95IsDTm5J-YegFrbINCC98w=@emersion.fr>
In-Reply-To: <CA+hFU4y+kHitNsqb1WC6dHE5hr=1S6gJeyHXC5mv9Ads5mdgWw@mail.gmail.com>
References: <20230701020917.143394-1-andrealmeid@igalia.com> <20230701020917.143394-2-andrealmeid@igalia.com> <CA+hFU4y+kHitNsqb1WC6dHE5hr=1S6gJeyHXC5mv9Ads5mdgWw@mail.gmail.com>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, July 4th, 2023 at 19:06, Sebastian Wick <sebastian.wick@redhat.=
com> wrote:

> > + * When used with atomic uAPI, the driver will return an error if the =
hardware
> > + * doesn't support performing an asynchronous page-flip for this updat=
e.
> > + * User-space should handle this, e.g. by falling back to a regular pa=
ge-flip.
> > + *
> > + * Note, some hardware might need to perform one last synchronous page=
-flip
> > + * before being able to switch to asynchronous page-flips. As an excep=
tion,
> > + * the driver will return success even though that first page-flip is =
not
> > + * asynchronous.
>=20
> What would happen if one commits another async KMS update before the
> first page flip? Does one receive EAGAIN, does it amend the previous
> commit? What happens to the timing feedback?
>=20
> This seems really risky to include tbh. I would prefer if we would not
> add such special cases for now.

This is not a new case, i915 already does this with the legacy API to
address some hw issues. Sadly I don't think we can do anything about
it.
