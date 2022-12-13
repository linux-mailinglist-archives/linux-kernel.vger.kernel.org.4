Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1998364B3D9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 12:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbiLMLKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 06:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235322AbiLMLKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 06:10:02 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407A61A238
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 03:09:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHlM3NMfDPTHa00LFy8bKY80GEnPKnu0qEjiNZX5sv9h/GE2oDN6QbalaP4jyAPVaTPYWz6qLlIa66b9ShLtI7tQE9XBEqJ4VQ/OYpFuztTCZcJh6NKCq15ian+C8wFeMugo6bMmli+87FoKC9GOAiDOp90ZdMgqYaR2IXsndJx6H93ytjw09RPvXlaGyW1yDEPjHCSNYwzMoUX6/EXwB2LheChG5y0mYVPpCe4/916dujlqgaeJGZtr1t2GnDiAcP6nUTrOFpR4qWgKKaXKaC96Scy3tLA7dn6I3oK/BeQnRxt97xLAnZdnJBTD6V4VokncWbrVRZGYQbUlt/wbWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+CQFw4gCiFsmv9V5JqP1gDCqNar2O+kp8gGliZUElY=;
 b=oS+WeE4fM7G5TL2tSu1/NVYiV9M695DJSma7l6LKIS7DK/z0dg624Rj3PXqlAFPy8U8WAWNuJNSLW6/shyjJWduiKhfQyBE3uSV9fvUwZvhkIj+cFwicBAqXr9t7XgYUCKqjMs28t3fgW7IU7dPBfIQtRV6aWF7Of0OxGlaMYYvAZYyAnfZEPG1zNkf51RAQ4BSpGrKpNVYkQ7Db5QkXE6M9rX8Skr7suvaHdLvDwN7vmozztNUpr3mj1iD6NnAln0x8c9Ajx67URSYiotJm8JvZSfEVYKWkLswxdFIbrcbNTwDo9mDwwh6V3GM1YpXjtzGkNNJL0O4yxXmjtWCqHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+CQFw4gCiFsmv9V5JqP1gDCqNar2O+kp8gGliZUElY=;
 b=BBAdy+hjMXyxg93yqmPdAxBMYNfSk7h1SERnMnDB3ugnv49xqWVM30V7LXPvDTv4ossg/gOtf2MVfo5j/teQUG8bVgGWK3Gn881HcRnDinyLkaGKOi9dwg9ye0yVm5GbCC6ozLoazbsnOd7+s7TEP8LB171W7EdNGb5KY0lKw0E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20)
 by CY5PR12MB6322.namprd12.prod.outlook.com (2603:10b6:930:21::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 11:09:00 +0000
Received: from BL1PR12MB5825.namprd12.prod.outlook.com
 ([fe80::2e66:40bf:438e:74b]) by BL1PR12MB5825.namprd12.prod.outlook.com
 ([fe80::2e66:40bf:438e:74b%9]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 11:09:00 +0000
Message-ID: <4cdcf6d7-8bc3-6392-2ae6-b3faf41bec62@amd.com>
Date:   Tue, 13 Dec 2022 16:38:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] vdpasim: fix memory leak when freeing IOTLBs
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>, mst@redhat.com
Cc:     gautam.dawar@xilinx.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20221213090717.61529-1-jasowang@redhat.com>
From:   Gautam Dawar <gdawar@amd.com>
In-Reply-To: <20221213090717.61529-1-jasowang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0228.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::16) To BL1PR12MB5825.namprd12.prod.outlook.com
 (2603:10b6:208:394::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5825:EE_|CY5PR12MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: f6b47298-c50a-4267-8f38-08dadcfa6eb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hUN/a1WvRrR+qOtxK5Q/2HHaG+b96sIc99sP9cDJphBmHZYM0bD0eNObSmJRa3049xo6F/vBwzGkrvOwmidpb8WaMBHW2pCp1PRVzymo26q/RZgKLPtY729nT5FakJhLuXKGW7M0zUakLXbQB+TV5CxAEUiRoPCL1uwJWL4fR34SvCe7q1WBOu059nGVklspifHRMjKX7bMnSZaEJMjtMjmZ3vhxEAi6vNP8U6FaIBxLCkqUQ5e18Q4YmiMXEADXbJWN1bcU23s+9NcX0qtdJ95W/8osD+slAcVBkLq9v+ct9EdaMPxor2j3HaVD6edI0SDzNq1PrwRJk6kff4w/mzpaOuVoB5RLuEb08JlnTwuQjueyB7MMgz1BEudY72IXBTH+b2jlE5FMNYuFC/4zQStdBHLuuEsPnotSo6P5Na/j0as6rwcpTtUbHRMZCy9cPTDGNLbRO+fjS9p0/ZuMhfdOutpNv3lFmw01WUfFrI119fa5JP4YP/Tk/GZyvQY/vCppnVOnQ6DmoPrxFTkI3auUfP0VX7QZrWOyNFvzZgASd9T1BYalvN62WUYtLSSnNUYL7S+gwBUMH+2o2Kp/ZUYvqdNx+9yRzAxKhDas0vRetCru7C6QyVNGA/qhH8etSNh1Lqr5xmIH2RhOFO7Y5wOgqetWsoFRf6edgD8vKoXRsKc2Pa9ap0isGevlLmTg0+ZXtZai0k0tiLmzeIjvAzpzsYYdME7X8uK3zqHtPqc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5825.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199015)(31686004)(41300700001)(2906002)(38100700002)(4326008)(66556008)(66946007)(8676002)(8936002)(66476007)(316002)(26005)(53546011)(2616005)(83380400001)(6512007)(6506007)(31696002)(36756003)(5660300002)(186003)(478600001)(6666004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjRNQlpDV212VDRBUldieDh3OERBNlE5QUZRNjNZWEJVR0hjTng4QTJxUTNr?=
 =?utf-8?B?cVVRUDFwc00wMnlldnVlbDVXT241WGtlajZ4OEZoNEw1dFIzRHVLbGl1WlpN?=
 =?utf-8?B?SEhjcENxcHJjZWs2ZG0xUVBFcmRhVko1TFpCcnUvNHJseGhibkhmbW9hcVpU?=
 =?utf-8?B?SVp6NmV1SWxrd3pWSFZ3VWJuZzdxWjVseVZNRGpDdjFTZDVEbFA3akhCaUlq?=
 =?utf-8?B?Z3p4NElzL3pVVnAyYUFjaU9UQnNXbUx5RlBEVWN1NHNWTEh4Mk9mcGlIb05H?=
 =?utf-8?B?NTlUZnhHZ0dnTlhRMDJTSDJZUGpHcHNqcTJITnRnR0ZhNitkeHJkTlEvQ1Ez?=
 =?utf-8?B?aEJ2U0ozRkVTeXUyZm1sYXUyQW1KekJzNURsMDR2T3YwRFVLTlJFVkJPaWNR?=
 =?utf-8?B?Z2hKUWtwMm5BVXhGckh6MlJGakJoWXN6cjVmQjRVUGR2SjEzTlhvMmo4NVdq?=
 =?utf-8?B?d21vajZmdzFNSS8xa09SKzhDS1hRQWc2dGJweG82bVNVZXI3S2R4RkpwamNz?=
 =?utf-8?B?T2o1L0hubXI4ckFyTUFncDQydDQwdkxZY2gvUXJEcnRuV0RNeWh5Y2hNa0s5?=
 =?utf-8?B?b1JyNWdTcVVRVk1TVERLV0psb2RIQ3RFWERJWENsYVFGSDJxUjdLR29aMUUz?=
 =?utf-8?B?ZHEzdDBacFhwU2F4Z3dobzNqYVJNTDR5d3VHUGdXKytjWlBqTlZJWjVlQUtW?=
 =?utf-8?B?OEE4akRwZGtObHBRd2FRUzk1UGx2UFBMS1hMMytIYUl3Q0tUUk9oTlV5SDNK?=
 =?utf-8?B?TXVnNVZBSFdCZ1JpN0JNUzVKbnhRNDJ4eFVKSDlqQmUzVFRLcGl3NEs0VjFt?=
 =?utf-8?B?Wk9QT29BS1dGWFpuKzBlaXZDQVJGMnVLc3N3dkdzdnFodms3V2Nqak1VMHc5?=
 =?utf-8?B?clNEZUhuL0lqbldIcExraHA4Sm1ER1h5dkRQTGlXYjVMaVdYYWxWZ3dqRmdx?=
 =?utf-8?B?S0lBL25DZ2x2K1IxSlgyYTNTU2tCNmVBSEpWWHUxSzN2THVWRVNsZ1dKVkk1?=
 =?utf-8?B?ODNvbXllZzcvRllyTjBKRWxWTXVkU1FNUVlCZCtadHkvT2dtQkwxVmE3ZkR0?=
 =?utf-8?B?RHdQZWpNc0Qxb0haUS9xaU5tbEVpNm84bVdNWk1wcGppVVluLzFka3NhdlZh?=
 =?utf-8?B?dzd5dXVGRFpRTFErZnJudVZBQjFEb2UvVmtVS0NwWk5HMUc2SWEvbXlud2Z5?=
 =?utf-8?B?U3dKN1dINWowQm9BeE1PTHRlWE1idWRvNEN0dDdaaXdmWHBRRXhsMHJWZWFi?=
 =?utf-8?B?T1JUMEVNOUxpWHcyYVNaVkJGbzVESlVCUElDOWZTUWw5MkdTNC9ISVpvRS9v?=
 =?utf-8?B?MThCL0UreVB6a1VmbUFrZkNKTjBDdTdJbDRxRmpJMElES3JqS3JFdWZTUEU3?=
 =?utf-8?B?S3dubU1qWlN3Z2xuS3ZUMS81MGFhYWZhRUgzcmF4a1V1Nmx3dVpNUFE2UEpB?=
 =?utf-8?B?aktSTTZPS0p2RXVieDIrcGYrTFdYbFljUXlGZXJZbXBTY1pxcldiVEFCSVY4?=
 =?utf-8?B?NjVKMUhQZmYwRzJzYVB2VFhZa0pzTFBqN3ZUT0s3VEFnQml5RENSalJubzM2?=
 =?utf-8?B?NGdwbVdPT3VrdERNV2J2VVBKU252THVCS0Vtam9JV0F2Und0VTdKNktINURP?=
 =?utf-8?B?blZXd3JUR09CaXk0VzhWelR2ZzM1ZEVxVUpJbTRuUWxlVWhWT014U0l4NDNo?=
 =?utf-8?B?UThBVGZmRitLK2ZwbEUrQmdPN0VMMmJrVjl2VW9uYnI4L1Bhak42ODlpSWdD?=
 =?utf-8?B?dTR4TTMzMk44bmJnZ0s3T2FiVTBOVU9IajZZVWV4KzUyLzJva3ZlL0N1dmdk?=
 =?utf-8?B?dlQ4bHhReFpoSFdDYTVYdkpiamZ1SjJQMFZyNzBVVFEyUDJ5WFF4ZGVLelVO?=
 =?utf-8?B?OWNBdTk2eDJCem8wRUVuMFRrSzEzSkNSditBcm8vRTJkaDlxZG50ZWIyYVlX?=
 =?utf-8?B?VTQ5NVRUbXZQSWpocHJLcW0zNzNVVUpBT3JnNnBiRDZVR3UwYWxuMVpmLzZy?=
 =?utf-8?B?S2t4NytoSVhRNnZjTmdvbGUwNmFMNjh5UUROTlVFTVUvK3ZxOHJ1UUlmcU8x?=
 =?utf-8?B?OUVmTUFEVFB2dXdoK2dqUEh3K0hhYnhBMUQybXhKNHJCS2I1YjVDM3k1bFds?=
 =?utf-8?Q?1GVaej4v3UVilhd8djTPb5SQN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b47298-c50a-4267-8f38-08dadcfa6eb2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5825.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 11:09:00.0204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0+lEu4XOGYIIYmZ7y/0R32F1qo7bQTqIQNjiHcfUvtVYqSPOVdI8ZTXbSFdF4Gz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6322
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/13/22 14:37, Jason Wang wrote:
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
>
>
> After commit bda324fd037a ("vdpasim: control virtqueue support"),
> vdpasim->iommu became an array of IOTLB, so we should clean the
> mappings of each free one by one instead of just deleting the ranges
> in the first IOTLB which may leak maps.
>
> Fixes: bda324fd037a ("vdpasim: control virtqueue support")
> Cc: Gautam Dawar <gautam.dawar@xilinx.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index b071f0d842fb..9668dc477843 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -690,7 +690,9 @@ static void vdpasim_free(struct vdpa_device *vdpa)
>          }
>
>          kvfree(vdpasim->buffer);
> -       vhost_iotlb_free(vdpasim->iommu);
> +       for (i = 0; i < vdpasim->dev_attr.nas; i++)
> +               vhost_iotlb_reset(&vdpasim->iommu[i]);
> +       kfree(vdpasim->iommu);
>          kfree(vdpasim->vqs);
>          kfree(vdpasim->config);
>   }
> --
> 2.25.1
>
Looks good to me.

Reviewed-by: Gautam Dawar <gautam.dawar@amd.com>


