Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E4E6A6C1A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 13:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjCAMHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 07:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjCAMH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 07:07:27 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F7937B5D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 04:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677672445; x=1709208445;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8B+OdOP+mGHojVRv4y8L2rJcZVcSJkxDCtxvAtfm0Ow=;
  b=g8ElPYXc4CxQfkDQNoUY+xiqbZ3esGA5jDmpSL0F3WwvGCa2GKIQKhVJ
   5thhXCikiKGqy+K+SVD29Bb7plcwUQcq1Xfc/tjodHG/A7MXz+KcBTw1d
   bq9MdhPfeglhtx6o2KBY6bHmUDMvr/vyBdEEtVeXOfTq1lwfdK8UKU1Y8
   f2jsT35+PPkC6OVGDv8rNKOa49CM11VS1amBeOvFk4hAp/k5wI6UJuUVz
   /7o+9qrjyGjbGxS6I7146RiqAP4hlTukOA8vjI2NYIe/Z2guY3IqRYmV8
   axiazzIj1b9SykrT/7emG+soWxvwoOSbLkhghTcVui/S3K0PryxyNzxCi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="335882303"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="335882303"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 04:07:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="848621022"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="848621022"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 01 Mar 2023 04:07:24 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 04:07:23 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 04:07:23 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 1 Mar 2023 04:07:23 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Mar 2023 04:07:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4Qq6aFJ4SQyOcOdcQyEgt/bxfRYTRepTQ/9dKluwsFGg5oyh1ie1g15g0PZ9jcURHdQ/vXuj52jdx46dElad9/2f7tI9XFtLu3TkY/gw+unsUHUhOFyWtX6f878CRCqX191dWmcGyPxvbicFXFVjSHvMdlLPjx3v15EBr1kPo53UAaNmxKI+yfAxS1we46Ez+qwmvWFQWIwcXnQ4A/CcAd8ViJwNYfdm05B7AUkD/DwNGQJUx13Hjwe50Qx345j4uGcI+WW2OGvJqIoIdND2xu54x80j830faUp1MKh1LdeU3g7F85eOXu9RSajNTv9vZtCNbC8yUgKWP62I92gXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tfba/0+/D58U49hl7wttsPfKU0q1SP2eQIiuCVn5FBY=;
 b=GZXqjbePBVkChndG49pehWlj2e1jBWM02zxUTnq7CIRRZRgrWrv9ij7UraOaTL4/vo2eS0wR6XmGWv9BIgf/C+3XZC5HaCgqoUmbsVqMWxYRUDfOC9cTnlfBkGbD+KFqDTDtXEqPwLcw/5afUg4JJaT+KNEiwtNRGow86KsOGQ7u0Qq6vH/JzCX5haKh7Ff4XfVlzQTiuKZiGVk7aSzkOUN11xBY0gT91Hshr6uMoOhN8ooa0EDJTuBebz4g6JxZXt+P7AsBBYPVHXH5Y7xZcAM38gahGHqwy+T4PcqHdUQIbAhc9nqDXVOxl5Q7dAS73xlOh8srEMNIobdw+kwNVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SA3PR11MB7979.namprd11.prod.outlook.com (2603:10b6:806:2f9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Wed, 1 Mar
 2023 12:07:20 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::3ff6:ca60:f9fe:6934]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::3ff6:ca60:f9fe:6934%4]) with mapi id 15.20.6156.018; Wed, 1 Mar 2023
 12:07:20 +0000
Message-ID: <61349a74-df11-0887-b018-456c14707557@intel.com>
Date:   Wed, 1 Mar 2023 13:06:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: drivers/net/ethernet/intel/ice/ice_txrx.c:1304 ice_clean_rx_irq()
 error: uninitialized symbol 'cached_ntu'.
To:     Dan Carpenter <error27@gmail.com>
CC:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        <oe-kbuild@lists.linux.dev>, <lkp@intel.com>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>
References: <202303011231.SEfXSwLT-lkp@intel.com>
Content-Language: en-US
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <202303011231.SEfXSwLT-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0447.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::20) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SA3PR11MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: e7771e5e-6091-40ab-a188-08db1a4d81de
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JIp24JhWUBtrFA+6ese9Rj413CfF2/EgMf8isuUGlOpjaN/FeBDgjB9emsUqUvuN0xuOvk8cWlR+2wv+ZJeDKfuw/oTD6F9rTiwjJcBf4caTuDbNfkvw5q8wIR7DgsuXUOeQ9yx1MMnqMFBXsJrAf3YT1ZSRSXEripfgxlvzOsZ9Rvs/k7nEiZ6D1pCYdp/WxUyaGqErpA6NJIx/hnVYJle+C0N7W2HerJrNxCQRximRigHdfZLAxljzC8QU/0b88B0bfu9KXsUp3rOgWs1S9zKKvY8zajHksBmMuGfGDmcv3xe17k2KqjDjNgXnRkOlxAHb76RkLZL4o7sjjXB45jlkhGM91glb2FRs4epmsNreCG46qjE5iZaByQNGKwflGDlAeA9d10qltq6mcmcvG8VpHTTzBCxOc7xOT/gr9BjHxyXfTcJxpxuVBPwoiU1OcRMwEyExW05DtIOgcFCykGzyibNIEygUCx5MKx8zMARYzxXauRl5qTX2Tjp7ZY3vNQ3IocfQua6wpHmieDUyp2EMNNKskz6GtXwqlnBPSw/YrQhhH2vj2psaOac71HMth575xAQ4a5vPAAwm52Z0jwtG7cUNxssiWltV6Hi8glbb25g7WHudXvD/1iBrI3NCLPjbvcTxNonZBpXGmO72xZbjjWcV9On59eAmvE5AhADhC2CG2x5tkQj/cWsYE+WfSSFHXRV1eeFpIWI9InptfmLDizCAo5v8MALU6R7GPcPXSeWk06nRZ9sSZOU10Yl45rES4dJjhaFca36vVfvLfjNHoZk8G2GfIFxNCo48rLU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199018)(31686004)(6486002)(82960400001)(66946007)(6506007)(6512007)(36756003)(6666004)(41300700001)(8936002)(38100700002)(2616005)(966005)(54906003)(316002)(6916009)(8676002)(478600001)(66476007)(66556008)(4326008)(83380400001)(26005)(186003)(31696002)(2906002)(86362001)(5660300002)(30864003)(4001150100001)(45980500001)(43740500002)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b003M2JSOVYzM0JvQWFyVmZVYk8rM0dXeCtvamU3enZ6MTE5YXl5TjN3ZHFK?=
 =?utf-8?B?NWlYNDY5elVJd2lqNTVtTkRZU1ZMOVllR1pidjhxUnZUMTlKcW01dXNWTEhL?=
 =?utf-8?B?alYrQmtSNFpSNUU3bjRyWk42Ym0zVW5zSW8yS3pWYStWcDVIdmpkaUVYTytS?=
 =?utf-8?B?WlFJY3RCcnV6c25IVjVVaWRUZk12TTlvOW5obG4vTklnc1FrelVpZ1ZuejlI?=
 =?utf-8?B?V1IzRS9wM3lMQVEybXRTNTRJNnNaU2dtbm5MS1RMNDlTTncvcHNyTkl5dFNX?=
 =?utf-8?B?bjkzTWZYbDY2Q2lJWXpoVmdFejAwd0tsUDdac0JDcTFKenFSc0NPc0I0bHJZ?=
 =?utf-8?B?K0VxRTdORTB6eStpb0FmejlkRmN1SFk4Nzc5MmpGZWtvdS9reTd1YmhibXBD?=
 =?utf-8?B?VXc2N1UyM3ZMQytyMU1tQUtvYVBJSUNuUnRhZUo3V1dpUUhPdjJNemJLd1Qr?=
 =?utf-8?B?ZXQyemtiQ2FGNFRveE5NKzJ1N0QzU1Nka3VxVUxCelN6dzBXbjBhWTR5ZlA2?=
 =?utf-8?B?cGpMN2svVlJwdjRyOHdxSEpDZGZQcld6cUp2eTdQU25LVUlpckMwNEJMalBT?=
 =?utf-8?B?eDR3WUhDMkFURWxHNlFOb0ZPOUxRTHMrSWpubE9IVlBueHE5Ykh0OGduVnpR?=
 =?utf-8?B?cjlZNW9DTXg2N1NQd1lmSXVxNjZCdkgvQlFiVWdWRzd2bHUyT1kyRjhoM29q?=
 =?utf-8?B?ZlZvbCtKTldIZjRPMTRNV0k3Sy9hQ2ZoY3E1bGxFMDA5MEd5M3ROMTBwRFg0?=
 =?utf-8?B?VWhpbk93cGFUT1kyNVNYMHZ0UVlwcUJvT0VYazI4NGVoZHFLaVN2U2xGbW0r?=
 =?utf-8?B?R3paRmFCY0twOGQzK0NldXQyR1ExdHNoUmtMZTFMNXlWanM2Nk9MME5ndzQy?=
 =?utf-8?B?bndXWWlpdEhSTmdlQ1puK0wra0lCVFJJVk9vWkFDRlJPZkZoMFlRU2VVS0hT?=
 =?utf-8?B?dHdUTy9GaXF2NElaWVAvSFExbjJxNXhhYlRyaGNzUVNrVWtNWlVvVXh0eE9y?=
 =?utf-8?B?eStZUlhxWkN5aHkyNFB4WGgxbVZpclJEd0hRTUg1OEpwRk5MTjBUeWVYSUNp?=
 =?utf-8?B?a0dCQUJZZW8vZWQvUDQ1bFRYMGtnUG9mck9sRXZ0RGxIc20xMUpLWFRvMU9l?=
 =?utf-8?B?UElNcThVL2IxS1lPd2QyaEpUNldQSjdwSjBGWTh0SHhJRTg3NWptQWtjR0ZF?=
 =?utf-8?B?SU9wQlBKYXJhL3FBaG1sQkdYNEd6ZE9hTUhBYmJudVdKbFFyc1gvS2t6VmVW?=
 =?utf-8?B?UmZva29uVVJJR2xNN0J5YmUyVkpkb3JVc052Y3ZPWEZyRjVWK2FVMFdlQ0or?=
 =?utf-8?B?SmtRUXNzZ3NGaFBtYjVtcE5oQVVPWDB5Q3lTU2Fod0lzQ3JrUGw4WXZ2anhI?=
 =?utf-8?B?SzRhaisvYmxhTGRjcDBFa1NPYXRTWE1FTjloUnp2MHlkQThHRFNZUENxb3FB?=
 =?utf-8?B?WEJXTHpEVlQwbTkyZzAvTlR5SDJPZkZTd1hiZGI3bjJMQ1JPZW0yclRNSlR1?=
 =?utf-8?B?VzdKcXhQWVArZHdKZHZra2IxMmVsSWZyZ3BZQTBzUExSaUNaS1JXYzRxRXlr?=
 =?utf-8?B?em95Mm96Sk9jVU84NSsvTERPaGxibUxmbGc2N3c2dXVCNVl3L0pDY1FVUzly?=
 =?utf-8?B?OEgrNWFycm5ONEJvaFV3SWFDeXFCZlgzc3hsdDh0emNIbjcxUDQ3aUtXSGJH?=
 =?utf-8?B?MzlVak80SFVrdXlNTjJseU00dmpDaDhtYXNlSVcvNVZWcXhMTGdvL2I0U1Rx?=
 =?utf-8?B?cjN4NEFuVWJ6NU9DM3B6YWpiWTF4cTFxQmhxOW0rTzhVRG00ZUZCQWpnNXBO?=
 =?utf-8?B?MWx2cVFzQnRpWlpaemtlM0QweDU3YWptSUg3ek1pWjFyUmZ0YzdWNjc5N2hQ?=
 =?utf-8?B?TTdGUzMwSjVqR2pPYlF4Y0VNNUpVKzdCemxLZmpGb3VNT1BPVHZuVFNlMlN4?=
 =?utf-8?B?OTNOYWxQdzYyNk43NlcxWUFZN1JFcmFGaUJCWkVhMUxBQThBcVZIempoZ1M0?=
 =?utf-8?B?WlhnTXVmQUczOTBOVFVZMDNVbjAwOTNocTZ1KzYrbFA1VlJCWWova3BieFRv?=
 =?utf-8?B?R1FzTzYvRTFGb1lzS3FEUVRtS1Nwc09sSHRnUWhxVW1mUFRVU3p5bE95Ym9h?=
 =?utf-8?B?bUVJbXVzVEExQUV5d3BLVVUyUS9NTG9tSWpNMTN3VzRLa1pXNlcvRURZN2ll?=
 =?utf-8?Q?7VSWz2szNLpK9+IasNu5/Mo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7771e5e-6091-40ab-a188-08db1a4d81de
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 12:07:19.9680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCNVb5dTtBiB40ysWzCbj+3zcVv04VREv+5pbXdaOwjt+fDqz1wg+kbeQWp0+rV+CVAxdMvGjL6sVfVGoEOkIc+E14N95ksnHgjytyU586I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7979
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <error27@gmail.com>
Date: Wed, 1 Mar 2023 08:00:07 +0300

Hi,

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   c0927a7a5391f7d8e593e5e50ead7505a23cadf9
> commit: 3246a10752a7120878740f345f3956997777b3d6 ice: Add support for XDP multi-buffer on Tx side
> config: x86_64-randconfig-m001-20230227 (https://download.01.org/0day-ci/archive/20230301/202303011231.SEfXSwLT-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> | Link: https://lore.kernel.org/r/202303011231.SEfXSwLT-lkp@intel.com/
> 
> New smatch warnings:
> drivers/net/ethernet/intel/ice/ice_txrx.c:1304 ice_clean_rx_irq() error: uninitialized symbol 'cached_ntu'.
> 
> vim +/cached_ntu +1304 drivers/net/ethernet/intel/ice/ice_txrx.c
> 
> efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1150  
> eb087cd828648d Maciej Fijalkowski     2021-08-19  1151  	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
> 3246a10752a712 Maciej Fijalkowski     2023-01-31  1152  	if (xdp_prog) {
> eb087cd828648d Maciej Fijalkowski     2021-08-19  1153  		xdp_ring = rx_ring->xdp_ring;
> 3246a10752a712 Maciej Fijalkowski     2023-01-31  1154  		cached_ntu = xdp_ring->next_to_use;
> 3246a10752a712 Maciej Fijalkowski     2023-01-31  1155  	}
> 
> Uninitialized on else path.
> 
> eb087cd828648d Maciej Fijalkowski     2021-08-19  1156  
> f9867df6d96593 Anirudh Venkataramanan 2019-02-19  1157  	/* start the loop to process Rx packets bounded by 'budget' */
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1158  	while (likely(total_rx_pkts < (unsigned int)budget)) {
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1159  		union ice_32b_rx_flex_desc *rx_desc;
> 6c869cb7a8f02b Maciej Fijalkowski     2019-02-13  1160  		struct ice_rx_buf *rx_buf;
> 2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1161  		struct sk_buff *skb;
> 6c869cb7a8f02b Maciej Fijalkowski     2019-02-13  1162  		unsigned int size;
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1163  		u16 stat_err_bits;
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1164  		u16 vlan_tag = 0;
> dda90cb90a5ced Jesse Brandeburg       2021-02-23  1165  		u16 rx_ptype;
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1166  
> f9867df6d96593 Anirudh Venkataramanan 2019-02-19  1167  		/* get the Rx desc from Rx ring based on 'next_to_clean' */
> d7956d81f1502d Maciej Fijalkowski     2023-01-31  1168  		rx_desc = ICE_RX_DESC(rx_ring, ntc);
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1169  
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1170  		/* status_error_len will always be zero for unused descriptors
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1171  		 * because it's cleared in cleanup, and overlaps with hdr_addr
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1172  		 * which is always zero because packet split isn't used, if the
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1173  		 * hardware wrote DD then it will be non-zero
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1174  		 */
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1175  		stat_err_bits = BIT(ICE_RX_FLEX_DESC_STATUS0_DD_S);
> 0d54d8f7a16de0 Brett Creeley          2021-12-02  1176  		if (!ice_test_staterr(rx_desc->wb.status_error0, stat_err_bits))
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1177  			break;
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1178  
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1179  		/* This memory barrier is needed to keep us from reading
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1180  		 * any other fields out of the rx_desc until we know the
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1181  		 * DD bit is set.
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1182  		 */
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1183  		dma_rmb();
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1184  
> 3089cf6d3caa1e Jesse Brandeburg       2021-06-08  1185  		ice_trace(clean_rx_irq, rx_ring, rx_desc);
> 148beb61203125 Henry Tieman           2020-05-11  1186  		if (rx_desc->wb.rxdid == FDIR_DESC_RXDID || !rx_ring->netdev) {
> d6218317e2eff8 Qi Zhang               2021-03-09  1187  			struct ice_vsi *ctrl_vsi = rx_ring->vsi;
> d6218317e2eff8 Qi Zhang               2021-03-09  1188  
> d6218317e2eff8 Qi Zhang               2021-03-09  1189  			if (rx_desc->wb.rxdid == FDIR_DESC_RXDID &&
> b03d519d3460f3 Jacob Keller           2022-02-16  1190  			    ctrl_vsi->vf)
> d6218317e2eff8 Qi Zhang               2021-03-09  1191  				ice_vc_fdir_irq_handler(ctrl_vsi, rx_desc);
> d7956d81f1502d Maciej Fijalkowski     2023-01-31  1192  			if (++ntc == cnt)
> d7956d81f1502d Maciej Fijalkowski     2023-01-31  1193  				ntc = 0;
> 148beb61203125 Henry Tieman           2020-05-11  1194  			continue;
> 148beb61203125 Henry Tieman           2020-05-11  1195  		}
> 148beb61203125 Henry Tieman           2020-05-11  1196  
> 6c869cb7a8f02b Maciej Fijalkowski     2019-02-13  1197  		size = le16_to_cpu(rx_desc->wb.pkt_len) &
> 6c869cb7a8f02b Maciej Fijalkowski     2019-02-13  1198  			ICE_RX_FLX_DESC_PKT_LEN_M;
> 6c869cb7a8f02b Maciej Fijalkowski     2019-02-13  1199  
> ac6f733a7bd5e2 Mitch Williams         2019-07-25  1200  		/* retrieve a buffer from the ring */
> d7956d81f1502d Maciej Fijalkowski     2023-01-31  1201  		rx_buf = ice_get_rx_buf(rx_ring, size, ntc);
> ac6f733a7bd5e2 Mitch Williams         2019-07-25  1202  
> 2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1203  		if (!xdp->data) {
> 2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1204  			void *hard_start;
> efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1205  
> be9df4aff65f18 Lorenzo Bianconi       2020-12-22  1206  			hard_start = page_address(rx_buf->page) + rx_buf->page_offset -
> be9df4aff65f18 Lorenzo Bianconi       2020-12-22  1207  				     offset;
> cb0473e0e9dcca Maciej Fijalkowski     2023-01-31  1208  			xdp_prepare_buff(xdp, hard_start, offset, size, !!offset);
> d4ecdbf7aa2fa4 Jesper Dangaard Brouer 2020-05-14  1209  #if (PAGE_SIZE > 4096)
> d4ecdbf7aa2fa4 Jesper Dangaard Brouer 2020-05-14  1210  			/* At larger PAGE_SIZE, frame_sz depend on len size */
> cb0473e0e9dcca Maciej Fijalkowski     2023-01-31  1211  			xdp->frame_sz = ice_rx_frame_truesize(rx_ring, size);
> d4ecdbf7aa2fa4 Jesper Dangaard Brouer 2020-05-14  1212  #endif
> 2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1213  			xdp_buff_clear_frags_flag(xdp);
> 2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1214  		} else if (ice_add_xdp_frag(rx_ring, xdp, rx_buf, size)) {
> 2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1215  			break;
> 2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1216  		}
> 2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1217  		if (++ntc == cnt)
> 2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1218  			ntc = 0;
> 2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1219  
> 2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1220  		/* skip if it is NOP desc */
> 2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1221  		if (ice_is_non_eop(rx_ring, rx_desc))
> 2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1222  			continue;
> efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1223  
> 1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1224  		ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_buf);
> 1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1225  		if (rx_buf->act == ICE_XDP_PASS)
> 59bb0808055758 Maciej Fijalkowski     2019-10-24  1226  			goto construct_skb;
> 2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1227  		total_rx_bytes += xdp_get_buff_len(xdp);
> efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1228  		total_rx_pkts++;
> efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1229  
> 2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1230  		xdp->data = NULL;
> 2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1231  		rx_ring->first_desc = ntc;
> efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1232  		continue;
> efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1233  construct_skb:
> 2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1234  		if (likely(ice_ring_uses_build_skb(rx_ring)))
> 2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1235  			skb = ice_build_skb(rx_ring, xdp);
> 712edbbb67d404 Maciej Fijalkowski     2019-02-13  1236  		else
> 2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1237  			skb = ice_construct_skb(rx_ring, xdp);
> 712edbbb67d404 Maciej Fijalkowski     2019-02-13  1238  		/* exit if we failed to retrieve a buffer */
> 712edbbb67d404 Maciej Fijalkowski     2019-02-13  1239  		if (!skb) {
> 2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1240  			rx_ring->ring_stats->rx_stats.alloc_page_failed++;
> 2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1241  			rx_buf->act = ICE_XDP_CONSUMED;
> 2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1242  			if (unlikely(xdp_buff_has_frags(xdp)))
> 2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1243  				ice_set_rx_bufs_act(xdp, rx_ring,
> 2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1244  						    ICE_XDP_CONSUMED);
> 2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1245  			xdp->data = NULL;
> 2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1246  			rx_ring->first_desc = ntc;
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1247  			break;
> 712edbbb67d404 Maciej Fijalkowski     2019-02-13  1248  		}
> 2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1249  		xdp->data = NULL;
> 2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1250  		rx_ring->first_desc = ntc;
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1251  
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1252  		stat_err_bits = BIT(ICE_RX_FLEX_DESC_STATUS0_RXE_S);
> 0d54d8f7a16de0 Brett Creeley          2021-12-02  1253  		if (unlikely(ice_test_staterr(rx_desc->wb.status_error0,
> 0d54d8f7a16de0 Brett Creeley          2021-12-02  1254  					      stat_err_bits))) {
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1255  			dev_kfree_skb_any(skb);
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1256  			continue;
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1257  		}
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1258  
> 0d54d8f7a16de0 Brett Creeley          2021-12-02  1259  		vlan_tag = ice_get_vlan_tag_from_rx_desc(rx_desc);
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1260  
> 133f4883f90668 Krzysztof Kazimierczak 2019-10-09  1261  		/* pad the skb if needed, to make a valid ethernet frame */
> 2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1262  		if (eth_skb_pad(skb))
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1263  			continue;
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1264  
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1265  		/* probably a little skewed due to removing CRC */
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1266  		total_rx_bytes += skb->len;
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1267  
> d76a60ba7afb89 Anirudh Venkataramanan 2018-03-20  1268  		/* populate checksum, VLAN, and protocol */
> 6503b659302893 Jesse Brandeburg       2019-08-08  1269  		rx_ptype = le16_to_cpu(rx_desc->wb.ptype_flex_flags0) &
> 6503b659302893 Jesse Brandeburg       2019-08-08  1270  			ICE_RX_FLEX_DESC_PTYPE_M;
> 6503b659302893 Jesse Brandeburg       2019-08-08  1271  
> d76a60ba7afb89 Anirudh Venkataramanan 2018-03-20  1272  		ice_process_skb_fields(rx_ring, rx_desc, skb, rx_ptype);
> d76a60ba7afb89 Anirudh Venkataramanan 2018-03-20  1273  
> 3089cf6d3caa1e Jesse Brandeburg       2021-06-08  1274  		ice_trace(clean_rx_irq_indicate, rx_ring, rx_desc, skb);
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1275  		/* send completed skb up the stack */
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1276  		ice_receive_skb(rx_ring, skb, vlan_tag);
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1277  
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1278  		/* update budget accounting */
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1279  		total_rx_pkts++;
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1280  	}
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1281  
> 2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1282  	first = rx_ring->first_desc;
> 2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1283  	while (cached_ntc != first) {
> 1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1284  		struct ice_rx_buf *buf = &rx_ring->rx_buf[cached_ntc];
> 1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1285  
> 1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1286  		if (buf->act & (ICE_XDP_TX | ICE_XDP_REDIR)) {
> 1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1287  			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
> 1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1288  			xdp_xmit |= buf->act;
> 1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1289  		} else if (buf->act & ICE_XDP_CONSUMED) {
> 1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1290  			buf->pagecnt_bias++;
> 1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1291  		} else if (buf->act == ICE_XDP_PASS) {
> 1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1292  			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
> 1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1293  		}
> 1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1294  
> 1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1295  		ice_put_rx_buf(rx_ring, buf);
> 1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1296  		if (++cached_ntc >= cnt)
> 1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1297  			cached_ntc = 0;
> 1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  1298  	}
> d7956d81f1502d Maciej Fijalkowski     2023-01-31  1299  	rx_ring->next_to_clean = ntc;
> cb7db35641c9a5 Brett Creeley          2019-06-26  1300  	/* return up to cleaned_count buffers to hardware */
> 2fba7dc5157b6f Maciej Fijalkowski     2023-01-31  1301  	failure = ice_alloc_rx_bufs(rx_ring, ICE_RX_DESC_UNUSED(rx_ring));
> cb7db35641c9a5 Brett Creeley          2019-06-26  1302  
> 9070fe3da0b126 Maciej Fijalkowski     2023-01-31  1303  	if (xdp_xmit)
> 3246a10752a712 Maciej Fijalkowski     2023-01-31 @1304  		ice_finalize_xdp_rx(xdp_ring, xdp_xmit, cached_ntu);
>                                                                                                                 ^^^^^^^^^^

It's a false-positive, since @xdp_xmit can be non-zero only if @xdp_prog
is not %NULL. But we could always-initialize @cached_ntu to 0, will send
a fix soon.

> 
> 
> efc2214b6047b6 Maciej Fijalkowski     2019-11-04  1305  
> 288ecf491b1654 Benjamin Mikailenko    2022-11-18  1306  	if (rx_ring->ring_stats)
> 288ecf491b1654 Benjamin Mikailenko    2022-11-18  1307  		ice_update_rx_ring_stats(rx_ring, total_rx_pkts,
> 288ecf491b1654 Benjamin Mikailenko    2022-11-18  1308  					 total_rx_bytes);
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1309  
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1310  	/* guarantee a trip back through this routine if there was a failure */
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1311  	return failure ? budget : (int)total_rx_pkts;
> 2b245cb29421ab Anirudh Venkataramanan 2018-03-20  1312  }
> 

Thanks,
Olek
