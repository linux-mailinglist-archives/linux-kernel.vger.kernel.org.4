Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB0F6875E7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 07:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjBBGdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 01:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjBBGdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 01:33:02 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CF1A257
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 22:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675319579; x=1706855579;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gp5kTTV47LeBWlm+r6oG3azQWQ4werq+oDXtigPPRiE=;
  b=hrVbo3nRTyCbP7AV62GeIT2Q5+n2gOxt78cJZ0WorFpTl8ViFsmBIIF0
   QfrPu/Xjz0GPyp0+bFK9CFsJjXu/yVDTq6GHm9Pvdmn8AljiW6XSmY+sy
   sehXophTxk/JfvStawvLkWUqLi2QskVCIaO3sw4GgYGl4vSmbEG6cWD68
   F+Uq282sPLPTJtNEr85eK1QehzBe4Zr3ZJwyzCPkrXIY0ZEBiEEbi6O+v
   zyfIDg6ZuxP5uuXMfEEy/POtQ8j1MuqhykVhoItypS8m7XlXAOzDY4x7z
   pOxIHCA61Qd2oCHKJrwNoxKZVRTVEsfrl6L3zfzT37HPvufWzekvSJY9U
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="392950442"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="392950442"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 22:32:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="665157556"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="665157556"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 01 Feb 2023 22:32:56 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 22:32:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 22:32:54 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 1 Feb 2023 22:32:54 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Feb 2023 22:32:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfI7ur05YwQjQ7MAbNfojfWts5ZnwgBIwbyzkLxI3sVz2zA/f2EIvYuERVd71u83p9jlC5m2MQV4/zcQjTXdQLVm2549kpD8UfuCi0san2K3ju0nF8WqVH/BS0jCcJ28PPHQLgegNOr2A3mbhJ7WbqmmoZ9zxBgQ+A6bOsqGUus5ZTefAlo0EMgDeZdKMU+1QaE+oW/YCFt2GncADBWjfCt9V97Qn9iGaMO9MXOcgMw7Lqq0OVvIbWOxmTaHeovIB7KZtOL8xt3RLwOGKgv0hYYZU5jP2I8pnj8sMsAP93I22ju0SUWJixvbNb7ssZ/5iTszyG01qIcH1+9Vtg1+VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gp5kTTV47LeBWlm+r6oG3azQWQ4werq+oDXtigPPRiE=;
 b=Tcb/ErT5bjpzwASaXtMgz+95aShe2mh92xP4s43j66QhWKaCDuPHhI7dce/WdKGhbdiwdofBJvKRVb7zacNXa0P9eLB0yc+64Rv2MdYH9p06/PapWMCjceuRRax7uPDQCyZxUmq6PmuHKmxfIgipHqjXeIimgxjucYt7YADSrk+1rsmwLxLMFGFHBqR0fwSW66U5NUKosAhgOc4vL0KpLexzQVGt5hcRIRPL6PswbiKEKLy5sTbPee1mszHJgvJtlFbwKo/VWUB7Kh7FmRWx3HCWrI1G1ELVl0KzATQYsvgcnrsXa/jkMwVnXw4udmuk+vOXFR+K/EVoSBChyvbGrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB5002.namprd11.prod.outlook.com (2603:10b6:806:fb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Thu, 2 Feb
 2023 06:32:36 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%8]) with mapi id 15.20.6064.027; Thu, 2 Feb 2023
 06:32:36 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
CC:     Baolu Lu <baolu.lu@linux.intel.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "Lu, Baolu" <baolu.lu@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] iommufd/device: Change
 iommufd_hw_pagetable_has_group to device centric
Thread-Topic: [PATCH v2 3/3] iommufd/device: Change
 iommufd_hw_pagetable_has_group to device centric
Thread-Index: AQHZM14dxdHVToGJbUKK/xSgiTyXrK61IE4ggAAUtQCAAY21gIACqcMQgAA/WQCAAAFJgIAAB22AgAGEHaA=
Date:   Thu, 2 Feb 2023 06:32:36 +0000
Message-ID: <BN9PR11MB5276076C2048581CCBA6011A8CD69@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1674939002.git.nicolinc@nvidia.com>
 <002911839dd30990d5e3135f8a0f8d41f14e856b.1674939002.git.nicolinc@nvidia.com>
 <BN9PR11MB527697E1E24784576C3FB7628CD29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y9ZMulxEyGvnvW0X@Asurada-Nvidia> <Y9eaLpD1XIvE/3Nh@Asurada-Nvidia>
 <BN9PR11MB52769883FEE25F0BA731220B8CD19@BN9PR11MB5276.namprd11.prod.outlook.com>
 <df494d34-d804-e743-023f-d1effc881628@linux.intel.com>
 <BN9PR11MB52766EAE924EB5DC320FC1488CD19@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y9oSs0TJ/KZKWCw1@Asurada-Nvidia>
In-Reply-To: <Y9oSs0TJ/KZKWCw1@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA2PR11MB5002:EE_
x-ms-office365-filtering-correlation-id: e35e8566-ac18-4d80-cf87-08db04e74607
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aMmPoF4W0z2il7u5YWzGgnY4yb/ZSey9Kzdd/9yxLiQPTY++ekrussHRjZxgxAlLMeXFsCXvE5u3S9rOOqy/O9fbe2KmMdBNoSzK/NR7oA/ikFa4b4FrT39BmEcQxijXMwWFGvbYy9+e2kRfOvE5bd4KSMhScxXS3d/Dp1eA3gLgcc+8LHpfytJBOfIC8JXa5K+xc5o/h5qINtwMs3+SAtFUFKjC8KutmZ52KtKKPsbs/fXvQlPm+Wzq3HEWZP3YJgmK9+uWxBuYqCl7y72TDWGmGsb2VFeFCxeHTRe1FkC/Us8rJBsIjhe99g27aPNadtTSdJ6bo7B4jV1VLC+57yiuyBMVTush3OcP9eW0OONGrzWMpwhiBnWf90SvuPMGf5czZoKB6F9JCnHLnRiA2rJ4fWzt3b86bQ/qysnb0RJ0EfuCUyaf65Er5gvVNbq7C44C+p826d39fm8vgP7BNG5sBU9glt0jnmRIu6CV4cJGNorBJ9wnotYS5m8blWiAkH9eUigqLkypGJB47biIlpxiPfDfQ2aoM3ELlyPWPf9ESg18VYi2lKECJNUZNuxhznu3v8BU7gt6fGm8SjwBNAAIL3qkhp3I9NC0ch9QaID4o5TFHGhKAmL2+zt6aZrsKAYwSjeOw6j43xkCrNNIHercYkBlk2PPzpO9irAUo4na/LSr33iJtyKe5J/I3WTUJZ5y8AzHbEaT4TG/64F2Mw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199018)(33656002)(26005)(9686003)(71200400001)(86362001)(7696005)(478600001)(186003)(76116006)(66946007)(64756008)(66556008)(66476007)(41300700001)(4326008)(6916009)(52536014)(82960400001)(8936002)(6506007)(55016003)(66446008)(83380400001)(8676002)(122000001)(38100700002)(316002)(54906003)(2906002)(38070700005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ni9leS9Lc3NRb0poMjd1L3Z5ZExyanM2SlQvMGhJNDVRUU4ycUYwTENoVGFJ?=
 =?utf-8?B?V1JUQlE2VHpQSG40enhaL3h5alBQZFcxbGdCQTRKaERJUTFvbmJuQ1l5bE91?=
 =?utf-8?B?ZllNZlNBMGVGSm1vVnZNMnJ2aGoway9SeTk1cFl1SlFQQW54REQ2VlpLdEhs?=
 =?utf-8?B?QndTYVgvbUJiL2N0Slg3MUdlVU8zeTJGVFNRcUhJWDc5TjZ6Nnl5WWFEcFZh?=
 =?utf-8?B?SWpBNzExRWVYVThsRERyZXlnVktxU3M4d2RkWTdwdTdUcC9JSVJDK0VyVEdC?=
 =?utf-8?B?QlduL211T0w0QWhXcXRSTTlBaHMybzZVWHVSOFpRNkxtODkzQU1Jc2JwZ0Nk?=
 =?utf-8?B?WDg4YVRTSGh4cWwvRXB5VkR5UHd6Y3FpS3dmZHNhVGlxYXFiN0c5ZHIza3hW?=
 =?utf-8?B?NVFjMXZqOU5hOWtBUmxJc2krMy9WdXVIaXhlK2lDdUR2OXI1WGRCVHIyS0du?=
 =?utf-8?B?Q2E3dXE4bGYvajl4STlTbE1GMVdMaEtnNmRQVHd1WUFjTjVIYVIzNzhqRmN6?=
 =?utf-8?B?bFVGdDdMSjk3UVg1YWtRaktMK1RyRW1vWlo0QTRsZEllRTZQWDJURFExb3p2?=
 =?utf-8?B?WU12MzZZVFVGMzdXNWVhVk1INC9iOVhBMytpcVF2SnQxbFY0WkVaQmY4MUpO?=
 =?utf-8?B?K25WNm55aytJbnQ3MUlrMktGSzluNzl1REhmL2hQK09ZN0VFb0lnUmIrNjdt?=
 =?utf-8?B?Ly80R3c2bUtjR1BtMDhJQWtuNmZueFpiRXBxTlE4RVo2THg0Z3puOFZHTUVh?=
 =?utf-8?B?KzBvQ0NMUVYrdE8zanhTN29VU1VnaEdmK3owbHN3QWZjbG13ekNONHAwcmRp?=
 =?utf-8?B?RHlhbGxtV0N1VGxMSFNzOTE0akcySWNaTDBqemhoak1CRTdPZGFOeWpQcmlx?=
 =?utf-8?B?akhFbDU3NVJyV2NLc0FmOUs4RUNua2NaZ1k2QXpBakZxRUlPenhoY0NoMmFP?=
 =?utf-8?B?QldQS2U1S1VUbTArWUJVRFJPYXJNWk5hMzUwdmlOeWF5dTZ4U2hrQStyYmVO?=
 =?utf-8?B?elJ5OXAxZ0ZWWVBwVldXZEZpSXJmV2V5SElCUXFzTVJMNkt1K1IySFRJQ1E2?=
 =?utf-8?B?TmNCL1pYT0h6elo0UDluNEozRDhqQS85YUlDQXB4d29wekhYOUd2bGFHS3NR?=
 =?utf-8?B?UXppbHZxelhvTXY1MGdOaHQ2MndOOXBHUkcvS3JyQnBvbnR4QlVEY2xrMGVQ?=
 =?utf-8?B?MEIrVnlGZnJjWk5yVHducHovRVRUcWNwVS9TUkZxR1F1MlRmOHpuSXlLOUlq?=
 =?utf-8?B?bVkxa2g1dklTdlNGeXAyaGk2ek5KMHgyMWxhM29Yb1VoQm9rR1o0RThsTVFl?=
 =?utf-8?B?VlNkeXpHZkNMbEREbHUvWkk5bEtlV2Yyc1RKbEl4Y2VYODRxMkxOMUJ0Y3U4?=
 =?utf-8?B?MXU1Q0lOOUtXUm9KY3JmWWxSRnMyWVA3WWV0dWx0MTFuTVl6cktwTDJmeEMr?=
 =?utf-8?B?cmRCNEhmVFlxWFAyY3p6amNtMVNHNlprdzF3eWNkZ2xVSlpCRjdmdzZoVUY1?=
 =?utf-8?B?dUNIYXovSitFYjIxOHV4TmFwczFWajZzSDlnWklzeCt4Q2psWnNscGJVNXNF?=
 =?utf-8?B?LzY1R24zZW5qUkJYVjZlUHZxdmx4NnpRV0pFMFFlQ2IyZnczcllBakVzQzVv?=
 =?utf-8?B?ZVlvR2h6REd1N2pSTDBCWDl4MWhQSkt3ZW5wNDVORUdWaWtQVnNUeEJBbFhh?=
 =?utf-8?B?SlJSOXZnVlBNdzJvU0w0Z013VnlrTFhMK0Q4L29VKzJTYUVibFhLakxIWFRZ?=
 =?utf-8?B?ZEJnRG9BaDFXZVlWUHk1Z0x2K09jYTdNMzA2SS9mZnVTR29VY2d6MVlsbEVB?=
 =?utf-8?B?SjlTd2dLU0N3K1FmeWY1c0dwNjNXTXJtcER5Q004MkMwVXlBb0MrcmxkYkRt?=
 =?utf-8?B?RGQvWHc4ejVhSlVwZEhXclJMdzBpekdDS1dFQy8relE1eW8wU09qaTRPWkIw?=
 =?utf-8?B?YkRTMUNaTitCQzdhd0M3SW0wWDh4Z0NaaVd4NVNjNUMwSVoxODBpeklFNmFw?=
 =?utf-8?B?ZFhFNEpxYjJieGFjUnRjQ3NxY2N0dEFyR3NpUW5zMzgvMlJsQ0x0Mm9rUjI1?=
 =?utf-8?B?WEJUZWhuSExQZXJTWlV2VmNZNUwwSmlGQ1hkbDlHd2xQdVZCb1hzS0R1UWRs?=
 =?utf-8?Q?cgZKC5GfjI1+DrZCo8ivYnLBY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e35e8566-ac18-4d80-cf87-08db04e74607
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 06:32:36.1461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pv66+nox19lvYE7se/R/SkB8NsWJq0QHrYtRw/TCHDpvKkXKACuNwuOtcpGsGMQS9yBeWhVusCq4lJRz3Ey9dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5002
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IFNlbnQ6IFdlZG5l
c2RheSwgRmVicnVhcnkgMSwgMjAyMyAzOjIwIFBNDQo+IA0KPiBTbywgYXNzdW1pbmcgd2UgZHJv
cCB0aGlzIHNlcmllcyBhbmQgbW92ZSB0aGUgZmlyc3QgdHdvIHBhdGNoZXMNCj4gYmFjayB0byB0
aGUgbmVzdGluZyBzZXJpZXMgb3IgdGhlIHJlcGxhY2Ugc2VyaWVzLCBvbmUgb2YgdGhlbQ0KPiB3
b3VsZCBlbmQgdXAgZG9pbmcgc29tZXRoaW5nIHVnbHk6DQo+IA0KPiAJaWYgKGN1cl9od3B0ICE9
IGh3cHQpDQo+IAkJbXV0ZXhfbG9jaygmY3VyX2h3cHQtPmRldmljZV9sb2NrKTsNCj4gCW11dGV4
X2xvY2soJmh3cHQtPmRldmljZV9sb2NrKTsNCj4gCS4uLg0KPiAJbXV0ZXhfdW5sb2NrKCZod3B0
LT5kZXZpY2VfbG9jayk7DQo+IAlpZiAoY3VyX2h3cHQgIT0gaHdwdCkNCj4gCQltdXRleF91bmxv
Y2soJmN1cl9od3B0LT5kZXZpY2VfbG9jayk7DQo+IA0KPiBTbywgcGVyaGFwcyB3ZSBzaG91bGQg
ZGlzY3VzcyBhYm91dCB3aGljaCB3YXkgd2Ugd2FudCB0byBjaG9vc2UuDQoNCmZyb20geW91ciBk
aXNjdXNzaW9uIHdpdGggSmFzb24gSSB0aGluayB0aGlzIGxvY2tpbmcgb3BlbiBoYXMNCmJlZW4g
c2V0dGxlZCBkb3duLg0KDQo+IA0KPiBCdHcsIEJhb2x1J3MgdmVyc2lvbiBoYXMgYSBzaW1pbGFy
IHBhdGNoIGFzIG1pbmUgY2hhbmdpbmcgdGhlDQo+IGlvbW11X2F0dGFjaC9kZXRhY2hfZGV2aWNl
KCksIHlldCBhbHNvIHRvdWNoZXMgX2dyb3VwKCkuIENvdWxkDQo+IHdlIGJpc2VjdCB0aGF0IHNl
cmllcyBpbnRvIF9kZXZpY2UoKSBmaXJzdCBhbmQgX2dyb3VwKCkgbGF0ZXI/DQo+IEdpdmVuIHRo
YXQgd2Ugb25seSBuZWVkIGEgZGV2aWNlLWNlbnRyaWMgQVBJIGF0IHRoaXMgbW9tZW50Li4uDQo+
IA0KDQpJJ2xsIGxldCBCYW9sdSB0byBkZWNpZGUgYWZ0ZXIgaGUgcmUtY2F0Y2hlcyB1cCB0aGUg
Y29tbWVudHMgaW4NCnRoYXQgdGhyZWFkLiBCdXQgb3ZlcmFsbCBJIHRoaW5rIHdlIG5vdyBhZ3Jl
ZWQgdGhhdCByZW1vdmluZyB0aGUNCmRldmljZSBsaXN0L2xvY2sgY2FuIGJlIGtlcHQgb3V0IG9m
IHlvdXIgcmVwbGFjZS9uZXN0aW5nIHNlcmllcw0KYW5kIGxldCBpdCBjbGVhbmVkIHVwIGFmdGVy
IEJhb2x1J3Mgd29yayBjb21wbGV0ZXMsIGNvcnJlY3Q/IPCfmIoNCg==
