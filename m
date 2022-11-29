Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F5463B8F2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 04:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbiK2D72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 22:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbiK2D7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 22:59:25 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7038F4A9EC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 19:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669694364; x=1701230364;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eA+XSLPR+mt/J+axBYYOlV06T17TOI/zi+cnIAh6n+g=;
  b=hQapL/EIQTBdSIKdG35yT6ZS+hzg/eRIRF1pes96VLTGno3Dp1Icd3+v
   HtTpF2LnMxbrZL6IS3zFlpz4wvVXIiFxcXucDSOKaLtMavI00T9PA5RRH
   PGzBwMAXvYUMMYz7A7c+JOvkvrT5GjuWog4ZS+0hn9kBcmAz2WLz9/Ib+
   e3iHmE1S05bMTTCPdmJqWhw5EWzQWAQxDBxrl/N/Fe6+CC17I2LYSjt2f
   IKrFTiTIW+B+ZaE1VkAsDYO/Hk1s2HMFtL44Zrr+UIQESkg+ml7s2SHr7
   hPlvv4Elak3EmzFrj9wUKPZjOzLCbfSouBX9dOxbEES5UtBBTRfs85nrv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="294707109"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="294707109"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 19:59:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="785891532"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="785891532"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 28 Nov 2022 19:59:23 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 19:59:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 19:59:21 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 28 Nov 2022 19:59:21 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 28 Nov 2022 19:59:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUiRL1ETkIENXKOt7bR89ZkM4tylR8MtpRjanMP1JrK0zeB4xuQSmPy8u+S9mhsee1Sc7awE2kOwiw1ubfo8BwPlMomWuYClO5W645ri7nzC/jrQ6CCpSeZIKVUVmd4SFKzQNuJbCpNE35KEI5v6CJJ72PL9jjLJ8AU2+/SvDxCorUdN//jqQ3uj+0fSmtb8dHt8bOHKoMwzK11uSrJLvjHJ1AE7gaQQrqUFuALu2WFRzo950TZMXcW4BA4H5Cc6xWdSB9sfNh2RMUvMrJCMnMxreP/R+0KCwb5kfWP5itLdP7iFxR+Btqi9O5G62bpkZn/1s7nQUICEvUgO8zbo7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eA+XSLPR+mt/J+axBYYOlV06T17TOI/zi+cnIAh6n+g=;
 b=oR1VozxwhWKaQyN5zsSQD2yFOyph8lvI3j+1cNpCOx5UgTak6a4H9OrPKVpM+ZGkgywuHJPx/c75WUvFVppEH7hCqFgwT2hz4o/LgdzxyZG9ZsFk4+qD20GmJcD8yaDD9b2DzbZag02l3tPh4+kRFc94TgnwZ1N863+WSRBVCmDviTGEcAiT/vQyehiLRi18AAvD0bHHnnRMbdbruBF9+NNk8jcrlMY9b3NClPw0kK03SuVZhNwccUpoZnNR4HJON5U9bkKRQeeQi0iUc/sUAAgHCqj+Od4GsbPIcA6vRobE65TB6fh/r7Kmrg0dlbGZAqnZ4ypB/ZONhGQWGEMXtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by SA1PR11MB5828.namprd11.prod.outlook.com (2603:10b6:806:237::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 03:59:19 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::7a7f:9d68:b0ec:1d04]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::7a7f:9d68:b0ec:1d04%9]) with mapi id 15.20.5857.021; Tue, 29 Nov 2022
 03:59:18 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Rob Clark <robdclark@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "Matthew Rosato" <mjrosato@linux.ibm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        "Baolin Wang" <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 20/20] iommu: Rename attach_dev to set_dev
Thread-Topic: [PATCH v3 20/20] iommu: Rename attach_dev to set_dev
Thread-Index: AQHZAvaNACkX9hY5W0Kk8eAOnvJxz65UWG8AgAAWFoCAAA6igIAAyTSQ
Date:   Tue, 29 Nov 2022 03:59:18 +0000
Message-ID: <BL1PR11MB5271AAA520B755C0E755105B8C129@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
 <20221128064648.1934720-21-baolu.lu@linux.intel.com>
 <01296f25-b507-c965-9840-119487a00534@arm.com> <Y4TNK9J8NijPbOVZ@nvidia.com>
 <8a46bb18-4cc4-dd08-1f06-399d3c875ad8@arm.com>
In-Reply-To: <8a46bb18-4cc4-dd08-1f06-399d3c875ad8@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|SA1PR11MB5828:EE_
x-ms-office365-filtering-correlation-id: 77677bdd-fba3-492b-dea1-08dad1be16e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: witgAXBxZcSTM7fhcWF4jydQkpG6ojj7yYeizBZqDKB8hkt+K1nbqAWpex973BAvzt7kqrUB+1OcUibvhUxMvUAm9EdSYEtnqQmbUqnOj/ltdfNfMf4OGeRHqRfq/fX25u6lGpu2X1a8ZOwyraTSortyP0D57cwnA3yOTZkyKxKTbvjY/qVLUKLcJAwOjl4T9k70SWZrqiYhg/oHO/xvCaeFgi0hlmm3wmZCo87ddDhxZYsXtCM+g6OAqYrJSWRiuFUW4zKcGkdW2KmL/eoO0eExGqdmbHPySgkJdbwaKyZWp0uzwpovSx7m6qekKQWLo9S+/zSXHPey0/coadabSAr5SITmbALex4scdmX9CEZCCc/njIl4VwaI7/qCMTj0sxVQj3IBjOVTghSFdcTWx/89mucWTXlnTzzpoBJN5xLPUPinfyQUGvbQqJgDZx6+JCXPK1fCXpWOhagyOTTmDe9yGsrtdzLmWecWy/w18MToIqD7OGtYS0/qVXRJncq1COx1B0dcX4hhvQM1qJAx554WHcD4JG3hHOlxSHTutGhv549lv+7ugM5L+ZZDH2pGDE/o8KX8lKdyC0+SJTfw1nH5GQ2nnOq92DKs1w/W9GmtPcic6+TGvxBO+I7VxNYzAgvB6ULCUTCEBrUEw8ypK9mnTa5oR+g4dLZ/XmXFJbEgxpm0RBdLovY2KZHWjq9/eERpCkgpHv2yMoYEvc1Kog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199015)(53546011)(7696005)(6506007)(8936002)(186003)(52536014)(86362001)(64756008)(66946007)(41300700001)(76116006)(66556008)(66446008)(66476007)(4326008)(8676002)(110136005)(54906003)(83380400001)(2906002)(4001150100001)(7416002)(33656002)(55016003)(9686003)(5660300002)(316002)(82960400001)(26005)(478600001)(38100700002)(38070700005)(122000001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2xLTklaOE4zN3JOSjQ4RlhiUXM1VloyMFhJT2xaQTBxd1FwSTBmTUtXbjlt?=
 =?utf-8?B?cDN6cytaYkdUSEhYMVBCT1RWcE9CL1ZkT3pNeWcrdXNQNlAzbXBKY1prMjl3?=
 =?utf-8?B?cHhuN2llOHQyeDZlOWR0KzdBRDVDcWJBRndzY0xxU0dnM0J0ZTFpUFhYMlhp?=
 =?utf-8?B?Tm9uSXBzcGREM2NWMjhJR3VUd1BCQnpSV3BFcmhpR0xNVE1jTXNRL3BGL21h?=
 =?utf-8?B?NVRhN2lDVjRoTFJNd2Vla0E3a3ZHQUdzQkgrMzhDOHhRWWYwMnFqQ2VEYmQ1?=
 =?utf-8?B?OVp1QitBdSs2Q2Q0cHdiNENaR2l2OEttTXNYVUlha0xaOFF3QkpqK3N5Vm4z?=
 =?utf-8?B?U2FHWjg0VkdIY3RhSUQzbVpEYmZjenFCa1V5dUNldzhpK0xXTmlWV0xLbWhH?=
 =?utf-8?B?ZnBlSHBMK1ZURFRIT05DTjlGWHNtZ1I4U000djE3ci91cEMzeWgxSXRiNUZZ?=
 =?utf-8?B?WVd2bVN1d3d2MEQ3dk1VWXk4UHNyRmNxd2VGcmdNRi9oNlJ3U0c1SkNJZ0pT?=
 =?utf-8?B?UmF1VkQzUmdSYkZ1WmpiZ0tEMFVBUVVZNTVONUgyem9Mb2FlTjRTbmtkcEVZ?=
 =?utf-8?B?Y2FnSUhUNU83WGtReGV5UU81M1lzRVBoaUxuWWNoZjRUeXlkRldXQm56aTBH?=
 =?utf-8?B?OVppK2xzR0lKemF0YSs0OTVBWU9wQ3AzSXVua3ozZEtyZXpWVDhGbjFqczg1?=
 =?utf-8?B?SlpsRUR5aTBIVmhVbURTR2FodndJcHJjLzUvREhvNjBtNjg5VmlHaExaMGky?=
 =?utf-8?B?L3pkLzgraWw5NFFyR251WHdKa1d2S1gwajBTdmUwckJXaVVsdWRWanFtbjZt?=
 =?utf-8?B?MU5VTkpPL2NldmZoSExrdEs1UUdaMnpGeE43Q0hCQ2ZZQ3NVSTJBclRoOUlh?=
 =?utf-8?B?clJDVFVta2pCVExsbUVGTFJ6aUI3THRUN1hKZGJBTW92UWxCU0lYZVlXc2Er?=
 =?utf-8?B?c2NueUxzem02UGRQMEZOU2NzczQ0VVFpZmRlUHNMMW5iVEVYZGhrVi91dUpL?=
 =?utf-8?B?a001b3Fwc2ZlZ2crTW1Cd0ozRi9OdE14KytCNUVQRlpSeWNDTFZFci9EU1hv?=
 =?utf-8?B?OU5lM0wvL2tDaDVzWXpUVDdHdEV6UHpOakhTajNlYmtlNUo1Sk5oa0tFZHBG?=
 =?utf-8?B?Q25KSGJwblVaWmdMMjFGekF2UnpTdnFNYlZYWHhadTFuS3cvK1R2ZFBmVXM5?=
 =?utf-8?B?NWVqR08yZUhGRENUUVo2MGhZZExwVmhLdFFoYmVXVFlTSWx0Q3FSb21ueW54?=
 =?utf-8?B?blZaUmQ1L1hZYklzL25OSmRaK2JhR0N4T2NnR29tMFJhSFk1aVpuakFNdHhG?=
 =?utf-8?B?b1ZRNDYwbXorekwvbm1zNnFBZ1ozOHlKMW1XaSswaWg4TnptZy9HeEVKQ3hz?=
 =?utf-8?B?NHJhOG5CbTBUL043Si9kL0FmYXBEeXd6K0dYclh2aXZFTWRVOEhJODFhNEp3?=
 =?utf-8?B?RUlSRDBCenRtcG0rR2xOV3pCZFFsczNIbXRDakxQKzlPeTBuSVNMOTVSQ0p4?=
 =?utf-8?B?NHkzU0ROdUFyY2JpSVdObHUzRVplKzdhVTZLdWxuaUxBQTg1V1ZFQjJZYjht?=
 =?utf-8?B?RGFkSXFCL0lESVlaa1dVNFJyZlU0THEyZ1RSR25mV0pIekFBQm8vNGlTdUJx?=
 =?utf-8?B?cVJobXdrNHNHRDNxdnFJaXhlOXEzRTQ0bytqU1FFbFFOWlg0cGF1dzVqeGs0?=
 =?utf-8?B?VCtXa2ZjUkhKVkkyWEl5NDhGSHhvdnNxdlJlMXJCQzRQcVR2ZlNNaVNVTDQ4?=
 =?utf-8?B?U2RIL1h5dFFRYXZEb01TdkZoZ0VCdExjZW1GZnEvd0RNZWwzRUpMU2VWWHB3?=
 =?utf-8?B?WVlxT3pVLzkvckFRNU5tR1RzZEs4b2l2OTZyL3VyT0VteU5nNUFyRWN0TWph?=
 =?utf-8?B?dFdmVTZnL1JBYVR0NStZekUzUTc0czVJNzNUbTN6NGFucG9zbkJpS1RkNXcr?=
 =?utf-8?B?QmU2dTcxQ2hQR29RWVdGSWM4cFJ6bEEweXhvTDhVemNKUFcrUlh0d080ay9x?=
 =?utf-8?B?OVJXNDRrY0ZKbzJTcVZlRGV1QkdYY0Q4UVFUZ1ZyRDJ4SWVkZGY1THhYd3JN?=
 =?utf-8?B?UENKRFNTTFJPWXN6QWlXbmdWdVBVK24wZkZwcDRzVnZhSUFwQUFkeWtaSFJF?=
 =?utf-8?Q?9G7bPVtRQ3ryEOp7nQD2Je3Ma?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77677bdd-fba3-492b-dea1-08dad1be16e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 03:59:18.4451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EgznH9GyepFJnUmttAi4qTRBwj8GfRO7FuXXEk87km5vqxfesRWyBzY2k19nMkoDeGzCEGMo0rA0cSIXBWG8dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5828
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0KPiBTZW50OiBNb25k
YXksIE5vdmVtYmVyIDI4LCAyMDIyIDExOjUzIFBNDQo+IA0KPiBPbiAyMDIyLTExLTI4IDE1OjAw
LCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4gT24gTW9uLCBOb3YgMjgsIDIwMjIgYXQgMDE6
NDE6NTZQTSArMDAwMCwgUm9iaW4gTXVycGh5IHdyb3RlOg0KPiA+PiBPbiAyMDIyLTExLTI4IDA2
OjQ2LCBMdSBCYW9sdSB3cm90ZToNCj4gPj4+IFdpdGggdGhlIHJldGlyZW1lbnQgb2YgdGhlIGRl
dGFjaF9kZXYgY2FsbGJhY2ssIHRoZSBuYW1pbmcgb2YNCj4gYXR0YWNoX2Rldg0KPiA+Pj4gaXNu
J3QgbWVhbmluZ2Z1bCBhbnltb3JlLiBSZW5hbWUgaXQgdG8gc2V0X2RldiB0byByZXN0b3JlIGl0
cyByZWFsDQo+ID4+PiBtZWFuaW5nLCB0aGF0IGlzLCBzZXR0aW5nIGFuIGlvbW11IGRvbWFpbiB0
byBhIGRldmljZS4NCj4gPj4NCj4gPj4gRW5nbGlzaCBncmFtbWFyIGFsZXJ0OiB0aGlzIHBhcnQg
aXMgY29uZnVzaW5nLCBzaW5jZSB0aGUgdXN1YWwgaW4tY29udGV4dA0KPiA+PiByZWFkaW5nKiBv
ZiAic2V0W3RpbmddIFggdG8gWSIgaXMgZ29pbmcgdG8gaW1wbHkgYXNzaWduaW5nIGEgdmFsdWUg
b2YgWSB0bw0KPiA+PiBzb21lIHVuaXF1ZSBwcm9wZXJ0eSBvZiBYLiBHaXZlbiB0aGUgYWN0dWFs
IHNlbWFudGljIHRoYXQgd2hlbiB3ZQ0KPiBhdHRhY2ggdGhlDQo+ID4+IGRldmljZSB0byB0aGUg
ZG9tYWluLCB3ZSBhcmUgc2V0dGluZyB0aGUgKGN1cnJlbnQpIGRvbWFpbiBhcyBhIHByb3BlcnR5
IG9mDQo+ID4+IHRoZSBkZXZpY2UsIEkgdGhpbmsgdGhlIG1vc3QgbG9naWNhbCBhbmQgaW50dWl0
aXZlIGFiYnJldmlhdGlvbiBmb3IgdGhpcw0KPiA+PiBtZXRob2Qgd291bGQgYmUgc2V0X2RvbWFp
bigpLCB3aGVyZSB0aGUgdGFyZ2V0IGRldmljZSBpcyB0aGVuIGNsZWFybHkNCj4gPj4gaW1wbGll
ZCBieSB0aGUgYXJndW1lbnQgKGFzIHRoZSB0YXJnZXQgZG9tYWluIHdhcyBmb3IgYXR0YWNoX2Rl
digpKS4NCj4gPg0KPiA+IFRoaXMgaXMgdGhlIGlvbW11X2RvbWFpbl9vcHMsIGl0IHNlZW1zIGEg
Yml0IHdlaXJkIHRvIGNhbGwgaXQNCj4gPiBzZXRfZG9tYWluIHdoZW4gaXQgaXMgYWxyZWFkeSBh
Y3Rpbmcgb24gYSBkb21haW4gb2JqZWN0Lg0KPiA+DQo+ID4gc2V0X2RldmljZV9kb21haW4oKQ0K
PiA+DQo+ID4gPw0KPiANCj4gQWgsIHRoZSBpb21tdV9kb21haW5fb3BzIHNwbGl0IGhhZCBjb21w
bGV0ZWx5IHNsaXBwZWQgbXkgbWluZCAtIG1heWJlDQo+IHdpdGggdGhhdCBhZGRpdGlvbmFsIGNv
bnRleHQsIGFzc2lnbl9kZXYoKSBtaWdodCB3b3JrIHdlbGwgZW5vdWdoIHRvDQo+IG1haW50YWlu
IHRoZSBwYXR0ZXJuIHdoaWxlIHN0aWxsIGJlaW5nIHN1ZmZpY2llbnRseSBkaWZmZXJlbnQ/DQo+
IA0KPiBPdGhlcndpc2UsIHNldF9kZXZpY2VfZG9tYWluKCkgKG9yIGp1c3Qgc2V0X2Rldl9kb21h
aW4oKSkgc291bmRzIGZhaXIgdG8NCj4gbWUuDQo+IA0KDQpUaGlzIGtpbmQgb2YgaW50cm9kdWNl
cyBhIG5ldyBjb25jZXB0IGFzICdkZXZpY2UgZG9tYWluJy4uLg0KDQpJIHByZWZlciB0byBkZXZp
Y2Vfc2V0X2RvbWFpbigpIHNpbWlsYXIgdG8gX19pb21tdV9ncm91cF9zZXRfZG9tYWluKCkuDQoN
ClRoZW4gc2V0X3BsYXRmb3JtX2RtYSgpIGNhbiBiZSBkZXZpY2Vfc2V0X3BsYXRmb3JtX2RtYSgp
Lg0KDQpCb3RoIGhhdmUgJ2RldmljZScgYXMgdGhlIHN1YmplY3QgdG8gZGlmZmVyZW50aWF0ZSBm
cm9tIG90aGVyIGRvbWFpbiBvcHMuDQo=
