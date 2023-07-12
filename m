Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D383F74FF19
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjGLGPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjGLGPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:15:06 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66C21734
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 23:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689142505; x=1720678505;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h0rCfR+HhtN+flBQd0B12/Ng4wit2/3DjpZZcfxYQAQ=;
  b=TyWrSej56yBSTtFIYWf5SIfcqV6dORhq7Lb+TpPUs0xM+DgAfJzcNSgz
   9dXY60whUK3zy93T5oZgc1GckmdfEivS9cTEKGa3xNoiK+FgQ75m5WQ/o
   aJ3aIIoEAjDWnkn/8LrdORvOjeS+lcGcbxjHnz1wBTq8aUBR95r7srh4x
   HFKyua56RzGm0bQPvBRJ1yf56owesbx+x0p4fHOBTrrlDQ8l82rHlCANG
   977S/eWnA9INVIzVICAAIZ3mAOUeT43x6H0iLgQRtfFI2rNLyD1S+muqU
   YFIPCmMY8TPsoKcsugenuBFYM5Teo0YaCZId1dU6+DzJ5Y/NFbHpAPslq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="395607382"
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="395607382"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 23:15:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="845542693"
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="845542693"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 11 Jul 2023 23:15:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 23:15:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 23:15:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 11 Jul 2023 23:15:04 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 11 Jul 2023 23:15:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3xNQO1+0NF3pDO5rXytjUD12/K1qmy8WQpcfwWFogHQbpzCp+0b51PIP8M+dzzL17EjNDd4IPNCNXs4BX/KXFJ1m4/KRGRbfcB2rYmKhFjRfrrO/FByaLnZiajl4U42bc/cvE0u3NFAgIy6K69ixbLKQQxRpnY8xnAxrSkCO/EFgZQHr6aCTKXLYr9qQuCdzctm+XFNP42kYdFNnINA6adCMMePNT7uGiJjrGr5iBC7rJW6DusTUp/U9mJbUYLVSLTLt/W39PfB9C/fFZDNGKhBnjWlePU/LQ2X18HoeOdrNy8wt8mLawpcWYdTc5fXo74yVyzjRK+CRi2/eUwGDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0rCfR+HhtN+flBQd0B12/Ng4wit2/3DjpZZcfxYQAQ=;
 b=Nlqq0L1mXEQQygTFkg/15XTAtM9DjAHs2kq5zBdFapWLf5TpnWLQoLEGOWBy2hyW7qv+YySowPpSU//dY+noDzWX2dfJKOk9LwBd7ID6Z4DfvcxULbE5B6Rx7Wh62++W5+EW5WKZlIRi6KfUC6SCmhs1VSQ1eLJk/g0amhxglYY44ltA6oHqh4TgdwreExOFPpKOgwRWEE9pb6kB4AaczwQj6MK/ANhbWYJcOhw1O+8I9gs0MgYzKplUcX3U7KwB52qNpibHYpl6F0QzJxVysDePc6FsE/FwbGD3T/3btSBUjX/eHO60zXqUX18AXdoARXOuxRTKD60bk2LzXM3OAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6257.namprd11.prod.outlook.com (2603:10b6:930:26::22)
 by SA3PR11MB7581.namprd11.prod.outlook.com (2603:10b6:806:31b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 06:15:01 +0000
Received: from CY5PR11MB6257.namprd11.prod.outlook.com
 ([fe80::25f1:cac6:3bbf:27ad]) by CY5PR11MB6257.namprd11.prod.outlook.com
 ([fe80::25f1:cac6:3bbf:27ad%6]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 06:15:01 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Zhi, Yong" <yong.zhi@intel.com>,
        "Bhat, Uday M" <uday.m.bhat@intel.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Song, Gongjun" <gongjun.song@intel.com>,
        Terry Cheong <htcheong@chromium.org>,
        "Chiang, Mac" <mac.chiang@intel.com>,
        "R, Dharageswari" <dharageswari.r@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] ASoC: Intel: sof_rt5682: add jsl_rt5650 board config
Thread-Topic: [PATCH v3] ASoC: Intel: sof_rt5682: add jsl_rt5650 board config
Thread-Index: AQHZtGaT0T46+v+6ZEqtWjmKY5r26q+1puAAgAAAYhA=
Date:   Wed, 12 Jul 2023 06:15:01 +0000
Message-ID: <CY5PR11MB6257F77DBF1D123FAD0DF4689736A@CY5PR11MB6257.namprd11.prod.outlook.com>
References: <20230712100855.272467-1-brent.lu@intel.com>
 <2e9a5d5b-f637-1f9a-b500-03f9c151dc26@linux.intel.com>
In-Reply-To: <2e9a5d5b-f637-1f9a-b500-03f9c151dc26@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6257:EE_|SA3PR11MB7581:EE_
x-ms-office365-filtering-correlation-id: b2d53655-40fb-4e48-7220-08db829f534d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mUJnDtaRfj1e06lZva8YvSY28Wl6vRSx23I+FpPF/mGKD83JJPWgh3GEeYv2mUT0NbFCKefh2kdpoQ4dWijcBOEHoCSpgFM8xRStfBpT5bRzPRYoG0TCrYavJVLOal+bJzdf9L/RmC4iNukxBnuyzlOZL6XqO/06m8K667FbgpZ6wJIFSG716GgoIWEGt36PVAXTFuXEd2ojvd43oFIIQwfoteKllu7lh8FcOkbc97Pp0Sn8v92/al7Vofsi0l62k4RyatUt6SP/r4o7Mj3uLkt033IPz7nRHk6b9Pe862dEooATpbusBW02Sh/0PdBL+pAOCwao1jM+m7j2GldNAKV+AO45XDSwWwicQiu/rSWckHF20BbNT+Jy0PuK39Z5iztSFs2K1UlD7xEWrIjbKfBRSbN9dfJJR5f81yby4wWUysQsOkKG0YRSycbjsCQ49NI1RJksrWiHDZbVtYnqqjp9+2TfG6Scx8MwcvVCm3zINPUDbV4Z3s8bXa1Aetbpq5wdAYGUgD2pb/Qi/MUGR2qUa0mhDhTmPYZ60EON5vO9w3/QL4YkwD89y66jDyxBJu9w82AWs7HOE8JNXvqNcWYRdtoYMqFDTwEKjT780Q8gbduEMmWavkiycEnDsQxA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6257.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199021)(4326008)(66556008)(66476007)(66446008)(64756008)(76116006)(66946007)(38100700002)(122000001)(86362001)(186003)(38070700005)(6506007)(26005)(82960400001)(9686003)(33656002)(478600001)(71200400001)(110136005)(7696005)(55016003)(54906003)(41300700001)(52536014)(5660300002)(8676002)(8936002)(4744005)(316002)(2906002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2lLVGlVQ2pPOUhtdnM0QW1OZ01kQmpvYjNqb2RuOVBDQW00ZUJzaXBBQzNp?=
 =?utf-8?B?NG5Pb1FLcW12Z3M2cU1jcGNML1hxdmo4bm9ZRWY1K1hNSDF5VXhtNE1CRHlI?=
 =?utf-8?B?dnJaNzVzZDZPR1VkcnJzNi9HaGx6dDdPSjZwOU41TDIvbUUwb0hCTk4xeUV3?=
 =?utf-8?B?VTJJeTZPVVRKVmx6bnJBSHZxMzUvUUNkUGZyNWRRckpvS05DVWwvMXhKV3Vp?=
 =?utf-8?B?QWN1NEhJWm4zWEJlQjZobWIzam4xNW5wTWY3MHUyZTBTY1RzUkQybGluUHdm?=
 =?utf-8?B?NnN5Y3lBK0pvNTNrbmE4N3ErNlJ3eDE5L3p5UVJCQ1JCYVd2MFpOVzhrdUl5?=
 =?utf-8?B?T2dnR2Y0dXN6Um9aenNiZUtCUmpLT2Y3TmdIenR5SkdqLzB6QWhaTExqVFJ2?=
 =?utf-8?B?MDRxbEdaVHRWTXBtd21yb0FPdi9zaW5jMzZBOWtpazl2UnQrbE5TaFRUSlRz?=
 =?utf-8?B?cDNXeitWQTJ2TTVNWk9VZTlqZEQyemFNaWdEZGczVVNZa3NzQVVIV1JFWTMx?=
 =?utf-8?B?aE9FeVZwKzc1NTZWZVE1emFmaWpiSGNVM3YvMXo2aWlsZmRDa0hHQWFkWjZP?=
 =?utf-8?B?TzI4dTNPUmtJcXJTeTUxWFRQL05TcENiblFqTkZUN1pRbVBQWDd1QjNLQUtK?=
 =?utf-8?B?THpBOGwrKzVFMElETmR2ZHgycXcxWGNqd3BRKzFjck1ESXRhUmpyTDVqb1Bx?=
 =?utf-8?B?MlNobTN4am1BeHA4bGdSMStkYkNGSlltTEZ2WHZOalllL1JUYTJtYjJJbXo2?=
 =?utf-8?B?OFpFMEkxQVd1OStUaDM1ODNMZi9zZXFIalBISnp0RnBNdnJ5TXVHVDZDRUJP?=
 =?utf-8?B?WkM3WXphUlhKdENHZE9xeDhtUnp5c3g5RzdzZVhzKzNZSGJMSzN1eC9URkRR?=
 =?utf-8?B?Y3UyVzBKVXEycGZBeExLaWRNc29PRTUyRUJqZ1pUMS9nbFJsWHhlemFtOFpI?=
 =?utf-8?B?NnVQOVdSSmpFWHN0UXNCbzdoMlQvdThsWG9rUGxDT0dKY2tZVU9hTGZONnNw?=
 =?utf-8?B?Zm1RcVRoSU9VUWx1Tmx2THN3WjVrdXlsQUdNbk9qZHJEN2NGYjJOT01ueExL?=
 =?utf-8?B?S2JuUmlDSHo0YXJOcDRuY3FpNUpwVFZ5WDM1SzIxQ3JYZXBkSXdRNVN4czFm?=
 =?utf-8?B?TThlVERRaEdTK3RxVmNNME1obDRUQS85Y0hEQlVHR29DVzdjTjk4ZFgvQjFo?=
 =?utf-8?B?dGp0QndML0VBNmJ4N0xsL1JMUDgrUU01SHR3SVQ0YXh1c0toRGtMV1dTVHVE?=
 =?utf-8?B?RFl5UC9Lc1JIeVFBZTJMbGxiK0ZkUmZta2ZxVjdXL0FKU0x6dmNOeE00VkNM?=
 =?utf-8?B?QVlXUDhsakxwSWdFbzF4MzZ5MDlRVG9Nc3AvR1pPQ012TGVKMm9PdEtUVW41?=
 =?utf-8?B?VGpBZWZLdDNaUmtTMzZLVy9FcVY1N0xndkZSajN1R29KRzhKMzM5SHpKYnJT?=
 =?utf-8?B?V0M0Yi82VnhLQVk3a1FQdGZySW9GNlVIV09nOXUwbTNMRTRraUI1VnV1ZTlQ?=
 =?utf-8?B?SUFQZHdsL1U3N1RDUnNCZG95T2ZGd1BTa2twV04zaStkd2wwdmdDS2lzTk5Q?=
 =?utf-8?B?ajB0TFB1aWNjZ2Z0RFFKSlRnSEFYR0lWT3pKKzdIeExWR3dUNCsvakYrOHZh?=
 =?utf-8?B?ZTV1STcwcm9FNnlBdE8vdXU1MUo3WHRyN0ZjZlZlby8vbVJiZ2NLcUtyREQv?=
 =?utf-8?B?aWh0aXB1czREQkFrMWRWUnhMQ1REUkk3N1poL3hZb0piRkZ3eldKaVZhOHAw?=
 =?utf-8?B?ejFDaEJLNEMxb0pPa0hWdXB3c0FUdS8xa01qck40S1NZbmkwK1VJR2tmMVZT?=
 =?utf-8?B?U1RJYUtZLzE5T1hwQ2ZnYnE5R0ZVTGR4MFRYeVZlVkZnenlXNDgzb2dlVTg4?=
 =?utf-8?B?cTR3OWd0OE5NWlZySXMyOFBaSEJaa0MxQ255UVpYK0d0SWRzL29CbmJEcXBI?=
 =?utf-8?B?U0U2SFRVWjNlRlhvd1FIcjFZT28rcFBuaXMwYmt0d3VTdXpNaWoxSzRZL1N1?=
 =?utf-8?B?OG1GZTYzUmZWQmQ2dnFObC9xV1paSEhEQTB2Uml1TmJoK1NMZDlzTkp6ckU5?=
 =?utf-8?B?cndlbVVEejF2Wjl4STgxUTRkM2VwZEVjWTFoQWpKdkZCRFlXcEtZSkRXYi9P?=
 =?utf-8?Q?nhXQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6257.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d53655-40fb-4e48-7220-08db829f534d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 06:15:01.1631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iEexs9zR457qnKSP62xpuP72WDLdQw1ga0DO2EbFSeK52wi48RYovEHEGUCf8Ti/CchiULnXkxpMyszSA3g/Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7581
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICsJew0KPiA+ICsJCS5pZCA9ICIxMEVDNTY1MCIsDQo+ID4gKwkJLmRydl9uYW1lID0gImpz
bF9ydDU2NTAiLA0KPiA+ICsJCS5tYWNoaW5lX3F1aXJrID0gc25kX3NvY19hY3BpX2NvZGVjX2xp
c3QsDQo+ID4gKwkJLnF1aXJrX2RhdGEgPSAmcnQ1NjUwX3NwaywNCj4gPiArCQkuc29mX3RwbGdf
ZmlsZW5hbWUgPSAic29mLWpzbC1ydDU2NTAtZHVhbC50cGxnIiwNCj4gDQo+IHdoYXQgZG9lcyAn
ZHVhbCcgbWVhbiBpbiB0aGlzIGNvbnRleHQ/IGl0J3Mgbm90IHNvbWV0aGluZyB3ZSd2ZSB1c2Vk
IGJlZm9yZQ0KPiBzbyBhIGNvbW1lbnQgd291bGQgYmUgbmVlZGVkIElNSE8uDQo+IA0KPiB0d28g
REFJcywgdHdvIGNvZGVjcz8NCg0KRHVhbCBJMlMuIFNob3VsZCB3ZSByZW1vdmUgaXQ/IEp1c3Qg
c29mLWpzbC1ydDU2NTAudHBsZz8NCg0KUmVnYXJkcywNCkJyZW50DQoNCg==
