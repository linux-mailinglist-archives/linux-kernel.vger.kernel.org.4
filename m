Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F3B73AE77
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 04:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjFWCDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 22:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjFWCDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 22:03:46 -0400
Received: from mx0b-00010702.pphosted.com (mx0b-00010702.pphosted.com [148.163.158.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83AA1BD6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 19:03:44 -0700 (PDT)
Received: from pps.filterd (m0239463.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35ME8TfH019219;
        Thu, 22 Jun 2023 21:03:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS11062020;
 bh=SbBxsq6inGVuB6NOWfXIayoJJNgJ/O/2J2EvxSxNIQ4=;
 b=2r8oxcGk63J5JCQ/7PQSoFxttPP2mlBQRdDOPV21A+ZAxFeU2URQ+uJ9ilImCgBJhbQK
 M+gcYwRMJ6np3II1KFrt/QvbREhsFKQ6ZZEm9ADD6RsbA2ubKD+H0A/pA7A/PzAbO+yc
 0nf1vgNQNQVVIPeLfTD6NnCo0xC1kczLK3sUI5GYSz1YHWMWU+jnwFNGSOHjW28Og8px
 r51CNS7YCtcx7/RtQL7vE/n/FO9V06xrBF5LVbspWKYAxaQYRAbjt8HT0Q1H1m3bc3zu
 GHkFAv/7ZNV7S37T8CPVm7ga4trCVctcoAEuVPiiGnB/kA1Fynw5drhP8cU0Z8GYKsrR 2Q== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0b-00010702.pphosted.com (PPS) with ESMTPS id 3r987bhcmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 21:03:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZS/4uApuiqzzHKddt+vF1VZM92gNlHTb5vjQqKIAES0iWtrNvvcGjBnXIWI10Qwnj8KXDr5GCW2j9IFpnaJ7sYX/tZZyDiMS8lTZmyNQn67zPnwFGVTlIILliFDXJP12LckQecdNYmS/z3sN61daOusCUgWp2St9axea69ryGqCQep5d1IDjowK0ORUOLaGQHDMlFmRNAlWJwKApbD29+doUUrYTBtYR1/TYGlHo7RfQ03P8asgIeJth+OfPOB5pBTVXyduBcyZkQYo4u+z1xef76k7f71dNwZ/gN06biZErNqjXtFeG5+t+CYlCxuJLVdNB5wzxkH1nsM3eKfB3eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SbBxsq6inGVuB6NOWfXIayoJJNgJ/O/2J2EvxSxNIQ4=;
 b=UPptD1cAbl487S9WIVMT+Cd14/6dYf5hOJ62BujhNNAMvaUKuSoWvXj/8Medje1uGVyn19dZFNQe/L+6V7s3wMVhZtRP42hf0rfovJA3BDo8D2uOxhf2W4LTd/3WsALhmZtvzT2jhZOrqOz4mEdYNvHm1JhC0EVCMAZfbTvJMKPfMolijGggek+Lj6mwVYwxQYgFFbORTqrvK5Sw95IWG/fDQ5vKr76A4MBmuPZOs0219H74sy2d7b/OS2+HcMejiD8vhgYvzEEqbKfpcLaQow2mYNxN1Hxjl1vPsMboHxZaaGG3IovHVZtpD3AteqDzZ4gfP8O5Fx2AaYvX4MKvuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbBxsq6inGVuB6NOWfXIayoJJNgJ/O/2J2EvxSxNIQ4=;
 b=WFSCPLVk/tesFd5YXDfJmJGmwmHcgTaKrWfApjq1ThsnxgPXAeLNve3KPi9M7EVqM02imSycV/VL9jcYrcMuON7m6CAf+P5JuOysgkoNBXMMzdogizcCvZu6vHTDgjAl2AQPeHcSVVlkGWgDauoKPdFj97uY5IfbGSSllgOSQRg=
Received: from BYAPR04MB4870.namprd04.prod.outlook.com (2603:10b6:a03:4a::15)
 by SJ0PR04MB7328.namprd04.prod.outlook.com (2603:10b6:a03:294::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 02:03:38 +0000
Received: from BYAPR04MB4870.namprd04.prod.outlook.com
 ([fe80::e520:543b:8288:b1f5]) by BYAPR04MB4870.namprd04.prod.outlook.com
 ([fe80::e520:543b:8288:b1f5%5]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 02:03:38 +0000
Message-ID: <fa298357-0b3c-5534-0619-1bd8911846f7@ni.com>
Date:   Thu, 22 Jun 2023 21:03:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] pps: Increase PPS_MAX_SOURCES value.
Content-Language: en-US
To:     Rodolfo Giometti <giometti@enneenne.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brenda Streiff <brenda.streiff@ni.com>
References: <20230605203147.694716-1-charlie.johnston@ni.com>
 <fe435e68-8e05-9078-0fe6-63ef7cce2fc9@enneenne.com>
 <b794bccc-0233-4d78-df6f-bf7c688a7d7d@ni.com>
 <70ce864c-ca13-4fc4-fcb5-9b7f91579a90@enneenne.com>
 <38f38f66-0fd5-4e6c-4839-8272cef77046@ni.com>
 <5aff32cf-74ea-b632-9d4d-a01ca0d31821@enneenne.com>
 <41affdf0-edba-6202-4e76-fd969da6497b@ni.com>
 <c770492b-dfee-c38e-f15a-aad382caec25@enneenne.com>
From:   Charlie Johnston <charlie.johnston@ni.com>
In-Reply-To: <c770492b-dfee-c38e-f15a-aad382caec25@enneenne.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR17CA0013.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::26) To BYAPR04MB4870.namprd04.prod.outlook.com
 (2603:10b6:a03:4a::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR04MB4870:EE_|SJ0PR04MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: ea42ca2c-9762-42fe-0356-08db738e0e8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mCVHUvRAgWcB5hu2qA3gUpcdrPtZRLr9/69617FpV+/ZRs7sH+olznaVI8Kv4dbBr+WO7rPUuKOoUZwYcZ1PM5lRpte3iopCIo4GdV7WcZPJixB56M9trwQ/FCz0pJur03HKBoEr2Y0uab3mVF2iA11l/2qEZA7Uv0+FdzyLyjwqeMsG7C4pVknQnLbiiZdQse3eWYSNfLyTnXzHABJzN3wP/2fieG1qCN9z913b4Jd7plx7NsuAliEa5+nCVGAcLgVud1EKFHchYFZzT5JUp/ffpZV05ZtARk1y+Q1YqkTmY6d6GDNRTcDiM0VaWncJ+DZzYEvGzTJS0mz4icdDebPKHpr/5UYntMCdO1OatNFc4jZCQsXus47dEMTY6QvH2bFo9I5DXdYKdVWFGXI1c0/GsyD5ovbtY6J2ybbWRtEIiu9YfLzM+n6wEdrq8TBzoNrdE4qqILxtkl9FixFQcy+jTsVP9YkUgaS88UME0MBkCo2K/hiou8fOKDPIA7AnCuiXtChr9kcu3Um9hejSczGD0603YNZZ803bkkveB6w2uhpPXkclHhxIs58VVC5EfPgLEFVa0Qa7m6ltTWZPMTLW4Bqu6MAX9i4YDOYnPjpNnGcPpIxQ/CYnRHD9HpXy0PWZv2uVWbfnyj61gBYf3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4870.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(451199021)(31686004)(44832011)(5660300002)(4744005)(2906002)(53546011)(6506007)(26005)(6512007)(8676002)(8936002)(186003)(41300700001)(83380400001)(2616005)(478600001)(38100700002)(86362001)(66476007)(6916009)(316002)(66556008)(4326008)(36756003)(54906003)(66946007)(31696002)(6486002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWVKNFB2VzlnUGYyMDMwV0hZWVZ2RktjRFZIM1ZTcVl3TXBFSy9KRWdnanZ3?=
 =?utf-8?B?eXVaRzhrUFFielVIUTl6cWtZNXRzZFN4a3h1dUEybXpaMjRiaWNoRCt5VDNU?=
 =?utf-8?B?Z1JiVFoxMDU3d0Zuais3R1BPYzlyd0FBYVp2VlJHSjB0OVNSQzd5Y0tyb1Bj?=
 =?utf-8?B?c0F2SlB0V2FBR0VNYTJXUFEzN203SnB1RXRzejdBWEQ1YXNFci9GSkl1NDZO?=
 =?utf-8?B?dnhoMWo5TTRiUjBWNjA2RENxR0lnVDQ5b2dQUU1nTXJmdEwwYnpxMEMzYndP?=
 =?utf-8?B?RG1DMzUybVQzSTMyamhPbzdnL0w1ZEVFdXZiUXZJQzIyaUo4eFZsS2pDWkY5?=
 =?utf-8?B?SUd2a09aWDJjbkx4NnlvQzhuYS9aN2pQYTBrN2lsVmlUbndjRXpMWVVWWFNn?=
 =?utf-8?B?Z1N2NkZtNTE3cXlRRU9RODBRQUlhL2ZXbDF6ckFuUjhCN2ZKbUdPa0M2Qk9Z?=
 =?utf-8?B?U1BML0F1clEyRVRjdGh5YUhCc0laVW5xOGVINXU3SGVPL0xwYUQrVERMK0tv?=
 =?utf-8?B?YlROQlljcVZ1OEp4YVpuWU9JQVhsL0lmNXB6VGZwMWNMb1FiYXZmSXY4anJD?=
 =?utf-8?B?NENqbHZERHJzRGg5ak1NbHNjTG1TUnNXWnRkSzhJdTVJTER1dXAvU0tRNFc4?=
 =?utf-8?B?b1VDTGR5UFBFWFdKMW5CbndlWkFUNlBzblg2MGUwcXcrczM3aVNTQVRaTE4r?=
 =?utf-8?B?WDhBSC9wTTNGZWFpRlFRbzc0UmovRkNjWDhYRU5FbTl2WWpkR1NUMXJVczU4?=
 =?utf-8?B?YVBsM1VrdExoQW9OTjg4a2RqdmNxYTZVczl5RTdsRzgyZWtkY0cvbW56SFMx?=
 =?utf-8?B?VmxGbnhrTk5YSHJlNFg3LzZ4WUp1VkxHcjBhVXBIUVdmaEQ2M3lITlZPSVZr?=
 =?utf-8?B?Q2x2NW9wc3RMNjgreWNsSTAwVVM3Z3RDb2gvOU5pMXBXRG1jcFhqZ2hxWFNp?=
 =?utf-8?B?RGtCNU41c2cwMXVZdnZENlA4eGJYV2pHd3hQcXozM2djRnFEVVlhVlo0ZWIw?=
 =?utf-8?B?YUJJR25OZnFsLzF3bDgzUmhpMmR2T05YZkZmKysvZDJPVWlCQlZyZlJIQXBT?=
 =?utf-8?B?eTlpOVpzM1ZodDgwWG03MkRXd0FETHVodVNKZVR3eW14YUthNEZQb2tYakU4?=
 =?utf-8?B?cTByKzJGdnY4VXdNODZ0YmwwUXRxek1NYS9rT3RJRFFmRTZRVTEwYkVkd3Z4?=
 =?utf-8?B?SGNQbFdsKzNLc0dJQmJrMkprMExSL0pHT3kxQlVWcjFhSDBacHRBcnQrem9t?=
 =?utf-8?B?UGZ5MlJack5iYjdWQjFMUkN2R2dlMVNEekFTbEg4SHlPcTFqSSsrWEU4UGh2?=
 =?utf-8?B?OW1PSXQ1RFE3M0tyMThGSzB5L2RtTWtoR2F1aUY5RW1UbTFQMGl4V01Vb2ZV?=
 =?utf-8?B?VEJwWGpoT3dvVjJMU0ZaS2dtZDB2QTYrUXZTRlhSeEdnQUtldDkzV1R4K0ZQ?=
 =?utf-8?B?M0tieEtVelkyMjJtZVd2WGtncnNQOXNiK0tiaUoyVjFwRURYMlV5ZDliK1lJ?=
 =?utf-8?B?VTh6eUt2UHB6bStBNkpvZDFmUFdnSGlKRkx5alZHaHVhcmRtZ1VkVTFTdlIx?=
 =?utf-8?B?cjZIcWk2Tk9nSlQrS2wxUWRyRUlac01WTnJYMXh5YnBrNW83aVl0MEIxQ3pn?=
 =?utf-8?B?Q3IxeW5wZVZqM2JyUWlOQWNUZUFEd1lYdk9DOUwzaE4wc2JKSitNMUkzV29z?=
 =?utf-8?B?KzZ5Wm9RQ1JuZTQ0OTY2WGJOVnh4OFB2TjdFN0hCRC9TKy9oSWNya0pMNTFi?=
 =?utf-8?B?MHluekNCbUtwSHB6WE5WQUVWbkFIVGNBVnBQdjBNMWo2ZjN3Y0tVbTdGWENt?=
 =?utf-8?B?YnBJeU9CaGx2Q3I4cUxGbGthdDRQa0hCTERHeXlQYUNSd29uUFlrNXNnR2tB?=
 =?utf-8?B?ektBa3Y3VSthR3Vnd2x0OXpiTFdKa1lJVG1INnp2SlBGSWRaRVRkL2NjZ0lB?=
 =?utf-8?B?aG5nQ0t5QWdnWE5DbXRQdGdrVDZwQmo2bXN2YW9XanA4bmxsK1BBaCtJNGp1?=
 =?utf-8?B?UTUxQXIzTkJxNHJFc0pzdUVwZ3pMTHF5Q0dBSTQ3MUpwaW0vWkJTUUcrSHdQ?=
 =?utf-8?B?byt4Q001WWNXc0x5UkJiT2JGczdwWHFrQUdmaWhaYnNLR1g5RlFqYWI4TUZi?=
 =?utf-8?B?eCs1Nmg1NTVnTHh3dVoyTjhMSmxWNlNkL3lnVWZFaDM4YUgrOU9VQ1dQK0tl?=
 =?utf-8?B?Z0E9PQ==?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea42ca2c-9762-42fe-0356-08db738e0e8a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4870.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 02:03:38.0868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgpdXdVmGjhOOAIS2ov+I1H9S/75H2r/9D4AbKJTS6YQPtJXECPI4WKtzu0HZgTsfgXb6+fpb288dkkplcRs8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7328
X-Proofpoint-GUID: D6EZSE5LNbfU6FvfoxdZ-1mRVPW-vi6_
X-Proofpoint-ORIG-GUID: D6EZSE5LNbfU6FvfoxdZ-1mRVPW-vi6_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_18,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30
 priorityscore=1501 malwarescore=0 clxscore=1011 lowpriorityscore=0
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 classifier=spam adjust=30
 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306230015
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/23 10:31, Rodolfo Giometti wrote:
> On 20/06/23 22:42, Charlie Johnston wrote:
>> I've resubmitted the patch with just PPS_MAX_SOURCES = MINORMASK. The system which hits the limit and causes the problem is currently available for testing.
>>
>> Is there anything you'd like me to try running? Or just confirm the limit change works?
> 
> Sorry for the delay (i was very busy in these days)! Please, test the attached 
> two patches.
> 
> Ciao,
> 
> Rodolfo
> 

Had some time to test today. Everything I tried appeared to work and the message log indicated sources were available for each port.

[    1.853052] pps_core: LinuxPPS API ver. 1 registered
[    2.749945] pps pps0: new PPS source ptp0
[    2.790179] pps pps1: new PPS source ptp1
[    2.818900] pps pps2: new PPS source ptp3
...
[    6.326282] pps pps26: new PPS source ptp27
[    6.354941] pps pps27: new PPS source ptp28
[    6.383575] pps pps28: new PPS source ptp29

Thanks for the quick turnaround on the patches!
Charlie
