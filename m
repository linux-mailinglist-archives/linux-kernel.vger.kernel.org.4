Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2EF60D626
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 23:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiJYVac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 17:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiJYVaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 17:30:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3752A5246E;
        Tue, 25 Oct 2022 14:30:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0EE9C1F8B3;
        Tue, 25 Oct 2022 21:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666733419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GsChx+MZJNG5dXDKs99vdVY/KWr9zZZnfSpLrLhebqA=;
        b=1Q1d+7Rr51d6MYXDNZD5NSRsd+RrBP3t89UkSIFI4OXho3Mx53DsfYJDC2Mx5tP8+eHEVw
        XxVyDYvsWem9SkJU2bpIfyQXhkpTCPI4HnyM3guNyQeKF4AjtXMxRRCN2H+mVEqUIoot7P
        zykaHxIu+d+8/0b2ksEoHLgKf3ObLpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666733419;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GsChx+MZJNG5dXDKs99vdVY/KWr9zZZnfSpLrLhebqA=;
        b=nwqV8LR6vkXw2FIVIHBJT++eqLS73KWJjC5AoPKaZaV7rXbMGb3MU4ils8pyvbQaQQ5q8D
        fS6HQAyGJbuC8JBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A3ADB13A64;
        Tue, 25 Oct 2022 21:30:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kgFFFmhVWGOXIQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 25 Oct 2022 21:30:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Li zeming" <zeming@nfschina.com>
Cc:     willy@infradead.org, jlayton@kernel.org, song@kernel.org,
        bvanassche@acm.org, reiserfs-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Li zeming" <zeming@nfschina.com>
Subject: Re: [PATCH] reiserfs: journal: Increase jl pointer check
In-reply-to: <20221025084704.3922-1-zeming@nfschina.com>
References: <20221025084704.3922-1-zeming@nfschina.com>
Date:   Wed, 26 Oct 2022 08:30:13 +1100
Message-id: <166673341340.7585.173987927705263434@noble.neil.brown.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2022, Li zeming wrote:
> If kzalloc fails to allocate the jl pointer, NULL is returned directly.
>=20
> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>  fs/reiserfs/journal.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
> index 94addfcefede..d64e9de126c1 100644
> --- a/fs/reiserfs/journal.c
> +++ b/fs/reiserfs/journal.c
> @@ -2569,6 +2569,9 @@ static struct reiserfs_journal_list *alloc_journal_li=
st(struct super_block *s)
>  	struct reiserfs_journal_list *jl;
>  	jl =3D kzalloc(sizeof(struct reiserfs_journal_list),
>  		     GFP_NOFS | __GFP_NOFAIL);
> +	if (!jl)
> +		return NULL;
> +

What do you think the __GFP_NOFAIL flag might mean?

NeilBrown



>  	INIT_LIST_HEAD(&jl->j_list);
>  	INIT_LIST_HEAD(&jl->j_working_list);
>  	INIT_LIST_HEAD(&jl->j_tail_bh_list);
> --=20
> 2.18.2
>=20
>=20
