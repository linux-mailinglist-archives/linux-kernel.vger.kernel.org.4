Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE3A70BDEF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjEVMZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbjEVMZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:25:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3853103
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 05:23:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0B73521BEB;
        Mon, 22 May 2023 12:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684758189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wpaiiqodyKy0vQ1DhJtYpCanuFOXvyTgR3AKKTwRaDM=;
        b=1N85ewdi4T9Tm9iCnKgBN2/WNHtI2Fovs3uH5EEgLrmN8PtMwY7ValscNVeP3GzL8o9+WE
        Pso+ue0qnbWOpIPgujIJ8oCYqiRj8OuF58ENmsJZ0W/3j6rJcFpAK6kFI0x97ikCVFEcsx
        0aOIcusfJPR6zSbO86DKNz03hV5ZxzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684758189;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wpaiiqodyKy0vQ1DhJtYpCanuFOXvyTgR3AKKTwRaDM=;
        b=kwg3NWWGvU1kuSwZ01cagoVlLeAnlFVrO/XpxD5GIpy8ngPTIzfzUKT3G1zgfleboHb/6d
        RBJ4P+vpvZ4SwKAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 949F013776;
        Mon, 22 May 2023 12:23:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iH4rIaxea2T4VAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Mon, 22 May 2023 12:23:08 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 04073e22;
        Mon, 22 May 2023 12:23:07 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Heming Zhao <heming.zhao@suse.com>
Subject: Re: [PATCH] ocfs2: fix use-after-free when unmounting read-only
 filesystem
References: <20230522102506.9205-1-lhenriques@suse.de>
        <a57047d6-8f57-3dde-f15f-b24f63d675cd@linux.alibaba.com>
Date:   Mon, 22 May 2023 13:23:07 +0100
In-Reply-To: <a57047d6-8f57-3dde-f15f-b24f63d675cd@linux.alibaba.com> (Joseph
        Qi's message of "Mon, 22 May 2023 20:01:25 +0800")
Message-ID: <87h6s47dxw.fsf@brahms.olymp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Qi <joseph.qi@linux.alibaba.com> writes:

> On 5/22/23 6:25 PM, Lu=C3=ADs Henriques wrote:
>> It's trivial to trigger a use-after-free bug in the ocfs2 quotas code us=
ing
>> fstest generic/452.  After mounting a filesystem as read-only, quotas are
>
> generic/452 is for testing ext4 mounted with dax and ro.
> But ocfs2 doesn't support dax yet.

Right, but I think it's still useful to run the 'generic' test-suite in a
filesystem.  We can always find issues in the test itself or, in this
case, a bug in the filesystem.

>> suspended and ocfs2_mem_dqinfo is freed through ->ocfs2_local_free_info(=
).  When
>> unmounting the filesystem, an UAF access to the oinfo will eventually ca=
use a
>> crash.
>
> In ocfs2_fill_super(), it won't enable quota if is a readonly mount.
> Do you mean remount as readonly?

Yes, sorry. Instead of "mounting", the patch changelog should say

  "After remounting a filesystem as read-only..."

Cheers,
--=20
Lu=C3=ADs

>
> Thanks,
> Joseph
>
>>=20
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>> ---
>>  fs/ocfs2/super.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
>> index 0b0e6a132101..988d1c076861 100644
>> --- a/fs/ocfs2/super.c
>> +++ b/fs/ocfs2/super.c
>> @@ -952,8 +952,10 @@ static void ocfs2_disable_quotas(struct ocfs2_super=
 *osb)
>>  	for (type =3D 0; type < OCFS2_MAXQUOTAS; type++) {
>>  		if (!sb_has_quota_loaded(sb, type))
>>  			continue;
>> -		oinfo =3D sb_dqinfo(sb, type)->dqi_priv;
>> -		cancel_delayed_work_sync(&oinfo->dqi_sync_work);
>> +		if (!sb_has_quota_suspended(sb, type)) {
>> +			oinfo =3D sb_dqinfo(sb, type)->dqi_priv;
>> +			cancel_delayed_work_sync(&oinfo->dqi_sync_work);
>> +		}
>>  		inode =3D igrab(sb->s_dquot.files[type]);
>>  		/* Turn off quotas. This will remove all dquot structures from
>>  		 * memory and so they will be automatically synced to global

