Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC5D604F4A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 20:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiJSSDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 14:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiJSSDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:03:40 -0400
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2090.outbound.protection.outlook.com [40.107.103.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83285110B14;
        Wed, 19 Oct 2022 11:03:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbyMtcrD4r0UJuh7kyV1hRU64DysvgHAYmmk/4Btu/wpinSu6GKIwpzIs9yI+nx8gplAqVXv2lpRjYB8onquCzpkfMGbHbuXiHZwPlh9sZd+lSTPzyF2NOpv0p5kCxZ4f9+WhiLmdEH+hNEvEVz4YVdTpFCjXnUZspVrubyyhkVRmHOOcqfCATQ2BBarJSWoV8u279c3OqljKKt3Xlf45CejYM6X9N6uUxJtVVvVo8rmtifeKqu1Hc+kK+Of/qlyrRFGgsYDHhPd3hg+5dPtM2fsbFcV9gVS8Ktf7/dFUcDU6iKgPM1Lv9r9chF/NKP6ORno9vE3Ycvr1R90dvmb7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqGHzmh1lkxIP0aakCNcyNihN7z4t92kZwLa0Kk7+dg=;
 b=j3H0/rJR5ZO3wJ3WPE5W1QM7hqHENXRVh9RKE6s+wW8L7B+WYQdyhjNuzHSncY89kqZLQvlWd5iZs0sAO0mjzWNXdu4knlwpZO9RfodVE+NCpJ2tdfG3YDtCQv2aCZtFPPlDGqPxCfbs8080ViuG2ZU/eLq8jCWgtA7EKX5VdxZweofHHS3bAvxDqcs+uJwX5+wWIukUcLFeo5NXp6q8G7ZMrUiFFDFLZxjNCVxGYXTRFDuDGcWE+Is52ZJzn+S88+plWDUJ5UTKA6tLC7lGyc4nZngoXeaE32avAoRJrb3NuJ+Bnd/CpjIo6Lr58j8K2ecHTNQHA+WkfJW8XXh7NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqGHzmh1lkxIP0aakCNcyNihN7z4t92kZwLa0Kk7+dg=;
 b=hJF5h1I2IteMl56moUJG+U2/+pPZw1+Z/mx1x2BV1mpOOIfc54vPNgrEJ6pPzwbnbF4bApHiZn7Qcbm0tiBQoq7l0rK83LzN/+/sAyKZlOeZh6ChLxLA+CttDn8uEgio9Kst174ZnQM8Kke8rAWybkkc9Ktx+//0urDXiV2julJc7TOZApgc6eKhZ3W3fCBi2p342tX4o2jDQP70KxVxX4Ub6WBmlCrHTWsXBgV7ZXrd7aJMfDmFXlr1s9W5dVQ4czRPr/ogi7p0V0p1CiZ1ClREvKYwiBIHUB93blMOxUkNxjL9bWAVacrq2e6xQYyatjk3w/p16yoUla/VrqbRXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBAPR08MB5830.eurprd08.prod.outlook.com (2603:10a6:10:1a7::12)
 by DBAPR08MB5750.eurprd08.prod.outlook.com (2603:10a6:10:1a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 18:03:33 +0000
Received: from DBAPR08MB5830.eurprd08.prod.outlook.com
 ([fe80::1552:6bd0:fde3:ed95]) by DBAPR08MB5830.eurprd08.prod.outlook.com
 ([fe80::1552:6bd0:fde3:ed95%5]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 18:03:33 +0000
Message-ID: <106f384f-d9e2-905d-5ac5-fe4ffd962122@virtuozzo.com>
Date:   Wed, 19 Oct 2022 20:00:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 0/1] aacraid: Host adapter Adaptec 6405 constantly
 resets under high io load
Content-Language: en-US
To:     James Hilliard <james.hilliard1@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     =?UTF-8?Q?Christian_Gro=c3=9fegger?= <christian@grossegger.com>,
        linux-scsi@vger.kernel.org,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        Sagar Biradar <sagar.biradar@microchip.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Don Brace <don.brace@microchip.com>
References: <yq15zo86nvk.fsf@oracle.com>
 <20190819163546.915-1-khorenko@virtuozzo.com>
 <CADvTj4rVS-wJy1B=dgEO1AOADNYgL3XkZ01Aq=RTfPGEZC+VMA@mail.gmail.com>
 <ffdb2223-eed3-75b4-a003-4e4c96b49947@grossegger.com>
 <yq135kacnny.fsf@ca-mkp.ca.oracle.com>
 <CADvTj4qfPhEKy2V0crGs+Hc_fq=P5OKWFohG9QbTHK3i+GWc=Q@mail.gmail.com>
From:   Konstantin Khorenko <khorenko@virtuozzo.com>
In-Reply-To: <CADvTj4qfPhEKy2V0crGs+Hc_fq=P5OKWFohG9QbTHK3i+GWc=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0601CA0002.eurprd06.prod.outlook.com
 (2603:10a6:800:1e::12) To DBAPR08MB5830.eurprd08.prod.outlook.com
 (2603:10a6:10:1a7::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAPR08MB5830:EE_|DBAPR08MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b8ae07-67bb-4eb7-bcdc-08dab1fc3c3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hVlzFXCl7/9H7plGHkMPdJoev8OrlGUoqIq3WTo1z7otFoO3xUsTyUCp5nmUg40vvu/2V0jpUH4LHLgtJlgiN4vh8t1D/10h0YvG1g9F7Q9VXEX2WSIpaHDjQB+Tyvu3I2HnG1arYgfVUFLnE/FpLqCOWo4DnG45fRCH7CIK2aaCoDovuttebIYhfrcif6b7rKMd/nm80usS3VdH0pe/WXRI0+uMHORDa2j+1KdZKp8tlhGm1GliXJ3Jqhg4FZvP/jCJPsNL5Wl+8iXOltb0S9CvyeCs5F97g+t+gM7I67652Kao9txOSkit2Qy3ecfMlbdz50MaoZn1bu57ET7NaehoeN1CPT2J1yeTVoDI2hkBRYg6cbXVuGYmv+HsklsGH7fch+1bJL0ZBzubgu097jxnS0PLImsGME5lpFB/iY6fkQHxpyT/fz/xFw3I+zgPPIdEMgqKNj3UKKDmJMVr8EMIeGykgdAo/sCsicKHcpo3/Vt5S5t2/r+y1zIOeVDHe+Clz2TqsV1OI+BhVXj7oezak9S8qrJHDGZ7MJT3yRTnQ4bN/1RpGFMBv9EM+6rLx27s9/MA7gDY0FvDbENE8/Y2UDEIrqJsGSn/3iSOKPo2alUbOrOjtbWkqytpeFdshw9GcIV7xr1SDjB3jAnlPtbEycJY6QuiNQ+BxbN9Egvy227Phamptsr6onoQ1KRlweDvgjtezbyFtEWlL1YjziRVhvUuSI+A/lg+pxv/ssXniApZPSGG1JwlUyPqxmweVmpfOiLgYg8BBntADzQ1DP6zN2vVO3i+fbEG0fTnnCzjJV/eTaXjq5szD5McGdEcgiiyaEqXhh/rm9eHmaC75tvd9cSaOpu/Gyf+0/HQE2M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR08MB5830.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(346002)(39850400004)(136003)(451199015)(186003)(66574015)(6506007)(26005)(6512007)(53546011)(52116002)(2616005)(2906002)(66556008)(41300700001)(8936002)(83380400001)(66476007)(66946007)(8676002)(4326008)(478600001)(5660300002)(6666004)(316002)(54906003)(45080400002)(110136005)(966005)(6486002)(31696002)(86362001)(36756003)(38100700002)(38350700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmdEcXRxRHZPTnRWUHZPL1NhVzAvUDNscVlUN3pHNVI5UHJ5M1g4MDdha2V4?=
 =?utf-8?B?Z1hpazNxZjNEaVhFWkdyOHM1WlBQSFNkZkQ0ZFdyWitCYzBNQ3JLNkJGeHRm?=
 =?utf-8?B?ZWg0enpXQWJ0VTBRRURWYWdoMlZpM3FvRUxNR0c3SzVZWjRYMzRYYkpUQTZj?=
 =?utf-8?B?V25raVBGVnBtWllESjNUaUUzMmo2akVYT0EzWkV0cEVmNFdHUUpnRU5UK25q?=
 =?utf-8?B?MHdkUjkvUVZTL3g1aC8yeWl4d0d4OUdLWnFaZ0w1dGU2c0lodCsrWXA1SE5W?=
 =?utf-8?B?N01YakQxbHpyd3d1bkpXWmRYRUNvRFZYVmZPZmpTdmoyR1NlQ3hFb1h0LzZR?=
 =?utf-8?B?VjhqNFVicjlMMXFIaHZUVm1TaTREVXZJdTdGVnVKTEJRTGdubzhCUks1S2JY?=
 =?utf-8?B?dzFKQ1E3bmcxeE5Eb1paV3o2NS9zMlFXaitJb0VWOVNnUk9kUDNlZnFHOUIy?=
 =?utf-8?B?eGQ4NVJCWk1GbWtKOWcwelkwUldLclRtVW5rZWdWTjZydlFzMTZqa3N5eU8x?=
 =?utf-8?B?OEFsc0o2M3ltOGs2TnBLMmFhc2JuUHcvT2xkaUNDZks1aDBMeDZJVVhGMW8y?=
 =?utf-8?B?V3F2Z0dIWUJ5TGhjaDRWRlpwMTEvWHRKYnFaRDNwWWRQMk1iMHVPdHNIM24z?=
 =?utf-8?B?THhXcHQ0eW04b2VCVW9obWI4U0dXKy9XQlNIRHN0dXFiWUtqNlNGM1lFR25I?=
 =?utf-8?B?WUFLOXBEcDQ2MXYvNlM2eXJYNzlCR2NhcWNwbE1XbjdXM3lIZi9hSjFOY0x6?=
 =?utf-8?B?WDVnUmJ3ZFRsSG0wMTU2b1Jwd0hVZnFsbVYzdUNXOHorZDBkMlhWTURGdmJX?=
 =?utf-8?B?SThtcktyUTIwRHpPZHVMQ1VuK1NJVVg3YXdyRlZNYUFpQUhPb3NqTENmT2di?=
 =?utf-8?B?d0NqUGtJOWZWa3dhblh5dC9lWVJvRFZJRGh3Q0xMYU5xcnRDSlp1aVVaOTRW?=
 =?utf-8?B?L011WklzSk94bmdwaHdzRExsdWd0QVIxRkJjdytINDUzUXJmMCt4UWdlNEtL?=
 =?utf-8?B?ZGVzc0kxaklzRHRoZVRXSFRkR0xPODFJY1dydXloNjRCYnNldVB0YjhRODRr?=
 =?utf-8?B?dnRuNlVQUDg1K092em5nMzF3UWVtTW1jbTVhWDJxdFAvNVlyZ2pvd1BXMm1o?=
 =?utf-8?B?bjZTbnFSc2NhazFtNTJFbU5RdkppT0U0Q0d3UmhiK1JXeG5iSURXYk80czh6?=
 =?utf-8?B?WWtGeVNxMXU2MlRpdG1XS3pIcndhZTdQMGFRR2hpc3h5ZEVqVmFxTWszdG80?=
 =?utf-8?B?cjkwZGJvUkFEYzBBd0RWdndVV0NiSTR3dHF1SGlhaWtuNmU4R3Qzclg3OE41?=
 =?utf-8?B?WWkvQUVTYXhJV211M3pSWmo4Sy9KVmJkcGZackY3ZDR0bnV2WTc0Rm5yai9a?=
 =?utf-8?B?V1lBdlhlQzRWejhtZC9IYVZIVE5weEVGTUVxaXpMVkUyN1docGJVS2xHSTJZ?=
 =?utf-8?B?YisrdlV4ZlNrdDlWVFllTGZqak5ZS1pMYkxrMFFKT1k2cWFmSDNGcTJUZ3VI?=
 =?utf-8?B?Z1hFa0thWVVadGNDMW1GZyt2UGpoU01xYVdQcVUrbUVORlFqdEd0ODZ1UkpK?=
 =?utf-8?B?Y1gxZ3NLYjZYNVZQNzZaRGtVWlU3YVRjckNCZlQ3djNXUTJzR1FXa3R0dU1v?=
 =?utf-8?B?VkZxYkVHOEh0STlaaExYRndKVnhSNWZ3cndDTEN1Rk9yVDF2VU5lYXVFZlBn?=
 =?utf-8?B?dGtNOGRJaFpreHFVMENITEZrOUxEWHA4MDQ1c09SNnIrZmRMNTk5c2Z2U0x1?=
 =?utf-8?B?eHFTMEQyRVcrR3VhMWlwVTVyakFENWp0NnpNdURUK0ZoVDBLMFlXajB2dU9h?=
 =?utf-8?B?Ujh5Ukk1ZVk3NTNabkl0QVhLWUNwbS9yTFdkc2ZTYUlQUU54akZYeFFEREdY?=
 =?utf-8?B?cFBVeE1VRVZwNkJJOFBuUEtFMHVRQTdic0M4UFFhaG14QWdIOUduMXBuVnd4?=
 =?utf-8?B?ZE1NaGRjY2IwV0sxbmZ3Y0RMZVVNRmUyVHVyRVh0Y1NOaVphQkg3SWdoL2pD?=
 =?utf-8?B?MHFQWWNSV3psdFlPVGhDL28zdWtDSEVDMUVDMmtmWFh0S2ZWUjd6VHh4T1ZE?=
 =?utf-8?B?Y29QR2ZEdWVWaGdWNHN5TU9ydTBhclJHSTQ4c2VKbnhMSjZiS2x6TUNHd09G?=
 =?utf-8?Q?pg6xrod59DV8Ie/v2omc/leXJ?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b8ae07-67bb-4eb7-bcdc-08dab1fc3c3d
X-MS-Exchange-CrossTenant-AuthSource: DBAPR08MB5830.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 18:03:33.0805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2vYURBaF1p71sE1EocKLhLPPnY40EdtOw8yUIXUMfs6p0VGyjDoq/5TA0UB5wVkuteROU8FBdEh2ZvfMwZ44ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5750
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.10.2022 14:31, James Hilliard wrote:
> On Tue, Feb 22, 2022 at 10:41 PM Martin K. Petersen
> <martin.petersen@oracle.com> wrote:
>>
>>
>> Christian,
>>
>>> The faulty patch (Commit: 395e5df79a9588abf) from 2017 should be
>>> repaired with Konstantin Khorenko (1):
>>>
>>>    scsi: aacraid: resurrect correct arc ctrl checks for Series-6
>>
>> It would be great to get this patch resubmitted by Konstantin and acked
>> by Microchip.
> 
> Does the patch need to be rebased?

James, i have just checked - the old patch (v3) applies cleanly onto latest master branch.

> Based on this it looks like someone at microchip may have already reviewed:
> v3 changes:
>   * introduced another wrapper to check for devices except for Series 6
>     controllers upon request from Sagar Biradar (Microchip)

Well, back in the year 2019 i've created a bug in RedHat bugzilla
https://bugzilla.redhat.com/show_bug.cgi?id=1724077
(the bug is private, this is default for Redhat bugs)

In this bug Sagar Biradar (with the email @microchip.com) suggested me to rework the patch - i've done 
that and sent the v3.

And nothing happened after that, but in a ~year (2020-06-19) the bug was closed with the resolution 
NOTABUG and a comment that S6 users will find the patch useful.

i suppose S6 is so old that RedHat just does not have customers using it and Microchip company itself 
is also not that interested in handling so old hardware issues.

Sorry, i was unable to get a final ack from Microchip,
i've written direct emails to the addresses which is found in the internet, tried to connect via 
linkedin, no luck.

--
Konstantin Khorenko
