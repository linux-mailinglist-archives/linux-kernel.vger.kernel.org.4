Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1AD66E4F7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbjAQRcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjAQR0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:26:12 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DF714E9B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:26:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCUJ23/38MmC6Yqm5PpfRYu/y4se71Gn01qk71uMYqF9Peu4HB1Uux9QNdU74WQlcn50p6h+uF9N1f/9+pbCbkfVK52fOdY65VcT4a9vAguKwXsYMoXwbd3uvvxHBUJkSw+nwlK3jaGICeOE4WEvEj352Z4sB5Khho/fBfATVasypMsQg+DQUNLjlHyyglKLGuUYl92Xn4V/lgnIqZF6kqneOsWJA5IoHo9W9yiEhgn6Ul57fo6tqKlnwQy0I923OPCOUxriUG8Gm+V/y1H3Zmjt6gbhVVY23vo3REMK5xE1kLzfOQYSmgMwg76u3KzjvMQN50Ipu29WKsY9QPtbFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9lZ8hprmuyn6wDvRLeY4+D1kjydEe8UedOXX33vUWM=;
 b=DUGrNCCCg26Fx5QgOfSTC81qznpgy6VUO8plElFgms4q4JNjeA4hrokXkomGZtY5P/wW0isYG9TGroq9tbxiwFemz50aGtMkJ4G8FQ79OESe5mW4Uf1LjpjASNc3yF3JbyYJQkWAmq2Szw92e+XBXTshU7Bbmgn2a8W3JDES5im6cXYTvakKqUdoWYPIk9HwfPfastPwrWLaQ693vkqGWdwaSDBBg6lyAvwR9TT3F8g+ng4kF8YadSuFv9kwXi/aBJrIJAzskJdMExTqrsuJHtuK9FZGscxM6sZt4QLQ0xo8OnfZ1uo2USTMgSvrRJOlrislQqSza16+NM/Trvq6sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9lZ8hprmuyn6wDvRLeY4+D1kjydEe8UedOXX33vUWM=;
 b=KBY5L4C1/geH26P4xVS34EYxl0A6asjoI/nYUmKl+Jtiu0j05MiRuC9X7A3ew2yNyXQMCVnE9KhEGvzcLm0g0yslc+3Uakey2Ac4r06mSFVgubqkTuOnCf8ut51M0GwcSoir2nZdIUp59ZpJ34HcZUk9Zu0VEYe9AviOecJlF+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BL1PR12MB5079.namprd12.prod.outlook.com (2603:10b6:208:31a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 17:26:09 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7%3]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 17:26:09 +0000
Message-ID: <bce8c402-edbe-4ba2-9cde-1a9485255c02@amd.com>
Date:   Tue, 17 Jan 2023 11:26:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] virt: sevguest: add CONFIG_CRYPTO dependency
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        linux-kernel@vger.kernel.org
References: <20230117171416.2715125-1-arnd@kernel.org>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230117171416.2715125-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:610:52::14) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|BL1PR12MB5079:EE_
X-MS-Office365-Filtering-Correlation-Id: d3a02f87-4cc2-498b-bd3c-08daf8afec02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LBOOj31MopC04Mh34BOAamAZybVOTbkse94okw7s2erzHi8iV5b2JW3qXiU6PkOxd17ywYOIwOQsYViwBpnmCQ2U9vGWiNzZ8jHWsgfEQMBeKLkN8GQgX4Ub2JeGhXSty6Q7bgvJg8GDNyB96REX0EYOvvTr8EjDPg+Oe5VOVGoqPFHj8WZjkkV3EZKQ2wRU5IcC/x13f2ds2dgaQ1S5KMLHDl18ZC2lJXnXGP5I5VFnmtCruk9A6Ww6TPuttS/z7fglQvKLWTmoUlGgLBCKWtRCYmO5HBLTPYFMEpcgpuYtVLC0YJ1iaYb2/ioFUI8e3k9/vxcqXE3G8qapWl2TfORJWMTklH7dWU4mkXQrAk0fAJ0+se7J/z8BRXuR3808iEBCD3bjyKbm3zCHASXc24O89870H5M7I2ff0Dh3ivLpqBZOE3MBbiXA9SuHwC+ea8g081IKf/vb2xIGUMkolxjQTp08UYtVCeLJSGPDY7KX5CXnQg9xXsa9yZQ9CTvK/tSVKTYrnuV3sX43bSyyRmDmY9G/LTIwHK7JHkZ+tnpFexJMDvPYftqqLmh9K6vO9bN/mvf+3dfnxuDCp7hGd7fUostW60isVXtUn9W8IH/sDDT+A3wISbYUlTmV4U+EyItRNDPEvjveK98wBY58VeoY+csBEUlrVGwKSbXk2oOQx+18iTJwN6z7WI8067mYBgiGMrHt8DPYz+JFSaq0E8aO7dZNpuDghmS2rSYUVHw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199015)(31686004)(36756003)(31696002)(86362001)(4326008)(5660300002)(66556008)(66946007)(66476007)(8936002)(2906002)(8676002)(83380400001)(38100700002)(316002)(6486002)(54906003)(110136005)(41300700001)(478600001)(2616005)(6512007)(53546011)(6506007)(186003)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDI4YmNld2ZSNjE2RlVzU0s2QnNXNndvc2VvZjNucDY0ZDZ5K0t1SEROVmRD?=
 =?utf-8?B?U3FzQm5kVjZaU2k5ZFFTWVdETnhsNzU4VGJRajdoRTE5bG9LOWlZcGxuaEVu?=
 =?utf-8?B?MTQ3RkQzU1RKN3dqd3Y5Z1cvOXlob0V2eSt6NEMveFdjUml1R3pNZU5yT251?=
 =?utf-8?B?ditYS2MzNG5MV3BPaUJqREpYOVNVWVJscnBrNmVvS3FlMmtHWWVaam4yNWNh?=
 =?utf-8?B?aU5CK0h1VXhxOWU2aWFrai8rL2srcGVDclUvRnFiL0Nyb01CRGZIaUlQK2lN?=
 =?utf-8?B?ZUREMXhpZ3hQV21CVThzOUNVUUo5N2kyWjJYaTk0RTFuME5zT1ZIWW0xUFp2?=
 =?utf-8?B?Sjd3U0FwZ1RWSDBqSlJwTEdKWWNzNmdTYUtyeHpvWGhnUlZEQ1diMmNycDZS?=
 =?utf-8?B?NHAxQldMUDN2cTRqWGl1MGxYSXhiNHovSzVHQi9tRnJ0aDJZSm1tenI5enhR?=
 =?utf-8?B?OTB3dHdJLzNkV0tmZnIvNTRibW4xejZvQkZxSmpma0FmS3NZYk9JSThRSzlD?=
 =?utf-8?B?MlBzcFQxclVNVm9KblZUQUQvRWdua2IvYURBYXBoYjJ1ei9GaytqVmxmUGRI?=
 =?utf-8?B?QmtRZ0Z5b2RNbjJ3MVBxMW5nV2FwOENmTEZSeVc5d3M5NE83QmJ5MGx1Q1VR?=
 =?utf-8?B?dHR3bXZWb2lIMFdERm1UQmtodFJCN1Yvay9YcTFvNDlXUmM2c0FycC9ua25x?=
 =?utf-8?B?b2VsL1NyMGZBQ1V4emVrQlFCYjUxR1ppVTJIYm5RTnpJVDlwYU10S2Jyd1BK?=
 =?utf-8?B?S1ZRWDlNMXhUd3hnSWpiUEFZbFJYanpSZnhFRW5QdDVxdGNpampYeXB3NGJm?=
 =?utf-8?B?MUtUNitCTFh2MUplU1lFSDc3N2NpWGhBTjEya3RwYUlhbmlpeVNKaEUydU5k?=
 =?utf-8?B?ZkRyWHlnSzNSNVNiYzE3a0k5eS9tK01EeXlseTRRcEJXVGZDaDZpSDgwY3U0?=
 =?utf-8?B?dFhYYWppU1hHRTNRLzdla05lUnVFeGdsR2plR1dnU01XYWxWZnZuMUsxK25U?=
 =?utf-8?B?SmVLMjZaUWpzb2QzYWJhZ0pZMk5hL1FYV0oyNm5abjRZNDVUZ0dHSk5YdlF3?=
 =?utf-8?B?eDlHa3hIV2xka2ZUU2J4NzlZZEZuS0FhR1RhTEJEbmp2b3dVeHczVm5EUVJ4?=
 =?utf-8?B?Q3dPd0N6Tzc5c2ZtSkIraXNFWGs2OVh0ZmZCanREWndRL1ZacnROOU5wdXoz?=
 =?utf-8?B?RWZVQWc2ZXVZRHozcFZ6T2E0ZE02RHJPWkNtUklTUW16S1pzUWRmb0p1dWR4?=
 =?utf-8?B?U2x4Q1FrQitjQlFYaXMwUHpPYnRiS2FZSlVnQ3VDTVpuWVllUnp3TUVFamVw?=
 =?utf-8?B?N0VVdS8vQnJodVpxU0tMZkREQjRXeE9QMWZGZEtzNE4wODliVGhzZStEZEpo?=
 =?utf-8?B?V29KaG0wb0JueE9GNDd5L3hBOEdvL3p4VEF6MG9ObFV4OGVUelBzQzFaZC8z?=
 =?utf-8?B?MFgrcW9tcDBhdzFBMVRINGVIRC8zQVc1MlRnN2JaSmZuWXdFTElYMVV3NHRZ?=
 =?utf-8?B?c2N4UCszMTRJKzExcENWK1VUZDR3blIzdDJEZzRiNlFQZi84aUhPOWZVdEFX?=
 =?utf-8?B?d3M2bkM4VDd3am5Ialh1NUhDRUpJMTRKVXlTNnVva2podjJISXBMNGZ2LzJ3?=
 =?utf-8?B?NHZ6RGNPbGg0N1ZJVTU3cmw2dnRQMlBWMW1McmpSMWt4WE9oK3IvL0JnWlBj?=
 =?utf-8?B?cUtpQ3hkTTRrSlBjMHlrTUhjUkl0OXluNkZUdE42bHFFRUVxVFROOTBsbWRW?=
 =?utf-8?B?YTh4MEw0NTdDNVNlMmYwUE9rLzBrNmdHNEEvWFRpZDBuL3VQNy9FOUFWaUxk?=
 =?utf-8?B?M25HajR4aW1lNG9aNzNqOGh5Z3UzdHJNQ3ZYM3dGRzdXYUhwNkFHOGV3WnRG?=
 =?utf-8?B?RlhnQjc0blZKbExQUFoyWk01RGRGcjdrUThMYWExTEx4Z1U3azNleHBhbVA1?=
 =?utf-8?B?WldDWnplVWozdWpiVXNwQ0VCT3BwMDlQTSt4OTE2K3pnSktEb3JpRkIyTk5y?=
 =?utf-8?B?VURaOVlrUDlhWlZnck5ndlhGSzdsNUNiQ3MwY3Q2aU96MjFiNW42enh6bFpW?=
 =?utf-8?B?VTdoSHoxZWF0ZVJ0bU1iZms3S0VJWFdlR0hJVytnNjQ1RVFtWS91dG1MOG1v?=
 =?utf-8?Q?AbicyHS87M3/zOvX9PEkonASH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a02f87-4cc2-498b-bd3c-08daf8afec02
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 17:26:09.1257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsWPKKoTXeWQT02mVVhpn4NIL2L/3UCDfMMvG+hHX+BB+Oh8RS168K8dgRnJORI0JfexjyQs2nImBBFtunQIig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5079
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/23 11:13, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This driver fails to link when CRYPTO is disabled, or in a loadable module:
> 
> WARNING: unmet direct dependencies detected for CRYPTO_GCM
> WARNING: unmet direct dependencies detected for CRYPTO_AEAD2
>    Depends on [m]: CRYPTO [=m]
>    Selected by [y]:
>    - SEV_GUEST [=y] && VIRT_DRIVERS [=y] && AMD_MEM_ENCRYPT [=y]
> 
> x86_64-linux-ld: crypto/aead.o: in function `crypto_register_aeads':
> 
> Fixes: d63670d23e60 ("virt: sevguest: Rename the sevguest dir and files to sev-guest")

This has been present from when the driver was first added, so I think the 
correct Fixes: tag should be:

Fixes: fce96cf04430 ("virt: Add SEV-SNP guest driver")

Correct?

Thanks,
Tom

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/virt/coco/sev-guest/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/virt/coco/sev-guest/Kconfig b/drivers/virt/coco/sev-guest/Kconfig
> index f9db0799ae67..da2d7ca531f0 100644
> --- a/drivers/virt/coco/sev-guest/Kconfig
> +++ b/drivers/virt/coco/sev-guest/Kconfig
> @@ -2,6 +2,7 @@ config SEV_GUEST
>   	tristate "AMD SEV Guest driver"
>   	default m
>   	depends on AMD_MEM_ENCRYPT
> +	select CRYPTO
>   	select CRYPTO_AEAD2
>   	select CRYPTO_GCM
>   	help
