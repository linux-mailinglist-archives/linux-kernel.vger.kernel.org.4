Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8594170D276
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 05:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjEWDmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 23:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjEWDl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 23:41:59 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5171090
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 20:41:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abA9nTQVMbeTO9nhbkyKapATi/QD4m624JriMOo5taosFf/UrrrQoXLs72m7ef0yE2JQPrSBKZ5AubJ0cf3soSd2MP/EbzjbhsWp61JORMolIX4jR7hKRnXEKPf0MehhqkouY01NzTkkNH+nbBgU7INpYqURNkOoR2fwd8FOOqd68J//78cQmlzwxmCMTQT/xtQOb9iXV/EwBMlfK5m2MAqmAfov8qk5DoHL3QOdsT4zodeRGfGHgey89eXchBdO3xoInuvxJ8aZo2RgqyZfp837iLY5OVn9S3wwA6Mn/Jr5BDa4yVz9oxStYu/cWk1WZseM+iHWMB+IS56KykSAcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTOtTXrp2JKcZ9JLpWqaNzf41CEVVnZ6XRUxAL3Up2k=;
 b=XG0Z/0cUK1XYD9oqmgF1Hjl4eHNSj9osMU/wcR7jN/9805IZ+3uDmi09TdSbSGmDWAxtUp7UFcQPGcFofqAah4TxLAUQyfdh+MSB58wf+wC1tnmhCn7H53hhsRkLw71/8vl2MKKZ28Ob1Xu6vEt3iAwwfkqHVyyUqjYHppCSI6hdeW24UfzZLjadn0j06Sx4b8D/OHcCVpaNHdbsBWRe4y+M6mJd40uhOOYAtrdoTaX0d01HxAN9he3FaB1N26ZBM1Jd2JhBctqYWiXdhPr9fkS4178G0DdYwUA+gk3hv2TZbFyJJTKyK4x8S5jt5AddAiaEHbi8y7ow1G2MkQCV3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTOtTXrp2JKcZ9JLpWqaNzf41CEVVnZ6XRUxAL3Up2k=;
 b=aa3xBY/N52EYj6gkTE4I4znhg3ld7uXtKFfFmPds1Sk+ZJGEkdlsOj8Q2f4x9uL54U5GA4iaNJqUBxRB/GkgfCl8SQFDQmy5azQF9jV6kRSO5VNYA3iqOpHbcDuegItnS5MEJk4I9Nep4Jd6Pwujxk7wTl0Sk0CbqvjnP+537oM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 03:41:56 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::5a2a:9873:3192:6c1e]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::5a2a:9873:3192:6c1e%4]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 03:41:55 +0000
Message-ID: <700f08ad-0eb6-4ad6-329b-fe5b9cdb6a4f@amd.com>
Date:   Tue, 23 May 2023 10:38:59 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 4/5] iommu/amd: Do not Invalidate IRT when disable IRTE
 caching
Content-Language: en-US
To:     jsnitsel@redhat.com, Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com,
        boris.ostrovsky@oracle.com, jon.grimm@amd.com,
        santosh.shukla@amd.com, vasant.hegde@amd.com,
        kishon.vijayabraham@amd.com
References: <20230519005529.28171-1-suravee.suthikulpanit@amd.com>
 <20230519005529.28171-5-suravee.suthikulpanit@amd.com>
 <byrqmwgki5ak5yn74ubvgikeb7ibrzml2lcnnx3qgkyi2omn3x@qyo5q5atbe33>
From:   "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <byrqmwgki5ak5yn74ubvgikeb7ibrzml2lcnnx3qgkyi2omn3x@qyo5q5atbe33>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::31) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|MN2PR12MB4111:EE_
X-MS-Office365-Filtering-Correlation-Id: 40866b0d-1c4a-4816-e2d2-08db5b3fa71c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 29/jZEKPvmqfy/BFp2o3h+S02v1UOOF61FOLHrqpczDfmpk3BiNRoEi/D/EWTgO3mxHYULCDqZpAmSFR0x/CLMoQdlCFnunTpPoOGe491WxPCAcKOli3RwqLFPTfNhYB71mwe+Z/7rKKbr1J5+e7V7B/00kAU8QOrrJNtDko3h5CehSfwRtqXz8lMjW0mG6qkx98sTCS1eUasWBnHT1Kd5L+ILQDS+uNN9izuuIiimk8KQwOu8P74ej567ouczCpsmVjOyICqCE++8W8xp1+It6BHKc4GNPUJ7yoCIJEogJswSJ/IQE6qiUo9PhsSd7Pvsi4iMKaQ646Gj2I9Hy4FYaVkeiHfSUf/yx6hiXF0EW0eFCkeQHqMmGi7aprrIgBcqOvm74jZ/977GQ2yUAfIJELd1GQBh4+iignXb1YvhIjjqx9aVtIr1B42LmYi4Ot/r3jhJq2hB/743w/AfPO+vKj3koXOKrW4WNVyrlW4Lw+Ufpdu4yOQj78attUp1iu3om49EChyZQ3vgIzEs0OCwMlahGsAmLG/6fHs6oF/pzOEwDW7aFW1pMWFSQW+tT9Vf/Zpffs9ZM8pjmrmRDdbsp5kyb02KjMdc55HlSNhS1I0eYE93A6jQK9C0oX0+w5BDdqeoCMQqgZUIXbZyAe9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199021)(41300700001)(6486002)(478600001)(31696002)(31686004)(316002)(66556008)(4326008)(6916009)(66476007)(66946007)(8936002)(5660300002)(86362001)(8676002)(36756003)(38100700002)(26005)(6506007)(6512007)(83380400001)(53546011)(4744005)(186003)(2906002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEVlbFdqRkZvOHZpbkFiOFlCbGdkbENPSElkdXNBWXRXUzBoUCs2Q2FOVVBP?=
 =?utf-8?B?dzdveU8wdC9QWTZUTlVxMHAyTTBGN29oVmQrUFR2ck5maVdmRVVxWGl4Y0g1?=
 =?utf-8?B?YlJzNm1WV1NWUW51WiswOXFoSGc3MEVZK2JOby9KNnpaN2ZiWnlUNFJXVEN6?=
 =?utf-8?B?SXlFbnB3OEVEUmNUcStzZ1Z6a3BHL210bGw5Z2dIQjlGYUFZUnhnZnZrZXBr?=
 =?utf-8?B?TFc3bUVFTm9HWXNQSG12akg3R1RxbzBiS29udjF5bDZVU1BENUQzTjB0dDF0?=
 =?utf-8?B?OHRUVUxhVHk5aGp2ZVUwdHE2dmExQmxPMkFDcFFBYXRZbFBtUCtRWmNKaGp5?=
 =?utf-8?B?QTY1SzU4OEJwR05RMHkyL3F1YytMaHpBTDVXRE9ya3p5aUFQUW44ZEtITUpG?=
 =?utf-8?B?NWVlZ1FrZ21ycm1YSFlCQm9zQXo2WGVJV1lrODFnQWtyV1pLMEdKS0x4YS9C?=
 =?utf-8?B?MG9weVJJOVZBZkYwOUpzK2F6aG52SUNNK0tzS1VHRlNzL1d3SC91N1U2SWJS?=
 =?utf-8?B?eTVYbi9mVXNkMU9yTnUyNEwrT3pxSHFXV0JRY2V3b013aHhJQXgyNGxiSkQ3?=
 =?utf-8?B?dTVJY2JDVWZ2ZDN5Ky9ieElBd3hTN0hHdnJwMmxWVWFnYWpvZXJ1M3dCN2RC?=
 =?utf-8?B?cmJJMVVvajhVMHBXV3IyT3F6dDJxTzg0eExuRXd0WTdjdjRqRnBHeWxUcXA1?=
 =?utf-8?B?RndHUDY5QTF5a2tzSjlMSUtYNm9XOFpjbGlONys2b2dwNDd5Q2pxYXhqcnBi?=
 =?utf-8?B?YXZUQ2lGVTdOS2tvMlRURytLM2NDUHozNUZQRU53ZEhNZm1LM2NnREdkeENV?=
 =?utf-8?B?dEM1MzBGV21tOG5yNWZac245eWJSY2ZxRGxnb28vTCtUWWRMdVl4YThEc0Nw?=
 =?utf-8?B?V2pGb2ZWbno4SENEUms2bG1XeVVqaVFLUkduOXV6OHZZbGY2dDBkTDJFYWQ1?=
 =?utf-8?B?VzFjTTVCeHV1L2xURTNTdkJLOTRMWERpU3QyRmxjOEJsUDFUUFE2UHRqSGgy?=
 =?utf-8?B?VGxuWFl1ZG0zSjJuVnlTOWwrdjBjNXZiK0toOGN3ZXJ3ZzQ5bjZ5TEUwL2RK?=
 =?utf-8?B?R2RTSW1DR1pWTGQvZUhvWjNPaFBWT05vaXhBUWdva1k4cDRVT3U3ZGgybDcz?=
 =?utf-8?B?R0xhWWZyblcrREpCZnpCNlFjVUpiSHVETTI2SWgzZ2hSelZhOHptb2hvVTYx?=
 =?utf-8?B?TGsxV0ZVcWpHOXRVd1kvT2JxZDJsOHZzQmNxTlZsTGZzUEhCU1UwenJTdUQ1?=
 =?utf-8?B?OC9tWkdtaXhTeEV3bHBBTXFuNmYxNG5kRlNQRHdUbXl1L0VCU01paUU5a2d6?=
 =?utf-8?B?ZXdVdTdkd1FMVUl6ZDlrbGJDeVRUNGdGTWp3eHVTRTNmaFpNbmxFeWFuMHhG?=
 =?utf-8?B?SG1kblJTSzZNbXJYNmVoM0Zwb2pCUXJDT0ZHTUo3RFpUR25aUWl5eTZ4WUZK?=
 =?utf-8?B?S09Sa0lVWHA2UzFlMzJkMjFLTVpCMFlUVTg2SnFrQUZzZXIyMm5ya2VBTmhB?=
 =?utf-8?B?dkxzOE1qLysvRHpEc1NJNThsY0JzNks0dXU2UEtXV05EdDUwODYvM0tIbXA5?=
 =?utf-8?B?NkxYcEpqZVR4aFd4TWJWcm5CaHhGREdmd2xXdy9HdWtVWTRJMno1SkhBMDlk?=
 =?utf-8?B?YnBlZ0YyaXBYdjMwUVNNRnZnaUlpQUhDZGhKY0VRaUhUYUVMbm1sOE85MnF5?=
 =?utf-8?B?SWFGemtPamtSQjBldEYwU3VBRnBZT3MwZlNmNkc3d1MvdXA4NklGWGRUVHNw?=
 =?utf-8?B?a0tkRmVvQkNibGZDZTdraDVsaFRqRDRNV2h6ckZCQkZXanF5UElLRG5sTG9s?=
 =?utf-8?B?SUZDelQrZFljTVJRbTFNZTZkaVRzcDJVTmhiQ2xZUXE0M2VZbmZUaGJlVmNN?=
 =?utf-8?B?WWNNZURHYUdlRVhZM1VxZ3hMUXJtZjRFYkQyVS9EeHhaRi8vYmZiUm5yS1c0?=
 =?utf-8?B?Tm41enFwcUZkbUorcDNRQzhpbFFCQVdBOUtxMEsxUVo3L3pBTFZxbTJQb1o1?=
 =?utf-8?B?akJlbTdLRUJJdmVkQ1BFMzhaTFM5MHZFSWJFekJLVytwZS9OT1piSnJjYlhq?=
 =?utf-8?B?L3VPbUhYekIxaitSMG1xdEtFcmdnVDhUTjBHQ1BjeTJtUzc5bGlpSFA1ZXRK?=
 =?utf-8?Q?auTLMiFIkDIXoKIZ14VoLptP0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40866b0d-1c4a-4816-e2d2-08db5b3fa71c
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 03:41:55.3173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+OOGyK5moya1BHM9BNarISIyHH+g344x/82CX4VdjAJEAXWzQnPNcxjc/LLlregLnthtrUM0W/mW0nxnua2KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/2023 7:17 AM, jsnitsel@redhat.com wrote:
> Would it be clearer for the summary to be "iommu/amd: Do not
> Invalidate IRT when IRTE caching is disabled"?

I have no objection to an updated summary.

Joerg, Please let me know if you would like me to send v3 with updated 
summary.

Thank you,
Suravee
