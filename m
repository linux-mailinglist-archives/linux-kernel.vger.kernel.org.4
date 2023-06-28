Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F24741217
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjF1NQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:16:10 -0400
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41]:2529
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231698AbjF1NPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:15:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXVl/wKe7FOrmrjAWSgDszX/FnsFhfpU+oOVQ9Ms8yqVlWWxtz+fjlLzuuROMD5zDgeEB1mObmsFW4+f41UAzEJ1d0ev608YKgJd8QPPYVwDbYHF8NRBylhq4qs/jYpcUP4ZsDWAhBTgP7HGbm4foX6Hnpu8BgfzNGPa1EjRq8E7y1EWZAP1TuiV1Q0bzH2PCj5y+kbCCv3/1wXYlTSlkiMQTFF+5ot+b5h3B6tfyXWSEUwUZy8p4b9bhuHqWGrJu5f/19m7VgGJhYgfQgIZYsrEfFGG4fhGcfvZDTL4ZYT3eOB1K4Ow+r7vWumQSbSythYzs0J9ShZJr5AyoMg6eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umv3tlOcwAKRea9FMCN3hru8uNNmYXLG4rjQkOyr/+0=;
 b=UhLULac7W1o7mw+7qvHAaxX9gR4cXKcfslmfbMtIhiseE6E47bnA7YgnMhtqvigJJA3ufv8w4h8pIQPFceJW3NTeYM6CFGqQOEZkdTpSA45s6TuK8WmuAmUGTMBeap4rMMpXu2y6kGbXllCBHEDPvY0xLi0L7kyFWymDCh0utAcDncb9BI8qtgl6cGEBlqxEgNN6SNyZv6krubuk/PSl6gV0nOB/Ill6/fm2/nbeOAYu8svA4ou3f2u6zF0NF5b44sS9IDjRNSk5ZDTf7iiiYKQ45j2scTG8VFLobnvplF17dIzco0vMfYjo+SnoYNy8f7Nfrm/JBDuB6XFyAWmg0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 SA1PR01MB6784.prod.exchangelabs.com (2603:10b6:806:1a1::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24; Wed, 28 Jun 2023 13:15:51 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc%5]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 13:15:51 +0000
Message-ID: <9343462e-6a4a-ca7b-03b8-4855e5a33b72@talpey.com>
Date:   Wed, 28 Jun 2023 09:15:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/3] dedupe smb unicode files
Content-Language: en-US
To:     linux@treblig.org, sfrench@samba.org, linkinjeon@kernel.org,
        linux-cifs@vger.kernel.org
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20230628011439.159678-1-linux@treblig.org>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <20230628011439.159678-1-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0176.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::31) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|SA1PR01MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f1f5a2e-4b2d-47a6-7f9e-08db77d9cb7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1xfIL8URF8Ef6VReg32icpZma3Sd715dwET+M3lrr4yqAXnFBPRNl0LiFDH0BnFHq7jkN+IHtUvB+5eHziGO67kmS7ryb/v1UO5jlUA54zUWL0OGgsNriNqPwzyS1dBlgxPKnmS8JdqgOrPgayQZIzT6KjnJJ/eBF6JdPe1q8Xrjmd0htVgC39XExruvt4sqJEwpkkpAB3xKjMMszQkUQ0EseCjKwBXYhKXUNCBhPjCGiunTxvqemjIB3knG7PcHcs1YjdWgzSCjhBV1Cv3JuATqV1/9pWuB2+5GDjPJhJkvCzrnbjAz5lxznJmKG+uK1MexJpNoEB3bKbGmOl9t4p7Bt1VNSQlWWH11xl6vzzws9rVm2/pMO5w6pg77k4CDFO1iFw7p4zaOntHkKK8+XdfdK2Qu5noZ55a4guSRoBQ0UiEvqvPRp5mfvVQQ7Tbg74GrwKU4Ds4Na5zcO9mRUD4jzoViSKJX9cLGWn101VYnVymwhcqTFDPZYadScZMTP/cHzoJx+ntzmOj9DzNoqtwGjnupHfTGggL/HUkYsseCcPSAd22Xl0Yi+Q+/poKh+fLXPuvdxGcj1aDHR+cJ79WSEmEyRiuxKS7DyvsZrmx/qru3yTaQu14NFu31JgriisbgI5ylsk4gQBKWonWSeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(376002)(346002)(39830400003)(451199021)(31686004)(36756003)(53546011)(6506007)(66476007)(5660300002)(86362001)(316002)(4326008)(66556008)(41300700001)(8936002)(38100700002)(31696002)(66946007)(38350700002)(8676002)(6486002)(966005)(6512007)(2906002)(186003)(26005)(478600001)(52116002)(83380400001)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGNrVHEyS05pOXVhUytGRFoveTF0b2RMRDZRejh2cEhKbVM0YzZQSVJ6TFJE?=
 =?utf-8?B?elhPaldseWMrYXM0Uk1KbnlLdVpZUzI0RlVLTFN6RVpZdkdNS1pOS1U5NFZF?=
 =?utf-8?B?M1dob1RzaWlTd1RNVUE5cHRFZGNwb0xJc1JUc0hBSk5vaUZIQkhSY1hWZmZa?=
 =?utf-8?B?dW9sVTV3TlFCbmNOd1MwS1kyMC9YZ1k4Nk00bjRySjE4TjFaaTQ2QzlLblZ0?=
 =?utf-8?B?dWRaZGtDMWZRa3NZM1ZjdWVYdGFoay9ENDVzZHYrU1VJWk1ReVFuRmZraHA1?=
 =?utf-8?B?QmwwSUI3TnNjVmQ0VlJpenJialZMRWdrUnU2Z1JwVkFkclNBMGx2dHhIcCty?=
 =?utf-8?B?NGJvSUpSNklWZFlXNWg1cjdMNU03MjJCQ2ZRRHRzNFlYZmpEbEEwbE5Wakdy?=
 =?utf-8?B?UUh2OEhRZzkxME9OM0NQRW1CMWx1WkNpR2syb291Z0JGZXdKbFNZL2pJbnlx?=
 =?utf-8?B?VlJDcWV2R1EzeUtGdlhHOHF4RytSb2h4SWg5aTNuZ0pUUy9qZitUV29QMkEz?=
 =?utf-8?B?VTJBUnRRcFRieHdsUVZSd0dwVXVhZk1mY2h2cWd1Vkh1NXhEZWpKNXZmbjNI?=
 =?utf-8?B?a0xzQndKaWRDby82c1FvNS9jMXpkZ1Ixb2pHcHFPNC9CdEd3SUlPMjB5U1FS?=
 =?utf-8?B?QnUyb0xsdnAvMXNwYUJud25sY04wWWlyZGxWUjF4TGl4RXhOR2Q1NVBUbE92?=
 =?utf-8?B?RmRWeVZFVVAybkYxVHU1eE9XcDQwT3p1dWw2ZkdZbDBvZnhkRFlaR1p1ZWJs?=
 =?utf-8?B?bkRIZUFYQWNIMFlLY0hjR2hoQkNoMk1rRlp3Vm9jZE84T01hVjduckRSdTU0?=
 =?utf-8?B?bWdrd2J3OGxmTDhnQTRXNmxGWGwxZE1mR0d0czR2MGRsQXdNM1dmcm1ycWRD?=
 =?utf-8?B?cmRmZWJWNkY4Sm1JZzYvR09KSEx4TFJ1bVk1NUtQWEcveG9Rb1UzbjloaERJ?=
 =?utf-8?B?NG5MV1FJSjF3RVpPSHlwVVN1TVVGUG01RUdSamxwazJMR1FKTnM0K3FrazVW?=
 =?utf-8?B?cmY4Yytzc3RJQXBoeFNaaXhMd0wrRHJNODk2RnVnVU9McU15N1FVeVhpNzd4?=
 =?utf-8?B?YUwvZXMzRGg1NC9yOE1mVVJSbXVmYzlMeGUvNjduY2Jaa0l0ZFBpaTE0bEZp?=
 =?utf-8?B?dStOenYzbko4T0pXNHd0amVXRkM0eWVRUGl3dW9ZQVZ2UTZpRGlzc0wrckda?=
 =?utf-8?B?MHRQRHU2RDllcTVXaFhmcTF6T3J6M0h6WUczL2QyWmxFTURvbmQyUjFDZHdl?=
 =?utf-8?B?MFRCOG44S1d4SjErV1VoSHE2aXQ2WmVsbXBOakRvWkQvVFB6MGZmaElJMEVz?=
 =?utf-8?B?V2JmcWJLb3QvRWxxTUpNNWNWVE9BUmVFWlZGUDBaQXJTWWhZb2IvaXFJbFVP?=
 =?utf-8?B?ZVFic0dkN0lRL29lY1BmdHpFQkhVbmx2WjFnUllrSzhJMkllOEQvYXlHYVRi?=
 =?utf-8?B?Uk55OW02N294NTl0K1ZJVFZaSWVLUzgyRjI1TlBsYTNrRDluR0Z5SUc5VGVI?=
 =?utf-8?B?SVAzNzdGZUFZcmxabWZqYmhTN01LeG4rTE1neDJRbTNYeWFrOEREUUpmTFVV?=
 =?utf-8?B?NktpOGR2N0E0R2UwdkcrZ3QreEZUTjhKbVFqZW95cG84R3Z3dmJGbWRuNVZV?=
 =?utf-8?B?QlhQR0hvVVJBRDU5R0NXb0FOT0xTN1d6U1RvbzFRWnhJazZhUms3WWovRTBC?=
 =?utf-8?B?VEdZQnlhdHUwZkJjYnpndkR4cWZXOERrVngxaFRvUmpOeExSS0pkZm5lckhG?=
 =?utf-8?B?VHY0TWdwK1dnT1lXVGtDUUlvNnF3OWY3amZGZ2FkQkhBRXdHQjFrM0RFS1Rv?=
 =?utf-8?B?Zi9SL2d0TlZoR2lHMnloWWk2aUtvNTZWdnM4b2NWNDJ3NitBWEY3WUg5dVZH?=
 =?utf-8?B?QTFUaHlHUGtLRnRlVmp2ckJYSjluOGlKVWVVNTk5N2p3MFFCSHdwMTFEZ2t4?=
 =?utf-8?B?MkVtMVAyNkRFc3JxYklqM0w4RGh2Z1pkaUw2U1FueGlJNWZYaDZqOEloekwz?=
 =?utf-8?B?RkQ0R1ZaNXlJVVArY29lRDhHQmgzS1RxRTB6bmc3RW53RkUvaVJoSERvaWlN?=
 =?utf-8?B?U0h3TVd2YjYrUnFjSG4xZUJLblJWb0Nub1BOQUhiNUdCakRsL1FIdzkxSlJj?=
 =?utf-8?Q?g9uiznqCG2sSZGjdmtukphLxr?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1f5a2e-4b2d-47a6-7f9e-08db77d9cb7e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 13:15:50.9976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5uFo9HEswso7UVRFr8qy1bCrjwSFCD7/YeCFPvJpcRFBMbeleMM0V45ABj3qUHjz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6784
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/2023 9:14 PM, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The smb client and server code have (mostly) duplicated code
> for unicode manipulation, in particular upper case handling.
> 
> Flatten this lot into shared code.
> 
> There's some code that's slightly different between the two, and
> I've not attempted to share that - this should be strictly a no
> behaviour change set.
> 
> I'd love to also boil out the same code from fs/jfs/ - but that's
> a thought for another time (and harder since there's no good test
> for it).
> 
> Lightly tested with a module and a monolithic build, and just mounting
> itself.
> 
> This dupe was found using PMD:
>    https://pmd.github.io/pmd/pmd_userdocs_cpd.html
> 
> Dave
> 
> Dr. David Alan Gilbert (3):
>    fs/smb: Remove unicode 'lower' tables
>    fs/smb: Swing unicode common code from server->common
>    fs/smb/client: Use common code in client
> 
>   fs/smb/client/cifs_unicode.c                  |   1 -
>   fs/smb/client/cifs_unicode.h                  | 313 +-----------------
>   fs/smb/client/cifs_uniupr.h                   | 239 -------------
>   fs/smb/common/Makefile                        |   1 +
>   .../uniupr.h => common/cifs_unicode_common.c} | 156 +--------
>   fs/smb/common/cifs_unicode_common.h           | 279 ++++++++++++++++

So far so good, but please drop the "cifs_" prefix from this new file's
name, since its contents apply to later smb dialects as well.

Tom.

>   fs/smb/server/unicode.c                       |   1 -
>   fs/smb/server/unicode.h                       | 301 +----------------
>   8 files changed, 298 insertions(+), 993 deletions(-)
>   delete mode 100644 fs/smb/client/cifs_uniupr.h
>   rename fs/smb/{server/uniupr.h => common/cifs_unicode_common.c} (50%)
>   create mode 100644 fs/smb/common/cifs_unicode_common.h
> 
