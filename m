Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B04A5F83F7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 09:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiJHHRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 03:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJHHRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 03:17:01 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DEB7E82B
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 00:16:59 -0700 (PDT)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 2987GOQM3985778
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sat, 8 Oct 2022 00:16:25 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 2987GOQM3985778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022100601; t=1665213392;
        bh=fhsXwqOn6b7OJ4kSMbUUmVMeTMqoVOHsJM7L8Vxq3pw=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=p+VVkC2QpkaEn2sAmG8VpSGUUZT9K81/evsGs+IEGWkBCu19B2lMGCZG4uGEl61AH
         H6lsumeVbJVUE7ggiJW+ngxf5m1Mid9DX3SXO1+QAyTiVjv1qKISPmYtZbqcwubeeF
         tP6PS5b/ijOl+HHsrzajHCsdBXYcVc0ztPQgzTGg56pAuR1uhXHK3vvCRA7gQM57wQ
         wAwbUHBU/CIlFzHR5X4fNpgiuu1XMw4h7dWM6DjwxUnrCSPeBDcdtkSqzB8K/5hhLH
         sIQkOPtc+t3B4HnO6J+8SHkyJtwnmfFMvHPv+6QdsT4HLRZLEiQZj2KgAQ30oa9og2
         3LphUUSuTJ3cA==
Date:   Sat, 08 Oct 2022 00:16:22 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     "Li, Xin3" <xin3.li@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: =?US-ASCII?Q?RE=3A_=5BPATCH_6/6=5D_x86/gsseg=3A_use_the_LKGS_in?= =?US-ASCII?Q?struction_if_available_for_load=5Fgs=5Findex=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <BN6PR1101MB21617D356343204482EFD1F6A85E9@BN6PR1101MB2161.namprd11.prod.outlook.com>
References: <20221006154041.13001-1-xin3.li@intel.com> <20221006154041.13001-7-xin3.li@intel.com> <Y0A77RLAgXQyrVPq@hirez.programming.kicks-ass.net> <BN6PR1101MB21611798953AADA4DFD71719A85F9@BN6PR1101MB2161.namprd11.prod.outlook.com> <Y0B83cSSwJnRtGAn@hirez.programming.kicks-ass.net> <80AC2E90-D842-4EA2-A413-3CC5CFF088BC@zytor.com> <Y0CKz/wjvYYYgH3P@hirez.programming.kicks-ass.net> <b2943f49-41ba-59c9-2592-d1a91a151138@zytor.com> <BN6PR1101MB21617D356343204482EFD1F6A85E9@BN6PR1101MB2161.namprd11.prod.outlook.com>
Message-ID: <F4064514-E927-4FBD-BE49-AA83E8453ACA@zytor.com>
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

On October 7, 2022 10:32:31 PM PDT, "Li, Xin3" <xin3=2Eli@intel=2Ecom> wrot=
e:
>> > Andrew Cooper suggested upgrading the orphan section warning to a har=
d
>> > link error, orphan sections are bad regardless=2E
>> >
>>=20
>> Agreed 1000%=2E This is a no-brainer=2E From IRC:
>>=20
>>=20
>> <andyhhp> -LDFLAGS_vmlinux +=3D --orphan-handling=3Dwarn <andyhhp>
>> +LDFLAGS_vmlinux +=3D --orphan-handling=3Derror
>
>Who is going to make the change?
>

Why don't you?
