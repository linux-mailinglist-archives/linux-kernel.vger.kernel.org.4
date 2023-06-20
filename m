Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD02B736DED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbjFTNws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjFTNwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:52:39 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B791BF6;
        Tue, 20 Jun 2023 06:52:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+faWJ0gdeQfFaa5s1p7aKeU0hDmv0e5iVFr7/RplIcvs6kzCaFBCoBApAcSqFzRzc+rmlXy4xig9sFSldA2KmM065KlbKYEJ58LZhvnsCLJKBdBr9voKrXw6IpVJ2mrCSiSk5eOJWi6a4z284gaKyZ6pmrRxOZrnDZOiegMvjGui9wRwAhVjEKYrUXDd7V1lUOWbJgkLShuG3kypvVhB1/WzYYTE1wvT+jLVervmpZyl0q6ljxLd/dTlcl8rqUN1Z58iZuUoblrATspi1zMcllhaJBgpGGWywSkF0VXNt12Dz1VGWsDqvNhocDXxb3HcotGbuJtkhHe4W2dMz+g5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQ//wvzEhWeVzUeWpIxwrhQMzhRn0n8kifcvYP05n2g=;
 b=JCMLlxM4GEstYq6/vmz5jZYsNSyxQ++TdeHNXF14TEOymUMEylcH8sUscuJFKY89pqZ/M4Q3JsmEFVuDM+p0Pe5TZy3SDPpYEcXtiSKahrF4AQ8RTRDwDUCMnVz+Rua8FvK/SWrrt2vrBnVyy8NW+Q6fdzuzdz5ZoHSgBHc3Nj4F8UQkMZPLUk/902rhZZS302XSx+vJLnNtgWsYPq7FPTonbcAbisUTk1qTcjBO/R/Z+kHm0rrvuGsor9mofDQ36wI85gmO3wzPokjG8cu5hGslBpeUnEPWzyR2Hbng/kkU42W/lNUvUjPY8ny2XsHVivDyY3WZag1KSUsM5ynKag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQ//wvzEhWeVzUeWpIxwrhQMzhRn0n8kifcvYP05n2g=;
 b=krsxcD17/T9QGLcA7Yk9hf2lS12z8bDEYsBb6n4qEqDur5xkSSl5QhL8w1cQidnED8Fn/6awx9qBNZ4q7GrKyMJZi41cGI5vDf91ipvSFJ9fBc6Ln3ZlNcnclHluSnps3/vkg9mFTPHG8lKHG4MuV/Y2R7EAJ46k++1Ntx99a9gQvQQGWVg/9d1pVxVhojHNk8QHi6Vhz1lcUkC+bRixXnRrgj2ne+mYohRe6mp1z72TxDhxdTBGdmbN7iTa3OpOE7v6IKNxg7v9txpd0La7xFbY16PgqQlHY12XDh+q6wR1OL9L2Qm5lnXusMjTdRjC5kTvA7wWH6619w/9y5fpew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 LV3PR12MB9236.namprd12.prod.outlook.com (2603:10b6:408:1a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 13:51:38 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::21ef:9d59:5b2d:f1e8]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::21ef:9d59:5b2d:f1e8%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 13:51:38 +0000
Message-ID: <638b51fe-da91-483d-9f84-147226fd895d@nvidia.com>
Date:   Tue, 20 Jun 2023 14:51:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] phy: tegra: xusb: Clear the driver reference in
 usb-phy dev
Content-Language: en-US
To:     Haotien Hsu <haotienh@nvidia.com>, Vinod Koul <vkoul@kernel.org>
Cc:     Wayne Chang <waynec@nvidia.com>, EJ Hsu <ejh@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
References: <20230609062932.3276509-1-haotienh@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20230609062932.3276509-1-haotienh@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0279.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::14) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|LV3PR12MB9236:EE_
X-MS-Office365-Filtering-Correlation-Id: 80f2befc-85b0-4bbf-16d3-08db719577ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S8C2XVNzaq5n++HSMAN49lJMMpdHym3AVO5Ozkc5yusQfREVfONh6QEOy51pznqAqPve1tmN+1w4XhUxNHfy0uF6Yl8KQUp7fKmRds83P/kOULSh3Gj6bY7q7tpsTOf9l0a+qVd3HZDbNCIGrjHpUstYwtt38BseA/CFlV4HGuh0fJvMRYQ75LqRsYmh7ajbyeKp0LxCJDiMyEGCmh49s5RhAni2WolPLVnnTTZtRksMkSq+MElqqmHCXjpRk6rFecHexV2zEGx6lIeU/irBkYSkaLlGChNn+p4x0iBRgvClLYlrVcvmuDU49OOg1vfW4eoSoL1feeO4z6rksXUCltMxYHfhfUvn2sLxk5S3HbMQRf4Va2nLTEOJZOwASaStT4jJL9JmZ9zB3MVECkiaQwCSP2YqVBIcHS+2zEChIy2PCz8wIJFj7U13cSIfWOMqxAfEIdeNqAE5Lr0GAg7ZJo7Xb02cL4TcfYqcuxBP1qfCnwBe0STxbw5idmLS9YLDDG0DE+7RgLQoKa2sKlPTz/iIYdkdMTLOsBOfLDMD7UOZkcT1ycQHlL/2hcLERvCmfM/NeWXgZKezxkjVlCFH/lEwW3ZM9Cc14YXI+4eTiAubbF0xy9vQNSTVKEQhK+A4LwL2S3vpJOx4tfqdgJuFbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199021)(478600001)(4326008)(54906003)(110136005)(26005)(6512007)(55236004)(36756003)(186003)(6506007)(53546011)(6486002)(6666004)(2906002)(8676002)(41300700001)(8936002)(66946007)(66556008)(66476007)(316002)(5660300002)(86362001)(31696002)(83380400001)(38100700002)(31686004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjQ1SW1jandzN3BrcTZCUWtoWXJVYmZaZ04vMFExNlI2NlJ2WStHN3RaQWVw?=
 =?utf-8?B?WnI0c3BLOGNrMFNNdTU2MzVRUHdpTjdiMkg1Q1lHL3F6dGsyY2RDaFp4cU04?=
 =?utf-8?B?VnZxMmZoY3RXV0xFdEVqYm5QdkROYjk4SnUrZnlBaWZVNFcyVUhwY29LNGJa?=
 =?utf-8?B?dVZFbUxhN0tJazVlZksrOGdkSG9sZEdqeEpMWXkxdklFbW5nV2dsbEY5ZUVw?=
 =?utf-8?B?Y1E3KzBVQy9wcStRMGtIdTQ1RzhuTGk4dTEyNXFGUFlOcEtPUDY0eldjeUhi?=
 =?utf-8?B?Vncwekc3ZE9xWk9hMEpXa1pJazFMTjM4MFlobWdOSCtqb2JSU1ljdDU0M0Js?=
 =?utf-8?B?QnAyRWF0bmZEYXVPbFp6Yjg3S2tWdnVkaUNGSHExS3RSeGJNa2YrRXBMOHhr?=
 =?utf-8?B?TEhScWFlM2VMY1BLUlFHajFiSGpZUUFTUk0zb2lyUkhvNlBqU2pSMW9OOG5B?=
 =?utf-8?B?dXFNM0R0R1U3cHh3dUV2ZEFoME45VUpjYjNXeG5MbEQxeWNsWUlDVTRWUmph?=
 =?utf-8?B?NlZGNXRWaHp4MVVhcWVueTkxSUxaY3pUMlFUR0lrZDhZQytUQ1ZkaGhEZVpJ?=
 =?utf-8?B?TUJhclJLZ0xyS0Q5cUY3VmtlRXVlUVFHSzlrNHp3TmM2TWtyU1VmaEc1b1JZ?=
 =?utf-8?B?RWpTZUlSM0t3byszR2NtWlI4SHZ6dlMxTHRtYzJvYkVtTGpMd2NzeHNpZUY4?=
 =?utf-8?B?VWNVR09ZK0cvdkRVMU8xZUpHOUExdmJIWVJOQzd6VkRKQm93cUVDYWVBaEsw?=
 =?utf-8?B?OVJFQ2xUbnNPNTV5ODVzN1lwUXBtQjI1aGVwOEhKRGgvWi81MG10dmgxWUVu?=
 =?utf-8?B?d0VrTTNiMFpMZXR4WDBoK0xtaUFOM1lQY3E0RWJCZ0xpM0ZRcG1LeW9oTlJV?=
 =?utf-8?B?SmcyZldNZi9CWEtadTQzRFM5WnI0cXJGOFAvbE04TGlZZzVPYzk0N0xJOUVE?=
 =?utf-8?B?Vm5zR1k5V21RQ2dBM0JRQTYza0Y2U043VUxSQkNHdnFTS2sxV1p2UXhnZmVN?=
 =?utf-8?B?RExsN1R1aU92T0gzamlsY0VYbnZreGxUL2Nmd0hNR3M1VElEaDRwcGFBOGhi?=
 =?utf-8?B?bXNlRVljUHFKTFhsOFVjSFAwU2RXdWIvbGJMZDd0Y2ZmWXg5dkxlZngzcGFh?=
 =?utf-8?B?Rm9KZys2T3VPemxycVFJaHVtZHhrbndnV1RIc3RzbzlVcXd5RVF5V1lseGFK?=
 =?utf-8?B?RFUwNmk3ckg2a3lTQ20ySkVBaFdlYTNWN2x6Rks1Q2U1aVpIcVI3Wld5b1Jv?=
 =?utf-8?B?YUQrWVJINjVmaXhyZjNsQTJEeW1Md3ZlVjdwTGN4M0FzQnFhT3dpNnBzRFBN?=
 =?utf-8?B?OXJLSkZNVU02c3NzdElJWWhiWjg3QmR5SkQ5Zm9NaVpCYnR3U0hldXhVVjM2?=
 =?utf-8?B?dFl5Z0Ryc1NqcW95NFFQSnR4R3ZINFpCWEJoV0lQMjlRV1MvY2xtRURmbE53?=
 =?utf-8?B?R2JWNGRKTHNIMTFzUytNZWplZGMrRnNjTXZRek9PbTVJc3F4L2xtcU9OODFC?=
 =?utf-8?B?UzhIclJTSk92TTZmQ2oyN0JtaGtNUVRiQmJkQU5FSWExd2d0WGhFeFk0V0Ey?=
 =?utf-8?B?RFpMZFNBaGcxbndPb3Qxa05tZm8zbHhrMUZHeXAyY2s1M2JVOTU5T2pRdFZj?=
 =?utf-8?B?TW1MZUhhek1ZeXpmVEYzK3hDZkViQWtWejg4VnRESzRqODRnRk9KNXpXdU5u?=
 =?utf-8?B?MFVwVE5DZVBrR2RiTDhCaC9JaENwbDJxNnVUSVRoRjlVVlVPZGZOMk03Qzhh?=
 =?utf-8?B?Z1N5dDJzSEp3VGF1SmZMejdzcHRoZTBlUkQ2R0F3bXdiRVUvd0NaaStlWCtF?=
 =?utf-8?B?OTFmTStkVTZqUi9PVitNbWNXMVEwczg1ZTMrS00zMGV2UkF5Q0VLUXpVdmdP?=
 =?utf-8?B?MmE2OFRhL0owV0Z3b3U5T0FGWkhtSW03dlkwTGpKa3lHTHNFQzhhSTVnRXA4?=
 =?utf-8?B?blNnMEdqRE9UYWo3VTVLQ0tuSXI4d1hzRWkrRU9wS3BKSGFKd3NrdDlMak44?=
 =?utf-8?B?VlM2dHd3S29WWGxEQlJGaXZ2blNINXNJRlMwcHNUMWFERkFkSW9pTEIzbGRU?=
 =?utf-8?B?RDJNM0laTjhBdXVJcjl6MXZKNFdiN0pURlBDZnNJT0xYcWZxMEViOWltUlN4?=
 =?utf-8?B?N2RxOWplMzlteUVHa051UXFTY3hHVGJRUGtGMnVKUFdud2ZNYTFTY1dmdzI4?=
 =?utf-8?B?S2c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f2befc-85b0-4bbf-16d3-08db719577ec
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 13:51:38.2113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fcfEh0jLrDqqQlOKxaTmznuLLvqShIHX32S/ClqSUKyewxHs3jFjv/IqRnbMt1X5AMEnuhWGWNlpnnTNC6FqWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9236
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 09/06/2023 07:29, Haotien Hsu wrote:
> From: EJ Hsu <ejh@nvidia.com>
> 
> For the dual-role port, it will assign the phy dev to usb-phy dev and
> use the port dev driver as the dev driver of usb-phy.
> 
> When we try to destroy the port dev, it will destroy its dev driver
> as well. But we did not remove the reference from usb-phy dev. This
> might cause the use-after-free issue in KASAN.
> 
> Fixes: e8f7d2f409a1 ("phy: tegra: xusb: Add usb-phy support")
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: EJ Hsu <ejh@nvidia.com>
> Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> V1 -> V2: Remove extra movements to clarify the change
> V2 -> V3: Update patch title
> ---
>   drivers/phy/tegra/xusb.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> index 78045bd6c214..26b66a668f3b 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -568,6 +568,7 @@ static void tegra_xusb_port_unregister(struct tegra_xusb_port *port)
>   		usb_role_switch_unregister(port->usb_role_sw);
>   		cancel_work_sync(&port->usb_phy_work);
>   		usb_remove_phy(&port->usb_phy);
> +		port->usb_phy.dev->driver = NULL;
>   	}
>   
>   	if (port->ops->remove)


OK to pick this up now?

Thanks
Jon

-- 
nvpublic
