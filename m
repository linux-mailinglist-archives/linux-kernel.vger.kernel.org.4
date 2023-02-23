Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754D26A0BE3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 15:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbjBWO34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 09:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbjBWO3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:29:53 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B333D54540;
        Thu, 23 Feb 2023 06:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677162592; x=1708698592;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nw+RzkqdVDRM+DhW3mrGD8hhiI1PcVrerBa/1dzwEX8=;
  b=dO+qYqxHoTKddzaiuEuHSPB1QSNfhzpXj3+CztLHNhHEC9/RryKIhiTi
   IftDHsVeEUZjUe93gK4mbhMWy05zSovQqlnDKSfFMaLoIphRb53hoZ9Iw
   T2sUTXEgvMs9AAOjfKLL/0ihZ6PcSkvoW57A9DPW9DNugNp4WgBvmXVTo
   61/e+esTXvx0CM4Dc4JvI4OkKo/FVOdxfus7hzOSByL1J8Zs9RzkhB27A
   6Xu/kcEEG4ffEHhtvtOnKpXZtdM6iDqiVWU8GIpVj/q0WMYdSZHuqQRxC
   TL3qpQ00HIu7DX9speIwm+tznE4U9Gi2+EDio6Yi8rGZBDodYWvtez+VP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="312854673"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="312854673"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 06:29:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="796331550"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="796331550"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 23 Feb 2023 06:29:51 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Feb 2023 06:29:51 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Feb 2023 06:29:51 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 23 Feb 2023 06:29:51 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 23 Feb 2023 06:29:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJgRJ/IQo9iys1DiGVr8dHd3CZUrpFsCtAJjz9EsM8LfYw7sepPLB87wbVdmRmmXvhwgqT/iG1hepH5ugNUUGv7oFEFuRxa3+bRmAzoDjSDV7P3howlj82qzP4h+zmVkfR7x8F4Po0utH8AoTdndCFgxtwqWfDmHGUa9gavPYJYmqN38W4qNbYKNkZ3wISZ5W4Drm47wtF0EoD6KvD0dV28uoRgGzv9v1HcTnQG0VN50ji4BW3mvy3ab70Ny2gB34YqCf98+dTC9nezXlUey33/P8rUHa9WDrgR6dm9x6ft1bycDf1VqdaeqSoe3mcdLkhMnXYfpMdNHOTkUfEejHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nw+RzkqdVDRM+DhW3mrGD8hhiI1PcVrerBa/1dzwEX8=;
 b=TEoORkTEVMUKp5JGXAEqERgEdpQFaIs5G1Y//Vt9Ls6FyGwMYJwHcMEv/0BEEbLMjDqT29u8ORevKv5ecXCP1xYBrA2rxphcO8+3DM+Ref+w1wd73Oypwo4hMo5Hl4LYb2rGEnom4o5P75rd+s6pvrsbzo4eV6Izr9TO/tkQrL1znMI+1ds7TyQ2zGUnd4kbOlegJUTBZRxgHal/hKnOl+OpWrN2EbFuk2rwhRm+6w3dwAL4M8UVWUPP3s40ycT3FE4CjPgzsUp+StGxVIE2Os2GJwvfw4GWl63+rtmTrW0QGLMGK/Xe05dsFbKcxIUdVHR3e5wuVszez51HQLyyAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by PH8PR11MB6927.namprd11.prod.outlook.com (2603:10b6:510:225::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 14:29:49 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::b6d8:543f:3a43:6c56]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::b6d8:543f:3a43:6c56%8]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 14:29:42 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Oleksiy Avramchenko" <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Subject: RE: [PATCH 00/13] Rename k[v]free_rcu() single argument to
 k[v]free_rcu_mightsleep()
Thread-Topic: [PATCH 00/13] Rename k[v]free_rcu() single argument to
 k[v]free_rcu_mightsleep()
Thread-Index: AQHZNk9uglg6Dkc2okSOWjTl6mSFcq7cnMSAgAAai4A=
Date:   Thu, 23 Feb 2023 14:29:42 +0000
Message-ID: <IA1PR11MB6171CE257AC58265B8B7CC9889AB9@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <20230201150815.409582-1-urezki@gmail.com>
 <Y/df4xtTQ14w/2m4@lothringen>
In-Reply-To: <Y/df4xtTQ14w/2m4@lothringen>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: paulmck@kernel.org
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|PH8PR11MB6927:EE_
x-ms-office365-filtering-correlation-id: d07555ac-f153-4b6e-7253-08db15aa674f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zBYmipRO45lhYkZma2UwTFvjVc88EjFKsX9XaP/mvRJpWZ1G2f4JYlczfJBlI3ysegDrraR1iSZSQ4FmBwjpIzBrn8n8gPr1odsNTLdxYD8/Xl1sIqMfilbE2swiN2EnjPCI1QU4tO9+Axcfb3RU+5o7zzz9lTVfenYxM7EOFkjrH7qG7yS/vOn5jLPxmyvwTsjMoCIwMY45jHiunzfUOs9I4dzNDRTSlI/Q81nbDUHmklEQDTbi651DRD8dkPAD2jTPYE3Yv4y8qwvPVMrgQveZHloA2Q2evPhRIfZl6UAUjT9OGmDHOS0Qld8UclUuqYyu6SKKvHn+sZkAnnrNhxQXduMwUzBNFlvWSmSLZ9xacluz5lCGxEas68Y/VVUHmd0h/AZaE89NxWBBL4kZeDyBDR+rXaOgSxGSlBaU6G216Tf9OzDZP7HuU7GJeB26XlhR0VId6JRrcY03Q/N4AOcJX7OK/lz4ob1MwtuxBPD8fNxNHo+5pxvYL8Fq1mVLRcDRqOwSLao5lgcHL+C9m5wBZC9uH1Sru8KQwlWvXHlOJn/LjTHFjJwByABtey53IMisJJMrkxMoGuEUL/DFqfMINNaQcMXukL6HCca0Is7OwSEm2UFj9M7nV01GSOA/lqH6ig27a2jUmRXa/2NiRyryb5kWkWpLmOY8fPAoNUduLve0Pn39FZ0ivq/1Ms9O
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199018)(83380400001)(316002)(54906003)(110136005)(26005)(64756008)(478600001)(38100700002)(122000001)(82960400001)(2906002)(86362001)(66556008)(33656002)(66946007)(76116006)(66476007)(55016003)(38070700005)(4326008)(8676002)(66446008)(8936002)(52536014)(41300700001)(5660300002)(7416002)(966005)(7696005)(186003)(9686003)(6506007)(71200400001)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dU9pZjg2L3lEakNPTEgxN3M4RXNjU0krSHM1Z2tBZGZHZ3R2SHN1bU5WejV5?=
 =?utf-8?B?WW4zRXNHTXZQUGEyc0hHbmpYb0M5djVITjJYOE85TkNuU1Q2ZVBUOFhlZ2xF?=
 =?utf-8?B?clJkMVIwT3RqNXhpUFZhMVRtRjFwTnJsTmFURVpGM3dZT3Jqc3E1UXYvYVJK?=
 =?utf-8?B?RU12Wlg4SjhvQWtvSTEwMVBINlRDckxlU2p2ZW5kQUlwQ2x0ODg3empCblMy?=
 =?utf-8?B?SDdjV001bFYzaDh0V3BNcndjWTBQRHhVU2pCVmkweFp6SWtQcm1NTnlDOUVw?=
 =?utf-8?B?Mlh0S2RtNW1IRWM2ZnpmaGNZeXd4a1JMNGp6aTBoMzdpRDRLb0o1dUJHSWYr?=
 =?utf-8?B?SlV3Q1AvTDFUcjlHbTRVcG5QNDRXYlBNdVhUZUZwV1RNanJxVjUweC9URWZp?=
 =?utf-8?B?aDFnTlVHN3lVamxJMHovdS9lSStkZDF6RVdGR2NCeHFxL29IODJPclN2WDBn?=
 =?utf-8?B?empKQ3RIUHIzek1OdGdFbGdHRFd6WE9JbnVoT25DTWszalZLNjJHK0lYOTN0?=
 =?utf-8?B?clZRcmdHeTNkeDEyNDFKamwrdkYvdjR4azJvODFMMjErdzViYXUxUWd1cEdu?=
 =?utf-8?B?WDZUL0IvSndPZnNIN2lRQ1F5RWhrb2o2U0VvclhHRkE4S21manZRdFdZRDI2?=
 =?utf-8?B?S1RyVHluNzFEdnFkVHRvaTM4bDFYRk5YS1A1TFI0bDJlenkrcUp2UUtnYlc0?=
 =?utf-8?B?RkFIZ1JmZld5ZEYwc1laSzhHR08zZS93dThkd0ZBdTd4eEc5WWphZjNlYWRm?=
 =?utf-8?B?WFRtUldWYmU0cWRNQUNSaTZiZ0dZUVQ5L09oNDVKbzhpUStZcTdGZ0o1dEtB?=
 =?utf-8?B?NXZwSklpUGtzcDhwTXRxemUzcHk2WWV0N1pCRjFERTZ4Q2hjVDIrNXRENTRm?=
 =?utf-8?B?MzlRUm5YZkJCVitkM2NQaHdxVURoWjJ2bjJQSVZNVFFibTNjOHJYVXlDdDBv?=
 =?utf-8?B?S1ArM1ZORHdiS3dJUzhWNmFjVTcxNjJWSjBhVHN5aUZSNytzc3Q1aU5OS3Vu?=
 =?utf-8?B?ODVZMHVzQjh0aURxVHEzV1FXcVZYb3h1dTUyekxscXFPVE5oR3BwZEh4UHUv?=
 =?utf-8?B?aVpSMVBCVU1FckhUeHRQOS9pR1dpZ0pIOFRHYW00ZXZvY2cycTluQjFwcDNk?=
 =?utf-8?B?Ti9KMmw3cWV6VkxlRkFKOHAwd0FKK0hpU2J0VG1nLzFZSmpXRVdJQ3Q4Z0hL?=
 =?utf-8?B?WVk0c1FZaVQ4WWY5TklVcGdqa1V4ekVsTDV6aEJTaWhMciswckwyRWgzN21l?=
 =?utf-8?B?VU8wNzhBMUNWQkxhNXBQaFpWd3Z5NmJNL3prb1VFaXllY0dLeTl3UHQ3Q3J4?=
 =?utf-8?B?TGx2TjdOMjdac2p0M0FvaE9RVFd1QzRPOEwzVTFidldQd3czcS9zd3dlcm5J?=
 =?utf-8?B?a0lEYldNZUZuMXA4OTNQaEYvNG9xVG1GUmNMN3VzQVVyWjBJdzhSTndjbnVJ?=
 =?utf-8?B?alJEb3hYZW5JU2ZWVnIyQ0xrVU4vZWs3c3dXWFFydERtU0p1Z3MyamkxbFl0?=
 =?utf-8?B?UmtldThnRis3RHVVMzRVQkRpTjRJMmpTb3I2UW96aG9oRlB6bEt2dVZCK3gr?=
 =?utf-8?B?R1pyOEtBWGxROGZDM2J2K1Y5WmVOMXB6SmV4elRFNW1FYVpocll0MWo0cmRR?=
 =?utf-8?B?SXBia0JTd1IrU3lJOHFlNlFZeU5DenNWU3lqc1dxZjYveEx5bFQ0bzlGRUcv?=
 =?utf-8?B?UkQrMTlzZysvMFNZSlNKenRSMHVYZzVUUXNrd3k2aEFUdCt6ZUUyenI2aG9D?=
 =?utf-8?B?OWl2SUJ2bWtiQjRNaW44d0wrczlpaFJ6MlNUcFp6TlV6YnoybURDNzF0a2Fs?=
 =?utf-8?B?TFoydHRMYW81WCtHTzMzTEV5SmRWcTJVYWxERjVQUldZdmo4Zkd2N1dmMFF5?=
 =?utf-8?B?azhvbGR6b2dvcGFXeEhDcWhtUHIzU1ByK3MzVXBjZnowNkg5UlFkNDF6UkhV?=
 =?utf-8?B?QjdCaUxRQUtMT0RDZnJ1alI5OWg1eUNHaW9WRms3RWNoMGwwSnRXcFBqK09E?=
 =?utf-8?B?L1dkVHI5SndKZHRkRUxlYUVoZUlYaDJGS2NaQ3hVaVZiR08xdmtXVHgyM2RO?=
 =?utf-8?B?eHBQRFM3WlJEN1YveU5aU05OQ1UrTzBlRHBsdFZNVEZ4cGttREtUNnFYUVpk?=
 =?utf-8?Q?J7Eddj9GG1mVhjpEw6VtUdRRf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d07555ac-f153-4b6e-7253-08db15aa674f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 14:29:42.4628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4vIoEK5Jr+102NlWQRuq3L/kjgW+tMQhJZC+wL6vDqMwnB9Q2LHrcDzVndbN2nffC6owjyNpoKPzLPk/am7nrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6927
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBGcmVkZXJpYyBXZWlzYmVja2VyIDxmcmVkZXJpY0BrZXJuZWwub3JnPg0KPiBTZW50
OiBUaHVyc2RheSwgRmVicnVhcnkgMjMsIDIwMjMgODo0NSBQTQ0KPiBUbzogVWxhZHppc2xhdSBS
ZXpraSAoU29ueSkgPHVyZXpraUBnbWFpbC5jb20+DQo+IENjOiBMS01MIDxsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnPjsgUkNVIDxyY3VAdmdlci5rZXJuZWwub3JnPjsgUGF1bA0KPiBFIC4g
TWNLZW5uZXkgPHBhdWxtY2tAa2VybmVsLm9yZz47IE9sZWtzaXkgQXZyYW1jaGVua28NCj4gPG9s
ZWtzaXkuYXZyYW1jaGVua29Ac29ueS5jb20+OyBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+
OyBQaGlsaXBwDQo+IFJlaXNuZXIgPHBoaWxpcHAucmVpc25lckBsaW5iaXQuY29tPjsgQnJ5YW4g
VGFuIDxicnlhbnRhbkB2bXdhcmUuY29tPjsNCj4gU3RldmVuIFJvc3RlZHQgPHJvc3RlZHRAZ29v
ZG1pcy5vcmc+OyBFcmljIER1bWF6ZXQNCj4gPGVkdW1hemV0QGdvb2dsZS5jb20+OyBCb2IgUGVh
cnNvbiA8cnBlYXJzb25ocGVAZ21haWwuY29tPjsgQXJpZWwNCj4gTGV2a292aWNoIDxsYXJpZWxA
bnZpZGlhLmNvbT47IFRoZW9kb3JlIFRzJ28gPHR5dHNvQG1pdC5lZHU+OyBKdWxpYW4NCj4gQW5h
c3Rhc292IDxqYUBzc2kuYmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDAvMTNdIFJlbmFtZSBr
W3ZdZnJlZV9yY3UoKSBzaW5nbGUgYXJndW1lbnQgdG8NCj4ga1t2XWZyZWVfcmN1X21pZ2h0c2xl
ZXAoKQ0KPiANCj4gT24gV2VkLCBGZWIgMDEsIDIwMjMgYXQgMDQ6MDg6MDZQTSArMDEwMCwgVWxh
ZHppc2xhdSBSZXpraSAoU29ueSkgd3JvdGU6DQo+ID4gVGhpcyBzbWFsbCBzZXJpZXMgaXMgYmFz
ZWQgb24gUGF1bCdzICJkZXYiIGJyYW5jaC4gSGVhZCBpcw0KPiA+IDYwMDI4MTczNDhhMWM2MTBk
YzFiMWMwMWZmODE2NTRjZGVjMTJiZTQNCj4gPiBpdCByZW5hbWVzIGEgc2luZ2xlIGFyZ3VtZW50
IG9mIGtbdl1mcmVlX3JjdSgpIHRvIGl0cyBuZXcNCj4ga1t2XWZyZWVfcmN1X21pZ2h0c2xlZXAo
KSBuYW1lLg0KPiA+DQo+ID4gMS4NCj4gPiBUaGUgcHJvYmxlbSBpcyB0aGF0LCByZWNlbnRseSB3
ZSBoYXZlIHJ1biBpbnRvIGEgcHJlY2VkZW50IHdoZW4gYSB1c2VyDQo+ID4gaW50ZW5kZWQgdG8g
Z2l2ZSBhIHNlY29uZCBhcmd1bWVudCB0byBrZnJlZV9yY3UoKSBBUEkgYnV0IGZvcmdvdCB0byBk
bw0KPiA+IGl0IGluIGEgY29kZSBzbyBhIGNhbGwgYmVjYW1lIGFzIGEgc2luZ2xlIGFyZ3VtZW50
IG9mIGtmcmVlX3JjdSgpIEFQSS4NCj4gPg0KPiA+IDIuDQo+ID4gU3VjaCBtaXN0eXBpbmcgY2Fu
IGxlYWQgdG8gaGlkZGVuIGJhZ3Mgd2hlcmUgc2xlZXBpbmcgaXMgZm9yYmlkZGVuLg0KPiA+DQo+
ID4gMy4NCj4gPiBfbWlnaHRzbGVlcCgpIHByZWZpeCBnaXZlcyBtdWNoIG1vcmUgaW5mb3JtYXRp
b24gZm9yIHdoaWNoIGNvbnRleHRzIGl0DQo+ID4gY2FuIGJlIHVzZWQgZm9yLg0KPiA+DQo+ID4g
VWxhZHppc2xhdSBSZXpraSAoU29ueSkgKDEzKToNCj4gPiAgIHJjdS9rdmZyZWU6IEFkZCBrdmZy
ZWVfcmN1X21pZ2h0c2xlZXAoKSBhbmQga2ZyZWVfcmN1X21pZ2h0c2xlZXAoKQ0KPiA+ICAgZHJi
ZDogUmVuYW1lIGt2ZnJlZV9yY3UoKSB0byBrdmZyZWVfcmN1X21pZ2h0c2xlZXAoKQ0KPiA+ICAg
bWlzYzogdm13X3ZtY2k6IFJlbmFtZSBrdmZyZWVfcmN1KCkgdG8ga3ZmcmVlX3JjdV9taWdodHNs
ZWVwKCkNCj4gPiAgIHRyYWNpbmc6IFJlbmFtZSBrdmZyZWVfcmN1KCkgdG8ga3ZmcmVlX3JjdV9t
aWdodHNsZWVwKCkNCj4gPiAgIGxpYi90ZXN0X3ZtYWxsb2MuYzogUmVuYW1lIGt2ZnJlZV9yY3Uo
KSB0byBrdmZyZWVfcmN1X21pZ2h0c2xlZXAoKQ0KPiA+ICAgbmV0L3N5c2N0bDogUmVuYW1lIGt2
ZnJlZV9yY3UoKSB0byBrdmZyZWVfcmN1X21pZ2h0c2xlZXAoKQ0KPiA+ICAgUkRNQS9yeGU6IFJl
bmFtZSBrZnJlZV9yY3UoKSB0byBrZnJlZV9yY3VfbWlnaHRzbGVlcCgpDQo+ID4gICBuZXQvbWx4
NTogUmVuYW1lIGtmcmVlX3JjdSgpIHRvIGtmcmVlX3JjdV9taWdodHNsZWVwKCkNCj4gPiAgIGV4
dDQvc3VwZXI6IFJlbmFtZSBrZnJlZV9yY3UoKSB0byBrZnJlZV9yY3VfbWlnaHRzbGVlcCgpDQo+
ID4gICBpcHZzOiBSZW5hbWUga2ZyZWVfcmN1KCkgdG8ga2ZyZWVfcmN1X21pZ2h0c2xlZXAoKQ0K
PiA+ICAgcmN1c2NhbGU6IFJlbmFtZSBrZnJlZV9yY3UoKSB0byBrZnJlZV9yY3VfbWlnaHRzbGVl
cCgpDQo+ID4gICBkb2M6IFVwZGF0ZSB3aGF0aXNSQ1UucnN0DQo+ID4gICByY3Uva3ZmcmVlOiBF
bGltaW5hdGUga1t2XWZyZWVfcmN1KCkgc2luZ2xlIGFyZ3VtZW50IG1hY3JvDQo+IA0KPiBIaSwN
Cj4gDQo+IE5vdCBzdXJlIGlmIHlvdSBndXlzIG5vdGljZWQgYnV0IG9uIGxhdGVzdCByY3UvZGV2
Og0KPiANCj4gbmV0L25ldGZpbHRlci9pcHZzL2lwX3ZzX2VzdC5jOiBJbiBmdW5jdGlvbiDigJhp
cF92c19zdG9wX2VzdGltYXRvcuKAmToNCj4gbmV0L25ldGZpbHRlci9pcHZzL2lwX3ZzX2VzdC5j
OjU1MjoxNTogZXJyb3I6IG1hY3JvICJrZnJlZV9yY3UiIHJlcXVpcmVzIDINCj4gYXJndW1lbnRz
LCBidXQgb25seSAxIGdpdmVuDQo+ICAgIGtmcmVlX3JjdSh0ZCk7DQo+ICAgICAgICAgICAgICAg
IF4NCj4gbmV0L25ldGZpbHRlci9pcHZzL2lwX3ZzX2VzdC5jOjU1MjozOiBlcnJvcjog4oCYa2Zy
ZWVfcmN14oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbg0KPiB0aGlzIGZ1bmN0aW9uKTsgZGlk
IHlvdSBtZWFuIOKAmGtmcmVlX3NrYuKAmT8NCj4gICAga2ZyZWVfcmN1KHRkKTsNCj4gICAgXn5+
fn5+fn5+DQo+ICAgIGtmcmVlX3NrYg0KPiBuZXQvbmV0ZmlsdGVyL2lwdnMvaXBfdnNfZXN0LmM6
NTUyOjM6IG5vdGU6IGVhY2ggdW5kZWNsYXJlZCBpZGVudGlmaWVyIGlzDQo+IHJlcG9ydGVkIG9u
bHkgb25jZSBmb3IgZWFjaCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluDQo+IA0KDQpIaSBGcmVkZXJp
YyBXZWlzYmVja2VyLA0KDQpJIGVuY291bnRlcmVkIHRoZSBzYW1lIGJ1aWxkIGVycm9yIGFzIHlv
dXJzLiANClBlciB0aGUgZGlzY3Vzc2lvbiBsaW5rIGJlbG93LCB0aGUgZml4IGZvciB0aGlzIGJ1
aWxkIGVycm9yIGJ5IFVsYWR6aXNsYXUgUmV6a2kgd2lsbCBiZSBwaWNrZWQgdXAgYnkgc29tZSBv
dGhlciBtYWludGFpbmVyJ3MgYnJhbmNoPw0KQFBhdWwgRSAuIE1jS2VubmV5LCBwbGVhc2UgY29y
cmVjdCBtZSBpZiBteSB1bmRlcnN0YW5kaW5nIGlzIHdyb25nLiDwn5iKDQoNCiAgICBodHRwczov
L2xvcmUua2VybmVsLm9yZy9yY3UvWTlxYytsZ1IxQ2dkc3pLc0BzYWx2aWEvDQoNCi1RaXV4dQ0K
DQo=
