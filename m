Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565CA61F052
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiKGKXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbiKGKWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:22:42 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01D4183BD;
        Mon,  7 Nov 2022 02:22:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 53678225CC;
        Mon,  7 Nov 2022 10:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667816560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jCn4MseqJcnTtCYiGPVCPesbMSniSjoMzrXJhKB4vOo=;
        b=XaQBv0h9JvOYe7ohJxNKojp4Gtl5Alz8BCNE73/RUsBKadqlIIfNqd7q4NI0AFPJ/SDHDs
        mEKdVd97gJJo2+CmnHBqB9rq/ePUz3+wytLxKPYfcWdtSLCVMvYV6FdGmJJtDYrp4GYdYF
        jMWdzsuBq9Zz30AOd1MfRbQGuukHvmk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667816560;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jCn4MseqJcnTtCYiGPVCPesbMSniSjoMzrXJhKB4vOo=;
        b=g7JjvHSdfn1Wj9M/78AHzwkucfxbJUA4DRoLNUT68gTUjyaBkgq+AKVKY8vbi7Wv6/9aDf
        ZBlnYrFLauvWwmCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE47C13AC7;
        Mon,  7 Nov 2022 10:22:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yXU8N2/caGMibQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Mon, 07 Nov 2022 10:22:39 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 6389e19a;
        Mon, 7 Nov 2022 10:23:41 +0000 (UTC)
Date:   Mon, 7 Nov 2022 10:23:41 +0000
From:   =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ceph: fix memory leak in mount error path when using
 test_dummy_encryption
Message-ID: <Y2jcrbZxgmLO/psM@suse.de>
References: <20221103153619.11068-1-lhenriques@suse.de>
 <700018a6-aff7-6e7a-98df-2fc8cca39acb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <700018a6-aff7-6e7a-98df-2fc8cca39acb@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 03:47:23PM +0800, Xiubo Li wrote:
> 
> On 03/11/2022 23:36, Luís Henriques wrote:
> > Because ceph_init_fs_context() will never be invoced in case we get a
> > mount error, destroy_mount_options() won't be releasing fscrypt resources
> > with fscrypt_free_dummy_policy().  This will result in a memory leak.  Add
> > an invocation to this function in the mount error path.
> > 
> > Signed-off-by: Luís Henriques <lhenriques@suse.de>
> > ---
> >   fs/ceph/super.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> > index 2224d44d21c0..6b9fd04b25cd 100644
> > --- a/fs/ceph/super.c
> > +++ b/fs/ceph/super.c
> > @@ -1362,6 +1362,7 @@ static int ceph_get_tree(struct fs_context *fc)
> >   	ceph_mdsc_close_sessions(fsc->mdsc);
> >   	deactivate_locked_super(sb);
> > +	fscrypt_free_dummy_policy(&fsc->fsc_dummy_enc_policy);
> 
> Hi Luis,
> 
> BTW, any reason the following code won't be triggered ?
> 
> deactivate_locked_super(sb);
> 
>   --> fs->kill_sb(s);
> 
>         --> ceph_kill_sb()
> 
>               --> kill_anon_super()
> 
>                     --> generic_shutdown_super()
> 
>                           --> sop->put_super()
> 
>                                 --> ceph_put_super()
> 
>                                       --> ceph_fscrypt_free_dummy_policy()
> 
>                                            --> fscrypt_free_dummy_policy(
> 

Here's what I'm seeing here:

  sys_mount->path_mount->do_new_mount->vfs_get_tree->ceph_get_tree

ceph_get_tree() fails due to ceph_real_mount() returning an error.  My
understanding is that that, since fc->root is never set, that code path
will never be triggered.  Does that make sense?

An easy way to reproduce is by running fstest ceph/005 with the
'test_dummy_encryption' option.  (I'll probably need to send a patch to
disable this test when this option is present.)

Cheers,
--
Luís
