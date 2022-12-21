Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF4E653724
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 20:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbiLUTnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 14:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiLUTnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 14:43:17 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B30A1AA09
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 11:43:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCaDh2ovkW5PDu1gNb7uN/zd+h960r0M09Bn7yhHpAoiUEUP2E9UIrRxS7oZN/fU6aEoAoTf1cJR2pZiZ9edfMLKkrCocWcMvBcRGQvhtXyTm0lPvZkpRcZRQrvmCMDlFmEEOTbw0XVTLkZtttcc9bc8wGVGjt+41GcvXZPMhWDswpjBclK+HBDWc5Ny8tgQYfHpkJR+WIl51ZI1dehyE2tR5ure3XDxpF93AbbLFFPRqif9oH2t3ygjfLqs25N/IURCEYzoQ7CbKSbTUaMtJ5Hhdy78Z2w9M8HZ0xhoFN2NRE+z2uIf8PBsMLKOcPyJzei9bPExYgAC7EWAux2KdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43edvZSDfxRBAQhQS0zpP3D1pJdFUB9RMtBBQxdaklM=;
 b=Gc+pITqpVjlHKjRTKGDBhvxQsI6/WrNLQitg7jubqE1kSzD6HEqr6mIwNuQlSPq4ydChbOMYvl1GOJWsv6YME0pl9pRjMRX6A6Q1fTIbPdXJau79+8wnhTGUK7ic4tLCroRKwkwKB0XdSbOHjAuxHJhW9cJr0HqJhF3QhxS0bjfGk8gfpvtY4GMa2WK6o39vAgoGc7fqEboNPYmSXFNl6Tr0yVWXOdO7f8zpjoxjbX3fFolNj7VAvwMje/CirpasnY/qcn5WbygiVkICdu2Zl6Urw0v5Na1giM/I2ET0sm8aemSl9chKTRQU5CkML597yfP69iHVZ6qUPZQQ5OEcsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43edvZSDfxRBAQhQS0zpP3D1pJdFUB9RMtBBQxdaklM=;
 b=RfHiGmUAB0cPEzYrAT+FlsSBwy9GSIVOZFhl4KZ4ibXL97to7BrsbMvEkWU0c4CiiJj5+5RJf4eZdqll4Oika9iP3IzqaXjfgUxwIDMxhQrjkBsREzAILZEHcRSFgDeYFnpf4LNsBhefK/X1FnbQNcS6NO3aVR3kRMaLKSSiH/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DS7PR12MB5912.namprd12.prod.outlook.com (2603:10b6:8:7d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 19:43:14 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::7d2d:dc01:79cf:df79]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::7d2d:dc01:79cf:df79%3]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 19:43:14 +0000
Message-ID: <91916c6a-3254-184a-6b37-b948b1195d1d@amd.com>
Date:   Thu, 22 Dec 2022 01:15:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V2 1/4] ASoC: amd: ps: implement api to retrieve acp
 device config
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     oe-kbuild-all@lists.linux.dev, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mario.Limonciello@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20221221112611.1373278-1-Vijendar.Mukunda@amd.com>
 <202212220159.alghwGQT-lkp@intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <202212220159.alghwGQT-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0147.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::12) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|DS7PR12MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: e80f41ff-97a0-4793-85ac-08dae38b9966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yIo9U81k8xP6h8dftZd2wBUh1pBy2mDC8+0xcwo2eXembqaQUVHZ1KY4WHgoa7qL2m7NRJ7kdTv7NOaPrWSTNlPj4KfS530aNb24qk3aZSfLqpxQeZUuhfeoKFBYMz5qMYva2CL9oOR37Dx2wbBk6eLgMA1jNCz7lYx9Of1RP6b9t8g+rlP4eK5d/mRz0f0Nq/TYaEC4hZXVmfwaj+xH73jobnCiewhzTrBZRE/TAKJ34RvgdMXCIJZvnxvnSod4V0rPJQ2ZbSx5R+sp18h9GFaRn6r9OUK9flN/5HoZTXY0mEITKGJnFnG4gXKQfPV7QsicF7v9Kd9JeCiUOwDdB6sYhl0/bf6S267eBCNS/R/bgXrsMaELanWeTqJfmpi7tb91D1DTcvEEl8g9ysI6mI3Rynd4mcnuHValVQJrAoH6iDY9+AoIhdiqQsxjaEuB4bUMaO8K7WIhEQrxqMQyoInA5ylsyjw7jaaZflXjT5k/HxFWXFJWLXkfa0pHfGEV8MP/cRK5szONag2fonNuvAmPpHsPGnFlekUgCuk17FWgnjCV88BBAFMtzvHql7eo/U1MEXMEyLbUiE2ULt53RzXXwMpcsW+I0wyFcI+dlUTMdz9MALcRa77tspQtLNlB0AKfnTsJpnFWtF/LjmbZ1Yw6bAomV4RuHz1uyzHDwVyE7MWvihoaCZQBOKxPgJhAFdhn65A8dc7W6tHtdtAKEbDGrrOth/45/nxEOeT738r5bd2JG3T+gkJuD3vL3xrPj+9gvev24LYy2uoNQdNvfu8vMvOoBRBXlCqDfI5yh6YkMSW7dJwpNQpbaPU8akxa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199015)(86362001)(66476007)(66946007)(4326008)(8676002)(316002)(31696002)(5660300002)(8936002)(2616005)(66556008)(36756003)(6512007)(6506007)(6666004)(53546011)(41300700001)(26005)(186003)(83380400001)(38100700002)(6486002)(54906003)(45080400002)(478600001)(966005)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnFFVDJJOFFpQ1JUWWRkd3h1YVdMTFczSU5HNkhTS085Ym5CNmNEM3JCVSth?=
 =?utf-8?B?TzdqbkpnblB0cndEK1YyTjhtekltYzZReUtrSGxsQWNacVcxMEhOLzZPOFB5?=
 =?utf-8?B?TGxmRDlrTXZNSzJDYURhak9sc1ZjNTlvN0Nab25XQzdFVVFyY0VMRzVaMWtR?=
 =?utf-8?B?SGZoSi9nTkVINWFOakdFT0lJa2Z1U0JqL1VEbDJyN3NUa2NQblpmNXNlVi81?=
 =?utf-8?B?TkRHL1Z6T1JVZXZyNW45TFdYUUpraXdETHRia0dXbDVWQ2tydElJQ3hnMFZF?=
 =?utf-8?B?Y0MzdGIzZjBjYmtsWjB2WDZSeWFJZXI4TmZobi9RR0VEYUVEU0FzMVN0Mk5r?=
 =?utf-8?B?eHpEVSsrZldPSWNUazR3VFp3S0p6UkhYK3p3ZUNIdDFObU5Xb1E5T3Z5V1Z0?=
 =?utf-8?B?NUJPR3B1MXdEWkd0ZlY1YkdReFBGcm1OWWxMdTJ0OWtEdlR0RnZSUERoWnBn?=
 =?utf-8?B?VjJDdTVySjBRQ0NBZmlZblVQWEoyQjNiRzY2dzE2RkU2Z2p0cldENTNLWHZK?=
 =?utf-8?B?clBDNTdwNm1LeXdUKzNHTVI2NGcxOU9SckdXVGdsQVFnU2dqdXFRK3c0VE1C?=
 =?utf-8?B?ZEpsSnJHRGplTGNRelRCRHhlTzEwSUR2cTQ2M1pSUVZicnhXSDJTSFhnNklE?=
 =?utf-8?B?a3drenVnbk1ka0tZMjNEMm1naHRJN3ROSThPM2hYQU9UaUkzVCt2NlZOVXVU?=
 =?utf-8?B?UW4rTS9uVldDdnF0aGdHZjM4WSthaTBUbG9CdXREVUFGS0x1TThIcm9LNmdO?=
 =?utf-8?B?YTc5QW53QmFseWNRbTdRNm1YME95TU5sb3Y0L0pNQlhrSzZJQUwrWU9sZGtZ?=
 =?utf-8?B?YTZIUnhtUDhHVWg5N3MxV2xTajVmSEhXZUU1eUZCTkR3bXRXeDg3YU9hTUha?=
 =?utf-8?B?V0xIUnl0R0x3ZVZGZ3FvMHpzano1ZUVxeGQvTkdEcUdQZEhkdnlhL3g1OTkz?=
 =?utf-8?B?UHplMm9Nd3lSR3Rsa1F1OW4wakpRQ2Z5OGJkZG01YVJPQ3RWVFA0U0p6dHRk?=
 =?utf-8?B?YjB2WGtWd2pVbzM5VTRYVnN2bXRJVEowb05wK0ZkakZQZEVEQlhLL1gzRFow?=
 =?utf-8?B?S25vNy9RRmNKVHBOOThiWDFNWjhFVWtoNXFKVXZEVnN5bkJYc3ZoRitOWXFm?=
 =?utf-8?B?c0hDcmU1Wm1NMWNmaHBDczhZWUxqVUxVc2NsTVBKQzdGOEZrUkhqUWV1dnBa?=
 =?utf-8?B?V1BORjd0YzBkTkVLYXV5Tm05eC9EUkNtU0h4Z0JDWUF0cGpZWHBKMkhvNWZS?=
 =?utf-8?B?em1QN0ROcXl1cUtCR0xXZWRrOVc2N0FTdHA1cG9RRDkrLzJzc1NjSzhiWktE?=
 =?utf-8?B?MjF3R3pYNGRIYmFZOEdGakY5OGlZbkxzbHAram1kV1o2a3hScncydWx0TWdn?=
 =?utf-8?B?TzMvVVVSaFUyNTlHK1FIMGxYNVFEV3IwVjJZUnVUOHRrZFhWSmZFTXJZd2xS?=
 =?utf-8?B?UVB0dXFTb1RGK1pVRElUd3RVeWM2N0todmZja1Z2NEVOTUo3T3FtUVpQcDZ2?=
 =?utf-8?B?QlZTUkVGS1BiY0RuRit2VUdvb3pQekplUUlkcVpHQU44ZnpWNzlFNzVXZ1VZ?=
 =?utf-8?B?Tmk2S3dqM1d5Q1g0RXFHU2NFV2l0MDRmNG5aK2s1WHp1VG0wY0tiSG9aWmRU?=
 =?utf-8?B?dENNaUswYkpkS0FmTmQvNTBZWlRFQUk0UTY3ejhxckt2NTEvbE9HYkxCZWEx?=
 =?utf-8?B?K1lWbWFZdlFGNTNnUVJCM1FNVFg2ZEozRGN6WXdQTUVEWVp4SlRWNmhWcCtE?=
 =?utf-8?B?cnNJcHR3YW9kVGQ4ZnU0YVZxQzFnUEJrSldyMDVJSnAvelVWMlpZei9LdXBk?=
 =?utf-8?B?RVBZQjN1ZWdqS3lRV1IyOWtKU0Y5a2MrM1lMUEhlWlE4QkRGUUlSS0hrVC9K?=
 =?utf-8?B?RlJ4eXEwSTdyRTg3cEg3VmJ3U0t1MEJtdlk0Vmw1Z0N1WW11KzVLVERUVWRx?=
 =?utf-8?B?RkRXM0NjR0J3ek9Md0VHUEh0SlRPZElpcnRMZ0pMcFhFSTEyZTh1TFRpcWNi?=
 =?utf-8?B?U0NyMExiWFNlNWx0K0FSbnhmMVhJZFZhOUN5M05UMG5uL0R5TVFlUHc2aWs2?=
 =?utf-8?B?OVNuV1FYQWFobDRvNlYvUjdMOVo4U1VpMTB1RHRMSHlCNEgrbGt3dC83SzUy?=
 =?utf-8?Q?RsqU+/AEbE6WmOUMgpQh+Uo4y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e80f41ff-97a0-4793-85ac-08dae38b9966
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 19:43:14.3531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: buF4Z3EgJ50onAW0a+Q91Api21rq84RSlC/ROYbBF/9B4+YCb0auwgGesgmOK77hendXkk3ZBbt2h+kTcjXaGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5912
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/22 23:10, kernel test robot wrote:
> Hi Vijendar,
>
> Thank you for the patch! Perhaps something to improve:
Issue is already fixed and updated patch series as V2 version.
Because of version mismatch , test robot picked older patch series.

--
Vijendar
> [auto build test WARNING on broonie-sound/for-next]
> [also build test WARNING on linus/master next-20221220]
> [cannot apply to v6.1]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit-scm.com%2Fdocs%2Fgit-format-patch%23_base_tree_information&data=05%7C01%7CVijendar.Mukunda%40amd.com%7C77e7d774bd4b4dd1165308dae37aa5a1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638072413166143017%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=pREy1cj%2FssW267IS2cjwj1HM%2Fz%2FtFwMuFFAPsyEojso%3D&reserved=0]
>
> url:    https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fintel-lab-lkp%2Flinux%2Fcommits%2FVijendar-Mukunda%2FASoC-amd-ps-implement-api-to-retrieve-acp-device-config%2F20221221-192703&data=05%7C01%7CVijendar.Mukunda%40amd.com%7C77e7d774bd4b4dd1165308dae37aa5a1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638072413166143017%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=FsiiH4axp%2FR%2F2SoClKiyisUtDb3kR18d%2BnsgjYhjUiA%3D&reserved=0
> base:   https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fbroonie%2Fsound.git&data=05%7C01%7CVijendar.Mukunda%40amd.com%7C77e7d774bd4b4dd1165308dae37aa5a1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638072413166143017%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=mhxTUjZwUkE6qSX2E%2FFdeNkvcxeUUGGLa0TiawEKcUA%3D&reserved=0 for-next
> patch link:    https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fr%2F20221221112611.1373278-1-Vijendar.Mukunda%2540amd.com&data=05%7C01%7CVijendar.Mukunda%40amd.com%7C77e7d774bd4b4dd1165308dae37aa5a1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638072413166143017%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=ITTW3FXkEw0X7GdiqzG1dvdrS4VcemqldLWkFJah%2FU8%3D&reserved=0
> patch subject: [PATCH V2 1/4] ASoC: amd: ps: implement api to retrieve acp device config
> config: i386-allyesconfig
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce (this is a W=1 build):
>         # https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fintel-lab-lkp%2Flinux%2Fcommit%2Fa47d6a455ff7716688a8c7efaae89f07cebf118d&data=05%7C01%7CVijendar.Mukunda%40amd.com%7C77e7d774bd4b4dd1165308dae37aa5a1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638072413166143017%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=WP%2FmbWI4Ry4pbUBfh6lx%2B4PxXz1TpjaXf6YIx7J71Nk%3D&reserved=0
>         git remote add linux-review https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fintel-lab-lkp%2Flinux&data=05%7C01%7CVijendar.Mukunda%40amd.com%7C77e7d774bd4b4dd1165308dae37aa5a1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638072413166143017%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=koa4GqupLUfcvkCsQ2MD%2FUNkkF7vhYoBXMYzKg8k%2Bus%3D&reserved=0
>         git fetch --no-tags linux-review Vijendar-Mukunda/ASoC-amd-ps-implement-api-to-retrieve-acp-device-config/20221221-192703
>         git checkout a47d6a455ff7716688a8c7efaae89f07cebf118d
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=i386 olddefconfig
>         make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash sound/soc/amd/ps/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>>> sound/soc/amd/ps/pci-ps.c:135:6: warning: no previous prototype for 'get_acp63_device_config' [-Wmissing-prototypes]
>      135 | void get_acp63_device_config(u32 config, struct pci_dev *pci, struct acp63_dev_data *acp_data)
>          |      ^~~~~~~~~~~~~~~~~~~~~~~
>    sound/soc/amd/ps/pci-ps.c: In function 'snd_acp63_probe':
>    sound/soc/amd/ps/pci-ps.c:231:74: error: 'ACP_DMIC_ADDR' undeclared (first use in this function); did you mean 'ACP63_DMIC_ADDR'?
>      231 |                 adev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP_DMIC_ADDR, 0);
>          |                                                                          ^~~~~~~~~~~~~
>          |                                                                          ACP63_DMIC_ADDR
>    sound/soc/amd/ps/pci-ps.c:231:74: note: each undeclared identifier is reported only once for each function it appears in
>
>
> vim +/get_acp63_device_config +135 sound/soc/amd/ps/pci-ps.c
>
>    134	
>  > 135	void get_acp63_device_config(u32 config, struct pci_dev *pci, struct acp63_dev_data *acp_data)
>    136	{
>    137		struct acpi_device *dmic_dev;
>    138		const union acpi_object *obj;
>    139		bool is_dmic_dev = false;
>    140	
>    141		dmic_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP63_DMIC_ADDR, 0);
>    142		if (dmic_dev) {
>    143			if (!acpi_dev_get_property(dmic_dev, "acp-audio-device-type",
>    144						   ACPI_TYPE_INTEGER, &obj) &&
>    145						   obj->integer.value == ACP_DMIC_DEV)
>    146				is_dmic_dev = true;
>    147		}
>    148	
>    149		switch (config) {
>    150		case ACP_CONFIG_0:
>    151		case ACP_CONFIG_1:
>    152		case ACP_CONFIG_2:
>    153		case ACP_CONFIG_3:
>    154		case ACP_CONFIG_9:
>    155		case ACP_CONFIG_15:
>    156			dev_dbg(&pci->dev, "Audio Mode %d\n", config);
>    157			break;
>    158		default:
>    159			if (is_dmic_dev) {
>    160				acp_data->pdev_mask = ACP63_PDM_DEV_MASK;
>    161				acp_data->pdev_count = ACP63_PDM_MODE_DEVS;
>    162			}
>    163			break;
>    164		}
>    165	}
>    166	
>

