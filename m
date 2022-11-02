Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8450F6161FD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 12:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiKBLrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 07:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKBLrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 07:47:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9991827DFE;
        Wed,  2 Nov 2022 04:47:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 32BD01F8BE;
        Wed,  2 Nov 2022 11:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667389670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EbYrB+1vSr1UNNNQD2qKBkA3iRJw6rUD5tHYLyLGBgc=;
        b=GrfCe/K3Gq9onijd8HxqKWriuCUf7AHUaKmTSSqv0mwUMm52w//PrrSB0C35cAcngThhWN
        YJy7FbWhMfhj5hwUU4A7nCNHJI5mOFKS/bNaZIKLhY91GqrQAPWvpi13ej7p2+EwSuMFSu
        0qlB8PohHeFWBhrY8cspLyaqsGZgsjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667389670;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EbYrB+1vSr1UNNNQD2qKBkA3iRJw6rUD5tHYLyLGBgc=;
        b=hPnMxSoREYA/EjsRPO0RTlto/fa/D7ZKhpnHpylfB+C+agSTt93hUMpq6jqt4d88xJ6zOj
        gHh7F5b7ebtJTLDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D04B0139D3;
        Wed,  2 Nov 2022 11:47:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HHUgMOVYYmNmfQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Wed, 02 Nov 2022 11:47:49 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 77ce4722;
        Wed, 2 Nov 2022 11:48:51 +0000 (UTC)
Date:   Wed, 2 Nov 2022 11:48:51 +0000
From:   =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ceph: allow encrypting a directory while not having
 Ax caps
Message-ID: <Y2JZI1QOl3dXBVUb@suse.de>
References: <20221027112653.12122-1-lhenriques@suse.de>
 <a992d844-6d75-e134-60e1-acb8c8972ff3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a992d844-6d75-e134-60e1-acb8c8972ff3@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 05:15:51PM +0800, Xiubo Li wrote:
> 
> On 27/10/2022 19:26, Luís Henriques wrote:
> > If a client doesn't have Fx caps on a directory, it will get errors while
> > trying encrypt it:
> > 
> > ceph: handle_cap_grant: cap grant attempt to change fscrypt_auth on non-I_NEW inode (old len 0 new len 48)
> > fscrypt (ceph, inode 1099511627812): Error -105 getting encryption context
> > 
> > A simple way to reproduce this is to use two clients:
> > 
> >      client1 # mkdir /mnt/mydir
> > 
> >      client2 # ls /mnt/mydir
> > 
> >      client1 # fscrypt encrypt /mnt/mydir
> >      client1 # echo hello > /mnt/mydir/world
> > 
> > This happens because, in __ceph_setattr(), we only initialize
> > ci->fscrypt_auth if we have Ax.  If we don't have, we'll need to do that
> > later, in handle_cap_grant().
> > 
> > Signed-off-by: Luís Henriques <lhenriques@suse.de>
> > ---
> > Hi!
> > 
> > To be honest, I'm not really sure about the conditions in the 'if': shall
> > I bother checking it's really a dir and that it is empty?
> > 
> > Cheers,
> > --
> > Luís
> > 
> >   fs/ceph/caps.c | 26 +++++++++++++++++++++++---
> >   1 file changed, 23 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> > index 443fce066d42..e33b5c276cf3 100644
> > --- a/fs/ceph/caps.c
> > +++ b/fs/ceph/caps.c
> > @@ -3511,9 +3511,29 @@ static void handle_cap_grant(struct inode *inode,
> >   		     from_kuid(&init_user_ns, inode->i_uid),
> >   		     from_kgid(&init_user_ns, inode->i_gid));
> >   #if IS_ENABLED(CONFIG_FS_ENCRYPTION)
> > -		if (ci->fscrypt_auth_len != extra_info->fscrypt_auth_len ||
> > -		    memcmp(ci->fscrypt_auth, extra_info->fscrypt_auth,
> > -			   ci->fscrypt_auth_len))
> > +		if ((ci->fscrypt_auth_len == 0) &&
> > +		    (extra_info->fscrypt_auth_len > 0) &&
> > +		    S_ISDIR(inode->i_mode) &&
> > +		    (ci->i_rsubdirs + ci->i_rfiles == 1)) {
> > +			/*
> > +			 * We'll get here when setting up an encrypted directory
> > +			 * but we don't have Fx in that directory, i.e. other
> > +			 * clients have accessed this directory too.
> > +			 */
> > +			ci->fscrypt_auth = kmemdup(extra_info->fscrypt_auth,
> > +						   extra_info->fscrypt_auth_len,
> > +						   GFP_KERNEL);
> > +			if (ci->fscrypt_auth) {
> > +				inode->i_flags |= S_ENCRYPTED;
> > +				ci->fscrypt_auth_len = extra_info->fscrypt_auth_len;
> > +			} else {
> > +				pr_err("Failed to alloc memory for %llx.%llx fscrypt_auth\n",
> > +					ceph_vinop(inode));
> > +			}
> > +			dout("ino %llx.%llx is now encrypted\n", ceph_vinop(inode));
> > +		} else if (ci->fscrypt_auth_len != extra_info->fscrypt_auth_len ||
> > +			   memcmp(ci->fscrypt_auth, extra_info->fscrypt_auth,
> > +				  ci->fscrypt_auth_len))
> >   			pr_warn_ratelimited("%s: cap grant attempt to change fscrypt_auth on non-I_NEW inode (old len %d new len %d)\n",
> >   				__func__, ci->fscrypt_auth_len, extra_info->fscrypt_auth_len);
> >   #endif
> 
> Hi Luis,
> 
> Thanks for your time on this bug.
> 
> IMO we should fix this in ceph_fill_inode():
> 
>  995 #ifdef CONFIG_FS_ENCRYPTION
>  996         if (iinfo->fscrypt_auth_len && (inode->i_state & I_NEW)) {
>  997                 kfree(ci->fscrypt_auth);
>  998                 ci->fscrypt_auth_len = iinfo->fscrypt_auth_len;
>  999                 ci->fscrypt_auth = iinfo->fscrypt_auth;
> 1000                 iinfo->fscrypt_auth = NULL;
> 1001                 iinfo->fscrypt_auth_len = 0;
> 1002                 inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
> 1003         }
> 1004 #endif
> 
> The setattr will get a reply from MDS including the fscrypt auth info, I
> think the kclient just drop it here.

I've done some testing and I don't really see this code kfree'ing a valid
fscrypt_auth here.  However, I guess it is possible to fix this issue here
too, but in a different way, by changing that 'if' condition to:

	if (iinfo->fscrypt_auth_len &&
	    ((inode->i_state & I_NEW) || (ci->fscrypt_auth_len == 0))) {
	...
	}

I'm not really sure if this is sane though.  When we loose the 'Ax' caps
(another client as accessed the directory we're encrypting), we also seem
to loose the I_NEW state.  Using the above code seems to work for the
testcase in my patch, but I'm not sure it won't break something else.

Cheers,
--
Luís

> If we fix it in handle_cap_grant() I am afraid this bug still exists. What
> if there is no any new caps will be issued or revoked recently and then
> access to the directory ?
> 
> Thanks
> 
> - Xiubo
> 
> > 
> 

