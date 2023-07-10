Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A0374D3AA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjGJKia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjGJKiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:38:25 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A789AB2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:38:21 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-78374596182so215365939f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688985500; x=1691577500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvz04yJSt5agLndtywybtJHsB7jWS+1+gKVSsWWw8q8=;
        b=ZfeBuOSdYbBlOpAuhNHZJi7BqVWFERjTyEFqrZqpYPyypLFucIAUo3RB41SWrv/fNy
         6MQeOYsEhQX1N9AEnZsZhshl6efmEASygO1KUfuF7HCLMPjfnbqUMiHBw8EaKuNZHj2U
         ZcASuu/2lYL77GerjZ4Um80miQJ03HJjjK/Zi1rE1/wrztQ4Dhqi/lcFW71Dc+pKyBOt
         iixCNR9dUX0YM0n83hosROqtaIW3lpgFSs04PVQkDrwAIc7GN31MHsQa7TpCu6KbUUD1
         zYdxalep44S/+wDCu0OdM37vejXarY7nz2wuEzGAFIXAjwl5sN0QHTA/4X1wazKUXAwe
         JpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688985500; x=1691577500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvz04yJSt5agLndtywybtJHsB7jWS+1+gKVSsWWw8q8=;
        b=AlGmZTU6jL3DxS8pqEEvfrpI/uzx+Jdm2BBu5z9lecE5GcsoeIFTiQLphaeqCQ3wR6
         FRysBi3Mr/clo0BGEyIwOWRAL3Kc1/pj1OFN5AD1KtJV8T8VnITn0WqXjVX/uukKGTiC
         xfBg88byX2KHDRQ2nL4qjfLhukW/X4SzHZWg+RfbTnGa6fkdh4knx9WOGWDfbTkgUyW7
         FKOcaHlsTNXYzCgV+U5AqV3q2/IfCrEGWgyuKINOI+tUYu3+aN+Cl51qjNHXIJB68I9L
         5mrLunKsk0AkJfwWvTAUxWyQ3/1LhIcr7UimF9HWcyRtgK2SHcmupOKq9bLpwh5UOLf6
         Qu8w==
X-Gm-Message-State: ABy/qLY59L5CRnVkklUML5tkYrhk2DEeWfX+8cRU4oULk0nI+xQRismk
        vyBzq4IPpDmVEeMV7bc2HSsuI8YqAgX5mib0uai8Hg==
X-Google-Smtp-Source: APBJJlHV0c/RmEiHfQDPTa8JHUyb9BGshA7xPbLYwdygcLChbrq+ZTqXINPJJAdemOgkFW139l34UqIqekrgl+kvTSg=
X-Received: by 2002:a5d:9448:0:b0:783:65ba:8614 with SMTP id
 x8-20020a5d9448000000b0078365ba8614mr11099647ior.10.1688985500443; Mon, 10
 Jul 2023 03:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230710032714.26200-1-zhangpeng.00@bytedance.com>
In-Reply-To: <20230710032714.26200-1-zhangpeng.00@bytedance.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 10 Jul 2023 12:37:44 +0200
Message-ID: <CAG_fn=XH8s8JbMKjsyyw_FZhLuoBqAwWU_+hCGyAXwe3wTBCWQ@mail.gmail.com>
Subject: Re: [PATCH] mm: kfence: allocate kfence_metadata at runtime
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     elver@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, muchun.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 5:27=E2=80=AFAM 'Peng Zhang' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> kfence_metadata is currently a static array. For the purpose of
> allocating scalable __kfence_pool, we first change it to runtime
> allocation of metadata. Since the size of an object of kfence_metadata
> is 1160 bytes, we can save at least 72 pages (with default 256 objects)
> without enabling kfence.
>
> Below is the numbers obtained in qemu (with default 256 objects).
> before: Memory: 8134692K/8388080K available (3668K bss)
> after: Memory: 8136740K/8388080K available (1620K bss)
> More than expected, it saves 2MB memory.

Do you have an understanding of where these 2MB come from?
According to your calculations (which seem valid) the gain should be
290K, so either 2MB is irrelevant to your change (then these numbers
should be omitted), or there's some hidden cost that we do not know
about.
