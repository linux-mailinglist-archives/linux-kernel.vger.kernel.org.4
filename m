Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AC166283F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjAIORE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjAIORC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:17:02 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5472315721
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 06:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673273821; x=1704809821;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IRHwQexSF+nWfQk77T+TGeqyWq5zO7dEJ61W9ctuijQ=;
  b=dikx1rfngcDOeVDT9hQ80e7becZO32vIpT75aBQz/YRoQzKSLA2vaGLY
   hCYcysFvpb60hHeiLA3SKkWbmjzWhoLRqzMGFX/wCdyzsJjohYncn4NFY
   X56D/7LlTmRKFx1b2Kx5FDNqTcTgWKg7ebAok/Gx6nXRYKKtgnJ5kp/LP
   0m3L6ktmv6YF685ltA7PDZfQNSI7h+ESNqjZ+8fBfT0vUjE/1VFSh5d7M
   1TVjTHXz/AHHELlTTlwcEdQJRHEdsD+XM8XuxBakLQfzUbcPezr7gRVps
   K6s1mrNpbKdB6fhIfRAZ3KQpH6a1q2W1PStlg3vGJ9679lf2/gnYAHmIK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="324886746"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="324886746"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 06:17:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="745392057"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="745392057"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jan 2023 06:17:00 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 06:16:59 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 06:16:59 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 9 Jan 2023 06:16:59 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 9 Jan 2023 06:16:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evBbjj7UgJtk91PnDetfGAfNz2Cvx4KXmbbBTckKGf6kIlKUcIqp0b7JyKNs7k68DPR0NZkWFG0lIkvX3CMzgpF2t1jNetRhlnSLsx2ncEF6kxF5Fo1IZ4ouJ13dzJk+6l2lAP6PvsUrOTjk0HfcSFS0kuyq4ZeqFeszrTJMSNvJo4iXmsHtZnvfwsKWSMMKcm2S5B7iIg4jbcDyUclleTxjJVTd+Z33131lxDCxmhtR/n96Ffp6AJioZwDkxz1gUidb7rTF1cyOKXMpRVo9SAUsCCXlNZ3DWrfTKDgCJUO5M5KAXl6/SQJjJKMZVvAWIwHAWNexvX1sbKQWxDUuGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+QxNoKNYhUfvgmnw1pUw2o3uTssw07/MLzjYwT6tAM=;
 b=k8j6UnnfLIOTxJP9e9liEWHABF0XWAfa0WFyytBs/VS9rSWySSQK6Yj9MnVIkSie/05JfgOAJsknzYhM4fGyBVkux4NVYqXT9gtCs0DyYf6SY+zGJb6nRnbOVJE/O3sTltLnWxQW6FR9mwy9G4slPtajxNy5dxLhqwrCl1PmNACZqkhZNWPJ27UIGmsxnmu8c9xVtXUhdPDtVA+89zzQB7+YcGLUEN2OpLW3IdDggePWKF81qIOFwiCDjr9T8+3fa8CrRS9C1dVcl/f1LvegZuScV2qauWy1S4+sKUuMPjZQyzpA2DtszDE4GNWRmNdyGuoOG9bro8EhhDCwFmfNNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH0PR11MB7471.namprd11.prod.outlook.com (2603:10b6:510:28a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 9 Jan
 2023 14:16:55 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::878d:c56c:28fd:e1cd]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::878d:c56c:28fd:e1cd%4]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 14:16:55 +0000
Date:   Mon, 9 Jan 2023 22:16:44 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC:     Vlastimil Babka <vbabka@suse.cz>, <oe-lkp@lists.linux.dev>,
        <lkp@intel.com>, Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Lameter <cl@linux.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [linus:master] [mm, slub] 0af8489b02:
 kernel_BUG_at_include/linux/mm.h
Message-ID: <Y7whzPD1Tf6MczZA@xsang-OptiPlex-9020>
References: <202212312021.bc1efe86-oliver.sang@intel.com>
 <41276905-b8a5-76ae-8a17-a8ec6558e988@suse.cz>
 <Y7Qxucg5le7WOzr7@xsang-OptiPlex-9020>
 <Y7VBFLHY/PMbb4XS@hyeyoo>
 <Y7Yr3kEkDEd51xns@xsang-OptiPlex-9020>
 <Y7bi+mjxEJb/pkVZ@hyeyoo>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y7bi+mjxEJb/pkVZ@hyeyoo>
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH0PR11MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: 75e6d250-ec7c-4a11-001d-08daf24c298d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /3HIZafs+BSV4roCRHpLE6iHDVT8JutzMPfnfRgxr7AsJnPwEPfGLUeqYdMV6ET64MWcY+q4pAAiOWDK0gbthu3d59mr3zXRrczNXTaFRk/r2A7erPd4DscWJIhQ2RoohDrYM+dJpDFliGa/exvzKGmWktkG+I4JdkzhzUl++O3UtC5pCB5N8ddfNVmLEPDbD5bXAPB7O8n7X+YVm48d/nvZpK1TfOPieOAfJuugjw9FdPiIUx5KBnNDiM7f7thD4pj3Xip7kpHsXeI+dgKhNYTt2Grdvgq9sPy9ch7eZ7mhLu/CWRPY7gIcP4jiCYarPex3iGd4PNfuXdyUecDS+55IkBBp3Lk0T3gW9/5Ush3yfo2o7/+0OkI6cvjw68B8v+Y6ZqaArja72OgDDrtv5dHJoOdi9rsiL7KzVK//7H2NrST6M+XwhGGk2CepZLopjyn3xajP4NSOBYHBRQpxfbJyE/bIpB8Z9aJ62FuYF2fCUCy7TSEOG3rnFBq5HjYmMe218/H0n/3GCEfuf4V71WP6NEvSK79HIVpDQxIZFIxAsfZxzZRwWKdQa0Cbmf4Xhxm14xZvgBN69zlBoQ1bVa1L/ncpB5NAxhCeckQN7kDL1ppznkCNrQZQXfoJFQSiCiasxcWIMD5XEsq/s9oV9FCEj150HyXAbrAOzjiTk89ibTQC1MP17k4K0iZ/SCp1a6KAFALdtW+gF29btkw9pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199015)(41300700001)(478600001)(8676002)(5660300002)(316002)(66476007)(66556008)(6666004)(66946007)(4326008)(8936002)(966005)(6916009)(2906002)(6506007)(54906003)(84970400001)(6486002)(38100700002)(186003)(26005)(9686003)(82960400001)(6512007)(86362001)(44832011)(33716001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xQYFFbKhcHisy6PUr6ZOekv9A9PwOhZk3Cxr2dhkRbl9Q2nYoxG1563fpSQa?=
 =?us-ascii?Q?JVaZaJ+jRbmeJYCyQSZXL8i++HCe+qu4FFL6S8uAMUPKBIZAPmjdzxVlbXwQ?=
 =?us-ascii?Q?XMr8l16zgLn4qyOk8khVTeyirn1llX3iEUOWtP/N/FmJYYrNdR8osf8gNs1Y?=
 =?us-ascii?Q?/RZHBwY3ldovDvebKZFMoPsPs/wr30eVpMcdK0UHQYoziinjNVi8FsCsPaW4?=
 =?us-ascii?Q?Lx2hKycURtuQT62vGROj3WjctSjBx7hQAwiN5iuqHLVHTseEY2mlhPXr0AvD?=
 =?us-ascii?Q?nX4xF9ZN3uEKXGre9DRnG/Eo0e/rDktedF+5bK8CzpVGXJaSqHRce59KITvW?=
 =?us-ascii?Q?BT8BWUbLOXgfFsqFJRz0t9Ry9DNoLn8EaxQXILRlwKHKCnxqjBDQplCVGQPk?=
 =?us-ascii?Q?4C7jjneE/c9trfcgnI64DS3XyD6NlwabwLMEO6o7KyDJrgjvzakSqVeP+467?=
 =?us-ascii?Q?h5ECVwEvVutY7xWObTBg1pGW++e/lDfYZ7ia5LM2RQbC2ETXo6vrJu93BCBx?=
 =?us-ascii?Q?TrUcxtgmYpOXspUH8Bgz6W0IntONu4cK0hHnNH9Nb6eeL1bZU7BeMqpm/OcT?=
 =?us-ascii?Q?FbJmcTOAiGKvCxGhvVYnxHur0hr7f2NWOZlaih3RN9jAKn5hdU1bqT/62ERT?=
 =?us-ascii?Q?ckVFe3h/XcCtby/BAWQLPh/gr9J+JfpzKJsHlj+q23dwa78uMz/1g74nqzJ6?=
 =?us-ascii?Q?nsJyKbRo3xjRVxlN5R8Hrg7Je9qnYsCD4zCxczIVTIEuYAAQ/q3owO+6DbPf?=
 =?us-ascii?Q?wOqAX0QLA+OhuR1mYXISUHGVUNqLBQLVOZN5kawbX7zYc2zqD4rAcO+h8Luf?=
 =?us-ascii?Q?w2GypUgw0Ab6clEAypavRgOOot+a+B2Kn5J34moRCPv5WKDe6tLqb/7IP8cW?=
 =?us-ascii?Q?m6wN/PZms2BFI7+w0+u/2h4efymy+3FvpHwJ1PIVL1ncUEiFBdX6a+lTICxV?=
 =?us-ascii?Q?hdiUtiAMld3rv4GM7X1fWWLF5Wqm2WXGR5Q3EiBZLAVB7Uk25jL0oldwi4hR?=
 =?us-ascii?Q?Q3SNTimBUqSfHw5OK6foHVfqaB+oeZDM9iSmQXGmchpT0txHpGZgxpj0KR4N?=
 =?us-ascii?Q?p3s48knIcD+AILZ8w6xcL2mQAz+P3r2Tzq9l+3zmsH8TFomxR5NXKbgE1Jz0?=
 =?us-ascii?Q?8ERoX4ffxIJjK/DAzfe8iuOkU/HiKacyoVeZAAMC/Hdak4NCqduuUP/ftZqY?=
 =?us-ascii?Q?oTR/9R5gGm/QJY4Rjda31eEbFDRAXNHcguHJFUEcfJ5KoTdNzhpi8oWzjajv?=
 =?us-ascii?Q?2YPgXJUdiwmeB8qTJTU7hPeswMrsVFLWYuAai9A7/KwtY8P9egY7XteIUr4G?=
 =?us-ascii?Q?Ta1poMNYC1G26CE6o2SQIt/HtNamnvOJ+Ma+lpb6M3Ltw+85K5xO8rhWfKnF?=
 =?us-ascii?Q?mtmTk/fTvQIzi67N/KfFioLk3AuSBuNwPF6sbvHKF++Jwcz3D8TNFip6xOvm?=
 =?us-ascii?Q?CeQlcgHs7J7H3UJw5BRc7CBF/o1PoqmQJhqPfQNaRwS51WtrpbcJUJIW7m0V?=
 =?us-ascii?Q?P4SmbKU3Ih7YC10mEBO0KcQp/ThXFPaY/uR2NxXFDZdHmOETf/dbKRlzD2uO?=
 =?us-ascii?Q?3UAtS6t9mg+wm1swqDS2mZoX5sJCYlIUn59JOxSEaM+t3/BM1dhrr0DocsUi?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e6d250-ec7c-4a11-001d-08daf24c298d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 14:16:55.5670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WmY7QKmT5kYepApS4j3aMyvZAH/rB+njfvsIdIyaR/HkTiB9WGnIkVjB6SgartmjDzDLIucq/j/24ND+6XT3Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7471
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi, Hyeonggon,

On Thu, Jan 05, 2023 at 11:47:22PM +0900, Hyeonggon Yoo wrote:
> On Thu, Jan 05, 2023 at 09:46:06AM +0800, Oliver Sang wrote:
> > If you need more information, please let us know. Thanks
> 
> Can we get a vmcore dump using kdump functionality?

it's kind of hard for us to enable kdump in our test framework, which we
need put some efforts to investigate, so maybe we cannot supply vmcore dump
for now.

but as you complained as:

> > To reproduce:
> >
> >         # build kernel
> >     cd linux
> >     cp config-6.1.0-rc2-00014-g0af8489b0216 .config
> >     make HOSTCC=gcc-11 CC=gcc-11 ARCH=i386 olddefconfig prepare modules_prepare bzImage modules
> >     make HOSTCC=gcc-11 CC=gcc-11 ARCH=i386 INSTALL_MOD_PATH=<mod-install-dir> modules_install
> >     cd <mod-install-dir>
> >     find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
> >
> >
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
> >
> >         # if come across any failure that blocks the test,
> >         # please remove ~/.lkp and /lkp dir to run from a clean state.
>
>
> I was unable to reproduce in the same way as described above
> because some files referenced in job-script couldn't be downloaded from
> download.01.org/0day :(

sorry for this, download.01.org is in migration stage, now we uploaded missed
images manually, above reproducer should be ok now.

could you have a try? and not sure if it's easy for you to enable kdump while
you try local reproduce?

anyway, this is just FYI.

at the same time, as Vlastimil gave us a great suggestion to try to do more
bisection to see if there is a real fbc, we now start to try to find a clean
base. thanks

> 
> -- 
> Thanks,
> Hyeonggon
> 
