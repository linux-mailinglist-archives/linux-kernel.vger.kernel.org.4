Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA766602AE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 16:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbjAFPBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 10:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjAFPBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 10:01:23 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EC860D9;
        Fri,  6 Jan 2023 07:01:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKQN2NG56WOpkNrv8Zw/2EGV+xR1WHXlZM9IYr8iEj5UAnJRZjKz3oVxUk1xX9MrKRMErvGvBET9nWvlj5pr1D2NXC3chCu4VqqQuShbjXcJKU0bwzbupD8ob+fyOxoQJHVTpKSll9Sf/MIked5aM13F1QZYHCxb4A9Q1AgSsONi9VXzwZ/u2KUAoKyF7fkd7Um/8YWcOePkA67SYmEi9doVeaYahLltHyuzzBgsDcaeg6HBowEcnarTPTqiJjJh4bpksFR4vz3Nhqil0MHBr5xoXROKEI+FE72LRqEIjNvTOx7oowEGzcD2Toevh67BxLRZQ/OOKNJ73u5aNyD9DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeYlo5o5VsdApKtf4/xcbm4xIkobo46TOODmBCS0ZlQ=;
 b=GAm+zI8tXPW0/3izgQWHoXe1mI4cTTPGDzuAzXVzORuyeH/Ubscyxbz9bHFjsMqafaXdex5xYj3bpphEeH30cFvOd2rhvrpT2h8Jd94p0Y2ku8Q+JGyPIUoH7TYjVc8Ot4w9V4ka2f6iSUaXYg5mElQj8mwIiDfk+LgkwT+a6JS/C7xE4ePF3f6xeBwimoKPCEkZCu0Q1KZ3RZd8/vKeiSVNtYPvZUiecjNrbWzZlGbk405EjDdL0NgXrdwiI5zwp8sK5OGuiqAnG7bcDR3D3lJAc+HcHX2F6VQjhLV/x25vAQKOw6ShS4bLlZp+jWPKlc2lpXbIaLajIjn1jKwalQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeYlo5o5VsdApKtf4/xcbm4xIkobo46TOODmBCS0ZlQ=;
 b=kNIgS+cE66R0hx6XTwvMFi0AAkvtICIoy+v5RTUCzAbNaRcvxSEduKPv3Dm+NWr8gm6qHPLTY80ujbOP1Zs/PJTpLqxeMrSMZQBiZdcDorqiXABeCjLUaZKZlC8HRrYCyTOZ9T5iD/qM1jBW3w3q6WI8cyM7MZzQ8F3vjWI95lvS2TkiI2f3SfitwtdPqjEx4UILH84+VtOyjjUW2SCmJnd8yjFbmi18+PHDZGo1gHWnaKb076U+UWV0LhTq41cRKIo/FA2RNldN/fbFBaWc4FrVkDmNXpOwdeRu3FPNz6hbVwcVc6xH3QMwaHCredVooRWdRaJKeSAE4qQIkwuwkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MW4PR12MB6779.namprd12.prod.outlook.com (2603:10b6:303:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 15:01:19 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f1be:5d:f297:e2f]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f1be:5d:f297:e2f%8]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 15:01:19 +0000
Message-ID: <f2dbfe41-7164-dffa-8e9c-2d5b0f8fcae6@nvidia.com>
Date:   Fri, 6 Jan 2023 14:56:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 0/3] xhci: tegra: USB2 pad power controls
Content-Language: en-US
To:     Jim Lin <jilin@nvidia.com>, thierry.reding@gmail.com,
        gregkh@linuxfoundation.org
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20221111101813.32482-1-jilin@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20221111101813.32482-1-jilin@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::20) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|MW4PR12MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d08c0f-6913-47eb-b103-08daeff6ddec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /qjYZYenhDRiJ45AL33k6RlU/NnNEZvYXAsmWxqCt4fA0hMfZRplVgf/AGrrQO9hcFedoZzTmiI8zlSadZzwSh1Rm9Tun6iNro11up3HziQmkB/ZtsfCMEh1cD+Hm5a7Od5C0bs0TTwl0zaYGIdaYSQpSc2viRh+n1vNozUnjaAY/OYD37BijTw94e0ZRl467kk2hAa0MwGZXBi7JbANMJQEKo+k3fw+g6oL4Ptmkv4aj8EwXNWdgOrIiHjXeCotzQDBBhqhLrtL/ReUlLuKvb7VLtSSI6zqB/RYz7mbUdsN+oYxlD3yVJr9Z1f8zQVbVZvQQRO5DxdeCZ/o48SQ8HLr74eitQiMJIqn/2yYhG6eQ5dMdTN5FoJqU3XUndQm8Jb8Y0byE4bGhTeqrMYxGq6IxCyi6ZffI84WzHqdROYEsXdxtc5FYuaRG2LPocGwUZYlwerqlP8ioT/KKvkWFqtBp73/ESI/AjmXSR1u+xPFtBU1IzaCD/oJ8XRA8Py4srGaJ/Uczpto0J1o4c35FE126/zAf3gr43uMHiq2NOsWWi809LEFLAhMblx2XPXtjcbuemaLaac9fgOk8ENQZMNlY7txtHuTAJf+tagOifl//XU9MttP5LBs6txEGvchgzDxVL7D2wh3CvgyENKjJtgsc2iz6dSz2ygn0wzo28vtS8pmk2Q65o/pgkn8JdE1OhOI9hWRHdlYMeoFWa0LRNYohsxboDRkhicCUr0SEgc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199015)(186003)(83380400001)(26005)(6512007)(86362001)(31696002)(36756003)(38100700002)(2616005)(2906002)(31686004)(8676002)(4326008)(66946007)(41300700001)(4744005)(5660300002)(316002)(8936002)(6666004)(66476007)(478600001)(6486002)(53546011)(66556008)(6506007)(55236004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDlyemxEdFQ3WWZFa0plblREdFo3enBTNlZ0RzRsWG1Pa3A1Z2FjY3E0SVF1?=
 =?utf-8?B?U0dDR1czL3B0RnpTU21xcmFTZzM5UmxVZ2o2QVRIWXVwQ3V0ekc4Y2MrNlNz?=
 =?utf-8?B?bnJhVC96eDM0NHZET0l0VHNaU0ZNQ3BESEJXcnVGaXFMMmFjUDhMTlpNQjdY?=
 =?utf-8?B?OUthNERad3A5dDdsRm1kKzZLbXQzU00xTk56RHBPZkxVSUFyMlJGTlRsZEgr?=
 =?utf-8?B?VXhPK0szcS9UWjdIZFFTdWd5NHpRZkdUY3M2UEhyZWh2QlNqZzEzdjhab1I2?=
 =?utf-8?B?bTI3clY0d1ZFNU9VdDZSQmJZc0R3RG94MVF5MG94OWx3Tmp3TVBsTnlJOG9k?=
 =?utf-8?B?ZE8xOXgyd1pxQ1YyS01XWFo2K0tkbDQvR2ZkQlB6eHBUUHlwSUU5MzJqU3JH?=
 =?utf-8?B?alplZEZraWRab1hZeU9FNlMzaDAvTmVMV28xUHZNWVpxWDBxMnh6T1E0Vzkx?=
 =?utf-8?B?TXZEY2Y5MDFIZDFKMXZqdXV3dXpjaklBNDQrSmV0YmlzZkh0YUJjYWJGdjlF?=
 =?utf-8?B?b2dFbnlPSTh6dGJhcTN4eEN6ZlRkVVlMOTcyais5MlhxMU9PYkVpU1FSVWlS?=
 =?utf-8?B?eU16WSt3OW5pUWh4bWRtaXBWWm1Gc2dwOURpYnhVczhBWVc3V2U4WWlGdG8w?=
 =?utf-8?B?ckNaakxCZkdqNWVzQUVCaFFwQjlYR1JkUk9qNVlLbUluVWgwS21qdUJRdEpl?=
 =?utf-8?B?cEdrcGxSaHBqY2tmRW5QS2J0OWdUd3RONmZ3RjVqUmxzeDNIYU1kSlczM2J1?=
 =?utf-8?B?ZFJhREZ6TVZndXM3eTBZcE5ZN0loWVNZWFhvQTI5eDVHbFVDVXA4S0hmcHl4?=
 =?utf-8?B?VE56RVBIaEttYnBiRTVqOGNXVDh2eUFvZVdhUnkwZENXQU1mcksvY1JGcko3?=
 =?utf-8?B?U0JORzB6WmVZMFlCQmxCclZxeExrbkx6OVBHTzdJeXlZb0U3SkRqbTNPQW41?=
 =?utf-8?B?djB6bGUwQXVDZ0VvbGg4R1NlMkVnSDBhTWdOdm9rbk5jdHBqd09pTng1Yith?=
 =?utf-8?B?RHFBM0FrVHFDUGl4RlNHVzdNY1A4VCtlRE1RRlg3TUhUMmtqSnpjd3Q4K2dk?=
 =?utf-8?B?VjlFdEY2dWRUN0Evbm9menRQQkQzSjBvcXp0L3JUVE9EOGlTQXcxRll0eXpW?=
 =?utf-8?B?dHpuRUE4VWQyNWxzTGFMc0JtT1BPNllldE1ncmM1M2JZMWVUaWJyUVQ2MWFr?=
 =?utf-8?B?eFpFRVl5MVNMSmg3Z0tVSlZrTTFUUithWEtydDhyb05vdjI1NWdBM29xTUg0?=
 =?utf-8?B?OVV6Y1ZxNjRCRHB5NSs4T3dPM1ZObDQ0dm9vM2JmV2dlcWFBR3I2dEs2TE0x?=
 =?utf-8?B?OVBPSUdpQ1ZFUXBQWEVEM1MzRkszMm1JSTMrM3pHR1VSbytFRlJCRlJkb1VB?=
 =?utf-8?B?T0FsNWI1OVBzeVJUNzlsUDh1ZnNiRnFxVkYwcUorOS9OSGtLMGJMcmpMSmIr?=
 =?utf-8?B?MURIcGdxZCtpTEYwV3NKdE5mcXM5SnZ3TXRvTjVoUnEzaFJ2bjFUOUN6ZUZ0?=
 =?utf-8?B?dWJzT1IzUzRTNnE4UVVET0tZc3c2REFpMHdPVXo0QUoxWksrcUpVcFJIWXlD?=
 =?utf-8?B?V1NWYTRCczdoYVdFUDEzWmJ5YkNTM2xlWlkra0EvemNQNUZ6aVZkbjBVbnlx?=
 =?utf-8?B?L0oxeDZqakZaNEdNSDJrSW14dXFBWHhFL2p2cng1QWsvQ09hR01KQkRQcHAy?=
 =?utf-8?B?RHpaaXo2TU5yYkU2L2IwM0VZbjN3RDg1L2M1Wkx3dVV1TWNsYUY3ZWoxMUM2?=
 =?utf-8?B?Ny9FdHQvZjhBVUFEYW43aEdVVFdqRlEzZVJ0aTRCa1U3Y3BHLzRQdllJTXlY?=
 =?utf-8?B?WUROSjQrTFB0dnp2R3dDam5sT0xIcVdmVDlRbk1XT1ZQQWI1SjJKaWxuVi84?=
 =?utf-8?B?U2dXd1ltY04vdFJMWDJheUlhbmprUEpjTVRod2UvMU5IVXBUMm5WUTJDU3JM?=
 =?utf-8?B?TjJmVXJlYzFtMWd1OFFvNVlkOE1wYWErRjFYY0hDMy9YMTFhYmhJZFZoaENk?=
 =?utf-8?B?M1hicDE5K0hUTDZNcUpxZTZVbUR1dGVWQU5CaXhUOVFrOWdSU2RRZkFNVFVL?=
 =?utf-8?B?KzBqNTkveUJSeWlFVUV3UUwrZG11Q3orei9BS3d1OGxKRWU5SUoxT0l2MFhC?=
 =?utf-8?Q?LiqDpUybixAM2JP1vNr6iDrP1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d08c0f-6913-47eb-b103-08daeff6ddec
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 15:01:19.5302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15QQTW3fdPHARqls6EZbO5Yhfi1jZIwpT5D4hRkRjJ6tzDdG+Hi0485W5Ue510ajL4UgMg1zeeraxUPrs6Xotg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6779
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 11/11/2022 10:18, Jim Lin wrote:
> 1. Export symbol on xhci_hub_control
> 2. Add hub_control to xhci_driver_overrides
> 3. Program USB2 pad PD controls during port connect/disconnect, port
> suspend/resume, and test mode, to reduce power consumption on
> disconnect or suspend.
> 
> Patch
> xhci: tegra: USB2 pad power controls
> depends on
> xhci: hub: export symbol on xhci_hub_control
> xhci: Add hub_control to xhci_driver_overrides
> 
> Jim Lin (3):
>    xhci: Add hub_control to xhci_driver_overrides
>    xhci: hub: export symbol on xhci_hub_control
>    xhci: tegra: USB2 pad power controls
> 
>   drivers/usb/host/xhci-hub.c   |   1 +
>   drivers/usb/host/xhci-tegra.c | 125 ++++++++++++++++++++++++++++++++++
>   drivers/usb/host/xhci.c       |   2 +
>   drivers/usb/host/xhci.h       |   2 +
>   4 files changed, 130 insertions(+)
> 


I have verified that this still applies cleanly on top of -next. Please 
let us know if this can be queued up for Linux v6.3?

Thanks
Jon

-- 
nvpublic
