Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58507674222
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjASTGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjASTGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:06:00 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9146F9575C;
        Thu, 19 Jan 2023 11:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674155103; x=1705691103;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=C26pL/ZR9hqK0q6ANisPaBdS6dlI9bdVaB0c9ITdz+o=;
  b=SK/l+ZX/C6CbITbr9ecOr6ZAlMp17Ah2OMr1ypXwoBsiEW2sL3DYmoxK
   axqV9gL8PZZe3318OyDcRXuiy3YOtANyu4ogmyZT8KGMTzgfNN68BJL+d
   +/YLX0HI+qkUXoVTp3mzhQJRjMzQQNIs0Ef/0bPurGFqzzYviAuu/wkJY
   aoI0uvE8AJhEdiCFM/eGWEiS11AU0Lcr+3wk31gQp2MZZQcmXmq12j2DR
   9H0XuqTfZ6pzRIcVznZim2kBXDzjVDYMygsJW1IoNXG2OvIsUe/cPYCr3
   mIqkhA8UCmF56azEJ/YCkZSA3Es9AtdOT8ZaHckbs9+LR7wq3UP9/a2MA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="305059329"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="305059329"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 11:02:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="637813410"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="637813410"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 19 Jan 2023 11:02:18 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 11:02:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 11:02:17 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 19 Jan 2023 11:02:17 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 19 Jan 2023 11:02:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENoZ8E+85kJVVlkLIyxA/zArwN8JtyrS91ns3vvx1FPrULS9AvJQXxAEX4HIVBS3Lw6jkhiXiq34C8BU6V0HXnt0WR1ruLok8G1Zkj+/ww7WBdu0NJPfAyyj7g+7RdNmdaJkbdSQvkTYrxzYbMWnq61a+8G73B4+1gWOCO15dHebVCWFJXHvF/IAogLHGs2ZTZNCHKmHwJjdSkcWDNLStzJdENwHfkGKwkMN91JxzUjnOTORkXcghn6bnJ4SZmmVWVgqKzMIv1mBjm1hg8vTFIaJL6KGudr4YeodpiU7IsNES6fwZsYZ7xn9sGRpySAjDzy/vu9GfmaOdgO2NSOOkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6FARfSChUXVQzj2jMYxUL0WHQs6mTaveKcdHEC3dDU=;
 b=D2WLo3OMI9vDhY965P2YQkqlAZ7rPq/CqlrGAJ7J8/G2JTJ6edGB3dOJ8Mh16xEIKeKxiDVa8WRbxl+YWndDkUTHPaWZ8OjMJjR/vQySANv52B2E5mcNpR8NKIP7m+RaNysT5ztvpqrRcrGihAfJJR5z3kZy/PhS48Vno54kdkjqUQiGzFzYeNW/pu4GJMfutmT7j1RSV/V4RhCNtmbSZTy5M0e2etzX36V0tgXeTqGztqIqYQs17kLcmBm7VesP3GevHNdkd+0DAcxkCrNqa9ti0ZWVUME+Ka9num0ycJJzobN6sp+5ISwuraWt1gpFdrUiFcGDN/KhjArhduGfKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH8PR11MB7046.namprd11.prod.outlook.com (2603:10b6:510:216::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 19:02:15 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::593:877e:dd33:5b7a]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::593:877e:dd33:5b7a%5]) with mapi id 15.20.6002.024; Thu, 19 Jan 2023
 19:02:15 +0000
Date:   Thu, 19 Jan 2023 11:02:08 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
CC:     Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        Gary Guo <gary@garyguo.net>, Kees Cook <keescook@chromium.org>,
        <linux-kbuild@vger.kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Joel Stanley <joel@jms.id.au>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        <rust-for-linux@vger.kernel.org>,
        "Guo Zhengkui" <guozhengkui@vivo.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        <linux-kernel@vger.kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Luis Chamberlain <mcgrof@kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] modpost: support arbitrary symbol length in modversion
Message-ID: <20230119190208.2towhelvz7s6dn3u@ldmartin-desk2.lan>
X-Patchwork-Hint: comment
References: <20230111161155.1349375-1-gary@garyguo.net>
 <20230112214059.o4vq474c47edjup6@ldmartin-desk2>
 <20230113181841.4d378a24.gary@garyguo.net>
 <20230117175144.GI16547@kitsune.suse.cz>
 <20230117192059.z5v5lfc2bzxk4ad2@ldmartin-desk2.lan>
 <CAK7LNATsuszFR7JB5ZkqVS1W=hWr9=E7bTf+MvgJ+NXT3aZNwg@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNATsuszFR7JB5ZkqVS1W=hWr9=E7bTf+MvgJ+NXT3aZNwg@mail.gmail.com>
X-ClientProxiedBy: BYAPR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:a03:74::35) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH8PR11MB7046:EE_
X-MS-Office365-Filtering-Correlation-Id: 550501be-1ab2-4e69-5619-08dafa4fad7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qyvq8N4MQs7Tjp/WZwQ4xMnEo28qnSWhdLdStD69h7O9oVjzNm97dcf3adgwiER99kbqexLSCF+v8hMCG7NY9A/kjC7IVEMvMVJ19Oyga5P9RCpO7zgtZASy6j6X9Ayt5NjYixI9mf/1FX/bvW8Hqsa2HXxAatrD6+Uhxr9DJG6hr8CF6TKguyamAI7RrrtzyD+iCORLPGyNIapUQ066x6s1MZRREJUOdgHBNP3v/Bunmfx7XbABTzuIJPrG25JLU5Gh2SkGm+aWUPF+Ofh4LkV+nF4khhNdJKY3PS1K3GgwgOWU/aUDDvosoa5oWRCMZr8vcIpjy1/JvN7SuWuwR6JcJlqEadMvdnZcb6+BB4i3m3IWo7q2qDaGmQIE0Gas1qzfaYGxRryOUfj4dE8Aibz+zxRMCeyzsNVb0hA3nFNuQktUyL22eJFqa2Dym0TBYo+AwzL+UWG9Q+yJ/6daIgxtpTBv6gIm1LGS15NKjIGS5fRXn5rcoPu1TyLkcmgI7RxL1/OvUsaSpF7mhqdvlelHGSa1sy680TvkfzZTCik9Hrj++CsYqTTX6kPytiyau9yibRsobS9pD08dd8gM2Mq4rAHmbQXtYPUePq3vUN0yfdJfrAPeLM0t+Htf5Glm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(39860400002)(136003)(366004)(376002)(451199015)(38100700002)(36756003)(82960400001)(86362001)(6666004)(478600001)(186003)(26005)(6512007)(9686003)(6486002)(6506007)(8936002)(1076003)(2906002)(7416002)(5660300002)(4326008)(8676002)(66946007)(6916009)(66556008)(66476007)(66899015)(54906003)(66574015)(316002)(83380400001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?5DcbA2zD+Ki7TrJ0QzW4uwxi/46SSYaU388igBOlWJChy6A7Ug8xs/AA1d?=
 =?iso-8859-1?Q?zYUIFpuNf+xe94Zc4Ol8YSZG8DOT4HuIGgWvw8wZ7r+qZ0oqyELtXV3l5b?=
 =?iso-8859-1?Q?PZEH04+t8tjYsvUJV7tisuepDT79crz0JxmTqU8liZjAV7FcYOqxuM6mpR?=
 =?iso-8859-1?Q?3kEX/BRNgVkvIbU5b11F+v8tzoqDtSs6WuD78Enj0OPZ/c56WZ5SdhqSN5?=
 =?iso-8859-1?Q?ZYl9KHTUr+665FjKXIpSbyCVYBtJF1RSf3llyCoqgC+NIIn2jT/j2b/gnO?=
 =?iso-8859-1?Q?oPCUrA61iWrbzXEQSLC3i2ov8ZHsWg45pGurSyP6AXTD3euhkcgKHJxKH7?=
 =?iso-8859-1?Q?x36uHxmKPfdQ/bTle3FJrfr7otG55o+RP4cNLzej9QF8hs1pI1AhO2Q32z?=
 =?iso-8859-1?Q?SaaNE3fQqUDFsaMMKLCLgwg0VQj36fS+n37HKOcUE0lbtmye3pYztoiNr4?=
 =?iso-8859-1?Q?/g4eSiMCWdKUAaEq/N4E3HYEdAvWbNWwiZFVHfiCER/idw6S2VojfCBmf8?=
 =?iso-8859-1?Q?pLSffVH9NMWG/jKc7NKqjFrUAObQdtwKWbDux9pIiytSzPw7jWcccTG7Rj?=
 =?iso-8859-1?Q?1Z1625r6MycWHI0QKN741K2BbnzuulUOIxG8iU941SelvEBtfU/PMNw167?=
 =?iso-8859-1?Q?BLw4TqIgmoduDJgVCqcn0ux1MARb0PTyXRv3zek2EOahjVcgiJTMMQ6fs5?=
 =?iso-8859-1?Q?TI4jFoTnb0q3rPu9tSmUsB0IIm2FK1lIIaYDQVz1mBBmoCqB8GCxbhGnT3?=
 =?iso-8859-1?Q?oXsxxLEW0iXxW1Zkxyk+RSd6k+y074JDB4ZNFl/FFAM8MjHyektpjnblp8?=
 =?iso-8859-1?Q?+hYanVoUnJMlXK/6ucyUIVB6xL3PFww31nL6DnnL1arpo11q9sfiqLSG6L?=
 =?iso-8859-1?Q?DQRZys2Skl4JrFRpJ6LVsKMPs24bnRoQ2tkwkdexAiejyppkVGzCqsdGDV?=
 =?iso-8859-1?Q?i8AWiTwhYl+97tkXcuheTgvR9OTtNx0JQQu7xp7zINrmJJHjgeL7iYMjqJ?=
 =?iso-8859-1?Q?XX5AX4G2wuhIiemCLAZId4/nhNnCrvqpkA4dhepcPVBH3oxaiI7rUQL6YY?=
 =?iso-8859-1?Q?kwK4CZb0Cclw+H0NMUPhTn6R0aUVMHYpLlKiooyULjMY6FNyiOCGLOQs6V?=
 =?iso-8859-1?Q?gfz1bRplmYLeftbfPdyRfedlsQ0paGpba5S4acSoDXnNnxcqNW4MI2obGV?=
 =?iso-8859-1?Q?KRqUqtzCmwXyite/weK5nsdfaeA0Wf68LQMSUBrrxmGmDKVFleR9mTrbCD?=
 =?iso-8859-1?Q?sBoMZDDnRgqb9XMxQUCXsbEJ0TF7IZdm92wucOVrsGHPKKxEzePvJBKKYD?=
 =?iso-8859-1?Q?6C6d7jABJB7hwmIeV0rhMbqCgncvPC5e5Xs5INeFLQXPuKIhLJEEJ7iQKa?=
 =?iso-8859-1?Q?aRblmhnUCo3Yk3XagD8KHGtfzoJgit0TG6zbQGzhvmvDlfokM581j1AdkM?=
 =?iso-8859-1?Q?3MbF3BYtHDl6R/4U1XYVPUikctjqf6M/nS+IWtitkIDVKnhwh4xJl/E83d?=
 =?iso-8859-1?Q?uX0/X9vlA0EUcypdBnbbDHi/jW8Z+tGwdkKAUDmlKFYipPDw/9YZBsL/6O?=
 =?iso-8859-1?Q?jBHW6A+if6anHr4COQcDq6vGZD4sMvYHE1ReQH6sWnLhoJ8Ja94F8bdCcj?=
 =?iso-8859-1?Q?FNnj/vy4qogR7AHJo0g2lHYJWiApXXuGul8jYXnEulGLEKjO/SyU4qiQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 550501be-1ab2-4e69-5619-08dafa4fad7c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 19:02:15.3677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mgyhFSRTrzNcJJB7KZTSlPVoS88vIaBUbmW08wtCo3yLvR9Zp/CH0naIoFOpEq6ZZ0yCG4QJZ+XGS9ZRRyDO/7xSB0i9AaeToFFI1PDnis4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7046
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 04:01:29PM +0900, Masahiro Yamada wrote:
>On Wed, Jan 18, 2023 at 4:23 AM Lucas De Marchi
><lucas.demarchi@intel.com> wrote:
>>
>> On Tue, Jan 17, 2023 at 06:51:44PM +0100, Michal Suchánek wrote:
>> >Hello,
>> >
>> >On Fri, Jan 13, 2023 at 06:18:41PM +0000, Gary Guo wrote:
>> >> On Thu, 12 Jan 2023 14:40:59 -0700
>> >> Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>> >>
>> >> > On Wed, Jan 11, 2023 at 04:11:51PM +0000, Gary Guo wrote:
>> >> > >
>> >> > > struct modversion_info {
>> >> > >- unsigned long crc;
>> >> > >- char name[MODULE_NAME_LEN];
>> >> > >+ /* Offset of the next modversion entry in relation to this one. */
>> >> > >+ u32 next;
>> >> > >+ u32 crc;
>> >> > >+ char name[0];
>> >> >
>> >> > although not really exported as uapi, this will break userspace as this is
>> >> > used in the  elf file generated for the modules. I think
>> >> > this change must be made in a backward compatible way and kmod updated
>> >> > to deal with the variable name length:
>> >> >
>> >> > kmod $ git grep "\[64"
>> >> > libkmod/libkmod-elf.c:  char name[64 - sizeof(uint32_t)];
>> >> > libkmod/libkmod-elf.c:  char name[64 - sizeof(uint64_t)];
>> >> >
>> >> > in kmod we have both 32 and 64 because a 64-bit kmod can read both 32
>> >> > and 64 bit module, and vice versa.
>> >> >
>> >>
>> >> Hi Lucas,
>> >>
>> >> Thanks for the information.
>> >>
>> >> The change can't be "truly" backward compatible, in a sense that
>> >> regardless of the new format we choose, kmod would not be able to decode
>> >> symbols longer than "64 - sizeof(long)" bytes. So the list it retrieves
>> >> is going to be incomplete, isn't it?
>> >>
>> >> What kind of backward compatibility should be expected? It could be:
>> >> * short symbols can still be found by old versions of kmod, but not
>> >>   long symbols;
>> >
>> >That sounds good. Not everyone is using rust, and with this option
>> >people who do will need to upgrade tooling, and people who don't care
>> >don't need to do anything.
>>
>> that could be it indeed. My main worry here is:
>>
>> "After the support is added in kmod, kmod needs to be able to output the
>> correct information regardless if the module is from before/after the
>> change in the kernel and also without relying on kernel version."
>> Just changing the struct modversion_info doesn't make that possible.
>>
>> Maybe adding the long symbols in another section? Or ble
>> just increase to 512 and add the size to a
>> "__versions_hdr" section. If we then output a max size per module,
>> this would offset a little bit the additional size gained for the
>> modules using rust. And the additional 0's should compress well
>> so I'm not sure the additional size is that much relevant here.
>
>
>
>
>
>I also thought of new section(s) for long symbols.
>
>
>
>One idea is to have separate sections for CRCs and symbol names.
>
>
>
>
>section __version_crc:
>   0x12345678
>   0x23456789
>   0x34567890
>
>
>section __version_sym:
>  "very_very_very_very_long_symbol"
>  "another_very_very_very_very_very_long_symbol"
>  "yet_another_very_very_very_very_very_long_symbol"
>
>
>
>
>You can iterate in each section with this:
>
>   crc += sizeof(u32);
>   name += strlen(name) + 1;
>
>
>Benefits:
>  - No next pointer
>  - No padding
>    - *.mod.c is kept human readable.

I like this option. It would be better than the current one.

Lucas De Marchi

>
>
>
>
>
>BTW, the following is impossible
>because the pointer reference to .rodata
>is not available at this point?
>
>struct modversion_info {
>     u32 crc;
>     const char *name:
>};
>
>
>
>-- 
>Best Regards
>Masahiro Yamada
