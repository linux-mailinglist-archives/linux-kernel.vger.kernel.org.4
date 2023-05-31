Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6EA717A11
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbjEaI3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbjEaI3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:29:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD61C5
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:29:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 911151FD70;
        Wed, 31 May 2023 08:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1685521764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jURzmeyEuYooQh/U4B38nFvx+WNhymEAqUYSpuRZwN8=;
        b=dwWQ0qfDzg83xo2Ggs8eARaFApu5CdAHC9izhUX3aEfnXam0fkYgGbYUYUpzLH4/xIVbWQ
        OWdQbIO5D2o9DIs/1VquMlOxysfM8AZl9B2AyGMVeLqeVkFwxUuiBlYVKoImSPEE5dXSI+
        asYTe2qAYFuws4qN+nhMuVryizueYxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1685521764;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jURzmeyEuYooQh/U4B38nFvx+WNhymEAqUYSpuRZwN8=;
        b=8Mt+128mUFtzweJgPE1nZDPQaLgFRGqrWw0qrq/HtbCZ0C1Lp6uM5wi/AQwpjlHTv/IAlC
        Mudh+FFPoCF9JkBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1362513488;
        Wed, 31 May 2023 08:29:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YlEsAWQFd2SgXgAAMHmgww
        (envelope-from <lhenriques@suse.de>); Wed, 31 May 2023 08:29:24 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id cada9c86;
        Wed, 31 May 2023 08:29:18 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Heming Zhao <heming.zhao@suse.com>, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ocfs2: check new file size on fallocate call
References: <20230529152645.32680-1-lhenriques@suse.de>
        <810630b9-2021-01b3-1473-aa759174205e@linux.alibaba.com>
Date:   Wed, 31 May 2023 09:29:18 +0100
In-Reply-To: <810630b9-2021-01b3-1473-aa759174205e@linux.alibaba.com> (Joseph
        Qi's message of "Wed, 31 May 2023 14:00:12 +0800")
Message-ID: <87fs7c3nvl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Qi <joseph.qi@linux.alibaba.com> writes:

> On 5/29/23 11:26 PM, Lu=C3=ADs Henriques wrote:
>> When changing a file size with fallocate() the new size isn't being
>> checked.  In particular, the FSIZE ulimit isn't being checked, which mak=
es
>> fstest generic/228 fail.  Simply adding a call to inode_newsize_ok() fix=
es
>> this issue.
>>=20
>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>> ---
>>  fs/ocfs2/file.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
>> index efb09de4343d..b173c36bcab3 100644
>> --- a/fs/ocfs2/file.c
>> +++ b/fs/ocfs2/file.c
>> @@ -2100,14 +2100,20 @@ static long ocfs2_fallocate(struct file *file, i=
nt mode, loff_t offset,
>>  	struct ocfs2_space_resv sr;
>>  	int change_size =3D 1;
>>  	int cmd =3D OCFS2_IOC_RESVSP64;
>> +	int ret =3D 0;
>>=20=20
>>  	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
>>  		return -EOPNOTSUPP;
>
> This means we only support keep-size and pouch_hole.
> And it seems pouch_hole will also imply keep-size.

I think you're forgetting about mode =3D 0, which is also valid.  And the
default '0' will allow size to be changed.

>>  	if (!ocfs2_writes_unwritten_extents(osb))
>>  		return -EOPNOTSUPP;
>>=20=20
>> -	if (mode & FALLOC_FL_KEEP_SIZE)
>> +	if (mode & FALLOC_FL_KEEP_SIZE) {
>>  		change_size =3D 0;
>> +	} else {
>
> Seems this will be a dead branch?

Again, you need to consider '0' as a valid mode value.  If you run
generic/228 without this patch you'll see that test failing because it
*does* hit this branch.

Cheers,
--=20
Lu=C3=ADs

>
> Thanks,
> Joseph
>
>> +		ret =3D inode_newsize_ok(inode, offset + len);
>> +		if (ret)
>> +			return ret;
>> +	}
>>=20=20
>>  	if (mode & FALLOC_FL_PUNCH_HOLE)
>>  		cmd =3D OCFS2_IOC_UNRESVSP64;

