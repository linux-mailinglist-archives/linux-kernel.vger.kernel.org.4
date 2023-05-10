Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E026FE469
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 21:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235547AbjEJTP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 15:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjEJTPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 15:15:55 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49012705;
        Wed, 10 May 2023 12:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683746154; x=1715282154;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CJYAgZNn1a7T0+yRFGUc8xT8EQPX6a0wT5RvbOZsgo0=;
  b=DuaHBFe7JzqXm377nkeqTOxubI23zlQeL9eDAm5mE8otQz7QoL8+Qad2
   QKHyPUa8Uo+45xmxiDG2YYhbZlHPvd7krHU6weHD3Jqud4pYuUpxjxjp+
   oKU8muArolIkGx4ZAFzNDMmyFpAfB2+QGSmi4QO6Cc6QsOkuoUPUP2u8D
   njpZrGN12pXy3PGbFIu6HzPiF+HNF6XyabJ/W+O1GaezFfDDYUmZZDfld
   swBF7IHUJziAP9QzAL9a0s+6mZLbtOWeeQVInYLWnlsCwKqJX91C+cv6p
   emag5JJbaFiuBXCWiTlqBpyf8dg1M+UQhffHDylLdLQSD0aYlGGVI0sf/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="415878161"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="415878161"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 12:15:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="823642733"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="823642733"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 10 May 2023 12:15:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 10 May 2023 12:15:52 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 10 May 2023 12:15:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 10 May 2023 12:15:52 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 10 May 2023 12:15:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLtNizLz8hwTU/nkHEiLSTGaczeHNpBH8KmC8UAlEv7hboCFsWSOHhvAjpBSs2Ct3ScCICcPgK7wAL6RNVYTFRuoS7/fGAwLGvQ8cc6p3wChAmezNQmD/keAO+WEWowrPmzVl4BM+3/s4U81biSXeaRt0p8wq8aISGqXlyVhYgT28CoY3wDw3d9C/mMBvDNHVncG5xc69JkSUp8G7W/InfGDscaPX4nkYg7Us1OjulK8TnHuj8xXyg8oamC0euyzN0Xv3oUQRGCf2v55cJrOOl8HlUREkrnlMmwCOtL5wTej7wHMOW1m1fuqrtbvl5ioJ5h1Ia+FaHSqGyMufG/0vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJYAgZNn1a7T0+yRFGUc8xT8EQPX6a0wT5RvbOZsgo0=;
 b=XcfJ3G/wtbdYRmLNWqY47JBY9/tabZ7drILK4CnFCyqL8lpCncZ1OrcOI8ccKIxxB/Tq1mSzZT9j2B6zSyO788dxDcJQts4h5Daxgzvpl8hkyUbH1+X7OBVS1Oh8ultNzrNw2kOhWbLVdmWRjK25NTWhAvzuCMHq1kp5VsrPDKyENhLPQ1Xz41JvN/sMQcxmCr8GUAOnT3TdlpMVIMqoeKIyC104GhpgNN9vZbsBOzDDWUoHZwo2JR3ZHzWMWkShGMNewPh7vGUU62zW/80B4jFFkP8o3vjDrP2Erlh7yERpeUc3tZsUDb2BFdc0hg/zxGOyN5EEipO4cDUM/v729A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH3PR11MB7347.namprd11.prod.outlook.com (2603:10b6:610:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Wed, 10 May
 2023 19:15:50 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302%6]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 19:15:50 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Brown, Len" <len.brown@intel.com>, Borislav Petkov <bp@suse.de>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [tip: perf/core] x86/cpu: Add helper function to get the type of
 the current hybrid CPU
Thread-Topic: [tip: perf/core] x86/cpu: Add helper function to get the type of
 the current hybrid CPU
Thread-Index: AQHZf3Co1LmNVPm5sU2/JATrjEENgK9T2LGAgAAETwCAAAgdYA==
Date:   Wed, 10 May 2023 19:15:50 +0000
Message-ID: <SJ1PR11MB608339696C47C46DFF932E72FC779@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <1618237865-33448-3-git-send-email-kan.liang@linux.intel.com>
 <161891560955.29796.10811256921836669612.tip-bot2@tip-bot2>
 <55343361-d991-c157-4a88-843947aa45ff@intel.com>
 <20230510181815.GA18418@ranerica-svr.sc.intel.com>
 <25fe5313-97de-1528-e13e-f3b6286a8385@intel.com>
In-Reply-To: <25fe5313-97de-1528-e13e-f3b6286a8385@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH3PR11MB7347:EE_
x-ms-office365-filtering-correlation-id: de9cab3e-ff5d-4293-6b8d-08db518af7b7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cYwWbLuybzHl5WUjUZ9uyYp+rs2P2XnUV6AGlUPUj65U1/6S5mU6WBEd8BZagrX9FHnazDgvZLbI0gaY/7uG5fF/CY3IrFWpYeTDcHQmqVrc7iS7aKew40o55O5YMsHxNJZ52PKHTiJZWkn0jCUA6DrgcO135sLglvBzjQyOYhplE3e6oLUBhh8mqZrehwC172WfcIgF63HIWKaQ6DN3xHmA7jAlA7IGUD/aF8GtyYQViC0babKZnqyrvr29vrPz19r+msbxeKqluLxe38/+Rnokcr7ZH8+meqRSJxeG3an0hhNgwLShU8fK4IyEGNNj/w8Fsyjgvg6EGft7ak8tLCq9Rw4NpXnymJIlGmEQ+ry2lR220W5jvn0a6aku70JWQ3zN+z+9BNBun8d8UAd2tKcib21WUEzz7SiC7faYqTKTMe1An+jYh0s/XGYLgcgJtV+tsfV+vI/0NJQ7GsnTt+zyOHT9oik4pdefjj/jlOeIejPdb1NoAYp+eKWx50MrQle9vSHHDFBMxxhqE8rukSg2XTKypr+u/pLxHLH5VhafJnAc656qZE5ZT4o6tK+lA5fMC2ALpW31aa0wY4KiApBiGAJ0bXb2S+kmQpyey5etwcHjt9vCKh4Ak+rcRkCr1ZWQpsesH+voGgif78DdPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(9686003)(2906002)(186003)(66946007)(66556008)(4326008)(4744005)(66446008)(66476007)(64756008)(316002)(71200400001)(41300700001)(76116006)(54906003)(110136005)(6506007)(52536014)(478600001)(26005)(5660300002)(8676002)(7696005)(8936002)(55016003)(38070700005)(38100700002)(122000001)(82960400001)(86362001)(33656002)(15583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RS9qMmttZWtvVEViSm1SV0tZZDB1R1VqcjhZM1YwS2k2OFVLbENHU2ppb25Q?=
 =?utf-8?B?UWFIMHZsWEs0clNGNG5NTHk3TVRNL3RUcGhqbThBd2NaK3kxU3h2UU45MHRs?=
 =?utf-8?B?LzVqSzROdjI5QnVvdUFyN2M0RGNiemRBMmVISnQ3L1hkeWRVcVZ2WnpOZzJB?=
 =?utf-8?B?UzlkUE84cGUyMzNNQTFRbWVpc1d0dGM2OHNTK1ZqWmM2cFpiUUY4akV1M3Rq?=
 =?utf-8?B?V3N0OTdRSmk2Wkx5dUR2YUFJcS9JMGFTRFozT3V0MVZqTWUwYzJaa1Zsd2d2?=
 =?utf-8?B?S0xIaVcwaDMzQXBSV3RGbG12YkhqczlyKzhxYlVXMHZiRW9DVXIrZ09acTI2?=
 =?utf-8?B?dVZZcUxEbWU4dHVsbWRzY2tQOS96YVlMVVBhQUVnNS96czFPMVdRVkdTelQy?=
 =?utf-8?B?S1lsVkdULzVVb2lobEJLR2VtMUpxVW8xbGZQZHJFUG5GQUl2STJXMHNDT0w2?=
 =?utf-8?B?ZzAwVDlRTVRwcnZ5NnRPeXYwWlB6U3RHMFNUYStJWW9MOTBZSW9VVUluRUFr?=
 =?utf-8?B?VkVZUHl4VDl5WklxMmJzQlRmUEJpS0VzMDlxVlNqRXQyQjhaRlpJVXJpVGN3?=
 =?utf-8?B?QkZZVysraE5Qbjg1YWhMYlFRMkJSWVh1RkVMeUthbzNvVExuRldGV0cxRmd3?=
 =?utf-8?B?MVdPamNGUFF5TGMrUEtZQWEyMllzajl2MDJtcVNRMnZ3QjZoWldIcUQxOTMy?=
 =?utf-8?B?OVl0ZU9LbTJKQUpaSU8zL05Ba3poUW44Zk11NmJ1TzFDR3IxL0JYOUNTQVJK?=
 =?utf-8?B?NEk4b0FMVlBhWERDcW53N3NGMXR0R0taQVo2cmNzRWMwUGRVTkZBdnRjcnlr?=
 =?utf-8?B?T2FYa0dDZkJSQlM0QjFpODJDeUptczVxa3g2c3dEc3lVSmpqTXdjUG5ON3Vy?=
 =?utf-8?B?bDA0S04vZGcxcmFvN2l2dWdzSUFpdHF0SnpMb2tqRExRUGFuTEw1ZHBhMVJj?=
 =?utf-8?B?UVNwMlJPUXFwMVRqcDNUd3ZiUk1mUm9sV2ZaZFJ4cE5CVmw5aU1ZaVNYNktO?=
 =?utf-8?B?V01jQ3VaTUJidkJkc05zNFZiRE1SVTZ3TTlsYVdSNHZ5OUtBZ3FObXVOcGY5?=
 =?utf-8?B?dEhPTkp0REdwc0UrMmtrTkhibzkwWVJlUnd1ZFRXVnNJNXNPOW1PZTVTUHpP?=
 =?utf-8?B?dDF0OGh5Y2NzTDFMNUcvWmROa2RnWjhVVTFMOUZzMUhtUHpQbVFiRkIxcHZa?=
 =?utf-8?B?aTBNR0kydFdydWhSNXkvaVMvYmZuTTdwblVGQTFmbHNQSHliSWEwQWM2SnR2?=
 =?utf-8?B?YTlyWGZ4SkJmQThqSmlWQ2UwK3JlUGpaNHNJRUNpbHdUZTBLY1lBU2tiMFNZ?=
 =?utf-8?B?RUVXVW5tYjZ5Uzd5aVdSSlJoM09WU2NsVndJSkRnVm8wNmVwSDF3ODhkUWEr?=
 =?utf-8?B?K3N4dWxGaHI0UkNVTWxpZmZhdFdHWlU1WjV3eHRDVWNmT2FOV2hhdFlZMVh5?=
 =?utf-8?B?b2tWZUp4MHRpakdhYUFmL2hsQnRkRmoyK3JMWmQveXgrb0lzTE0zZTM0cTJ0?=
 =?utf-8?B?Y0NscWRKSEZPSXVReGRjZXQwdEFId2dRSTdqbVRKZmIzY2N0Q1NmQ0FaWE9q?=
 =?utf-8?B?R2NMaFRrVFg2WHNmSVkwMFg4ZlBrUkI3SGhBSzh2SG4rVUY1UGtQWXhadlQ1?=
 =?utf-8?B?VU44Z0hLQWVMWnFxSGpLa0svM1lsUTkzeVpmRWVublY1T0pTNVAxMXFLTFdE?=
 =?utf-8?B?MGI3MkhJdVpraTNIYUI2bHIwMmFnaGlnV3RHeTNPYllQS2tkUnZMSUpsbUh1?=
 =?utf-8?B?OW5HRURYU3ZrK1F4S0N2Y1dZMzVGbzVsQ0N3TVNmWjd6SWg0TzVCV0Fpdnda?=
 =?utf-8?B?RkFHNmhGV21IS2FnWU13TE5zWlYrVUYrMVN6M0oyYmtaL1VPUnNZbnMzNmZQ?=
 =?utf-8?B?aXgxVkdaMzBndk1JdkdyK0d4NTVYUDhqTGVJcjkxaFBWMFNSbzIyUU1OS2pL?=
 =?utf-8?B?T1UwMk94TFRsODkvNXlsRWJUdEdoU1JQSjZNWVlvRHBqMlNDUFdKbk5CV0hX?=
 =?utf-8?B?dWIwUzREcGhIY0tlQmFXazBsL252SVZDNDRPMVJFMXZBK0dKSkp4UU0yMkRU?=
 =?utf-8?B?L3hiU0dMSUlQWmdEZEpPOG11NUZHa3Y2THBpTWhLSUZ1eXcrN1FSTkNNcjF1?=
 =?utf-8?Q?4srU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de9cab3e-ff5d-4293-6b8d-08db518af7b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 19:15:50.6378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q64zthb7YM/nRyxLHjgkFVsvbNaYxqvG7LYNxUIdaCZEOMYX300+baKd8+ABrvy+uSUNznrlK+aPyaWXjDHo8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7347
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJIHJlYWQgdGhlIFNETSBhZ2Fpbi4gSXQgc2VlbXMgdGhhdCBjcHVpZF9lYXgoMHgwMDAwMDAx
YSkgYWxyZWFkeSByZXR1cm5zDQo+IDAgd2hlbiB0aGUgbGVhZiBkb2VzIG5vdCBleGlzdC4NCg0K
UXVpY2sgY29ycmVjdGlvbi4gU0RNIHNheXMgdGhhdCByZWFkIG9mIGFuIHVuaW1wbGVtZW50ZWQg
bGVhZiB3aWxsIHJldHVybiAwIGluIGFsbCByZWdpc3RlcnMNCmlmIHRoZSBsZWFmIHlvdSB0cnkg
dG8gcmVhZCBpcyBub3QgdGhlIGhpZ2hlc3Qgb25lLiBCdXQgaWYgeW91IHRyeSB0byByZWFkIGEg
bGVhZiBoaWdoZXIgdGhhbiB0aGUNCmhpZ2hlc3QgaW1wbGVtZW50ZWQgb24sIHRoZW4gQ1BVSUQg
cmV0dXJucyBkYXRhIGZyb20gdGhlIGhpZ2hlc3QgaW1wbGVtZW50ZWQgbGVhZi4NCg0KRS5nLiBt
eSBDTFggc3lzdGVtIG9ubHkgZ29lcyB1cCB0byBsZWFmIDB4MTYuIFNvLCBvbiBteSBzeXN0ZW0s
IGNwdWlkX2VheCgweDAwMDAwMDFhKQ0Kd291bGQgcmV0dXJuIDB4MDAwMDBjZTQNCg0KLVRvbnkN
Cg==
