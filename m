Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B1D601879
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 22:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiJQUCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 16:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiJQUCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:02:45 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8203463DB;
        Mon, 17 Oct 2022 13:02:43 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HJOt7u007874;
        Mon, 17 Oct 2022 13:02:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-id :
 content-type : mime-version; s=s2048-2021-q4;
 bh=BDsOMLSnqsNwU7G7wbOFg+oWxUFNQ7UhQFcDbSSow0o=;
 b=W93FLBYeGUg91PyRIVAdY1OZgknUVmu0TmfrsH8/GC0tvNxmU666iR0UilAhF+OiRlPB
 oJZDkGTLYRygpOuP7ygIXBavGrbAcDpLuzs5AuYVRkDav+qiWZBD8TgixdzMCY+QRIMv
 otrwRRkOeS1Un4SIHzWK91C9pcVxqKKCZJeqqitp++B65TN5lNUqKPqRI+Di2NEsuSyw
 yfSBsglhEYYtGu0ELRDIPVauvM9oGwM2M8sAH0d9iLvIqD1NP2SoqOuiDA0v5rV+CRzV
 Z8/yjY6fqOsn31qdoffk1pGAuteYRAID99ZxOU7nMM8UFayApO44jmUJ1Ns529nbJq5S Vg== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k99auu1pq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 13:02:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzFtyIVhcERmjf070iiq6tYCGO6D7Sdr/W8+qxUuohXo/lFnxM/0ltI06tr6JJJaa6VRT/cF9Go9EAlgM2iEnLJNVQDWGEiUVC0tyYehEH9Hgm1M/p6QKD6ZVPuY9WC98soJWXvrLUafs0ihMgFYxy1FGdODqu4P6VRjuCtm2/RWuJJGHIo9+8uWaxDQ2nKDoWGqIVf1470Qxbs6SYcfUSe7nK3nSeCAqhAwO0UECihKwgKwlEKa57utxfPYU0aU4bQxgc3gDiM7nejy00YmD7Wvn/KLRWCcbrsTNxZXKxRKMcgdvq/m0q6Ah2ZA04HplW4yRDAPCHuLajWpKG9cMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqwnbkcnPckOWao+CpqoFmon0frQ8A6mel62TghFKhU=;
 b=QXlZrACjpvbiKMhL7gFxcnpVgu2CrjCkabWQEmQL4sCICaDX5dCEOdRsomRgS9D1cVrPLuZQy269ZWkXz7pAGtJIaNJKe4EXJyVTLLOyB5Vxc6VzjjMD2vFnH+eX5t7AB/ueSOX1RNtmHe/ZggwX9KeK3v3JEiQ3VR3iDQ1f+SMp3zelSusqT7EWihmgENbpOKka4YfltjE1NSMCbUoJ6dRRZ4QeEH83Pxn55VyPuMkggf1dCxAB9R09Z02ikWBLIUhx/SllJt3LUMfFppuJm0J+NhHEvqy99u9vTe+HRKkvGXou2cQjO5BFQWzlq5JN/k32YNGyApnBOoTABJ0m2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by SN6PR1501MB2015.namprd15.prod.outlook.com (2603:10b6:805:7::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 20:02:38 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::14ef:d825:d623:440c]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::14ef:d825:d623:440c%5]) with mapi id 15.20.5676.038; Mon, 17 Oct 2022
 20:02:38 +0000
From:   Nick Terrell <terrelln@meta.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
CC:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Len Brown <lenb@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Tom Rix <trix@redhat.com>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [PATCH v2] Remove Intel compiler support
Thread-Topic: [PATCH v2] Remove Intel compiler support
Thread-Index: AQHY3ZVFv9Qm/NYeCEaItXFQ4kEqp64N+oGAgANi94CAAa4qAA==
Date:   Mon, 17 Oct 2022 20:02:37 +0000
Message-ID: <3F993490-0E9A-43C8-B272-FACF718E674D@fb.com>
References: <20221011171427.58891-1-masahiroy@kernel.org>
 <CANiq72kvaPGr=2S6J7q7gfEg_CauHUfhuLmABpktfUPfK+_Hvg@mail.gmail.com>
 <CAK7LNAQkSbH-Gw3sgMzxHyA9pSf3gLVvbCLg3yvbO43_vi5=YA@mail.gmail.com>
In-Reply-To: <CAK7LNAQkSbH-Gw3sgMzxHyA9pSf3gLVvbCLg3yvbO43_vi5=YA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3667:EE_|SN6PR1501MB2015:EE_
x-ms-office365-filtering-correlation-id: 861d5ec6-dfa7-4da7-8676-08dab07a8a60
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fiBdoQeoQ04Ycn190QgYRLryCEu2DdRP5jknut9NfWrWDRWK6WYt45RN0oltV9DwAHRyUzQLJ3L2xJMEpRgaKHwooMBVu7pwqVBAjRsj3Jdmazk+HMisGGHAs7QtMA/w3XNdFLJt2L6INdT1zsj6K8qp0RmHdgcGgpOIVzrmNlaB+8DDtInizGhlQ+08RrARa1lfT2M2c8phPBzlyeJHznNRZ1vlJdI1AETIjozCUk8jroZC5c/G/46vcihnddSIuyJtTbCkBz/Qu3y1uGk9PgQU9tTb1E8WnaAORDi83og6n0M0NxqT9kuTeyX4pnpmEU6TvZCbtzgNw6Lws2FBXF6wdvKu87c6nSKY3LxfyNgYp9BaV2oOEQVIIDCKnm8hapwgZxgkVZ2wsiPl/doNfXlhbnoEJSCULa9uzrZvAYviSN8j+oBzzH3/LeCM3goIwkRZcbSO7UrQEaNYIBICkvoPkGwBQJqF8whO4fDpr0YO7yjMaPD3DIMwS+m9JDJl044VMpvsLjtofZSoXoYgoknZZodMSzAAX9jSgV9/KOkRiLC4kEXsOE7qMojRkCJmahLac8CA4G+PuSCgNJNv73nT8NFqzsFEUhxbFkMrMbNBvXUNT1ReYkMAxpF7/jZQWkDmQZQ0WmwFpNiC3BFY51/H4XeLfqMBK7kYwxeDV8Ik7vgN9PO9XwGLwQ2mAUOI5H6m5RSZyp9Omo7gSSkNosUrNchroxto9p2L9fywn2GI0FtJ7uZqEpMju3j4Phg4jg839gURiRvqUPB6KqFihZnj178WkghqLeRu3UqLotZgbKFFWdPp6984Cn+tzF/WemJqS2Y8lmvbvGnQFhb+3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199015)(4326008)(9686003)(6512007)(53546011)(478600001)(83380400001)(2906002)(7416002)(5660300002)(6506007)(186003)(6916009)(41300700001)(316002)(66946007)(66556008)(71200400001)(8936002)(64756008)(966005)(8676002)(66476007)(76116006)(66446008)(6486002)(54906003)(86362001)(36756003)(38100700002)(38070700005)(33656002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TGqxLdC9943vmQU97q3vbUE7fpXWF8ri/mnKLP24tjhelBHOlWnZBUxnjJRk?=
 =?us-ascii?Q?yDf7AIwZd35ffkev8ymlYHvn3nDgXPwuC61LVju/tfZvnRZ5PFfExzezJxUq?=
 =?us-ascii?Q?SraTnUZwg6YCb0IUctM94G+kPQhyrDQK9V1qAc+l+4W/P+ZCq3MhWkyj2UMk?=
 =?us-ascii?Q?0yiONbxz6ICxG1fxsJ7juBa2E5QsEMboRlSvxlilFzYPr7a+B5bTDj0z9YZ3?=
 =?us-ascii?Q?yFIy/ZCWl2v3cI1sURiBzoF8AGNWPSeyP4h09pwcjnbcpUM46nWoK4d8X43B?=
 =?us-ascii?Q?Ajxg8Fs+s+/YoBsy2CQg7hFUrbhqXosTe7yqCV72GeZ8uvAOlbziS8ZVwzCZ?=
 =?us-ascii?Q?qqofCGmN8WTRiWLGOb18QNeW6hF4Ka9RdCJTdCLaEPm2uIWkSEFtHQpV/UmQ?=
 =?us-ascii?Q?eZE+7kvhnj+vSb6ttaj2DZ/kqZNTRrbXPZkg/sBut4pUBT3qxGTq/g59aLGO?=
 =?us-ascii?Q?GccHLLSEqdv5dciEGi25zGEoNkfgpngIEVs9e2p/Af1RFeiQEOGAE9b1X49y?=
 =?us-ascii?Q?qiQ0KKR32iFip3V/N5fGywAjoSNe2c+y+gzY1gVJGPRoXZxhEoYwJUlwy1ih?=
 =?us-ascii?Q?XhIMrw2nv6AypAK9Weu0YSS+jhfsasakVxkUWa/yx9lHcvsSIzhPi0/6jzrQ?=
 =?us-ascii?Q?8xm5xqIS8DAUPYe8Mde1MC7ZTr1yT3tgVganGSuTsKkGrFy17WJU3l/Hq3+x?=
 =?us-ascii?Q?XhsWUGx1+hrakHG0J6kIF0VN99pQSmTSwrxm4oTXLhBBV3RzQDmORP826HuZ?=
 =?us-ascii?Q?DUOz5Q5L6+Z4pjardEygDblxTfQn583JlhyG6PdMAUMT757ctDsCYV2/b+qQ?=
 =?us-ascii?Q?5wBp6EM4M/ETrkKNmVOG9P9J39WAqsDAaYxr+nvqjF6hZ82AB8CT4H2rReLR?=
 =?us-ascii?Q?hiI8rQVYZsXTZxJVUSZ7jpaTxxpVZVD3TZ4h5Wabwush6diIyyI4v/XztUyt?=
 =?us-ascii?Q?IY30JveknR7NuUpVI6CQFssTSS6gLq+ulalqZIGevr2f8rzWbinXDo0kxMdt?=
 =?us-ascii?Q?fosMDcD0RSOohVmADRamVBf6j6Yyn6slz78gmPsu2NRRRjW6qkdcH2dLjpZH?=
 =?us-ascii?Q?IR7pJ2HsVLJggiDw2WJyNUeNhot5XCEeWhO/xC7iDA4+JX5rDjWCYsJDzE8+?=
 =?us-ascii?Q?CzSr+XvzdqTM48eQ9vNQtzkkpA65anFjMA+KkJAXRZCSMs9dbZq/iQDUap2U?=
 =?us-ascii?Q?Hd2JnEb4msVLAy5FqlxLhUql4kup4WZHKvJRS0ZYZ4ORiqEI83sHzOq6W1Ms?=
 =?us-ascii?Q?gs9csxsqfCWHvVsHNs1kTtVgcYhE/nV7gBFcPEbJLFwv9MDUjQjy32XeER/g?=
 =?us-ascii?Q?DILDj2dWhg6RVXxnz+b00gKqaYajABiSkIvKHximXwZZnqm6FQvJVMTPzvi0?=
 =?us-ascii?Q?Xm5oWUO1CCD6klpQARnKh1nQbIecuZzCV4YetG+j/yCaCLBVlbSJi64Rl6if?=
 =?us-ascii?Q?LdQcrA9UqOtbgChwem7M+5xN+ImzKTQte7v3ZlOeY1BLGdf7BVwkYpMonf2o?=
 =?us-ascii?Q?c+ENUgkodlEffN2j4ENm/AX38Kl/eyaqVVrKABLcqF/yeW4VMY3UrFDB8+xN?=
 =?us-ascii?Q?W7FrVMGJgIbhPeQ45Y/LeANK09MzaUslnbU2OSMzX7d6AuP5LlDMcn7ibvK6?=
 =?us-ascii?Q?Hy14g9N5r0rH/gm3ExpXg0k=3D?=
Content-ID: <48853B23F303654E88CC17E704500B3F@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 861d5ec6-dfa7-4da7-8676-08dab07a8a60
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 20:02:38.0270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rv4bR+xXH1EkeXVE804QIP8ARhRkgWEt1OyCwiV2Yx8L5+jh5u772V/uIFpWUfjtYS+Fgz4kp9cCUpCGnjdPzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2015
X-Proofpoint-GUID: 1sZPBtXQehYwZ8a1BzIfgN3gHSxDo5Oc
X-Proofpoint-ORIG-GUID: 1sZPBtXQehYwZ8a1BzIfgN3gHSxDo5Oc
Content-Type: text/plain; charset="us-ascii"
X-Proofpoint-UnRewURL: 2 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 16, 2022, at 11:22 AM, Masahiro Yamada <masahiroy@kernel.org> wrote:
> 
> !-------------------------------------------------------------------|
>  This Message Is From an External Sender
> 
> |-------------------------------------------------------------------!
> 
> On Fri, Oct 14, 2022 at 11:40 PM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>> 
>> On Tue, Oct 11, 2022 at 7:16 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>>> 
>>> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
>>> index 898b3458b24a..9221302f6ae8 100644
>>> --- a/include/linux/compiler_attributes.h
>>> +++ b/include/linux/compiler_attributes.h
>>> @@ -64,16 +64,10 @@
>>>  * compiler should see some alignment anyway, when the return value is
>>>  * massaged by 'flags = ptr & 3; ptr &= ~3;').
>>>  *
>>> - * Optional: not supported by icc
>>> - *
>>>  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-assume_005faligned-function-attribute
>>>  * clang: https://clang.llvm.org/docs/AttributeReference.html#assume-aligned  
>>>  */
>>> -#if __has_attribute(__assume_aligned__)
>>> -# define __assume_aligned(a, ...)       __attribute__((__assume_aligned__(a, ## __VA_ARGS__)))
>>> -#else
>>> -# define __assume_aligned(a, ...)
>>> -#endif
>>> +#define __assume_aligned(a, ...)        __attribute__((__assume_aligned__(a, ## __VA_ARGS__)))
>> 
>> Thanks for cleaning the conditional inclusion here. I double-checked
>> it is indeed available for both GCC and Clang current minimum versions
>> just in case: https://godbolt.org/z/PxaqeEdcE.
>> 
>>> diff --git a/lib/zstd/common/compiler.h b/lib/zstd/common/compiler.h
>>> index f5a9c70a228a..c281a6430cd4 100644
>>> --- a/lib/zstd/common/compiler.h
>>> +++ b/lib/zstd/common/compiler.h
>>> @@ -116,7 +116,7 @@
>>> 
>>> /* vectorization
>>>  * older GCC (pre gcc-4.3 picked as the cutoff) uses a different syntax */
>>> -#if !defined(__INTEL_COMPILER) && !defined(__clang__) && defined(__GNUC__)
>>> +#if !defined(__clang__) && defined(__GNUC__)
>>> #  if (__GNUC__ == 4 && __GNUC_MINOR__ > 3) || (__GNUC__ >= 5)
>>> #    define DONT_VECTORIZE __attribute__((optimize("no-tree-vectorize")))
>>> #  else
>> 
>> These files come from upstream Zstandard -- should we keep those lines
>> to minimize divergence?
>> https://github.com/facebook/zstd/blob/v1.4.10/lib/common/compiler.h#L154.
>> 
>> Commit e0c1b49f5b67 ("lib: zstd: Upgrade to latest upstream zstd
>> version 1.4.10") is the latest upgrade, and says:
>> 
>>    This patch is 100% generated from upstream zstd commit 20821a46f412 [0].
>> 
>>    This patch is very large because it is transitioning from the custom
>>    kernel zstd to using upstream directly. The new zstd follows upstreams
>>    file structure which is different. Future update patches will be much
>>    smaller because they will only contain the changes from one upstream
>>    zstd release.
>> 
>> So I think Nick would prefer to keep the changes as minimal as
>> possible with respect to upstream.
>> 
>> Further reading seems to suggest this is the case, e.g. see this
>> commit upstream that introduces a space to match the kernel:
>> https://github.com/facebook/zstd/commit/b53da1f6f499f0d44c5f40795b080d967b24e5fa.
>> 
>>> diff --git a/lib/zstd/compress/zstd_fast.c b/lib/zstd/compress/zstd_fast.c
>>> index 96b7d48e2868..800f3865119f 100644
>>> --- a/lib/zstd/compress/zstd_fast.c
>>> +++ b/lib/zstd/compress/zstd_fast.c
>>> @@ -80,13 +80,6 @@ ZSTD_compressBlock_fast_generic(
>>>     }
>>> 
>>>     /* Main Search Loop */
>>> -#ifdef __INTEL_COMPILER
>>> -    /* From intel 'The vector pragma indicates that the loop should be
>>> -     * vectorized if it is legal to do so'. Can be used together with
>>> -     * #pragma ivdep (but have opted to exclude that because intel
>>> -     * warns against using it).*/
>>> -    #pragma vector always
>>> -#endif
>>>     while (ip1 < ilimit) {   /* < instead of <=, because check at ip0+2 */
>>>         size_t mLength;
>>>         BYTE const* ip2 = ip0 + 2;
>> 
>> Ditto: https://github.com/facebook/zstd/blob/v1.4.10/lib/compress/zstd_fast.c#L83.
>> 
>> Apart from the zstd divergence which I am not sure about, everything
>> looks good to me!
>> 
>> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
>> 
>> Cheers,
>> Miguel
> 
> 
> Thanks for your close review.
> 
> I will drop zstd changes and send v3.

Thanks!

As Miguel pointed out, we sync zstd in from upstream, so any changes here would
get overwritten next sync. If the idea is to just remove icc specific code for code
hygiene, I'd leave zstd as-is to keep it more in line with upstream. However, if there
is a very strong reason to delete it, we could remove it as part of our import process.

And if anything is broken, please open an issue on zstd's GitHub or email me.

Best,
Nick Terrell

> -- 
> Best Regards
> Masahiro Yamada

