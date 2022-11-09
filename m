Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CFC622898
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiKIKhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiKIKhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:37:05 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4EA1A222;
        Wed,  9 Nov 2022 02:37:04 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 168FF225EC;
        Wed,  9 Nov 2022 10:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667990223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PTFgvjXWv3n/EyOFo+Gn65eHKp4vrNFiybKk0Lhb4sk=;
        b=gXNQBDbmjlsgp588+LUzu7wzA8UxZILvj45/6YZLB7i4G51xTE2MGemwx/7ZTLsceOGOZ+
        woGy/tMQpCUSo0SiqaxFpvQ1Zm8pm1HVfdP91aQfbrJ5Eca8gQiMX2SeocwYTfPdSRwGip
        /NOIpKvk7OL7IHo/FDuv97wNUEwUXp4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667990223;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PTFgvjXWv3n/EyOFo+Gn65eHKp4vrNFiybKk0Lhb4sk=;
        b=6+oN0DLXt1cuL0OAvI7l8TQ6wSpbSpAWwXEYC16QDK1uAMqspD0x7W5p9yDVSp28o72kiN
        C3XEB9pNVzwUTZBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A29AD139F1;
        Wed,  9 Nov 2022 10:37:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +4vgI86Ca2OoHAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Wed, 09 Nov 2022 10:37:02 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id a0c8f054;
        Wed, 9 Nov 2022 10:38:03 +0000 (UTC)
Date:   Wed, 9 Nov 2022 10:38:03 +0000
From:   =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ceph: fix memory leak in mount error path when using
 test_dummy_encryption
Message-ID: <Y2uDCwDf+ZgKcRqu@suse.de>
References: <20221108143421.30993-1-lhenriques@suse.de>
 <215b729e-0af0-45d8-96af-3d3c319581c9@redhat.com>
 <Y2tz8zQPlTWtfOdw@suse.de>
 <614e430a-a559-e640-b2f3-020db758c061@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <614e430a-a559-e640-b2f3-020db758c061@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 05:57:41PM +0800, Xiubo Li wrote:
> Hi Luis,
> 
> Please check https://github.com/ceph/ceph-client/commit/205efda80b6759a741dde209a7158a5bbf044d23#diff-eb62c69f842ed95a7d047262a62946b07eda52f2ea49ae33c39ea13754dfc291.

Ugh! That's quite confusing :-)

I did a 'git fetch' and looked into commit 205efda80b67 ("ceph: implement
-o test_dummy_encryption mount option") instead, and compared it with it's
version in the wip-fscrypt branch.  It looks good to me: the only
difference I see is my fix (adding the 'ceph_fscrypt_free_dummy_policy'
call to 'ceph_real_mount').  Thanks!

Cheers,
--
Luís

> 
> Currently I only applied it into the 'testing' branch.
> 
> Thanks!
> 
> - Xiubo
> 
> 
> On 09/11/2022 17:33, Luís Henriques wrote:
> > On Wed, Nov 09, 2022 at 11:08:49AM +0800, Xiubo Li wrote:
> > > On 08/11/2022 22:34, Luís Henriques wrote:
> > > > Because ceph_init_fs_context() will never be invoced in case we get a
> > > > mount error, destroy_mount_options() won't be releasing fscrypt resources
> > > > with fscrypt_free_dummy_policy().  This will result in a memory leak.  Add
> > > > an invocation to this function in the mount error path.
> > > > 
> > > > Signed-off-by: Luís Henriques <lhenriques@suse.de>
> > > > ---
> > > > * Changes since v1:
> > > > 
> > > > As suggested by Xiubo, moved fscrypt free from ceph_get_tree() to
> > > > ceph_real_mount().
> > > > 
> > > > (Also used 'git format-patch' with '--base' so that the bots know what to
> > > > (not) do with this patch.)
> > > > 
> > > >    fs/ceph/super.c | 1 +
> > > >    1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> > > > index 2224d44d21c0..f10a076f47e5 100644
> > > > --- a/fs/ceph/super.c
> > > > +++ b/fs/ceph/super.c
> > > > @@ -1196,6 +1196,7 @@ static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc,
> > > >    out:
> > > >    	mutex_unlock(&fsc->client->mount_mutex);
> > > > +	ceph_fscrypt_free_dummy_policy(fsc);
> > > >    	return ERR_PTR(err);
> > > >    }
> > > > 
> > > > base-commit: 8b9ee21dfceadd4cc35a87bbe7f0ad547cffa1be
> > > > prerequisite-patch-id: 34ba9e6b37b68668d261ddbda7858ee6f83c82fa
> > > > prerequisite-patch-id: 87f1b323c29ab8d0a6d012d30fdc39bc49179624
> > > > prerequisite-patch-id: c94f448ef026375b10748457a3aa46070aa7046e
> > > > 
> > > LGTM.
> > > 
> > > Thanks Luis.
> > > 
> > > Could I fold this into the previous commit ?
> > Yes, sure.  I'm fine with that.
> > 
> > Cheers,
> > --
> > Luís
> > 
> 
