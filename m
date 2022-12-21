Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE43265345E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 17:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbiLUQw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 11:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiLUQwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 11:52:55 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922F77679
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 08:52:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hq+YOATGJ2JsJUX3BE1PTxPgRxgmaVTtpoKgNRAKpxGzn52Tb25HqE6jcUByUvaay0kwfq9pjjXGk3s6DjXofTq05YrM2LbUv63GtEpmvECvlTZNyqIfdcKMSRKas5ab2sfQNPbtS7Cc7srQxApXU0lu7QbJVsJ1qi7vwGkQAZcU7vWRCvL7xGHYtQI5ZWuLylEY3wLFDpF2hlokwRqoLHWs46ylZUbOR1CAPnNRRUKR0oRwCWH7QAJQY1ykY304Mbz6RUQeOmvpFk6HPo+gYp2BCC9l2G0xz+8DZpoJ/ehk2YJ4qH1eEKt4gWbSfUH4rbK2k8JjHg5qbDEvIjlRQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnviDfjDncYP7duZytT8HerOvdsH8tW2tTgyISbEXrA=;
 b=Llu4hRo+15KMW4HhVOzRLdOCyxI3jPsc6hW+SwBhrrqn+0gscVJVBYyFBU+puz6q/IKk/n/zpvVoqRSXratj7lpqX4sgVYrgvRtFgCLOjptsBxxtkGFtKG8MP8C7Q+xxeq9QQSuz1nMyhOnxoRZtfVnhKUE7zvkSolgwFRWts842P+jC5eSgsyEDpKZAQK8FQ1M7TZKJRCVCOs3KPaCxkx75M7Q2qzENq0+T26HqySUJ94aUP28SQkf81Fwd+7LVCy4w9cfE4wbgvN6LLKmfA3z5Lpok4tDAlNnE2Ckgru5gDAvcbjPiNIQ8IjXmH9vaj85rJqbnQ1a1XQQFxPeGLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnviDfjDncYP7duZytT8HerOvdsH8tW2tTgyISbEXrA=;
 b=rWPcBf+7pUO/C1cIjabC8IhPym8IILxWm8qKAZXWlag396MdkKunzNdjJGhNl6Pn5ZCF5Kb7GElo3UZc3DI/r5SWMEvJ0S/BV93lDxR5NMr1P1tWs37webk/5tFtLeT3gfHuUIG984X8JCIRzCIcxCG2k4mY1rQjvKQmRYEOY38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by PH0PR12MB5436.namprd12.prod.outlook.com (2603:10b6:510:eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 16:52:51 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::7d2d:dc01:79cf:df79]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::7d2d:dc01:79cf:df79%3]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 16:52:50 +0000
Message-ID: <7fe4d8aa-ea13-bb78-655e-b6122e0b35a4@amd.com>
Date:   Wed, 21 Dec 2022 22:25:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V2 1/4] ASoC: amd: ps: implement api to retrieve acp
 device config
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20221221112611.1373278-1-Vijendar.Mukunda@amd.com>
 <202212220044.5C92oI7z-lkp@intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <202212220044.5C92oI7z-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::10) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|PH0PR12MB5436:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ebb5fb6-89e1-4252-f0c8-08dae373cb88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kxz/xM5yapbbHzfSLvygwbd9xrBlieBNuCeBGKtSRNmo2NAjFeeAlEVYFqaCsf0PKd5FKbv+5EbcRGICg3KGiBW09eKpbRGcQorROgHA8uRK652FQgJA/2EJnHEgR8SpJkvfFAl8dRCN/4iVuzPbcs0VXrCTWG9FRioCurwBnEeqT4EuRvCCalYTI4KVkeR31RV6nhuyNrE5UxzP4LEb/X3+KhfMo2FV3vyoNc0Qghu7QBE7bPJKkX5PALokiQP1Ndftj4nSBNcBc/a4rZ5caULp0WTBcvI4jCn1tc40Ry8HKNk+uLv8fqiGs0xx3iM28as+hQsTaWoHmdUbQ3PZk0hHix665RSqYAW5HyljCvO+DONeVbtlHxZylE7iugg56iwA6CaYzBUdk5rLyesL5amWipJpR6lBNrUKMw3ilgqP1CNw6uNUr6f2or3dl3JoQkdlIoOOYVKP/z0jDq5mCFolTNedWF0wzVruLMHg2UCl+rMbQWLnamiHATuomhTRpkgsW86t2tqu/FnSCiO1jeiAjD0rydJcv2mJjgzgbckpHuOL6RQzWmR0VoWQbPye7iRGXMe2QoXyqkwQUrNRVUyQUavZKHkFzXxqMrWbjnV4wkArgUu0IHSkMm/niIb0zkGJlWMlCE3ZYnZISj8G20DwXJr7iT7HaSpiPUcjTz9thU1s5vmiDb76GcKehBH9xP3KBwtKPTNQPXuNmT7q2D7n4dhm72l1BqJ3O1yIMeQ5UUuEl40OZgmlRV/onTouzHpJZpzf8hNFGkSVIGmLjypTmEmBc/z9LekAIIFYIp4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(451199015)(31686004)(45080400002)(2616005)(186003)(6506007)(6512007)(66556008)(478600001)(26005)(6486002)(8676002)(66476007)(66946007)(41300700001)(8936002)(5660300002)(83380400001)(2906002)(6666004)(966005)(4326008)(36756003)(54906003)(38100700002)(86362001)(316002)(53546011)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0w1S3huWUVGVmFHK1QwSGE5YlkwZmhxaUpnNU8xQTRKSXN4SkI2MmhzSWVo?=
 =?utf-8?B?S2FJOXo4cTVNQU1xekU4R1N4eG8yZlFSNGovb3hmN0VMNUtmdkRvNG5INlYr?=
 =?utf-8?B?b2lxTUcxeFNLQzRFSExGbVhvMW5ZdWdiZVZuL2NwWmV3bTZLUXN0SnYrVzhZ?=
 =?utf-8?B?Y043QTJQWmh0a3IyazJuc09vZnBpQXZ0RWZINTNJNFE5RVVZWUZTeXBPR0RY?=
 =?utf-8?B?SmRQd05hRStNa0pES1RtcHFxNm5HbnlSM2xSbWNmVVlZQ2xDb09KV1FyMEhG?=
 =?utf-8?B?MnNJQzVWMFdiQk13TEkzM2dsYjlhcFdMcGN5UlNncy8yeEhRRitucEVib3Vx?=
 =?utf-8?B?UHpUOG5zTGtWZkhRNjU0VlpicjlDYXJlZmVhZ2hpU2VrOVBSZkZwbUdBTUdN?=
 =?utf-8?B?NmJJbmNzdTloZHBBSmpkSzhJR1JlU1poTk16K3cyNGlLZUNld3g3eGw1eXRo?=
 =?utf-8?B?YkdlVUlaVGdkZWhJblNtVjJEdkoyazBBYnlXTjdKcVMvUDh4cGFhUmJkOEQy?=
 =?utf-8?B?cW1zemZOSnEva1ptc2J4SGNWTUVWbkpBVnpab0hqVXZHZzNrQ0h5TEJDUUQv?=
 =?utf-8?B?MTA4TU11eENHclZCcThiR1YyM2RNRmxCOStSVXpROTFsQ1FpdlFXVXI0ekI4?=
 =?utf-8?B?Q1hGQ2xWTDU2MW1OeWNJR3dqd1dtWWEyTUJuZWkzR1JseVg5MHErN0JYUGg2?=
 =?utf-8?B?MVZzVElMdlRSYjRsVXM3dFAxdngwN2VZRU9aYkhIS2hVc0VDTXc3S05QeEEy?=
 =?utf-8?B?TG4rcG9FQUE2Yk5Td2M3anhPMEZEZXZhUVl0Q0JnZVA3Q3NOTmhSd3ZNOGFy?=
 =?utf-8?B?UUtjM2tUT2NWeEprQWIrWWp5TnR2YVU3b0pQMWhidDNaZ0xSSVJNcWtLSzk0?=
 =?utf-8?B?RVhnaDNKdE14N3ArQ3gxdm9WcXBvS29WbTBrMU80bnlIZG8raGNYUFRCeXRi?=
 =?utf-8?B?ejZwL3I5ZHorbWo5UXd0dk85T3YvQktLQlR3ZHNzcVZLU0k4ME8wOFR2NWtU?=
 =?utf-8?B?eTBoWGxpVVprLzlFaFlrMnpTdWc0WmdHYkNBMG01bVhQODQwS1Nidi82OGRm?=
 =?utf-8?B?R2FXTWMvZkY0TExla0JJZTFzbVJnUHdVUXUzdHNJZ3ZDZlZNaFdSdWllVFlj?=
 =?utf-8?B?TW00MVBNKzFGWHQ5dll4QkRMSmdWSEdQZUdhWENxcklkR0pWYXVOVkR2RDhi?=
 =?utf-8?B?VUxNMTFHRkdSejA1V1JRZEdRSndTVkV0eHZjK2dzSG5Bb3dVSVNMdUtNY3Zi?=
 =?utf-8?B?U1BzV2FqRDRjNmJyY2ZvL0I0eHBBKytWb0pQNkZOeS80VFgxZkFqbVg0RjBl?=
 =?utf-8?B?aXZncGwzWTlOZk5mYUNFS3h6MFhSYld0ZitYdGZLQk1HK1U1SXRxRi9hUzJV?=
 =?utf-8?B?RDEvY05NbzR3T0pCSzY0WTJLazZxNWczazFlK0c4K0YwWDBCNGF2K2cxQTMy?=
 =?utf-8?B?KzllWEFqQ3cxUE1OMndDazFQTmY5K3I4cW5LYUJiTGliNmdiUHdXODkrTnc1?=
 =?utf-8?B?aFg2NVYrZm5xUmV5bVpxZW1vZHJXUzlCZzNxUDhENmw1QnMzSVhlN21tMm82?=
 =?utf-8?B?MXIyenJkamxWMndZMnpzZzA2VHdvVlJGVVlvMXN3R1lwWEJvUkZPYmFxZW11?=
 =?utf-8?B?OG51anlucThQa0FzNlNYS0JLRU4raitVL2QrM254b1ZqL0s2UHFDWTREeGxq?=
 =?utf-8?B?eDhVQUFLa0J0N1pwYVdNVFkyb3VNc0RBM2NsYW16cGV2OUJodEJ0RGlqODF6?=
 =?utf-8?B?MFEybDdRVFlTeWljVDllOWI2ZjBHMjc1K2VYZk9mejB5Ykx4NmVNdVZjTGpw?=
 =?utf-8?B?eDc0VW9BbTBBUmxhVmFCSzNVSlRSdFZ4TU5HdWl4Z2NTNWdKMCtIM1Q3K1FV?=
 =?utf-8?B?cUxjb2xGeEN6OUJ1U0FpbDBDQjdVVmVEeU5GM2szNUtsNU1GQk1hazRPNi9H?=
 =?utf-8?B?dHZYZytwbVM2M2dCbitLU1dQcXFxWjRZRGxlcmlVeXNJaklUWTJSV09rQTRR?=
 =?utf-8?B?a2Q5SFZyK0lDQ1FkaEI4MEtPVkRzTTk3MFhNc05zMEdSZjZEM2VnUUQySU9q?=
 =?utf-8?B?TFNwTFNLQktFa0ZjSytnQmQ4QUdCQTRJcU9ZWDdVOC9Zell5ME4za1NwMStk?=
 =?utf-8?Q?WLYeaoCYU6pvCdiO8ciEa1xY7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ebb5fb6-89e1-4252-f0c8-08dae373cb88
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 16:52:50.5749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9JEL6e4+xRp4D1btiYaDfnuuwJA1L95zYGPws2QNoq6kGUc2SuHA9e04dkINpYyqG/mKyuJrEA0dxYfUmueZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5436
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/22 22:10, kernel test robot wrote:
> Hi Vijendar,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on broonie-sound/for-next]
> [also build test WARNING on linus/master next-20221220]
> [cannot apply to v6.1]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit-scm.com%2Fdocs%2Fgit-format-patch%23_base_tree_information&data=05%7C01%7CVijendar.Mukunda%40amd.com%7Cf724439b0cd34a8d51da08dae3722149%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638072376572895135%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=SgBlnpPN56oK62ky0JU8azh3nuEXn6tMz3xZbOejY5Q%3D&reserved=0]
>
> url:    https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fintel-lab-lkp%2Flinux%2Fcommits%2FVijendar-Mukunda%2FASoC-amd-ps-implement-api-to-retrieve-acp-device-config%2F20221221-192703&data=05%7C01%7CVijendar.Mukunda%40amd.com%7Cf724439b0cd34a8d51da08dae3722149%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638072376572895135%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=UGJ84JSzprAvXAfmo2OXhrWT3CBFgJ12CzIArUgBEfM%3D&reserved=0
> base:   https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fbroonie%2Fsound.git&data=05%7C01%7CVijendar.Mukunda%40amd.com%7Cf724439b0cd34a8d51da08dae3722149%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638072376573051377%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=4LZbNCMAz%2BCGrAgM%2FsBDxgRx7ose4EyopgsQkM4W8NU%3D&reserved=0 for-next
> patch link:    https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fr%2F20221221112611.1373278-1-Vijendar.Mukunda%2540amd.com&data=05%7C01%7CVijendar.Mukunda%40amd.com%7Cf724439b0cd34a8d51da08dae3722149%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638072376573051377%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=o%2B9ZhXvww%2FKDjm2sfVskOK0pNibVP%2BMO4sJnv6%2FAwRI%3D&reserved=0
> patch subject: [PATCH V2 1/4] ASoC: amd: ps: implement api to retrieve acp device config
> config: x86_64-randconfig-a015-20221219
> compiler: clang version 14.0.6 (https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fllvm%2Fllvm-project&data=05%7C01%7CVijendar.Mukunda%40amd.com%7Cf724439b0cd34a8d51da08dae3722149%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638072376573051377%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=4xoUOqgeepbVj6xehXIOmWaRcR6FhKKmlHnxO0l1HBU%3D&reserved=0 f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=1 build):
>         wget https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fraw.githubusercontent.com%2Fintel%2Flkp-tests%2Fmaster%2Fsbin%2Fmake.cross&data=05%7C01%7CVijendar.Mukunda%40amd.com%7Cf724439b0cd34a8d51da08dae3722149%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638072376573051377%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=65DwVdNjRWKIxNSxqtpFyF0%2FFldAeix1%2FTnZGYSj6L4%3D&reserved=0 -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fintel-lab-lkp%2Flinux%2Fcommit%2Fa47d6a455ff7716688a8c7efaae89f07cebf118d&data=05%7C01%7CVijendar.Mukunda%40amd.com%7Cf724439b0cd34a8d51da08dae3722149%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638072376573051377%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=U9Ko4HNfl%2FfQTaPrCPVH7R%2FG5MIXydh5xtoNbyDNX8Q%3D&reserved=0
>         git remote add linux-review https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fintel-lab-lkp%2Flinux&data=05%7C01%7CVijendar.Mukunda%40amd.com%7Cf724439b0cd34a8d51da08dae3722149%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638072376573051377%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=pEWhdrTN6tbqt22WvlgMAlVJKo43ont0s9fIuFaav0M%3D&reserved=0
>         git fetch --no-tags linux-review Vijendar-Mukunda/ASoC-amd-ps-implement-api-to-retrieve-acp-device-config/20221221-192703
>         git checkout a47d6a455ff7716688a8c7efaae89f07cebf118d
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash sound/soc/amd/ps/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>>> sound/soc/amd/ps/pci-ps.c:135:6: warning: no previous prototype for function 'get_acp63_device_config' [-Wmissing-prototypes]
>    void get_acp63_device_config(u32 config, struct pci_dev *pci, struct acp63_dev_data *acp_data)
>         ^
>    sound/soc/amd/ps/pci-ps.c:135:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    void get_acp63_device_config(u32 config, struct pci_dev *pci, struct acp63_dev_data *acp_data)
>    ^
>    static 
>    sound/soc/amd/ps/pci-ps.c:231:60: error: use of undeclared identifier 'ACP_DMIC_ADDR'
>                    adev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP_DMIC_ADDR, 0);
>                                                                             ^
>    1 warning and 1 error generated.
>
> will fix it and respin the patch series.

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

