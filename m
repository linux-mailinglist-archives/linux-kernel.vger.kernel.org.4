Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15135B6797
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 08:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiIMGEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 02:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiIMGD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 02:03:58 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E27D21801;
        Mon, 12 Sep 2022 23:03:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFBJ010rne4Jb32izulRSMQVpdwJSUOTqPNckvgxGTBPNov1yEMpkFoHmbo9IVml7HdWHxxYjHfElBib67QZRxlQdeAVSd2gA2+yqRBkgm7l9p7eS62GfVFriBobG1DUNbyaslSZjx8KMrg87i/Yx/GfOWe6dqdfO34BTDLsq89mWWR/lTLJ0AEAdf/Daqxj0N70od6RsWaRmj2v8fIeL491ZhaZLtgqWBXk2qbQvHVHFxFOAFvY45C1vv82J4vKYy6bNq0S8ppKiLk5XDPPNHpdbacZQ+UEsHCLpXwwAnsuJSJBM11oY8GnGb4ypyxmBrvmCY7HEqHRlVkApGoQFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b48vAQ+Pnc99cNmZ/f5D6UHZ/E5IRzNC/YpJQWFnh2I=;
 b=IjNScZ4kGaX9b0S9iVEyOy0Ijz9Y69oMRGE/tE6P92R7OAaYQxHeud5m+mJVtjqrNgKJpz7FSQjjfoRK7IS2PKVmzJNs2jhDCb1Q1CYMyAZYYWCYkYTs6CppZBHJoN7Kro2Gz9OsoOqrvexeQmGQIauSHbVIXL8WFrO3Wum2qV3Q48vhrlg8DfnNPplG6FlfKrlPv1ZkPhDOnSf9k0sZoj2dJRQ6TzIWZ+wl3Wsb9nNss79dDYrBoBfJbLTsX/1mn4cGCWl1PicKsPFRk5SXGtxpkAqlBPgzJQSbIvG1k+SSLH17qUW15eC54fsnpqpIn301lwAjXa0DZI860keqxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b48vAQ+Pnc99cNmZ/f5D6UHZ/E5IRzNC/YpJQWFnh2I=;
 b=AqrKyQe4Syowv9sXvBlZv9+PUaCCtA5k7YjloFIPx+Lw55LLqFBr7EyLwC/3mgsLyzxKgwc2TVQ1JrRpxbQhbhVxj9Mg7cZiFHJHzqcdrPs70yu5XmKPPNBo6ZofDLZS9Fow4W2tnVPH3A5O++bUpQO5z/3fjrxqwwm6m72kCQG4T67iDYH83S3LiPccmZV3jbnDzdefdroUINh6npSo4AAwUW2SoCvb73U2TwGPSLDEE/+UheuNiJxCwj1quDO9olQSlhGmuAMhjsoqco6iQjX32IFHBFL2PV9xd3FuBPzWFnFUu1ErhGMGoCrvUOJSDbq8Sdgb3L12OVuRgPEm0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23)
 by PH8PR12MB6769.namprd12.prod.outlook.com (2603:10b6:510:1c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 06:03:55 +0000
Received: from DM6PR12MB4435.namprd12.prod.outlook.com
 ([fe80::3dd3:e494:c723:e0cc]) by DM6PR12MB4435.namprd12.prod.outlook.com
 ([fe80::3dd3:e494:c723:e0cc%4]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 06:03:55 +0000
Message-ID: <c237d356-4792-8ed2-61ce-539fe40df8a6@nvidia.com>
Date:   Tue, 13 Sep 2022 11:33:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] ALSA: hda: Fix tegra hda dp infoframe struct
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>
Cc:     tiwai@suse.com, perex@perex.cz, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20220913034410.17502-1-mkumard@nvidia.com>
 <87fsgvhlwr.wl-tiwai@suse.de>
From:   Mohan Kumar D <mkumard@nvidia.com>
In-Reply-To: <87fsgvhlwr.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::13) To DM6PR12MB4435.namprd12.prod.outlook.com
 (2603:10b6:5:2a6::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:EE_|PH8PR12MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: fe9593b5-df27-4a5b-0d93-08da954dbd5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TK8RVvwzaNF+cO0kwNIkfzSEHSjnyqW03uPZ3MfX3YlfgGZil5GD7y4YVOU8AHL3f5jnEqNQEH39yxxwYyH/sg8dTUOtE199Lm4UqcJpfjAao/rPn3Xx92aQ6hAwBu/CohxLXp4qRqnP6npsHgWQVbQsGQRwuvWmwUWJfrPs/80Rp2RqWpHS2IZhuLq5+LIcWaj6ABS8WfPJdWt5QL2jV5ZKFPh5aap456QAH/+O8d3G4v5dv5DsLLz7Hl62kggpK4Lb+mOp4TV11Poo2krvXzd3PtJ8T1jusr5Oa22uLdZz3Db6FYGndtOeapvlHTO2tuhEOukDM+MjGc9DhXjVSpL11XP/vmvCmKx4LbwR8b1ScC+oyxnIemC2hQ+2PqUx29WGDRBqsY4jtIRHaCkUIx7H/tD9gu019xMNMe8TZyGro6Ao7C8M6hrhdlWY9Wm0feevhn1qENj3++qkL+OGFlRigHelGdYJdYJ8wNMKrRiKv6Eh1GmpIatZhmqzYwQE7a4pBevkrF7sTK6TsWYs7ZOOkXWLcY0Qe7+ApYu2vqFjGjCeDSQlt7A0BXJeOI3HcWSMhnassVI3gKxTkiAxQ+iiCEzEX/p1NqoukfvIPaD8ZZ6HbTObB0s2YCMkdAkkmZDo3aaWeda3abxyh5WsD0T3wDW8+msuxI1chlIQoU+wMWpAWE2y+Ol2qgrFGiNurWQ7ZjHAuFQCWLlgHu5y3u5BNrCkCOW/kboFBicQ6dgQG2OQ7MI36wQGD4gzUf4ugaSSRXvHpQcvsNzQq2+pH71LkUiwFPfSZOJUMq3dlAI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199015)(6916009)(53546011)(26005)(66476007)(5660300002)(6666004)(86362001)(186003)(478600001)(66556008)(31686004)(66946007)(36756003)(316002)(6506007)(38100700002)(6486002)(41300700001)(31696002)(2906002)(83380400001)(6512007)(4326008)(8676002)(8936002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVZ4dkY2bzZvMzJxaUsrS0IzYjNHaE1RVFNOazAvZkVjamlRcC9xSFhxc2lV?=
 =?utf-8?B?bS9CSG1KeklGMHVvSjVkTkpobElDaC9heGlFL1VlZFJjQVZHNEEwQmhYdXZE?=
 =?utf-8?B?a3VZOTFzMU9mWVhJaGFRV2lER0xQRjFta2F3elpBSWQ4WjFrN2YrRnh5eHg2?=
 =?utf-8?B?Z09nMGlFNFpBa21PQVNCYVY4RGNTMCs2V1g1ZjNUakVBOVdwZTB5ZlZCdTkw?=
 =?utf-8?B?OEFTZDBhS1VVbG4vajVzQUVJK1JVTUJ4NEFzUTBTZlhnK1RCUUV3WnF5aDIx?=
 =?utf-8?B?MmUzM1V1c0ptSTZxRnQ4Qm1tTHZJUkNsU0tWY0hwaWxUZ0ltZFRPem5rbWwr?=
 =?utf-8?B?V3FicGt5NE8vVjFtUXluTFREeVdRMTV3TUtPTVU4SjNCMzlHMFpIamhPTXBH?=
 =?utf-8?B?ZHFYV1RJSFpaN2FyR1Z2KzZZN3RScjBXYWxMYjRqMVFib1FTTGZtNVVHR08z?=
 =?utf-8?B?RDNyOGlqYndyUnpqZEdLTkQraG0vbnl5M0ovOWFyR2xLbVI0NHd6VWFVaSs0?=
 =?utf-8?B?OGVzMnh0TnBOTU0wVndMNWlKdXdCaUlnV2R6RUxwU0kzZkVJLzZGdzVnNEhD?=
 =?utf-8?B?QVlZV2YzWDVGQmZyYms5bDdub29ZOWtEVXQ1QU8vOFIvUUxKV3lKdzRwcHh1?=
 =?utf-8?B?U3FYbWJqMmRHeDByVU0xY1Z6NjROZmRUcWVGWmNTK2tMSm0zTStIRWRLRnJB?=
 =?utf-8?B?RVRCY25ONVZHbThUR3VwL3pOamRIWFFvUTV0MWZoMjdxUkE5aEJaS1A0ck96?=
 =?utf-8?B?aWRnWm9WRUFNSUxVc1VVcFM0UU43dm83R0JxSFUrZHUvb2ZQNElIdFl5eCtk?=
 =?utf-8?B?WFhleDlVb0NDN0luc3lyanh4OE9QL3ZGYk9MYjZORkNjNk1CTWYwV29mS1dZ?=
 =?utf-8?B?QVRPVnpscjNCZXpJcDVFbm02dEdtQjYybndrbm1laGxkNUsxSmNJZkIwak1P?=
 =?utf-8?B?a2dlcUF3TGpLZGsreTU5VVVsdFZacU80TXJ0YUtPSmFMUnkwb2NEUU5vYURr?=
 =?utf-8?B?WGU5LzQrS1lDZ2toKzU1WjdHaDZrbnVOc2hzeEZWRnVrUnJEWStvcFNoeFo2?=
 =?utf-8?B?TUJCUUNSUkZwSXJSdjlBcG9CMW1XQ1RlaDlOVXRKWVRvaEpKejR1THl0bFF4?=
 =?utf-8?B?cEpxNXR2UUhnWWgzYlBHc0Z6QzZRc2VxT3BqZGZiQkdEZTRzTDhwQmlLRlhD?=
 =?utf-8?B?c2NRa1hjUEw3RS9VUGlveHgzSWFna2pIK2p0S3Vmc3RuUDF6MmFYbkdDZWkv?=
 =?utf-8?B?K0dPdVF1TlcrSjNTeDBadDQ2aklGWHVoWGZOSXFmOENyV2d2dGNwQ3l2WEZq?=
 =?utf-8?B?MTdKbFlLVVFOSzJTZkJRMG16czhWWlBLQU9UcFc5UGpTbk5qUlExeFhiUkRI?=
 =?utf-8?B?bUZQdFUxZXRReXFheFRacVhRRWd5aEtlblY4VHdpZHc5VXI4QUpNODNqT2FS?=
 =?utf-8?B?bGl4R1QwRHd3SFp4cEVjZEhxQSs0czNQMmhDUzVCSVNhYjZiM0JUSFhPdDJ4?=
 =?utf-8?B?aEJNc1gwLzZuK052NHZTYkVkWUxKYU1yUGFiQ0w3eXp1OGR0d0dCYkxFcEs5?=
 =?utf-8?B?eEtQZHcrQUZRSmVwcnlLTUdQREo2akFvMXRLRUpQRTRZdmlOV1R6cXRwMUNR?=
 =?utf-8?B?UzhyUm1aR1AxN25vMnNXSldZR0VTbFFvM2duQytlbHlUcnVGUkpIKzFSa2wv?=
 =?utf-8?B?bGNIaFZ1R3FJaUx1YlBBVlBtRVgrZDMwcDFKakxLUVF0ejY4dDEvNG5TRGJ5?=
 =?utf-8?B?b2NQWEtLQkk4ZHV6SUNZS3U3Z1BNOEgrYTlUbS9JWE9lUDBCVDJoS2RhYVBP?=
 =?utf-8?B?S2Y2K3NJK2x6bi9ZYUJPNmM3OXVSQW9vQ1dvOWlJaE5NYXJDZytJK0NrZ3dM?=
 =?utf-8?B?QkU3MWNvamJGOUFmM2Q5UGdvOHBHYnYwS0JBVy9qUlZmTS9JMG5wSlZwWUVD?=
 =?utf-8?B?cU9yTXJuWjJaM0V4b2lwMHlGTG40UzNLdXlKVUFtRDNiNmJ6U0JoT094eHg4?=
 =?utf-8?B?SEMxeHNLYm1tTk5ueHFTNGFTU1VETE9xYlR1ZHkzb1hNK2xLS3ZIZkc3eUtS?=
 =?utf-8?B?RzBuTDZNRVF4Qno0c0xaU2d2SVc0M3FVVjlUM1B2N1hUV0pPRXBVTEN6QjBR?=
 =?utf-8?Q?DaS6B958JxBL5V8eJtyQP9UkK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9593b5-df27-4a5b-0d93-08da954dbd5b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 06:03:55.1664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86Rz15QXph6z3aZ1K8cktdFMKNryf9MNTr4SCF28EuZdMOikc5rFofOoHZqRHUHdYvYbkP8OBmvbPi1JQRtmPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6769
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/13/2022 11:10 AM, Takashi Iwai wrote:
> External email: Use caution opening links or attachments
>
>
> On Tue, 13 Sep 2022 05:44:10 +0200,
> Mohan Kumar wrote:
>> Tegra HDA HW expects infoframe data bytes order same for both
>> HDMI and DP i.e infoframe data starts from 5th bytes offset.
>> This hw behavior mandates to have dummy bytes for dp infoframe
>> structure for Tegra.
>>
>> Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
>> ---
>>   sound/pci/hda/patch_hdmi.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
>> index 6c209cd26c0c..a52e764db2e0 100644
>> --- a/sound/pci/hda/patch_hdmi.c
>> +++ b/sound/pci/hda/patch_hdmi.c
>> @@ -218,6 +218,9 @@ struct dp_audio_infoframe {
>>        u8 type; /* 0x84 */
>>        u8 len;  /* 0x1b */
>>        u8 ver;  /* 0x11 << 2 */
>> +#if IS_ENABLED(CONFIG_SND_HDA_TEGRA)
>> +     u8 checksum; /* Tegra HW expects infoframe bytes from 5th offset */
>> +#endif
> I'm afraid that we can't use ifdef here, as this is another module
> that is used not only by snd-hda-tegra.  In theory, snd-hda-intel can
> run on Arm using the same codec driver.
>
> That is, the check has to be dynamically.  Maybe we need to set a flag
> at tegra_hdmi_init().
>
> If I understand correctly, Tegra uses the same byte layout for both DP
> and HDMI?  If so, the patch like below should work instead.
>
> Of course, if that's really specific to Tegra, not generically for
> Nvidia graphics, the flag has to be set in a different way...
>
>
> thanks,
>
> Takashi
>
> -- 8< --
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -171,6 +171,7 @@ struct hdmi_spec {
>          /* hdmi interrupt trigger control flag for Nvidia codec */
>          bool hdmi_intr_trig_ctrl;
>          bool intel_hsw_fixup;   /* apply Intel platform-specific fixups */
> +       bool tegra_dp_workaround; /* workaround DP audio infoframe for Tegra */
>          /*
>           * Non-generic VIA/NVIDIA specific
>           */
> @@ -679,15 +680,24 @@ static void hdmi_pin_setup_infoframe(struct hda_codec *codec,
>                                       int ca, int active_channels,
>                                       int conn_type)
>   {
> +       struct hdmi_spec *spec = codec->spec;
>          union audio_infoframe ai;
>
>          memset(&ai, 0, sizeof(ai));
> -       if (conn_type == 0) { /* HDMI */
> +       if (conn_type == 0 || /* HDMI */
> +           /* DisplayPort for Tegra: Tegra HW expects same layout as HDMI */
> +           (conn_type == 1 && spec->tegra_dp_workaround)) {
>                  struct hdmi_audio_infoframe *hdmi_ai = &ai.hdmi;
>
> -               hdmi_ai->type           = 0x84;
> -               hdmi_ai->ver            = 0x01;
> -               hdmi_ai->len            = 0x0a;
> +               if (conn_type == 0) { /* HDMI */
> +                       hdmi_ai->type           = 0x84;
> +                       hdmi_ai->ver            = 0x01;
> +                       hdmi_ai->len            = 0x0a;
> +               } else { /* Tegra DP */
> +                       hdmi_ai->type           = 0x84;
> +                       hdmi_ai->len            = 0x1b;
> +                       hdmi_ai->ver            = 0x11 << 2;
> +               }
>                  hdmi_ai->CC02_CT47      = active_channels - 1;
>                  hdmi_ai->CA             = ca;
>                  hdmi_checksum_audio_infoframe(hdmi_ai);
> @@ -3992,6 +4002,7 @@ static int tegra_hdmi_init(struct hda_codec *codec)
>          spec->chmap.ops.chmap_cea_alloc_validate_get_type =
>                  nvhdmi_chmap_cea_alloc_validate_get_type;
>          spec->chmap.ops.chmap_validate = nvhdmi_chmap_validate;
> +       spec->tegra_dp_workaround = true;
>
>          return 0;
>   }
Agreed, will do as per suggestion and upload patch v2.
