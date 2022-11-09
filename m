Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D6C622C10
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiKINCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiKINCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:02:40 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CB12CE3A;
        Wed,  9 Nov 2022 05:02:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 16C6522794;
        Wed,  9 Nov 2022 13:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667998958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hjfNn8jWIDsAR7kj9048Nl6m/l0f5ueCW8Gr2KNsOhw=;
        b=GXHgKSoxVW2YHlobbVQ8ol4lr6y1L+R1WkwXWcywXSnO9u1Mw6EsJhKMeli8wxNFnlUIKC
        9W/xzN3bTiQE3YyvMnKqzOTeNSbjgA7Hie45fMgjudI4RTWsfUHFHo2Sn/kKH+0zgjVXT0
        OLoATfsROR/5PiDKsctW0VIxLonqrcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667998958;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hjfNn8jWIDsAR7kj9048Nl6m/l0f5ueCW8Gr2KNsOhw=;
        b=B+iYC70KKeLhRoB50dbtvb61T+WftFbN2iOATMC86HAbdpyATElGU6dJpnEfvX0g3a6GmK
        /yshg0SqwH5Qk/BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5EBA139F1;
        Wed,  9 Nov 2022 13:02:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id K9/kMu2ka2OndQAAMHmgww
        (envelope-from <nstange@suse.de>); Wed, 09 Nov 2022 13:02:37 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Nicolai Stange <nstange@suse.de>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Martin Doucha <mdoucha@suse.cz>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] padata: make padata_free_shell() to respect pd's
 ->refcnt
References: <20221019083708.27138-1-nstange@suse.de>
        <20221019083708.27138-3-nstange@suse.de>
        <20221028143546.3xc6rnfkfcml373c@parnassus.localdomain>
Date:   Wed, 09 Nov 2022 14:02:37 +0100
In-Reply-To: <20221028143546.3xc6rnfkfcml373c@parnassus.localdomain> (Daniel
        Jordan's message of "Fri, 28 Oct 2022 10:35:46 -0400")
Message-ID: <87educb7rm.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
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

Daniel Jordan <daniel.m.jordan@oracle.com> writes:

> On Wed, Oct 19, 2022 at 10:37:05AM +0200, Nicolai Stange wrote:
>>=20
>> Fixes: 07928d9bfc81 ("padata: Remove broken queue flushing")
>
> It looks like this issue goes back to the first padata commit.  For
> instance, pd->refcnt goes to zero after the last _priv is serialized,
> padata_free is called in another task, and a particularly sluggish
> padata_reorder call touches pd after.
>
> So wouldn't it be
>
> Fixes: 16295bec6398 ("padata: Generic parallelization/serialization inter=
face")

I chose 07928d9bfc81 ("padata: Remove broken queue flushing"), because
that one reads like it fixed a couple of much more severe padata
lifetime issues, it only missed the relatively minor one addressed here,
in a sense.

Or to put it the other way around: if one were to backport this patch
here, 07928d9bfc81 should probably get picked first, I think.

But I'd be fine with any Fixes tag, of course, I don't have a strong
opinion on this matter.

Thanks!

Nicolai

>
> ?
>
> Otherwise,
>
> Acked-by: Daniel Jordan <daniel.m.jordan@oracle.com>
>
>> Signed-off-by: Nicolai Stange <nstange@suse.de>
>> ---

--=20
SUSE Software Solutions Germany GmbH, Frankenstra=C3=9Fe 146, 90461 N=C3=BC=
rnberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
(HRB 36809, AG N=C3=BCrnberg)
