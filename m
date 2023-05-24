Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A39A70EEBF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbjEXG6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239829AbjEXG6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:58:19 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B66E7D
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:57:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EC4WnCqTpNcRnMu9yrtFChiO5gCcW7KcR2nuf63vWYU4dw/fqMp9/HYJpXHWkf/5uZrS9Rnedjeyj7IGHKHQYjE8JYaucrdjWMTF86BPlV09SFivohH/dtx/dwT89GU3ZKQebPo5O4insnYSuPN/zegAqJdaHh3NhH96TFPg3Hl3rz3f7iNZA/EMAoLk4p9mqRPSZcRCowj299uk6XhUHfQxkIT5Q3/fLlpNsgsovIdkDdrjhM4J+O9TjDFevrc+AwDhUd7UCF7VCOcgbxEcq4mYCn4MGkoRytnT751C6QX7fC6bZbN44S51jRT93hDvijKm9xNmE5j1goG9i/LbBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGaV31YLTOyGrgDmRhWF8MI+BXsWLKa3Bld53GiiaS4=;
 b=aUtHNY2/eMdkoZX8hPG0Bq5ZKVtIMtqXnhG9QITlSjDid281nt1CWD8Ju3o3qRK19/roCX41eQwyhie9HERs55eykNpWsHZlyedoKiu2/kVlbleL+yQ39Bd7l3k6oAvBX39Y6v05sHdNuroKE5jIhJ+Gy/M7+tKeCQW/V5EC3RJgtd/okrWwlJ4kdkVcvESAwPVIOPrVG4vjNVl7J4KYGSa+X1ikyP2kHWLUw6LPZU+vktNHdDUgi1BH5NjBcThQ6Jb3BCZXC5KnGhTc0FUxgUZF/UnHliyeg4Q+gwHQC+y33/xykvTHIL8lZ6JklgVluzeVoBamBCmN4ElDQISvxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGaV31YLTOyGrgDmRhWF8MI+BXsWLKa3Bld53GiiaS4=;
 b=IlM4ncjAowJJsapCwCiddao78a1HXeSjXMpKmDoqKXQsFYh8doRuGUMqo/zMc28Kw15lW14xUlgokMnH0MP87F5kt2ImjA9S35FtFKB9jzdN0VW/cb5tVMOVO5XnFq2VxmntrXxyCqIdm4UQhr5KJMwyhfqDC9a7trFJixcrJdE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by BL0PR12MB4996.namprd12.prod.outlook.com (2603:10b6:208:1c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 06:57:56 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8700:a051:2ddf:d350]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::8700:a051:2ddf:d350%4]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 06:57:56 +0000
Message-ID: <06df5132-c1e5-c3cd-bf5c-c0d672837352@amd.com>
Date:   Wed, 24 May 2023 12:32:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V2 1/9] ASoC: amd: ps: create platform devices based on
 acp config
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
References: <20230522133122.166841-1-Vijendar.Mukunda@amd.com>
 <20230522133122.166841-2-Vijendar.Mukunda@amd.com>
 <1d73963a-de26-a147-6ccb-e5c8c65f579b@linux.intel.com>
 <a9723614-2ee8-279c-8a95-28535ca47709@amd.com>
 <dd93f315-79ef-5108-0cae-fbfafafb9a12@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <dd93f315-79ef-5108-0cae-fbfafafb9a12@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0223.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::16) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|BL0PR12MB4996:EE_
X-MS-Office365-Filtering-Correlation-Id: 96d6627a-e81c-472d-6400-08db5c2433d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0uz8KEQQkX7bePLbd+RJ/fDsFs6v4mRTxKZLnw2qnhOWXTpZvaFVjEkpZseP0dLRJdOHScPUbtHRLhTz0u15UbG1DSVYa5d5zEL5NUwBAiPsey6EZe3NAKaIyw/PIFgbivUImYtix1eDIk5zcqHNSZV3Mj0ItRAqsM2PZA4SjZaU+Mkuggl9tXleUwQobgUlkF+38ZaFrjiQsI935erspSU6dqFidg0JhTC4WTxUvuZ5Eoyk1N5ZhcDZ6Fx55Q4eE1ZDoDuNOUHuCp7hXE0KdQpLoTRJw/GNm6KwnfLRtCs9rjYeU7yVAwJpbGjWpteMaAW/sGpblca1IlXuzm0G3Kl+FyZ9JiMDIHMTS6dRS48L8o0IU1f9ZK707/Fl+riclQ+8hbOMVRdZpTH573uBAIqN11I6ZaZ9ZQhu+Sp7r72MIgzAlTx/7p4g8+R/mebdL3euOLOYA1OrRhRJWnae4e4hgt9DDRNfXX6sguwxp0ZkLjlQQKYI/D76hm0PfexAGI8N8uBAHPPrfRrudkhUR8jTAdmSwCC+FFceJ72DNamMI7oHHg2tL4HQLeHH5O3ur+9DqkeikRkS3EgtWaAqZb68qN9hN/HUUgaOeRiSCESzcLdSC8uKxI30QOdjCXQI2rkNAziyCupnsEnNEDY1AA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199021)(31686004)(54906003)(2906002)(5660300002)(8676002)(8936002)(41300700001)(66946007)(66476007)(66556008)(478600001)(316002)(4326008)(36756003)(6666004)(6486002)(26005)(53546011)(6506007)(6512007)(38100700002)(86362001)(31696002)(2616005)(186003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnQvSm0vSy9NeFY1bG5EZENUSEVuWU9uQlZnL0tNSUQwejA5TVl3R2RJaWRJ?=
 =?utf-8?B?bUZ6THJTeldjQk5WVE82Nmx6SE9yaTNqWSthdE5jOFBpR2RRTFl5SVFzYjdT?=
 =?utf-8?B?bXJweHppaXVnUHZjZTI3SUhOdDU4bnp2ZnBYTGdmZERseUlQc0xRWStYTFF5?=
 =?utf-8?B?WEJFWUV0bGxiaWJ1M2YrVFByWkJkUFl5U3dZM1cvVWFicllFY05zTS9UZnNT?=
 =?utf-8?B?dDlQQTE3dFNUVklCdkE0cmNyTExhcmh6S0Zza3JNY0QzRmxHcm1HeDNOanBr?=
 =?utf-8?B?TVV3ZUpyV1FwQXhMY2ZlZDkrV0JmSXNYTitmQVdmcUZXYkZqQkdLbk5IZ1Fi?=
 =?utf-8?B?QjRVbWMwNFNycGgwVHVGMFVZMXRhZUp5R05aVDNPM2psOTBUY2xpc2VGT255?=
 =?utf-8?B?MEJsR1d4QkNSbVEwR0psZlhXMm5IN3ZNM2dEOU5CVGY2YitZSHZNWitxQ2xG?=
 =?utf-8?B?VldTcFJnMWVsZENKU2VUNkRvYTkzL0NBVElZbTZnVFNMYWIvdkk3dFNieG4y?=
 =?utf-8?B?MFlwUnFtV25RKy9yc0NJS3dIY3Nmb2dzb04wdm5nR1N3cGYwbnBBelorRWFm?=
 =?utf-8?B?YjZGVGNsa1ExdGRVZ1Y0c0hDZXRZSlYxNEs4NCtaM3ltTXJWekdDNFRkdndH?=
 =?utf-8?B?ZFl2dkRYeDVPNWM5b21zaGkvVytDeUlnM0xWYVBGdFBqNTh3TlNLNFdxK1Jy?=
 =?utf-8?B?cFNmdTBhU3JSR2N1ZnZZbU00ZHpXWXNLWm1LajEwdjVwLzZ3MU1YL3Y4UzF4?=
 =?utf-8?B?aU5wQ3piVUpwdit3N0xiclZNUXVpRjhtSndGSWR2em9GM094R250UXdtMndl?=
 =?utf-8?B?azROV1pWTXRTZ04rK1lnYzE2K3VYMUNwdytoa1Y0dDAvVzI3ZjB6R2NGQXR1?=
 =?utf-8?B?QVhSUDF1VkpuSG9nc05xdUtoQ2pCcGUyR1ZwakJpZ29DN1ZQanhySGV2UjFR?=
 =?utf-8?B?bWE2Q0RaTEdLSXRqRUx4emI1dXVYSm96VU5MaXdDTWt6d0k4aFBYUmV5ZEFa?=
 =?utf-8?B?MkhiVjRLdnZiZ2RaZnV6UnFTUkt6TTVkVDU2SFhtUmRudm11T2RwUWc1Wm5k?=
 =?utf-8?B?SW1Pd0FaVWRxdTBQN25jWGNPLy9MQ2dENlNVU29KN0ZkNzJ6akVxSGlaT2tk?=
 =?utf-8?B?QWNXNjltcVBBSG9qSFhSK0ZwZE9XWjVrTXVIOXNKditYbzlDK2F3TzVrV0Fp?=
 =?utf-8?B?YVFMcGpld0t3QzV5Qm1VQjFKZWhkR2FybUswS1RnWWY0SDdUYy9YRld6MkRD?=
 =?utf-8?B?STB5NmdoK2IvSlRCL2ZvS2p6cTg1OFM5Rmw4VlZ5ck9FUUs4M3hGY3N5VUFZ?=
 =?utf-8?B?NEhzcEs3cVg5amhNQk9yclFOaG5TcFRPeFJiWEw2RS9HUGRSaW1oaHRZelJR?=
 =?utf-8?B?TFZ3MUFMM3FNeVdEOENiQnh1T29zdFErOXgxQ2hncUs5TE9obndJQ21neFl5?=
 =?utf-8?B?OEtXcDI3OXdOVnRTTm8reGFVVUI0Umx0UFpmWldPbXd0SGZuQ2hpanNZY1NL?=
 =?utf-8?B?cW1FbGNzYWFqc29FbTFsOVZlTDQ3TDhTSk8wc1NLR2ZKTkdKWE03Zmhud3VY?=
 =?utf-8?B?MlVlRncwcUZlN09Tc1R2L3RFZ0t6R1NkUHJ0L2ROYkc2Unk0L3EvT3N1U01P?=
 =?utf-8?B?T2Fmb0sxOElpMnNGeXAyRjR3azRUNm9BMGdnVzY2dUU2bWNseFhHT1ZhSk1K?=
 =?utf-8?B?QUgvSUdEV0NPaHNIRmgxQkNLRi9xZG01OW9TQVpLQTV5V0lMQzhYV2lnczd5?=
 =?utf-8?B?bHFCdFliYW5vQ1YvWjl1bFYvYTFjalN3VEdlNUJ4Y21ZMHVZNTFMYVBTL1Fp?=
 =?utf-8?B?alNLQ2l2djFrOVNJeHNpTkg2VGJ6OVlpdXpzY3VaRWMxeFlhWmE4d2cxdlI2?=
 =?utf-8?B?OFQ4WHN0Z09Lcy8rcCsyZW5QazhRM2lMdElzOVY0TzFoNWRMSEhEbTBkZWpt?=
 =?utf-8?B?NXZnRUVBcmNiak9MMHdWczhCeDA3SlpTU2F4WW9RTWZGdlY4azJWamJrakgx?=
 =?utf-8?B?MTVyZDlPcGxlZUJRVmdlN1NtYUxmSmNQR1dlaml5ODVzZmZFOGwyaXlRdWcy?=
 =?utf-8?B?WnRxM0p4c3UwWmNSSzBmNVRvUkZES3RFTitYZHNYOGU3UENHM204aXVHOFVq?=
 =?utf-8?Q?7kEBATYTIFAdvRFLoN9+1sjM9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d6627a-e81c-472d-6400-08db5c2433d4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 06:57:56.3438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+o/Nh5OxkPtz6j+QhwwTDPi/AOY0ONvaGrogeddkG2JA4GY6UDUrmLkheCLyg2lYqqbV9rh02Xr1IZBhmfmNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4996
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/23 19:59, Pierre-Louis Bossart wrote:
>>>> +static int get_acp63_device_config(u32 config, struct pci_dev *pci, struct acp63_dev_data *acp_data)
>>>>  {
>>>>  	struct acpi_device *dmic_dev;
>>>> +	struct acpi_device *sdw_dev;
>>>>  	const union acpi_object *obj;
>>>>  	bool is_dmic_dev = false;
>>> useless init
>> We are checking is_dmic_dev & is_sdw_dev flags in same code.
>> Either we need to explicitly update value as false when no ACP PDM
>> /SoundWire manager instances not found.
> please discard my comment, I read this sideways
>
>>>> +	bool is_sdw_dev = false;
>>> and useless init as well...
> same here.
>>>> +	int ret;
>>>>  
>>>>  	dmic_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP63_DMIC_ADDR, 0);
>>>>  	if (dmic_dev) {
>>>> +		/* is_dmic_dev flag will be set when ACP PDM controller device exists */
>>>>  		if (!acpi_dev_get_property(dmic_dev, "acp-audio-device-type",
>>>>  					   ACPI_TYPE_INTEGER, &obj) &&
>>>>  					   obj->integer.value == ACP_DMIC_DEV)
>>>>  			is_dmic_dev = true;
>>>>  	}
>>>>  
>>>> +	sdw_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP63_SDW_ADDR, 0);
>>>> +	if (sdw_dev) {
>>>> +		acp_data->sdw_fw_node = acpi_fwnode_handle(sdw_dev);
>>>> +		ret = sdw_amd_scan_controller(&pci->dev);
>>>> +		/* is_sdw_dev flag will be set when SoundWire Manager device exists */
>>>> +		if (!ret)
>>>> +			is_sdw_dev = true;
>>> sdw_amd_scan_controller() can return -EINVAL, how is this handled?
>>> Shouldn't you stop execution and return here in the < 0 case?
>> As per our design, ACP PCI driver probe should be successful, even
>> there are no ACP PDM or Soundwire Manager instance configuration
>> related platform devices.
>>
>> The ACP PCI driver is multi-use and that even if SoundWire manager
>> instances or PDM controller is not found, it will still be used to set the
>> hardware to proper low power states. i.e ACP should enter D3 state
>> after successful execution of probe sequence.
> Ah ok, maybe a reworded comment would make sense then, e.g.
>
> "continue probe and discard errors if SoundWire Manager is not described
> in ACPI tables"
>
> Same for DMIC above
will add a comment.

