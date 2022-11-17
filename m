Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB17D62E3AD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240256AbiKQSBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239005AbiKQSBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:01:46 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E184F7FC36;
        Thu, 17 Nov 2022 10:01:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4F3121F8E2;
        Thu, 17 Nov 2022 18:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668708102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/+JxpzcfcwJFtmpbUfqLQDQyF+RiIM1YT3S3Jpqg/d4=;
        b=AmzzsF36XcppJVp01VviVMI/EYGRXtbY8kWOFLbzX5FU/64nCzJg0Ug4nfEM5rBkKARJFc
        /xs/oPABmyaLRwMHmbrBJckpbrOw1gFRUxqFxgm5fhz1Gy6X+rkA5IgwZBSuJP6QItjk5n
        hcsMlgKY0IDnchfnwh1btDeho3h2dgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668708102;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/+JxpzcfcwJFtmpbUfqLQDQyF+RiIM1YT3S3Jpqg/d4=;
        b=KAzzWGSo6pgveVs1eykJsU/7Lh9nA/8embvn35gm2rFFxbezxMLlIOicf2IuLpzN6Chgkf
        BC2WvIWL9k6VkIAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E10B713A12;
        Thu, 17 Nov 2022 18:01:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M9srNAV3dmMFYAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 17 Nov 2022 18:01:41 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id c385487c;
        Thu, 17 Nov 2022 18:02:41 +0000 (UTC)
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
Date:   Thu, 17 Nov 2022 18:02:41 +0000
In-Reply-To: <41710b3d-b37f-8c65-d55d-c4137a366efd@redhat.com> (Xiubo Li's
        message of "Thu, 17 Nov 2022 19:08:02 +0800")
Message-ID: <87o7t5mpby.fsf@suse.de>
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

> On 17/11/2022 16:03, Xiubo Li wrote:
>>
>> On 16/11/2022 23:37, Lu=C3=ADs Henriques wrote:
>>> When setting a directory's crypt context, __ceph_dir_clear_complete() n=
eeds
>>> to be used otherwise, if it was complete before, any old dentry that's =
still
>>> around will be valid.
>>>
>>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>>> ---
>>> Hi!
>>>
>>> Here's a simple way to trigger the bug this patch is fixing:
>>>
>>> # cd /cephfs
>>> # ls mydir
>>> nKRhofOAVNsAwVLvDw7a0c9ypsjbZfK3n0Npnmni6j0
>>> # ls mydir/nKRhofOAVNsAwVLvDw7a0c9ypsjbZfK3n0Npnmni6j0/
>>> Cyuer5xT+kBlEPgtwAqSj0WK2taEljP5vHZ,D8VXCJ8
>>> u+46b2XVCt7Obpz0gznZyNLRj79Q2l4KmkwbKOzdQKw
>>> # fscrypt unlock mydir
>>> # touch /mnt/test/mydir/mysubdir/file
>>> touch: cannot touch '/mnt/test/mydir/mysubdir/file': No such file or
>>> directory
>>>
>>> =C2=A0 fs/ceph/crypto.c | 4 ++++
>>> =C2=A0 1 file changed, 4 insertions(+)
>>>
>>> diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
>>> index 35a2ccfe6899..dc1557967032 100644
>>> --- a/fs/ceph/crypto.c
>>> +++ b/fs/ceph/crypto.c
>>> @@ -87,6 +87,10 @@ static int ceph_crypt_get_context(struct inode *inod=
e,
>>> void *ctx, size_t len)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ERANGE;
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(ctx, cfa->cfa_blob, ctxlen=
);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* Directory isn't complete anymore */
>>> +=C2=A0=C2=A0=C2=A0 if (S_ISDIR(inode->i_mode) && __ceph_dir_is_complet=
e(ci))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __ceph_dir_clear_complete(c=
i);
>>
>> Hi Luis,
>>
>> Good catch!
>>
>> BTW, why do this in the ceph_crypt_get_context() ? As my understanding i=
s that
>> we should mark 'mydir' as incomplete when unlocking it. While as I remem=
bered
>> the unlock operation will do:
>>
>>
>> Step1: get_encpolicy via 'mydir' as ctx
>> Step2: rm_enckey of ctx from the superblock
>>
> Sorry, it should be add_enckey.
>>
>> Since I am still running the test cases for the file lock patches, so I =
didn't
>> catch logs to confirm the above steps yet.
>>
>> If I am right IMO then we should mark the dir as incomplete in the Step2
>> instead, because for non-unlock operations they may also do the Step1.
>>
> Your patch will work. But probably we should do this just around
> __fscrypt_prepare_readdir() or fscrypt_prepare_readdir() instead ? We nee=
d to
> detect that once the 'inode->i_crypt_info' changed then mark the dir as
> incomplete.
>
> For now for the lock operation it will evict the inode, which will help d=
o this
> for us already. But for unlock case, we need to handle it by ourself.

OK, that makes sense and to be honest I thought that there should be
another place for doing this. Unfortunately, I didn't found it: in the
test case I have the fscrypt_prepare_readdir() isn't called:

   # cd /cephfs
   # ls mydir
   nKRhofOAVNsAwVLvDw7a0c9ypsjbZfK3n0Npnmni6j0
   # ls mydir/nKRhofOAVNsAwVLvDw7a0c9ypsjbZfK3n0Npnmni6j0/
   Cyuer5xT+kBlEPgtwAqSj0WK2taEljP5vHZ,D8VXCJ8 u+46b2XVCt7Obpz0gznZyNLRj79Q=
2l4KmkwbKOzdQKw

At this point readdir was executed, of course.  And
__ceph_dir_set_complete() is also used to indicate that we have the full
contents.  However, executing the following commands won't result in any
new readdir():

   # fscrypt unlock mydir
   # touch /mnt/test/mydir/mysubdir/file

and since the encryption key is set at the sb level, I couldn't find a way
to detect changes in inode->i_crypt_info.  ceph_d_revalidate() is invoked
but at that point I don't thing we have a way to know what is changing.

Any ideas?

Cheers,
--=20
Lu=C3=ADs

>
> Thanks!
>
> - Xiubo
>
>
>> Thanks!
>>
>> - Xiubo
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ctxlen;
>>> =C2=A0 }
>>>
>

