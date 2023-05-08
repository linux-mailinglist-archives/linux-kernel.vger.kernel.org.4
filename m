Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF6A6FB983
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbjEHVYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjEHVYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:24:25 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3412546A1
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 14:24:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmvkPitIT/usFhxJjej0ka3VPjHqmSq9neVU982rd2IUAWFcAURaXqWfdUpe/iqbw108SfGaWjwjzseoy6pUMvexaBhi/qXccwNghv1qHpvOLIx5JTLpEaJJx46Wi2PYDrJqLIxD04w4NI3UzqFWu3WnY4EIbmlgF/SDQxNFKvOLdbGXR6ssZTX/QwkWSktZbpPTKhdN3ORoqqG9HM3+7y+w4EyyHshR65iz1X4sNIs6cY7ogs7B8rC0P5IEqf4JfxG3xDJEVuzi9hPTUZTDLdhVY2rwOFN4kpyONsGplHFDixzV7+XYddY9WEqYuj/Dx1HE4/OQ2ALfhlVmElKIRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUH1WBm8IL5ZbsOg2Zs+lrViYLHCnPFEVunvSyMXKn4=;
 b=Z72yDwOd1tbdhpMPTxE1ddCk6Bw1H+drnNnbeHl3+WzHLQmoXGLzqo8aOJVrj4Szb3yziAJta4Lb3kUYb66UPBOTJpafIHiQ2CwAKfNB4RNHBz88sOWZC4zIMUJ2eItraBl54QOaATWTjsFCyQ1pA9EiLIWn+4hJumftSccMnosDekBfSevtz+Ydp50SBDaRBBi5+sQB7fM6jjv9bi3uklJuCw32cOJd2QQTDuYdbFDkutbw3oYaRT/3AIfWr6StzPVHQTmrSDrxvG7qiNeBPtDbtqW3TbqgKY8HEfWSzmHsvhwzoQpulCO8xy9g3H96PgfWFeKdFVkar6mc8cxd0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUH1WBm8IL5ZbsOg2Zs+lrViYLHCnPFEVunvSyMXKn4=;
 b=qI7PXXcZofsGjvJgBpbntlYG63XKYPO4Rjpo22lkl/0XOOqG6zCuhwLGmZmPKh/GYiLDxLAgba/5SRAGXRG6H0SMbp3tkUA/8I3oZbB0AA/TBuChyMJwn77+S8EbsvC7SHWgJ4YTdIQpaH+YVmopcdERZcjYPgKUSfhZq9DVEpo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by PH8PR12MB6676.namprd12.prod.outlook.com (2603:10b6:510:1c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.31; Mon, 8 May
 2023 21:24:18 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd26:a6b5:1d41:ac27]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd26:a6b5:1d41:ac27%6]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 21:24:18 +0000
Message-ID: <613b2431-7d05-fb44-25d7-dba59e5eca3c@amd.com>
Date:   Mon, 8 May 2023 17:24:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Harry Wentland <harry.wentland@amd.com>
Subject: Re: [RFC PATCH 03/40] drm/amd/display: introduce Steam Deck color
 features to AMD display driver
To:     Melissa Wen <mwen@igalia.com>, amd-gfx@lists.freedesktop.org,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        sunpeng.li@amd.com, Alex Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     Joshua Ashton <joshua@froggi.es>,
        Sebastian Wick <sebastian.wick@redhat.com>,
        Xaver Hugl <xaver.hugl@gmail.com>,
        Shashank Sharma <Shashank.Sharma@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        sungjoon.kim@amd.com, Alex Hung <alex.hung@amd.com>,
        linux-kernel@vger.kernel.org
References: <20230423141051.702990-1-mwen@igalia.com>
 <20230423141051.702990-4-mwen@igalia.com>
Content-Language: en-US
In-Reply-To: <20230423141051.702990-4-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::35) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|PH8PR12MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: 08cd3ceb-b300-400f-f5b7-08db500a94d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xW32+UGyl01PZ0rqDbXuPlPDjaoVuY9DIGstFADwMCGKVh412QK2P/xWBq9Giv14Kbc97FvFcmbrgrzida1O6euMzASKzNMgbKtSGcTnE5BrH93QaiNjTu1CeVOj2k1ha9BzVsa64gUEP52BgucnzUm2x9q+dvR82BssvcpK3jaSGLTZdrjzukD19aIKNcCoMK8w7sBNrC/ryo19XaNOoq6Z/urzY502UOVV2fvoC8hA6Fb+tc3uMAUinHLHUykRtQF+QzVbYMVtTMbxynrOIjl5rCadf88qGRPAWZqUdVodI0SflJsXakL14NjrwH26awGKiWtKLqscNzhpatIL/nSR9KPhVk8qERJiP79WREru8cCqPKBJh1pNVHuebg5Jv9IoSMIy5o8FFMkvXROJkjZra4zGLeAw/nRBq+L/eeT40gBPfcKl1cZ7/lioipAOwwtblVkxE9xVIJpFO1a5uGxqcpMgp30McLNP4C9LtD5B5uyKVvluvm4hZEcpO+tos0bTWoKExOLq6JZES5ffWEnPpfIfBo206t176v3MmqmeTpTmG5tGpjyZfCanIGlF74fjXCDNXB3wvQlYJT9LpufMrJ9A3H+Q/WD5FqIhg4dtnTl+w9z2CBSkY5YqD+m0ON9sCOTlvRKgeLJ1HvEBydJpt+//kVMBZ9EiktLkk8s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5427.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199021)(110136005)(6666004)(478600001)(54906003)(6486002)(2616005)(6506007)(26005)(53546011)(186003)(6512007)(2906002)(44832011)(38100700002)(36756003)(66556008)(66946007)(66476007)(4326008)(921005)(41300700001)(8676002)(5660300002)(316002)(31696002)(86362001)(8936002)(31686004)(66899021)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEVsRGF1SjVqWkFNNDNhVW9kRmJrSlVvY2tRWlNUTFNZTk03dVlDc2U5TUhP?=
 =?utf-8?B?a2JPL3dKbUhXclJaa01ESUh1VW5aRTdkVkxOcGtuNG5kK0R0NDJPN0NRbStK?=
 =?utf-8?B?TGVjZVMxdmNxeEdkUGE4MDl6SDBhR1gzRGFnNzRNeHVqd0xtT3dpTDVRYUdB?=
 =?utf-8?B?akM2bFFDM1NsdTI5dkZLbGdoY05vcTJXSjhoUEZOOXZQcW5BaTVMWjh4WHZP?=
 =?utf-8?B?ZnlPYWV2VWsrQnJSNkZQazlyZzhVOXVCb2kvUzBBSjlLN1dvblowU1JaRHBY?=
 =?utf-8?B?UThMVHpnZVg3MU9VaCtJdVV6VkRSZGdyQlYxeEtUOWtaQlpUN0ZVaEVtMkR2?=
 =?utf-8?B?TkRTVWswSWVFczNmcDhFOGlxMzdNcU9GU2x6R01PSzRtMmtBUnBQOUQ2Vmx4?=
 =?utf-8?B?cGllQkx1Uk1uT2NEb3NOeXNZSFZBS1FjK3E0NTBwY1BEaStWRVBXQm9OZzBq?=
 =?utf-8?B?MWlqR1J0dWEzSFFoOHhVYTBSN3VOWTFGbmxxNFlqTDl2VkxwMlJDNEZrdGNz?=
 =?utf-8?B?VE9NUEtpdWdsNzlHdzFwcGt6SVBERm1sbjZZcGlMWTBoeEpmTXdNUExqVm5E?=
 =?utf-8?B?L2NPWk5SMENORloybGhsd2NycGxKdzlmT2VDazZORDhxOXA2bU1DUS9tbkxi?=
 =?utf-8?B?YzNRZ0lWRkZvN1BhN09uSWlWZnY3NTQ1b1lTS3RuYldZRHBqbDBQRlVIQlFy?=
 =?utf-8?B?djcyTVdCTjdJeHRMZ1JtWFlsakhld0N3UEtSamdWUC9TWHY5S2lNTmdPUnQ3?=
 =?utf-8?B?L015VWVZUTUvcEJjbG9QTXJidW1Eb3I3N2N0MFRxNGlqRHMrWjhlZ3BnSVM3?=
 =?utf-8?B?VGcrUkphT0pVUUNWUjFXbnh5Z3pNandjSDFUcnJ5RlF1UjlFSnRFeGM0WU93?=
 =?utf-8?B?eS9uQ29VYnFVaFlkdmlLSlFDTEJxc1ZoRHNqVGN5dVkxMnZBdWwwY3dCVkJt?=
 =?utf-8?B?ejRESExWZXc4bGY2N25RK3pvZTFpdDNoUkNxNE1MN3pIdTliUDBzUS9RazJ3?=
 =?utf-8?B?UjE2Z2cvYitNK0t6RFpwSmdBT0hBaU9DUjZuV0RuSHBmWUpVdUhpbmxCU1pB?=
 =?utf-8?B?czYycHlhODR1azlKZVJFOTRSZ2xFVWlxODZvcXZrY0s5SGV4ckg5aDVyclQ2?=
 =?utf-8?B?RGxtdWdyc3pTdzNiamY2aFRseFdSNlg5R1pMeHpueHFjN2VSMjJ6cG14Q28z?=
 =?utf-8?B?UWFzYlR0d2Fsb1Q4K2xULzZ1ZHl2TDVWay9EeWxGNU1VdFhPdGdSYTBHUVJa?=
 =?utf-8?B?RkI0L245RUFBa1FlZ2pOMy9Nb1pYUXFEWWh6RHNVaW5tTFQ3aVBNTnJteXNn?=
 =?utf-8?B?TFhLU1VuTkR2VFNKMTl5eFBxM05IYm9Lak1zU1NIZm9yNUhTZkxkdU54aG03?=
 =?utf-8?B?NXluVUw5WlRWOWZlQThPd3A0eTdDcExhc25NeWxwM1NvcithbGNQLzZ6M3pI?=
 =?utf-8?B?WkxQY3BaM2RmQVBVaE9Oa3d3RE14QVlCYU9aTE5jaVI1bkhsQ00wWGE5MWVY?=
 =?utf-8?B?MS82T0dVUFNZb1REVkQwSkxVSzA3QVp4Ukt0c1ZSckRLYURHK01VN3hDeEg4?=
 =?utf-8?B?V3FlUTN3N1ljZjdRSmU4ckNtQXdZdmFWenFRTlJPMk92ZFFYYmZZNWIyVEds?=
 =?utf-8?B?YlFEajUrdW52KzBBcml6S1dHMWpFN3JFekkzQnJkQVdnRkFnMWFFaDNKdElF?=
 =?utf-8?B?Rm5MdnBZRWFaQXBMTVNQNnNFeVZ3eXhnN1BqeUE5dVR2d1YzeVpDSmk1RFdU?=
 =?utf-8?B?dThRVDU4cmlzcWFWMUgrZGs2QkhjV05zTjFGZEJ1V2w4d0VIeEtJeDV5SVdP?=
 =?utf-8?B?VlVvNzRLZEJ0cmd6bWJ5YmhPQ1B0MmpvSEZNenN5eDVYeURsL3hrUDRMaGRI?=
 =?utf-8?B?a1p1cFhqQWxmQnJxNlJsTENhdDBHdXQxM0hveEl0dU9iVlFwaXpOQitiNHF2?=
 =?utf-8?B?K2E3OHJsRXRLakkzWkEzYjJNaW10eDVEcjZSNTl6ZlN2TW5tWkVwNTNyZFdp?=
 =?utf-8?B?MS9RWjg4b0ZnU1JTaXV6UldLV0xRRndmM052ZEhYZzkvUWZiNy9hTUFHYUJO?=
 =?utf-8?B?djZ6MVR2bmZwMFM0eHV6ckFwWXZOZnBZMkpnWnozWHVxMGR0bXdkUGRldVNL?=
 =?utf-8?Q?exn+W6Kw3I2SfaeygBiG4NSS6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08cd3ceb-b300-400f-f5b7-08db500a94d1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 21:24:18.1977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dLtgiSbxH/teHj0u7zuQtGOCBUEWW27XSOA83vipuDX6aQo/ooIyXMT/MhHy/iIkDGuORUjL3C0X9KYvJiNzUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6676
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/23 10:10, Melissa Wen wrote:
> We are enabling a large set of color calibration features to enhance KMS
> color mgmt but these properties are specific of AMD display HW, and
> cannot be provided by other vendors. Therefore, set a config option to
> enable AMD driver-private properties used on Steam Deck color mgmt
> pipeline.
> 
> Co-developed-by: Joshua Ashton <joshua@froggi.es>
> Signed-off-by: Joshua Ashton <joshua@froggi.es>
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>  drivers/gpu/drm/amd/display/Kconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> index 06b438217c61..c45a8deb1098 100644
> --- a/drivers/gpu/drm/amd/display/Kconfig
> +++ b/drivers/gpu/drm/amd/display/Kconfig
> @@ -53,5 +53,11 @@ config DRM_AMD_SECURE_DISPLAY
>              of crc of specific region via debugfs.
>              Cooperate with specific DMCU FW.
>  
> +config STEAM_DECK
> +	bool "Enable color calibration features for Steam Deck"
> +	depends on DRM_AMD_DC
> +	help
> +	  Choose this option if you want to use AMDGPU features for broader
> +	  color management support on Steam Deck.
>  

If we can drop this (i.e. don't offer a CONFIG_ option to allow enablement of
the uAPI, but build with -DCONFIG_STEAM_DECK) it would go a long way to keep
us from requiring to support this forever.

Harry

>  endmenu


