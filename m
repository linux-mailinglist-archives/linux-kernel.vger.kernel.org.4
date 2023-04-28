Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFEE6F166A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345763AbjD1LKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 07:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345700AbjD1LKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:10:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C75D44B6;
        Fri, 28 Apr 2023 04:10:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9305642E2;
        Fri, 28 Apr 2023 11:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2E4C433A8;
        Fri, 28 Apr 2023 11:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682680248;
        bh=MgfPMfiKjI0tNegcTrXd2ZOXVx68i9D4rnYhMXY2OtQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=niadc1KLJ5jjSy0V0s6jR4CaWAsX8tkW40W47LEu5MIozrpJDPc6i0Bk3UfrXFU7M
         PMBJLMGq1KJJKyhZchZOrcVhuZKTLZSLRgMjj5Rlfd2JkLGde8S/KyqJ3n20J+0T1M
         RyTdZoiWogIYYfh2reQi5ZTGhPUGFbWph2Pvz33D/HbBQf9KeL2Q4GaO2VKoVjOWqI
         W8LqGxtaYWQA0yAwNReSVWBbQq54BbeV8m//2LoLXfchQleIz2SQUwpwDrXmMhvYOw
         vbJH81jhp/7aZF4V9Xzuui2E1GGxemmZPm47ROf0IBHloCDg1lgbCk/i00fAFiC7Ka
         f5tYb9qf+C6/Q==
Message-ID: <3328747ef568361bd3bd5f053ec9a2c27e7f9c48.camel@kernel.org>
Subject: Re: [PATCH] ceph: Reorder fields in 'struct ceph_snapid_map'
From:   Jeff Layton <jlayton@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        ceph-devel@vger.kernel.org
Date:   Fri, 28 Apr 2023 07:10:46 -0400
In-Reply-To: <f6b869ea-979c-efda-d454-8dc688d1986b@redhat.com>
References: <559c9a70419846e0cfc319505d3d5fffd45b3358.1682618727.git.christophe.jaillet@wanadoo.fr>
         <f6b869ea-979c-efda-d454-8dc688d1986b@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-04-28 at 08:53 +0800, Xiubo Li wrote:
> On 4/28/23 02:05, Christophe JAILLET wrote:
> > Group some variables based on their sizes to reduce holes.
> > On x86_64, this shrinks the size of 'struct ceph_snapid_map' from 72 to=
 64
> > bytes.
> >=20
> > When such a structure is allocated, because of the way memory allocatio=
n
> > works, when 72 bytes were requested, 96 bytes were allocated.
> >=20
> > So, on x86_64, this change saves 32 bytes per allocation and has the
> > structure fit in a single cacheline.
> >=20
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > Using pahole
> >=20
> > Before:
> > =3D=3D=3D=3D=3D=3D
> > struct ceph_snapid_map {
> > 	struct rb_node             node __attribute__((__aligned__(8))); /*   =
  0    24 */
> > 	struct list_head           lru;                  /*    24    16 */
> > 	atomic_t                   ref;                  /*    40     4 */
> >=20
> > 	/* XXX 4 bytes hole, try to pack */
> >=20
> > 	u64                        snap;                 /*    48     8 */
> > 	dev_t                      dev;                  /*    56     4 */
> >=20
> > 	/* XXX 4 bytes hole, try to pack */
> >=20
> > 	/* --- cacheline 1 boundary (64 bytes) --- */
> > 	long unsigned int          last_used;            /*    64     8 */
> >=20
> > 	/* size: 72, cachelines: 2, members: 6 */
> > 	/* sum members: 64, holes: 2, sum holes: 8 */
> > 	/* forced alignments: 1 */
> > 	/* last cacheline: 8 bytes */
> > } __attribute__((__aligned__(8)));
> > ---
> >   fs/ceph/mds_client.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> > index 0598faa50e2e..2328dbda5ab6 100644
> > --- a/fs/ceph/mds_client.h
> > +++ b/fs/ceph/mds_client.h
> > @@ -355,8 +355,8 @@ struct ceph_snapid_map {
> >   	struct rb_node node;
> >   	struct list_head lru;
> >   	atomic_t ref;
> > -	u64 snap;
> >   	dev_t dev;
> > +	u64 snap;
> >   	unsigned long last_used;
> >   };
> >  =20
>=20
> This looks good to me. Thanks.
>=20
> Will apply it to the testing branch.
>=20
> - Xiubo
>=20
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
