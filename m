Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A25B610CB1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiJ1JEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJ1JEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:04:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643BF1C5E05;
        Fri, 28 Oct 2022 02:04:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D5EEC219F9;
        Fri, 28 Oct 2022 09:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666947844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MnfikghvtyeYYc/3zkiU6mCaK96Xr2h09xdTH4YQqIc=;
        b=NcNdr8oJHSKD+C/iTpS3yaPeE2WV7qbapGELpmYXI7HHj00myLZuzbw8/sBmrA1UnGbHRu
        y5H+XBqNCUeNd6fFRi8DIHYwwz71M/yFV0m3+XQN9DHpBc7HHqZsrEQxlaPe3g1eouf3lF
        6I71izkOnqytLJlIsO6f4BTuCpI6+aA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666947844;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MnfikghvtyeYYc/3zkiU6mCaK96Xr2h09xdTH4YQqIc=;
        b=M1NBQLTewjyF/DmuZvD+R82g+g2M7+Zlk2nW/Mz9ZesgJ5MIgU6JJmF1ti4PEiXtJ0YmRU
        ZS03akeJEfQII8BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 791A113A6E;
        Fri, 28 Oct 2022 09:04:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WhSKGgSbW2MoDwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 28 Oct 2022 09:04:04 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id c40a8901;
        Fri, 28 Oct 2022 09:05:02 +0000 (UTC)
Date:   Fri, 28 Oct 2022 10:05:02 +0100
From:   =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ceph: fix mdsmap decode for v >= 17
Message-ID: <Y1ubPgzSm7YATBRv@suse.de>
References: <20221027152811.7603-1-lhenriques@suse.de>
 <8b666226-ef41-13ae-c90c-aaa5f499b0a0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b666226-ef41-13ae-c90c-aaa5f499b0a0@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 09:28:37AM +0800, Xiubo Li wrote:
> 
> On 27/10/2022 23:28, Luís Henriques wrote:
> > Commit d93231a6bc8a ("ceph: prevent a client from exceeding the MDS
> > maximum xattr size") was merged before the corresponding MDS-side changes
> > have been merged.  With the introduction of 'bal_rank_mask' in the mdsmap,
> > the decoding of maps with v>=17 is now incorrect.  Fix this by skipping
> > the 'bal_rank_mask' string decoding.
> > 
> > Fixes: d93231a6bc8a ("ceph: prevent a client from exceeding the MDS maximum xattr size")
> > Signed-off-by: Luís Henriques <lhenriques@suse.de>
> > ---
> > Hi!
> > 
> > This inconsistency was introduced by ceph PR #43284; I think that, before
> > picking this patch, we need to get PR #46357 merged to avoid new
> > problems.
> > 
> > Cheers,
> > --
> > Luís
> > 
> >   fs/ceph/mdsmap.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
> > index 3fbabc98e1f7..fe4f1a6c3465 100644
> > --- a/fs/ceph/mdsmap.c
> > +++ b/fs/ceph/mdsmap.c
> > @@ -379,6 +379,8 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end, bool msgr2)
> >   		ceph_decode_skip_8(p, end, bad_ext);
> >   		/* required_client_features */
> >   		ceph_decode_skip_set(p, end, 64, bad_ext);
> > +		/* bal_rank_mask */
> > +		ceph_decode_skip_string(p, end, bad_ext);
> >   		ceph_decode_64_safe(p, end, m->m_max_xattr_size, bad_ext);
> >   	} else {
> >   		/* This forces the usage of the (sync) SETXATTR Op */
> > 
> Luis,
> 
> Because the ceph PR #43284 will break kclient here and your xattr size patch
> got merged long time ago, we should fix it in ceph. More detail please see
> my comments in:
> 
> https://github.com/ceph/ceph/pull/46357#issuecomment-1294290492

OK, agreed.  I'll update this PR to try to fix it on the MDS side
instead.  And let's try to have it merged as soon as possible to prevent
further issues.

Cheers,
--
Luís
