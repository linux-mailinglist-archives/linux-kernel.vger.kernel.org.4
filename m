Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4900632453
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiKUNve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiKUNvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:51:16 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D874265B9;
        Mon, 21 Nov 2022 05:51:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4611621D75;
        Mon, 21 Nov 2022 13:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669038672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rQ0o98zjUmMT+62Z2lW5h2Wo4qhzXmBQMYBa5yQKGcQ=;
        b=l5b6CnPeXHgdlbGMLBzXukaxU0d/JxaKxfXHafzF2MDdhV/pEfKTNa0eGYqfhEls5vy5z1
        WAAfJH4jN6BuoCH8G99/DvgOMCnE1SDcafOxaj2x+F1RLWyRTL+HJ9iZp+Ma81erxDt5bB
        tVL5+gpWojttANf3Mergj8V7J0qQTT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669038672;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rQ0o98zjUmMT+62Z2lW5h2Wo4qhzXmBQMYBa5yQKGcQ=;
        b=97j/MW4Np6j7zszERWsRzX1dThb/zJrPpGvequvfrg2+UaiCS1PIJ9dmaXmJlYI45TK5Qx
        SLPgMEjvZmIC6MBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7E2B1377F;
        Mon, 21 Nov 2022 13:51:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +JGkMU+Ce2PpBwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Mon, 21 Nov 2022 13:51:11 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id ac6dc86c;
        Mon, 21 Nov 2022 13:52:13 +0000 (UTC)
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
        <87k03sms8b.fsf@suse.de>
        <f8067bfb-95d6-c24a-8f2e-aa2229a74924@redhat.com>
Date:   Mon, 21 Nov 2022 13:52:13 +0000
In-Reply-To: <f8067bfb-95d6-c24a-8f2e-aa2229a74924@redhat.com> (Xiubo Li's
        message of "Mon, 21 Nov 2022 08:53:49 +0800")
Message-ID: <87wn7o1kky.fsf@suse.de>
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

> On 18/11/2022 19:12, Lu=C3=ADs Henriques wrote:
>> Xiubo Li <xiubli@redhat.com> writes:
>>
>>> On 18/11/2022 02:02, Lu=C3=ADs Henriques wrote:
>>>> Xiubo Li <xiubli@redhat.com> writes:
>>>>
>>>>> On 17/11/2022 16:03, Xiubo Li wrote:
>>>>>> On 16/11/2022 23:37, Lu=C3=ADs Henriques wrote:
>>>>>>> When setting a directory's crypt context, __ceph_dir_clear_complete=
() needs
>>>>>>> to be used otherwise, if it was complete before, any old dentry tha=
t's still
>>>>>>> around will be valid.
>>>>>>>
>>>>>>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>>>>>>> ---
>>>>>>> Hi!
>>>>>>>
>>>>>>> Here's a simple way to trigger the bug this patch is fixing:
>>>>>>>
>>>>>>> # cd /cephfs
>>>>>>> # ls mydir
>>>>>>> nKRhofOAVNsAwVLvDw7a0c9ypsjbZfK3n0Npnmni6j0
>>>>>>> # ls mydir/nKRhofOAVNsAwVLvDw7a0c9ypsjbZfK3n0Npnmni6j0/
>>>>>>> Cyuer5xT+kBlEPgtwAqSj0WK2taEljP5vHZ,D8VXCJ8
>>>>>>> u+46b2XVCt7Obpz0gznZyNLRj79Q2l4KmkwbKOzdQKw
>>>>>>> # fscrypt unlock mydir
>>>>>>> # touch /mnt/test/mydir/mysubdir/file
>>>>>>> touch: cannot touch '/mnt/test/mydir/mysubdir/file': No such file or
>>>>>>> directory
>>>>>>>
>>>>>>>   =C2=A0 fs/ceph/crypto.c | 4 ++++
>>>>>>>   =C2=A0 1 file changed, 4 insertions(+)
>>>>>>>
>>>>>>> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
>>>>>>> index 35a2ccfe6899..dc1557967032 100644
>>>>>>> --- a/fs/ceph/crypto.c
>>>>>>> +++ b/fs/ceph/crypto.c
>>>>>>> @@ -87,6 +87,10 @@ static int ceph_crypt_get_context(struct inode *=
inode,
>>>>>>> void *ctx, size_t len)
>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ER=
ANGE;
>>>>>>>   =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(ctx, cfa->cfa_blob, =
ctxlen);
>>>>>>> +
>>>>>>> +=C2=A0=C2=A0=C2=A0 /* Directory isn't complete anymore */
>>>>>>> +=C2=A0=C2=A0=C2=A0 if (S_ISDIR(inode->i_mode) && __ceph_dir_is_com=
plete(ci))
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __ceph_dir_clear_comple=
te(ci);
>>>>>> Hi Luis,
>>>>>>
>>>>>> Good catch!
>>>>>>
>>>>>> BTW, why do this in the ceph_crypt_get_context() ? As my understandi=
ng is that
>>>>>> we should mark 'mydir' as incomplete when unlocking it. While as I r=
emembered
>>>>>> the unlock operation will do:
>>>>>>
>>>>>>
>>>>>> Step1: get_encpolicy via 'mydir' as ctx
>>>>>> Step2: rm_enckey of ctx from the superblock
>>>>>>
>>>>> Sorry, it should be add_enckey.
>>>>>> Since I am still running the test cases for the file lock patches, s=
o I didn't
>>>>>> catch logs to confirm the above steps yet.
>>>>>>
>>>>>> If I am right IMO then we should mark the dir as incomplete in the S=
tep2
>>>>>> instead, because for non-unlock operations they may also do the Step=
1.
>>>>>>
>>>>> Your patch will work. But probably we should do this just around
>>>>> __fscrypt_prepare_readdir() or fscrypt_prepare_readdir() instead ? We=
 need to
>>>>> detect that once the 'inode->i_crypt_info' changed then mark the dir =
as
>>>>> incomplete.
>>>>>
>>>>> For now for the lock operation it will evict the inode, which will he=
lp do this
>>>>> for us already. But for unlock case, we need to handle it by ourself.
>>>> OK, that makes sense and to be honest I thought that there should be
>>>> another place for doing this. Unfortunately, I didn't found it: in the
>>>> test case I have the fscrypt_prepare_readdir() isn't called:
>>>>
>>>>      # cd /cephfs
>>>>      # ls mydir
>>>>      nKRhofOAVNsAwVLvDw7a0c9ypsjbZfK3n0Npnmni6j0
>>>>      # ls mydir/nKRhofOAVNsAwVLvDw7a0c9ypsjbZfK3n0Npnmni6j0/
>>>>      Cyuer5xT+kBlEPgtwAqSj0WK2taEljP5vHZ,D8VXCJ8 u+46b2XVCt7Obpz0gznZy=
NLRj79Q2l4KmkwbKOzdQKw
>>>>
>>>> At this point readdir was executed, of course.  And
>>>> __ceph_dir_set_complete() is also used to indicate that we have the fu=
ll
>>>> contents.  However, executing the following commands won't result in a=
ny
>>>> new readdir():
>>>>
>>>>      # fscrypt unlock mydir
>>>>      # touch /mnt/test/mydir/mysubdir/file
>>>>
>>>> and since the encryption key is set at the sb level, I couldn't find a=
 way
>>>> to detect changes in inode->i_crypt_info.  ceph_d_revalidate() is invo=
ked
>>>> but at that point I don't thing we have a way to know what is changing.
>>>>
>>>> Any ideas?
>>> # ls mydir/
>>> zy94Zt01M90xwYq+nxJsEvea+HYq49mqVgrUBkYrJAU
>>> # ls mydir/zy94Zt01M90xwYq+nxJsEvea+HYq49mqVgrUBkYrJAU/
>>> 24iNa8ICYc6nZZIkL,4n1sOtp9KiaTGtpq8PCZDQ6LU
>>> ivG4rQYzg6YENagbTZaV2kh2sVouEdlkmBZPfgVDl48
>>>
>>> I have added the debug logs in all the places just like:
>>>
>>> @@ -784,7 +786,9 @@ static struct dentry *ceph_lookup(struct inode *dir=
, struct
>>> dentry *dentry,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return ERR_PTR(-ENAMETOOLONG);
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ENCRYPTED(dir)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printk("%s fscrypt_has_encryption=
_key(dir): %d =3D=3D=3D=3D=3D=3D\n", __func__,
>>> fscrypt_has_encryption_key(dir));
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 err =3D __fscrypt_prepare_readdir(dir);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printk("%s fscrypt_has_encryption=
_key(dir): %d =3D=3D=3D=3D=3D=3D\n", __func__,
>>> fscrypt_has_encryption_key(dir));
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (err)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n ERR_PTR(err);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (!fscrypt_has_encryption_key(dir)) {
>>>
>>>
>>> # fscrypt unlock mydir
>>> Enter custom passphrase for protector "l":
>>> "mydir" is now unlocked and ready for use.
>>>
>>> And after "mydir/" was unlocked and then when doing:
>>>
>>> # touch mydir/dir/file2
>>>
>>> And when lookup the "dir/" dentry I can see the "mydir/" encryption key=
 changed:
>>>
>>> 709 <7>[79125.023676] ceph:=C2=A0 __ceph_caps_issued_mask ino 0x1000000=
0004 cap
>>> 000000004dc11892 issued pAsLsXsFs (mask As)
>>> 710 <7>[79125.023687] ceph:=C2=A0 __touch_cap 000000007071b095 cap 0000=
00004dc11892
>>> mds0
>>> 711 <7>[79125.023823] ceph:=C2=A0 lookup 000000007071b095 dentry 000000=
00f97501b2
>>> 'dir'
>>> 712 <4>[79125.023838] ceph_lookup fscrypt_has_encryption_key(dir): 0 =
=3D=3D=3D=3D=3D=3D
>>> 713 <4>[79125.024186] ceph_lookup fscrypt_has_encryption_key(dir): 1 =
=3D=3D=3D=3D=3D=3D
>>> 714 <7>[79125.024194] ceph:=C2=A0=C2=A0 dir 000000007071b095 flags are =
0x0
>>> 715 <7>[79125.024269] ceph:=C2=A0 do_request on 00000000a93fafef
>>>
>>> I am thinking could we just make __fscrypt_prepare_readdir(), which wil=
l return
>>> 0 when the key is already set or successfully set, to return 1 instead =
of 0 to
>>> mark that the key changed ?
>> OK, I see what you mean.  Thanks.  What about simply detect this change
>> here instead of changing __fscrypt_prepare_readdir() semantics?  Because=
 I
>> think that would require changes in several other places, including other
>> filesystems.
>>
>> What about something like this?
>>
>> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
>> index edc2bf0aab83..499ec75d2496 100644
>> --- a/fs/ceph/dir.c
>> +++ b/fs/ceph/dir.c
>> @@ -784,6 +784,8 @@ static struct dentry *ceph_lookup(struct inode *dir,=
 struct dentry *dentry,
>>   		return ERR_PTR(-ENAMETOOLONG);
>>     	if (IS_ENCRYPTED(dir)) {
>> +		bool had_key =3D fscrypt_has_encryption_key(dir);
>> +
>>   		err =3D __fscrypt_prepare_readdir(dir);
>>   		if (err)
>>   			return ERR_PTR(err);
>> @@ -791,6 +793,8 @@ static struct dentry *ceph_lookup(struct inode *dir,=
 struct dentry *dentry,
>>   			spin_lock(&dentry->d_lock);
>>   			dentry->d_flags |=3D DCACHE_NOKEY_NAME;
>>   			spin_unlock(&dentry->d_lock);
>> +		} else if (!had_key) {
>> +			__ceph_dir_clear_complete(ceph_inode(dir));
>>   		}
>>   	}
>>=20=20=20
>
> Yeah. Could we just add one helper, such as:

Sure, that makes sense.  I'll send out a new version soon.  Thanks!

Cheers,
--=20
Lu=C3=ADs


> bool ceph_fscrypt_prepare_readdir(dir)
>
> {
>
> =C2=A0=C2=A0=C2=A0 bool had_key =3D fscrypt_has_encryption_key(dir);
>
> =C2=A0=C2=A0=C2=A0 err =3D __fscrypt_prepare_readdir(dir);
>
> =C2=A0=C2=A0=C2=A0 if (!err && !had_key || err =3D -ENOKEY && had_key) {
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 return true; =C2=A0 // key changed
>
> =C2=A0=C2=A0=C2=A0 }
>
> =C2=A0=C2=A0=C2=A0 return false;=C2=A0 // key not changed
>
> }
>
> Thanks!
>
> - Xiubo
>
>> Cheers,
>
