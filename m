Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF9B5F977D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 06:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiJJEvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 00:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiJJEvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 00:51:48 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A20026566
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 21:51:45 -0700 (PDT)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 29A4pJiQ127633
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sun, 9 Oct 2022 21:51:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 29A4pJiQ127633
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022100601; t=1665377480;
        bh=UBkpJcmuZpohyH+0IUzegBEZKTqQnErY39YIEpDxOgg=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=Gz7l+0vlIObxcvL5Ok7ZUi9NlgciEvs6WDdEVJNGLWBhGDENbGbtt3FH8aofDkfqd
         EuhdO8ELhQARAcy5gPqgwCZPDG79PlewpapsilJOTzjJXZPIaW0enxxcvTCVCmWbpq
         3yCjx56n9KRndOAn0VZqSi10f42vLYqaZEToB2MLQmhzbP27WWtekp+ejeUTBVDVPD
         RPFHs/3Vg7B/nvf7fHT56up5EWjvJXb71Bfl+M2sogyaGTeMGyBKdZ4NiNHnlrEoWZ
         av2bfGXz6BZDtKnN0gJa4ms6nZLl+AE3JkQrFH/29J4vJEcYOw3kJ7xJleYOfRQcvi
         tjaIGvXAwS3TQ==
Date:   Sun, 09 Oct 2022 21:51:18 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     "Li, Xin3" <xin3.li@intel.com>, Brian Gerst <brgerst@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: =?US-ASCII?Q?RE=3A_=5BPATCH_6/6=5D_x86/gsseg=3A_use_the_LKGS_in?= =?US-ASCII?Q?struction_if_available_for_load=5Fgs=5Findex=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <BN6PR1101MB2161FFEB80E3D3AE06035384A8209@BN6PR1101MB2161.namprd11.prod.outlook.com>
References: <20221006154041.13001-1-xin3.li@intel.com> <20221006154041.13001-7-xin3.li@intel.com> <CAMzpN2iccL5kNa2UaBXppiLnoNWrpwJd74+uBrB_63N0F5F5Xg@mail.gmail.com> <BN6PR1101MB2161E1191DF1BD0135DC3947A85E9@BN6PR1101MB2161.namprd11.prod.outlook.com> <CAMzpN2i52orTgPqRARoCkuA=c2GEyWXLscrFRgDkb0LoFV01Rw@mail.gmail.com> <BN6PR1101MB2161FFEB80E3D3AE06035384A8209@BN6PR1101MB2161.namprd11.prod.outlook.com>
Message-ID: <ABA47BBE-8478-42BF-833A-0292DF015AE7@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 9, 2022 9:32:34 PM PDT, "Li, Xin3" <xin3=2Eli@intel=2Ecom> wrote=
:
>> > > There are not that many call sites, so using something like this
>> > > (incorporating Peter Z's suggestion for the exception handler) woul=
d
>> > > be better from a code readability perspective vs=2E a tiny increase=
 in code size=2E
>> >
>> > The existing approach patches the binary code thus we don't need to c=
heck it
>> at runtime=2E
>>=20
>> static_cpu_has() uses alternatives to patch the branch, so there is no =
runtime
>> check after early boot=2E
>>=20
>
>Sorry, didn't know it, thanks for point it out=2E
>
>If we prefer static_cpu_has, are you asking to replace all alternative ma=
cros with it?
>
>Xin
>
>

Honestly, it seems to me to be more than a bit excessive=2E The code might=
 be nontrivial, but *with proper commenting* it should be perfectly underst=
andable=2E=2E=2E
