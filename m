Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953A7718E2E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjEaWMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjEaWM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:12:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAF3191
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:11:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D38763F92
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 22:11:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E92C433EF;
        Wed, 31 May 2023 22:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1685571108;
        bh=Q3O+YfTi8ZwhCNuCN0xNiOxst69PRRr66pHSmYOzp1U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sH7XXkPri4OLA8eYaGe6mlFtbTmTfWJRgdLV4scGrBIX/t5996wccgLGVkfiDj6H4
         v+NC0hMlKUTUMgN1tnClGHtXKzsZ3fiYLCPfcFu8RcFtJ4tJ7kAiZvgdnJ0LL2lR36
         IC8jOSIz/ccDKBVkwumZg7geS4XMZPWgDO15k7WE=
Date:   Wed, 31 May 2023 15:11:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
Cc:     =?ISO-8859-1?Q?Lu=EDs?= Henriques via Ocfs2-devel 
        <ocfs2-devel@oss.oracle.com>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Heming Zhao <heming.zhao@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [Ocfs2-devel] [PATCH] ocfs2: check new file size on fallocate
 call
Message-Id: <20230531151147.3d98aa2fb1d7f659bccef37b@linux-foundation.org>
In-Reply-To: <20230529152645.32680-1-lhenriques@suse.de>
References: <20230529152645.32680-1-lhenriques@suse.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2023 16:26:45 +0100 Lu=EDs Henriques via Ocfs2-devel <ocfs2-=
devel@oss.oracle.com> wrote:

> When changing a file size with fallocate() the new size isn't being
> checked.  In particular, the FSIZE ulimit isn't being checked, which makes
> fstest generic/228 fail.  Simply adding a call to inode_newsize_ok() fixes
> this issue.
>=20
> ...
>
> --- a/fs/ocfs2/file.c
> +++ b/fs/ocfs2/file.c
> @@ -2100,14 +2100,20 @@ static long ocfs2_fallocate(struct file *file, in=
t mode, loff_t offset,
>  	struct ocfs2_space_resv sr;
>  	int change_size =3D 1;
>  	int cmd =3D OCFS2_IOC_RESVSP64;
> +	int ret =3D 0;
> =20
>  	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
>  		return -EOPNOTSUPP;
>  	if (!ocfs2_writes_unwritten_extents(osb))
>  		return -EOPNOTSUPP;
> =20
> -	if (mode & FALLOC_FL_KEEP_SIZE)
> +	if (mode & FALLOC_FL_KEEP_SIZE) {
>  		change_size =3D 0;
> +	} else {
> +		ret =3D inode_newsize_ok(inode, offset + len);
> +		if (ret)
> +			return ret;
> +	}
> =20

So userspace can exceed rlimit(RLIMIT_FSIZE).

Do we think this flaw is serious enough to justify backporting the fix
into earlier -stable kernels?

