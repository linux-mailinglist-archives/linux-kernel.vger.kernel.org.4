Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606AC5FC467
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 13:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiJLLn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 07:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiJLLn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 07:43:27 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF47D82D26;
        Wed, 12 Oct 2022 04:43:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BsH6amQk3Fb+ibubEzRg9OrQGE4shbCmeC8TIbzQe/rNxGhnovCbLvji19u+9bGFA08XPftehv1RnRd9YAvFDcwauxgO3zWQsDgcEaXpYW1RkAW8XjbCJBK1ZdleWvgKVopRC8zE2yGx1FF+qFEKy5j4pvaIchYEHnjq5X0+QMuiKFutJ9cwEwuD0zm0S11jY6rAlkaSuMGaLcVyyj5cLQ2ZE8iDYjcdyqKu3hxB91rR2VIOGisC8+IeNaeLOXcYIDePlCWS0g1PXzAwyrfiAozTpwiJ95jVr0a2we1KL3VfyblR9l7NkW757PhK3SbKqjSQiZw5c0P+gkhGhYIw/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4IedVqsqU9V/bXe6ii9VoQ8oCO8pt61D+4JZn5UZVU=;
 b=ogOTNYcEfK+zwiJOhviUUJ7CXSocZcMfv/cnQrM/AAYJ7XqJlsQfOXBMzQ1PLt89trDyMHTCsDLoZ14YLA9NMTGNxJ3Tnf24MgEdI9g43+QJlQiPgdLra/aMbF2l5x29ubzPNZOHEQ+g9xPLxKvfsXT82BNeF3tFF7vhJfmrLhuotP0SzsosSIxtBNraYDV47CdsXTzAg5u6PtmqWyBtHK3hDiELmjDX9wshQKeKf8ztTx0a50Q6gLbG85PtsZv6VR/xSbx/F0JSb5eGBZNbV0luohDTbQ/lwUDjmisGn9xz6KfTBy+XYITcl85Kb7CLvuVn/VWnFu9W/6W5OO//mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4IedVqsqU9V/bXe6ii9VoQ8oCO8pt61D+4JZn5UZVU=;
 b=DrKIesxkwYxlL4s6O0F10I7VfhR8+xnC6M+GyKJ9Y5QvvEeGGuh3+OdqwZyqYv/SbKTaFG+e+4G46wMmJk2sxkW80iT3xs5eA7mbVm4lLPjXI7/2EA8vfjeztMD0t+GfZSAFRZACf1jVi5eEx5A/oDWrqrhi3NkG2L0Jzi0m62iJEOBrtkY7sety7YZQ218y44bgTptv7cqe0CCBM4LJzJZlrfNZ3Rf+04Md+XllbNgdNI7YLhg6opDj9nM42nRDV03SEcwOduSizyOob819L5i712MIvK4GO5f9fyqmbfckOElrn61TZz2xshZ/9E3C8zSWmio8dNxTIOYQ5O6/dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CY8PR12MB7633.namprd12.prod.outlook.com (2603:10b6:930:9c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.15; Wed, 12 Oct 2022 11:43:24 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66%5]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 11:43:24 +0000
Message-ID: <d219eb55-ebea-091e-d9b0-3881bd4525bf@nvidia.com>
Date:   Wed, 12 Oct 2022 12:43:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3] xhci: tegra: USB2 pad power controls
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>, Jim Lin <jilin@nvidia.com>
Cc:     thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
        mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221012102511.3093-1-jilin@nvidia.com>
 <Y0aikRq2Yi5kYW9j@kroah.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <Y0aikRq2Yi5kYW9j@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0148.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::12) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CY8PR12MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: 1510c9fc-759f-4f07-1d17-08daac46f852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7tLcmEGoiDYTNAKIBuGL6h6DZ97VXvmcaJrvXqLddv289e93iLFdtndZTHaWzXnA6WbLwXKttiDPj1A9rn6qDI5MxE14yyTZrHVud55DhVIl95QCuffo+rhCfwxmQM6dAm35qwBwWXAIh421B2ThNgC0wJCvohP8gDoimWUICYdyk3i06dl72IuTWy2PhdVl3fwc0l+SZvnmcNSIJ9GkadPBlYQvwcnHLWzfrRNA9A/vJ5WNOoO4b0UIdDfdZX8MSrt1udD7vVF3SF5/+jIjdkP7DDN/X632/qkdvVuhJ5Isim7wJFasIWDijH8yn8/9fUffPKOrMFefZkV2aR+nrr7FuRPZ8MpQai4sHUHAGMcTYQmO2p5Q2CwPoGpoaK0Ha2JEMEuRSZPOuCapYms4/pEfjnvw1uZXHuNAwrwShuh+1VnaPoIL3RGcYTJ9mNllP/m44oyKNKqf1GfjuL7yQKM1TwHD4ZJWrhbYkH5cvhhmKQAla8qzLoJKH3WVBMLY0euHvbq1MRQMH0RMXUpOUKzvba4y6lAtoW1uc4kEBwTClBWLkE5zvx/M6WGC1yTvRNl8YRDwZkfadppM6xD4AAcuHPRHHGh8Ur+SK7RzqyFZkeJkQu64y0u9J7+fIHD8xRqPprKUQirmHhFf27zV3F/aPtGA5dnt7PPCDCmokVuX3iTA1+PofqwulmE3et/rHt/YH58O+9ocTN7SR7dnmcW56/kNAgISIStr3GhKqkA+WYWds60ZOpJlC2Ya57DiHWwaadhD1P8TSEfCfaqeuLkoH/FPjxTbAg5mbVhImlc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(451199015)(110136005)(31686004)(66946007)(31696002)(86362001)(38100700002)(36756003)(2906002)(41300700001)(8936002)(66476007)(66556008)(8676002)(4326008)(4744005)(316002)(6666004)(5660300002)(6486002)(6512007)(478600001)(53546011)(186003)(6506007)(2616005)(6636002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWM3WFQySkhmVnREM0tWVXJXTERubnpsRURJR2ZaSXBZK3cxeU9LOU91Q09M?=
 =?utf-8?B?VzI3Njh4QUJmL2VieGRMME9mWkx4YVdPVFV4U0NkMWlnVFk1ckJPbUFnWm95?=
 =?utf-8?B?R090enJhZHEySStUVDZ5QWxtd0pNT1dyN1Y3akpaLzRZRFJ6aTZFdTEwV0h6?=
 =?utf-8?B?aXltazRVV1kzTklhbFBGNzRMT0lRSkM4cmpidFhodzQxbHFEYkJmdEJtd2ZV?=
 =?utf-8?B?UFU3NXIwUWxlVU5jbUdRZTlMRXlMSDhCVFBabUZYeG1teUdKdDFWbEhBNmx6?=
 =?utf-8?B?Y1BBcWlCcGMvVXZYN29iazA1c2c3aS9sMTBjaEVmNlJ2MzZkRFAyWGNNU1dD?=
 =?utf-8?B?bi9mVllPbEtDYVAvYUJIZUdoR2JkSy9hYWpHbzZNTHA0Qk5OMFdIRVZ4SU5L?=
 =?utf-8?B?U25lam9BZ0ZQdHF4OGpkQ01GRm1RUHdTZWNEa2swa0xZTTJITnZaYWZiNEc3?=
 =?utf-8?B?MGtoV05HY2ROTjRJMkhGbWhTS0doRWJ4MW5jMkVPeEZpRkhXWW5JdHVORmhu?=
 =?utf-8?B?dkw1S04zamlrdC9uN2xFdG9BQ2MybzNVSlpsdUxnUkZFTGY0V1dQaHNyTURk?=
 =?utf-8?B?Z3dFb0dqeE1RVDBseVJ2L3h0SDFlRFJ4ZWg4R0F1em1iNG1OdlkxYjNnZHg0?=
 =?utf-8?B?NE5xZ3N6NnpNTVE4WStyWTlRUS9iY3hENTc4OVc3TE1DUWNuWXB3bS9zdGNi?=
 =?utf-8?B?bC9oaTMrcWRDVGZ5MVZjUE4rN3FNdCtqMFFiUk1Ed3gwNGtyYnl2ZmtJUXFB?=
 =?utf-8?B?VEluSGZaU3hsNzVUUVNoRUFkOVA3T2VhLzAvZ0YxTStlcVBZRGFqVWs2SVYx?=
 =?utf-8?B?RTRhc0craHdKUmJXNnhYd0JhNEtIb2J0cUZRdW8reGkvd25FRlhxeHNXN3d1?=
 =?utf-8?B?V254UWxYSjdKaDc1K2hvRnZyTHNVMHNUNTBPTU9xY1dqM21VQng1U3E2V0Qw?=
 =?utf-8?B?NjFUOWd2OGtxZURkQkluUHp6SVFERGJNRndVOTZnM3dMRExUNFRmTFJBdXRB?=
 =?utf-8?B?WUdlZ0JxU21yUUgrbE1FVk9KeFRKU1ZhTkpPS1U0b3VucHgxWmRuSWh6cHJy?=
 =?utf-8?B?UXQyUVcwemZNSlZhTnRnVUdXWTZFYkNDZnlrYStQdWkxTkc3YlFuNzNQRE9x?=
 =?utf-8?B?a1k3UW1BUVRuL1p2Rno3V3VZUUpvc295OEdlUnhvbVplaU1QWlgvNHo1V1Ry?=
 =?utf-8?B?TU8yQll2VDlrK0FMVTFoTkVnSEdITncyZmpZdVJsQTVRSUtKRXlNOUFSbjFL?=
 =?utf-8?B?UlVrb0FNSWFVZEpWbkRUbGl5aXZKc25hbzh3MmRwZCtwSjYxWDd0N1RIaGNL?=
 =?utf-8?B?UTNmR3dzM0lvcHRTc1dSREk0THF5NHJMS0Z1N0puOEpOSExCSy9vMzVRcXRy?=
 =?utf-8?B?b0YvTng4L2c5UnFwVzg2UHVGcWxqNnE5cC9NbXRXQU5HVExaelRkSHJoZjFn?=
 =?utf-8?B?czRXZEx0aVVpajZybGg1OW5ua1g2SzhqNE5NUm93MVd2azdXWk1PQVZPbnBl?=
 =?utf-8?B?cnR3dVZpRncrM0dmSHRmaFNTTlkwWTl2MFFtUk1UVnFEeEFwcmloUHQyVElp?=
 =?utf-8?B?SExyeTQxVWtMaEFwaUV4S0c4eFRiakVILy9tWmEvMWFIVzhXaXZYeTh5SGNI?=
 =?utf-8?B?cElnbjkwL0FoVCtBVHkvVFZHM0xpTmFqNk9WTjZkMTVFVmZWVDhRR0YyQm1l?=
 =?utf-8?B?NHlpSGtlMjRTbHdZNWRLc3FBTkZUOTlSWFJ0dzE2NHdSNnBmYVJKZmZhMDd0?=
 =?utf-8?B?aFh2c2xKM3pnN2RiUlFsUGFZMCs2R2s5d3NoZTRlcFNrT2ZpNjJVc1A4OEk5?=
 =?utf-8?B?dzRNSGtlYTZGV0NDcjNoc1cvREtGUEE3SjVwTHB6TEhFdVk4MVJtTjFzK20r?=
 =?utf-8?B?ZGIvYm9pZ3Z2L3krNzF3QnNSVENQZVcyUlhvR1hBQXJrQTNqQ2hyZW9HZVAz?=
 =?utf-8?B?SG1qSHdENVRDWHhwR3FudVpSWmc1QWcwNmZuYkNDYXhFTjljOEx1aTBpUEU3?=
 =?utf-8?B?OG1vdHJkcWN6WmFMRzJScTFMTGk1R0NvQSsvbjl6eFlZUCsyelBUVjcrRVlE?=
 =?utf-8?B?aU9nV2JPeDJJSm1jOWlDOERoVm1ESjRqeEdxcmhNam8ydm9LWmhpNEQ1UWNL?=
 =?utf-8?B?RC9KS0llZHJNdTNJR3huaE8ybnd4VHlNTlRCeXhFVnMrZExaUHVpWTFJWjJY?=
 =?utf-8?B?UHNpS2xxOG5adkVEKzFIZGlFMEF1L2IxOGJOaGJEN2NESWpVSUJYV3VZY2ZX?=
 =?utf-8?B?dzhiY2JONlJ3TC9jYytSRzJ1bTJBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1510c9fc-759f-4f07-1d17-08daac46f852
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 11:43:24.3268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elQ9f1TODLUj1oSmJ0SFSwuh/rSEVQvCcjHsgFXX9e6olkdCuNFY+o5X5basp2wjfBCYmm0MBP8xMu09zk6p2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7633
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/10/2022 12:18, Greg KH wrote:
> On Wed, Oct 12, 2022 at 06:25:11PM +0800, Jim Lin wrote:
>> +static inline struct tegra_xusb *hcd_to_tegra_xusb(struct usb_hcd *hcd)
>> +{
>> +	return (struct tegra_xusb *) dev_get_drvdata(hcd->self.controller);
> 
> No need for the cast (and if there was, no need for the extra space).

May be best to drop this inline function completely and call 
dev_get_drvdata() directly. I only see it used in one place.

Jon

-- 
nvpublic
