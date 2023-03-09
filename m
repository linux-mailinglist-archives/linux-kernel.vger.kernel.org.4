Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363A66B1BB3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjCIGnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjCIGn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:43:28 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075B21F4A3;
        Wed,  8 Mar 2023 22:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678344201; x=1709880201;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Of/Y0BaC6F4pHEFY2stwvByH8/NPe4eu5jJn+kl+aIE=;
  b=bIfivVcGqoSAKF6pj51UUswE4Sw5YKZwaCNSVC7CKbV5t6w+Nd0mHT2C
   2jl8YVXyyouIdk9wJkt2B/BRUJPx2Pjq1T+xei/BanDdLK70cIA0zzuJ2
   dAa+R4ro3hGfLXTYRhQBTirGm/wanApv/t/aK27ZdQNwkEcScSvHL5R1C
   fUC6G9jeQnePKc2FNc5Kmj3VAm1LneT+wh+nQ/G8Gk7bp+4FWBJlDlrO2
   txDRpSSxNQu4N70i7PigJ3r4zowlnxq/2eBEtsVUvaUg6oNVXuSeJDTRr
   DOEbyyReSxQIWfaRKTaHNqPbnFvG5CdeOy5x5p4Kj5XGfKhIweOKl8beL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="364004239"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="364004239"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 22:43:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="677260918"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="677260918"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 08 Mar 2023 22:43:20 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 22:43:19 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 22:43:19 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 8 Mar 2023 22:43:19 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 8 Mar 2023 22:43:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwFJk/PtX+KG5TXYd5OgzXgI+5KkFhhtEj2ULaYrulRxHaOo7q7JmizSzrVa8oD9hdTQYnHusPkHwRAmIarIQKUmQlrq84lzOC6awKW7sqXSvfAmqY2xb78Exnawi38L8TBHR+QxEIH41GpDjyyPeRvV5GGbvPffKYxuI+OzMbme7S9MCIP4BdQIIaj2DzH8rN7LHsXDqEcIeBto6+ZB/NpRzgBOGspE6VEqqvWl+QHqPG/lq8Cg876JCLB0iApc0C70FY3aZc/gfz2JiZHdrQeJvxWMc7/iZ9c+3X69mkbp0u9w5b6c6NBl+Fx6EKF+0ttwihrbpeNjg+xG41ifYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Of/Y0BaC6F4pHEFY2stwvByH8/NPe4eu5jJn+kl+aIE=;
 b=kRbnbdmGnhmrN2y9ozd8L/KuWy06QNHseeIS5jUqPqDBff8D2Eidf23nJl+afsVb+TLRBEpYypHC8HsPHtuJ+gjYo5bjauNDuPMOL9q+I6KXf4iWtW8lXi0pnruwuM+s/QC/+XFUNRkzwPsvi9FPm43y5wmGWgmNzdXIjwSJOC5Rw0MeGpOVkXv/Y1HnXWMBu9KSdyWbwhfQOAbHMD93/WfBB+a+0XUz9cNGBE/XGp+zQl4tBVAC1V0kH245xsz2HkzFhkIvdJrY4EmEDnX+ChjQdQCzZeRr3LeLsX+UunpLn4420wqpWbewAI7Ig4euxVxDbTUINxu2HBil7jLR0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3065.namprd11.prod.outlook.com (2603:10b6:5:72::15) by
 IA1PR11MB7367.namprd11.prod.outlook.com (2603:10b6:208:421::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Thu, 9 Mar
 2023 06:43:15 +0000
Received: from DM6PR11MB3065.namprd11.prod.outlook.com
 ([fe80::fcc8:cfc8:5056:5f8b]) by DM6PR11MB3065.namprd11.prod.outlook.com
 ([fe80::fcc8:cfc8:5056:5f8b%4]) with mapi id 15.20.6156.029; Thu, 9 Mar 2023
 06:43:14 +0000
From:   "A, Rashmi" <rashmi.a@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>
CC:     "kris.pan@linux.intel.com" <kris.pan@linux.intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "Vaidya, Mahesh R" <mahesh.r.vaidya@intel.com>,
        "Srikandan, Nandhini" <nandhini.srikandan@intel.com>,
        "Itha, Vasavi V" <vasavi.v.itha@intel.com>,
        "Demakkanavar, Kenchappa" <kenchappa.demakkanavar@intel.com>,
        "Zhou, Furong" <furong.zhou@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
Subject: RE: [PATCH v1 2/4] Revert "dt-bindings: mmc: Add bindings for Intel
 Thunder Bay SoC"
Thread-Topic: [PATCH v1 2/4] Revert "dt-bindings: mmc: Add bindings for Intel
 Thunder Bay SoC"
Thread-Index: AQHZL7b54OzBYjM1LEyj3sR4Tt2gya6tb0sAgETROwA=
Date:   Thu, 9 Mar 2023 06:43:13 +0000
Message-ID: <DM6PR11MB306560B02E22BC934A6BFD1F8CB59@DM6PR11MB3065.namprd11.prod.outlook.com>
References: <20230124054427.28808-1-rashmi.a@intel.com>
 <20230124054427.28808-2-rashmi.a@intel.com>
 <c850df25-57b8-3172-8e5c-c466dc8556cd@kernel.org>
In-Reply-To: <c850df25-57b8-3172-8e5c-c466dc8556cd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3065:EE_|IA1PR11MB7367:EE_
x-ms-office365-filtering-correlation-id: 2e9a7baa-c379-4c52-109a-08db20698e85
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HYcfrpV3Vy9DX5PVUcYmxIrvh63+Lq0YbZ3z3kxiv+NmGFqJsSIaN3qfzPD8PwlkVov2lIfWaPyd5FE0DBccs3Kbc9L5h4ExFc4ym6inHFx+0SlAyBVq70dGEMJXlQ+hUuev+k2OuPGLhgWuPcPGrAWVvWQxpVKx2SUkQ7H4TDwZ3mwJ66FC3Quh0ExKiMJ3ORSUSzHBQPSVfoSpFytCXrmjWYTKQXpgtqEGiQwPPWhpx++e/vfbs7ppkz4oVUJfcSuiPeR9f09N4TgTPVcUUGwOr3QnEj7Jzv9pm9mh3f4EQnGkoxypnLHjCOhD15sOYuHVgEXraABVWK+0h2hXkAu8q4PY4BJAKwYsiKb46y0tu/qICCIkKlPfIVEn/QGZZmoT1mg+GgVOametwyrBrzG2HWBEdbSUYFvRr0NkteJ6EwrKsxYNLD1c8HlGfbPg25cjd46CjLR3it0LkOtrfq/clqIZZ+B6R6c9YIBBG6XAuJ3p0s3TAswCd4Hxn1cWY9zdIU2YFvu8sTX5SdEp6PpTuBfV27XGO1CBjkubOdfUYP88eeookA+09P2TYbHfOa+65XbN/BEyWTj2q+6nxTDiApJXRzgZ7kPWKzLMGorZxajpDmBa6gF9nY9zEC3gHB3rjulusrf+TfpeLuvhyxj36COKuo3YXG9esAw74W7QZPeX8JnW7j3olSgWjfkDK+ed2bf+V+iSOPc+A/BOVKyiRkbyN2lfNmBUAkUypaI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3065.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199018)(33656002)(921005)(110136005)(186003)(38100700002)(54906003)(316002)(66476007)(52536014)(71200400001)(5660300002)(478600001)(8936002)(7416002)(7696005)(8676002)(66946007)(64756008)(66556008)(2906002)(76116006)(4326008)(41300700001)(66446008)(122000001)(82960400001)(86362001)(6506007)(26005)(53546011)(38070700005)(55016003)(9686003)(55236004)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVZrTTRsZFB4Wm9pMmdtYXo3MHBrN1E5ZCtlWG5qWTJLSHpUWmlydE96eDZF?=
 =?utf-8?B?eVJqVk9HbFNuM2o2bkxMZllNWEFKS24vSWVzRFpnak5ZY0paUEJiYk9VVzBB?=
 =?utf-8?B?c1RpZHkxQVROdVhWRzBXcmU1Y2JKYnZpTG9OOWhiUVlZeUQxZzNJNGwxSm94?=
 =?utf-8?B?M3RpRFBuQy82SWZDaW9jNW1hSE5QMVBaWmhTN0NaNzFEekZ6empVZWEyRzNX?=
 =?utf-8?B?N0xhUTl5UHpNY2x0K1ZBMlJLeTNZbHExZjRiT0Rwa3RBYXROdkJqbExoWHJy?=
 =?utf-8?B?VDhMRjBBT2t5dW84SHNPSGZubGdyTGlYNXBtT3J6VWlBcVk1NkhZbkkwdWlp?=
 =?utf-8?B?bnJOd0VBYW9JbGNkTXRNQldyNEZQdVBLU2hCaDhSUnJWZ0VCb3dRU1NMQXo2?=
 =?utf-8?B?RExXWng2Y2ozR0ZEdjhiRTV6bXhLUzZuM3N0Z0VzWi9hQWIzTjYyM2JBZTV1?=
 =?utf-8?B?cjQ1RXlQNUV3RW52YTBRaW9STWFYYUVCSzR4LzVCZ1RyVmlNT3hPRnBTazh2?=
 =?utf-8?B?dnh2cVI2Q3lCY3hIaFhtV0dKL2VDbEZyV1JEZ0hmOS9ST0dQaDhWQ3hUVVpm?=
 =?utf-8?B?ZDg2dzhocnNBUzhGN2kzczh2L0l6bFpqc1ZJWEowc2hXdVZ1dGJWT05YV1A2?=
 =?utf-8?B?QTd6cFFialVwVlZpYkRzTDRGRkFocjFFMEM5VjNrWHdBNVZwOUo0MERYVXlr?=
 =?utf-8?B?L0prMkxVajY2OElnMGlRZ1JVMEk4ZnFSUVNhK2J1aUJKOGZPNlFSRmpjaTlz?=
 =?utf-8?B?K3pDcy9waCtXamFQZmt1NjBYNFRmdmJUVWxhekFrVzRxOGMxNWxsNXJQdXFv?=
 =?utf-8?B?VXlFUnJRdU1idEkzTFlTV3JLV2J2cEc1ZmUzSmxOb2N6RDBFMXJ4dDRtV0NM?=
 =?utf-8?B?V3FQd2krSFhKUHR4V09nYkNSa3MzWHNhRHVaRWVEd2RUZlY2YUJrdUtSYWpY?=
 =?utf-8?B?WlNVSThyQkJXMDFJVVpFenNBd0NIa0N4cHRtVVY4OFNmdHlPUFkzSktrcEJO?=
 =?utf-8?B?WUM3SjhERTcwYXZLVGZ2ZW1RR215SUc4SFI4QnNRRTZEMEZKNzRzamNIK25P?=
 =?utf-8?B?RlZDeWxFMnVxcDJydWJaOTVZR1hEMjQ1aFM4ZjJrZ0c0RjhLbk1PaHdnVWtN?=
 =?utf-8?B?eTRML0xGaE9MOElta1FPTFJnSmNFOHk2MUF4b1I4cFdZelBpSFZKcUgyV1pU?=
 =?utf-8?B?ZHZpeEFGcXNFWlRuYS8zZ0x0S2V6QW0wRFlyQUNqd2htZnEzcHB1ZlVBTVpY?=
 =?utf-8?B?UGdIZ3ZmSnNXTDg1Z2tPb2IwQlVIZ0ZTT3dRVjhMS1N5Sm42cWZXTUtPaDIv?=
 =?utf-8?B?WmdIdVhMemlRVjQ2Q3dibmJpYTBaNmpyNlAzeDB2bk1zbytaUmdRK3QwZVFV?=
 =?utf-8?B?dFdTRmlSZHBpOGkvSFc3bWhSVCtZMU5FNFdyQ2FmWXR4ZW03WEZKYWJxMHQ0?=
 =?utf-8?B?Q0NLZmY5RExUZWVKMTltaVJVV1Q5d0FvZkt0bGI3OHJkeisrVDBtSkt4V0Nr?=
 =?utf-8?B?ZXFSRi9HNmJMNmlGZDRqSHRkVnJlOU5mL1FUSEZMck1lYk1vL1E1ZXJleWx2?=
 =?utf-8?B?ZXUvcXo2bTFsYkQyQkNqNzlFQklSZTkvM1pXZGdlcGVUMkxUWnhTWHRVWU1H?=
 =?utf-8?B?SE1nUUFnVUNKM2hrOHJLVnFIOEZzNzZpbXpHV0NkN09KZWdGVHBCU21TcGFE?=
 =?utf-8?B?eDlLVEpGcGVvUXJpWmlaZTNBNDU3NzFCTTdJVDFnUHpqSnVPbFhTRE9qTCtX?=
 =?utf-8?B?aHlucUlkRnI5N3pXRDNSVy9MTVJzZmxTdENLeEVBSnJQTkVnQ2xDckx0NTRp?=
 =?utf-8?B?Nys2NzlDMm11R1BkVEFYcmJVK0YrY2drcUtqNGlySFFZamM5ckJRb1FobUd6?=
 =?utf-8?B?dXB4dG4rVENoUDJ3Z3NKMlhESDlXV2tYVHplK3YwNkNkR0xTN3FSVGJVTERW?=
 =?utf-8?B?Nk4xN1E2aURHb1lVaUJQRzQ3cW56Qlk1aFUveUtDazBUaThpMjV3SDdNUi9x?=
 =?utf-8?B?bkQ5d1FqQXY4Ui9XekZpb0hqSU9HWmtKbnVORVAxV2NTU2ZIQktEQk1ZRzRL?=
 =?utf-8?B?ZTBuTDRsUXROMDI3WndEZzNhR0tJVXVVQkdkc2M3UHE1RkZDaVVzN2hmd0hn?=
 =?utf-8?Q?HLd5rQci64fZdun7nZ3Ok5s26?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3065.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9a7baa-c379-4c52-109a-08db20698e85
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 06:43:13.7172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VQOq/Rzgh48xOPs7VQ3oB6KoMC7t6q4mxaW/AruTU4Mqu5qLfOjxNsWM5IPflNUFOsejSBXKzl83cg84IjZD3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7367
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDI0LCAyMDIz
IDU6MDEgUE0NCj4gVG86IEEsIFJhc2htaSA8cmFzaG1pLmFAaW50ZWwuY29tPjsgdWxmLmhhbnNz
b25AbGluYXJvLm9yZzsNCj4gbWljaGFsLnNpbWVrQHhpbGlueC5jb207IGxpbnV4LW1tY0B2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IHJv
YmgrZHRAa2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtpc2hvbkB0aS5jb207IHZrb3VsQGtlcm5lbC5vcmc7DQo+
IGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbTsgbGludXgtcGh5QGxpc3RzLmluZnJh
ZGVhZC5vcmc7DQo+IG1ncm9zc0BsaW51eC5pbnRlbC5jb20NCj4gQ2M6IGtyaXMucGFuQGxpbnV4
LmludGVsLmNvbTsgSHVudGVyLCBBZHJpYW4gPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsNCj4g
VmFpZHlhLCBNYWhlc2ggUiA8bWFoZXNoLnIudmFpZHlhQGludGVsLmNvbT47IFNyaWthbmRhbiwg
TmFuZGhpbmkNCj4gPG5hbmRoaW5pLnNyaWthbmRhbkBpbnRlbC5jb20+OyBJdGhhLCBWYXNhdmkg
ViA8dmFzYXZpLnYuaXRoYUBpbnRlbC5jb20+Ow0KPiBEZW1ha2thbmF2YXIsIEtlbmNoYXBwYSA8
a2VuY2hhcHBhLmRlbWFra2FuYXZhckBpbnRlbC5jb20+OyBaaG91LA0KPiBGdXJvbmcgPGZ1cm9u
Zy56aG91QGludGVsLmNvbT47IFNhbmdhbm5hdmFyLCBNYWxsaWthcmp1bmFwcGENCj4gPG1hbGxp
a2FyanVuYXBwYS5zYW5nYW5uYXZhckBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djEgMi80XSBSZXZlcnQgImR0LWJpbmRpbmdzOiBtbWM6IEFkZCBiaW5kaW5ncyBmb3IgSW50ZWwN
Cj4gVGh1bmRlciBCYXkgU29DIg0KPiANCj4gT24gMjQvMDEvMjAyMyAwNjo0NCwgcmFzaG1pLmFA
aW50ZWwuY29tIHdyb3RlOg0KPiA+IEZyb206ICJBLCBSYXNobWkiIDxyYXNobWkuYUBpbnRlbC5j
b20+DQo+ID4NCj4gPiBUaGlzIHJldmVydHMgY29tbWl0IGFiOTkxYzA1YzQyODUzZjBiNjExMDAy
MmRiOWJmMzBmY2M2MzIzZGQuDQo+IA0KPiBQbGVhc2UgdXNlIHNjcmlwdHMvZ2V0X21haW50YWlu
ZXJzLnBsIHRvIGdldCBhIGxpc3Qgb2YgbmVjZXNzYXJ5IHBlb3BsZSBhbmQgbGlzdHMNCj4gdG8g
Q0MuICBJdCBtaWdodCBoYXBwZW4sIHRoYXQgY29tbWFuZCB3aGVuIHJ1biBvbiBhbiBvbGRlciBr
ZXJuZWwsIGdpdmVzIHlvdQ0KPiBvdXRkYXRlZCBlbnRyaWVzLiAgVGhlcmVmb3JlIHBsZWFzZSBi
ZSBzdXJlIHlvdSBiYXNlIHlvdXIgcGF0Y2hlcyBvbiByZWNlbnQNCj4gTGludXgga2VybmVsLg0K
QWNrbm93bGVkZ2VkDQoNCj4gDQo+ID4NCj4gPiBSZXZlcnQgVGh1bmRlciBCYXkgc3BlY2lmaWMg
Y29kZSBhcyB0aGUgcHJvZHVjdCBnb3QgY2FuY2VsbGVkIGFuZA0KPiA+IHRoZXJlIGFyZSBubyBl
bmQgY3VzdG9tZXJzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQSwgUmFzaG1pIDxyYXNobWku
YUBpbnRlbC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEh1bnRlciwgQWRyaWFuIDxhZHJpYW4uaHVu
dGVyQGludGVsLmNvbT53cQ0KPiANCj4gU3RyYXkgY2hhcmFjdGVycy4NCkFja25vd2xlZGdlZA0K
DQo+IA0KPiA+IC0tLQ0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvYXJhc2FuLHNk
aGNpLnlhbWwgfCAyNQ0KPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDI1IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvYXJhc2FuLHNkaGNpLnlhbWwNCj4gPiBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvYXJhc2FuLHNkaGNpLnlhbWwNCj4gPiBpbmRl
eCA0MDUzZGU3NThkYjYuLjBkNWQyMWRkMzBiYiAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL2FyYXNhbixzZGhjaS55YW1sDQo+ID4gKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9hcmFzYW4sc2RoY2kueWFtbA0K
PiA+IEBAIC04OCwxMiArODgsNiBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgICAgIGRlc2NyaXB0
aW9uOg0KPiA+ICAgICAgICAgICAgRm9yIHRoaXMgZGV2aWNlIGl0IGlzIHN0cm9uZ2x5IHN1Z2dl
c3RlZCB0byBpbmNsdWRlDQo+ID4gICAgICAgICAgICBhcmFzYW4sc29jLWN0bC1zeXNjb24uDQo+
ID4gLSAgICAgIC0gaXRlbXM6DQo+ID4gLSAgICAgICAgICAtIGNvbnN0OiBpbnRlbCx0aHVuZGVy
YmF5LXNkaGNpLTUuMSAgICMgSW50ZWwgVGh1bmRlciBCYXkgZU1NQyBQSFkNCj4gPiAtICAgICAg
ICAgIC0gY29uc3Q6IGFyYXNhbixzZGhjaS01LjENCj4gDQo+IEluc3RlYWQgc2hvdWxkIGJlIG1h
ZGUgcmF0aGVyIGRlcHJlY2F0ZWQsIHVubGVzcyB5b3UgYXJlIHN1cmUgdGhlcmUgaXMgbm8gc2lu
Z2xlDQo+IHBlcnNvbiBpbiB0aGUgd29ybGQgdXNpbmcgdGhlIGJpbmRpbmdzIChlLmcuIHdpdGgg
QlNEIG9yIGJvb3Rsb2FkZXIpPw0KTWF5IEkga25vdyB3aGF0IGhhcyB0byBiZSBkb25lIGluIG9y
ZGVyIHRvIGRlcHJlY2F0ZSB0aGUgY29tcGxldGUgcGF0Y2hzZXQ/DQpXZSBoYXZlIGEgcHJvcG9z
YWwgdG8gY2x1YiB0b2dldGhlciB0aGUgMiBkcml2ZXIgcGF0Y2hlcyBhbmQgMiBkdCBiaW5kaW5n
IHBhdGNoZXMgYW5kIHNlbmQgb3V0IG5ldyBwYXRjaHNldCBjb250YWluaW5nIG9ubHkgMiByZXZl
cnQgcGF0Y2hlcy4NClBhdGNoIDEgLSByZXZlcnQgZHQtYmluZGluZ3MgcGF0Y2gNCiBSZXZlcnQg
ImR0LWJpbmRpbmdzOiBtbWM6IEFkZCBiaW5kaW5ncyBmb3IgSW50ZWwgVGh1bmRlciBCYXkgU29D
IiAmIFJldmVydCAiZHQtYmluZGluZ3M6IHBoeTogaW50ZWw6IEFkZCBUaHVuZGVyIEJheSBlTU1D
IFBIWSBiaW5kaW5ncyINClBhdGNoIDIgLSByZXZlcnQgZHJpdmVyIHBhdGNoDQoiUmV2ZXJ0IG1t
Yzogc2RoY2ktb2YtYXJhc2FuOiBBZGQgaW50ZWwgVGh1bmRlciBCYXkgU09DIHN1cHBvcnQgdG8g
dGhlIGFyYXNhbiBlTU1DIGRyaXZlciIgJiAiUmV2ZXJ0IHBoeTogaW50ZWw6IEFkZCBUaHVuZGVy
IEJheSBlTU1DIFBIWSBzdXBwb3J0Ig0KDQo+IA0KPiANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4g
S3J6eXN6dG9mDQoNCg0KLVJlZ2FyZHMNClJhc2htaQ0K
