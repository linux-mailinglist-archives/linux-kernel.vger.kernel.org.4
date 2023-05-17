Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128CC707435
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjEQV1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjEQV1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:27:07 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26D3173F
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:27:02 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-94f9cd65b1aso32205166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684358821; x=1686950821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzYzSX84H6WHKtz+iH1LcjjiFBZ+NTz6SMtxmugCTuE=;
        b=dMIQ7h9ygisE9xCOEILiU++AsVgAME8zdFw1htlciHACuRFaquIqoSxj4m336DF36G
         DYciwnOTAkIgztl+Lng0jklKQ11YgDFrOu/UTRPc/11gHgAPpYc6TSCOeOHoDk4xIyX+
         ltm6ZxAEdsv5Y6SGv0WbzHlCTwfL0eSBss5R5TGwIoO51Owkc0Prje194Vu3mbPx6VIX
         95s315MmMOnBmwI5VmkV00bAA1eSv0XCebyAMcx1JU0mtvVVXG/XZzWa4F7J4vQqDYcT
         /DqIyyzZxDh+mf+V1lP3un2gSdy3np293IyB0nqHtWyByD9ChJ3Gj6ICwsA5k/GGBDtk
         U3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684358821; x=1686950821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzYzSX84H6WHKtz+iH1LcjjiFBZ+NTz6SMtxmugCTuE=;
        b=EEuTawQX7FUHjtASjV62VEOu7/WZI1FznJ6I6YcykG3hHk3l9zqOKdaOEJeAa8xLxQ
         +l2+95N7nLuIZQ8VDwTHCtMy6p79xyJHxIhavDPgza6RVBVbcT84s1gSaQ17koTSspo/
         w+c24MlV2fp2wCFh3uGXyO3ktyhrnx7rLSZRrSWf0yIsLJhK992VSdLtVobLs3GdHx6u
         o2JpcGGeegM+EsAOmHG3fryzQ2z1aWv5rUMdPygNcMs3wYCGlWGmlrKvUNH/LqNNKrlz
         MrcRk+moGz5WGcgOGzk6jfoOsWyUfpZlfrdgk/SCSsCVy4vcA7Fq195FZRAI7LtzWpgl
         zWeA==
X-Gm-Message-State: AC+VfDz3YL9QH7ZdRsZq3pcUTbN1rKbClNEEPTZGi3DVlqO7MxNXVpTY
        R8b7umqVby20RJ+UEdCj8iWN4YpwKHn/QYFq6IqQWauh
X-Google-Smtp-Source: ACHHUZ5RJENfs+AvgwNVePKeS1Vm6dlZR93nZAHnNB30jh0lj49u+IN2gssLagp228gacwO2Q/Fjtxdh0OUmWFZwako=
X-Received: by 2002:a17:906:74c8:b0:965:a6c1:9b96 with SMTP id
 z8-20020a17090674c800b00965a6c19b96mr3029111ejl.2.1684358820832; Wed, 17 May
 2023 14:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230509183301.1745462-1-olvaffe@gmail.com>
In-Reply-To: <20230509183301.1745462-1-olvaffe@gmail.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Wed, 17 May 2023 14:26:49 -0700
Message-ID: <CAPaKu7TqUt1L-5RUuwEagr2UUs8maOO+FSoS2PEoP9eO1-JJSw@mail.gmail.com>
Subject: Re: [PATCH 1/2] amdgpu: validate drm_amdgpu_gem_va addrs for all ops
To:     dri-devel@lists.freedesktop.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Philip Yang <Philip.Yang@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Danijel Slivka <danijel.slivka@amd.com>,
        Mukul Joshi <mukul.joshi@amd.com>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 9, 2023 at 11:33=E2=80=AFAM Chia-I Wu <olvaffe@gmail.com> wrote=
:
>
> Extend the address and size validations to AMDGPU_VA_OP_UNMAP and
> AMDGPU_VA_OP_CLEAR by moving the validations to amdgpu_gem_va_ioctl.
>
> Internal users of amdgpu_vm_bo_map are no longer validated but they
> should be fine.
>
> Userspace (radeonsi and radv) seems fine as well.
Does this series make sense?
