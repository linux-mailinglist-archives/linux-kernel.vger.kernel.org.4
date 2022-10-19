Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DA86043DA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbiJSLu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiJSLue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:50:34 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02on070d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe07::70d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A740A237FF
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 04:29:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8UJRFnS7Z5r8JRXAUjyTfHhynsXmOEX399WTzdheDtxmt55hBj4WxG0yIqaYwF/ofU4VLMYmmzOcQ1tjirs74DXaurs3LIicQxe3q7XODI2qn1iF2Gab34XbVDNbxPDyuvn4DIeCMthpNF1TyNHyEmVZiyn1Iknpb8r3qagKE/RvaOcFjxAq8R04+iz1UXADH384XbHKp1282uyJ3/4gr99F8dL/zru/cFiWFGnny5wPFxLktWza9ZLDhKiBQSizsEibFlyaqZbxY0bhxQq144dWDQNJtyOMyYnpp3gvPVqak+IhVLnAV40wynHdzjBOwNKVyIjkaLvokzC2JnnJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psdjsyPrSBn+LZyeBSfAVpKlYTRBr/W6oqtMy7RKKMI=;
 b=NGZrnN9nn+Q6PdcmTxj1deudFWwmFyRyAwp2wP20o09C3jNsCDnADdIZ16XPJ7o+Zp8wDkEzE8LpV5AE7f++rTOpWEG+L9I17QaWcKv9mcPPEW8U87m+MCdUDXCzHG4QdsXGJV6inhbdNiwAWQsF+ADy7cNqyQU3D6kVJhmP1TCrqPAkzMvcwi4eY+XQvjrTBW72t/V+QJfRsWr4YY6yV383C9KdWEoPXzj6ZUo00ksn6+qELwVypsPVbPTElfXA/gCVjHD4AibjoF74a1BceWA/KPMi44a3VH4AGMPCL/BFMy6D/hlvNyhe8AbjJQBMRHSQKdPygWlzXPJD7OyEQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psdjsyPrSBn+LZyeBSfAVpKlYTRBr/W6oqtMy7RKKMI=;
 b=RF87XqOn5/EtNe7/TxjeKFvQDUu3WI5afRMlC+aXc46WjSLju2PRz1CV8U3VgYv+i0oCF2012KnKcELjP1RHvuFdqO21WF41T1S3MzvKqEtAq/Bvq0UP/FK4ygZr2xh4STpN0m6yaaM6YyUfewXRV5J+oiwxdShg4OAStbDdb98DkNdmGzNiD2grLx3pnU+Hd6m0faEn7aTqWuWPMigO9jz5LdOJWbJ9uY8tQ0jXb/3KbqluFoLLrpd/21SxGfT8ynwx0aPByZA2nUuMzcUB//6sggnblGp++0VKhwXCh0UhOPmxiiHBLuOitYKOPnfTXfYU+c0MAbtuixdO54hoUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com (2603:10a6:802:a5::16)
 by DB9PR08MB6651.eurprd08.prod.outlook.com (2603:10a6:10:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Wed, 19 Oct
 2022 11:06:16 +0000
Received: from VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::6809:fef7:a205:b08a]) by VE1PR08MB4765.eurprd08.prod.outlook.com
 ([fe80::6809:fef7:a205:b08a%7]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 11:06:16 +0000
Message-ID: <edba66e3-89bd-e7b2-6ebb-3f868c9aec67@virtuozzo.com>
Date:   Wed, 19 Oct 2022 14:06:14 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [RFC PATCH v5 6/8] drivers: vmware: balloon - report inflated
 memory
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nadav Amit <namit@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>, kernel@openvz.org,
        linux-kernel@vger.kernel.org
References: <20221019095620.124909-1-alexander.atanasov@virtuozzo.com>
 <20221019095620.124909-7-alexander.atanasov@virtuozzo.com>
 <Y0/Qu0eSYFqtuC/v@kroah.com>
 <2ae8251a-456d-abdd-ed1a-1bfc04356741@virtuozzo.com>
 <Y0/WUdUIJ6O7EzQg@kroah.com>
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <Y0/WUdUIJ6O7EzQg@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0311.eurprd07.prod.outlook.com
 (2603:10a6:800:130::39) To VE1PR08MB4765.eurprd08.prod.outlook.com
 (2603:10a6:802:a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4765:EE_|DB9PR08MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: 7670e697-d649-4de0-fed9-08dab1c1f12f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i4mT3Bvomz1kVQlnu1r4HSE6xYFcF20H1sCPpE/+FrUSFKuBNPoxyKMdSGz2NxKgeFHFSUkEk3iVWVvc1ZgvHYf5RQ4K9Q4yZY8lJpBu3lEiMyXX0Jx+WqrLp/paGjIvevDTgrSLyssFiu0Vf65P9fphgBULFhEqgcbL5DHpbhbBtGkLTLoeKqSrNTZqxD4j8nCTnVrCPY+FeXW0BwRR5N0Ow4zoiOmX+Hwvf1kf8xKgIeJ9XLkZLPfFageibl6CHpFtbzouZ3NcchiLhyut9iC0aITjbcR/KmUu/dyXD5iR7bN3378b5OLy0bdiK//1IhHpdpx9jlNd7lTZqhsU/yJLOGjIxBy2H34SeVcCKWiRginScX24IicohniwbHs3v3mVCTyUoRRMu0GTj1Dn/+hhYNBIa3e7JhrOuuynSY71Ng0MdYXTWLstY3mm06naeEMafWqn4LqbiMxpuaXcTgLDoEXdZN1qr5Ekqzj+Vzv43JEV+sTKBON5/qzvoq4fkdAP96yhnJGcCKFSsZSELgQOtR9kDB/VgltdkuH463YLLsHsTiGTqrp50blWzDC7M/LkGZ9oA8Nh1T/quCHjZLI33NdMrlpIy698ude2hdN675cooROjV2RgQTOLoYzqkR8aT5jGDVXBRh2oZZQIWGfYjGd5Pf3DVC99QC6zFK99POmJZNVNrgzbH7RZvIkiz2QKjXbEkl9+pRXiZB2nNi3OHIb7GDqTL6Xtg+BP3Ix4QcX80RbyqlIBpOA9TkCvcakhnLR7mBkpTcJjSca1kTDilzn0ceKMtUboMb/lm24=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4765.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(346002)(366004)(136003)(376002)(396003)(451199015)(5660300002)(31696002)(6486002)(478600001)(38100700002)(4326008)(86362001)(8676002)(66946007)(66556008)(4744005)(44832011)(54906003)(316002)(6916009)(66476007)(2906002)(8936002)(2616005)(83380400001)(186003)(41300700001)(6506007)(6512007)(26005)(53546011)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjNjZjQrcU53Y1ZrcUc3SGRBR1JHV2kxTmJ6b2ZLU21wOVZDQkZvRXo4eld1?=
 =?utf-8?B?ZkxZaXBDamZqdHV5d25DcXAyUDZidzU0SzE2bVc5a0xCTmlFUW1XZVZnbXhI?=
 =?utf-8?B?UXV1SjFqaVc5SnFZMXlLUk1DcW5MRURORUlINHFzNDBiS3NzZGNXZ1Vvd1dI?=
 =?utf-8?B?OERORFhGbC9qeUNUS1ZXajFWaUlmRjNIeHZndkFaOUN4R1RsZ2MyZDB3cHEr?=
 =?utf-8?B?Qlg1SkFWUmlicXJzT1Q1N2dCVW8vRDFOWlZ4UGxFZjJMb1ZiUzFiN1NvRTF4?=
 =?utf-8?B?dTVLWCthUDVHM3JvaXJCL1N3ckVRNm9xMktlalFxWUEweEtZbXFNcUcrOG03?=
 =?utf-8?B?Sk45ZVZLZHByN2RRM0VkT2xIZWJ5TG0zbjhSWGl2SXV0bExXSDhIdlNHVzl6?=
 =?utf-8?B?RUlVYjEzYjI3SFdQK2ZpQVZEZHBHTnVtMDZNNXk5Rjh4Q1FXZDY4LzFsWHF4?=
 =?utf-8?B?T1hDc2huR1VGWkR4c0FnSEY5dUFGWjZvQ2tDamV6MGJwelh2WmZwTElMVFRo?=
 =?utf-8?B?bHErSWJZM3o1WFZ4RFhhb3hHelRzaGMxU0FmVU1WVVlyUTRPdkg3cklqZFJF?=
 =?utf-8?B?d0RURU42RFF1azBoUHFQWFRQYjNQMktiNUdsN2M2WlZaZVB5TjJWSjlUZ3BX?=
 =?utf-8?B?dG1ud1p1M2I1RkFjV1JPRUQ0K1JDTXcvZkhMVzI3OTJ2M3JNV2l6WTRlN3Q4?=
 =?utf-8?B?MzFvcGV3KytsM1VaMDk5MzU0Q3BhalVVN1ViZmhQM0RJMXVLczBVNWxQT0tJ?=
 =?utf-8?B?d2UwcEUzNGsxQ1NuQTVLWkZqeTJ6ZHRReEl5OVlyQzBJd1pjdE9TRVMrZjlF?=
 =?utf-8?B?NU02RW5ib1lLV1dGTWRSV2lTMS9YU04zcGJFaXYwcXhCZC8yaFRJOUFOMjkx?=
 =?utf-8?B?ZFhjd1I4aXBKRTVsY2p2d3FteE5xMVEyUVZQelZhOWREb0g0bFhaaGFTaXYy?=
 =?utf-8?B?cnZLWkZyVWhGNjJmR0dqbm1UUWJGbmFpeXFwYk5SenVWKy90VE1JTENlL1ow?=
 =?utf-8?B?U2REWVhPZ0wyS2g3UDVsTzM2V2l1VW5uWEZWREdqOGdNM29iTWZZMkRUUVd1?=
 =?utf-8?B?MVgwSWIwaDV4Q0VvejB1QVJXcE1nR1IrNFAyMFJGUUFsNldzZ1oyalBPNW4x?=
 =?utf-8?B?Q01YYktpUXhUc3RNdmVnME1lNmhMOVdmRDBGd3RHc1BJRjkzQ1k0RGRXU1Y0?=
 =?utf-8?B?a3R1VGxTdzhNemM1d0F0Y1VJRFYybFUyVUkrRXVFaTdocGNVTk5rVTVVUGhq?=
 =?utf-8?B?T0FjSGZrVmtoOEJmbFFBU1BKbUh0YTBLdm1aK1FlNzBwaTUxaU01UFRVSUo1?=
 =?utf-8?B?bTZBeThUaXRtVVlzbEtxb25yeC9sbmZyVkVVVTlGenFWOU5CODNzcXpvRXZp?=
 =?utf-8?B?N0VLZ2cwWG1BMERBOUcvaUNLTjc1ZFZjeklFRXR3STc4RmhXT2hwdlBGNEtS?=
 =?utf-8?B?bFE0RUp0Y0t3QWRZcHgrT2d4Wm9oL0RwZkhCMHZyZnAxZW93VVpCWDU5VXh3?=
 =?utf-8?B?bERrQ01rSDl1S1ByK1hlZTByZHlXRTNvWExHUTVrQmw0Y09mYTBQckcrNjM4?=
 =?utf-8?B?d3N2VXZwM2VhKzNsZThIODV6QXVENGhHcDd3TmoyWERwWE1EbEtWeE1MbkxK?=
 =?utf-8?B?ZFhGdk5NcUhTdk01Uzl5VzlpWGNYN2RidnY2aEc3SzhGTnNGSkRuQVYvZ3pJ?=
 =?utf-8?B?dXVabUNnSUN3S0Q2Y0hCMVBWUW9oKzlPZmFEUEd1MWNrY1RiSG9NdWFCMWEv?=
 =?utf-8?B?NitueGZhU2dpeUUrS1IrbjRzUmVxTzJ1Vm1GWmkxcFllWC9rQmtHNlNWSHo4?=
 =?utf-8?B?T2NSVGRFNDFtbFpNZzgxMnRNYzd5d2RjcjRiYXRZWmUvSnNzejdkMHhVNVlU?=
 =?utf-8?B?ZjJNaDJraFRRVW5sZ2xoRmtDZ2YwK21SRzdDd1FvWktzOXFma1dGZzV3N0J0?=
 =?utf-8?B?Qm5lR204RGZjUERPQ2FHK245WFlmK2pnbUVRODBzVkRGMGcyRHhlRmRjS2ZU?=
 =?utf-8?B?MUNSNTE0b3JJZVZLVFBkL25nYUU4SFBlM015b2pvODlSU3BZUVgrQlRnU2tj?=
 =?utf-8?B?TjkwekY4cXdMY01oNm1vTDJNK3cyWElGN2FDZzBWY3Raa0VPcWdFcEovU3Mx?=
 =?utf-8?B?VEw3cTdtaW0wdk0rVHh6N1ZYclhRZ2YzYXdaclNvNUhYRThVUlc1anhpbWND?=
 =?utf-8?B?L2c9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7670e697-d649-4de0-fed9-08dab1c1f12f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4765.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 11:06:16.0386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nh8Q3JltbzV6mAYvX45eFjnVuq5QYr7qCY8C9IOl5WR5T+MuvQ1xi/S6i6ZfdR2BcoWAiSbtkk2ImGTgviq/yhjvKjwNBVZHWOu4MjBz17pA/Cpv2xDLRcg9w2UODBmM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6651
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.10.22 13:49, Greg Kroah-Hartman wrote:
> On Wed, Oct 19, 2022 at 01:38:13PM +0300, Alexander Atanasov wrote:
>> On 19.10.22 13:26, Greg Kroah-Hartman wrote:
>>> On Wed, Oct 19, 2022 at 12:56:18PM +0300, Alexander Atanasov wrote:
>>>> Update the inflated memory in the mm core on change.
>>>
>>> That says what this does, but not why it is needed.
>>>
>>> Please expand on this.
>>>
>>> Also, is this actually fixing a bug?  Is it a new feature?  Something
>>> else?
>>
>> The whole series is about adding a new feature - providing access to the
>> balloon inflated memory amount - it's in the cover letter. Should I repeat
>> it for every driver that implements it?
> 
> Each commit needs to justify why it is needed on its own.  You do not
> provide the needed information here at all to be able to review and
> understand if this commit is even correct or needed.

Ok, understood. I will keep that in mind. Thanks.


-- 
Regards,
Alexander Atanasov

