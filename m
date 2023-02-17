Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753D669AC87
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 14:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjBQNak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 08:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjBQNah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 08:30:37 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F2A68AFD
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 05:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676640610; x=1708176610;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vK0TIl39AXPmC24xjYgPptA0JfyhNO9tCeFyQ3DnkJc=;
  b=K00Gk5pbWYnmbgBWZGa+ggTapcD9iETnCz0UDq7WqMhvq/xGH1BVZ3g+
   7xtJhon8Hw8toTxw7BVsNAi/R3Fn+OBv2iC1e+OWgOViC6LR8ipZtyg9I
   06eEQdP8mq18wAT+az2ECa/U36ehzfe7aTdd+PHqMIrbec0wO1JDaNqaY
   a2mO+M++EmOmtI32O3GrdA54L12F+wLrUrOBymo1cCNM9op9DdA/peWU3
   YY735dR3+9n3ZZN4O70PzynhkCBdmxFDX1kBbpyRfJ3uq/jgHKosFqwaq
   teInArXUTPAIvC/+Dx+tQjMKlODBaW7bUKNNRZ5lR4NJqQCoSgFVMCXGD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="334182602"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="334182602"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 05:29:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="700898582"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="700898582"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 17 Feb 2023 05:29:47 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 17 Feb 2023 05:29:47 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 17 Feb 2023 05:29:46 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 17 Feb 2023 05:29:46 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 17 Feb 2023 05:29:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtsxnFTueADLzUwUG/eVngwNOUPTeBJV3wJj/V9GmL+VilpLDvrDILD0dmNSWdXfRumHkEEqVcUXD14oX1i2+N7L0T+1yvDqGuPDEy5XC8dN7+ORZL1fsHc5P+G4MfaQQE1OfJ6Tj997TU7MIYLDIMp6SgJdAKUtC923cKjHCrP2K1qn+9+WMgDgSy/3/1jt1MLxKDNTpYv1P5rJ3e252oXP0i/QBpjL9ora+kcAOr+Ubo7oOdnNhdgyJbZRoXGSQDVNP8b+Zl0+nfPjLcAnw8N7p3wK+a8VtGas8Ibd12PjS4dBc+oulBg0fHchC/3x1x8pg5V/0jWpUsbSBR558A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Au7KtVL2MMWDIw2Vnj67IbxzMBMnTxOs/xOdZoT1++o=;
 b=mrAXKe3NEcQhk5f3LPgsoICVdHSyK08+E7/njoTe/6ie1JVtFGGdUzMR7k3ntWSuSYGTcc1OlaTA/y+QWbole9HBFgtk35Buu9JgDV3NcRUY3+qAK0C2gqLStHanwyHOQgfAlcSdf+GyZebE0R3SDMqfuuqGsyphyJ9wwVREy3HfSzEe+UMzPwRRc2WddFtYZOsOIhqNCScxPLlMMyvsP5vFcT6xtKh8l8QNLJVk+BsF8LGb0Ctx/MScorY/jPx6A4WvQgYMijy7My+092r0Hh0w29EP1edMeYL2ExBlxjA0ab95Jaob8npQSu4oSa4gAaK8i8lOI24O2PKXpX4rMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CY8PR11MB7921.namprd11.prod.outlook.com (2603:10b6:930:7d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Fri, 17 Feb
 2023 13:29:42 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::3ff6:ca60:f9fe:6934]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::3ff6:ca60:f9fe:6934%4]) with mapi id 15.20.6086.026; Fri, 17 Feb 2023
 13:29:42 +0000
Message-ID: <0877d757-275e-2c82-0e08-5c9ccd27be1c@intel.com>
Date:   Fri, 17 Feb 2023 14:28:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re:
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v0.c:1170:1: warning:
 stack frame size (1168) exceeds limit (1024) in
 'dr_ste_v0_build_eth_ipv6_l3_l4_tag'
Content-Language: en-US
To:     Muhammad Sammar <muhammads@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
CC:     kernel test robot <lkp@intel.com>, <llvm@lists.linux.dev>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <202302171359.vvB4yivq-lkp@intel.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <202302171359.vvB4yivq-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0198.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::23) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CY8PR11MB7921:EE_
X-MS-Office365-Filtering-Correlation-Id: b5582e12-7566-4610-1333-08db10eb06f7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mXAUiCs71VD+cvFBIbEx5QxdMw81R5lYmaaNkRKRizcw1Izy/G/apsZF0GmXky3PuXDXxkjYx35RCmu8ZSxpxK5zZZJKccF260ptK3GjNryMbL3Evq1QRRgwW4UhAElgLVGP59FX6h01LXUTIURfTzLvVIgv83t5vz6Y7jJyEI0DdqeXWBwP5jY9H0eaOmAqCFjw6ufBUx5/qQiwyZ5q9/APdfBZXMTy9qqX9ET70b6pmGWo+nntQxjdjF41SwG7DNW1wehwNTpMgy+pHbR8UeJIwuxO/5cmOdVrH+oexywY5IYk249FPpk5h0XJhCgTGTFQweK3r+NNDjFkYiCatp+absgAE7WWNnHiKJJRRujt/VHMOSy7tBVxDHUiHhd4PBU+KC3FNDJ3xsM5+71nvepQ1Gbd3fpTaRY5aG+NC0m/TGM4iLFKoiekdpam21aFBBtkBH7h6rLVKwZeJE6dZQD626hppmVJ5vnOZOpM6Tvl3H/o5Y++fpHobQ8xefN2V5BVRe/rhkHxdzSOxTMYNquaLQ1umIxrqctp/zno0XQZ5XfTe8MziUBHP518mX08RWyrEnvPQOtSMRhJBuTMTardAOnr+uAn1NjtMqzdl1VDna6RDSTnw9hp/A1WfOFKg9n3MzdXnfNP2w0NhrBTQIbN+L+9qeVjvfyaQe0e5PwKRXLIM5Rn3kZf9TITH0X8IBLGS74qQZnodbNUEKB3eOhDLGa/c2cgGFWrzQQ/lzIkEXcoNK29qYY/YesPiekc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199018)(31686004)(66476007)(66556008)(83380400001)(8676002)(4326008)(41300700001)(82960400001)(38100700002)(66946007)(8936002)(316002)(6486002)(966005)(110136005)(5660300002)(2616005)(6666004)(36756003)(86362001)(2906002)(31696002)(6512007)(26005)(6506007)(478600001)(186003)(4001150100001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rk4vSWRuUmF4czdWV1YveldvQjNKTUlhVXJQRXpBMzUvS0xKanlZMWlUZ042?=
 =?utf-8?B?SklSQld3dllJd1ducUtTVnlIYlFlNm5xQ0hYR2kvcmNYZ0FSaVN4b3BlRWFu?=
 =?utf-8?B?T2pWbWNNRVRreXFQTlZaMEQ5UEpzUXhsTzYrcGpYR1lhcUhqZ21EQVBDOUNx?=
 =?utf-8?B?NEd1UytuVyt3eUlIZ1g5UmhxaVl0Wi82QjRzenB0akJDZHRBZTV4bzY2RDkr?=
 =?utf-8?B?Z3BGSHZNd29LZis2Um9vTGtTLys2YWVYRVlqK2dzMTlKcjZEUkgzUlVqQkJr?=
 =?utf-8?B?N3NnTGwvTFdyK3RtTE5uVmJST21sMk1ORHRlZmpPaFNQNnlqd2FkYTdVWmth?=
 =?utf-8?B?RU16QWVQa0hoWFZIT0I5bFZBRWg1MWhtbkV6bmtFQ3gzRVRSbnFXN1Z6MThx?=
 =?utf-8?B?ZFJzT1RIWWFwYlNvaDIzRGlMa3NRQWNuQTlOcndGRHRIMEIxSTRmRmVHcmdh?=
 =?utf-8?B?MWlpck1XbElRd0tyTFUybjFlOFcxVEVPVTRVczkyYllZUlFoVlBFbitLZUxZ?=
 =?utf-8?B?NldDeXduTHJKOXFINWZxbC9pWk1BOGtNeFlUc0IvWTRBdFpzaFgzQmQrMTUr?=
 =?utf-8?B?bVNhell3YzY0UDlNUlgyTnRlUlpPUXFmbHFETmsxMm84QlFTRTV6MXdCNlhr?=
 =?utf-8?B?V0RURjJpOG44OE84T2UzdWcyRWk4RWROMlFmRngwTklSR0Fyd3F0b284dXNS?=
 =?utf-8?B?cTVzOE9XM1JkMFJUOFpXN0wxaWRNNjBoOG16L3U4bDVIbDRVOHV3dThCSXJ5?=
 =?utf-8?B?aklCa1VFOTJiRVpKWW9oRVl3dFQ0NW95b0hZU3YzSkNpb1NJUWVsNDU2b05X?=
 =?utf-8?B?WGhWdmRUcms2MEE1emx0TUlCbmEvSzh6eEZTQTBXSUNxcS96bnAwOXpoM21G?=
 =?utf-8?B?bS96R0J0WnRETUZSNDJ1SmNSWGhIZVNkT0lYdHFqbXovMHVZV1hmdWZtOHFj?=
 =?utf-8?B?TEQ3dmg2MXhaVCtjV1NBdHVJai9JUXNHZEhnWkNpQ3BsVExCcUtxVFJYNEdh?=
 =?utf-8?B?dm1nakszb2E1UXIzekpKL0huTU1FZFBIQXY3Y3NMMk9hOXlmNFRlTTF3U0Zs?=
 =?utf-8?B?dW8yNXlVZGlNc0ZKbEVTanFrVDVUdjFIMjFwOXlEZjJoUUcxM1NjUGlESS8x?=
 =?utf-8?B?ODNqKzdSOG4zcEV6cm1SOTY4VkpSekY1eUZmMGxUL0diYmNhR2VjcCs1aUFO?=
 =?utf-8?B?NnV0ak1LaUIvOXlsQzY2bFdGRHIxZjRTOWpybWFPL1lRY0MvVTFJeU9oY1ly?=
 =?utf-8?B?SUhVeDV0UlU1ZWwybWNXN0JhVXlnQXVZK2dpYlB3bnFubXUydmx1ZlVGS0xs?=
 =?utf-8?B?SXVBdzl1c1IrSmkyL3FZYW4rVk9ZbHRPeTZTQ0UvRXV6cTQ3RzFHekJzTWdo?=
 =?utf-8?B?UkpFQ1NiakZIZVBjMVBKQlhEbFZyMlJXb3Jxc1J4UEdTNHQ2UCtMd2Zzc3Fv?=
 =?utf-8?B?amhYM3RVVUZnRUJaUWNIaEVCVlpNRm9DVUU5SnBndzFVK1JLY3ZrNkxpblUy?=
 =?utf-8?B?ZUtLVzRyemNaS00wc2pzSEpKVDczWWsrUERzdmZ4c3RoWU1vWTdsdWY3Nkp2?=
 =?utf-8?B?MlE2TVFNaTU2T1ZZMGpHS25XYTEvc3R2TUJDcFlGV1l4bVdFTVhtR1F2WHFh?=
 =?utf-8?B?OG1FVDdpbHFJQmFFaUxGdUNiU2ZlSy8vZkNQMEx0OFZzeW1jTDJMem9ibFk4?=
 =?utf-8?B?bWtyMU1CWVNLMzF2dFduZFhNNll6RFl2TVhCZFhVazhQcXVUWTlHQk5WSVM1?=
 =?utf-8?B?Z1gwZ2NhbWtuckVkVXNhLys2UG11bFRKWDdHUXpweW5RYkR1STNyZE5XdXNK?=
 =?utf-8?B?S0lpUnZNdmF2WUtONmZHK3VNcHoyQlRQeThNY0NuZEFvU2VnYVNHd09nSVJY?=
 =?utf-8?B?RVpQNHF6ZEhaV3hNU0I0VXBkYlBBdUZmbWc0eEhOT2EwRVFWcm4vQnFSV3hk?=
 =?utf-8?B?TGFDWjhsZzBMYndERjJESlNJdjVoUzZMOEtiNGdaNGdvbitYZmtieXpaci9Q?=
 =?utf-8?B?dDZzK3IrbTBNcWdGUXJ2dndjbFM1S2VZSWtLTXZRYVladVE1a1VLdGczZmo5?=
 =?utf-8?B?RHZ5WWY1ZmRrbGpRdklSeWJPaWFRWEptVmQ5dTVkblFLZ2lkZTI4SWEraytY?=
 =?utf-8?B?aWtudTlWdU1MbXRoQXJqc1JDMlQ4UkU3U1BrVjg5bUtSTFh3NTAvZEJpMWtL?=
 =?utf-8?Q?EjnFRJr1G4Zyis+dhNJswdM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5582e12-7566-4610-1333-08db10eb06f7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 13:29:42.6084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vasj8sJiRfj5eCWLura+ON2POGfX9MbDZf9zkstwLH0EhXCUQ+NI2L00fjm6DjsOp2VQOZGzWk+2pSqB39P9bdxGMN5HVzlMiY+BgE6aMqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7921
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kernel Test Robot <lkp@intel.com>
Date: Fri, 17 Feb 2023 13:26:53 +0800

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3ac88fa4605ec98e545fb3ad0154f575fda2de5f
> commit: 7766c9b922febe18b4eb124eb731dd9a1ec71373 net/mlx5: DR, Add missing reserved fields to dr_match_param
> date:   1 year, 2 months ago
> config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20230217/202302171359.vvB4yivq-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install powerpc cross compiling tool for clang build
>         # apt-get install binutils-powerpc-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7766c9b922febe18b4eb124eb731dd9a1ec71373
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 7766c9b922febe18b4eb124eb731dd9a1ec71373
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/net/ethernet/mellanox/ drivers/platform/ drivers/staging/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202302171359.vvB4yivq-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v0.c:1170:1: warning: stack frame size (1168) exceeds limit (1024) in 'dr_ste_v0_build_eth_ipv6_l3_l4_tag' [-Wframe-larger-than]
>    dr_ste_v0_build_eth_ipv6_l3_l4_tag(struct mlx5dr_match_param *value,
>    ^
>    56/1168 (4.79%) spills, 1112/1168 (95.21%) variables

I wondered a bit regarding this warning, please see below.

>    1 warning generated.
> 
> 
> vim +/dr_ste_v0_build_eth_ipv6_l3_l4_tag +1170 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v0.c
> 
> d65e841de80375 Yevgeny Kliteynik 2020-11-19  1168  
> d65e841de80375 Yevgeny Kliteynik 2020-11-19  1169  static int
> d65e841de80375 Yevgeny Kliteynik 2020-11-19 @1170  dr_ste_v0_build_eth_ipv6_l3_l4_tag(struct mlx5dr_match_param *value,
> d65e841de80375 Yevgeny Kliteynik 2020-11-19  1171  				   struct mlx5dr_ste_build *sb,
> d65e841de80375 Yevgeny Kliteynik 2020-11-19  1172  				   u8 *tag)
> d65e841de80375 Yevgeny Kliteynik 2020-11-19  1173  {
> d65e841de80375 Yevgeny Kliteynik 2020-11-19  1174  	struct mlx5dr_match_spec *spec = sb->inner ? &value->inner : &value->outer;
> 0733535d59e154 Yevgeny Kliteynik 2021-07-04  1175  	struct mlx5dr_match_misc *misc = &value->misc;
> d65e841de80375 Yevgeny Kliteynik 2020-11-19  1176  
> d65e841de80375 Yevgeny Kliteynik 2020-11-19  1177  	DR_STE_SET_TAG(eth_l4, tag, dst_port, spec, tcp_dport);
> d65e841de80375 Yevgeny Kliteynik 2020-11-19  1178  	DR_STE_SET_TAG(eth_l4, tag, src_port, spec, tcp_sport);
> d65e841de80375 Yevgeny Kliteynik 2020-11-19  1179  	DR_STE_SET_TAG(eth_l4, tag, dst_port, spec, udp_dport);
> d65e841de80375 Yevgeny Kliteynik 2020-11-19  1180  	DR_STE_SET_TAG(eth_l4, tag, src_port, spec, udp_sport);
> d65e841de80375 Yevgeny Kliteynik 2020-11-19  1181  	DR_STE_SET_TAG(eth_l4, tag, protocol, spec, ip_protocol);
> d65e841de80375 Yevgeny Kliteynik 2020-11-19  1182  	DR_STE_SET_TAG(eth_l4, tag, fragmented, spec, frag);
> d65e841de80375 Yevgeny Kliteynik 2020-11-19  1183  	DR_STE_SET_TAG(eth_l4, tag, dscp, spec, ip_dscp);
> d65e841de80375 Yevgeny Kliteynik 2020-11-19  1184  	DR_STE_SET_TAG(eth_l4, tag, ecn, spec, ip_ecn);
> d65e841de80375 Yevgeny Kliteynik 2020-11-19  1185  	DR_STE_SET_TAG(eth_l4, tag, ipv6_hop_limit, spec, ttl_hoplimit);
> d65e841de80375 Yevgeny Kliteynik 2020-11-19  1186  
> 0733535d59e154 Yevgeny Kliteynik 2021-07-04  1187  	if (sb->inner)
> 0733535d59e154 Yevgeny Kliteynik 2021-07-04  1188  		DR_STE_SET_TAG(eth_l4, tag, flow_label, misc, inner_ipv6_flow_label);
> 0733535d59e154 Yevgeny Kliteynik 2021-07-04  1189  	else
> 0733535d59e154 Yevgeny Kliteynik 2021-07-04  1190  		DR_STE_SET_TAG(eth_l4, tag, flow_label, misc, outer_ipv6_flow_label);
> 0733535d59e154 Yevgeny Kliteynik 2021-07-04  1191  
> d65e841de80375 Yevgeny Kliteynik 2020-11-19  1192  	if (spec->tcp_flags) {
> d65e841de80375 Yevgeny Kliteynik 2020-11-19  1193  		DR_STE_SET_TCP_FLAGS(eth_l4, tag, spec);
> d65e841de80375 Yevgeny Kliteynik 2020-11-19  1194  		spec->tcp_flags = 0;
> d65e841de80375 Yevgeny Kliteynik 2020-11-19  1195  	}

So you have 11 _SET_TAG() here (each of them is MLX5_SET()) + one
_SET_TCP_FLAGS(), which in fact is 9 more MLX5_SET(). Total 20 and
MLX5_SET() hides a u32 inside. 20 * 4 = 80 bytes, so I still doesn't
fully understand how it becomes 1112 bytes. Probably each _SET() expands
to something more than just one integer (it has a lot of calculations
inside, however, all of them are compile-time constants, so dunno).

One proposal would be to move this block:

	if (tcp_flags) {
		SET_TCP_FLAGS();
		tcp_flags = 0;
	}

into a separate noinline function. Or to try to optimize MLX5_SET()
somehow :D

> d65e841de80375 Yevgeny Kliteynik 2020-11-19  1196  
> d65e841de80375 Yevgeny Kliteynik 2020-11-19  1197  	return 0;
> d65e841de80375 Yevgeny Kliteynik 2020-11-19  1198  }
> d65e841de80375 Yevgeny Kliteynik 2020-11-19  1199  
> 
> :::::: The code at line 1170 was first introduced by commit
> :::::: d65e841de80375372f9842ed71756d3b90d96dc4 net/mlx5: DR, Move HW STEv0 match logic to a separate file
> 
> :::::: TO: Yevgeny Kliteynik <kliteyn@nvidia.com>
> :::::: CC: Saeed Mahameed <saeedm@nvidia.com>
> 

Thanks,
Olek
