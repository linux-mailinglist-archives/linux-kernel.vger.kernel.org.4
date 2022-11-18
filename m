Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EEE62F367
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241647AbiKRLLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241447AbiKRLLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:11:23 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718E58C4A3;
        Fri, 18 Nov 2022 03:11:21 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B59FC224B1;
        Fri, 18 Nov 2022 11:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668769879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CNnq9c7v858Ag4af5yoH9bLSAnL8u3w+0ng2vfK0G5k=;
        b=eLYy6pZKteKaGSjnm71zGGgqeb57mlaoqdE3wnoJNwDZ9Fa6wL72MNt7njxsW2yO8v+wD7
        GxOd9HnqT6JM5xW8zfX57b3bbKGj5XewO0bf3XFsiJwmpM7FgRTFwhpr6ynkHIEt/gZBnG
        5c5hB0GkHtRYKVdOkCa7WmVuBsvEs7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668769879;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CNnq9c7v858Ag4af5yoH9bLSAnL8u3w+0ng2vfK0G5k=;
        b=kmcCfCmhqx+8rV7MzohkKdgDbXFSRhOIDxm+oQdwEYMTy5j1JKJaYyQPbo+ZO8ZBi4GGUu
        WDyhlbVINI9Yi2Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E6BC13A66;
        Fri, 18 Nov 2022 11:11:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MaBJFFdod2NNXQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 18 Nov 2022 11:11:19 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id eb6b13ad;
        Fri, 18 Nov 2022 11:12:20 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ceph: make sure directories aren't complete after
 setting crypt context
References: <20221116153703.27292-1-lhenriques@suse.de>
        <5de0ae69-5e3d-2ccb-64a3-971db66477f8@redhat.com>
        <41710b3d-b37f-8c65-d55d-c4137a366efd@redhat.com>
        <87o7t5mpby.fsf@suse.de>
        <116d12db-5c24-9a57-79a9-b7a02a0bb4c2@redhat.com>
Date:   Fri, 18 Nov 2022 11:12:20 +0000
In-Reply-To: <116d12db-5c24-9a57-79a9-b7a02a0bb4c2@redhat.com> (Xiubo Li's
        message of "Fri, 18 Nov 2022 13:24:10 +0800")
Message-ID: <87k03sms8b.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xiubo Li <xiubli@redhat.com> writes:

> On 18/11/2022 02:02, Lu=C3=ADs Henriques wrote:
>> Xiubo Li <xiubli@redhat.com> writes:
>>
>>> On 17/11/2022 16:03, Xiubo Li wrote:
>>>> On 16/11/2022 23:37, Lu=C3=ADs Henriques wrote:
>>>>> When setting a directory's crypt context, __ceph_dir_clear_complete()=
 needs
>>>>> to be used otherwise, if it was complete before, any old dentry that'=
s still
>>>>> around will be valid.
>>>>>
>>>>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>>>>> ---
>>>>> Hi!
>>>>>
>>>>> Here's a simple way to trigger the bug this patch is fixing:
>>>>>
>>>>> # cd /cephfs
>>>>> # ls mydir
>>>>> nKRhofOAVNsAwVLvDw7a0c9ypsjbZfK3n0Npnmni6j0
>>>>> # ls mydir/nKRhofOAVNsAwVLvDw7a0c9ypsjbZfK3n0Npnmni6j0/
>>>>> Cyuer5xT+kBlEPgtwAqSj0WK2taEljP5vHZ,D8VXCJ8
>>>>> u+46b2XVCt7Obpz0gznZyNLRj79Q2l4KmkwbKOzdQKw
>>>>> # fscrypt unlock mydir
>>>>> # touch /mnt/test/mydir/mysubdir/file
>>>>> touch: cannot touch '/mnt/test/mydir/mysubdir/file': No such file or
>>>>> directory
>>>>>
>>>>>  =C2=A0 fs/ceph/crypto.c | 4 ++++
>>>>>  =C2=A0 1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
>>>>> index 35a2ccfe6899..dc1557967032 100644
>>>>> --- a/fs/ceph/crypto.c
>>>>> +++ b/fs/ceph/crypto.c
>>>>> @@ -87,6 +87,10 @@ static int ceph_crypt_get_context(struct inode *in=
ode,
>>>>> void *ctx, size_t len)
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ERANG=
E;
>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(ctx, cfa->cfa_blob, ctx=
len);
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 /* Directory isn't complete anymore */
>>>>> +=C2=A0=C2=A0=C2=A0 if (S_ISDIR(inode->i_mode) && __ceph_dir_is_compl=
ete(ci))
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __ceph_dir_clear_complete=
(ci);
>>>> Hi Luis,
>>>>
>>>> Good catch!
>>>>
>>>> BTW, why do this in the ceph_crypt_get_context() ? As my understanding=
 is that
>>>> we should mark 'mydir' as incomplete when unlocking it. While as I rem=
embered
>>>> the unlock operation will do:
>>>>
>>>>
>>>> Step1: get_encpolicy via 'mydir' as ctx
>>>> Step2: rm_enckey of ctx from the superblock
>>>>
>>> Sorry, it should be add_enckey.
>>>> Since I am still running the test cases for the file lock patches, so =
I didn't
>>>> catch logs to confirm the above steps yet.
>>>>
>>>> If I am right IMO then we should mark the dir as incomplete in the Ste=
p2
>>>> instead, because for non-unlock operations they may also do the Step1.
>>>>
>>> Your patch will work. But probably we should do this just around
>>> __fscrypt_prepare_readdir() or fscrypt_prepare_readdir() instead ? We n=
eed to
>>> detect that once the 'inode->i_crypt_info' changed then mark the dir as
>>> incomplete.
>>>
>>> For now for the lock operation it will evict the inode, which will help=
 do this
>>> for us already. But for unlock case, we need to handle it by ourself.
>> OK, that makes sense and to be honest I thought that there should be
>> another place for doing this. Unfortunately, I didn't found it: in the
>> test case I have the fscrypt_prepare_readdir() isn't called:
>>
>>     # cd /cephfs
>>     # ls mydir
>>     nKRhofOAVNsAwVLvDw7a0c9ypsjbZfK3n0Npnmni6j0
>>     # ls mydir/nKRhofOAVNsAwVLvDw7a0c9ypsjbZfK3n0Npnmni6j0/
>>     Cyuer5xT+kBlEPgtwAqSj0WK2taEljP5vHZ,D8VXCJ8 u+46b2XVCt7Obpz0gznZyNLR=
j79Q2l4KmkwbKOzdQKw
>>
>> At this point readdir was executed, of course.  And
>> __ceph_dir_set_complete() is also used to indicate that we have the full
>> contents.  However, executing the following commands won't result in any
>> new readdir():
>>
>>     # fscrypt unlock mydir
>>     # touch /mnt/test/mydir/mysubdir/file
>>
>> and since the encryption key is set at the sb level, I couldn't find a w=
ay
>> to detect changes in inode->i_crypt_info.  ceph_d_revalidate() is invoked
>> but at that point I don't thing we have a way to know what is changing.
>>
>> Any ideas?
>
> # ls mydir/
> zy94Zt01M90xwYq+nxJsEvea+HYq49mqVgrUBkYrJAU
> # ls mydir/zy94Zt01M90xwYq+nxJsEvea+HYq49mqVgrUBkYrJAU/
> 24iNa8ICYc6nZZIkL,4n1sOtp9KiaTGtpq8PCZDQ6LU
> ivG4rQYzg6YENagbTZaV2kh2sVouEdlkmBZPfgVDl48
>
> I have added the debug logs in all the places just like:
>
> @@ -784,7 +786,9 @@ static struct dentry *ceph_lookup(struct inode *dir, =
struct
> dentry *dentry,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return ERR_PTR(-ENAMETOOLONG);
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ENCRYPTED(dir)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printk("%s fscrypt_has_encryption_k=
ey(dir): %d =3D=3D=3D=3D=3D=3D\n", __func__,
> fscrypt_has_encryption_key(dir));
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 err =3D __fscrypt_prepare_readdir(dir);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printk("%s fscrypt_has_encryption_k=
ey(dir): %d =3D=3D=3D=3D=3D=3D\n", __func__,
> fscrypt_has_encryption_key(dir));
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (err)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return E=
RR_PTR(err);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (!fscrypt_has_encryption_key(dir)) {
>
>
> # fscrypt unlock mydir
> Enter custom passphrase for protector "l":
> "mydir" is now unlocked and ready for use.
>
> And after "mydir/" was unlocked and then when doing:
>
> # touch mydir/dir/file2
>
> And when lookup the "dir/" dentry I can see the "mydir/" encryption key c=
hanged:
>
> 709 <7>[79125.023676] ceph:=C2=A0 __ceph_caps_issued_mask ino 0x100000000=
04 cap
> 000000004dc11892 issued pAsLsXsFs (mask As)
> 710 <7>[79125.023687] ceph:=C2=A0 __touch_cap 000000007071b095 cap 000000=
004dc11892
> mds0
> 711 <7>[79125.023823] ceph:=C2=A0 lookup 000000007071b095 dentry 00000000=
f97501b2
> 'dir'
> 712 <4>[79125.023838] ceph_lookup fscrypt_has_encryption_key(dir): 0 =3D=
=3D=3D=3D=3D=3D
> 713 <4>[79125.024186] ceph_lookup fscrypt_has_encryption_key(dir): 1 =3D=
=3D=3D=3D=3D=3D
> 714 <7>[79125.024194] ceph:=C2=A0=C2=A0 dir 000000007071b095 flags are 0x0
> 715 <7>[79125.024269] ceph:=C2=A0 do_request on 00000000a93fafef
>
> I am thinking could we just make __fscrypt_prepare_readdir(), which will =
return
> 0 when the key is already set or successfully set, to return 1 instead of=
 0 to
> mark that the key changed ?

OK, I see what you mean.  Thanks.  What about simply detect this change
here instead of changing __fscrypt_prepare_readdir() semantics?  Because I
think that would require changes in several other places, including other
filesystems.

What about something like this?

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index edc2bf0aab83..499ec75d2496 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -784,6 +784,8 @@ static struct dentry *ceph_lookup(struct inode *dir, st=
ruct dentry *dentry,
 		return ERR_PTR(-ENAMETOOLONG);
=20
 	if (IS_ENCRYPTED(dir)) {
+		bool had_key =3D fscrypt_has_encryption_key(dir);
+
 		err =3D __fscrypt_prepare_readdir(dir);
 		if (err)
 			return ERR_PTR(err);
@@ -791,6 +793,8 @@ static struct dentry *ceph_lookup(struct inode *dir, st=
ruct dentry *dentry,
 			spin_lock(&dentry->d_lock);
 			dentry->d_flags |=3D DCACHE_NOKEY_NAME;
 			spin_unlock(&dentry->d_lock);
+		} else if (!had_key) {
+			__ceph_dir_clear_complete(ceph_inode(dir));
 		}
 	}
=20
Cheers,
--=20
Lu=C3=ADs
