Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8477364D3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjFTHgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjFTHfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:35:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAEC10DB;
        Tue, 20 Jun 2023 00:34:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA2BE6102A;
        Tue, 20 Jun 2023 07:34:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3244FC433C0;
        Tue, 20 Jun 2023 07:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687246484;
        bh=x4bDx7j3zJPo8H1+HoyMmJ95wfLoimCtDNuaHTR7vGc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LJ32k4sITWRFtBWDLlr5Rq2XN6LHpbTj5I6Iss6pPs8sYAePnlfRkMV2WIV4UfkFC
         uJD0j+E4w0a2YvZQGw3a+9i7PzNAc49bz6L9WX1yMcl8iznNVyqUGQaJUTDo27zMWv
         NNOJP1Lk/3Y+7CSuflPI7S4cwhOHHPSo97NQLtXPo/CU4YGavtCTuDJtjJzpzDIvf8
         8cE4WvKAE22FULUIspt69sqo011iUeJD3f6GHXwDCDJOO/kbWDof79WzBtULI527AZ
         VoLkfbxh797lZsgh/0TkOZNam9AfSmgpxgE3MsTgxY8gZUKLDDOun2o2tBQrF377dh
         fruysrJDc1g9w==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-570808d8ddeso41631177b3.0;
        Tue, 20 Jun 2023 00:34:44 -0700 (PDT)
X-Gm-Message-State: AC+VfDzXLDDI9n4tCZ1qXag1vmdLydmOR2DGgjuXyDdwZhYJy0nw4xLY
        KyUZ73/RG6xZJcqSU/6FXMZXqsrynyo7gJEEa48=
X-Google-Smtp-Source: ACHHUZ6nt1vkY6cIKx9+/4bUFnQjhbMy8aHOW7xNwL8tzPMzbveQbjE9R8a8Nbt4TPn8xorqrMkdKylDP3/d4tqRQzw=
X-Received: by 2002:a25:e786:0:b0:b9e:b9b4:bb12 with SMTP id
 e128-20020a25e786000000b00b9eb9b4bb12mr8461938ybh.48.1687246483175; Tue, 20
 Jun 2023 00:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230620004217.4700-1-dakr@redhat.com> <2c92bae3-0003-3c53-8ef1-6e12e5413995@redhat.com>
 <CAPM=9tzMzfuMN_iGD-97_o=QQEDT6Mbb9_u=z_o49TeT7=XUFA@mail.gmail.com>
 <CAFCwf11OwnoxPWHuS_55OXKE7wfHH++1Bk_37DATeCiT07GtMQ@mail.gmail.com> <CAPM=9tyv5Fje0iL0-2oJQBKEsg-nc-YV9q4BSg5SwnBvGvrzDw@mail.gmail.com>
In-Reply-To: <CAPM=9tyv5Fje0iL0-2oJQBKEsg-nc-YV9q4BSg5SwnBvGvrzDw@mail.gmail.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Tue, 20 Jun 2023 10:34:16 +0300
X-Gmail-Original-Message-ID: <CAFCwf10w37OR_sxUkvORe2AoHTPE08891aMtVnrKJfa9SGTeZA@mail.gmail.com>
Message-ID: <CAFCwf10w37OR_sxUkvORe2AoHTPE08891aMtVnrKJfa9SGTeZA@mail.gmail.com>
Subject: Re: [PATCH drm-next v5 00/14] [RFC] DRM GPUVA Manager & Nouveau
 VM_BIND UAPI
To:     Dave Airlie <airlied@gmail.com>
Cc:     Danilo Krummrich <dakr@redhat.com>,
        Donald Robson <Donald.Robson@imgtec.com>, daniel@ffwll.ch,
        tzimmermann@suse.de, mripard@kernel.org, corbet@lwn.net,
        christian.koenig@amd.com, bskeggs@redhat.com,
        Liam.Howlett@oracle.com, matthew.brost@intel.com,
        boris.brezillon@collabora.com, alexdeucher@gmail.com,
        bagasdotme@gmail.com, willy@infradead.org, jason@jlekstrand.net,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 10:13=E2=80=AFAM Dave Airlie <airlied@gmail.com> wr=
ote:
>
> On Tue, 20 Jun 2023 at 17:06, Oded Gabbay <ogabbay@kernel.org> wrote:
> >
> > On Tue, Jun 20, 2023 at 7:05=E2=80=AFAM Dave Airlie <airlied@gmail.com>=
 wrote:
> > >
> > > Since this is feature is nouveau only currently and doesn't disturb
> > > the current nouveau code paths, I'd like to try and get this work in
> > > tree so other drivers can work from it.
> > >
> > > If there are any major objections to this, I'm happy to pull it back
> > > out again, but I'd like to get some acks/rb in the next couple of day=
s
> > > in order to land some of it.
> > >
> > > Dave.
> > >
> > >
> > > >
> > > > forgot to add your email address to the patch series - sorry about =
that.
> > > >
> > > > This series (v5) contains the Documentation changes you requested.
> > > >
> > > > - Danilo
> > > >
> > > > On 6/20/23 02:42, Danilo Krummrich wrote:
> > > > > This patch series provides a new UAPI for the Nouveau driver in o=
rder to
> > > > > support Vulkan features, such as sparse bindings and sparse resid=
ency.
> > > > >
> > > > > Furthermore, with the DRM GPUVA manager it provides a new DRM cor=
e feature to
> > > > > keep track of GPU virtual address (VA) mappings in a more generic=
 way.
> > > > >
> > > > > The DRM GPUVA manager is indented to help drivers implement users=
pace-manageable
> > > > > GPU VA spaces in reference to the Vulkan API. In order to achieve=
 this goal it
> > > > > serves the following purposes in this context.
> > > > >
> > > > >      1) Provide infrastructure to track GPU VA allocations and ma=
ppings,
> > > > >         making use of the maple_tree.
> > > > >
> > > > >      2) Generically connect GPU VA mappings to their backing buff=
ers, in
> > > > >         particular DRM GEM objects.
> > Will this manager be able to connect GPU VA mappings to host memory
> > allocations (aka user pointers) ?
> >
> > I only skimmed over the uapi definitions, but from that quick glance I
> > saw you can only pass a (gem) handle to the vm bind uapi.
> >
> > I think it is an important feature because you don't want to have two
> > GPU VA managers running in your driver (if that's even possible).
> > Maybe we should at least try to make sure the uapi is/will be
> > compatible with such an extension.
> >
>
> I think that would have to be a new uAPI entry point anyways, since
> managing user ptrs is extra, but the uAPI is nouveau specific and
> nouveau has no hostptr support as of now.
>
> The gpuva manager is kernel internal, I think adding host ptr tracking
> is useful, but I don't think it's a blocker right now.
>
> One of the reasons I'd like to get this in the tree is to add things
> like that instead of overloading this initial patchset with feature
> creep.
>
> Dave.
ok, that makes sense.
Thanks,
Oded
