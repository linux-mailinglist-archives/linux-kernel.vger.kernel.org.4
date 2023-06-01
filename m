Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547BC719C2C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbjFAMbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjFAMbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:31:43 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B25119
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 05:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vckG8mEOEEQ6TigMiJbDqHyq0tn1H72eSApMQSUAks=;
 b=eXhjHQPJh+r/sSSSzi2sNITWoF5ry6miXjC7YwkOutPglvVCK8fvChpOhiryj4K/194uv2rUorvKgRFddmYYesJsw15b10w9m/u7cUGkELYN0jTZd6zbn0y4YlFxoPLs0CBRKG0G+SM47J1J5IHvq1gb+Eiz3genG51Ny5DT1R7wlI1bITNmib3eDkaN9aY5E6wRFiIUNX4QSpJTMdAabbBguZpauP34ZI3YXkNz153RhGpGUCJKm0GYlVZdO4Xny8Fev8VTSRL+o36TM0QhtOoTdnGqdwcfEqIhzMgXxXeHqPS8YaZt37bJ4V3rqxCKeuIaR9PUyK2cyNH0lDgu6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by MW3PR12MB4555.namprd12.prod.outlook.com (2603:10b6:303:59::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 12:31:39 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::d13:d49e:d598:833b]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::d13:d49e:d598:833b%3]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 12:31:39 +0000
References: <20230531044018.17893-1-mpenttil@redhat.com>
 <87wn0pt13j.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     mpenttil@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH v2] mm/migrate_device: Try to handle swapcache pages
Date:   Thu, 01 Jun 2023 22:25:35 +1000
In-reply-to: <87wn0pt13j.fsf@yhuang6-desk2.ccr.corp.intel.com>
Message-ID: <87wn0npdnc.fsf@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR02CA0063.namprd02.prod.outlook.com
 (2603:10b6:a03:54::40) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|MW3PR12MB4555:EE_
X-MS-Office365-Filtering-Correlation-Id: 945e0ea7-7eb0-406e-35fa-08db629c258f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /wELuVA3A0z84TuTnznju1EOHoJS1nvU0Vsci6b0nolQIBVBPaGBH02LvAhvzOQ14ZvPoNJ0jQnOiDT6+WknY0yTq2i+uxQWxB4Eu4X3YTJszkMhDfP70GNEvnCkPbATtVzFFcNtHRapdgZaHiRC4dxat1fAjkU0w+OeR8lqiTZTSoDGyFa1hep2ALPXMwSdWfecy83HllwwZYNqIjtz6ZwPE9n+yrTLhR+wBWdnwI2FPcy5bQNGk9DUUfhSiyVwuf+Pg/RzdigueE9Qyks+GHs6nLzQrjTRqfh0vg47l4WviAmDXnrXNJIfJTH+l29TR69nh7L6qGdZ08yh16HvzRBe/Dt88pGA/GRg4uaFlrotbZa5otN1Q3D+bBgpa/QQHDopYdumis+H56AdaXPGDNbjo1V5MUaev6iDky3fqDvhlyajOWwm91VxqATXDNS7lldlub1L0F3Hj/R9xFLxdOh6/RdUrQ/7uswhdAcN1EzP8PCl1KFHlri2AxtFFrGG4Fa3Tbh09Sw/CO/u2S1fQheKTH2FT2C5ZWAfvGhE8VH/Yc25rmgNMdJ4yfB22LA1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199021)(6666004)(6486002)(478600001)(186003)(36756003)(26005)(6506007)(6512007)(83380400001)(2616005)(38100700002)(86362001)(107886003)(316002)(6916009)(4326008)(41300700001)(66946007)(66556008)(66476007)(2906002)(8936002)(8676002)(5660300002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?andtV3BvNGxIS2hSV1BDbjNxTzRCVkR0NktJZ3I3bHdHanJ3V0dINXdBOS9M?=
 =?utf-8?B?MXdOWEN2bXNHKzNCTmt4ZU1laGhieTZNUmdlQkdDWi9DUlVFNjAyRjdQa0wz?=
 =?utf-8?B?RHNBV0tKRzZVVjFqMnlSQkR6YWVaRDc5c3NMV1hSbnZ6UmR6VE5RSTkrcE1F?=
 =?utf-8?B?ekxOTC9lNTdUd0JzWHMwdWx2dmZRNUJIY3FXNk5lZkdDTEpJWXRwclJRVHFa?=
 =?utf-8?B?ZU83RFRFOEhrcXB4MG1YUDZnVjJFc1Rwd2c3ZW9ENFU1QmdSSGZVR0IxbjJL?=
 =?utf-8?B?MnN0OU1ya3dHRFE1UTNseXRVME9sbVV2R1ZUL2F4akR2bEttZG96NzEzdml4?=
 =?utf-8?B?ZjBkVklOTXhsbXV3WXFGSjVaZ09kZnUwYWR5NE1UMUdQSFoxdnkwd3pmUmoy?=
 =?utf-8?B?UU1nVU9nMGY1VTZ1eGRDdzRUR0xxUlBKOE05NEt6RGN3TzBTcFpTYkwzWHJ0?=
 =?utf-8?B?NlFjamI0RHA2UElHbGJ2djZuT0RCbC9TTHk2Q0NwOUJISWN4MG1ObHpheE9I?=
 =?utf-8?B?STlpMmFtSURBUWlhUUZrcE9OU2NwblZjR2p1Yk80ejdVbURTbkM0WnhnZERK?=
 =?utf-8?B?UWpwaUVoa2MyWTJiVFBkTmVNOGp2Z2NDa1hCcEVJbm01emZVVmtnWU0zd0d6?=
 =?utf-8?B?Nm41OEIzK25welFjcW1YYmY4NjR5MXE2NTJNTndQSExvaVo3Z2FQM1VOUEps?=
 =?utf-8?B?cnNVWk9MYUZKYVFkdGlmcllrZitOcERJVTh5aHhpajVtUmpaQUpmbVUwbHBS?=
 =?utf-8?B?bnhYZWNWKytRWUMvQ2ZqWTFxUTk4TDMvRy9PdlAwSHNkSkczM2xvTkptb25G?=
 =?utf-8?B?ZGFKNHY2MDMzWHJEUWVwWWlwQ2dGSzFwMkxPVjJ6RkplMTY4aENJTFNPZ09i?=
 =?utf-8?B?Vk5rWU1wNnZJWStibnJRdnNEbStxR1RWVEhEa3ZzV3I1RFVPelB2enBsc3Vn?=
 =?utf-8?B?WE50VFhnUjk0ZTlYTHFOSmd5MzF5M0VmK1pPenBSMzZSQ0VXWnh0WityUHov?=
 =?utf-8?B?Mk01WmFqTHdQR0tSM2pFdmwxa244MmQyckhQRGdGazJEenEyWnMvSTdldHVx?=
 =?utf-8?B?RHR4SFFCaGprbU5Tb1ptSDJTdWNvcDc3WWpRNFN1OW80K0ZtZ3l2cWhoMWJj?=
 =?utf-8?B?THdIWk01K3d1ZnpaVzlYWDczbnp5K1JRUFdmWlY1RUFqWVJHSk41R3IzRCtO?=
 =?utf-8?B?bWx2UndMNXk0blBVMHk0VE5YQ0FSUG1kNWc0akErY1pCSWNWTEFodU1ZNVBQ?=
 =?utf-8?B?RVc1eEdVTjl3L3Q4RGMwcGd5ZkdqYWx4NFBFdUdiZDFHSnNOM29zVCtVcWV2?=
 =?utf-8?B?ekVIYzlWb0Q3ZHpsNmYrM0hmUjdVU25GSURXMGttM05oRnZLS1YxWk1rU3pw?=
 =?utf-8?B?U1NieWRBRTdreXIwMmRidzZIR2pLdDgrejhyYzBVRU1mZC83bW5pL1F3Q3FV?=
 =?utf-8?B?UWFlTVFNUWxWV2RFV3djY3loakFHT1hJVzFPcWtjc0ZGYk96Rkl3Z3dMRHNv?=
 =?utf-8?B?TmtnbGltOFJuaUlHd3lRZlB3QUlnK1RjZ29DdGZmc3pRdnlGVWZBNGUvUUhk?=
 =?utf-8?B?Z2NOOTBVYnJlbDZUZ2d2NWd3b1NxcW5sYk9rQTJrMFVlMzZCQzQ4bW9BSUNM?=
 =?utf-8?B?czNCbWUwMVUxTlRvRG43OWhwSWgxdW8xaDFPY25wV0dteDdwMU9WM1JSSVZh?=
 =?utf-8?B?Y3RhMHoyT2VCRmpsaUx3NmxTK0dZVW80V0VuUkRiTmNzbDA1VE1veGtzaUhq?=
 =?utf-8?B?dWI1VGRsd2MyMi8yQmdUZmR2RkkyaUlZSDJma2tSQzlvd1QrU3RwTzlSMUN2?=
 =?utf-8?B?Rm5QWk5yZ3FlZklkbUkvNnRVcFBXd2FCbzZlOWZEWHI0UWZQSkllUFd3TmZ3?=
 =?utf-8?B?eko3T25seXdIRm54TDFqeWVEQkJKeDZiakd0Z05sZWEzMnpDenkwR1pwejNY?=
 =?utf-8?B?YUZRZGdWWGNUVXdTYjlGMnJDN2RPNERPUXovWjV2L2llMENmanFvN0ZSTE1H?=
 =?utf-8?B?aXJBZCtyV3ExdjMyaytaVjJ1dEVNbHBrdnFIWW1FOVRkQXNiaFc3dTlHZ0dI?=
 =?utf-8?B?aGxNSzBFZHJmNlVUTmJzY2twS2xxZEhnME1uMmZUUkRld0xUbDQ4VG5UQ05p?=
 =?utf-8?Q?YAGZZWxnfGpB0w4Qeu5h1sOKo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 945e0ea7-7eb0-406e-35fa-08db629c258f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 12:31:38.9947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jzc4akFt//a+xVtpY6YwbWow2eMVL3ifjzJpZH+poRHYyubis/Cl0wxD+nnqFyy82de4C/h37Zn/TzH6Z4fs9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4555
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


"Huang, Ying" <ying.huang@intel.com> writes:

> mpenttil@redhat.com writes:
>
>> From: Mika Penttil=C3=A4 <mpenttil@redhat.com>
>>
>> Migrating file pages and swapcache pages into device memory is not suppo=
rted.
>> The decision is done based on page_mapping(). For now, swapcache pages a=
re not migrated.
>>
>> Things can however be improved, for swapcache pages. Try to get rid of t=
he swap cache,
>> and if successful, go ahead as with other anonymous pages.
>>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: John Hubbard <jhubbard@nvidia.com>
>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>> Cc: Huang Ying <ying.huang@intel.com>
>> Signed-off-by: Mika Penttil=C3=A4 <mpenttil@redhat.com>
>> ---
>>
>> v2:
>>   - use folio_test_anon() (Huang, Ying)
>>
>> =20
>>  mm/migrate_device.c | 24 ++++++++++++++++++------
>>  1 file changed, 18 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>> index d30c9de60b0d..829bbc526758 100644
>> --- a/mm/migrate_device.c
>> +++ b/mm/migrate_device.c
>> @@ -747,13 +747,25 @@ static void __migrate_device_pages(unsigned long *=
src_pfns,
>> =20
>>  		if (is_device_private_page(newpage) ||
>>  		    is_device_coherent_page(newpage)) {
>> -			/*
>> -			 * For now only support anonymous memory migrating to
>> -			 * device private or coherent memory.
>> -			 */
>> +
>>  			if (mapping) {
>> -				src_pfns[i] &=3D ~MIGRATE_PFN_MIGRATE;
>> -				continue;
>> +				struct folio *folio;
>> +
>> +				folio =3D page_folio(page);
>> +
>> +				/*
>> +				 * For now only support anonymous memory migrating to
>> +				 * device private or coherent memory.
>> +				 *
>> +				 * Try to get rid of swap cache if possible.
>
> I think we can delete the following 2 lines of comments.  They add
> nothing except what code says already.

They are also a bit confusing, because a private file-backed mapping is
treated as anonymous so folio_test_anon() won't filter those
out.=20

I will test this tomorrow but the change looks good so please add:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> Otherwise looks good to me.
>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>
>> +				 * page is here file or swapcache page, could be shmem also
>> +				 * folio_test_anon() filters out file and shmem
>> +				 *
>> +				 */
>> +				if (!folio_test_anon(folio) || !folio_free_swap(folio)) {
>> +					src_pfns[i] &=3D ~MIGRATE_PFN_MIGRATE;
>> +					continue;
>> +				}
>>  			}
>>  		} else if (is_zone_device_page(newpage)) {
>>  			/*

