Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484216918BA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 07:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjBJGvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 01:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjBJGvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 01:51:12 -0500
Received: from out-85.mta0.migadu.com (out-85.mta0.migadu.com [IPv6:2001:41d0:1004:224b::55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F49E4FAFC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 22:50:55 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676011852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=egqOr1YGGT8jEo/lWpo5ulMjHrekpAj8mKAHNFKoT3Q=;
        b=YtCQqDiZfnWVNM8XB9yKdmKL8ukWOtRj3ClxpxvnqnMLI/mTXjVv68YNcZLbs5E9d3GeoC
        gEe7a2LdEjb1U1Jfm7bZ6jbdMLZK13x/DVrYh9vROrP+EHlE87td07M89CU2+qpPVFtvw/
        HJc6jCduzlBVwBKc38moYm6+TKQkPn8=
MIME-Version: 1.0
Subject: Re: [PATCH V2] arm64/mm: Intercept pfn changes in set_pte_at()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <Y+PbfGow2q0Oud3M@FVFF77S0Q05N.cambridge.arm.com>
Date:   Fri, 10 Feb 2023 14:50:09 +0800
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2B3E64D8-81AD-4DD2-87D8-B8B2AFA97B5A@linux.dev>
References: <d454c9a2-5300-b600-a2ae-21d82d338470@arm.com>
 <20230131154950.GB2646@willie-the-truck> <Y9pZALdn3pKiJUeQ@arm.com>
 <A8DF7D56-C145-4B49-A034-022917B87C89@linux.dev> <Y9uUO9AadE+8ik/0@arm.com>
 <F10F1618-7153-41C7-A475-522D833C41D4@linux.dev>
 <20230203101023.GA5597@willie-the-truck>
 <93461768-791A-45BE-BEF2-344CC5228C92@linux.dev>
 <20230207143131.GA12475@willie-the-truck>
 <FB3AE2F1-2EF8-4960-884E-DABA7E64CE59@linux.dev>
 <Y+PbfGow2q0Oud3M@FVFF77S0Q05N.cambridge.arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 9, 2023, at 01:27, Mark Rutland <mark.rutland@arm.com> wrote:
>=20
> On Wed, Feb 08, 2023 at 11:13:46AM +0800, Muchun Song wrote:
>>> On Feb 7, 2023, at 22:31, Will Deacon <will@kernel.org> wrote:
>>> On Mon, Feb 06, 2023 at 11:28:12AM +0800, Muchun Song wrote:
>>>> I am not familiar with ARM64, what's the user-visible effect if =
this
>>>> "amalgamation" occurs?
>>>=20
>>> The user-visible effects would probably be data corruption and =
instability,
>>> since the amalgamated TLB entry could result in a bogus physical =
address and
>>> bogus permissions.
>>=20
>> You mean the output address of amalgamated TLB entry is neither the =
old
>> address (before updated) nor the new address (after updated)?
>=20
> Yes, that is one possible result.
>=20
>> So it is a bogus physical address?
>=20
> Yes, that is one possible result.
>=20
>> Is there any specifications to describe the rules of how to create a
>> amalgamated TLB entry? Thanks.
>=20
> Unfortunately, this is not clearly specified in the ARM ARM, and we =
have to
> take a pessimistic reading here. We assume that amalgamation is some =
arbitrary
> function of the TLB entries which are hit (e.g. they might be OR'd =
together).
> This is something that I'd like to have clarified further by Arm's =
architects.
>=20
> The important thing to note is that amalgamation applies to *TLB =
entries*, not
> the translation table entries that they were derived from. Since the =
TLB format
> is micro-architecture dependent, and since the manner in which they =
might be
> combined is arbitrary, the results of combining could be arbitrary =
(and
> consequently, this is difficult to specify).
>=20
> The architecture *does* provide a few restrictions (e.g. Stage-1 =
entries within
> a VM can't escape Stage-2, NS entries can't create a secure physical =
address),
> but beyond that we cannot make any assumptions.
>=20
> So e.g. if you have 2 read-only entries for addresses A and B, =
amalgamation
> could result in read-write-execute for a distinct address C.
>=20
> It's not clear to me whether that could also affect hits for unrelated =
VAs.
>=20
> So the short answer is that we have to treat this as CONSTRAINED =
UNPREDICTABLE,
> and must avoid potential amalgamation by using Break-Before-Make.

Thanks for your clear description. It's really helpful.

>=20
> Thanks,
> Mark.

