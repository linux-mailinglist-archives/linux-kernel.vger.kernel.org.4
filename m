Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFA1696FF3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBNVlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBNVlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:41:22 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F6129419
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 13:41:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOIxefmYo2BSDfsRk2umURVEsf8ptHnKoyoU4CosF5BA5viCl2RqNFf2gLZAnBZE1N4nMtpL07oemACNDXphi6pdBjTkGlEro+1FRAsmfQV1A7/dXmL1Y3G9iiGv+glDM/HuayUUZwfRpBMY25BGCy+FqQdgZmDegQtFpPMlMoSZ6Bqz2+XnL3QUL55sxmUqiG8Pg4VvMWndAJ2N04rd4ipaTkV+Ntg72rPHLJmgp3fecTvTrUDhrPgN7pJsR172bGENZ7IL/psLPjfxL3kIai50Vz5a9V9n/CxinNnWWRY4oEX/8DsjqV7B0jhUcH56/NRgaEMIg1RyNDzp2t25sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suhuj9RqZW5OtMnccCr+rnYMWbQmYZD/fEz5npI6Mtc=;
 b=UzLPpDepUZsEfDS+/t12sRmLrJFEk+18SmwZGwmkq8uasFHYGdEO12ZrlqA1u7QyGfqf1SoOIqcPhf1uH6+zR16ROM/sK81AU2lW+U1kklEB3EQWPHCl6a86W4WkQe0YbGNC2lYRy0Z+Z8fMsRJZSe5ZJufWpjCElb25mUcH7uwyMjZtVBX12iv5YMKQmQ/asePJjhGkChpSHzErpjH1thXsFamIeli4D4N/vAcFJDJ+2cXa5TSJWrjBudtdnu8i2qhBl94l59Mc7jDh0L1HAJ0qmvgBkEa/nvJ/DvByCOFQjsaajiSAQJLaD19D3piV9rnNbgu2kIwbMxeFiMGySg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suhuj9RqZW5OtMnccCr+rnYMWbQmYZD/fEz5npI6Mtc=;
 b=3USeCJjivt0qHRv/Xv/YDTr9bzqziks7rJE5ocyaG1QywXdgnBXbZJNqsQ/v9UIqQFM724o9K5QvmqL/rkjD+VhI/1Kr3892GbR0AMJ/D42RoWA24zpB+W8Qit4PQg0A8ij506Da4I1dPvgHih2gwKjvreMJWV2pPyPIRpvyDrg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DS0PR12MB8199.namprd12.prod.outlook.com (2603:10b6:8:de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 21:41:18 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%8]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 21:41:18 +0000
Message-ID: <a06eb4f4-70c7-0a3f-c22e-ff69b587e0c0@amd.com>
Date:   Wed, 15 Feb 2023 03:14:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V2 6/8] soundwire: amd: add runtime pm ops for AMD
 soundwire manager driver
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     amadeuszx.slawinski@linux.intel.com, Mario.Limonciello@amd.com,
        Sunil-kumar.Dommati@amd.com, Basavaraj.Hiregoudar@amd.com,
        Mastan.Katragadda@amd.com, Arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        "moderated list:SOUNDWIRE SUBSYSTEM" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230213094031.2231058-1-Vijendar.Mukunda@amd.com>
 <20230213094031.2231058-7-Vijendar.Mukunda@amd.com>
 <383a8166-bc60-8557-e76b-f6287c967598@linux.intel.com>
 <65ec1f29-2ad2-acd6-feff-7d1d6f40ef8b@amd.com>
 <37fbb1d4-60f1-5cba-180a-ba51922fdca8@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <37fbb1d4-60f1-5cba-180a-ba51922fdca8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::17) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|DS0PR12MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: 575d7b8a-1949-46bd-cf3c-08db0ed434b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1OtC4vPiY6QxGgg5KZsYsti4iV/phdyhF9xgerpLBhExTaAdnZXRAPB5JG7xcLRfT8sJcUqk4l0upA76K4uVgrvBRs6zt5fITydfQg90MPFZ2G6SZC1J76mKcAQAN5VnFPPf0+r6QNxAE4qRJGZHu8BzU+EjiK12Ff87yXGWs+U3Dt4zxz1tq9upp2x28cFhmiSxHINihsGDg6vjRn6qlHu82oKH1Lr9bh20rs2Qz/jCnkVhT+d9Hlzx/KaHwjmeNl6GOXWdf5tG2JShweunnlnf3SLxHIg19W9J4dgWki/BP56DXR51d4OKCJrW+FBF+fVMqr2jv3lOHp2JWaEliiEaOoGwt5ACJzTFY0phbEAz1wnDfpuIpTyviFJ1WliUZrwGQOjNhq6+nrjMl/6JKQBJG+K6kroojO6iE/K6cJ8uRQ9hcoG6pOFC09dAFz8cBq28ScTXJzRtAffBoMSzkDVMi69/QHJmEfRkT/kusIwja/HOh/JEIJbPyfU+wMdoU0UMGH+61Movl3jec1hplB99OdUlsOpfFugncQz4SX+vPCKNd7SKsZ9yuNkk2ntERQBlcKWTHI1d5/WDdM2ujMIu9To2geo3Pv22bDJ6U3KMcRQHeHUMYjIcTp1lFUfdrb2JaOrkLeeKoYnRnoTCIdnbvUcSfwqA400/tpZqSkPjJ5X3CxKjeK+rEkp6BGqsG3EY4eKoO6WSsUOahvI4bxtDz/KX0ZUsssbpB+xl6TE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199018)(31686004)(4326008)(83380400001)(2616005)(6486002)(36756003)(66946007)(478600001)(186003)(5660300002)(38100700002)(31696002)(26005)(6506007)(53546011)(6512007)(86362001)(66899018)(8936002)(8676002)(316002)(6666004)(41300700001)(66556008)(54906003)(2906002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UElWaGp3ZkNQMURyZ1IvQ3g0MXJJMnhsNWVIZW1uY1JvNitUaFlNaFZIRmVm?=
 =?utf-8?B?Rk9wVDZiZHg2K2MyNXR6eGVya08yM1o4Mk5Oc3BCLzFvRGNLUzlRSWVkb1hm?=
 =?utf-8?B?YU1ESEUwM1Y0SEV0OXNleVpmZ1ErMCs4NXdhK20ybHFCWnNicTEvTjdwNWZ6?=
 =?utf-8?B?bG50dlRyZ2JaeE9PVkJ5Q25XcEpBMXRWeHBtQ0gzdXd0VW9jWlpyM1p3Z0tu?=
 =?utf-8?B?VzlFQzVYY0JIMmdkL2dRcGJVN1BKNU5rNDNpdGJkVkE1aXpLYmtMVkxZZUdx?=
 =?utf-8?B?bVdpK2s5RmQ2U0lpTTE3dG52U1RlOXlzOHVCbG1vVFBtMDB3TDFSK3lkY3M4?=
 =?utf-8?B?RVkvOFUvUjdHTVRZNXpYVUpRV2dUWkluUWNIOXF3ZkZ5cnF5KzVJRmRSSDdV?=
 =?utf-8?B?YzMyV3VneGpvUjhucWpVdjA3UC9JKzVxd3lQWm8zR1p3TzEycUNQc1pZVUZ5?=
 =?utf-8?B?a3YvQ3AwS014RmpXWjYweU95RU1HclpMa21jMndiRUJxUEZ1aXpOL3V4c2cx?=
 =?utf-8?B?QWx0NEFJSEJyL08zamNoQ21aRXh2UGRoWWN0b0ZmaHBPRHFSOHpTR2l4azQ2?=
 =?utf-8?B?bm9CcW5kQjNsN0dQUUlHMlFraHBJSlV3eXMvYjVQTDVLSzVEQzI1TThma0hr?=
 =?utf-8?B?bFB0dkdpa0JsOVF6ZFlaNklGNWRnU3lJSkE4SWFzTTVjRCtVTXRqTFJreFps?=
 =?utf-8?B?b2UzeThEbmNldUNWVDBjUE9oVGdLaVJpMDhUM2IzbXAyL1p0SGhCTlo1VEdo?=
 =?utf-8?B?a1ZWMm1UbjczcS8yTVlkRVJCd1hJVStpazhJK3prQ3dIQ3ZhVUF1QjdZZ2F4?=
 =?utf-8?B?NllUeTdPTUF5cFhvWTRUMWJBWEl3SXV1YmtaWjNmTHM4OW1keUR5Z3hQcUlk?=
 =?utf-8?B?d1NCTTRCRFBTOFgzNVFkR244T1dZQVA4Y1dUZVpjYlg5V0oxZmNtSmUrZFZI?=
 =?utf-8?B?U0JZS0MvWnVYc3NtbUxMMUt3bE5kN2VqVm1kRjhxVi9VZUV1ZFVlb09mc3BW?=
 =?utf-8?B?VjN2MlZjUE9TQWdwM3FHSkFaMyt6bkxCUXN0bDJqWEVRVGZNQklkOXN0aVVk?=
 =?utf-8?B?N2NvVWxzbzNkYkIyTmwrZng5WXM3bGcvb2tjMkNHNWF6WHIyWjZSWlc2VVpw?=
 =?utf-8?B?M2czUWR4LzdoSi8wMnlmdTl1NFdUNlVjWmJ6anZpMTU1WVNKNWtUa1JZWW9V?=
 =?utf-8?B?T1c3NnBJNE5Jd0hnblZ0Zk85YjRxWi9nOFllMTlQN1NpUDdLNW50d1RtamRE?=
 =?utf-8?B?VTBlTzFaK1hHSVh0Z2pNeEg4VHA1Qlh3YklJTVNIZk9xYWdjQWtKUTY1YUZW?=
 =?utf-8?B?emdkcXp2QmdNSUhRa1A1b1k3WDBhd1ZMZTdJYTQ3RnlPNmx4VUg5c0RLUFho?=
 =?utf-8?B?ZnlLeXR0NWo5WmdmZGI2LzdWTXJjcFMzTkRRNWxraTIyUXdHNXBBa1RNUkQ5?=
 =?utf-8?B?WXhacmlwQW1OKzZaeXFRWWkzUG1nMk1GQWd2cE55NnpTMVpzWVVTdWJrRXhI?=
 =?utf-8?B?czdjak9URzdzQ1MrNWtjSnhiUVBwbmprWWlkcWlHMXpjbEswZWlBeWhWcDls?=
 =?utf-8?B?ZHhrTHB2aWRoRGhLVExJOWc4Nk5JdXNHMjNJdndZMnJWdEE0MXppbkJYYVdB?=
 =?utf-8?B?TU5lV2lpRjB6cGJrQkE4RG1hTzlzaGd0NHZLMjc5NEh2eTZUdDNDcEcrSUxs?=
 =?utf-8?B?Y3JFVWNuUld6M3lPNnhnME5RblQ5M3liVVk4TWNzbi9KVWRadHdPaCtLREEz?=
 =?utf-8?B?aC9qN2tsaWsvTHlld2I3Nm13RGJTTUxUenlrUHJYYVhCeXF5THpMSmZnQXJw?=
 =?utf-8?B?Tk9EUE1yRCtUdUg3SVNKeDNTaDZxQmhPd1JrbTR2bmtoR3o2SnZXR3hha3Vr?=
 =?utf-8?B?K2NEMW9aTGhNSHV2eVdkVnlweDlVUUhkNGFiNFp0WWEvSmU4RWRsY0RQZTc5?=
 =?utf-8?B?NitZblkwK21yYTV3dUZhSTlFUm9FK3J3Z2JFZUU0Nk15Qm9HdTVpREpKajlm?=
 =?utf-8?B?aFN2cFMyRERwbjZ4VkhYanlNVThJQk1mTk05M1lQaXFHbFBZS1NnbVlMVy9m?=
 =?utf-8?B?WGs0YStVZytXUDVMcnRKYzJtSExwZ3krTkt1VVZZUkk3dWNnUEdIVWdTY3Bk?=
 =?utf-8?Q?BeZupzR2SsR+YINRjvq6/to5K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 575d7b8a-1949-46bd-cf3c-08db0ed434b5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 21:41:18.6837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVevvHesFluYAyZQ8cJsmyt5TY1mLU4VrVqLEN3kgvjIIoPbNguf+vX1C8wfkTBclamRgG+sA4Fhxs7v1URE3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8199
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/23 19:03, Pierre-Louis Bossart wrote:
>
>>>> +/* AMD pm_runtime quirk definitions */
>>>> +
>>>> +/*
>>>> + * Force the clock to stop(ClockStopMode0) when suspend callback
>>>> + * is invoked.
>>>> + */
>>>> +#define AMD_SDW_CLK_STOP_MODE		1
>>>> +
>>>> +/*
>>>> + * Stop the bus when runtime suspend/system level suspend callback
>>>> + * is invoked. If set, a complete bus reset and re-enumeration will
>>>> + * be performed when the bus restarts.
>>>> + */
>>>> +#define AMD_SDW_POWER_OFF_MODE		2
>>> You need to clarify this mode, can you deal with device in-band wakes if
>>> the power is off?
>> On the Current platform, in-band wakes are not supported if the power is off.
> Humm, that's an important clarification.
>
> Does this mean your link0 will never use the POWER_OFF_MODE since it
> includes support for headset codecs and you want the ability to detect
> jacks status changes?
Yes. we will use CLK_STOP_MODE in runtime pm and system suspend
for Link0 when jack codec is connected over Link 0.
>
> Or is this more like CLK_STOP_MODE is used in runtime pm and POWER_OFF
> in system suspend?





