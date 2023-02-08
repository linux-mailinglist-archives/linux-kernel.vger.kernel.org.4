Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D2768E821
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 07:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjBHGUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 01:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBHGU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 01:20:29 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5673C2AC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 22:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675837228; x=1707373228;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zRDz0jJ3dVlRGss/+eIDHi/6v7mAnWuV4yfacyp+MU8=;
  b=LB+oIdZYHFm0tfilKl3iSJg4JhvZpJkaaqqjMz122UNn41tOarwx5xHi
   cfq4/ezna7mIDawKE0dA/scddY0taKqxY48XIEO7kTu3g3qJQR+6TkG67
   F9MNQH13N2T20c4CLoPvKxAGFjBD3+jqMrG5Btpes3wcDpsJCq+8UWGUP
   MysI3bQBpLpNzRp+tD3uZA2C4gzXFABSGqOEXG3KGGl290diGicTcH6fn
   dKrBbiIshvKkdBv0KCU4Tkws3scgd65pg2DYOX+WtjAjbMW03OzBlSMY1
   zvJv6r3J3wxqAQzKbEk48M1SWY4Y6v/fSv9cE8MpHDJkGSBo7Zq0mWdXV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="317720795"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="317720795"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 22:20:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="912621317"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="912621317"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 07 Feb 2023 22:20:27 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 22:20:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 22:20:26 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 7 Feb 2023 22:20:26 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 7 Feb 2023 22:20:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frgSvAdrC8SmbnHlCO4bxyObXz3aAdBjlVnzKqYwjnTpnwwylU32FrXsLGnrLXY0wWInaa7Ym5NYCyngKlEC03PyrwFhPbolx1C+6l2Npnl7nTSLyxpziUNsjdpe0OtIcXdAbBYMhKeqi608pyUEfpoYGk08+aduJOeogIpGWAO3eLhXmZRKRX/PCaXt4L2JnQRlUGShpI6v5rdn4jyqC+PCA7gasiaw1mrJE5bbU37jb6zloQvHL7U6P0JvB8HS/w0U8NTySk9agFUrT7IS5vFam7igqz0/arZTRzvzXz8v3i+z1HZ5+4WMbJJUOttFilfM5PlwQcFwbiSZFLdUQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smso2pTn3S7ymm7KMl3rSM00/GR5LXIvlQeXutVBzRc=;
 b=mhrTNkFwjMQblqUgmbWv+bSTe2KWVkrHsFhIZ07tZpWpdvSRCsnSdRbl97uyK7dvB3jZt4E/sxG4vLHoVLPwuPrhyCECVIU+Co8r09Q6WdqHUIkwBwsvnFKJS0tD1rcoDM1vTERV8B/idrQ89u6Ltfc3r6VtRxz3NBRxdVmd6Jj8CawxYe7acjTjIywxH7U3TWzlWNn0deeoV5lg4NXqvvELyZELTR7uNw4HRkHs2PsMQzYR9vx1L86urem6jCkidgccCJ8D4W5KzsPtO3+HbqnyCCLUe0TB8XCNU4ig1tTyQ8cgnFZiKaAZTCZYv2Emoi4pUOYSl0qS3NwQDKqriA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by PH7PR11MB6884.namprd11.prod.outlook.com (2603:10b6:510:203::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Wed, 8 Feb
 2023 06:20:23 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d%8]) with mapi id 15.20.6086.017; Wed, 8 Feb 2023
 06:20:23 +0000
Date:   Wed, 8 Feb 2023 14:15:42 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Terry Bowman <terry.bowman@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH 2/3] tools/x86/kcpuid: Update AMD leaf Fn80000001
Message-ID: <Y+M+DtRg/+zpopRE@feng-clx>
References: <20230206141832.4162264-1-terry.bowman@amd.com>
 <20230206141832.4162264-3-terry.bowman@amd.com>
 <Y+HKRLN//GnP0c5r@feng-clx>
 <Y+JylWCLMA6mK7G0@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y+JylWCLMA6mK7G0@zn.tnic>
X-ClientProxiedBy: SG2PR02CA0117.apcprd02.prod.outlook.com
 (2603:1096:4:92::33) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|PH7PR11MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ae6c54-1eda-4d4d-10b1-08db099c8fd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bmvx2pxOgbYrHeX5dIGuM63s/NimqRQE3wpHiiUiyeGnC9Z9e1LxvLfw+6y9UgXKZG7fJZulKqGX77QXa97oBvoYClAYQrkkuFzUdHo4rING8g8CStFmvRvpiTqy9ckpaYxJ5o008Vb1GwPlKXKG1A+1bPGZflwXZgDgpCcjjtPlIkGj4LTuWSYuDtj5Su2hXy6eY8HjxtWCyPtGNtUH06FMr0ouPqUmuyZUM7KLeApbH6yNa5/ta1hOY491BJzGNBNE0MfyDaG7AxP+1OKtI96Ae0uzsSOOvozDha3ORKtcCUs/6HPkac8xrE8QD355VZ/qdoxoanFmp59zm2hLbpGphVZ/wAg6AkL5pIUVF9SLjvXBN8Y2GAPpnA4bqmH7Cxjxw0OYvP1uwAP6fi+G5cjEgCj0nvnNOCwucMip9baHdQDB1V7Mjdd9LrhFMfN0tqsjvzC1bF2ctmhGWuZKguX8RPk0WrVv/dFR3mEMM7SfhzZrz8P2hrPCmKcsfk3wqvp4adJ7CESpO9RQ3uWuCzxYl+6mN/aZlyeHrsj/ghrSc6vWi+Tyqzrmcrb8wxo3hHpFguIndYW0zMM/IcNdW+E+UsBP3j4nOlQW3Cyvsi+ID/J2DwHaU9vwbEbc/suWxL3sjPNlkUcf8DTXxeO/pG8iIRi4QF94miUHn0tISovyaTKt5rW2m+m3o7hmgera
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199018)(4744005)(44832011)(6506007)(8676002)(186003)(9686003)(316002)(6512007)(86362001)(38100700002)(82960400001)(6666004)(6486002)(26005)(478600001)(966005)(41300700001)(8936002)(5660300002)(4326008)(33716001)(66946007)(66476007)(6916009)(66556008)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OCiGxwvaosmaeWDy0/CYKjajEmZsJ/XM7B5dgscjnjvU+V3L4ewjChlUiUOE?=
 =?us-ascii?Q?5zQcjCm95TIPvSdT+9ITJ8EypePaNzF93FhKouz9NEiAhLKjlFPCeDriA5wq?=
 =?us-ascii?Q?nZA4uYVi7pisIfVgIsiSowwuNZ70VHkKzeLf/bnBdmTjA3CakyqUs9P66p7q?=
 =?us-ascii?Q?WJyK9rBMH/btCkY5mGqUbJ+80EJCQYTMcEDNxnxE6S7e7tOWUrwst0jYZ/+s?=
 =?us-ascii?Q?R9/dpCoGXw9wI0ePwKBeOfhHva5dv2GD1NOOg8gX1h9m7XTZiHRMWzW6yWf2?=
 =?us-ascii?Q?OUPb5NgUQkJzKdb8F65S/KlPCmYN2Gn23Lq/M7q3/pYi2cfS0Z4YCNTVSUHk?=
 =?us-ascii?Q?CQLbSnj7UfPQm39olHGM5NbI5wDMgq+Ixsn6olTEE3jh5YOrCkQlFIT6fX/J?=
 =?us-ascii?Q?vW8grWG0pSsKBsEjZ5seto9H8xYL7dowfU2Cv374WAEj80cELEBiAh8yLuuX?=
 =?us-ascii?Q?S7ckuw/UfrqGSPkaZFEg5LiEIHYx6JaUFS4W/mvzN9FcncymFk0FoDnCaMKO?=
 =?us-ascii?Q?4RGqwA+ulfN26yghlK97DVk/b4AYpCYdUmogrccsGylaA+ueP3UkAxr/+Via?=
 =?us-ascii?Q?otADvvBrh3yhLvbdkfAMcLXF4fkn4SImwQMqeCSbaNxZV7jTs4lgGSUGilOR?=
 =?us-ascii?Q?oZezKZk9W7aZpmWgn49GFlPnx0m8GlIu3eCUw6S4q6QmWgbPl88ZZ8mP1y3j?=
 =?us-ascii?Q?az2Lf21BD1uC/cdB1is2r0aCksrIUOFueSkFWHX/ikiLycJW+4P6RQHJICMQ?=
 =?us-ascii?Q?F0JTWHuNEoQSGLpSl35t1kBK14xf1cLhmWHQxG05yotS+m9b7s9O6lhxJdA+?=
 =?us-ascii?Q?LqnZw3bzR7KucZZW0tYXEUlf2nRpp2HTFNi/0VOUi0sMfUEKn7cCAuWIwF0E?=
 =?us-ascii?Q?ByDics5a9PwU7kXvVTiy8qQhezZemgChWxFs6MGD6Y+eHNHS1xtXNhjiPDK2?=
 =?us-ascii?Q?JZ7cFsImOEIHmuD3DbJv4A+tDwLGpHECM08yjUTRb4AJzO4Zv2QoYKB5Wuwh?=
 =?us-ascii?Q?3UwUFLZLFIjh1zWJSG+qsyiwIg2BBLKEWrQh2R5trp8Z1LqwZnc80HtigdLE?=
 =?us-ascii?Q?BnY6l1m2U33gPEUw/g+wO/yIwxVSDbvjO8Cxsp/uTvRPnkNItj3BgD2ce0dm?=
 =?us-ascii?Q?St/e9I/iI/17k+umhB64aZX8lKEaPvlDIv/zvq2G0Ql3ScUAm4pkRvumCAz1?=
 =?us-ascii?Q?EHStdMM+2UDYX+sjMBTPbuKH19mgYXg+Sj9hgsQSx/JNUSdGn8Bh1bADManf?=
 =?us-ascii?Q?JocWm8ggmgEtyh41q1CmaY9F/ZabyIm+VcMt2A2LZHyN03yHt41cibODcmca?=
 =?us-ascii?Q?WfpFAAamGsotzPIFN9tezAdCuxXbAGa756SHpFjgGoP6Yggn8pS2UBp09h+b?=
 =?us-ascii?Q?l97pKHV7GtZ46raqr9m6GCKJdJMAA3MFa55kr7cDCsg7cjSRkZPUfRKdOyoW?=
 =?us-ascii?Q?aPC9SeraCXrWYhXmDNW634oG2Wi+p8gcp2ttbAv58gnDHJFE5zEtU0Jq3Uor?=
 =?us-ascii?Q?q6imubww0/2EPqBs64AqoKsdt4HsMp+WztUT2zV1umCdGJiObmPdgVe02ACm?=
 =?us-ascii?Q?TylL9KvCIC0hhQCa9Md53BPZHhlNEzXijp+1B5Rr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ae6c54-1eda-4d4d-10b1-08db099c8fd2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 06:20:23.6763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ajqP/HyiSiHN06DTritqMmEOX1ylAL+7HDu0VoEQFz6hFaFJu3hibI++Vs4vDQIDhgUxfITXNWpxsuGTGHPFQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6884
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 04:47:33PM +0100, Borislav Petkov wrote:
> On Tue, Feb 07, 2023 at 11:49:24AM +0800, Feng Tang wrote:
> > I'm not good at naming :) and you may find better names.
> 
> He's using the official PPR doc names so they'll remain like this so
> that they can be found in the respective doc.
 
I see, makses sense to me.

Thanks,
Feng

> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
