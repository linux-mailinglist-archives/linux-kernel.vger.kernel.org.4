Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CB5604F45
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 20:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJSSCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 14:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiJSSCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:02:20 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB7F1BB966
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:02:19 -0700 (PDT)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 29JI1hiH1846833
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 19 Oct 2022 11:01:45 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 29JI1hiH1846833
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022100601; t=1666202505;
        bh=M7t+K3bYSK6FwahZ9FxJ5V40A4SFVLrfM056XJT4RFE=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=l/A6GLy3TAF/g6OPt4/nna5yb+u0S4ImEw0uIgFsA7n0QrtZpuo0FRKXaH1/wIsD5
         6nnO4dqtiNTXwiQ6lFRotYNBi8NOBhBhEcsfbTDudYdZ975RNPJO8qDPhH1YezbuNy
         rIUnrDHN9sUuijmARIENXtQzdiQfdYFfecXwEjf8m7E4TebAYnvA5HtttOVVAKZjmD
         06Iy2FdjohMqHVBCDJxmjyjkawN+T/FNzvj0PTgkiBnsc6rk+Y4cgobqsegnrz7Bjg
         T4FN3K2UqSnpxIl7HDy8B0mnWeHvcuJBttHY+3ORHuheAy/vNnQJjnsI075Iytsco6
         2k44JxloCj6Ug==
Date:   Wed, 19 Oct 2022 11:01:41 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     "Li, Xin3" <xin3.li@intel.com>, "Gross, Jurgen" <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
Subject: =?US-ASCII?Q?RE=3A_=5BPATCH_v4_5/5=5D_x86/gsseg=3A_use_the_LKGS_?= =?US-ASCII?Q?instruction_if_available_for_load=5Fgs=5Findex=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <BN6PR1101MB2161DD8F4F587C6FBFCA18EFA82B9@BN6PR1101MB2161.namprd11.prod.outlook.com>
References: <20221019095035.10823-1-xin3.li@intel.com> <20221019095035.10823-6-xin3.li@intel.com> <439a325f-6a00-845e-7850-43abfc60cd44@suse.com> <BN6PR1101MB2161DD8F4F587C6FBFCA18EFA82B9@BN6PR1101MB2161.namprd11.prod.outlook.com>
Message-ID: <FDC4F3E7-DEDD-41CC-93E6-8021F16B509D@zytor.com>
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

On October 19, 2022 10:45:07 AM PDT, "Li, Xin3" <xin3=2Eli@intel=2Ecom> wro=
te:
>> > +static inline void __init lkgs_init(void) { #ifdef
>> > +CONFIG_PARAVIRT_XXL #ifdef CONFIG_X86_64
>> > +	if (cpu_feature_enabled(X86_FEATURE_LKGS))
>> > +		pv_ops=2Ecpu=2Eload_gs_index =3D native_lkgs;
>>=20
>> For this to work correctly when running as a Xen PV guest, you need to =
add
>>=20
>> 	setup_clear_cpu_cap(X86_FEATURE_LKGS);
>>=20
>> to xen_init_capabilities() in arch/x86/xen/enlighten_pv=2Ec, as otherwi=
se the Xen
>> specific =2Eload_gs_index vector will be overwritten=2E
>
>Yeah, we definitely should add it to disable LKGS in a Xen PV guest=2E
>
>So does it mean that the Xen PV uses a black list during feature detectio=
n?
>If yes then new features are often required to be masked with an explicit
>call to setup_clear_cpu_cap=2E
>
>Wouldn't a white list be better?
>Then the job is more just on the Xen PV side, and it can selectively enab=
le
>a new feature, sometimes with Xen PV specific handling code added=2E
>
>Xin
>
>>=20
>>=20
>> Juergen
>

Most things don't frob the paravirt list=2E

Maybe we should make the paravirt frobbing a separate patch, at it is sepa=
rable=2E
