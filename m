Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145CE6070FF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 09:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiJUHZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 03:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiJUHZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 03:25:18 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2126.outbound.protection.outlook.com [40.107.21.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293EAF01B6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 00:25:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1zGkCElN3xL7GCtAFwrUcYmeNn7MsrPRxgNDAVexFMlro+jtu8KJfxi5lH6hH32QQnrBwJfwPbv7KhlbCxl4soVeUX9FaR2IWb9NHa8HLxYj/e5OpHqcxKDqEOogC5DhJWECHVuHNvMEeEJi/E0L4KSwSHGsyr77SE/MKDOGvKyrsElQ2EjekGUN0vIdKv9Jg+jBtoFuNeevpq1pDG7Q1ALdGhbuKHU1Fnnnf1Ima/C2nkl3h0WwxqM+1lT9xbVNpr0GJ2bjNmRaxhbreLwjs0jE0GzC8+Mvs0lse/7vweJ5IvQTsld7PxESnEBN/gDrRwVsFfjBRZOUtLzH1FcSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gh83QUE67PHxeBoG5swqZGBH/UOl971p7Tj3amBlqt4=;
 b=g+uU5kT0LPbsWqq/CagLOZbfPcJcFfWR9TsYSp3Q5phdxLSzMxlZJ7XT5EmCr4VoQFr8ShFW8bKtCftSuxqJ6iS7wScmcfnOkxBPuQh8fwolOYJzgt2FQrGrtDzqxqhW5cyBequuujE1nJ9DPRt8wsWs18IhMq8+4n+RSrl9cpNEbsUMVuUsrOhq7PU6CXLaeZi3bwJDnKBViE120fsS38hcwE3bvd+QmCvchmTrqPcqn8kO4L02flCF1k0EwDVEKWrmj73JxmfMTrGmbweuPJrcmK5gTBw7typQEmZ7uiT9NlMmXAGLzHOikSLvWs5l7c46z1VdMcDa0vg9OmcPIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gh83QUE67PHxeBoG5swqZGBH/UOl971p7Tj3amBlqt4=;
 b=t6dH/rucssOmPK/iEg2UNVGMkGH+0BeZiTYtpbiz2is5UgTaT1CbUV1SSKIdEW0IUn0r/n0w1OaU6TKYiC0sq37lKLlarb8/LSij6yJ/3L60/odLIAQoJL66ZlYf4j2L3HP5I+41rGcd8gepUu66AqOc8XVa/U2mRInimaUeaB1fsMjI9sISN22esIlCZD8NioeDjv4vb3K7hrsF+QuaGRiR1PFmPqbbZNp/3wnNxcaBEt94aaTagtmReIWGv86JFgdLo7vqIZTHqbhv0T2kM4IxwMtgvFeHq86EGpNwoa9KqirUZ1uvKZZ3z5jIlkJsnkv2uafI04Gt+dtEDuVD0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB4758.eurprd08.prod.outlook.com (2603:10a6:10:da::16)
 by DB9PR08MB9562.eurprd08.prod.outlook.com (2603:10a6:10:453::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Fri, 21 Oct
 2022 07:25:08 +0000
Received: from DBBPR08MB4758.eurprd08.prod.outlook.com
 ([fe80::abdc:cee5:91bf:4c78]) by DBBPR08MB4758.eurprd08.prod.outlook.com
 ([fe80::abdc:cee5:91bf:4c78%7]) with mapi id 15.20.5723.034; Fri, 21 Oct 2022
 07:25:07 +0000
Message-ID: <627d2c7f-8ba0-2910-a98d-ef42b9dd5ade@virtuozzo.com>
Date:   Fri, 21 Oct 2022 10:25:05 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [RFC PATCH v5 6/8] drivers: vmware: balloon - report inflated
 memory
To:     Nadav Amit <namit@vmware.com>
Cc:     Pv-drivers <Pv-drivers@vmware.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "kernel@openvz.org" <kernel@openvz.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221019095620.124909-1-alexander.atanasov@virtuozzo.com>
 <20221019095620.124909-7-alexander.atanasov@virtuozzo.com>
 <39FA848F-290D-4110-B27C-8822377E6AA5@vmware.com>
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
In-Reply-To: <39FA848F-290D-4110-B27C-8822377E6AA5@vmware.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0601CA0027.eurprd06.prod.outlook.com
 (2603:10a6:800:1e::37) To DBBPR08MB4758.eurprd08.prod.outlook.com
 (2603:10a6:10:da::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB4758:EE_|DB9PR08MB9562:EE_
X-MS-Office365-Filtering-Correlation-Id: e21be0d2-e5d8-420d-28e1-08dab335618c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bOo5y+JCiSeK6q1Ln+UnfrEinidB40lgcrhmB7VKn/pwN+Kp6Lw19uloJowgGrTrI0VglsbYwQ0JBkHBf21RHA+B9ZW9DzHsjkFYTVXeSD3xGNIfE4VqAsOs4kQDMabd+9IyThtGopWIeols282hTrgCjinHdEhv6Cj3vadZy7pL8hQeXE8gduxgc7pnSVi4H7pRLyusS3DWttZX+s9c7QqCmFrexsrrrMhpGBnEcJoVLP54uB9GCcLlnnswbVJgTlCct2tBJa8Og0mBKnH0BZSH94Tia7OMK4L7Qjw+PsBLIxYRdW0GccK/Zi7KZn0YshkxXtziDTs0YsxU5tIqtj+ClJRjccf6It82jYNm9J3iAGVriycJsqZDckXEGeKgK2Nduo0xLvTiQhISr3XhLwZgIIqeEgUpG8CXEcO7xz/1dudnJqx8ZT8O1UKkUPUiAiFX8TUcFjigGbY1Mm4f3pytpOsJcHvGNHTCPqfQrcigeD1MEwME6UVKG7TReYxzSjwAr4GyjEdcwBzDXrvLOgt3QMJV1mgiA6ZfB5BRXj0U2L9D6cm/HdeEI8l6NOPRVHtQb6aE3C+rJfLNbAx50hT26/VrN4BEo3wZGuGcqnK1gxlYgnk5fIsLbLP6cDO+eSAYgPxE18MSs5uGOyxAPZbsGDblmkJG3ZxRMmXaNcqnkiQZ6ca7XD7sDgXOkf18rcKFDkZxSjIO7xXt0GVlE3UsODGMUOPKQMVi++KEhOJqxkADCe6/Lxb6q1P/WQJ9qxLJ3uloGUiUlUsgB4dBlEbr2htT2codDprCrD0kaEo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4758.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(396003)(376002)(136003)(366004)(346002)(451199015)(36756003)(38100700002)(26005)(83380400001)(44832011)(8936002)(5660300002)(2906002)(316002)(41300700001)(66476007)(4326008)(66556008)(8676002)(66946007)(54906003)(31686004)(2616005)(186003)(6512007)(86362001)(6916009)(6506007)(53546011)(31696002)(6486002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2Z4bUprT210dWpsb3A1a0VEZHFzRGdyWUNxUUNzb0FBRGt6TEJhUXhrZmZP?=
 =?utf-8?B?UWFBY1orQnB3QndYV3M4c0dGaGgvVC9Ld3FUQ2hQTUtTRWVsT1JOeXFWUGJu?=
 =?utf-8?B?a29rY2tjSUkyNTZYc3VZbERVbzRNQ0MyTU1zaDBDM2pHTHYranQxMVBuM1NH?=
 =?utf-8?B?RHMvbExNL0w4ZS9acVhCUTV2QUw4d3RFbU5sOHcrOE5BVW5qTmRTODFrMzVh?=
 =?utf-8?B?NU9qTjRnQzJKZlZUZ0RYaXJZeEJvVFJqVHlLTnVOTEtuZ2pLV1NoRWkrTlg2?=
 =?utf-8?B?dW5XMTBTNGUrN3VFQTEwcWFpcU1WNG14bm9JQUIxVkxEeFU3RTdjU3BBWTBB?=
 =?utf-8?B?VERmdVI2Zm9NYWsxYU1sakRpVEVzb1dOcWY4TThZeTVCWk5OQXdmK09TNHUz?=
 =?utf-8?B?M1B4YXczYkpwSElWQVBSaGdGK2NOK3p4RXQxZkVLNUcwLzRQQlVpVUpCYlZM?=
 =?utf-8?B?SG84S2hCSEtKMUZmK0Nxbkp1Wk4wVEdJM0tWSWJua09DS0psN2I1UnU0ZlRK?=
 =?utf-8?B?c3U1ZjVBV3QxSkh2MngvcVIrdjRsVUdqSmx4TUtlaDNqQ1Z5bXYwUHlNQVVT?=
 =?utf-8?B?aU81REplK2ltRGtLZWJKckt5SXo0VXYzVXBCWEVuanBzYzhqTXNRelZCdkpB?=
 =?utf-8?B?dlNYbUNMeU4yRUtJWVQ5ME9nZ01xNDMzb1Vrb080YmtlVWcwYlQvQnJyUlJH?=
 =?utf-8?B?NXdEZm5weEtkbzdiNGFRSDNvMWIwMXRiWlBMWStLa1FGNmhPVWdvbk4zTUhr?=
 =?utf-8?B?ZUFGR3BIQloyei9YVVpyVEUrZUFrMnFlZ3J1RmVCRyt4V0VPNDJXODE1aHY3?=
 =?utf-8?B?R3dDT3FMYnpmZENid3BCSk9LWFkxZEZVdEZvTWhkY1ZKdWxhRlRqY05sTWI0?=
 =?utf-8?B?QjRzQUtJVzErNmE3Q21FVjhOTytvb2F6YW5GVTE2cjc5ck10ZkdmRGljZHhL?=
 =?utf-8?B?K3lmcW9XdU9qNTY1c0E5TjAxSkg3eGpGVXk4WXl2aUpVa3pjQThUN0M2Wkow?=
 =?utf-8?B?MUlpRWpvZFVXOVZpbXpESTlMdGRGdWdJNFJDeVRXMXdSbngrTS9ONDlyNUh0?=
 =?utf-8?B?SG5PMlRJLzFBYVladnBNcjljdmVkUXp5L1BvU0pla1MxcTNxdDRzK2Z4T2hr?=
 =?utf-8?B?N2JONFh2REhMQWRiNUwrNHhtemI3UjdWdHRFQURMSnFrUmR2OHJOd2ZUaTVa?=
 =?utf-8?B?UzFMTGkvUHE1WTlGU1BJQ3FPS3FNYzNYSE9OZVo3WSsvK256OGR3WDEycTJF?=
 =?utf-8?B?QmUvcTJTWlFuZTlBdXJhN0VoY0FBUWZ5UWlYVGpJSTV0TDVQOVN3UzRhTExh?=
 =?utf-8?B?V1pZVWVkdHU0UDRCbmZ5M1lVYWVZaHJlN3NDc3l4YWo4MWdFeUNPZWZRZGFQ?=
 =?utf-8?B?eENJWFYzNVZkajBHeU15UzBjeklaK0w0ZFdqU1huSnRQZ09BUDdYZ2d4Q1d2?=
 =?utf-8?B?TGdsbVJYamVPbkR2NkZuMlpvTWhINFo3Z2tUV2FuMnRKN3RkOGR1amRCRFRB?=
 =?utf-8?B?OHgvSXc5eGxFcjBzR3JuOEE5aFA0aXY4dWYzMi9xWTM3d3lZSlhucVludUhD?=
 =?utf-8?B?RHNGRUxUNCtXRnhxcFB0dWdFYkhmc0I2NWRSREk5ejNZVVFSajZFaUVBc0dm?=
 =?utf-8?B?amkvTEhZVkkyTnFuMEF3aWNqQVZLVVJuVElhQWpaeVJHT1g5bS9WVllOd0hS?=
 =?utf-8?B?NUY5LzhSb0h6enVRQ2xzaldQUC9sWjZqak1EcE43M3MvckZ1RVpuR2FFMEM4?=
 =?utf-8?B?alRXQk82TnZSZEFaeGZ3NllSSFlMVDZXdkVPZ2JwRHJIaVVYM3F3TkhGZ0Vr?=
 =?utf-8?B?U3RvODZqbG5DQ0wwMytYeTRLdGIyZnVVQWsxSWRPZGJVeGIyTnZPcXBzZnZq?=
 =?utf-8?B?L29RSExJSnZadmpRc2FlbFRkWHliL0EzbEk4VDR1anEwTnJiSnZtckx4UDFw?=
 =?utf-8?B?d3MyWU9Na2pjWTVyL2huVDNjdjhpTVlwNSsvV2VrdDkwWDJCWndpVXFPcmlj?=
 =?utf-8?B?UmtyQ3pTeWlsak9YRnBzZkdmVk9KMUdQcnZhSUNsUXNHMFNuZjNTNEc5dllx?=
 =?utf-8?B?bDdsSnFtWEZJTThzZkUycHVhVG0rMU1BVDAzSTdINmhFUXlhMDVmTHFydlVx?=
 =?utf-8?B?dnp5MlhWL3ZFcGF6ZTF6WXdEN25PVmFMTnQyNEpKZ01yQTdydWtjZ1FqZnhp?=
 =?utf-8?B?Zmc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e21be0d2-e5d8-420d-28e1-08dab335618c
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4758.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 07:25:07.9279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sq83kUJLGnieNLRZ7RCd6RW4E5SjNS9ZLDA/RjHvHpuYXMb1g0MrrCNGP7bspN9ZAo59GS48+3aFmKZmCXPfq1JGWvb4M47jZIHXaqv44FqCUYuk+KFHJ0yM+Y/nDhTe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9562
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.10.22 9:50, Nadav Amit wrote:
> On Oct 19, 2022, at 12:56 PM, Alexander Atanasov <alexander.atanasov@virtuozzo.com> wrote:
> 
>> Update the inflated memory in the mm core on change.
>>
>> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
>> ---
>> drivers/misc/vmw_balloon.c | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
>> index 91d4d2a285c5..3bfd845898f5 100644
>> --- a/drivers/misc/vmw_balloon.c
>> +++ b/drivers/misc/vmw_balloon.c
>> @@ -1507,6 +1507,7 @@ static void vmballoon_work(struct work_struct *work)
>> 	queue_delayed_work(system_freezable_wq,
>> 			   dwork, round_jiffies_relative(HZ));
>>
>> +	balloon_set_inflated_free(atomic64_read(&b->size) << 2);
>> }
> 
> I don’t like it in general (I think that something like that should go into
> some common infra).

My goal is to create that infra, sure there is a place for improvement.
I think of it as a commit point so plugging it into something existing 
does not fit or at least i don't see how.

> But more concretely there are at least 2 problems here. First, queueing the
> work should come last. Second, there are other places that change the
> balloon size (e.g., vmballoon_reset()), which are not handled by this patch.
> 
> If you added calls to balloon_set_inflated_free() from these places, you can
> get races while calling balloon_set_inflated_free() and the last value that
> would be latched would be the wrong one. I don’t see anything in the logic
> or comments that clarify how something like that should be resolved.
>


Ok,I will move it before the enqueue call.
But are you sure about this the reset?
vmballoon_reset(...) is called only from vmballoon_work(...) which does 
the update ? what i am missing?


-- 
Regards,
Alexander Atanasov

