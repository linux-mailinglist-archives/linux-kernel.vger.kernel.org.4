Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56A760BF8E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiJYA3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiJYA3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:29:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BADF7285A;
        Mon, 24 Oct 2022 15:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666651935; x=1698187935;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9RMbNCU8b0QLqJQM6Iwjo7sjrJxQeSfx/8IlrSOsNmM=;
  b=X4gvzcZ8dW/NGHCKTMAG5DhGheKifyVN2ie4kVgiDD0s0iaEqe4jgfj+
   mF0N8mp4BRHNJDuS+PqlijdNvxML4kXO8cUUKEUebLYFFsyAKJrBdu/nj
   gUw50+jqaTN//A5VjJ6P2T+feZdNva4AQjwTcI4uOrzoLAsdcIXJ3sbXl
   fcxDmRDCV8ovtvVjMcDWwPs2wj0HRR1U4CD+yXtrudU//vcvJtDehHeOU
   2uWVZqRzmXy778mY5myPOpu79MBKNVq3m6zzmdvLYFDPy28LLlDDZiP9M
   V3BPsH6lSXNFBiWu4Vy/g17ey2WV/RpNzgqZ/7gcF2qAm9MAGgn2vY29I
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="290842514"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="290842514"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 15:52:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="720644265"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="720644265"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Oct 2022 15:52:13 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 15:52:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 15:52:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 24 Oct 2022 15:52:12 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 24 Oct 2022 15:52:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4QJxzgzKp5s9bhwpEHiS7+DKz+gxVEtmmdDtXzaPck6g3MUuKviziFvwvOTbFThwAFe8DlbpdU+v7x4yWGft3Asz1wzzIMhN/OsNt3qnb1K1v94ytWL3vZlDQfQxwJDEJhbT0fzpRKKSkYj1pyKTgb5twReu6MRpzzJd+gdigE6ykp8TJRBXffRTXmA3WqRJPmkm9AFLliVKlTU8gEJDJfwAvTO1XJP/4dsEd+FUdIS3ApJdT+qWsnEEwp6Vs4JbiB4Rl1vfCtjLxHMuQQustAsUW2o9+xQzrAnJYLAAVpkf8/G1syIbIiWTJrAV4L3wjf1FmN1m+ZZF/jxXuqxoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1fXUShKKfnmLQcqhGDz92q1KcfJbIS/oKbGVSGXStU=;
 b=FjMff9n2vFI6lPVTj8YoJ9Ab0km7nDq3XAmsGwYVdlVKCnd1O/yhGsRri1euT9iuHrSdBknuWiNs0g19/jVo1TBXXvZXH678rNOxJJQoLo4tDnQqAoVk21YKsVZEK+DwV+RWnFgJYfMxHmZLLlDTarv5xG2aajZ6kB9LgRfl1stSscGWguuSkcufoNrvZB/KMtuy+9+fuJpTu1ZVwMUpfNNmYcHnFkxYOoMoDBtwntvyDvXsWO6mmNGQ8u47zQekkhvwEkx2ZsTMeZotyzItFX3l6syZIpZraBaY7fA5ccsAFhasLN+/Ec5J8DzoxDFowCkK+8M6vc2uDfdZzTQX9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DM4PR11MB5261.namprd11.prod.outlook.com (2603:10b6:5:388::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Mon, 24 Oct
 2022 22:52:09 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e475:190a:6680:232%7]) with mapi id 15.20.5746.027; Mon, 24 Oct 2022
 22:52:09 +0000
Message-ID: <4028a1c7-ed84-37a8-1d94-178b5aa201a9@intel.com>
Date:   Mon, 24 Oct 2022 15:52:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 02/14] platform/x86/intel/ifs: Propagate load failure
 error code
Content-Language: en-US
To:     Jithu Joseph <jithu.joseph@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221021203413.1220137-3-jithu.joseph@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20221021203413.1220137-3-jithu.joseph@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0031.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::44) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DM4PR11MB5261:EE_
X-MS-Office365-Filtering-Correlation-Id: b7ee8823-3d69-4838-de7a-08dab61261ca
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ez9roB+6XfeLB+vtdwPCLqN2GmtnIJyyzKu9REcH6XasJ3CSJht0Kviu4nhi6Hv8RJraeqiRVioXq5EDfIxPfrdm+U5pPXJuNEqqPIJ2ePd0AK+KIquiwGuv+Pn1EAkEYrejD+VGID90rX0xivfUcZp6rtBUYbV1qvJT2NVpAetqryhb38HoBXa0qURDnXncUQHq7rll/0bXSYcDsMlTbs3cQqePHVIbDE27EY3dXdNaKpPenoowKONYFLsLzKUpIa1Umw4520F/Bv13WZanr8RdJ72D64ssDftNXNpdKsypufih6Tkj8aQZJa/i59EC651lZ+KteylV1+ejkGjZksxJINdZGSBipfBlzSqozcguyewDfzq9urj2D7LaCGJW1uiHlkHslc6niPzJzrumtlBn/rzM0X5+9lLlBc+Zp8bCH6V0Kn/u1eZJIj0wMsRSmg0Z20uD51x00H45NrHrhkiKXOD5TTWEDA8+uTIue9nRs1SNFtEEFjbLWAf765TVNHiacSptVuJpjZM4ptQn9FzmVQLthv7dD9B+n1aVXMW4uaN2B4AYyWB6vii9lN3NAdlWyG4SyJ+gnPuwesYW6NSDoUmhtdYOmvw3Xfuer3a0SgeT91XCC7rzdEAb1Zlm/n6V4X9zfTfaN6xLjza8ogPtNuQCRNe+e3JV5tXUfwPq2EEk7QTCUja8AajNVz9hBa1ObIAnLZdPIjHwVj8CBmX2OrRbRz0fnjCJfc5nRp0QWQ3aRy74fQ2KiG/iFYLdLpfcrV83+BjybqWfsZxl6Lt1i24xuXgA/ZjFy86Qlww=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199015)(36756003)(66476007)(31686004)(41300700001)(31696002)(6486002)(38100700002)(86362001)(44832011)(2906002)(82960400001)(2616005)(186003)(5660300002)(83380400001)(6512007)(6506007)(6862004)(316002)(53546011)(66946007)(66556008)(8676002)(4326008)(478600001)(37006003)(6636002)(8936002)(7416002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y21GNDdLVVBHS0cxK2tuZGZkUjlqSStESkkyczFrV1NDODMwSGh1TUFaMXF6?=
 =?utf-8?B?VnZFYmh3d25jS2kxVXU2S0NYOUdOUFQrSjM3RUQ0UE4yMGtWREtqSUpPaTFQ?=
 =?utf-8?B?dmRHSHY3TUZPVGtabVRpQU9WTTMzQmJDNks2NmRJRGFxV0tKOEFrT3NkY1l5?=
 =?utf-8?B?NjBvY3JOT3JnNnNrV0hDbGM2T3hPelU2QTN1YUd3eU5vZTF2QmM4eTRrc1k5?=
 =?utf-8?B?UWEwRFF3UEkwUURqMlRUcnhkUy83azRraE1RUDM2YkRXeWRYdS8rR0xVbVdV?=
 =?utf-8?B?ZkN2eG95WkpWeTR0Z1J3cVZvbjJMWGZCbElTcktERUZJY25reklteXFGN2xr?=
 =?utf-8?B?b29SeEZFdXRGcysyRGdERWYwSFh5OCswbUtNM1NwM1FFMkF3S1FPQWwvMkVw?=
 =?utf-8?B?YTVtUGk5SUJlUWU4a280dUptLzJXdi94Ri8yR1d3M1NLaXB1YW1vcmdFTGd6?=
 =?utf-8?B?VFh6WUZPTU1qM0xoMHd0UzFjK0cyZmRQU241ZGNFWUc3Z1gwYUlRS0I3clAw?=
 =?utf-8?B?MW9KQklpNEtUcm9iUkNrb1ZlaFg4YmE3aE82dkY5ZnJrRFhMRUJ4WkpHcnZF?=
 =?utf-8?B?WCtZZWVzZEx4T0FPRlp0ZU1teHVaNFpjcHNnTDBZLzFTNG5Fa29HcWRwMnl5?=
 =?utf-8?B?a2tQMGt4WVZQaWo0MUR0SzJPTXJvRmdENmpTZFo3Nzc1MUtPWWlWRHUzYWZU?=
 =?utf-8?B?dzN0bnpNQzRIT3JmRnZUVWcvcytlOFNjTmRpU1JGVnd1SGhhOGd4dHJiOGF4?=
 =?utf-8?B?K3BOc3A2NkhMdTRuLzZ2OHJ1c0N1ckZiVDg1bW9uTkJUVmo0bkpSeFE1UUpa?=
 =?utf-8?B?N0hPazl5Qm5JbmRDcEgvdFBKcGZIaEhzUkd4TUpwc1M1RlIxaCtQQ1VpUVVs?=
 =?utf-8?B?TjR6dldtd3hucVNyeU9ha1FYZEVqZ3ovMC93YUFjd2x4ZHgzOXdodjlBNEhX?=
 =?utf-8?B?TFJIb21UYndmNjZFK09qYS9ZRk5GS3k2RlhRU0IxTmxubFBKM1JzSUcvYlh6?=
 =?utf-8?B?YWFmK0x1cHl2ZjN6NUIyTEwrTm14SXV4ckdTQ3J3YVJYWVZBTG5yQ0NheWMr?=
 =?utf-8?B?blhISmtxeWVobXJlZzNHbjA5MUxUeVJ1M3Z2QUNMYzdidVBzblZMVmpHdlJU?=
 =?utf-8?B?Unk2d3RBdDl3WkNGbmN3aDFkSGdpdnVkYi8wczluUW83QU1WNGNjcUpMQk9x?=
 =?utf-8?B?dDdsclhmTjh6N3ZyajVMOENSazl1TXFzbjh2bFdFQXhBSWF6T1FOeHNCUnZK?=
 =?utf-8?B?LzhGK2xEWUQxL1Vvd3ZxNGI5KzczN0V2NWVKT0RvQmUvRmJWTHpHUGxMbUNa?=
 =?utf-8?B?alBkMEEwY2pPcUZXMHRNa1hIaysvNEtpUFN2REZKYjVQbUJ4bld2ZWkxNlVJ?=
 =?utf-8?B?MHJqUGs2QWdEb3FIYnRQYzdoZFVjQUxMQms4MjIydG1EVTZ1N1RwbmpYYWVo?=
 =?utf-8?B?anI2Z3l5aUhFVVYwYzBrUjU1enNrOEVBOW1ZSWs4ZjMxRHlVWmk2dk1oUXJI?=
 =?utf-8?B?VElYSjV4eWhlRmpWTzZaanlSa1VVc2hiQktTelo4Ui9ldFdLdldZNkZrRmZV?=
 =?utf-8?B?OHdSZXppb3hDdzNrNk9Zd3JZcjZZbEdVb0hsN3FERXM4Tmx4R1ZPaHZXSXlV?=
 =?utf-8?B?cWlsdjBkVE0yU3QxaG5iMURpVE53eHZmSlJycGozRWpPQW5aREorSGM2cmcr?=
 =?utf-8?B?MTFzWVhEWVpjeGRPQWhGQ0NMNU5Qak9yRk0ydXJwOXptY2plb3IyaTdzSkxO?=
 =?utf-8?B?bzUzcVlZeHdZUFJNcFI3eHpiUHoxUW9ZYkZId0dQTHJyNHpZenVTOXJIL2M4?=
 =?utf-8?B?YitPYjRDdVA0WmR1eTg0dDJZY1dMcHc2V2JCcTZHQk5mSUhIZWxUN09HL2ND?=
 =?utf-8?B?dnFEdXF4RjU1NjZjOEwwb0RLdkxZNCt3dHhlNnI1eXFpQmdRSENjT1d1L0JV?=
 =?utf-8?B?eTNKU2ZMaWlHazJuWE5yU1ZlcCtFRitLMGdrS0YzMUZZcmRCQmhJam9lekZJ?=
 =?utf-8?B?cWdDeDJqZVBJY29VWUdDWGp2MUFOM2F4QWlJdHErbWJ5STZTQk91ckZiRmFX?=
 =?utf-8?B?YVF2M2FQWHViOVEySW0rYVFmd1E0UGFJTEZlNUlzZlAvWTZKMTA1eFZvM0I4?=
 =?utf-8?Q?PuNo1UPAT0p7nsC8LpbTZXjHA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ee8823-3d69-4838-de7a-08dab61261ca
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 22:52:09.4104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oGL9lJjExk87iov24kmUZwdqrc2gr6H3bi8kie6ob+lra640/ul/7onqcKHoSvxzW0C1G1apRJwjlN2T/X3y4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5261
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jithu,

On 10/21/2022 1:34 PM, Jithu Joseph wrote:
> Existing implementation was returning fixed error code to user space
> regardless of the load failure encountered.
> 

The tense is a bit confusing here. Also, 'Existing implementation' is 
typically implied and unnecessary. Would something like this be better?

The reload operation returns a fixed error code to user space regardless 
of the load failure encountered.

Modify..

> Modify this to propagate the actual error code to user space.
> 

...

> diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
> index d056617ddc85..ebaa1d6a2b18 100644
> --- a/drivers/platform/x86/intel/ifs/load.c
> +++ b/drivers/platform/x86/intel/ifs/load.c
> @@ -234,7 +234,7 @@ static bool ifs_image_sanity_check(struct device *dev, const struct microcode_he
>    * Load ifs image. Before loading ifs module, the ifs image must be located
>    * in /lib/firmware/intel/ifs and named as {family/model/stepping}.{testname}.
>    */
> -void ifs_load_firmware(struct device *dev)
> +int ifs_load_firmware(struct device *dev)
>   {
>   	struct ifs_data *ifsd = ifs_get_data(dev);
>   	const struct firmware *fw;
> @@ -263,4 +263,6 @@ void ifs_load_firmware(struct device *dev)
>   	release_firmware(fw);
>   done:
>   	ifsd->loaded = (ret == 0);
> +
> +	return ret;
>   }
> diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
> index 37d8380d6fa8..4af4e1bea98d 100644
> --- a/drivers/platform/x86/intel/ifs/sysfs.c
> +++ b/drivers/platform/x86/intel/ifs/sysfs.c
> @@ -94,9 +94,8 @@ static ssize_t reload_store(struct device *dev,
>   			    struct device_attribute *attr,
>   			    const char *buf, size_t count)
>   {
> -	struct ifs_data *ifsd = ifs_get_data(dev);
>   	bool res;
> -
> +	int rc;
>   

Does rc refer to return code? The other IFS functions like above use the 
commonly used 'ret' variable. Any specific reason for the inconsistency?

Also, patch 11 completely removes the reload_store() function. Should we 
avoid a separate patch to fix something that is going to be removed 
soon? Would re-ordering the patches help in that regard?

>   	if (kstrtobool(buf, &res))
>   		return -EINVAL;
> @@ -106,11 +105,11 @@ static ssize_t reload_store(struct device *dev,
>   	if (down_interruptible(&ifs_sem))
>   		return -EINTR;
>   
> -	ifs_load_firmware(dev);
> +	rc = ifs_load_firmware(dev);
>   
>   	up(&ifs_sem);
>   
> -	return ifsd->loaded ? count : -ENODEV;
> +	return (rc == 0) ? count : rc;
>   }
>   
>   static DEVICE_ATTR_WO(reload);


Sohil
