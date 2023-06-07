Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1DF7254DA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbjFGGyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238240AbjFGGyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:54:39 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3131732
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 23:54:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMVSduP8eGT0MxnLr/QLQPLtxC4itkQ/XHQl4oRLBPMFEJRGLQRv6uZ8zfifFiNuYhSB3x12qgOaB4ped0TVHENOChsINUHZ7N1MsCZsN9fftEKHwRzQ/Z+qEgxVl19XIkfdYsnMaO/8fyoJTxknqKIvCErEEWs8HcFbjYlxrBpobzolIbGfwmDuE97Zupa5qaWEx5Yk79APYn6jJzXMjJLR4XbsUNqcdE2J8SFmg+N5L4EGp4W8MbgajFTFCE+01NV0VthMKLHw2z1jqYKN+1bAPGu/xDeB8fHNeDuRVOTZ3Nu8EFnEZRfRBrSiJ97uUWL2amUWjpMBksVOpcpVSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OklhDx3O48TLC6piVQfQ+mDYhqXwP5LOZkiE6YcWWvE=;
 b=RzdDC/a7PFtJAQLBqshF812Cc5vbDvQ85/ZoMwgwgjmNtMKfxg0JHd1mHEY+TDFThkaUIPrpohmlum/0s4sAfdJV4lqNxv4qfZLPXOD/xlE3YfcDm0N6IzSanK8Cl5Lt7NjU0iBhtyoVS0MJ8Z6GpZj+EL4CrnVchxteTUrFldHoTMIvknTqETE6U+M2+A7KQiQ/NSaFdgrYVUHOJXsdiasIWbndYIKc9GwYRqyQWX1NvLd2MCKPtlQYnUbNEFHaDRyVjJ7dVNL6MjtoYDxM8gurZRfsYbczfs3iDPBnKrG/9c5a+Jj39S3UuKRzSrj6YxHmx3cJV9ZEe6DtwMs3uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OklhDx3O48TLC6piVQfQ+mDYhqXwP5LOZkiE6YcWWvE=;
 b=sOKhNGjA14ijtb0N1lpLr+lzyzItgjzMY3fSa77nyj6kikYb8TNYA6o5Hq6iZeP45wl+3DVzLnQ8uI79GBFDiM/zUq8BRQARZyg174OIKbrSZ2XnkW5SBlzRvQ6iECPrRx1HEahs4q6QssJYB2Nvi/Z8CE6DvT/YhmsptqQfOEU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DS0PR12MB6584.namprd12.prod.outlook.com (2603:10b6:8:d0::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Wed, 7 Jun 2023 06:54:30 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8760:2e89:1243:2b5d]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8760:2e89:1243:2b5d%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 06:54:30 +0000
Message-ID: <38044626-ec8d-7841-01dc-f062eff8451a@amd.com>
Date:   Wed, 7 Jun 2023 12:29:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V3 9/9] ASoC: amd: ps: Add SoundWire specific checks in
 pci driver in pm ops.
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, mario.limonciello@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230606060724.2038680-1-Vijendar.Mukunda@amd.com>
 <20230606060724.2038680-10-Vijendar.Mukunda@amd.com>
 <b9487589-7149-cdbe-59f3-d5279f25b02e@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <b9487589-7149-cdbe-59f3-d5279f25b02e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::7) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|DS0PR12MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: f1750dfa-fb03-4e12-f0b5-08db67240b1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GFrEyT0EUD0mYnQteBZ3KBtKbRRh3ndudIp4lV2xH/8/RXN6+aiGiGDKiJEKp0zGhuCjznaRY6XTcRfm/6lHMXLSteydTDDNzMnQJtvfLm5eM/KOTD4hOUFmnHQu9eCelaIVO53qkBVylhqbfqQExeICahISx1IwjBQrr7CoGx8fn6jwGxoaMrOonDjMsKZlpi9AiPcX+QQZiWXf+WD40CrAS6M6rSayaGzbssjvldtQW9QOpe3PoUnW/j56OZLbW//Bhm/n/CUZaMdEiWlZ8eQVkNp6wXgO9e4svDzCqUfyYq+K6YGZjj+KIb/CtAVePmKWTSS5SMl2vgB5KratNMJw216n/x79db+X1kxRB1FgqJ9XRXXMa25JfryqpRbcpKvpvo17xbhAMBM4x5tsJXcs0ianB+AGA2FLWFmLx/VxWHICtmcgGVxRAUwJDm7qyJgZcLaNHsFTl+7pC+zwCcrZJydH18yUaBi/szxt7t77B2m9jYdP3eTNUgoSxJMXdpe8QPTEiaaQ1XcTaOLKZk6JN+GAN26Q9duJGffPkJqInGW33sQ4HGe5yuYsT+de4+IBjryzNC73tIhbOiP6Nj1JApr3yX4Lu8LP5hfimf/L7iBkK5JSOUBVpiNfawE02Hg5bRN9XHgs6tMysb7/EA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199021)(54906003)(478600001)(5660300002)(8676002)(8936002)(4326008)(66946007)(66556008)(66476007)(316002)(41300700001)(38100700002)(2616005)(186003)(83380400001)(6486002)(6666004)(53546011)(6512007)(6506007)(26005)(31696002)(86362001)(36756003)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFo4bWl5WXRWa1pHVDJzUkViRllyVXFraFlyMGlSRi8zUEZRNDlISmlrYjEw?=
 =?utf-8?B?QVUxNVYwQVRDandQc1ltdm9qbzBVUjF4c3I0WndiWW84RzZodERJbnZ6Z2oy?=
 =?utf-8?B?N05zbEtNZ1hTTm40d1ZUbCtObnQ0Qzg3bmxTQXJNOEZpTTVIb2tlTUF2clBx?=
 =?utf-8?B?Y1k0aDE0UW5TeXlrWmsxeXdHcFBNb2VjUmVUaXQzcEljUkQycm1SQkRJU1hY?=
 =?utf-8?B?Q3VoTmZvRGVtTGdMblc4U2dObnV4d1dnS2xLdGNJaFk5Smp0QjM0L2RPNjdV?=
 =?utf-8?B?NnVvWmFWRGRqMnMxYW9xUnhpR3gxRW9KZVVJSWE2a1B0VmtzV2k3TkNnYTV3?=
 =?utf-8?B?STFDWmtDZVRwTS8vTFc5bEMxV0NVLzFEczBqZ04wbGxGSnhNZVVkLzhEYmw4?=
 =?utf-8?B?TWtoY0wwL0I1U0ZSa1p1L2lVTzRKOS85M1lxWG5mU1JYTnRTdmt1dk5yaVRr?=
 =?utf-8?B?YlRCSUZ2T3VUWVhJSXVNUnkyVTlpZVkzOFNmdWc0bWNuM1pabm41RUd4WnVW?=
 =?utf-8?B?WFJ5emRtcVNhMVRKQ09TU0VOa3lncWVtY2tEcUtWaW8vOHdVRytNT2tqL3Jn?=
 =?utf-8?B?dG9URE52UTNuMi95dUx3UmlzRW1uTFJ6UzFSNEM2c21scXc2WkhWcjU2QUZJ?=
 =?utf-8?B?blpXTnZTQzJOTDJaTmtUVTh2MGRoRHdmeUg5OHkyaVlGS3NQNm1LbWxacUZz?=
 =?utf-8?B?SExyYTVGZEVTR0dKS2pRdmVwSmZJMzB6OGVXM0htbC9iOVA4T1NXd1hYRC9W?=
 =?utf-8?B?cjNvdTI4T3VGL2NmaTVNY2o2UWZsZjR1UGw5c245WTBYYjhpUjBPc0RWbXZz?=
 =?utf-8?B?MUt1VXZPZDN3QzNCQkREWU8xN2ZJcEpYK3VWOVY2d0pjSHlReW45Qks3cm9M?=
 =?utf-8?B?YzB1TUpOVGtzOExCcnc3L3lYakM3a0N2SjN5Y1lSMFNBbzFOV2dTK2toR3Yz?=
 =?utf-8?B?YnA2NHdVMGJKZFVyeUp6TlV2ajdvai9MN0ljREZiaWJCSG9mRmJkVEl1cWpW?=
 =?utf-8?B?dHh2cmQzcGVWUmR6OTNYQ0xsbmMzemM0aEZSZ3BWczdLeFJoVThSL055cHJH?=
 =?utf-8?B?THhBalpRak1HZFg4UEdhb1VMaEVublM2Q3ljazFCYkphcnFQUkdDMUlsb1Fk?=
 =?utf-8?B?N1hjNXBqMUVtcXVBcmZiR2dDbEh2OWY4cVhRd0FOSXkyQ2NuQWN0UTZGVy9l?=
 =?utf-8?B?TDUyYk9yNVNleEkrUCtlMHNLc0gxby9udlduc3BwK0tTOC9nYndlcDY5T1dW?=
 =?utf-8?B?MU9FaFVzM2hDdnRHNDNMWkhma2QwV2s1ckpZYmRPbDBhSE1uZ1RrQmRVK2Uv?=
 =?utf-8?B?b3hrNk5XazNMNXBBQ1BvMXZ2RUpubXVFeTRWbnRPbG81aGpCaVRabVZka01X?=
 =?utf-8?B?M3doNVF3NngvQkcrWnllSk9SNDJtRFRmcXhsUXppOXY4M09SRUdVU0hreEth?=
 =?utf-8?B?TGhtWFlEeFhsM1VDSkw2TmpoYmkzMHVqa1ZKbEc0ZEJ6QnM3bUlqTElCK1px?=
 =?utf-8?B?eHVSL001NFR1NGdDalFLOVovekVBZ3NWMzYwMGFsbmhNQ3h3c3pBZkM5MTVX?=
 =?utf-8?B?a0F6OVZmZGtaNkJBZ0Y2eFp1R1BPY1Bzd0pncXZ5Sndtc3pFRno3MlpGR0gv?=
 =?utf-8?B?clJIZGVCblU1VEhpZnVVWWozTmpSUVhtRjF2N3FoT3N1VEFOQ1U2dDBIMDAx?=
 =?utf-8?B?VGNmQUV5UE1IZkFWYzJIL2NtQjY4eXFlWUdTUllOY2lneFA1UmFOS1lVVnp6?=
 =?utf-8?B?Qjhyc21qbTljTVNhNDFFUDlxem9MZ3pOVGtsU3ZQTDZYVEtRa2d6TDJkQnRI?=
 =?utf-8?B?cmlJUkJkbmw3UUtXSzdHaWFCMGlzVGt5TFpkS0l5R20zcGNEWWg3b25yQlpI?=
 =?utf-8?B?aEtzOFdGU1ByNkFiNStzVTJNcldYRmh6UGJ1dHNVRkh2MEJVRFlHM1ZkQ0c0?=
 =?utf-8?B?V0RuRXRWNkxxV1p2YnlEZk5zSzRHWGVkbzhnSlRyb0ZDRlNhdWFKVkJxT212?=
 =?utf-8?B?dUpJRU1CbUt4c3VXTUNROERDT2lJVmZycnBWRHVuZy8vRXVQQjFBQVgzaHdy?=
 =?utf-8?B?M2kyQTVhQk4ydTd2SjBUeXRFc2FBZ2wvL0pjRWNaZmZQd2o5YkZ1bFp3dEpu?=
 =?utf-8?Q?aK7pKM/T/hKoseAAA9MJL0S27?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1750dfa-fb03-4e12-f0b5-08db67240b1e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 06:54:30.7104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xaBS1Yiu8wnw/JmwVcbX8Gi5dDF/FrXHY3mQ5o32TXMwdo/7jlkhMauWVqvm/5MOfEzufL2PBMaUUwySFEO4Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6584
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/23 20:36, Pierre-Louis Bossart wrote:
>
> On 6/6/23 01:07, Vijendar Mukunda wrote:
>> AMD SoundWire manager supports different power modes.
>> In case of SoundWire Power off Mode, ACP pci parent driver
>> should invoke acp de-init and init sequence during suspend/resume
>> callbacks.
>>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> ---
>>  sound/soc/amd/ps/pci-ps.c | 18 ++++++++++++++----
>>  1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
>> index daf54fe9cafd..5802a701b3b1 100644
>> --- a/sound/soc/amd/ps/pci-ps.c
>> +++ b/sound/soc/amd/ps/pci-ps.c
>> @@ -662,10 +662,15 @@ static int snd_acp63_probe(struct pci_dev *pci,
>>  static int __maybe_unused snd_acp63_suspend(struct device *dev)
>>  {
>>  	struct acp63_dev_data *adata;
>> -	int ret;
>> +	int ret = 0;
>>  
>>  	adata = dev_get_drvdata(dev);
>> -	ret = acp63_deinit(adata->acp63_base, dev);
>> +	if (adata->pdev_mask & ACP63_SDW_DEV_MASK) {
> And now back to my comment from the first patch, you are using a
> bit-wise operation with an enum which is not explicitly defined as a
> mask. This test would be true for ACP63_SDW_PDM_DEV_MASK as well.
Already provided explanation for the same , in patch 1 review
comments. Please refer that one.
>
> +enum acp_pdev_mask {
> +	ACP63_PDM_DEV_MASK = 1,
> +	ACP63_SDW_DEV_MASK,
> +	ACP63_SDW_PDM_DEV_MASK,
> +};
>
>> +		if (adata->acp_reset)
>> +			ret = acp63_deinit(adata->acp63_base, dev);
>> +	} else {
>> +		ret = acp63_deinit(adata->acp63_base, dev);
>> +	}
>>  	if (ret)
>>  		dev_err(dev, "ACP de-init failed\n");
>>  	return ret;
>> @@ -674,10 +679,15 @@ static int __maybe_unused snd_acp63_suspend(struct device *dev)
>>  static int __maybe_unused snd_acp63_resume(struct device *dev)
>>  {
>>  	struct acp63_dev_data *adata;
>> -	int ret;
>> +	int ret = 0;
>>  
>>  	adata = dev_get_drvdata(dev);
>> -	ret = acp63_init(adata->acp63_base, dev);
>> +	if (adata->pdev_mask & ACP63_SDW_DEV_MASK) {
>> +		if (adata->acp_reset)
>> +			ret = acp63_init(adata->acp63_base, dev);
>> +	} else {
>> +		ret = acp63_init(adata->acp63_base, dev);
>> +	}
>>  	if (ret)
>>  		dev_err(dev, "ACP init failed\n");
>>  	return ret;

