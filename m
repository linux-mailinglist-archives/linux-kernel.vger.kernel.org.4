Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AF66C81ED
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjCXPz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjCXPzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:55:55 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2139.outbound.protection.outlook.com [40.107.220.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8101E5E1;
        Fri, 24 Mar 2023 08:55:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KnwmpfMguljV3Cd6/sFrU4omgIylDKDJpAVYAo2RdusKAfG3HlChbeQJNIuZtoeS558c10ihgbpI5BN+cwJWuD3Aq1pw+DAJua9vxgn5ZczVpNaJqkQAQJx3OchFIwhgXlSIPfLk6cg1C9UYVXanfS/CKX303Jf8+XtryDVHFbot+aMgmBLvNhT6cAklkHG+CMAyycOtOL0FATJ018kA192+rzEDSSVz2+14Ve7e1mTGsG/wLhI5uU1r9uiNhKaRMEil6hVjBbsvK4EVZ2xDahVOwtCTerLGFQxY1s++BKr7WyDnp3O6UyZIVo5vMJ8xLeYrJOnIL2GqOsVcZVKfvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAUiwHQMKND2rirQm2udXbu4T95RkS0R6xzTuFgNaIw=;
 b=Nb9wwhx/muyXcGAzHPrKcPYjJUSUNI5Gv41mIj1avN1TwyClAXtv3rag/B67WkIknbDUWRQM6zGhOI7O/pf1RIPzEP+GgqX6Drj36GcKaZnsPISlhVvZXdBaM3iVC3Hk1kHQYhbgXCN7zz1DxG+2C4TEGl+pQSAQMpyjX9JbOgGgeOguR0Di7pmhZIIX8obB9IWLG5iws19rMXikhDiEOq6YUDs5c4BVeYKLwUYa8N8zdbTBQGom0LU9JEdkg8qdXh3liVbUwPaVoLWnJ6/WQNZMEG24OoR+KLORTHpyGhsiZG5smWA7PpC6Pr1O2qZM0UUSqUg8FUhuZQxvNng9AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAUiwHQMKND2rirQm2udXbu4T95RkS0R6xzTuFgNaIw=;
 b=std0R25P5ldlMYFmIFWnvShc1NiQ7TfqqGYJBSXy+bPhyRA6+8KzgSkm7tTG+HnfMFJ9JnJgNDTBFpc1ETXQBlsvVEUhjEjhcCXI3TFA/yX5pqh0HCGGoB60AK9F+ucBc01XAMyRPeaHwDpTzYughG4CV3U+4epRQ65aosjxbMM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BL3PR01MB7027.prod.exchangelabs.com (2603:10b6:208:35a::9) by
 SN6PR01MB4142.prod.exchangelabs.com (2603:10b6:805:a6::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Fri, 24 Mar 2023 15:55:48 +0000
Received: from BL3PR01MB7027.prod.exchangelabs.com
 ([fe80::ef17:958:5c42:3d26]) by BL3PR01MB7027.prod.exchangelabs.com
 ([fe80::ef17:958:5c42:3d26%3]) with mapi id 15.20.6222.010; Fri, 24 Mar 2023
 15:55:48 +0000
Message-ID: <84a9421a-f9f3-7a00-a3db-663421b57c69@os.amperecomputing.com>
Date:   Fri, 24 Mar 2023 08:55:44 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [QUESTION] The delay between sampling for CPPC
Content-Language: en-US
From:   Yang Shi <yang@os.amperecomputing.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org,
        george.cherian@cavium.com
Cc:     scott@os.amperecomputing.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <0453c753-681e-4d42-65e5-a5967697f6ca@os.amperecomputing.com>
In-Reply-To: <0453c753-681e-4d42-65e5-a5967697f6ca@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:610:59::12) To BL3PR01MB7027.prod.exchangelabs.com
 (2603:10b6:208:35a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR01MB7027:EE_|SN6PR01MB4142:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e044a45-6bd2-45e7-cb88-08db2c803c2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nWh5TyDQ5s7pb44L4AJt1LjLfUN6pLiGdvz8wi7hZPyFxKiSV9Umg9o9UURObrG48Z1WeRr5LTWJ4uPXwtklvEdbkv8DwIbTyOdvAbdi4USihJh2SgI+mgaFrYPHv54k+fS+JAl43vmPcYsjcwMQjJ8eX4xxxaJ2FBlzIS5Y6avqqbUKaO/um/DtblIZZiEGsLpRE5nwm6JWBFQZUxJwbpSZlL1F2t2kvj9xDjGYLfno2LgZoxPcmu5KDS8T+Lm0aUib+T+6cvqakg9UksvqD6MaboRw8TrZSmNbvQfDVdfSk7/87JXegdIUUGdtAab7vYBcpuRnEkg236KNPN9wTEZElYtRRqJLivs/YT5hgo8MFa9Tean9bcl0hHetgBdrjUHOaVm2jm0L9vW+hRsASB5xDZLIpqYD7dds8ecfhYSriVoBo2qskwVXNwTBjUocwRmoNUrT7kwr5yffkVTURaSxwsITJhzJSL4fWjCpZyCceli5vGqdZTpZJOdxhxWGRgl3xb+8MMqg1L6dcELXtoKp/kLH0Bilfp9HqB4lmSVJUIKYNSHobheIOsthk7gzroHfYA6GEGf44DqCx3DWgCieIwz2Kfc3snZYpPiTx+cqwh6clRE4waKX6LKTsQGjxl2OOUZgWcNjBERffTgksw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR01MB7027.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39850400004)(396003)(136003)(376002)(366004)(346002)(451199018)(31686004)(53546011)(66476007)(8676002)(4326008)(41300700001)(66556008)(2906002)(66946007)(4744005)(38350700002)(38100700002)(86362001)(31696002)(5660300002)(8936002)(6506007)(316002)(6666004)(186003)(26005)(6512007)(6486002)(52116002)(478600001)(83380400001)(2616005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M05zYXN4azJTV0NWTzY3TVE2WmVkTXlad1JhVDYwRVIwNmN3QUNadnVCWkx3?=
 =?utf-8?B?ODNYdlhEK3d0aGRYVlZOUThSSkdBWnY2dGY0TW85bG9tV2xWRHV2L3ZkRDBo?=
 =?utf-8?B?OXJBS2hoV2JCS1BTVkFFZ2FKNDB5akpNd0dKK09mK3RBaGdrUmEvdFg0TGk4?=
 =?utf-8?B?ZHNTRTdqdWZvYlhTRVZZSDFtSG5XZUdQRlM1N3UzaTZDZ2ZVelhkSEFBYSt5?=
 =?utf-8?B?L2pkcDJRUkVhcFFFN0lJeERia3BGWkNxSFBhMGNWd2V5ZDB6QW9Cbm9mSTZr?=
 =?utf-8?B?eHg4bU9WSG9Yci9VRmZNa3FFazE2aVg0M3pJV21IdEZHR2lHWUZiMXBxeUZF?=
 =?utf-8?B?a1BDQnRqa1RRblQ4OXVJV2RObi9mU2FSSHRCSTgxRWFnOGNzeStva2Z1L3I2?=
 =?utf-8?B?TXlDQ2l0dWpsWHZHVDBtaEZ5WlY3d1FRbWdsMTBnS3U5NUE2cmVrR3M4UmRV?=
 =?utf-8?B?MjU0dmZhRlpTSCs5djc5M0g0MzJHR01rK0trcndQVDFzdUd5T2tYQVJ3V2Fa?=
 =?utf-8?B?MVRISUN6dmR2djNJS2NBMGdPMk9NOEJSRlVMY3JIRkxiMXZYaUhOS3p4VDdq?=
 =?utf-8?B?RjBTUWliMkhqY0syS0tMenc3bnhMbDhGNEpQTDJXQ21jUUhzTjZ2RExHQ1hu?=
 =?utf-8?B?ZVpCcXIrSCt6SUJnc3BZamNuWjF3VEhQRmx6U1UzbUM5VENZbjlzMDBTL21w?=
 =?utf-8?B?cFk4VU9aelJmcFlRbnpoVURNOXJUa1g0ZTB3bGlCeVhqZDAwR0pPdUdUOVNO?=
 =?utf-8?B?SGpQb2Y2eVF3WkVsSlhJY0lvamE5bitiazI5ci9FMXhKNGdSZUx2aisyOEpv?=
 =?utf-8?B?SklhNXcxbktnRmxwd1ZPV0NXS3lWaU5IVmo2TzRSb1k0WkYxODR4NmlIMUpW?=
 =?utf-8?B?bnpweklpTEt0bFJUY2FHd1A2ditXcVN5dGEyY3k4NlI5SWM1czdLUC90MjJG?=
 =?utf-8?B?OUdQcnd4TG5pejA5ckFZQzRpWU1GbWorYTQ1Q2FrbHk5VHY1eWQ0K25VUDZL?=
 =?utf-8?B?OWVaSXVqSkkwTXM2SnQzQmtzamRkcFd1UWNQT2lHQzRVMURpd2Z3eUVmZ3dQ?=
 =?utf-8?B?eXV1SWNaMVdEZWZid3djRXZmeW9sVzFTUnhwSFV0SkhyM1NDYkRZZkxSN2sr?=
 =?utf-8?B?dGdvQ1dHNXJzUG01WlkwNzloN3BMRFd4OGQ3QitzMVlHd3ZTaVlUZHFsTXg3?=
 =?utf-8?B?VTRHYWNEc1FHZHF4YUx2QzcvMFJrV1FicGRSSWFwcHptbUMzbzlVOEIwN0or?=
 =?utf-8?B?dEtrSThveUxJQXVQd3FDZW5uVk9vRG9nQ3hhRVNJSWZUbUpTWVFzWjZMQ0tz?=
 =?utf-8?B?UmFoNUVvVmtPakNJOTNGTzFZMmJ0QTd5SThKUGY2WDVYMDFVWFBLaFdaWDlL?=
 =?utf-8?B?RnBldktzb3ZycVlBR09qM2JWN0Qyc0dGTmdmNmQyMVBmWWVMVmM5Z0gvUDA5?=
 =?utf-8?B?eFlTV200TGhodlhpbktXblUwRHdtemZOTkgzMXZsRENBbmV3MEtTRDF4RjZJ?=
 =?utf-8?B?RmNzNmt1WkNXNDJlY0NLdENCbXFsOHkvYnNVQXBqZEJMdENUZGdSQlAvYVN5?=
 =?utf-8?B?T3JIWDB4VGpZYzBsbjNkc0RLNmREbDhjWnhpY083UmJPdnJZYm01bkg4ZG5Y?=
 =?utf-8?B?ZkhQVWxubUFBWW81RXFhME1sOVVvTXgrZWI3K2JpUDlNdkdydzZaK0VibERt?=
 =?utf-8?B?ZDFzekNjdkdXUFdCNE16UGFzTHk5eE1oaVh4N0gwVnY4eWVsNFczY1hzRW5F?=
 =?utf-8?B?MnFOdWNMK0lyODRmZmdjNG1SNTdDVEtZYSsvaWxndU9scDFyTVU0bUZHcnpI?=
 =?utf-8?B?WE1iL1FxMnJHL0FTaVN1MVhpb2NHcTFPa1E2bnc2dTZFTUtMNk80V2U5NGpE?=
 =?utf-8?B?bTMvZzUvViszT2d6RkZjUlFFNndSdjhVR3lFcUJuSzIyTUQ4akJwU2EwSHZH?=
 =?utf-8?B?Snh4YU5ndFlieFM1cWkwTm5acHpNWTl3K0FMYXlzeWxCOGdpZWswN1RiUDhO?=
 =?utf-8?B?bThiQ1VtUFdDMDlGL1pjTll6YzlnaUs3T2xvRDNqeHNCUldVcVpYQW02cEhU?=
 =?utf-8?B?QVZZQ1kwbFQ4b05oenN0Znl4c20zWVF2Ujd2Tk5Cc3VvSnBoWnEwcVV2dGMv?=
 =?utf-8?B?dVBpMWpPRllIMUY4ZTBGU3ZySkVlYWVSZkMxMk40SHk2Tko4T3NlSU95cmtC?=
 =?utf-8?Q?jm3dKxLXsCcxmb4+VI/pNLc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e044a45-6bd2-45e7-cb88-08db2c803c2e
X-MS-Exchange-CrossTenant-AuthSource: BL3PR01MB7027.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 15:55:48.4495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3nLOAvezpxSiHM42CGdRdI9kXziQSI7XItrbT6z7N2yw0UuoZ00n1PC6gLRGrKnQPCJOPo6I4lSWkzjBZlJm2Sy/3epniZKJfvxKYJroHUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB4142
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gently ping...


On 3/20/23 10:21 AM, Yang Shi wrote:
> Hi folks,
>
> When testing CPPC cpufreq on our platform, we noticed the error may be 
> quite high and it (high error) may happen quite often. For example, 
> our platform max freq is 2.8GHz, when the CPUs were fully loaded (100% 
> load), we saw cpuinfo_cur_freq may show 4GHz, it means > 40% error. 
> And the high error (> 1%) happened 256 times out of 2127 samples 
> (sampled every 3 seconds) in 2hrs test.
>
> We tried to change the delay to 100us, things got improved although we 
> still saw high error, but it happened much less often (22 times out of 
> 3623 samples).
>
> So why was 2us used as the delay? Does it make sense to use a larger 
> delay, for example, 100us used by our test, or even larger, for 
> example, ms granularity?
>
> Thanks,
> Yang

