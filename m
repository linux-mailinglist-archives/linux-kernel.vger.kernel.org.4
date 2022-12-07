Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD8A645A4F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiLGNCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiLGNBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:01:55 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD93A56D5A;
        Wed,  7 Dec 2022 05:01:54 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id co23so532211wrb.4;
        Wed, 07 Dec 2022 05:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YVq0+UudzmdQRaa093Lbr3RyPe8FvBPlb/bI7jjFrI=;
        b=CMORAutNrxMOSyZ3nsb0/8TpMLFDIPZ1Qz88/ymw+/kMn53Q+YInmlWDf+8eXThgQP
         pUArjM4WqUjQv0jcKnrLBQ1l74ru2Ca4yQkYzeqpqamSIhlhLgmkbwsWkiznpae1DFzd
         OEx/COJhWbu07iLBtfhMjVhjZEvnYxtVJha7KpunLVu9soEiJW7v2q3StiQXbtjUapkf
         8P0fbk8Yak01+o9CcBErx3J3UDmDGKQmj9JgAbtgcaCXoMbz0i8Hlv3fOToMJX0aW87y
         j3goQM/7HUnfnInWniUErWN+jKWLADK8mbhPWSmBFYqK3X69t5vOF67W5e0TBLkeLOJL
         qczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0YVq0+UudzmdQRaa093Lbr3RyPe8FvBPlb/bI7jjFrI=;
        b=fm0ODJsgHQC5AjMNB9B6cxJZ8ihkqja0DKLiF3+aQfnuUVaghaCYzYVsTDRMrqTrym
         WEhuK6ijhJpu75DbIZ272Uz9Sreoq+uMFJOvou76xAcpr3E0duzSsqbebBoaMOo5tKQB
         JDBtY4e4a70n0R8K9z1mNnBWuZ/ksbfwhmGfayJwtVOk/WK/2XCDLHm5h704XmFUNjxM
         C6JHeaJi8X9+aF+x646pWp3iR1g83Icw8Ft04vMBRWcpnZIYBgzbg7ILrWQAwqUdySit
         Zgbdn0Qd6bKQkkxPK442tMi3FSw9JZ+6FyaVAsy613A2WSyqxutk1ssGzUzW7qzn+fC9
         oBbA==
X-Gm-Message-State: ANoB5pkZgszRwagpbtT7xGIHrGtHfFsw01SQzFBg3p8Xcp923Lw0v1ej
        YQ1TBEuq/mTh0VWFmnc/TSA=
X-Google-Smtp-Source: AA0mqf6XKt9c4pFnmhN0NNmHU8welUubyeVCDFFUuu+/FqSi0mi4la0JgJ4FBHRH0u3/QFEiWQ2ICA==
X-Received: by 2002:adf:da4c:0:b0:242:137d:9ce4 with SMTP id r12-20020adfda4c000000b00242137d9ce4mr325754wrl.3.1670418112988;
        Wed, 07 Dec 2022 05:01:52 -0800 (PST)
Received: from suse.localnet (host-79-26-108-238.retail.telecomitalia.it. [79.26.108.238])
        by smtp.gmail.com with ESMTPSA id m18-20020adfe952000000b002421888a011sm19432882wrn.69.2022.12.07.05.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 05:01:52 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] mm/highmem: Add notes about conversions from kmap{,_atomic}()
Date:   Wed, 07 Dec 2022 14:01:50 +0100
Message-ID: <2130641.irdbgypaU6@suse>
In-Reply-To: <Y5BIHdnP4yeJ8svL@linutronix.de>
References: <20221206070029.7342-1-fmdefrancesco@gmail.com> <2093077.OBFZWjSADL@suse> <Y5BIHdnP4yeJ8svL@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On mercoled=EC 7 dicembre 2022 09:00:29 CET Sebastian Andrzej Siewior wrote:
> On 2022-12-06 20:12:13 [+0100], Fabio M. De Francesco wrote:
> > >   Furthermore, code between the kmap_atomic() and kunmap_atomic()
> > >   functions may implicitly depended
> >=20
> > I suppose it should be "depend"? Shouldn't it?
>=20
> Ehm, yes, correct.
>=20
> > >   on the side effects of kmap_atomic()
> > >   namely disabling pagefaults or preemption or both.
> >=20
> > I agree with you for rephrasing, mainly because it is
> > written in poor English.
> >=20
> > However, I still have doubts about why you deleted "migration".
> > AFAIK, __kmap_local_pfn_prot() always takes care of disabling migration=
=20
for
> > HIGHMEM enabled kernels.
>=20
> That is correct. Historically kmap_atomic() never had a
> migrate_disable() statement - only preempt_disable(). With disabled
> preemption the task migration is implicitly disabled.

Sure, I understand this mechanism: task migration is implicitly disabled wi=
th=20
disabled preemption.

>=20
> > How about !HIGHMEM, where kmap_local_page() is an indirect call to
> > page_address()? Did you mean that, if the code between kmap_atomic() and
> > kunmap_atomic() depended on migrate_disable() (in PREEMPT_RT) we should
> > always just stay safe and call preempt_disable() together with conversi=
on
> > to kmap_local_page()?
>=20
> Even in the !HIGHMEM case it always uses preempt_disable().

With the only exception of PREEMPT_RT kernels, which instead use=20
migrate_disable().

> With
> PREEMPT_RT it is different as it never disabled preemption and always
> did a migrate_disable() instead.

OK, I see that I'm recalling correctly :-)=20

> If you talk about what needs to be
> considered while migrating away from kmap_atomic()

Yes, I'm trying to explain what needs to be considered while converting fro=
m=20
kmap_atomic() by looking at all the different cases.

> then I wouldn't add
> the PREEMPT_RT bits to it since it was never in the picture while the
> code (using kmap_atomic()) was originally written.

Ah, OK. Now I understand why you changed my last phrase.
I agree with you, so I won't add anything about the special PREEMPT_RT case.

> > If so, I understand and I again agree with you. If not, I'm missing
> > something; so please let me understand properly.
> >=20
> > Aside from the above, I'm not sure whether you deleted the last phrase
> > before
> > your suggestion. What about making it to become "For the above-mentioned
> > cases, conversions should also explicitly disable page-faults and/or
> > preemption"?
>=20
> They need to disable preemption or page-faults or both if it is needed
> (not unconditionally) and where it is needed. This means not
> unconditionally over the whole kmap-ed section.

I never meant to suggest to _unconditionally_ disable page-faults=20
and/or preemption. I was only trying to say that developers must carefully=
=20
check whether or not the whole kmap-ed section depended on those side effec=
ts.

If so, they must _explicitly_ disable preemption or page-faults or both=20
together with the use of kmap_local_page(). Instead, if the section doesn't=
=20
depend on preemption and/or page-faults disabling, they must only replace=20
kmap_atomic() with kmap_local_page().

I had probably used a bad wording when trying to say the same things that y=
ou=20
wrote much more clearly.

Thanks,

=46abio

>=20
> > Thanks again for noticing my mistakes.
> >=20
> > Fabio
>=20
> Sebastian




