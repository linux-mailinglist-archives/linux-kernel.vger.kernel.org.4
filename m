Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0731750599
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjGLLIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjGLLIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:08:53 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CDA10C7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:08:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2XNdXPClpvbLpBxSi4yY/wJxyKguZ8987yZ2qCsWuONRsyTUJtDfV7xSlXJHPFgouxAmZIvSqeVQo3376HnzIn8PGjBk+FaGFm9sd/U1kdTDkVLsJ6agy95qZTXTkkERavUy+l80ElXqECideSXrjC+FBUrM/1j3spe1Z3csftiZ2oz9sfKoXTCe6coXfgXMmdmcvpUH4faAW6Pl5ythmJkotXM+7x0IHDhTeZzClVSIXvvnINXXn/VMB9DgCJP+hZTBPdkUNQd339E0p0sI9PCSLWIN8PX7zYlLVOqbNluP2G4EEC2+d+C+wzric6j4WywCd8I84y00/uF7AaVNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYdIZIQuP218xb9v1Oka4FuMoK3HwznvbnOWlAjcko4=;
 b=nHNjkUMPgroce/pLnqErqJOgDxt4WudI4xnBoswwwCVpxgSrgboHB7TgyCiSU7w5CHtKFW47K+d1yKjVkA50zw4pAd1xFWHRmkWr0L5eScKL1qRbu11WeLU8VnApmVzjdynOdn/ocw46VermR0vNeV3GhC0KcSFNl8XoLfS3sfkpPWBnt+kao8EDFnj0bRnGy6AWLSTMp7PGZgZr49JqD2wCqkh9q4EaDy0cU0yC20asgdEe5GNhT8zblJmv6w+Y9Z8/VhEjTNd576WjaTYSjB1hFXLVYzmE+z/3jJDb9Cfq34Q4+lVUvF78bSIZNYNkVGIWXJylO1dMHGHa5T95nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYdIZIQuP218xb9v1Oka4FuMoK3HwznvbnOWlAjcko4=;
 b=Nei14Xe7zHRA8e2JkHjFVVpSzy5wYH9WNg3o94qE7J4TRWZEitMZUXP1bTm+w/JT5nbMperDgF6sjY3Undka6vNsZEpk6iKREHgJRrHRb70wdCS8JBaVTZRT87nEGocCD3ZTT1WGVqLGm8ggOU/qtUpU1YCiqe+BRrDhQzHn2bM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2823.namprd12.prod.outlook.com (2603:10b6:a03:96::33)
 by DM4PR12MB6446.namprd12.prod.outlook.com (2603:10b6:8:be::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.30; Wed, 12 Jul 2023 11:08:50 +0000
Received: from BYAPR12MB2823.namprd12.prod.outlook.com
 ([fe80::38c:a382:ef01:6a93]) by BYAPR12MB2823.namprd12.prod.outlook.com
 ([fe80::38c:a382:ef01:6a93%4]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 11:08:49 +0000
Message-ID: <f3b7d7fd-2ce4-a579-0570-d55b04950140@amd.com>
Date:   Wed, 12 Jul 2023 16:38:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] ASoC: SOF: amd: refactor PSP smn_read
Content-Language: en-US
To:     "broonie@kernel.org" <broonie@kernel.org>
Cc:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "Hiregoudar, Basavaraj" <Basavaraj.Hiregoudar@amd.com>,
        "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        "kondaveeti, Arungopal" <Arungopal.kondaveeti@amd.com>,
        "Reddy, V sujith kumar" <Vsujithkumar.Reddy@amd.com>,
        "Prasad, Prasad" <venkataprasad.potturu@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Paul Olaru <paul.olaru@nxp.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230630070544.2167421-1-Mastan.Katragadda@amd.com>
 <20230630070544.2167421-2-Mastan.Katragadda@amd.com>
From:   Mastan Katragadda <mastan.katragadda@amd.com>
In-Reply-To: <20230630070544.2167421-2-Mastan.Katragadda@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::21) To BYAPR12MB2823.namprd12.prod.outlook.com
 (2603:10b6:a03:96::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2823:EE_|DM4PR12MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: 196353b8-269e-4519-88f9-08db82c85e04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wnPUMez/JXVwGr1FT+BwoC2dXJMyFzj2uk4Xdl9jUKYuD7h9Di8v/92/yrkqG6lLjtU+zXM0KW0Et+rcLZs5lsXKnT6WxvhhsL1YSqr4wUy8C9qeC2A6RtXRYLwhtHo6wTIYjKuel04OcM2rFa58x/mY9MqI5x9QNBo4NPb+w6GYupVtSfJCnK7rBfgqhovyrlcgFKwhE6uDH494BvF3P6u8Is87Ld73WQbeKdCUVFenUfS6KAH1pV39EYHdo1Z5b3fNhPHMr8/b1q5IfiOK1dRPajgqbooZoYnj9vMTfDcdf3iaPZgOYw0Coc3oPnNrJ+CwvkBhJutKJ5ALgEYck62l3jJTVMy8S/0LGzjKRafI3X8EiY5VaETOD/k1oEZCqWceq8p/fvp+9psw9mqJeXbLF11WOi9xfQkGSfJqLogDQd8Oyz6FiPfeq4aEbW3XqEp63yUGT5YyGG4B+dHBpNeica7ATrEzp/GXVoUwAGVp6+UsswGkyR66a55yLbcTu9bguOoP7r0VjHjGWLj//uf8DN4S8MkWpBg3vOe8Z55QlnICJE4tV1XqetOLs+AYHUAZp0Yw3w0aFW4AbOA4nEclFuv1sqFI32zr90hnSCNj6xAm14NmcbdhC4PzMUzo6/u8P5SuUd4wlz8ajPD5kQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(186003)(26005)(6512007)(53546011)(2616005)(6506007)(5660300002)(83380400001)(4326008)(44832011)(8936002)(478600001)(41300700001)(6916009)(2906002)(66556008)(316002)(66946007)(66476007)(8676002)(7416002)(54906003)(36756003)(6666004)(6486002)(38100700002)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkpvMm9QWEE2bFVzRTFhU0hXbnpsNHpYMzBMcldXMUxsQUJLTjEzNDhOcS9T?=
 =?utf-8?B?dWRTSlZRb1l3WWpkTE85MVJGeVFBK0NqY1M2RTR2NlRYSzZoOCtqckwzNHll?=
 =?utf-8?B?QWgzV2loaCs5c3NQWXgySWRSY3FQdnZDZ3FmeEpQcFl0RjROWGJKSTRudm1J?=
 =?utf-8?B?Z3NLS0JNKzh5aE9aNUpYWWYwRDJDeWVjQitHVGl5cHNDa21uSlJJZGY5cGJG?=
 =?utf-8?B?aU52N0diV2hOUnBaMzZncm1taSt1UDJVQnRTYmxna2VWVWNSWkhmSXVBaHQy?=
 =?utf-8?B?d1YrdjN0Rlc5UWtPVUwvcHBIb3VVZ0hmR2JUeVQ0ZGI3bzBCMmR2elFZMmli?=
 =?utf-8?B?ZEJpL3IxQjcrazRwN0FKWTQ1WkEzMVNtaDNCWnRYbkxZMjhRNStNaThWNGRl?=
 =?utf-8?B?T2dKblVWcmN2eW5pV0VPSGUrVzJnMzQxWXRzZGl3Wmo3QTlrWW5DeTdhWWla?=
 =?utf-8?B?SWJJMzJoSUhLRGZyb1NKOXkxVXFxRFF6YXEvQktBbStxOWV3aTB5WWZMM2w4?=
 =?utf-8?B?RWt2TkRnVllnM29WS25PTjBrRFNiNnN1aXoza0FkQmxZdWJqaTcrMFE0SFIz?=
 =?utf-8?B?M3Q1NGozU2RjY3BmNnVYWDRON2laZnNSUVhZMkp4cENRUlZXWlFJbFlVbHUr?=
 =?utf-8?B?Y0pXTXV1SHJuaTdLc2RiM0V4SkNPbi9HSkFhcUpCcmNYNkRQaW9IbGtWam1u?=
 =?utf-8?B?WDBZcW00YlFLeGMwa25EYkw5dDBDWWxDRGphL293N2JrYmp0NWZPR0hIZXQv?=
 =?utf-8?B?SWdZU2tkbjNrb3IxenV2dmZUNnJGRkd2cWtEcTlCclZ0RUh4RjF1L1J1NHFY?=
 =?utf-8?B?VHhZWjJLMFdXb2sxZStzTWJYRGFCQ05DMmVOVWdxSUVqU2I1QWZjRnBINXZQ?=
 =?utf-8?B?R1Vld3pUMVUrNEd0bnQrZUtBUWJ0VjUrajBYOUxDZzdIdEpWa0hGTXR1Q2kx?=
 =?utf-8?B?OFY5dklSUGtLUHpkSmcxZWhTdVlUbkRpODZJQWp0ZVlUWi8zbkgvNW5Ocnkx?=
 =?utf-8?B?ZmtBeml0VlVPbWJuSlVUZ0NMV0x2dE9yUnVGd0JGaUJsOHoyQXVBeFVwVUVz?=
 =?utf-8?B?UitqZzNrV0JIZVF0SjFMRDRkdmFQQXJHYzN0SklGS3dOR3YrNVM4bTdwNnhP?=
 =?utf-8?B?aS9LYzNYZUs3RDU5UVFac2FDa3U5M1pCNXI0RXZrekt3clBtZXd0Um5aME5l?=
 =?utf-8?B?UC9vWEg2MzUxQ09meUhTUlVmK3Z6d1RiNURzTVdYN2puZUp2QWF3K1BkZ2dX?=
 =?utf-8?B?dUFjbllDdC8wN2NwOTFjWEJ4NnFWM2Vvdk1BV3RnNzBrdzU0YjJhVjJKL1RQ?=
 =?utf-8?B?RHVlQkFRWmVtRldFSWRKU1dQTlFhYzhVTXV1bVpYSjlhalFWVG1DMGxQbndq?=
 =?utf-8?B?U2V0WTBnaWJPQ0RQK1dMcmNzeUo5UzhCbW0vcm4ySm1BRnBLTzBWcGJ2MlFL?=
 =?utf-8?B?MW9jdzRCMWdMVnBNN25IaGprNEdjb3NjN0pKNy9CYTRmSkVkbWlyam0rOE4z?=
 =?utf-8?B?eXc2a0ZoK3NxM0hwTDQwL0VKWUNsK1BMWTdQWFpFaU1mYTM0MXB5K0lSazgv?=
 =?utf-8?B?TVczSU92VlFUUDg3QkU4SXpkc3JHcm9PWGJ1Uy8wVDRyM1poMFJmQStQUFkr?=
 =?utf-8?B?cjBIdGoxZ0dHeG5nR3liRVhhTjBSRFM5cFBVQ2loZFlRaXNIYW9NakV2dU1H?=
 =?utf-8?B?amtuYU9oUkc3ZHBsQ1ZuL0VsVGQxZDYvWDd4U2VYMlpPZ1FIS0RuUkFKNHRq?=
 =?utf-8?B?QlFEM05NdzBvanVhalFlMW13OGxabDBUNUJIM2hEWWpkemdOUXluQmRudEFS?=
 =?utf-8?B?aVd0Z3d3N2hXYndWeDRKTWs3RzZhVmY2c1VLcVVaU002OWEzd29zQWdicVgw?=
 =?utf-8?B?aitaTGN4QjJQOGlyeGpJRFd2eUtzVWNXR0g5UWVUQTdOcDd4cVhRVHJkUDRN?=
 =?utf-8?B?dFBIaGRPSHI0S2xFYW1oN0EzTE45Smdsc1I4UC9OYTRrOTYvalJqcFFpUm5v?=
 =?utf-8?B?QURrSmFCcG54MXIzWFVPZnduMFh5cjB6V00wS1M5b3drK3RqL21vc3VUY0xG?=
 =?utf-8?B?WlJDbEJVcVJtd01zRXFFMGJhR1NLZWdxbXVZK2l2TjV3bnBXcXpMMm53UllO?=
 =?utf-8?Q?MGS43aPb6cw3AeTvCHL33Ndxl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 196353b8-269e-4519-88f9-08db82c85e04
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 11:08:48.9435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z7k7zUSMHemWiYsJd03BOMKaD1hSeBSV50esZEE/Znzwtfc1HHvW8/cQPhQn0Z5QMwWy3QByI4h+DZDBAZPyxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6446
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/06/23 12:35, Mastan Katragadda wrote:
> Use the read_poll_timeout marco for PSP smn_read calls.
This patch has not been merged.
>
> Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
> ---
>   sound/soc/sof/amd/acp.c | 34 +++++++++++++++-------------------
>   sound/soc/sof/amd/acp.h |  4 ++--
>   2 files changed, 17 insertions(+), 21 deletions(-)
>
> diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
> index afb505461ea1..c450931ae77e 100644
> --- a/sound/soc/sof/amd/acp.c
> +++ b/sound/soc/sof/amd/acp.c
> @@ -28,12 +28,14 @@ static int smn_write(struct pci_dev *dev, u32 smn_addr, u32 data)
>   	return 0;
>   }
>   
> -static int smn_read(struct pci_dev *dev, u32 smn_addr, u32 *data)
> +static int smn_read(struct pci_dev *dev, u32 smn_addr)
>   {
> +	u32 data = 0;
> +
>   	pci_write_config_dword(dev, 0x60, smn_addr);
> -	pci_read_config_dword(dev, 0x64, data);
> +	pci_read_config_dword(dev, 0x64, &data);
>   
> -	return 0;
> +	return data;
>   }
>   
>   static void init_dma_descriptor(struct acp_dev_data *adata)
> @@ -150,15 +152,13 @@ int configure_and_run_dma(struct acp_dev_data *adata, unsigned int src_addr,
>   static int psp_mbox_ready(struct acp_dev_data *adata, bool ack)
>   {
>   	struct snd_sof_dev *sdev = adata->dev;
> -	int timeout;
> +	int ret;
>   	u32 data;
>   
> -	for (timeout = ACP_PSP_TIMEOUT_COUNTER; timeout > 0; timeout--) {
> -		msleep(20);
> -		smn_read(adata->smn_dev, MP0_C2PMSG_114_REG, &data);
> -		if (data & MBOX_READY_MASK)
> -			return 0;
> -	}
> +	ret = read_poll_timeout(smn_read, data, data & MBOX_READY_MASK, MBOX_DELAY_US,
> +				ACP_PSP_TIMEOUT_US, false, adata->smn_dev, MP0_C2PMSG_114_REG);
> +	if (!ret)
> +		return 0;
>   
>   	dev_err(sdev->dev, "PSP error status %x\n", data & MBOX_STATUS_MASK);
>   
> @@ -177,23 +177,19 @@ static int psp_mbox_ready(struct acp_dev_data *adata, bool ack)
>   static int psp_send_cmd(struct acp_dev_data *adata, int cmd)
>   {
>   	struct snd_sof_dev *sdev = adata->dev;
> -	int ret, timeout;
> +	int ret;
>   	u32 data;
>   
>   	if (!cmd)
>   		return -EINVAL;
>   
>   	/* Get a non-zero Doorbell value from PSP */
> -	for (timeout = ACP_PSP_TIMEOUT_COUNTER; timeout > 0; timeout--) {
> -		msleep(MBOX_DELAY);
> -		smn_read(adata->smn_dev, MP0_C2PMSG_73_REG, &data);
> -		if (data)
> -			break;
> -	}
> +	ret = read_poll_timeout(smn_read, data, data, MBOX_DELAY_US, ACP_PSP_TIMEOUT_US, false,
> +				adata->smn_dev, MP0_C2PMSG_73_REG);
>   
> -	if (!timeout) {
> +	if (ret) {
>   		dev_err(sdev->dev, "Failed to get Doorbell from MBOX %x\n", MP0_C2PMSG_73_REG);
> -		return -EINVAL;
> +		return ret;
>   	}
>   
>   	/* Check if PSP is ready for new command */
> diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
> index dc624f727aa3..c3659dbc3745 100644
> --- a/sound/soc/sof/amd/acp.h
> +++ b/sound/soc/sof/amd/acp.h
> @@ -61,12 +61,12 @@
>   #define HOST_BRIDGE_CZN				0x1630
>   #define HOST_BRIDGE_RMB				0x14B5
>   #define ACP_SHA_STAT				0x8000
> -#define ACP_PSP_TIMEOUT_COUNTER			5
> +#define ACP_PSP_TIMEOUT_US			1000000
>   #define ACP_EXT_INTR_ERROR_STAT			0x20000000
>   #define MP0_C2PMSG_114_REG			0x3810AC8
>   #define MP0_C2PMSG_73_REG			0x3810A24
>   #define MBOX_ACP_SHA_DMA_COMMAND		0x70000
> -#define MBOX_DELAY				1000
> +#define MBOX_DELAY_US				1000
>   #define MBOX_READY_MASK				0x80000000
>   #define MBOX_STATUS_MASK			0xFFFF
>   
