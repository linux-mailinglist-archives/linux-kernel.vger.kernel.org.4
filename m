Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126C1609D16
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiJXIrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJXIrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:47:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BF823EAB;
        Mon, 24 Oct 2022 01:47:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 56A2121A31;
        Mon, 24 Oct 2022 08:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666601251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QoVcV9gbQThkvscNugr29PVp2ZbHse5aemDFMb3FVME=;
        b=J9s2V8zycLD77Lz2SnE+jZElvElJAACENvJ3DiGpSjMaY1Vs8cQIVNaQMCyCYLVUs6Uldu
        7Z/+/8/dv/L5CHzXxYjtXmMX2skPc1KWmO0ykcnt+KS+f404plQ6V9WhJTqbpwloHXb0X2
        MwMBCX+U43pXQ5lOvpXTLabvsBxZwnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666601251;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QoVcV9gbQThkvscNugr29PVp2ZbHse5aemDFMb3FVME=;
        b=kCjJuKCeEjB0/Lrz0AE0IhsorVpD5YAAkRomV0kYIhg+nxgEwsjU73AIpAPVJFL3LmWIIx
        UUThjllY9ycrbkCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 20E4313357;
        Mon, 24 Oct 2022 08:47:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FfHEBiNRVmNFWQAAMHmgww
        (envelope-from <nstange@suse.de>); Mon, 24 Oct 2022 08:47:31 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Nicolai Stange <nstange@suse.de>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Martin Doucha <mdoucha@suse.cz>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] padata: fix liftime issues after ->serial() has
 completed
References: <20221019083708.27138-1-nstange@suse.de>
        <20221021213540.7zlhwbbbp7og4lrl@parnassus.localdomain>
Date:   Mon, 24 Oct 2022 10:47:30 +0200
In-Reply-To: <20221021213540.7zlhwbbbp7og4lrl@parnassus.localdomain> (Daniel
        Jordan's message of "Fri, 21 Oct 2022 17:35:40 -0400")
Message-ID: <87wn8pip5p.fsf@suse.de>
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

Hi Daniel,

Daniel Jordan <daniel.m.jordan@oracle.com> writes:

> On Wed, Oct 19, 2022 at 10:37:03AM +0200, Nicolai Stange wrote:
>> this series is supposed to fix some lifetime issues all related to the f=
act that
>> once the last ->serial() has been invoked, the padata user (i.e. pcrypt)=
 is well
>> with its right to tear down the associated padata_shell or parallel_data
>> instance respectively.
>>=20
>> Only the first one, addressed by patch [2/5], has actually been observed=
, namely
>> on a (downstream) RT kernel under a very specific workload involving LTP=
's
>> pcrypt_aead01. On non-RT, I've been unable to reproduce.
>
> I haven't been able to hit the issue in 2/5 on RT on a v6.0 kernel in an
> x86 vm.  Were there any other things running on the system besides
> pcrypt_aead01?  More details about your environment and your kernel
> config would be helpful.

Right, the issue is indeed hard to reproduce, unfortunately. It has
originally been reported internally by our QA Maintenance team, which --
for unknown reason -- suddenly started to hit the issue once every while
in their testing environment. I did manage to reproduce it once or twice
myself, but it took me several days running pcrypt_aead01 in a loop each
time. AFAIR, I allocated a single cpu to the VM only and increased the
priority of pcrypt_aead01 a bit, with the intent to make preemption of
the ->serial() worker by DELALG more likely. But really, I cannot tell
if that did in fact contribute to the likelihood of triggering the race
or whether I've just been lucky.

Also, as mentioned in the cover letter, the RT kernel this has been
observed on is a downstream one, based on 5.3.18 (source tree at [1],
config at [2]), but with quite some additional patches on top. A
backport of this patch series here had been subject to testing in the
same environment the issue originally showed up in on a fairly regular
basis and no new crashes have been observed since.

Let me know if I could provide you with any more details.

Thanks,

Nicolai

[1] https://github.com/SUSE/kernel/tree/SLE15-SP3-RT
[2] https://github.com/SUSE/kernel-source/blob/SLE15-SP3-RT/config/x86_64/rt

--=20
SUSE Software Solutions Germany GmbH, Frankenstra=C3=9Fe 146, 90461 N=C3=BC=
rnberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
(HRB 36809, AG N=C3=BCrnberg)
