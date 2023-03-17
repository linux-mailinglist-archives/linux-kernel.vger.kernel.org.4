Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3681D6BE0C3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 06:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjCQFtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 01:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCQFtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 01:49:43 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091F91ADE1;
        Thu, 16 Mar 2023 22:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679032181; x=1710568181;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sEUixxQh5M7FllqkaXFOz7oYhzzN7EJGtXFSyM2e75c=;
  b=JvrBMClujrujeAlI28y0EWMskSTL94GE+HtmG/eJr+J0Xj6qd882Q9fG
   rjQl72AaNrXKrFu9USq3q/XcKnU8swVYPpMGsPyh5wo+l/m3PBbJtqve6
   LCCOoMkdYotgnmrVvagMrinbllN7pMKxiCpPQsOPhO+waFvCdiW7dYkbn
   MirqwYyxpfuXbpyBbqMLGC8G0W4xyfBqmjJLO1dPcsNI0moknPQdiDzMP
   nAj39vFMM5HkS3v1NRCcIRrZkcsYquX6aqAS0iL5KQ5KxO4wughYYeNnT
   B1mVdTGPNibOs0mCTLM+VtOLvkw3cDQ8+2ZdYa6tJMA7XLcchebYnJ7+9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="317843552"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="317843552"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 22:49:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="1009514419"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="1009514419"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 16 Mar 2023 22:49:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 22:49:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 22:49:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 22:49:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 22:49:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dw4C1gh4h2IRBGJVh1q1rCzXRjyxazCswhqMe0ThlQIcUEREoGxeuAO+TMJTngY+IY2S57XF4zxgrhqFlCPgcJNubZnPasbCqmXE4IUzsTJn5KQRDMPvJy4sNM6WHSxl9kOTw7nlnvSzMrdfG+qh6vn+wLFKZccfiWqR35W47D2c9R1N8uHMZ1FrbP0F3bLRAOyAeJlEjiA+unQmhvrW5FAnTl7Qnl97LUf6hka3sRlIfuAICbyNU4qziK0+1rnCSovtnxMtOPW8qW/II5Mk0LNyQVQVXOD5SdbbDxm8wM9kyesz22ovHQ9OigiHZLFp8lAM6vkhEgXdjb5fc4JLnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEUixxQh5M7FllqkaXFOz7oYhzzN7EJGtXFSyM2e75c=;
 b=GFTcpsyXlXA6JUnqv/yp+IMpgcZSqw9CnZ5Mng90WqDwhW8/ri/qgEOHWkvlurOGyBveMUsm3muIgkcdbb8MlcVlR+kygvL6pyzFO+z/n8olikz94b+6z+vQOzdfshC8yvCoKv+vskhAf292f4Z2VXMot9jgAXSMc1NyqhBo4zstwTtDRM3Djh+xv+IHolwlS78Y05vc1sNw7ey4I6lLPZnAxXZdnNCcvHVld1VuaOQlluOYuq4iP89wJz+8DXVfYv4WgcjO0aRm2baPx4DhnyXfbxToBRxrRJ6uPy6MIxrmq4yke4Z8rgvZtMR2tgJAydT7k4++JClWeFsogFa8Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2618.namprd11.prod.outlook.com (2603:10b6:5:c0::30) by
 PH8PR11MB6658.namprd11.prod.outlook.com (2603:10b6:510:1c1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 05:49:35 +0000
Received: from DM6PR11MB2618.namprd11.prod.outlook.com
 ([fe80::85cc:49ad:f49d:ea7c]) by DM6PR11MB2618.namprd11.prod.outlook.com
 ([fe80::85cc:49ad:f49d:ea7c%5]) with mapi id 15.20.6178.024; Fri, 17 Mar 2023
 05:49:35 +0000
From:   "Xu, Even" <even.xu@intel.com>
To:     "todd.e.brandt@linux.intel.com" <todd.e.brandt@linux.intel.com>,
        "Philipp Jungkamp" <p.jungkamp@gmx.net>,
        srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        "Brandt, Todd E" <todd.e.brandt@intel.com>
Subject: RE: BUG: hid-sensor-ids code includes binary data in device name
Thread-Topic: BUG: hid-sensor-ids code includes binary data in device name
Thread-Index: AQHZUzXwgfGO1WCFDU+JrWsC/WBLDa70FL4AgACW9ICACdTz8A==
Date:   Fri, 17 Mar 2023 05:49:34 +0000
Message-ID: <DM6PR11MB2618B71FCDD70813404F570FF4BD9@DM6PR11MB2618.namprd11.prod.outlook.com>
References: <592bcdcbb3603cf5dfefd09abdd6916db4efc691.camel@linux.intel.com>
         <317ce138f63b9317ac7be1949a68db5117c19b92.camel@linux.intel.com>
         <424882ed2a79a641f88b5f2d1ed5a5d3d4fe98d9.camel@gmx.net>
 <fe7b41aa975128bd44d351911b0faa17b837033c.camel@linux.intel.com>
In-Reply-To: <fe7b41aa975128bd44d351911b0faa17b837033c.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2618:EE_|PH8PR11MB6658:EE_
x-ms-office365-filtering-correlation-id: 003a6b55-537b-4f26-966f-08db26ab6330
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fTCGYJSumWFPzF93tf0sXAudb6sTQzTYt24dGgRzAoeRzrUgEvsjwvnRNaNRb3sG5HxGb7GB5sqi0GfjvcyZUn6LolVfHSmpgSWMVGpJYaWLjSy2BB3TngZ1eLI/MnqDDBCdZ+h8jxqh4imyFXQXg35MSoTuduWkKRBqwXgOamLwKssFTT4HvsvccziuFoUwEJh5Z1gW9vtgR5oM0VEQl0+HeMMswRGEFuCsv8/cqL+0dTnoSGsfTRnZEisaS1hCNHqH+A04REE2rRFkhXjEMq+Nyjn2EUOSaSPsT951e0iIZix7g0Xf6hVjAooJhQ/yf3tmyv/NGLUG0TpKAgtKERF616/FZ2fMKLFkNN4tzXyHltn7srixroCGDfDWxsv32Pg4weOyDnLoDTlT5aDuaxCVAK1vrUY9CbKk+bngTT8khfpdWXqaLrwlswiEFgMIx1mVET4kAgqPeCYtI0LoTuc9TaAy1LqZmcLhTjyhyKPOo3+/wbMhbFBvMZLT5T8alEEolsJ65+yxvll3/KX3QLb6ugmmoehhku36oKMOOy5OZsCSUPo30ZEdemoiOqTpRTiYJLu0s//3PYcbMiSrO9PzdOiYKlOXRWICc7dmpL7b84WXt67jlG6s67WoLpoE7SHoPGUFjMwxpXg/emBllrrYqSNFRpZfjKryTFHDa3TlAavDJGAtT2grZhtW6ekY3cE5ka6XZMrne3KHLa4XaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199018)(7696005)(55016003)(82960400001)(71200400001)(9686003)(53546011)(6506007)(186003)(26005)(83380400001)(5660300002)(86362001)(8936002)(41300700001)(52536014)(33656002)(2906002)(122000001)(110136005)(54906003)(478600001)(38100700002)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(316002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVZSem02azZpU29ZOU1ZOEUxWlZKZlBoWlVKcEMyOG4yMG1HRU42OGNJQ3pK?=
 =?utf-8?B?Z3ZPTDdKNTVQYzJPY0w4V0x1ZGp3OU15ak1qYS9sRVR4eUg1QUllZ1c4cytQ?=
 =?utf-8?B?SGJBTG41R2ZTT1cxZ2t5WkN4KzdpWXZoSVFxcldqb29PbFFCdjJ0Y2VJa3Qr?=
 =?utf-8?B?c3pPMXg5UWNUZzZ5U1FIWU1WdGc2clNoWFlnL2RzNGpIZ1ZYeS9rZWhEMzZv?=
 =?utf-8?B?WDErNFp4ck9MaTVVR1p6OW90bmUwakw1WFBBS3VEbHFwdzVsL0JqOU02Wlpu?=
 =?utf-8?B?OXNGNm1CYmM0dklaWjZSRHpoMURObThGcUtISDJrUFBqOUhtMVZZM0dEUG1C?=
 =?utf-8?B?UXdXQW1Yc2k3c2I5dzlha2ZZNUx3NFJ1em1rNGtDY2tGNmZEczhhRHFONDdv?=
 =?utf-8?B?L2M1NkJpZVVzR1RGZ05SUjYzTDg5UHJXVWphbVBmY2FjT0RBTElIaWxIODBw?=
 =?utf-8?B?MzFJaXZJK1FmcHFvOXp2Mnpsa0Z5TU94a2gxaDViZnEzWUZnYkZDbFJYWFJM?=
 =?utf-8?B?MVp3MUhYNlJsaHd6WEtLNTNSUDNOck13MERuOEVKMXNaNHgyeVQzb2RaMGVF?=
 =?utf-8?B?OUxjYURDSFJwakJyZW45MmU2YWtMbHliNW1td0pOdFpMZzU0TFdoT1RhcURv?=
 =?utf-8?B?MTZIZ2U5UzBkRXBxWmJpc2s3bFBhTnE4T1hCTUIyNUx0T1g3UGczZjNhcEFY?=
 =?utf-8?B?aTdPelFPK1N1RkJZN2M3UzIwbWNYQXBWc0V2UzRqM2d5bXVKdk0zWEZYRXNX?=
 =?utf-8?B?RzgwMlpycmNRbHM0Y3RrV3FlVTVEblpyWVpjb29rRi8waXQrdjZwM2NIbjlq?=
 =?utf-8?B?SDZwQzVvbUtVbnEzR0Jwa05EZFlTdmVqZG5EeFgwS0pZNStBQ0tSRytJYndm?=
 =?utf-8?B?TDZ6L1pFL1RTaEozakJCekMrRzVVRW5VV29wRUFJcksyRXdXRlNFc2JEMmdS?=
 =?utf-8?B?SllDeGZKaFpla2NVR0JhY3E1Qit3Tkg4WlVEdVdHbXFFM2c0Qnk3eUYwUGFn?=
 =?utf-8?B?UmJBam1HUk5EUmdVdDBaVzNSMUNXSlUwYjFwejFwaVZFWEFBNmQ1bmtDblpy?=
 =?utf-8?B?d3Z3SFFaL0ZYK1FhR0xFLy9XWGk3dEtIaDN4N2F2TksxUEhNSU52OVR5VU84?=
 =?utf-8?B?V2F3T0ppdFEralNYWjV6VmhyUk12UG1la0NoZm4xWUU1d0FuOVhGSHkxcUpN?=
 =?utf-8?B?VUJOMzNPbE9lelVyVEQ3WUhhVU1zYis5S3BVNmN4SXRHRS9pVXhVaUZCVVRy?=
 =?utf-8?B?STduaThETnorQUtoeFlwQnNwSHVWZ2g2bDZyTWMzeGExZUFpQ3hDSTFDNHND?=
 =?utf-8?B?QkgyM3M0SzNmeTcrRHBub0ZpSXk2UlA1ZTNqc2F2T0N6UGlqVHZrbGVaSmlG?=
 =?utf-8?B?VTVnaFBWM3R4a003Ti9CZTRxVE0zU0ZDUDl2cEhseEp3N0dqMUxUMFFDWW85?=
 =?utf-8?B?RHhZMVZDLzVwOU1NV3llTVJHNkttWmZzV1Ezc1pOUDl4bzROZGVOS0lDUnlh?=
 =?utf-8?B?aDk1U3VCMVc0NTVpM0F6WDc1UlI4c3lLYXF3Uyt4VFhEbldNZXVKVkIvdFMr?=
 =?utf-8?B?NEFEOWFFN1U4Z1djSlRPVjAvS3FHamo3Tm1UUjEwbWtBK05vUEhYaTdBR3dO?=
 =?utf-8?B?YW5aZXhTREJRZXZjN0kxcHBjMlNRVHZEc3lzZVJZTm02YzRJT0JwTEwxVGNu?=
 =?utf-8?B?NUJjclU4VkJzTlFueTBUMWRLRGNrL2ZqVk1HVGFaaGlEcjZmRzJqRUJnOXVy?=
 =?utf-8?B?VXZQOVdPSjNBemUzSDhLaEg0amRoK0tPbHNWQmN5VGR3YWRLSVpGcEtIeXB2?=
 =?utf-8?B?VW8rUXVsVGo3amFMOW9KenF0L0FCUjFHUXc0SnQ0bUYybTl5ZTk0MFFLRVZV?=
 =?utf-8?B?Y0ZPNnl2VHVSc29LbzkwbTBDMDZGcjZ4TDFGckRKSGRFbWFtb1BCOWNMRmNk?=
 =?utf-8?B?NEFiSGdDdng4RWJYUGtlK0xJZ3dUV0VtbzIralBKM0J0Z3Y5Y3NPVzFTeFY4?=
 =?utf-8?B?MTBhTUErL2Q5bmxIOUJTNGxVV2svWmgwWFlYejlNUEVoR2txUGRQbXQ1Sm04?=
 =?utf-8?B?NmhSNnd2Q0d6dVlBSGplYlFneFBnL2o5S3BvYU14WVlxTVBiaGpoL1ZvRHBj?=
 =?utf-8?Q?kAAA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 003a6b55-537b-4f26-966f-08db26ab6330
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 05:49:34.8292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8HXf3UMr16dtntXNXsZNwOV9wwbZu7vGSjiyT1QCZdayVBlAmS9Suoz46BfZdKx15BzBW5LajIm3WN1eMaN8nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6658
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFsbCwNCg0KU29ycnkgZm9yIHJlc3BvbnNlIGxhdGVyLg0KDQpGcm9tIGJlbG93IGRlc2Ny
aXB0aW9uLCBpdCBzZWVtcyBub3QgYSBidWZmZXIgb3ZlcnJ1biBpc3N1ZSwgaXQncyBqdXN0IGNh
dXNlZCBieSBOVUxMIHRlcm1pbmF0ZWQgc3RyaW5nLCByaWdodD8NCg0KQmVzdCBSZWdhcmRzLA0K
RXZlbiBYdQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogVG9kZCBCcmFuZHQg
PHRvZGQuZS5icmFuZHRAbGludXguaW50ZWwuY29tPiANClNlbnQ6IFNhdHVyZGF5LCBNYXJjaCAx
MSwgMjAyMyA3OjM2IEFNDQpUbzogUGhpbGlwcCBKdW5na2FtcCA8cC5qdW5na2FtcEBnbXgubmV0
Pjsgc3Jpbml2YXMgcGFuZHJ1dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5j
b20+OyBsaW51eC1pbnB1dEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IFh1LCBFdmVuIDxldmVuLnh1QGludGVsLmNvbT4NCkNjOiBKb25hdGhhbi5DYW1lcm9u
QGh1YXdlaS5jb207IGprb3NpbmFAc3VzZS5jejsgQnJhbmR0LCBUb2RkIEUgPHRvZGQuZS5icmFu
ZHRAaW50ZWwuY29tPg0KU3ViamVjdDogUmU6IEJVRzogaGlkLXNlbnNvci1pZHMgY29kZSBpbmNs
dWRlcyBiaW5hcnkgZGF0YSBpbiBkZXZpY2UgbmFtZQ0KDQpPbiBGcmksIDIwMjMtMDMtMTAgYXQg
MTU6MzUgKzAxMDAsIFBoaWxpcHAgSnVuZ2thbXAgd3JvdGU6DQo+IEhlbGxvLA0KPiANCj4gb24g
djMgb2YgdGhlIHBhdGNoc2V0IEkgaGFkIHRoaXMgY29tbWVudCBvbiB0aGUgJ3JlYWxfdXNhZ2Un
DQo+IGluaXRpYWxpemF0aW9uOg0KPiANCj4gPiA+IC0JY2hhciByZWFsX3VzYWdlW0hJRF9TRU5T
T1JfVVNBR0VfTEVOR1RIXSA9IHsgMCB9Ow0KPiA+ID4gKwljaGFyIHJlYWxfdXNhZ2VbSElEX1NF
TlNPUl9VU0FHRV9MRU5HVEhdOw0KPiA+ID4gIAlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpjdXN0
b21fcGRldjsNCj4gPiA+ICAJY29uc3QgY2hhciAqZGV2X25hbWU7DQo+ID4gPiAgCWNoYXIgKmM7
DQo+ID4gPiANCj4gPiA+IC0JLyogY29weSByZWFsIHVzYWdlIGlkICovDQo+ID4gPiAtCW1lbWNw
eShyZWFsX3VzYWdlLCBrbm93bl9zZW5zb3JfbHVpZFtpbmRleF0sIDQpOw0KPiA+ID4gKwltZW1j
cHkocmVhbF91c2FnZSwgbWF0Y2gtPmx1aWQsIDQpOw0KPiA+ID4gKwlyZWFsX3VzYWdlWzRdID0g
J1wwJzsNCj4gPiANCj4gPiBXaHkgdGhlIGNoYW5nZSBpbiBhcHByb2FjaCBmb3Igc2V0dGluZyB0
aGUgTlVMTCBjaGFyYWN0ZXI/DQo+ID4gRG9lc24ndCBzZWVtIHJlbGV2YW50IHRvIG1haW4gcHVy
cG9zZSBvZiB0aGlzIHBhdGNoLg0KPiANCj4gQmFzZWQgb24gdGhlIGNvbW1lbnQsIEkgY2hhbmdl
ZCB0aGF0IGluIHRoZSBmaW5hbCB2NCByZXZpc2lvbiB0bzoNCj4gDQo+ID4gLSAgICAgICBjaGFy
IHJlYWxfdXNhZ2VbSElEX1NFTlNPUl9VU0FHRV9MRU5HVEhdID0geyAwIH07DQo+ID4gKyAgICAg
ICBjaGFyIHJlYWxfdXNhZ2VbSElEX1NFTlNPUl9VU0FHRV9MRU5HVEhdOw0KPiA+ICAgICAgICAg
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqY3VzdG9tX3BkZXY7DQo+ID4gICAgICAgICBjb25zdCBj
aGFyICpkZXZfbmFtZTsNCj4gPiAgICAgICAgIGNoYXIgKmM7DQo+ID4gIA0KPiA+IC0gICAgICAg
LyogY29weSByZWFsIHVzYWdlIGlkICovDQo+ID4gLSAgICAgICBtZW1jcHkocmVhbF91c2FnZSwg
a25vd25fc2Vuc29yX2x1aWRbaW5kZXhdLCA0KTsNCj4gPiArICAgICAgIG1lbWNweShyZWFsX3Vz
YWdlLCBtYXRjaC0+bHVpZCwgNCk7DQo+IA0KPiBJIG9tbWl0dGVkIHRoZSBsaW5lIGFkZGluZyB0
aGUgbnVsbCB0ZXJtaW5hdG9yIHRvIHRoZSBzdHJpbmcgYnV0IGtlcHQgDQo+IHRoYXQgSSBkaWRu
J3QgaW5pdGlhbGl6ZSB0aGUgJ3JlYWxfdXNhZ2UnIGFzIHsgMCB9IGFueW1vcmUuIFRoZSBzdHJp
bmcgDQo+IG5vdyBtaXNzZXMgdGhlIG51bGwgdGVybWluYXRvciB3aGljaCBsZWFkcyB0byB0aGUg
YnJva2VuIHV0Zi04Lg0KPiANCj4gVGhlIHNpbXBsZSBmaXggaXMgdG8gcmVpbnRyb2R1Y2UgdGhl
IDAgaW5pdGlhbGl6YXRpb24gaW4gDQo+IGhpZF9zZW5zb3JfcmVnaXN0ZXJfcGxhdGZvcm1fZGV2
aWNlLiBFLmcuDQo+IA0KPiAtCWNoYXIgcmVhbF91c2FnZVtISURfU0VOU09SX1VTQUdFX0xFTkdU
SF07DQo+ICsJY2hhciByZWFsX3VzYWdlW0hJRF9TRU5TT1JfVVNBR0VfTEVOR1RIXSA9IHsgMCB9
Ow0KPiANCg0KSSBkaWRuJ3QgcmVhbGl6ZSB0aGF0IHRoZSBpc3N1ZSB3YXMgYSBidWZmZXIgb3Zl
cnJ1bi4gSSB0ZXN0ZWQgdGhlIGtlcm5lbCBidWlsdCB3aXRoIHRoaXMgc2ltcGxlIGZpeCBhbmQg
aXQgd29ya3Mgb2sgbm93LiBpLmUuIHRoaXMgcGF0Y2ggaXMgaXMgYWxsIHRoYXQncyBuZWVkZWQ6
DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2hpZC9oaWQtc2Vuc29yLWN1c3RvbS5jIGIvZHJpdmVy
cy9oaWQvaGlkLXNlbnNvci0gY3VzdG9tLmMgaW5kZXggM2UzZjg5ZTAxZDgxLi5kODUzOTg3MjE2
NTkgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2hpZC9oaWQtc2Vuc29yLWN1c3RvbS5jDQorKysgYi9k
cml2ZXJzL2hpZC9oaWQtc2Vuc29yLWN1c3RvbS5jDQpAQCAtOTQwLDcgKzk0MCw3IEBAIGhpZF9z
ZW5zb3JfcmVnaXN0ZXJfcGxhdGZvcm1fZGV2aWNlKHN0cnVjdA0KcGxhdGZvcm1fZGV2aWNlICpw
ZGV2LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGhpZF9zZW5z
b3JfaHViX2RldmljZSAqaHNkZXYsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBjb25zdCBzdHJ1Y3QgaGlkX3NlbnNvcl9jdXN0b21fbWF0Y2ggKm1hdGNoKSAgew0KLSAgICAg
ICBjaGFyIHJlYWxfdXNhZ2VbSElEX1NFTlNPUl9VU0FHRV9MRU5HVEhdOw0KKyAgICAgICBjaGFy
IHJlYWxfdXNhZ2VbSElEX1NFTlNPUl9VU0FHRV9MRU5HVEhdID0geyAwIH07DQogICAgICAgIHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmN1c3RvbV9wZGV2Ow0KICAgICAgICBjb25zdCBjaGFyICpk
ZXZfbmFtZTsNCiAgICAgICAgY2hhciAqYzsNCg0KPiBXaGVyZSBkbyBJIG5lZWQgdG8gc3VibWl0
IGEgcGF0Y2ggZm9yIHRoaXM/IEFuZCBvbiB3aGljaCB0cmVlIHNob3VsZCBJIA0KPiBiYXNlIHRo
ZSBwYXRjaD8NCj4gDQoNClRoZSBjaGFuZ2UgaXMgc28gc21hbGwgaXQgc2hvdWxkbid0IHJlcXVp
cmUgYW55IHJlYmFzaW5nLiBKdXN0IHNlbmQgdGhlDQpwYXRjaCB0byB0aGVzZSBlbWFpbHMgKGZy
b20gTUFJTlRBSU5FUlMpOg0KDQpISUQgU0VOU09SIEhVQiBEUklWRVJTDQpNOiAgSmlyaSBLb3Np
bmEgPGppa29zQGtlcm5lbC5vcmc+DQpNOiAgSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVs
Lm9yZz4NCk06ICBTcmluaXZhcyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4
LmludGVsLmNvbT4NCkw6ICBsaW51eC1pbnB1dEB2Z2VyLmtlcm5lbC5vcmcNCkw6ICBsaW51eC1p
aW9Admdlci5rZXJuZWwub3JnDQoNCj4gSSdtIHNvcnJ5IGZvciB0aGUgcHJvYmxlbXMgbXkgcGF0
Y2ggY2F1c2VkLg0KPiANCg0KTm8gcHJvYmxlbS4gSXQgYWN0dWFsbHkgbWFkZSBzbGVlcGdyYXBo
IGJldHRlciBiZWNhdXNlIGl0IGV4cG9zZWQgYSBidWcNCmluIHRoZSBmdHJhY2UgcHJvY2Vzc2lu
ZyBjb2RlLiBJIHdhc24ndCBwcm9wZXJseSBoYW5kbGluZyB0aGUgY29ybmVyDQpjYXNlIHdoZXJl
IGZ0cmFjZSBoYWQgYmluYXJ5IGRhdGEgaW4gaXQuDQoNCj4gUmVnYXJkcywNCj4gUGhpbGlwcCBK
dW5na2FtcA0KPiANCj4gT24gRnJpLCAyMDIzLTAzLTEwIGF0IDAxOjUxIC0wODAwLCBzcmluaXZh
cyBwYW5kcnV2YWRhIHdyb3RlOg0KPiA+ICtFdmVuDQo+ID4gDQo+ID4gT24gVGh1LCAyMDIzLTAz
LTA5IGF0IDE1OjMzIC0wODAwLCBUb2RkIEJyYW5kdCB3cm90ZToNCj4gPiA+IEhpIGFsbCwgSSd2
ZSBydW4gaW50byBhbiBpc3N1ZSBpbiA2LjMuMC1yYzEgdGhhdCBjYXVzZXMgcHJvYmxlbXMNCj4g
PiA+IHdpdGgNCj4gPiA+IGZ0cmFjZSBhbmQgSSd2ZSBiaXNlY3RlZCBpdCB0byB0aGlzIGNvbW1p
dDoNCj4gPiA+IA0KPiA+ID4gY29tbWl0IDk4YzA2MmU4MjQ1MTk5ZmE5MTIxMTQxYTBiZjEwMzVk
YzQ1YWU5MGUgKEhFQUQsDQo+ID4gPiByZWZzL2Jpc2VjdC9iYWQpDQo+ID4gPiBBdXRob3I6IFBo
aWxpcHAgSnVuZ2thbXAgcC5qdW5na2FtcEBnbXgubmV0DQo+ID4gPiBEYXRlOiAgIEZyaSBOb3Yg
MjUgMDA6Mzg6MzggMjAyMiArMDEwMA0KPiA+ID4gDQo+ID4gPiAgICAgSElEOiBoaWQtc2Vuc29y
LWN1c3RvbTogQWxsb3cgbW9yZSBjdXN0b20gaWlvIHNlbnNvcnMNCj4gPiA+IA0KPiA+ID4gICAg
IFRoZSBrbm93biBMVUlEIHRhYmxlIGZvciBlc3RhYmxpc2hlZC9rbm93biBjdXN0b20gSElEIHNl
bnNvcnMNCj4gPiA+IHdhcw0KPiA+ID4gICAgIGxpbWl0ZWQgdG8gc2Vuc29ycyB3aXRoICJJTlRF
TCIgYXMgbWFudWZhY3R1cmVyLiBCdXQgc29tZQ0KPiA+ID4gdmVuZG9ycw0KPiA+ID4gc3VjaA0K
PiA+ID4gICAgIGFzIExlbm92byBhbHNvIGluY2x1ZGUgZmFpcmx5IHN0YW5kYXJkIGlpbyBzZW5z
b3JzIChlLmcuDQo+ID4gPiBhbWJpZW50DQo+ID4gPiBsaWdodCkNCj4gPiA+ICAgICBpbiB0aGVp
ciBjdXN0b20gc2Vuc29ycy4NCj4gPiA+IA0KPiA+ID4gICAgIEV4cGFuZCB0aGUga25vd24gY3Vz
dG9tIHNlbnNvcnMgdGFibGUgYnkgYSB0YWcgdXNlZCBmb3IgdGhlDQo+ID4gPiBwbGF0Zm9ybQ0K
PiA+ID4gICAgIGRldmljZSBuYW1lIGFuZCBtYXRjaCBzZW5zb3JzIGJhc2VkIG9uIHRoZSBMVUlE
IGFzIHdlbGwgYXMNCj4gPiA+IG9wdGlvbmFsbHkNCj4gPiA+ICAgICBvbiBtb2RlbCBhbmQgbWFu
dWZhY3R1cmVyIHByb3BlcnRpZXMuDQo+ID4gPiANCj4gPiA+ICAgICBTaWduZWQtb2ZmLWJ5OiBQ
aGlsaXBwIEp1bmdrYW1wIHAuanVuZ2thbXBAZ214Lm5ldA0KPiA+ID4gICAgIFJldmlld2VkLWJ5
OiBKb25hdGhhbiBDYW1lcm9uIEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbQ0KPiA+ID4gICAg
IEFja2VkLWJ5OiBTcmluaXZhcyBQYW5kcnV2YWRhDQo+ID4gPiBzcmluaXZhcy5wYW5kcnV2YWRh
QGxpbnV4LmludGVsLmNvbQ0KPiA+ID4gICAgIFNpZ25lZC1vZmYtYnk6IEppcmkgS29zaW5hIGpr
b3NpbmFAc3VzZS5jeg0KPiA+ID4gDQo+ID4gPiBZb3UncmUgdXNpbmcgcmF3IGRhdGEgYXMgcGFy
dCBvZiB0aGUgZGV2bmFtZSBpbiB0aGUgInJlYWxfdXNhZ2UiDQo+ID4gPiBzdHJpbmcsIGJ1dCBp
dCBpbmNsdWRlcyBjaGFycyBvdGhlciB0aGFuIEFTQ0lJLCBhbmQgdGhvc2UgY2hhcnMNCj4gPiA+
IGVuZA0KPiA+ID4gdXAgYmVpbmcgcHJpbnRlZCBvdXQgaW4gdGhlIGZ0cmFjZSBsb2cgd2hpY2gg
aXMgbWVhbnQgdG8gYmUgQVNDSUkNCj4gPiA+IG9ubHkuDQo+ID4gPiANCj4gPiA+IC0gICAgICAg
LyogSElELVNFTlNPUi1JTlQtUkVBTF9VU0FHRV9JRCAqLw0KPiA+ID4gLSAgICAgICBkZXZfbmFt
ZSA9IGthc3ByaW50ZihHRlBfS0VSTkVMLCAiSElELVNFTlNPUi1JTlQtJXMiLA0KPiA+ID4gcmVh
bF91c2FnZSk7DQo+ID4gPiArICAgICAgIC8qIEhJRC1TRU5TT1ItVEFHLVJFQUxfVVNBR0VfSUQg
Ki8NCj4gPiA+ICsgICAgICAgZGV2X25hbWUgPSBrYXNwcmludGYoR0ZQX0tFUk5FTCwgIkhJRC1T
RU5TT1ItJXMtJXMiLA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBtYXRjaC0+
dGFnLCByZWFsX3VzYWdlKTsNCj4gPiA+IA0KPiA+ID4gTXkgc2xlZXBncmFwaCB0b29sIHN0YXJ0
ZWQgdG8gY3Jhc2ggYmVjYXVzZSBpdCByZWFkIHRoZXNlIGxpbmVzDQo+ID4gPiBmcm9tDQo+ID4g
PiBmdHJhY2U6DQo+ID4gPiANCj4gPiA+IGRldmljZV9wbV9jYWxsYmFja19zdGFydDogcGxhdGZv
cm0gSElELVNFTlNPUi1JTlQtMDIwYj8uMzkuYXV0bywNCj4gPiA+IHBhcmVudDogMDAxRjo4MDg3
OjBBQzIuMDAwMywgW3N1c3BlbmRdDQo+ID4gPiBkZXZpY2VfcG1fY2FsbGJhY2tfZW5kOiBwbGF0
Zm9ybSBISUQtU0VOU09SLUlOVC0wMjBiPy4zOS5hdXRvLA0KPiA+ID4gZXJyPTANCj4gPiA+IA0K
PiA+IA0KPiA+IEhlcmUgdGFnIGlzOg0KPiA+IC50YWcgPSAiSU5UIiwNCj4gPiAubHVpZCA9ICIw
MjBCMDAwMDAwMDAwMDAwIiwNCj4gPiANCj4gPiANCj4gPiBUaGUgTFVJRCBpcyBzdGlsbCBhIHN0
cmluZy4gUHJvYmFibHkgdG9vIGxvbmcgZm9yIGEgZGV2X25hbWUuDQo+ID4gDQo+ID4gRXZlbiwN
Cj4gPiANCj4gPiBQbGVhc2UgY2hlY2suDQo+ID4gDQo+ID4gVGhhbmtzLg0KPiA+IFNyaW5pdmFz
DQo+ID4gDQo+ID4gDQo+ID4gPiBUaGUgIkhJRC1TRU5TT1ItSU5ULTAyMGI/LjM5LmF1dG8iIHN0
cmluZyBpbmNsdWRlcyBhIGJpbmFyeSBjaGFyDQo+ID4gPiB0aGF0DQo+ID4gPiBraWxscw0KPiA+
ID4gcHl0aG9uMyBjb2RlIHRoYXQgbG9vcHMgdGhyb3VnaCBhbiBhc2NpaSBmaWxlIGFzIHN1Y2g6
DQo+ID4gPiANCj4gPiA+ICAgRmlsZSAiL3Vzci9iaW4vc2xlZXBncmFwaCIsIGxpbmUgNTU3OSwg
aW4gZXhlY3V0ZVN1c3BlbmQNCj4gPiA+ICAgICBmb3IgbGluZSBpbiBmcDoNCj4gPiA+ICAgRmls
ZSAiL3Vzci9saWIvcHl0aG9uMy4xMC9jb2RlY3MucHkiLCBsaW5lIDMyMiwgaW4gZGVjb2RlDQo+
ID4gPiAgICAgKHJlc3VsdCwgY29uc3VtZWQpID0gc2VsZi5fYnVmZmVyX2RlY29kZShkYXRhLCBz
ZWxmLmVycm9ycywNCj4gPiA+IGZpbmFsKQ0KPiA+ID4gVW5pY29kZURlY29kZUVycm9yOiAndXRm
LTgnIGNvZGVjIGNhbid0IGRlY29kZSBieXRlIDB4ZmYgaW4NCj4gPiA+IHBvc2l0aW9uDQo+ID4g
PiAxNTY4OiBpbnZhbGlkIHN0YXJ0IGJ5dGUNCj4gPiA+IA0KPiA+ID4gSSd2ZSB1cGRhdGVkIHNs
ZWVwZ3JhcGggdG8gaGFuZGxlIHJhbmRvbSBub24tYXNjaWkgY2hhcnMsIGJ1dA0KPiA+ID4gb3Ro
ZXINCj4gPiA+IHRvb2xzDQo+ID4gPiBtYXkgc3VmZmVyIHRoZSBzYW1lIGZhdGUuIENhbiB5b3Ug
cmV3cml0ZSB0aGlzIHRvIGVuc3VyZSB0aGF0IG5vDQo+ID4gPiBiaW5hcnkNCj4gPiA+IGNoYXJz
IG1ha2UgaXQgaW50byB0aGUgZGV2bmFtZT8NCj4gPiA+IA0KPiANCj4gDQoNCg==
