Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9108063D2DE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235599AbiK3KLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbiK3KLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:11:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701003122A;
        Wed, 30 Nov 2022 02:11:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22E1AB81AA6;
        Wed, 30 Nov 2022 10:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178FAC433D6;
        Wed, 30 Nov 2022 10:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669803066;
        bh=iWiMxm9cmlpHRqQeOt4LtzIpVKq3GIUkq3XGUxzAxR8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QNTV37ogVWcVtB3yrnTtKMsDyDsfXcUPIQ1amowdO3xAt7x6JkUaddnG/m0VvnANA
         obBt6fVZG7XAQeTQlmUf87eEz935uC95M6GIBXaWrYUg6nzE3W+/qJ9QksFvQiw1a+
         11KnfV2bwVGgXGxBZQyiOKqNikg/skeVsYdWzvHpUpmfsO0HSG1JP9LLNOc82pvz6o
         MxV5NrTCp+c5u32JdTL2c5ugFkv54BA/DxPtNOlhSwO0Mr3yWRJyjZp/m416MUye6T
         uqBov2RA3isYNvlppT3jLg18XWEZ0j7o4FKE7hyZ6YOiBTipEb70LzEXqr4f7TpHDE
         qSXwbhilqeSrw==
Message-ID: <1401f070248db62f0b41092db4bb3550861063af.camel@kernel.org>
Subject: Re: [PATCH v4] ceph: mark directory as non-complete complete after
 loading key
From:   Jeff Layton <jlayton@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>, Gregory Farnum <gfarnum@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     Venky Shankar <vshankar@redhat.com>,
        =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 30 Nov 2022 05:11:04 -0500
In-Reply-To: <4b7ccbee-1135-09a7-9255-2f84e8907614@redhat.com>
References: <20221129103949.19737-1-lhenriques@suse.de>
         <4914a195-edc0-747b-6598-9ac9868593a1@redhat.com>
         <CAOi1vP8raoFP2dsc6RY1fONCsHh5FYv2xifFY7pHXZWX=-vePw@mail.gmail.com>
         <20e0674a-4e51-a352-9ce2-d939cd4f3725@redhat.com>
         <CAOi1vP_H8jE4ZU4a4srhQev3odECgZD1LyxA8dv+Fk-bVDvoyQ@mail.gmail.com>
         <CAJ4mKGb=_CWTh5rrAFiib66-S6WeT=ajjkN_pOAac4d8uC9fDQ@mail.gmail.com>
         <4b7ccbee-1135-09a7-9255-2f84e8907614@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1 (3.46.1-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-11-30 at 16:25 +0800, Xiubo Li wrote:
> On 30/11/2022 14:54, Gregory Farnum wrote:
> > On Tue, Nov 29, 2022 at 7:21 AM Ilya Dryomov <idryomov@gmail.com> wrote=
:
> > > On Tue, Nov 29, 2022 at 3:50 PM Xiubo Li <xiubli@redhat.com> wrote:
> > > >=20
> > > > On 29/11/2022 22:32, Ilya Dryomov wrote:
> > > > > On Tue, Nov 29, 2022 at 3:15 PM Xiubo Li <xiubli@redhat.com> wrot=
e:
> > > > > > On 29/11/2022 18:39, Lu=EDs Henriques wrote:
> > > > > > > When setting a directory's crypt context, ceph_dir_clear_comp=
lete() needs to
> > > > > > > be called otherwise if it was complete before, any existing (=
old) dentry will
> > > > > > > still be valid.
> > > > > > >=20
> > > > > > > This patch adds a wrapper around __fscrypt_prepare_readdir() =
which will
> > > > > > > ensure a directory is marked as non-complete if key status ch=
anges.
> > > > > > >=20
> > > > > > > Signed-off-by: Lu=EDs Henriques <lhenriques@suse.de>
> > > > > > > ---
> > > > > > > Hi Xiubo,
> > > > > > >=20
> > > > > > > Here's a rebase of this patch.  I did some testing but since =
this branch
> > > > > > > doesn't really have full fscrypt support, I couldn't even rep=
roduce the
> > > > > > > bug.  So, my testing was limited.
> > > > > > I'm planing not to update the wip-fscrypt branch any more, exce=
pt the IO
> > > > > > path related fixes, which may introduce potential bugs each tim=
e as before.
> > > > > >=20
> > > > > > Since the qa tests PR has finished and the tests have passed, s=
o we are
> > > > > > planing to merge the first none IO part, around 27 patches. And=
 then
> > > > > > pull the reset patches from wip-fscrypt branch.
> > > > > I'm not sure if merging metadata and I/O path patches separately
> > > > > makes sense.  What would a user do with just filename encryption?
> > > > Hi Ilya,
> > > >=20
> > > > I think the IO ones should be followed soon.
> > > >=20
> > > > Currently the filename ones have been well testes. And the contents=
 will
> > > > be by passed for now.
> > > >=20
> > > > Since this is just for Dev Preview feature IMO it should be okay (?=
)
> > > I don't think there is such a thing as a Dev Preview feature when it
> > > comes to the mainline kernel, particularly in the area of filesystems
> > > and storage.  It should be ready for users at least to some extent.  =
So
> > > my question stands: what would a user do with just filename encryptio=
n?
> > I think how this merges is up to you guys and the kernel practices.
> > Merging only the filename encryption is definitely of *limited*
> > utility, but I don't think it's totally pointless -- the data versus
> > metadata paths are different and you are protecting against somewhat
> > different vulnerabilities and threat models with them. For instance,
> > MDS logs dump filenames, but OSD logs do not dump object data. There's
> > some obvious utility there even if you basically trust your provider,
> > or run your own cluster but want to be more secure about sending logs
> > via ceph-post-file.
>=20
> Hi Greg,
>=20
> Sounds reasonable to me.
>=20
> I will leave this to Ilya.
>=20
> Thanks!

For the record, the only reason I proposed merging them in multiple sets
was that it is a large set of changes and I was leery of regressions. I
don't see a lot of value in enabling just filename encryption without
the content piece.

I'd be fine with merging it all en-masse, though it's a bit more to wade
through if we end up having to bisect to track down a bug.
=20
--=20
Jeff Layton <jlayton@kernel.org>
