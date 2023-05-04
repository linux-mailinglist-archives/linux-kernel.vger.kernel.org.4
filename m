Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A57A6F77A9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 23:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjEDVCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 17:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjEDVB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 17:01:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1786187;
        Thu,  4 May 2023 14:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683234070; x=1714770070;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IfVExH0qardTjdqtJgdlAIcymWuZgM64VE9GNqOqshE=;
  b=gp1T+1Edh+hSnEVcJjmZexVtF79C9WXOK3pWCQEhIHvvi79JFtMWjhgh
   b447WGicV53F+EXTe6PSG4+efvVYaetzgow1HGNi/D2zk426o0Ckr4AyS
   gGmfhq5UjdhVNnXiC4ToDbRfeNe/Q6MXuatNGxRIIEs+kL/uGOVyBo21e
   8F1cWL679QqQ2pobPXSdSKYnlVoT4XRZP1l+8n21rhLUnazcZ51nkh6XT
   RPPEYT7nMvzWf78pD/WYjTgPjM2dI/2dTyKW6vSJlyMh2SBld7Px0GyVH
   PvyvoNSZPZjL6X1Vxi1YtP28z3b8hHH9mruX5wW6LV/kgxFYGZ+EK3qwA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="377131444"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="377131444"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 14:00:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="786732267"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="786732267"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 04 May 2023 14:00:54 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 14:00:53 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 14:00:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 4 May 2023 14:00:53 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 4 May 2023 14:00:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+wNpHuMMXlkXUfjPTC4SwZb74qtNcDOWX+jJSW0IUrP1AjnSOsNbUHYUj3wSlOcC4WoGO1lf8ZR2omoKx0iNXIYKMlgRKmIWQ/sON/pLIvwvLLKjluadH4+87g1xAb3G7FBvYY38OjqKuHESiqHxZfbRUn+0CEB9FkbfZuZaSXHn6jjmLlcc4D46JsHsOzOCUJPcKksI6FxTZNCIzpI+KDBoLlTSKK3Apgd/djG++oAwpuTZjvhwUKMCBak3kgQ6gwlk3c9zw47zfTXPg0jkFX9CYsohlSNXmKeUkSwXidnORJopQhj5jTJnCofNumHjwzKZ6m117cYHRbeoM4XVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuzaY/2vaLzFvAc+FosPk4geRpITSdPSRfKSmuPuvDE=;
 b=ABzKHm3u/gfqEF1cSq5pQpM4nSv+OIjxIKpsy8Geq6vlffocRdogMUgPdKv13AI+5FnYdYiRPwCbLbH4r8sttV8Uz/UIE1bS3uQz7wMTc87GanabwsLCL4sMdHjCcUozff7qYqs15S2FtBiajNCxXe5RK0OQNxj53Y08EKR5vu2hjOVrwSzLGen4zQsBk8MjoI/15WtCfx5oXt3WpTWl6lQ5FZQa2p21gVkaAnrymI7bpRxYb6T3Vq00+uAe3xBQ6F4Lr+QaU9qetIu/jJyVshYSQFIapUjdk6XnA95LrjBDgflSpuGXZ1EM/nut2rkH2MPul4BP4aYPVqa6aYKBWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH0PR11MB5564.namprd11.prod.outlook.com (2603:10b6:610:d7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 21:00:51 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302%6]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 21:00:51 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Piyush Malgujar <pmalgujar@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
        "benjamin.cheatham@amd.com" <benjamin.cheatham@amd.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "jannadurai@marvell.com" <jannadurai@marvell.com>,
        "cchavva@marvell.com" <cchavva@marvell.com>
Subject: RE: [PATCH v2] ACPI: APEI: EINJ: EINJV2 support added
Thread-Topic: [PATCH v2] ACPI: APEI: EINJ: EINJV2 support added
Thread-Index: AQHZfoz/HoY7ASH3bUeV4msZv1/xf69KTa1QgABJGIA=
Date:   Thu, 4 May 2023 21:00:51 +0000
Message-ID: <SJ1PR11MB608326A6AC3FFE42699DDB40FC6D9@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230504133224.2669-1-pmalgujar@marvell.com>
 <SJ1PR11MB6083A266C4A869FC9AAA5A9AFC6D9@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6083A266C4A869FC9AAA5A9AFC6D9@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH0PR11MB5564:EE_
x-ms-office365-filtering-correlation-id: 56517d2b-bae1-4778-a9e4-08db4ce2a4f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OdvvzIAOWmKs7HXpDfGvmhoTFy5R3Qe13VB7OUrFuUT0xA6XjGSw4yLVfrg0/uHj+glr5r1eLSOgAV76HCzLlLZ6Xu/iYjqm58j6eZeenKMDD1QJ0Uznex/y918iYmEUk8ahq2IUecz1rdBUFM2ArB4x/EFbmxCEtq9ZxaN1y80UJR/Ni2fPCBncpHtrYXCqgQzByigHUDEQ+usK/WCsilh9Nxgl2lPg+RHgMAR/bU7sg5kkk+56mci8cEbuc9RV89FCchh9sOWocQF97+PWcVemmtbfqz+LVfo5Peemjjf9NNHQVpD3XMFHS9VR4kTYuyU0IU24BPpVdOfDVY7B7t0Z5qke1VisEeqrscRhoU9Gjd6pSDrcJc4nuehrls0QC/ouIlN4rRV/cY47smtuBbK4lJxubbh0/W2wX6uuwnnFIHBrqIqUNkGXtzLXXjWHs8raEP4bj93Qh7eMyUjhiCDS+I3U+LAB8vH/dcHKn/3/mF/EADmK1dK5cZgZ8n4wS2xU+L+kYBk4MQMkNsSuVrbugB5ZkZfhR2gPUMhvC2s7qrNlwicxUQXjQsA9vbg3XOEBZT7FdmPjhbOTgIExmJVU5rX9VSeCjn+Ve3GhlLHd8Q9JQWlyd0YMM40MHeVMG2aaTTdJgeI2cRdppa7sVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199021)(9686003)(26005)(6506007)(7416002)(186003)(2940100002)(110136005)(122000001)(478600001)(33656002)(38100700002)(41300700001)(54906003)(7696005)(921005)(71200400001)(55016003)(52536014)(5660300002)(8936002)(8676002)(316002)(64756008)(66446008)(66556008)(4326008)(66476007)(66946007)(76116006)(2906002)(86362001)(38070700005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YBtoiZX92RFHSYGyEjyv+dcIrBcj3heBJ/FdVWI9MURSScN0GdpgmbLMrJVk?=
 =?us-ascii?Q?VcMGChqo0yWTfeNXZcOOCuwtDVxTaHQNfafY3Qb4axHNRS5uxIZEcK39pmld?=
 =?us-ascii?Q?RDW07oSq73wsw6vGoIpnR3dDPiOgZkMiLkuvuBJMRpA084jLuy6+hESAvqR2?=
 =?us-ascii?Q?ZbF8kK0B8zTnmRPOngR+hyURAPQhDvieW70nvL2ken9Us91XhqJvKbdRf5Sp?=
 =?us-ascii?Q?5/ZvGWDjG7CXpr7whtxfMuHClJS57wOxAkrONMwKz7zWqnW39iNikoKjruzT?=
 =?us-ascii?Q?XbRVleLgAkqe0M+iDJSoTdhyQBIN3D+YUKElGzjUMmQMQNJJGe5ESvq4svu7?=
 =?us-ascii?Q?DUy6WrtSjVEpgi1J8vIvj8OqErLEF2KfbLzJBmdb10axxjsnIvLGlDay5WC9?=
 =?us-ascii?Q?YvfpigGQnG/N1HXZcNVHJWXPlIK/WV2WxRjM0KjT4kpFg5L1aLDwx3CVPIQT?=
 =?us-ascii?Q?GUtx9Lb02EUMJv4iVzb9Q4ZqNhEE7XZB0dBX1LyC21R0rvD1//B42Uh/SbM0?=
 =?us-ascii?Q?qYmGTHKEuZi0QHDopDiI68CzAD7N6r/RHeBCebbCl16jjISHB4mid5O6a3BX?=
 =?us-ascii?Q?mO+xdg+mQZXq2eJ/zNc9PlQRJfqUxlgSUWoyxXofWS2YrcEY0QVpjySULXxA?=
 =?us-ascii?Q?BSBxYIcRLTtLVBQkwZs7/Q/BH/fPMRy02U5cAECxRMRb1xT62Mh0tqiRF4bN?=
 =?us-ascii?Q?qENYy/roI6C0Sjjw4d1JJX9BAw6E/IhVm9RsKUpEGb1qAyYeYmaGM3ULfcbX?=
 =?us-ascii?Q?YhUWDJuY/7BJYorMI3aRIkJOBQsuIbCm87aO6HPy3GP+R/OYtviCxItaGi2+?=
 =?us-ascii?Q?4Zd33T5nlpvG5h8Fr6oGKRtjbCT4yqM5FcVXpqJqRAhc23RNEClYJoMfApp4?=
 =?us-ascii?Q?qnLildXef6+lVjErJvoV8dDBqeFdQZOqpoW+Dy9GhjU3hcoJT7NdDx5wl3Kp?=
 =?us-ascii?Q?vTJTaf0VjZLRwg0aBBxMbNc3Ys4dZt7BLLj95iMRRfvnLPE/IOa6ue44TqKX?=
 =?us-ascii?Q?3eiZAT21xNhM85gRYWaR076J0zl/yhylSPJ+HMqjhuGLZI2NZmri2vfEuL/N?=
 =?us-ascii?Q?QxzGEF/6m/94eXl1dqRD824k9CNlREXKPdWBBk2YPO64io8KJ0SyC8Lc8hfk?=
 =?us-ascii?Q?/ryuIdJJO3AzbixrHlqBlYmimmfNcdrehw0ZGY0y0yuLRx39cohLlPNpofad?=
 =?us-ascii?Q?AeqFTfGWl8K3sNhVFbM1ObeBJGT8Uk7wsY+qaiZGOwmMfGMiT23OB2t7wJRi?=
 =?us-ascii?Q?KgUizwqopRDKxGBZyH3pVpeppRf6wPTGOrsNLfPv9p1Q++UfZvfk82mdeNQ6?=
 =?us-ascii?Q?OkPGWteUQJNx2bjDyDoCjhFpqwJJAEZOmkpFYnaRAsB2/58lXz3vPjggC0WQ?=
 =?us-ascii?Q?hNMHXdZqS9YUTNFNSxe26iwKlLIJJdvLMNqBY/yxFSXyxfJNllIe70+9H0rG?=
 =?us-ascii?Q?M50c1g2vEWNv+9qjhAsK2znQzRMLDzy8oqIXYGQjshktN6rFJZh0TYsfb23+?=
 =?us-ascii?Q?1rflmcfdu4drjLRUsrJ9oc7APfuoekk5YTadrLfa+hrP6eK/J8ux/HkT8Mtu?=
 =?us-ascii?Q?aZerEnL8Vd9bVCKpbL8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56517d2b-bae1-4778-a9e4-08db4ce2a4f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2023 21:00:51.6609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gh6mZ7kipxT1QORS97ABiMJZmEs3ZEPfVfDK2+PIfOXyWu+UTPdDGDZPbM56Bjip5LdideMS7WWRSEDDQW6ylw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5564
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +An error injection example::
> +
> +  # cd /sys/kernel/debug/apei/einj
> +  # cat available_error_type         # See which errors can be injected
> +  0x00000001 EINJV2 Processor Error
> +  0x00000002 EINJV2 Memory Error
> +  0x00000004 EINJV2 PCI Express Error
> +  # echo 0x2 > error_type
> +  # echo 0x5 > flags
> +  # echo 0x12345000 > param1
> +  # echo 0x2 > param5
> +  # echo 1 > error_inject
>
> Is the expectation that platforms that implement EINJV2 will not include =
legacy
> EINJ support?

I spoke to some BIOS folks here. They said that the ACPI 6.5 change is an
extension to the action table with new opcodes for GET/SET when EINJV2
is supported. The legacy actions are not deprecated. So platform firmware c=
ould
support both old and new injection formats.

So I'm going to double down on this:

> Maybe it would be better to change the top-level directory to:
>
>	/sys/kernel/debug/apei/einjv2

and say this isn't a "maybe". The EINJV2 interface files should go
in a new directory. The old files should continue to work (assuming
firmware still enumerates the old available types).

Simplifying the interface for EINJV2 in the new directory is an option.
I think we should take it ... the "paramN" files that mean different
things for different injection types were an evolution rather than a design=
.

-Tony




