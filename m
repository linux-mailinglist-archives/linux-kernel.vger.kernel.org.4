Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5D66DF015
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjDLJO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjDLJOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:14:21 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1121726;
        Wed, 12 Apr 2023 02:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681290860; x=1712826860;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZCBfmX7VH4OWEyLOXzDSLuNt5/rJ6JN/8xJdJW2Ie1c=;
  b=Pu3JdxMxJ6AzdjAV7ytQ2YAxc5sGuSKIy+WfL27sRUfIhZmdpfy9qU2a
   m4NB3gSOL0je+WRYUVSdih48vLdWJWljI6CT/8b2d7n9uTiHvfoRDfqg7
   qTHQDmIoSfVt08RuA3TL3AX7jAcNcr/Ps1ACUKzgrdX4emANu9ks+yi0H
   wNbytBEFCNNYyTJXaSAlnFia2f5Am/ujxwtWxNrwNzQ8qj5hM1p+l+iea
   YbZX62S2wscAfNmp8Mb6smUFcQ8kPQo9oGlUctQyFV1fshwaetdo6/oYM
   IFwMKHJVpd447w5d6MuOltlK+L98o20SnZ0V/YqJTiylQgzTUHPMO/qkb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="341334022"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="341334022"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 02:14:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="719287056"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="719287056"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 12 Apr 2023 02:14:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 02:14:18 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 02:14:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 12 Apr 2023 02:14:18 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 12 Apr 2023 02:14:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSSCIsF8nj6W+hZ6cd0vPAoFkc0NXWNmiuIuq1Uc1UkQKZW4wyIygb9+qjLu44t89qA/Gx+F+b5dZODQK2wYZT8bN5Zy+D5ugXFKbIp6J+g2t6EyO28hNpDYgC5bxja4z70FQd6mB6QAfaIydqQEdY2SMcHj3wyh2IWuy4ttkfkrhsaFoop/3xm0n983RaDJWMW/rwBh9R1/cPG107Ue90RcpeHbT0QEfCz7XUZz32cHKZJguYjhq/fH+iToO9OVvgSv62Pjc69sNv/mRbGM2NjfMCmfHp33KEbxEInWEhuVIT55ot/0kjKPNA+fRrBzXXcCDH2kTDZ8zpWdeWoO4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCBfmX7VH4OWEyLOXzDSLuNt5/rJ6JN/8xJdJW2Ie1c=;
 b=DLq0ejtKI2iIRQqwW0mMvfEEWSNStVADY4Pf+OCoIekDOOfJfVaepaZJh3QOdVRYan4S9Vztz3NAmMddEIMI952x3O9UmrJJjyTBYHrhWuNm+QAzAUqFlm26lpzoBtLZ9KZpzx56RpvTay7SHc5nwfUALV9t+O+h1524ct0ug5IsNWcwe5vxE5vbq8BzvMdue1tOeHkO9AvQEQJJeStBkq63lgMwSYnr8Ya8lxSlZo73MVcVshHX7HOYUb3gNGlM+xVLtdcQ5N9Mkwsn7js+FzLhioaiSMdqQa/Ms/DFnc+dfOSqqWAG2LshTU+NJvSnovpITuP7OVofyN+h0ysghQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by PH8PR11MB6681.namprd11.prod.outlook.com (2603:10b6:510:1c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.28; Wed, 12 Apr
 2023 09:14:16 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::3265:f579:62a6:8a0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::3265:f579:62a6:8a0%5]) with mapi id 15.20.6277.035; Wed, 12 Apr 2023
 09:14:16 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] rcu/kvfree: Prevents cache growing when the
 backoff_page_cache_fill is set
Thread-Topic: [PATCH v3] rcu/kvfree: Prevents cache growing when the
 backoff_page_cache_fill is set
Thread-Index: AQHZaiXby4kI/lAQlUSTC1cR7UMpS68lNdWAgABJBmCAAK/VgIAAAf6ggAAHJACAAB0hgIAAB8aAgADFFUA=
Date:   Wed, 12 Apr 2023 09:14:15 +0000
Message-ID: <PH0PR11MB588060C9B6BE6F08540E74DCDA9B9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <PH0PR11MB588072A12543FD617C833AF9DA9A9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <ZDVt5eUAlp4VmbFy@pc636>
 <PH0PR11MB5880C4B181B6237402B1FBA7DA9A9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <ZDV1jhENgED4ctxO@pc636>
 <2159c88e-ec99-4ad6-a166-baf4199d138f@paulmck-laptop>
 <ZDWUgygOqJjs07pp@pc636>
In-Reply-To: <ZDWUgygOqJjs07pp@pc636>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|PH8PR11MB6681:EE_
x-ms-office365-filtering-correlation-id: 795bf110-3ce7-41eb-48e9-08db3b3649fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R67tgjyp4hJ0SqFf6KyDAPU4ubAfQPxxXkSAEHz6kMEdsN1vCwO2KGqJ5jH/2D2LFiWTvRN/jdKGNcT4qvi13y7bnvHqimYuZ3eeIxKK0fBp5UzhNqknDgdht/AGIKR35WKPKb3c4ZeASCq9tHXt+Ru/zlJma8ahI1GyZ2X3u+E3PQKBO1FEJmzAEKz1AG83OQjCfwdm1/r/pT8RSAGqo2594VxTutI82CJrrWZvPYDii/tnvQb1YgNYTjxrDOpmKWiv036FoVmqMoxxNWHUKdS4eMGzm6/O0c8xsNdvPj8ryBkjBJrH7sCZFJYjBlkfIDsLFKlDd+kpFzkSqfHEzBCJEkw0wZGOZx0TPCmehC+LoBsD8jvNtw2Cj4JqRqwEfnSPYQDp6Qo38EdF/L2fdHTgOeetjPI5rSlIM58AC8axjB9Z1cbYgq98iNwfooHqboaCXbb5BITu/nn01PFxHLk0ivI/FPBNkFSFiNoKseg5nKcTvPJpXZ8HsmHmiG9KTLblDfNZCbxraXLnWDGK/Em5uJ1RTsUT4EJOwolaBUFcx7nnPwRGR0FdCLDWwrmvk2TozCWJhmBSnzbys5QLyDKAsM4fGMqIyI04PnYE79IxTHTZNf8ClvfuTwvnLoYQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(136003)(366004)(376002)(451199021)(76116006)(83380400001)(71200400001)(7696005)(54906003)(110136005)(6506007)(26005)(186003)(9686003)(82960400001)(33656002)(2906002)(52536014)(38100700002)(5660300002)(122000001)(4326008)(66446008)(66946007)(41300700001)(66476007)(64756008)(8936002)(38070700005)(316002)(8676002)(66556008)(86362001)(55016003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L01nL2dPUFFwL1E5eWQ2S1RGS09rN2tCUHlYRTFDWjJlWnN0MnEwZitHaXgr?=
 =?utf-8?B?ODg5alB5bGd0K1ZCM1ZLRDVUQTVQWXpUV3JMenQrdEh6T2VvclVVRTR2cW5J?=
 =?utf-8?B?bXZrbFZoSDFIdkN1MTBOWGJJMzJpVmRIMURGZTkvQlNZc0p6UlRnWFZ1bEda?=
 =?utf-8?B?RkhjdDdGckxidEtLUVNNakZKVGxGUGxsWVF5ZTlHcnROcU1MU0h0Z2UwZVhP?=
 =?utf-8?B?RHpUbnFmaFNNTk9tQSswT3o3bnFoQXlnYnBycEFIUldTdzhEejllVTcvaExG?=
 =?utf-8?B?Y2gzTEdBcFRPMWY1dVJhV3Zib2hLSk1ia0tWdjBneEdnSEx4VDRod2N6S2Mr?=
 =?utf-8?B?M1lLbXNZV0FsY0x6YzZQN0tkUXgvUmpudjY5WThVQjhFVm1NNURDcFhwQzdM?=
 =?utf-8?B?Q0x0L3dOKy9aeHk3a0pEZmo5eUFmNFZxZ29HUW44UUhrV3pKSFBIbnZxelQ4?=
 =?utf-8?B?eklSRUdIdW5EcEdLZC9HeHRUQmh6WGRuSTFWWlJwUDhZOERhWlNBSFNGNExm?=
 =?utf-8?B?dGk0cTdsbDdOcDRMWHUveUh1TVVldDcxVmNPcXo0cHNobFRzMmpuaGlWd1RE?=
 =?utf-8?B?UlVhbEJTOFdRa0Mvd3E1bTIydVp1NUcrcjMwNE1NU3QydVIvR3d1am4xTXJw?=
 =?utf-8?B?SHFSRGYzTW5BNUdheGkxbStiQ3k4V1J2MlBHdUhIcWlSaEJacFdPdXZKRElV?=
 =?utf-8?B?WWxBaGdpcTNsR1NCeEphUmJLZ25nMlA3SWRHSDlOUmN2ZmJTLzBHRnhNWG1J?=
 =?utf-8?B?NW1uY0FOWS9wVzVmOHBYL2NxaVArblM1TW1CTUMrb2E5ZEx0dE1Gc3ZUSnJN?=
 =?utf-8?B?UmNxT1BUZ1pKYjY5cEpjWVFTSERtQjBIMi9nZ0hkK0N4bDJ1ajI0bEZWejJT?=
 =?utf-8?B?TDBKcCtKcmI4ZUtlbnhram9hWElxTDAwWWovbUVXQUdiQzN3ZHNycEV5dGY2?=
 =?utf-8?B?MGtVdSs2S1F5OG9GQmJhRnJ5OTdBV0l2YTVERTNkSHBjNzcrNjBYZDB6dGZh?=
 =?utf-8?B?L0pxR0tseE51QnI0TWxsSGZ5aEM1MERtOTJFRUVhNlpkRTVuOHcyN0JCMjhI?=
 =?utf-8?B?UkVwRVFVUDZ4bFkzSkEvclhoazJKTzg2dzZYc3AreGZZWDBGcU5UTFB3Q3c1?=
 =?utf-8?B?bWp3ek1tbU9CZjlzKzI3eDFNMFQxL0QvQ1pXZGdyNjJKZG55NGVTaWFmMlM1?=
 =?utf-8?B?dFZQZmdhaktUNlZKdFRCNjcxZHBzdXNwekRFTFNremRybk5CM0pCSDk4SUIr?=
 =?utf-8?B?QlFHSUpkcFdFYXBUR0pBMTNMeFJoRnNDczMzL1NabGc5SFM1SEcrdFprNG9K?=
 =?utf-8?B?NW9vZC9PRXpiY1NTcFFxM1pOejNZeEx0aUlrRlZHalJueWtmNXpFNjV4enZE?=
 =?utf-8?B?TDB2Nm9SK05nZGtVMnRqR0VwTmg0cFRxTlcwK3RhazdPVjVuWGtBZkhDT3Jk?=
 =?utf-8?B?VzVSRWVoc1Nlc3YybG1yMU5xdHNRelEwYzJBVE40TXg4ZlVETVJPTDNRaXRR?=
 =?utf-8?B?WmtpOGZMcUp3R21nd3UrTDlNaHQrc3hnMTBROVlNMkVaVkRvZXM4bnk2Y1dm?=
 =?utf-8?B?bXpVVlVBYVFqVXkrR0o4UWN1R3JvTVlGN3RaVjdlMUoyTnc4UzlzTUJtTW1i?=
 =?utf-8?B?NVJwcnFpV3MwYk1oNW51L2xGaVdSRlptbmdrYUR6VHB1NTFic1A2N3I1U1ZS?=
 =?utf-8?B?M3hrSi8yMjg4bW9MMGF4QTNoWGVicE8rOGZ2K3JPV1VPYUF0MFNlVjNWSUxU?=
 =?utf-8?B?TnBDOUkwUEhIWWtqV3FOWXV4RkNDbmk3S2NYM0t0d0VPN2VnaE8zcUxWRHFE?=
 =?utf-8?B?SDFVLytsMzIyeU1tbVdqTHdXVW1OTjNvSTZxMnViTkNJQ2taUjErZjlPM0Zi?=
 =?utf-8?B?RTY3cUtZbTBXVUsxNWhGZ2VrMm91WDM3K1B0bXhSQ2pvTkJtckg0MVUzaDVK?=
 =?utf-8?B?NjUrMnNLNWoyYXRhZ0NSYTkweWVwSG1vZ2VOcUpJOURLclNtODNBV3lJREhQ?=
 =?utf-8?B?NElHZUNZMFdSLytDTDFRaHpHWTJPWk5EZTM3VFJHSUdWNlZuOW02eEQxVnRY?=
 =?utf-8?B?L0VVc1FSMURqT0JQbjdGYmluSTNjM3ljL0dQR0RaVXlTRDZ2MzV5N3lBdCtp?=
 =?utf-8?Q?W0ODIEs4f0L5YUx6kjYYTVWlN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 795bf110-3ce7-41eb-48e9-08db3b3649fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 09:14:15.8397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /vCq3mYFTI9DoLkdRTIL0RoIvx1p9Vols77bhJkpqP9yeqSyNa+MSymbYVvviBlvkibbzfe6YuoRK6d9N3TVxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6681
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIFR1ZSwgQXByIDExLCAyMDIzIGF0IDA0OjU4OjIyUE0gKzAyMDAsIFVsYWR6aXNsYXUg
UmV6a2kgd3JvdGU6DQo+ID4gT24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgMDI6NDI6MjdQTSArMDAw
MCwgWmhhbmcsIFFpYW5nMSB3cm90ZToNCj4gPiA+ID4gPiBDdXJyZW50bHksIGluIGtmcmVlX3Jj
dV9zaHJpbmtfc2NhbigpLCB0aGUgZHJhaW5fcGFnZV9jYWNoZSgpIA0KPiA+ID4gPiA+IGlzIGV4
ZWN1dGVkIGJlZm9yZSBrZnJlZV9yY3VfbW9uaXRvcigpIHRvIGRyYWluIHBhZ2UgY2FjaGUsIGlm
IA0KPiA+ID4gPiA+IHRoZSBibm9kZSBzdHJ1Y3R1cmUncy0+Z3Bfc25hcCBoYXMgZG9uZSwgdGhl
IGt2ZnJlZV9yY3VfYnVsaygpIA0KPiA+ID4gPiA+IHdpbGwgZmlsbCB0aGUgcGFnZSBjYWNoZSBh
Z2FpbiBpbiBrZnJlZV9yY3VfbW9uaXRvcigpLCB0aGlzIA0KPiA+ID4gPiA+IGNvbW1pdCBhZGQg
YSBjaGVjayBmb3Iga3JjcCANCj4gPiA+ID4gPiBzdHJ1Y3R1cmUncy0+YmFja29mZl9wYWdlX2Nh
Y2hlX2ZpbGwgaW4gcHV0X2NhY2hlZF9ibm9kZSgpLCBpZiANCj4gPiA+ID4gPiB0aGUga3JjcCBz
dHJ1Y3R1cmUncy0+YmFja29mZl9wYWdlX2NhY2hlX2ZpbGwgaXMgc2V0LCBwcmV2ZW50IHBhZ2Ug
Y2FjaGUgZ3Jvd2luZyBhbmQgZGlzYWJsZSBhbGxvY2F0ZWQgcGFnZSBpbiBmaWxsX3BhZ2VfY2Fj
aGVfZnVuYygpLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFpxaWFuZyA8
cWlhbmcxLnpoYW5nQGludGVsLmNvbT4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+TXVjaCBpbXByb3Zl
ZCEgIEJ1dCBzdGlsbCBzb21lIHF1ZXN0aW9ucyBiZWxvdy4uLg0KPiA+ID4gPiA+DQo+ID4gPiA+
ID4JCQkJCQkJVGhhbngsIFBhdWwNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+
ICBrZXJuZWwvcmN1L3RyZWUuYyB8IDQgKysrLQ0KPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gZGlm
ZiAtLWdpdCBhL2tlcm5lbC9yY3UvdHJlZS5jIGIva2VybmVsL3JjdS90cmVlLmMgaW5kZXggDQo+
ID4gPiA+ID4gY2MzNGQxM2JlMTgxLi45ZDlkMzc3MmNjNDUgMTAwNjQ0DQo+ID4gPiA+ID4gLS0t
IGEva2VybmVsL3JjdS90cmVlLmMNCj4gPiA+ID4gPiArKysgYi9rZXJuZWwvcmN1L3RyZWUuYw0K
PiA+ID4gPiA+IEBAIC0yOTA4LDYgKzI5MDgsOCBAQCBzdGF0aWMgaW5saW5lIGJvb2wgIA0KPiA+
ID4gPiA+IHB1dF9jYWNoZWRfYm5vZGUoc3RydWN0IGtmcmVlX3JjdV9jcHUgKmtyY3AsDQo+ID4g
PiA+ID4gIAlzdHJ1Y3Qga3ZmcmVlX3JjdV9idWxrX2RhdGEgKmJub2RlKSAgew0KPiA+ID4gPiA+
ICsJaWYgKGF0b21pY19yZWFkKCZrcmNwLT5iYWNrb2ZmX3BhZ2VfY2FjaGVfZmlsbCkpDQo+ID4g
PiA+ID4gKwkJcmV0dXJuIGZhbHNlOw0KPiA+ID4gPiA+DQo+ID4gPiA+ID5UaGlzIHdpbGwgbWVh
biB0aGF0IHVuZGVyIGxvdy1tZW1vcnkgY29uZGl0aW9ucywgd2Ugd2lsbCBrZWVwIA0KPiA+ID4g
PiA+emVybyBwYWdlcyBpbiAtPmJrdmNhY2hlLiAgQWxsIGF0dGVtcHRzIHRvIHB1dCBzb21ldGhp
bmcgdGhlcmUgd2lsbCBmYWlsLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID5UaGlzIGlzIHByb2JhYmx5
IG5vdCBhbiBpc3N1ZSBmb3Igc3RydWN0dXJlcyBjb250YWluaW5nIGFuIA0KPiA+ID4gPiA+cmN1
X2hlYWQgdGhhdCBhcmUgcGFzc2VkIHRvIGtmcmVlX3JjdShwLCBmaWVsZCksIGJ1dCBkb2Vzbid0
IA0KPiA+ID4gPiA+dGhpcyBtZWFuIHRoYXQNCj4gPiA+ID4gPmtmcmVlX3JjdV9taWdodHNsZWVw
KCkgdW5jb25kaXRpb25hbGx5IGludm9rZXMgc3luY2hyb25pemVfcmN1KCk/DQo+ID4gPiA+ID5U
aGlzIGNvdWxkIHNlcmlvdXNseSBzbG93IHVwIGZyZWVpbmcgdW5kZXIgbG93LW1lbW9yeSANCj4g
PiA+ID4gPmNvbmRpdGlvbnMsIHdoaWNoIG1pZ2h0IGV4YWNlcmJhdGUgdGhlIGxvdy1tZW1vcnkg
Y29uZGl0aW9ucy4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoYW5rcyBmb3IgbWVudGlvbmluZyB0aGlz
LCBJIGRpZG4ndCB0aGluayBvZiB0aGlzIGJlZm9yZfCfmIouDQo+ID4gPiA+IA0KPiA+ID4gPiA+
DQo+ID4gPiA+ID5JcyB0aGlzIHJlYWxseSB3aGF0IHdlIHdhbnQ/ICBaZXJvIGNhY2hlZCByYXRo
ZXIgdGhhbiBqdXN0IGZld2VyIGNhY2hlZD8NCj4gPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+
ID4NCj4gPiA+ID4gPiAgCS8vIENoZWNrIHRoZSBsaW1pdC4NCj4gPiA+ID4gPiAgCWlmIChrcmNw
LT5ucl9ia3Zfb2JqcyA+PSByY3VfbWluX2NhY2hlZF9vYmpzKQ0KPiA+ID4gPiA+ICAJCXJldHVy
biBmYWxzZTsNCj4gPiA+ID4gPiBAQCAtMzIyMSw3ICszMjIzLDcgQEAgc3RhdGljIHZvaWQgZmls
bF9wYWdlX2NhY2hlX2Z1bmMoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiA+ID4gPiA+ICAJ
aW50IGk7DQo+ID4gPiA+ID4gIA0KPiA+ID4gPiA+ICAJbnJfcGFnZXMgPSBhdG9taWNfcmVhZCgm
a3JjcC0+YmFja29mZl9wYWdlX2NhY2hlX2ZpbGwpID8NCj4gPiA+ID4gPiAtCQkxIDogcmN1X21p
bl9jYWNoZWRfb2JqczsNCj4gPiA+ID4gPiArCQkwIDogcmN1X21pbl9jYWNoZWRfb2JqczsNCj4g
PiA+ID4gPiAgDQo+ID4gPiA+ID4gIAlmb3IgKGkgPSAwOyBpIDwgbnJfcGFnZXM7IGkrKykgew0K
PiA+ID4gPiA+DQo+ID4gPiA+ID5JIGFtIHN0aWxsIGNvbmZ1c2VkIGFzIHRvIHdoeSB3ZSBzdGFy
dCAiaSIgYXQgemVybyByYXRoZXIgdGhhbiANCj4gPiA+ID4gPmF0DQo+ID4gPiA+ID4tPm5yX2Jr
dl9vYmpzLiAgV2hhdCBhbSBJIG1pc3NpbmcgaGVyZT8NCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+
ID4gPiBObywgeW91IGFyZSByaWdodCwgSSBtaXNzZWQgdGhpcyBwbGFjZS4gDQo+ID4gPiA+IA0K
PiA+ID4gPiAtLS0gYS9rZXJuZWwvcmN1L3RyZWUuYw0KPiA+ID4gPiArKysgYi9rZXJuZWwvcmN1
L3RyZWUuYw0KPiA+ID4gPiBAQCAtMjkwOCw2ICsyOTA4LDggQEAgc3RhdGljIGlubGluZSBib29s
ICANCj4gPiA+ID4gcHV0X2NhY2hlZF9ibm9kZShzdHJ1Y3Qga2ZyZWVfcmN1X2NwdSAqa3JjcCwN
Cj4gPiA+ID4gICAgICAgICBzdHJ1Y3Qga3ZmcmVlX3JjdV9idWxrX2RhdGEgKmJub2RlKSAgew0K
PiA+ID4gPiArICAgICAgIGlmIChhdG9taWNfcmVhZCgma3JjcC0+YmFja29mZl9wYWdlX2NhY2hl
X2ZpbGwpKQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ID4gPg0K
PiA+ID4gPlRoaXMgaXMgYnJva2VuLCB1bmZvcnR1bmF0ZWx5LiBJZiBhIGxvdyBtZW1vcnkgY29u
ZGl0aW9uIHdlIGZpbGwgDQo+ID4gPiA+ZmlsbCBhIGNhY2hlIHdpdGggYXQgbGVhc3Qgb25lIHBh
Z2UgYW55d2F5IGJlY2F1c2Ugb2Ygd2UgZG8gbm90IA0KPiA+ID4gPndhbnQgdG8gaGl0IGEgc2xv
dyBwYXRoLg0KPiA+ID4gDQo+ID4gPiBUaGFua3MgcmVtaW5kLCBwbGVhc2UgaWdub3JlIG15IHY0
IHBhdGNoLCAgIGhvdyBhYm91dCB0aGUgZm9sbG93aW5nPw0KPiA+ID4gDQo+ID4gPiBkaWZmIC0t
Z2l0IGEva2VybmVsL3JjdS90cmVlLmMgYi9rZXJuZWwvcmN1L3RyZWUuYyBpbmRleCANCj4gPiA+
IDQxZGFhZTMyMzliNS4uZTJlODQxMmU2ODdmIDEwMDY0NA0KPiA+ID4gLS0tIGEva2VybmVsL3Jj
dS90cmVlLmMNCj4gPiA+ICsrKyBiL2tlcm5lbC9yY3UvdHJlZS5jDQo+ID4gPiBAQCAtMzIzOCw2
ICszMjM4LDkgQEAgc3RhdGljIHZvaWQgZmlsbF9wYWdlX2NhY2hlX2Z1bmMoc3RydWN0IHdvcmtf
c3RydWN0ICp3b3JrKQ0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgZnJlZV9wYWdlKCh1
bnNpZ25lZCBsb25nKSBibm9kZSk7DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICBicmVh
azsNCj4gPiA+ICAgICAgICAgICAgICAgICB9DQo+ID4gPiArDQo+ID4gPiArICAgICAgICAgICAg
ICAgaWYgKGF0b21pY19yZWFkKCZrcmNwLT5iYWNrb2ZmX3BhZ2VfY2FjaGVfZmlsbCkpDQo+ID4g
PiArICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiA+ICAgICAgICAgfQ0KPiA+IEl0
IGRvZXMgbm90IGZpeCBhbiAiaXNzdWUiIHlvdSBhcmUgcmVwb3J0aW5nLiBrdmZyZWVfcmN1X2J1
bGsoKSANCj4gPiBmdW5jdGlvbiBjYW4gc3RpbGwgZmlsbCBpdCBiYWNrLiBJTUhPLCB0aGUgc29s
dXRpb24gaGVyZSBpcyB0byANCj4gPiBkaXNhYmxlIGNhY2hlIGlmIGEgbG93IG1lbW9yeSBjb25k
aXRpb24gYW5kIGVuYWJsZSBiYWNrIGxhdGVyIG9uLg0KPiA+IA0KPiA+IFRoZSBjYWNoZSBzaXpl
IGlzIGNvbnRyb2xsZWQgYnkgdGhlIHJjdV9taW5fY2FjaGVkX29ianMgdmFyaWFibGUuIFdlIA0K
PiA+IGNhbiBzZXQgaXQgdG8gMSBhbmQgcmVzdG9yZSBpdCBiYWNrIHRvIG9yaWdpbmFsIHZhbHVl
IHRvIG1ha2UgdGhlIA0KPiA+IGNhY2hlIG9wZXJhdGluZyBhcyBiZWZvcmUuDQo+IA0KPiBJdCB3
b3VsZCBiZSBiZXN0IHRvIHVzZSBhIHNlY29uZCB2YXJpYWJsZSBmb3IgdGhpcy4gIFVzZXJzIG1p
Z2h0IGdldCANCj4gYW5ub3llZCBpZiB0aGVpciBjaGFuZ2VzIHRvIHJjdV9taW5fY2FjaGVkX29i
anMgZ290IG92ZXJ3cml0dGVuIG9uY2UgDQo+IHRoaW5ncyBnb3Qgc2V0IGJhY2sgdG8gbm9ybWFs
IG9wZXJhdGlvbi4NCj4gDQo+QWdyZWUuIFNvIHdlIGRvIG5vdCBtYWtlIGl0IHZpc2libGUgb3Zl
ciBzeXNmcyBpbnRlcmZhY2UgZm9yIHVzZXIgdGhhdCB3ZSBtYW5pcHVsYXRlIGl0Lg0KPg0KPg0K
DQoNClRoZSByY3VfbWluX2NhY2hlZF9vYmpzIGlzIHJlYWQtb25seSwgVXNlcnMgY2Fubm90IGJl
IHNldCByY3VfbWluX2NhY2hlZF9vYmpzIGR5bmFtaWNhbGx5LiANCg0KLXItLXItLXItLSAxIHJv
b3Qgcm9vdCA0LjBLIEFwciAxMiAwMTowOCByY3VfbWluX2NhY2hlZF9vYmpzDQoNCmRpZmYgLS1n
aXQgYS9rZXJuZWwvcmN1L3RyZWUuYyBiL2tlcm5lbC9yY3UvdHJlZS5jDQppbmRleCA0MWRhYWUz
MjM5YjUuLjBlOWY4MzU2MjgyMyAxMDA2NDQNCi0tLSBhL2tlcm5lbC9yY3UvdHJlZS5jDQorKysg
Yi9rZXJuZWwvcmN1L3RyZWUuYw0KQEAgLTI5MDksNyArMjkwOSw4IEBAIHB1dF9jYWNoZWRfYm5v
ZGUoc3RydWN0IGtmcmVlX3JjdV9jcHUgKmtyY3AsDQogICAgICAgIHN0cnVjdCBrdmZyZWVfcmN1
X2J1bGtfZGF0YSAqYm5vZGUpDQogew0KICAgICAgICAvLyBDaGVjayB0aGUgbGltaXQuDQotICAg
ICAgIGlmIChrcmNwLT5ucl9ia3Zfb2JqcyA+PSByY3VfbWluX2NhY2hlZF9vYmpzKQ0KKyAgICAg
ICBpZiAoKGF0b21pY19yZWFkKCZrcmNwLT5iYWNrb2ZmX3BhZ2VfY2FjaGVfZmlsbCkgJiYga3Jj
cC0+bnJfYmt2X29ianMpIHx8DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGtyY3At
Pm5yX2Jrdl9vYmpzID49IHJjdV9taW5fY2FjaGVkX29ianMpDQogICAgICAgICAgICAgICAgcmV0
dXJuIGZhbHNlOw0KDQogICAgICAgIGxsaXN0X2FkZCgoc3RydWN0IGxsaXN0X25vZGUgKikgYm5v
ZGUsICZrcmNwLT5ia3ZjYWNoZSk7DQoNCg0KdGhvdWdodHM/DQoNClRoYW5rcw0KWnFpYW5nDQoN
Cg0KPg0KPi0tDQo+VWxhZHppc2xhdSBSZXpraQ0K
