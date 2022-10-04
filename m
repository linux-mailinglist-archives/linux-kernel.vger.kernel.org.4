Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B359A5F3B61
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 04:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiJDC06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 22:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiJDC04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 22:26:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F8ED74
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 19:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664850293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fVkcg9C8JIxqxOQDwg0gOT0h8GaFXdcY7F7efzgxrAg=;
        b=OuFFRwtpRRAuBQs4Cnmkt1FZVXvbhup/cKwvzvEt/ILLzOjTBnEEdHt+FA16U1V1IAmgKu
        LXxiC8WxE6o1W4w914G3FlIvoN3UW8reIyDD7gugBP/6aYNJZJNQpIT2RJ9Ig5cRowTC1U
        VaTK2oLrHEJ6T8tEq2mx9ZQ8mc1YJAY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-141-QenT7fCNML-VKMq_NR9xCA-1; Mon, 03 Oct 2022 22:24:50 -0400
X-MC-Unique: QenT7fCNML-VKMq_NR9xCA-1
Received: by mail-lf1-f70.google.com with SMTP id z17-20020a19f711000000b004a24ea72fa4so577671lfe.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 19:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fVkcg9C8JIxqxOQDwg0gOT0h8GaFXdcY7F7efzgxrAg=;
        b=WRsFQag+jKOnJqvltp/lr2HFFP/oTBrRNwEvrYBiy0HahwG4kVCtfPduvenszAiOnd
         iutJ6feT5U0ay3rkMc3sHY69xQdoecSXUtIX5wPTGO6v5su+yswISs2dOqMmC7Bo4hIm
         3amMh3tMsy5QLaHqwTRFyRJHsmVfywlG+d6FYtfxDWA/L2nY/AMt8+HUQqYY6rST56ss
         27jksGpkgTF57d8DSY8k+q4kNpl80gD+Ea4UEnCY5viun0yDUPlzkYpINBplLqtHWhcw
         kZynClu3v9Ey4YibVRlSvEPbjRBtiSzxF2ZR1rhWiLJj9ktSsGOWWRhzoFOMv0K1OpaK
         y3fA==
X-Gm-Message-State: ACrzQf2zAwxK4BnLLMzZOp4bsA/Bz5jX6xlEhqYo4XCpPd9rrDzZPrqP
        ae5CuDUxt48+XGqQU9CW9su/wX1algXTZDFZ2KGU9AGuAY6CJK3F63YPS6qeDQdXJrcrFX8pGUa
        Vvdro6M/m9gSvHPAnOPFmoIaS6U2iIvUvjgpquT9x
X-Received: by 2002:a05:6512:3d9f:b0:4a2:4986:281 with SMTP id k31-20020a0565123d9f00b004a249860281mr1516685lfv.123.1664850288917;
        Mon, 03 Oct 2022 19:24:48 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM43JpG4+HkP34BMh00KTDXXzJi6U2FMyVKrOOV9rwvThgPq3E1KX8F6iiYpkGCS/29GDwP66I2XdKeeelgNxP8=
X-Received: by 2002:a05:6512:3d9f:b0:4a2:4986:281 with SMTP id
 k31-20020a0565123d9f00b004a249860281mr1516681lfv.123.1664850288711; Mon, 03
 Oct 2022 19:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220930105434.111407-1-broonie@kernel.org> <20221004132047.435d42db@canb.auug.org.au>
In-Reply-To: <20221004132047.435d42db@canb.auug.org.au>
From:   David Airlie <airlied@redhat.com>
Date:   Tue, 4 Oct 2022 12:24:37 +1000
Message-ID: <CAMwc25oshRcJBoCT70B+b42bh5sPqgyoHuBx6K6ZLrwBMHnJzw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the drm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     broonie@kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 4, 2022 at 12:21 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi broonie@kernel.org,
>
> On Fri, 30 Sep 2022 11:54:34 +0100 broonie@kernel.org wrote:
> >
> > After merging the drm tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >
> > /tmp/next/build/drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c: In function 'dc_stream_remove_writeback':
> > /tmp/next/build/drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:527:55: error: array subscript [0, 0] is outside array bounds of 'struct dc_writeback_info[1]' [-Werror=array-bounds]
> >   527 |     stream->writeback_info[j] = stream->writeback_info[i];
> >       |                                 ~~~~~~~~~~~~~~~~~~~~~~^~~
> > cc1: all warnings being treated as errors
> >
> > Caused by
> >
> >     5d8c3e836fc224 ("drm/amd/display: fix array-bounds error in dc_stream_remove_writeback()")
> >
> > I have reverted that commit for today.
>
> I am still getting this failure.  The full error is:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c: In function 'dc_stream_remove_writeback':
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:527:83: error: array subscript [0, 0] is outside array bounds of 'struct dc_writeback_info[1]' [-Werror=array-bounds]
>   527 |                                 stream->writeback_info[j] = stream->writeback_info[i];
>       |                                                             ~~~~~~~~~~~~~~~~~~~~~~^~~
> In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc.h:1269,
>                  from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:29,
>                  from drivers/gpu/drm/amd/amdgpu/../display/dc/basics/dc_common.h:29,
>                  from drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:27:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dc_stream.h:241:34: note: while referencing 'writeback_info'
>   241 |         struct dc_writeback_info writeback_info[MAX_DWB_PIPES];
>       |                                  ^~~~~~~~~~~~~~

I'm not seeing it here, what gcc is this with?

Dave.

