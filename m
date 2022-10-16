Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBA0600289
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 19:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiJPRxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 13:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiJPRxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:53:01 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AA932066
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=/QSZlP10x6sKv7h8Gtd9mwjASy+NA/rKPLXm4tqQL28=;
        t=1665942779; x=1667152379; b=ro9lCKsceVbmoK/R+y5zBUibyzlEswGUT+pfewgvQB3+V2j
        HCm1Qg9Nwc4qmFIVxSnxPui41jGXcLIqp6qIFPQsh3JOpXhB/i7OT2Znfs1lXY+A2OyayrhM7Hbpa
        O2PIHw534T0T7YZJBG4hISuEtDME8yLeVywGe3ZPpxt/0MJrlNuJtbaa584FwNbX9T+NfKznPGs+k
        pTFGfUn8zXEoAmDvMi88ePUJeaQfvN+T2om6gjEwsbo9rhxPYo5MAtLEQEjudqj0+2q3H1oFNz9Vo
        VXOl4odMLPswM4QC2zaK6v8fhJSswZxdiGjjojOzx76BiArXHQM12KAibNFAUYjw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ok7of-008UHd-2S;
        Sun, 16 Oct 2022 19:52:49 +0200
Message-ID: <f0b1f33108fec467689b52568b5ad7c906eb5435.camel@sipsolutions.net>
Subject: Re: [PATCH] um: protect find_task_by_pid_ns() with rcu lock
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dawei Li <set_pte_at@outlook.com>, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Sun, 16 Oct 2022 19:52:48 +0200
In-Reply-To: <TYCP286MB2323CA02DF3A741B5F58B297CA269@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB2323CA02DF3A741B5F58B297CA269@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-10-16 at 23:10 +0800, Dawei Li wrote:
> find_task_by_pid_ns() is safe if and only if it's under protection
> from rcu read lock, implements the protection.
>=20
> base-commit: 193cb8372424184dde28088a4230a5fed0afb0ad
>=20
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> ---
>  arch/um/drivers/mconsole_kern.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_k=
ern.c
> index 5026e7b9adfe..6b80e766ae80 100644
> --- a/arch/um/drivers/mconsole_kern.c
> +++ b/arch/um/drivers/mconsole_kern.c
> @@ -683,7 +683,10 @@ void mconsole_stack(struct mc_request *req)
>  		return;
>  	}
> =20
> +	rcu_read_lock();
>  	to =3D find_task_by_pid_ns(pid_requested, &init_pid_ns);
> +	rcu_read_unlock();
> +
>  	if ((to =3D=3D NULL) || (pid_requested =3D=3D 0)) {
>  		mconsole_reply(req, "Couldn't find that pid", 1, 0);
>  		return;

This can't be right - the 'to' pointer is used later in the code (not in
the existing context), so the protection, if needed, would have to
include the later "with_console()" call?

johannes
