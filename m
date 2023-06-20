Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8980736C43
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 14:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjFTMsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 08:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjFTMsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:48:13 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E181709;
        Tue, 20 Jun 2023 05:48:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RuR1VK9jUZiR5HzhtLRImTpD+6vyLB1E2FWBtGCDBvYECihp/gQV+s1rbkomFB+ju58viwdaLDkJN+Zl0KVly0gIcetpjfIZigKIOoJO7utetznLCJs9iqUaCmoEegUigGF7F1fs6DlDsSX5h4yXrn4ht5iJfKd8CI0AfRYOVZuj2i5sSWom8k5kIkN/aTnN0Q560U5ZOOuy+e0Fjkfo24/jYj7kOdK3zYJMELlcfG/5HCUZbqg7GjXluDXt9uOxWtPkxa0fe+KZ+vYCcgv2cjkaTTBoEanNxffNXcmOpmVw075ughkp8x8JCIw1jUUeU1kc3sUoH+5rWvmaC/XfyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sz4XGrh7PiSSXmoFSjRHr3MF1EtSxuxUrBCjcc38mPI=;
 b=jT0+6mnmkuNN7lX67kTOCEYtK5mPYDBZ4s2xJtq5xx6SHYRyW7U7wQRhmeIrY0DCQ+o5DKv79p7qjuWpredxH7CZlEX1y9nEoyWy7G9pq8qvKIw6ENRqgf+C9VS/qeZHkpHUfp4anlg13Ud2IMlMkzpqR6x6sOy0d12FSYOZoYh3xuwVvjIXDnebfXnjXb/2v+dNbxXPGIx/Bd5oaTxgZZVM1+nkaewox9Qc9b1dMlsOWgOJRqE9q34sFJEOl9TCBcvGBOSUWsmsUo+iaH1Z5p9mL/s+grA9h5ByvlqNMyP6QCxBHkyYyoSgHRtdxa4dZ1kvcha75LdnzE6EtB0/wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sz4XGrh7PiSSXmoFSjRHr3MF1EtSxuxUrBCjcc38mPI=;
 b=3pMszQBmAZK5PON6AOlObL3mfZ73+6CDsdoPla+yi/r9Az+Aq5LMNiMetXAKZHd/nnbV/FDwX2oVhSHZN9rXLfKUGhJW7xj0ptNool/z1MLVwLIQFNJglpyFQhpwbyUR4b/LBLE//HbwPX9+vQjAcajjz9auqQ/Ep7U6iQXHvfk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BY5PR12MB4162.namprd12.prod.outlook.com (2603:10b6:a03:201::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 12:48:02 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8a7:d4dc:7ac8:9017]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8a7:d4dc:7ac8:9017%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 12:48:02 +0000
Date:   Tue, 20 Jun 2023 20:47:37 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Karny, Wyes" <Wyes.Karny@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "trenn@suse.com" <trenn@suse.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/6] amd-pstate: Make amd-pstate epp driver name
 hyphenated
Message-ID: <ZJGf6ZCeMZxbJND4@amd.com>
References: <20230612113615.205353-1-wyes.karny@amd.com>
 <20230612113615.205353-2-wyes.karny@amd.com>
 <ZIwKNI6OvhZles5F@amd.com>
 <CAJZ5v0j0AqosqH6wx2ToGOM-zGdowJiZtxG2kZrSd9QcJyXdtw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j0AqosqH6wx2ToGOM-zGdowJiZtxG2kZrSd9QcJyXdtw@mail.gmail.com>
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|BY5PR12MB4162:EE_
X-MS-Office365-Filtering-Correlation-Id: e66dd3c8-d3ff-4341-a9ea-08db718c954e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kvyoMB0ly4THh8Q5mJi5bFs21EMX5Lr5GysNvJ4fIujszo4nG/KzeHKfQEDLEyHO8j4o7X76mqsrR/CuXjnY6opzzfeiB+yUtWcCRcxg3e6DaldF0OYErZl73gqknYuaslX6k8KE8Wk7OmdOeYvh8AvESGjF1cClE8o+BFuBBvFLpONVsRq76dYRF6T4ERb+R3R8THkTlMoPpN3ozE/Ls8GqBiSoCnfwc1+CxITG3yNRWVD4k+EH85cH8APV/hz0SHXQEw43/TC2feMXR5JebWX7zNvqiXaQiIwCN0MNJvD6+FeCNK4nllPTOLCIE6LM25LNTh2vk/pcbowoCn8TTquJHw4wYomQaV9R6A64RktNMUtdX0IeIaw89+4i2pSGfXN2YonG+HbRN88zNYfNY0G1GXhSiCGE5bsM6EMeXLuFSt5xBOcw59Y4nh+en3E2PnRqkUQFt4LKxvi3QOUB/7EPyeNEJjhyI3B/WBGcnqvnZVeZit3jb9yazVbQJuU6Ekn122K7SrXm7ViP4gz2+mHwO3juGSGU2dMn1IJ09ndWdZW4hzU16UroHm8RdfID
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199021)(478600001)(6666004)(66946007)(36756003)(8676002)(6916009)(66556008)(4326008)(66476007)(41300700001)(2616005)(38100700002)(6486002)(86362001)(2906002)(5660300002)(54906003)(8936002)(316002)(6506007)(53546011)(6512007)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnozakUyVFVGWEhyU01qQkUramFaOEhkUnFrRmRUNG9UMjh4RWxhY2hvdTNH?=
 =?utf-8?B?YkNmSnVpOE05SnZ0K0t4a3l4a2lRdXo3dW12T1Y1MC9qcXNFS2lNem1mclFF?=
 =?utf-8?B?TWd1OVRFUW8wblZJRmRJSVd4Y1lENXlFWnRrc3REcXJQK0luT0lqTEdsNEJ4?=
 =?utf-8?B?S2tFV1c3bTBEWG9sTFVUNWlWRlgva2JtYi9FKzhlTHROUVNzY0F0bmVzSElX?=
 =?utf-8?B?ZTd0bDVxV1l1ZjcvNVdoaC9hVzFIcnZJakkwYkxBOFFvaEplMnNIam9MOERZ?=
 =?utf-8?B?WkltS0JLa2hobG02L085NkJVUjRMR2ZzdFAza2dvcGNSVE5WNUZBbkVMNnVM?=
 =?utf-8?B?NVNnd3NsVlVIWTJwSjBoSEdUaEVHeThKdHJwWTlJYWYwU0c3dTFaQ3pNTWpQ?=
 =?utf-8?B?bStuS3lrc0EyYjFOcURaalNPL1lJUy9Fa0JTNFFEdm9UQ3VmRGVYWlN4aU91?=
 =?utf-8?B?WGZFbDVPdTRLN2o0Zm9zZXVqNStlZVR5ekFESTRGSWJ5Wk5DSExvb3RxWHFp?=
 =?utf-8?B?REpDOStFT05DQ0l1OXFSdFdYcldDQXoxUTVpeUxIeGFVbTFJNUpjcFQrQWZR?=
 =?utf-8?B?Y2plWG9RVWtWREtFYWlWVVpuaXZTOXJWZnYzTkc3L0dnaGhJUHJ4L3lmc005?=
 =?utf-8?B?VW16RG5henVVOFo1bDRTc29Ld3c2SmU0MFNqUjFYSTgzb25CSnY4M0kzV1Ji?=
 =?utf-8?B?VXBua0twMDFKQUxRaTROZUUyOTlLR3Mwa2RPY1BiUlZXRU53YzhXcEQ0OUty?=
 =?utf-8?B?VUhSV0x0aUEwam9laW1kSmdCUkp4S2Mya2RmOUtkY0JRTkFNS3p4aUVZZ045?=
 =?utf-8?B?ZG5UcTBGYWpGYzBKY3NFcTJDVXdDL2labzF6azRPNDFEcHMzdUR6S0pXaG5F?=
 =?utf-8?B?Q3U4ZkV5T1RBVEtlUTJrdGR5R1RUbkcveldPWVVWY0lUZG0xZDQ0YmNsSVQr?=
 =?utf-8?B?WkZiTlNVUXhQTU9LcTZ0TWg1QWpGQ2lmWGdkQWZTNjZlOHZ0U0hPK1BUZE5v?=
 =?utf-8?B?WEcwYUhlK3Bid0lhN2dGcHlKSlliSFYwdlhKNUNTY2lRczFhNUpIV2R6SHds?=
 =?utf-8?B?NXhROVdZYTIzMXJBdHVUQkVvVDdRN0ZMMTdOa2tRNzRXMTAzdHhQRmM2eldZ?=
 =?utf-8?B?Wld3ekNud2Z1ZEdmcmNwUEhBZXNaVGc4U0ZDZzc0a2hFWjJUWlJVLzhsSEZN?=
 =?utf-8?B?bnd3RGdGZFlxL3VCR1Rka1Z0RStweHRDeVVtcUR4R0N6Z1d0NEdhVElSOXVF?=
 =?utf-8?B?RENsZTRudGg4TGY5L1NrZUEwNFdLbXFIdkpocjVpL2JaZGc1RUNjazAwRUp4?=
 =?utf-8?B?TDUvRnFUSldUOUs0dU1XZlZzdFpsbUVxUkZ3c3RUOEl0T1VrNGNrZ05udU5p?=
 =?utf-8?B?OEIzeDgxNXErR2Fwemg4cUEyMzMwc1FpWkF6N2lmZ2xhdysyR3R4NVRhWGxN?=
 =?utf-8?B?RTR3Z3dNVmgyN2kySCtTZ1BmY01lb25aRmNNTld5aVJvUUo1NTF6Q2ZmMHl6?=
 =?utf-8?B?cURRRHh3L3RVU2F0U1VpOW5pclpjWXlYeExOZ1hucGJ0WDJ6bVBXYmMzcHVR?=
 =?utf-8?B?d3M4OG1TTW9rV3N3b1BWZzFwSWNoeDJNQm1Oa1I4RnZvS05WT1ZENFVDTTYx?=
 =?utf-8?B?S09kb2UraUIwcXkzNDhCdnBxd0w1bWhUa2h0M2V2UHJmellVdTNwVnBoMG0y?=
 =?utf-8?B?cHJWYnJ6NHZZbWZYdWJSRzE3RVA2T3BGa2NvVWN3VmxNMmcxemdKR0xHeUx4?=
 =?utf-8?B?OTBpb2ROS3BXNFdwYy9oMXVHZUtoSHpSZlBPTXFUeG5wRUdMT3RFTDIrT3Qr?=
 =?utf-8?B?QnlpYXNvM1FLVFlTd05ieDFYa3k1dDVvSUozS1ZHbG1UWENSMkhmTUQ2YVYv?=
 =?utf-8?B?YityUURtaEpPbHNqNGZ0dXBCbHl6Mlg2OFR0WGNvcDVNL2hlQ3hUclBPWlgx?=
 =?utf-8?B?RzNpcTNxK2ZlNDZLdFZxUjY0RGh4UHozOWZmNXNhMXFPYzZySEhsZ0wvSm5O?=
 =?utf-8?B?QzJWNWI2NC9KV1ZjaHFkMnBNWTdsbmNaL3FzcUYxc3RRYjlheU81TTJkQlRh?=
 =?utf-8?B?dDhBdlBZN3ZYS0F6RmJpM01qejJqdXU4aVdXRG94b2RzTXZubmJxUU16NHpp?=
 =?utf-8?Q?i11cPlKWptXru00llvIjMpFEA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e66dd3c8-d3ff-4341-a9ea-08db718c954e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 12:48:01.9408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tKuBdCDRTsTdAyytSvMgvwWM7zWHt533bWgyQgxT0o5OWlojUipe4ratGzrQruKV/skf+7c4OAnxsGdlhdER6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4162
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 08:33:30PM +0800, Rafael J. Wysocki wrote:
> On Fri, Jun 16, 2023 at 9:08 AM Huang Rui <ray.huang@amd.com> wrote:
> >
> > On Mon, Jun 12, 2023 at 07:36:10PM +0800, Karny, Wyes wrote:
> > > amd-pstate passive mode driver is hyphenated. So make amd-pstate active
> > > mode driver consistent with that rename "amd_pstate_epp" to
> > > "amd-pstate-epp".
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
> > > Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> > > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> >
> > Acked-by: Huang Rui <ray.huang@amd.com>
> >
> > And yes, we should seprate it from cpupower as Rafael mentioned. cpupower
> > tool may go to another repo.
> 
> Not only that.
> 
> It is generally better to send individual fixes that don't depend on
> anything else as separate patches, because this allows them to be
> picked up and fast-tracked at multiple levels (mainline, stable,
> distro kernels etc.).

Get it. Thanks for the clarification.

Best Regards,
Ray
