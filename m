Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8484060321D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJRSOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJRSOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:14:38 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5151FE5D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:14:34 -0700 (PDT)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 29IIDq2i1687227
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 18 Oct 2022 11:13:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 29IIDq2i1687227
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022100601; t=1666116833;
        bh=O+5SfYdXnWvgSzFcU395fP/yPvA6+Jy3GDPGjcsY1pw=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=qWdf4tC3EkHpJt5FnihSkh3CSg0xY9AzM9Hm+DRbN9GIWR0ZGwTXl72rlApz1cy0p
         tfFFsXbfqbyFVnxx8jl796zWhu+qn4AhJhRd7ZeMnQZjRB/TmZTcz7ncuKAbUkPvXY
         GICTyPlBErdY9frrXxAWMdmBFSQRCg9EKrMP8p0hkua7XPQp/0ajsBEIGR3CK9zAgf
         VlumiJMgecWiwxK85FhtUf1iGs0/1XVd37fnok5AogghCFbJE36bhpF48422paE0k/
         xpd+4LG5zQmrtxcHuqu3G7uwoVIMcg7iohPA0J7+mweB27w9p02f/7/ZZFaviOxqpb
         C1LDnIcC6sRkA==
Date:   Tue, 18 Oct 2022 11:13:50 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     "Li, Xin3" <xin3.li@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
Subject: =?US-ASCII?Q?RE=3A_=5BPATCH_v3_4/6=5D_x86/gsseg=3A_move_local=5Fi?= =?US-ASCII?Q?rq=5Fsave/restore=28=29_into_asm=5Fload=5Fgs=5Findex=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <BN6PR1101MB2161B983B1A85CE3803A3EF8A8289@BN6PR1101MB2161.namprd11.prod.outlook.com>
References: <20221013200134.1487-1-xin3.li@intel.com> <20221013200134.1487-5-xin3.li@intel.com> <8735bpbhat.ffs@tglx> <BN6PR1101MB2161B983B1A85CE3803A3EF8A8289@BN6PR1101MB2161.namprd11.prod.outlook.com>
Message-ID: <629F4B18-CCA4-4409-946E-F00146C6BCB5@zytor.com>
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

On October 18, 2022 10:25:31 AM PDT, "Li, Xin3" <xin3=2Eli@intel=2Ecom> wro=
te:
>> >  static inline void native_load_gs_index(unsigned int selector)  {
>> > -	unsigned long flags;
>> > -
>> > -	local_irq_save(flags);
>> >  	asm_load_gs_index(selector);
>> > -	local_irq_restore(flags);
>> >  }
>>=20
>> static inline void native_load_gs_index(unsigned int selector) {
>> 	unsigned long flags;
>>=20
>>         if (cpu_feature_enabled(LKGS)) {
>>               native_lkgs(selector);
>>         } else {
>> 	      local_irq_save(flags);
>>               asm_load_gs_index(selector);
>> 	      local_irq_restore(flags);
>>        }
>> }
>>=20
>> For paravirt enabled kernels we want during feature detection:
>>=20
>>         if (cpu_feature_enabled(LKGS)))
>>         	pv_ops=2Ecpu=2Eload_gs_index =3D native_lkgs;
>
>If we use static_cpu_has in native_load_gs_index
>       if (static_cpu_has(X86_FEATURE_LKGS)) {
>               native_lkgs(selector);
>       }
>
>We don't have to change pv_ops=2Ecpu=2Eload_gs_index, right?
>
>Thanks!
>Xin
>
>>=20
>> No?
>>=20
>> Thanks,
>>=20
>>         tglx
>

You don't *have* to, but it would mean a branch to a branch, so it would b=
e more efficient=2E It would strictly be an optimization=2E
