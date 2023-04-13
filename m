Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F506E02F7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 02:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjDMAEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 20:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDMAEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 20:04:40 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C047A9D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 17:04:38 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a652700c36so167965ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 17:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681344278; x=1683936278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TD8d5lr5MkiN2++oGGCJCsMVGJRbHc45GRZJ35kiN8=;
        b=tkWR9F20ucPpo1lTciwCS1VaBcp6T1BGCSSSD9KrFtZ1Zwmb9oI1TiAedLL9atVPlD
         7YjRO1VK2rB3tIouLTrc+g0MYG2nTZpI1vJWYLWbFGe1niObTtSPjfLv5OX+qPRUred0
         xlUfHGCufknPpcmFybego7lDy/nGNJyBoO2PzGNsMYG1OZsFJ9jIDmd4IlSFBxWgNe35
         /dGGPPpFksV4mW6ULY2dNeVksXks96kOFkWiyuNVZwZjP0/zbaHcRZ6nkTTYH/CA0wjz
         BUv3YYo30efcJAv1sd7l6kjVaranKcmS2jxuRoQ3/0DfGcBdytqQ7J+5hXaC3Jlh3ktC
         V3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681344278; x=1683936278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TD8d5lr5MkiN2++oGGCJCsMVGJRbHc45GRZJ35kiN8=;
        b=BCxbRB0vyV2v/NfSHWCuu+0miCaqNKqmdb1d6yYglCM+cq2rqXJ4V7ZVpmdiN2dFmI
         gPz9vObjJiKUG16OaUOw2tlOPbO+ClozYwaQCtAma9koYxztUvXxT3xW6VjbIlWJ1Bmz
         1P9kKnzvNBbz4DbTEV8KHBRrSy8cike7HbvQPWuo29TLFODcQpLyZwLz5uzbS4nw2FX6
         y6Kvym0ydNoT2desiyOMOXVtJpOB3mxDxPjjr5CTW00IiIFyAt1jPLYHppGEx/jkDk/r
         OOlxiLetI1uFtg42lXuaMmL+QA13HujTpV9eLkjdoMjSt/nv10WYaGD7UZXxTKO4y3bM
         1p8w==
X-Gm-Message-State: AAQBX9eBSsgaMcMs2VoswKzrG4fq4ns2SHHH8q0HcjKBL8VXSy+o4h2K
        lXJANmfWRNMTKjcEdRJ0aag1FjmfXt5UsnWTWPxY9g==
X-Google-Smtp-Source: AKy350aFp8aD8fS3GRkg+Ma4y3lVM9sfzyPJ+FDQtWAnxs5derdP3Ayk1ShdJ+4ob5RT0Xr4WW4vBVunwX7+cJuqMpE=
X-Received: by 2002:a17:902:a515:b0:19f:3c83:e9fe with SMTP id
 s21-20020a170902a51500b0019f3c83e9femr829013plq.14.1681344278084; Wed, 12 Apr
 2023 17:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230327222159.3509818-1-sboyd@kernel.org> <20230327222159.3509818-6-sboyd@kernel.org>
In-Reply-To: <20230327222159.3509818-6-sboyd@kernel.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 12 Apr 2023 17:04:26 -0700
Message-ID: <CAGS_qxryWVOT9cBtKk28=NupbLP6_AiCj0P3np2GpMVKkyQOLg@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] of: Add a KUnit test for overlays and test
 managed APIs
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Maxime Ripard <maxime@cerno.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 3:22=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> wro=
te:
>
> Test the KUnit test managed overlay APIs. Confirm that platform devices
> are created and destroyed properly. This provides us confidence that the
> test managed work correctly and can be relied upon to provide tests with
> fake platform devices and device nodes via overlays compiled into the
> kernel image.
>

The discussion around kunit_cleanup() caught my eye below, so one
small comment about that.

<snip>

> +/* Test that of_overlay_apply_kunit() cleans up after the test is finish=
ed */
> +static void of_overlay_apply_kunit_cleanup(struct kunit *test)
> +{
> +       struct device *dev;
> +       struct device_node *np;
> +
> +       KUNIT_ASSERT_EQ(test, 0,
> +                       of_overlay_apply_kunit(test, kunit_overlay_test))=
;
> +
> +       np =3D of_find_node_by_name(NULL, kunit_node_name);
> +       of_node_put(np); /* Not derefing 'np' after this */
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, np);
> +
> +       dev =3D bus_find_device(&platform_bus_type, NULL, np, bus_match_n=
p);
> +       put_device(dev); /* Not derefing 'device' after this */
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
> +
> +       /* Remove overlay */
> +       kunit_cleanup(test);

Note: this cleans up *all* resources associated with `test`.
Right now, it's probably fine, but this probably isn't the safest approach.

Notably, two of the new/upcoming API changes rely on resource,
kunit/static_stub.h and kunit_add_action() [1].
Calling kunit_cleanup() undoes all the stubs and immediately triggers
all the actions.

Perhaps you can create your own local `struct kunit` like in [2]
E.g.

struct kunit subtest; // not sure what to call this...

kunit_init_test(&subtest, "fake test", NULL);
/* use subtest */
kunit_cleanup(&subtest);

There's also already-submitted code doing similar things in
lib/kunit/kunit-test.c you can look at, but it's in init/exit funcs.
See kunit_resource_test_init() and kunit_resource_test_exit().

[1] https://lore.kernel.org/linux-kselftest/20230331080411.981038-2-davidgo=
w@google.com/
[2] https://lore.kernel.org/linux-kselftest/20230403201930.2019419-1-rmoar@=
google.com/

Daniel
