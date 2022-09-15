Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479045B95F6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiIOIKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiIOIJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:09:51 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDDA23159
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:09:49 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EM68U9002328;
        Thu, 15 Sep 2022 01:09:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=oiMB8bAtswtGDlBHieQIypDmP2Z9B48PpjlTErAJQ9Q=;
 b=fDepf1RMLhdHoanxt4gxJvs+mSXp3bxCimQ2tPql1PdFmgEQ7pyTovJ+6H4SIGw0ekZU
 yjWSuFOwkrEwFkspQsFZxdKiyp+RwhI1YyfItQVmMfpeqdQ3asJ9qKI9faWse1dRXjk+
 GrdddQenL2H9o11sDcDPw4sAGwTHVpyJKy8= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jjy0pbr9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 01:09:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ez8nXFEhfC6rNnjNqTfrYsDDplKGPxc5tIjC9Z6aVK80Wf949VFQ9nJcbO+nT6ZlgUPbLf8lqg3YmMr3dgo3fwWYgb2B+4z86xCZCdoWWT4YxyoGsxB4S7yIjT4qgJW8cAzvh0/QLgnpkcNz1IpiSV/izPezo4g1w4WvZ2vET6StZf4qqg3xuPRfuYcWqeDdNFzuGzJfc3i1nccaXXgp2a6tkoKtiZx8vylf88L6Hrmr/BsUQHZDZ/JtTUvNLWIV/VR/IOzTesIVmBIEydGcG8hH3gU/IPyjnIMUQLv0wPfyXRnACmMQpoh7OiRHlJlnB2X41349HNRufrEnm7J8zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiMB8bAtswtGDlBHieQIypDmP2Z9B48PpjlTErAJQ9Q=;
 b=dauRkLVIa4ElOyH/gfBJADeg+sq6tNac3HIub5pSjjcUOYUlfRQElz1+wczTAb6dBEL7xURXXr4j0lzkkY+Z1iueRGQzJtVdSxVJdrnAZWhqyAmHRdnw0TrU2zwX9fZS2EUVQLvFqtMhSeeNDiPYt9Iqg/RaSyZe7+wef+edYF5dxzEHSPJJlTRT+96mtbEXMCqFeI+x84ZV6LVgztJ0fLoR194lMbZ2OF0mp9NGdnVGipjP+cBPGvM60wRPzHZw+4fvFrW9fWkAti4FQ1d/o1+Wdbbq86NcrgzqfILXv0HRU3wQ8SB0teH9Vg8Aboso/c7MrIp1dhAS/AJt1+BVFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by MN2PR15MB2687.namprd15.prod.outlook.com (2603:10b6:208:129::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 08:09:43 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::700a:e1d7:b866:f3bc]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::700a:e1d7:b866:f3bc%4]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 08:09:43 +0000
Message-ID: <9755284e-6b57-8340-dbf5-1bb50f036da3@fb.com>
Date:   Thu, 15 Sep 2022 09:09:26 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [Tab-elections] Results from the 2022 LF TAB election
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        ksummit@lists.linux.dev
Cc:     tech-board@lists.linuxfoundation.org,
        tab-elections@lists.linuxfoundation.org
References: <87h71984jy.fsf@meer.lwn.net>
From:   Chris Mason <clm@fb.com>
In-Reply-To: <87h71984jy.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0016.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::21) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR15MB4287:EE_|MN2PR15MB2687:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d14d70c-7599-4dbe-7d2a-08da96f1a515
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n4uKf/1DE7IeNB5YRXPoiyxVF92kE9GPIuSniQzowLexYkJdScX9JqB1wmo2FlHyolsPxUZLXAKW26d91Y+olJUBMP54+fZBa6ASbMuLQmGr72NQcgot41hiZ7ouExd3VKTVxIBz/03SGlBSgkfOEy8m0bwh060D7oS9OLtvXttDFwO9dAblRKCzmpzYhKpjUCzmK+Tv22NjB0WdHtshQwwx6WQUV9pin48nKOHboidhMV6HQwyQKhz6kYHh12eRDPc24aukekxY6+Ao81iYJYwxmNm0HVA9fTo15L+OuUxxrcBkIzxeC8pB9tE/3c0e/EwH5Dr2rHymsiE04AEQyAjWzZo9h6KqTEN4Tg7JWBck5qffYtLXumneKee5zj2Li48bK1gZ/7VseFVKdkawsrOpcnmrdI5f8rcSJh4ZJ+XeKSDbtRng1sIPcOFiNza+kujOV059VKOJXa7ubvl85ZjGcfE7wWoWuQgftgEAKKgrWR1JT80HltMLk0CZcCbf1g8lppGMF8tJx7k2YiRu+lU3ZewcOJH4sp9OYD5nb+tiDcLeFJTKGtbI7U+yBFqpHta3BM4fjVMY1d18+yQltq1XqlkxhujIywYQWJfTtk+RD6hABWZhnPPJiZXNetD91ZRMYdQGsDYFFRi/ITTCpRi50oGn/DajVNjRg8TmkhDMBsJq43GU9+nDDr9ihTpLzlhezaURfr+5KTqIt+etV5j/4UyATNTlLjcbZahw/sJeuW4VtrbOSPJl95XNGNaGxOaRrFy251lmvbSjeCKXZX3ZNd20+cteGJhgDb+kxb8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199015)(6506007)(186003)(83380400001)(8936002)(5660300002)(66556008)(66946007)(66476007)(316002)(53546011)(8676002)(26005)(6512007)(4326008)(86362001)(31696002)(66899012)(6666004)(2616005)(6486002)(41300700001)(478600001)(38100700002)(31686004)(36756003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0VTWkI5ZTJQQ250b1V6QUdJbzVoN3VLUk1DbFhkWHZSSDYvRGNrM29nOTFK?=
 =?utf-8?B?RGU0YXpnRWEvU2tsWkE5WFJ4MmIxN0phb254WWF1TlFKTU4vRXFVbDVxYlZh?=
 =?utf-8?B?cmpLTklHVVVEWWhjaFZRSnJuK3kyc1hWQ3ZlNXF5QVloQW45cExmSkN4UEo2?=
 =?utf-8?B?enpTNk80U3Nac05Vd2g5L2ZrRElycmZ5SU9LY1kvZHF2c1FkNlhGWC8vYlF0?=
 =?utf-8?B?V09zaFozaU45UUsyeDVQVGlMaDdjRFRYUllraDhtTUZXNGZwbzBOQjhkUHg5?=
 =?utf-8?B?K09CR0JHSkNQNnJMOHY4QmgzTmNYNUZsUGRveHFmd1VzZlI3T3lvSmJweFhS?=
 =?utf-8?B?N3JlK3BHOUNVdnVSd1Roc0NzN1FjNXlORkt5UnlUdGI5S1dZRWUvbU9IdnU1?=
 =?utf-8?B?Y0ZEaUltOTlWNDdhZjZNdHQwbllPcGZlVjFTejYxK2p4SjlPbjRnSTEzV1Yw?=
 =?utf-8?B?aVhjS2tnZlVQNGJ0eHFYK2V0OFBERGhCa1hSb0R5eExUcEYwWkhUclZ4emVZ?=
 =?utf-8?B?ejcva1kvekp5ZGNMSVRjSnhOZTQ2WGRyanoyVlgrMnU4R3RNRnhqSnZZeG84?=
 =?utf-8?B?VjU0RkkvNTFnYUFjZGhycHFvUVhUWGFEU1BJdjlJdm8vTFNxOE9SQWtLS0lq?=
 =?utf-8?B?eWRvempoOWVJeXJnUzlCd1JLc1pFQTNCU3JVYnk1NDUvRERIQzZUL2JnVkgy?=
 =?utf-8?B?Umh2ZHpoY3ZDaFh2eXBUNGVGSzFhNWxxS2o3Y1lpbDRuZ0R3cDNUc2dZTk5h?=
 =?utf-8?B?QXUxZEx0SFh0K0pjNEFSR3hxVWY2azdQZCtuK0FxelZVcFA3Y2VmV0JLNVc0?=
 =?utf-8?B?S2ZDMWl2ODFWeEdiOUtrdmwzbC9jZXIwN2xtcjlhNnBCQWJaQTVMcXRkdTJ5?=
 =?utf-8?B?WjE1c0xHN2dNQURXS1VELysvVzgwMVgwM3oyM054UllyanoyQURoWlV4TEFk?=
 =?utf-8?B?MWtwQkExeHpJU2lJWndEM2hQZzlJK1ZXYjQrNVhUYjI5ODhEaWhNd2NFK2Z5?=
 =?utf-8?B?TlNYRFAyY3d2WnJvSm1ia1dSd3JHOU1wbnlld202UW41aDU4RXcraFUwWXBK?=
 =?utf-8?B?MUdxcTQ5UkMydFFZOUVMS2JlalJFOVNjYllmbDhGM2s0RTNsbEtqb0FrVUl1?=
 =?utf-8?B?Q1Q2Zm5XWmJQOTJWek0xYVg1QUMyZE45b21kU3hwOHV2K3dFQ2NwdlYrSzM1?=
 =?utf-8?B?Q1R5QkxJMW52TGVRanNzdjA1eHpZb1RBTDdrK01JNWwyVWZORGxOWE1YcEZm?=
 =?utf-8?B?NnBhMlJ1dmtzQyttaHJ2TFhiNzZtaDBRejJGbWUzRHRGVXBiY2tPWFNxTVU5?=
 =?utf-8?B?K0R1WWJKcUF0K0pGaDJLVUx4bEppOXFLdGhjMjdiUkU1UVl5YzdiZGUvbnZ1?=
 =?utf-8?B?YkNDbTE5dkNHTEVJR1ZKbndaMlc3V3N6MG5JNktiamhGRVhNSlhTbUVNNFNE?=
 =?utf-8?B?RU9VazNBb1FNb1JtL0cyMVJaVGFiZ1d0aGNmMEw4OHY3eis0K2picVpRWE9Z?=
 =?utf-8?B?ZzVmMEhEUTFIczg3VEhEaTM1REI2VFh2ck1hanFHUndnM1Vwd3BFL010aHFy?=
 =?utf-8?B?dkx2Yjcwd1NKdlQvTU1mV3F6ZHE5bVNBNmw5aTdmOG4zYmJHcVJZeDJ2ZWsx?=
 =?utf-8?B?N05NOG04RUFQL3ZsbFVUZVFZc3N3djRtTk9YNGJpTHJPbXpVOWJMcEpLZlph?=
 =?utf-8?B?TTM4TkZSMjF5bmhsZGZ5OU5hcnhlemV5NVlVaFZIaTBqWHpjQjRTaXVHVVZn?=
 =?utf-8?B?V0l2WWtEcXRiZEp2TDlmQkVKU3RBSnI0cC9BbkltZVRkdzFSS0djblF0QStj?=
 =?utf-8?B?UXVKWlUrdnJiVkF5MU8vV01SRDRCSW5EbXVhUjFaZ25HaVlxNnBWbmtoc3hx?=
 =?utf-8?B?QTJKWm1lemNKMFBQUEYyZ081bEV1N3BtOEgzS3ViQk83T1N6WTZSV3orckxB?=
 =?utf-8?B?dVJLY0t1bmtuczUrTHhtYnNNaEIxbEhzWk1qMmRJZjFHeWlYVmZtdmx6aVdU?=
 =?utf-8?B?T0RyaWs0N3pPN3NrNS80NnBaRytXRFdzcmo2d01zREw4UWoyOHVLa1RsUVZJ?=
 =?utf-8?B?Q2dmc2s2NkV6QXc4UXJJVkhEQkk2eU9mdmRZMkFzZDEzTUtyaE5sZVBhV2Z2?=
 =?utf-8?Q?ZTBI=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d14d70c-7599-4dbe-7d2a-08da96f1a515
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 08:09:42.8998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SAvg+q7fpKqJ9m5gud5YlIHsVU7sLfrC5XCXq4nmKpIslMA+fFsEhQ79328tM3x8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2687
X-Proofpoint-ORIG-GUID: Odek40F6TPaSlQZakBxrH1azsQPAAhet
X-Proofpoint-GUID: Odek40F6TPaSlQZakBxrH1azsQPAAhet
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_04,2022-09-14_04,2022-06-22_01
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/22 8:44 AM, Jonathan Corbet wrote:
> There were 960 eligible voters for the 2022 Linux Foundation Technical
> Advisory Board election, of whom 267 cast ballots.  The results were:
> 
> 1. Kees Cook
> 2. Christian Brauner
> 3. Jakub Kicinski
> 4. Dan Williams
> 5. Dave Hansen
> ---
> 6. Chris Mason
> 7. KP Singh
> 
> The top five candidates will serve two-year terms on the TAB.  Thanks to
> all who participated in this years election; please reach out to
> tab-elections@lists.linuxfoundation.org if you have any questions.

Thanks for running the elections this year, and also thanks to Laura 
Abbott for working through our transition to the fully online elections.

Congratulations to all the winners, I think the online process worked 
really well, and I don't miss carrying around the ballot scanner in my 
luggage at all.

> 
> jon
> 
> P.S. On a personal note: a special "thank you" to Chris Mason, who has
>       led the TAB well for many years.

Oh, it's my turn to thank this year's TAB for taking over the reins, and 
also everyone that has put up with me over the years.  I've learned a 
great deal from my time on the TAB, and I'm looking forward seeing you 
all on the lists and at future conferences.

-chris


