Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAF16A54DE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjB1Izf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjB1Izc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:55:32 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D84AE;
        Tue, 28 Feb 2023 00:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677574530; x=1709110530;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Sq6YV2rRU2dwjaas9Ba9/4tQRGrreWe9M47IZEj0CsI=;
  b=O4RNIokjxtJjKDSx1uUVpYKbF37WVxf+ew7nKlCjnQsEBIxu1J6LdUUz
   nbG7WfR8yAGXMTtHieehjZYqe+VhE3oRrcPvFznwTpWCEFHfFzxK30Lc1
   cwFERZD13WPDhrONatjShfXry5CXWdq0tcVvJzPQHsSOm0APWZceyQOjS
   1Ctz+gjem+dU81GekyDFTYw8DK+e0zJJD6/1udND3xTn8cXfWuGJmbibF
   Elw2k+Mj2XX9NFtckeLdrRE9ZgudsOe7Z8g5KvCvumzhL3Ui3F/JdIeKb
   Sy1DPOJeBkiKWiF8o1G3Ls3ORc3KSIWhAeSMafs2abmWuN24g3u3b23xb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="322337608"
X-IronPort-AV: E=Sophos;i="5.98,221,1673942400"; 
   d="scan'208";a="322337608"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 00:55:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="763093917"
X-IronPort-AV: E=Sophos;i="5.98,221,1673942400"; 
   d="scan'208";a="763093917"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Feb 2023 00:55:29 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 28 Feb 2023 00:55:29 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 28 Feb 2023 00:55:28 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 28 Feb 2023 00:55:28 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 28 Feb 2023 00:55:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmqVGNbRcj/qKRp6BV/BD0tlXMFhzHNxK7g2nRTYDiB//FbROMRTT057aPsuWnwiu8/TFU86rpUe4FYFK0Lj/jhBIgNZCDdO3xDdlu10g1FBQ6GfMNJae2ua4CNdi2SVqsKYs9ADQvK2TLsgVyzbEbn0o7VpHBnUlJqA9WjYEJWyakXj0HLrzlmwNBSopCQNQ1EMH12iUuh+bcWYZ+nk6V7pt6EW/gVaazbKXMp+ltAKvRXoVZB8XT/x+P/ysIqzqq7ssyVjM4u2H0aECvgTa76CnEVi7CB63X4MCD1uboZ5SHAV+1wlyANbRrAjscUwuNCWLDQrhoBbN4hiVcRU5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sq6YV2rRU2dwjaas9Ba9/4tQRGrreWe9M47IZEj0CsI=;
 b=BnD0On17xXMyjiMXS5hE5EpdM1lftsXMhjxlFPh6Zs8DzSIrbc6nbROpx+drGxVy4aIG3/S4VTnm59OdPkwY7ntUIIcKFhNdWQru5TNS2f3FwT4KHpPulYQWneK60P9IhbkPJwFqRYyRvnjhc5xKPf0gW1QazKVBgkw6yUJJfAjtXyvhoVxOAez+7VLwwMFnGiwH7vjjm8JsTvj1JuWRq3jXXNTngcAC30nScNP4oSFjSXcNNhwkb6iKQdn5cJ9kJSE5WVwzNFeCrrgJTxfJgkFv/SqFHegjUuHkM9eLJnomnse/t7a4WVzkumqTIDJZTQcnBurvhgKKoMeRcXIbqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by PH8PR11MB6880.namprd11.prod.outlook.com (2603:10b6:510:228::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 08:55:26 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::b6d8:543f:3a43:6c56]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::b6d8:543f:3a43:6c56%8]) with mapi id 15.20.6134.029; Tue, 28 Feb 2023
 08:55:26 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>
CC:     Sanan Hasanov <sanan.hasanov@knights.ucf.edu>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
Subject: RE: BUG: unable to handle kernel NULL pointer dereference in rcu_core
Thread-Topic: BUG: unable to handle kernel NULL pointer dereference in
 rcu_core
Thread-Index: AQHZSnHWBOuzu5f2AkiK0ceFnKP0i67ibuWAgABXUwCAAUYesA==
Date:   Tue, 28 Feb 2023 08:55:26 +0000
Message-ID: <IA1PR11MB6171E006D288555B6223FBF789AC9@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <CAABZP2z+Hk_w7nAhhyhJA9zidQViibMUO_xYianfm3xcG1QQwQ@mail.gmail.com>
 <D59B7575-FAB1-4446-BBA9-DF5EAA1B5DCA@joelfernandes.org>
In-Reply-To: <D59B7575-FAB1-4446-BBA9-DF5EAA1B5DCA@joelfernandes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|PH8PR11MB6880:EE_
x-ms-office365-filtering-correlation-id: 5a34401f-adeb-4d0e-28b8-08db196988e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: edGoXDv2+YdfialHMR8QHbCBd0ZMNqkWKArml5D4SreoZnsANSRDWGk8yu6+zTZCqoxde8UvMDEn3DwAQE/PT5bg63evH16m2npeZoelgAtehvdXBxUjawfPwwWuP3j+NTEXqZnnt6sWAjr/hQ80tVZoSPj/H7+oF/zOedXu7rrb/ZbaOo0Kqp8LLYBzaTlQFGUsYz7mB+Lwml1FmqDQm742+WDZu+8w7WqpKvo16osxNrgowucBneWEeZKx3eOB43ka664nZcuSQ7MxOFGL1pE6eANtHoPtIJdgH6Tqhvojt4IzaifVsJ9BbKJaVnaZL3TMY3SJlo5lPqa4sD4TU0wDInWOwZePILNwqTchKHCh/nycaHoQiOi5++PBxoqRF4Va/5HpXAiV2JXbJ8RW4yEG/0vsMxnrhFVYuHLF57LnvUQoNtBv1bxlz7uaUyALIrPLFa4i5+uQSx8j/jhWP9eSFUGHKiaRQ1dNBjs5PZzi4ZH6ezzOhFGZDBysV4bqvxBUUDVUBLfyCi/j8Ez59KCsrHBVIu+aZOKGHyt6jXnQ5pZULqXVBNbTvsdrCXuAztFJrG5wnO9/9pF2sC9lbT+mE7dP60zIkdVHdHiQLFDXDmF/dZDxqzqgkkSRV0U2q5x1W9h4c//LbptSYsbnXIxh8ZxGgCXnaX0WG9rmAQdnHBRY7/pMFKzb3qSeoNQMmNqzmZoZaIHmQKj7isHM2g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(136003)(376002)(346002)(366004)(451199018)(33656002)(83380400001)(45080400002)(478600001)(53546011)(26005)(6506007)(71200400001)(7696005)(9686003)(41300700001)(186003)(86362001)(52536014)(76116006)(66556008)(8936002)(66946007)(66476007)(66446008)(64756008)(8676002)(4326008)(2906002)(55016003)(7416002)(5660300002)(38100700002)(82960400001)(122000001)(316002)(38070700005)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmFmbVdEd1IrWnBjRzhKUWora0NDMXkvS2tNbnI2WlpRTmdrMTdRbk5ZMWdC?=
 =?utf-8?B?RnVNdG02TUhRSzAzNkQ1Q3c3blNyeEtlNDdHdExpZmxTZk1mL2FjUUlYVnNY?=
 =?utf-8?B?OWZvcHoxeGdqUStSZGVWZllHZUJDaHlKbWVXTHFJUDkxYXFoVHd6QndDTDI2?=
 =?utf-8?B?ejBadWlCTWxMZG1sODhEWDFqS2EvZzNIMEU2QjVNdUdzMXVaaXozS29CRDQv?=
 =?utf-8?B?L0UrOUp1VU1sZGpKTS9OMEtRaGVTMXpySGFGWUVxbCtzTWwxWXUxRWFma05Y?=
 =?utf-8?B?NHA4N1NaYVpEdFFEMjRpNERaTUU0K1l5Wmhyand3Q0pMelo1cGhVYUl0WFY3?=
 =?utf-8?B?bllYbVlTSWZBTWZTTXhWelV1YjRQcFFuVDhCaDVZUGZZeUxBSTM1RnlvTWZL?=
 =?utf-8?B?T3MwejdIdHZqTzdGR1ZmREVEV2RWZDMwcUZyZDN4bEUvU2dtNGxmS3J0aFpN?=
 =?utf-8?B?TE1pSGdKREtWdjVSV0cvQ2FET0QxcmR0N1RsbVNaNHlqekhnbWtRRnZMVzdT?=
 =?utf-8?B?blZ4LytsM2d6OUdXT0lhenB5emlQRUl4cThnc1h0c0hOa0prUktMOFlwaThv?=
 =?utf-8?B?dkRRYWhlanZxc1NWeTFrT2I5cVg4RzdHQmJsTDVZUG9XZCtKcnhEYXR0Tjcy?=
 =?utf-8?B?RnBDT0JrVmszVHY4anlKcUx1V29ialp5cHJNdmtxKzg0elFTcTFhR2h6L0xI?=
 =?utf-8?B?R3pLcWpoam91emFneWxnMXdGeUsxMFlPcGp1SHoyK2lZZkJzS2RiTDg4aE84?=
 =?utf-8?B?WWdMRnNsT1FtSWdZbGVMUlV4cThicEQ5enNDUGM4eTFJT1hPNVl6WUNFVmhD?=
 =?utf-8?B?WERmUEVIbWJOQlhaN21PZGtlaHp3bTE1TW1BdFZFYlc1TysvcHY0aEZOWk9a?=
 =?utf-8?B?cXRFYW5DOU1FVG5SaDhUTmw1NjdkeCswWUp4NlRXT3dybXkweUFIZkxCMnIy?=
 =?utf-8?B?b2IrWmdiSVpMNE5HTnZLZHF0NTlnb3RHY0dMcm9ndGxDQ2RXbVhDaitZS0Ur?=
 =?utf-8?B?K2VjS3VhdFlPUVQvU2JLckIrSG1RODd5bFB1M1dUT2drTG5SS3lldFhTL2li?=
 =?utf-8?B?V00wb1puTGxFM0NaU1VYOUJ0TVlxemVDQXNrNmJwZFB0eHZJWGk4ZGVaR2Np?=
 =?utf-8?B?ZlJMUFJ2YU9SSk9hbGhvcW00UitlTzNXSFpqYUhvL1JCYUJxdFFMd2FMUHlH?=
 =?utf-8?B?UzAvYXRiZ0orSSs0L3kzdS9uZUs5UEdTMFJEeTBCbkdqcC9pc1JycTNxdmF2?=
 =?utf-8?B?TmZGdTdpaFNySnFORU4wYlVEQ2NvaWZGbVFCQmVZcTRLUTR5UmFMUDY4ejdx?=
 =?utf-8?B?cWZxSVZXYm80cCtOUXJqNVpwUjR2N2xTTmlmRzh2ajE4Zytvd1NUdmg5cWdT?=
 =?utf-8?B?TzBpcWdIeUFXWG51bWwyTVMwUGt4aUNFOGM3YjcxYkJjMXZNVkhZKy9raHBt?=
 =?utf-8?B?MllmWUI4VC9zMHNDWTNuMHBlb3BJRmF6QzJidGdwRkZ5aEh2NE1Eb1RlTjY1?=
 =?utf-8?B?bW0vQThIV3JydUJyVU54Sm90WUFvRWxiUWxocGNEdVJMOUZnTUJPNmRGY0Uz?=
 =?utf-8?B?ZThuU3owbGJpMEJra1lQYnhZd0lnM25ZQXEvVU5iUW4wdER3clNxZGlMU0pE?=
 =?utf-8?B?NU5BN2pVR25USE1xOFo5SXRqOW9FNXFoUGdlR2lyUTRqWm5JbURsZWxsdjRy?=
 =?utf-8?B?S1pQa014K2YzTFo5Sk5nWEYyNTdScnlTOGxqdmNYK2tLYVBtd3dDQVc5Sm9m?=
 =?utf-8?B?NHdMNTVhWUY3bGxxc3M3UytncWc1Rk5iTjA2NzAxRStVU0VwRWxwREJTS3dG?=
 =?utf-8?B?Q3ZaU3NWUkFyQmxOY1BHb2hkeDZ1S2pSTU9UbVU2WER2ZSs1amZSRlpmMDNO?=
 =?utf-8?B?K0hIOTh3dWRKWjFXVjVmaGhUUnVKR1gxem5TQVB5SGpuNURPM0tYUnhaT1VE?=
 =?utf-8?B?UFJ1ck5iakFXcEN6Vm56QWR0OUtkRy9seWVzTXhQRmhwTk1ZZGJid0tiZU1W?=
 =?utf-8?B?OTd2Mk5oRzNXNTJEWkpvMHdEVnNrYXlOOHZPSVZteWlCaU16Szc4RkxiNlVj?=
 =?utf-8?B?RVNyQytkWTdFNllQS0h5QmxXWkdtbUxRL2ZFYkNqUUFxb1NWUlQ5ZlQ0ZjIz?=
 =?utf-8?Q?DDoo+SN9rIhYloeKg1I5NTTGl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a34401f-adeb-4d0e-28b8-08db196988e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 08:55:26.1946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jfSkmDCrPT7st++ZncW9kIJyBqtRDUQV/vwdmEZ28cLd2uhAORF9RRSdBEvTPTbfmfRnyTF+kRfLo7AYGtZmtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6880
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

PiBGcm9tOiBKb2VsIEZlcm5hbmRlcyA8am9lbEBqb2VsZmVybmFuZGVzLm9yZz4NCj4gU2VudDog
TW9uZGF5LCBGZWJydWFyeSAyNywgMjAyMyA5OjE1IFBNDQo+IFRvOiBaaG91eWkgWmhvdSA8emhv
dXpob3V5aUBnbWFpbC5jb20+DQo+IENjOiBTYW5hbiBIYXNhbm92IDxzYW5hbi5oYXNhbm92QGtu
aWdodHMudWNmLmVkdT47IHBhdWxtY2tAa2VybmVsLm9yZzsNCj4gZnJlZGVyaWNAa2VybmVsLm9y
ZzsgcXVpY19uZWVyYWp1QHF1aWNpbmMuY29tOyBqb3NoQGpvc2h0cmlwbGV0dC5vcmc7DQo+IHJv
c3RlZHRAZ29vZG1pcy5vcmc7IG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNvbTsNCj4gamlh
bmdzaGFubGFpQGdtYWlsLmNvbTsgcmN1QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsNCj4gc3l6a2FsbGVyQGdvb2dsZWdyb3Vwcy5jb207IGNvbnRhY3RAcGdh
enouY29tDQo+IFN1YmplY3Q6IFJlOiBCVUc6IHVuYWJsZSB0byBoYW5kbGUga2VybmVsIE5VTEwg
cG9pbnRlciBkZXJlZmVyZW5jZSBpbg0KPiByY3VfY29yZQ0KPiANCj4gLi4uDQo+ID4+IEJVRzog
a2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSwgYWRkcmVzczogMDAwMDAwMDAwMDAwMDAw
MA0KPiA+PiAjUEY6IHN1cGVydmlzb3IgaW5zdHJ1Y3Rpb24gZmV0Y2ggaW4ga2VybmVsIG1vZGUN
Cj4gPj4gI1BGOiBlcnJvcl9jb2RlKDB4MDAxMCkgLSBub3QtcHJlc2VudCBwYWdlIFBHRCA1Mzc1
NjA2NyBQNEQgNTM3NTYwNjcNCj4gPj4gUFVEIDANCj4gPj4gT29wczogMDAxMCBbIzFdIFBSRUVN
UFQgU01QIEtBU0FODQo+ID4+IENQVTogNyBQSUQ6IDAgQ29tbTogc3dhcHBlci83IE5vdCB0YWlu
dGVkIDYuMi4wLW5leHQtMjAyMzAyMjEgIzENCj4gPj4gSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFu
ZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1MgMS4xNS4wLTENCj4gPj4gMDQvMDEv
MjAxNA0KPiA+PiBSSVA6IDAwMTA6MHgwDQo+ID4+IENvZGU6IFVuYWJsZSB0byBhY2Nlc3Mgb3Bj
b2RlIGJ5dGVzIGF0IDB4ZmZmZmZmZmZmZmZmZmZkNi4NCj4gPj4gUlNQOiAwMDE4OmZmZmZjOTAw
MDAzZjhlNDggRUZMQUdTOiAwMDAxMDI0Ng0KPiA+PiBSQVg6IDAwMDAwMDAwMDAwMDAwMDAgUkJY
OiBmZmZmODg4MTAwODMzOTAwIFJDWDogMDAwMDAwMDBiOTU4MmY2Yw0KPiA+PiBSRFg6IDFmZmZm
MTEwMjAxMDY4NTMgUlNJOiBmZmZmZmZmZjgxNmIyNzY5IFJESTogZmZmZjg4ODA0M2Y2NDcwOA0K
PiA+PiBSQlA6IDAwMDAwMDAwMDAwMDAwMGMgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogZmZm
ZmZmZmY5MDBiODk1Zg0KPiA+PiBSMTA6IGZmZmZmYmZmZjIwMTcxMmIgUjExOiAwMDAwMDAwMDAw
MDhlMDAxIFIxMjogZGZmZmZjMDAwMDAwMDAwMA0KPiA+PiBSMTM6IGZmZmZjOTAwMDAzZjhlYzgg
UjE0OiBmZmZmODg4MDQzZjY0NzA4IFIxNTogMDAwMDAwMDAwMDAwMDAwYg0KPiA+PiBGUzogIDAw
MDAwMDAwMDAwMDAwMDAoMDAwMCkgR1M6ZmZmZjg4ODExOWY4MDAwMCgwMDAwKQ0KPiA+PiBrbmxH
UzowMDAwMDAwMDAwMDAwMDAwDQo+ID4+IENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6
IDAwMDAwMDAwODAwNTAwMzMNCj4gPj4gQ1IyOiBmZmZmZmZmZmZmZmZmZmQ2IENSMzogMDAwMDAw
MDA1NGU2NDAwMCBDUjQ6IDAwMDAwMDAwMDAzNTBlZTANCj4gPj4gQ2FsbCBUcmFjZToNCj4gPj4g
PElSUT4NCj4gPj4gcmN1X2NvcmUrMHg4NWQvMHgxOTYwDQo+ID4+IF9fZG9fc29mdGlycSsweDJl
NS8weGFlMg0KPiA+PiBfX2lycV9leGl0X3JjdSsweDExZC8weDE5MA0KPiA+PiBpcnFfZXhpdF9y
Y3UrMHg5LzB4MjANCj4gPj4gc3lzdmVjX2FwaWNfdGltZXJfaW50ZXJydXB0KzB4OTcvMHhjMA0K
PiA+PiA8L0lSUT4NCj4gPj4gPFRBU0s+DQo+ID4+IGFzbV9zeXN2ZWNfYXBpY190aW1lcl9pbnRl
cnJ1cHQrMHgxYS8weDIwDQo+ID4+IFJJUDogMDAxMDpkZWZhdWx0X2lkbGUrMHhmLzB4MjANCj4g
Pj4gQ29kZTogODkgMDcgNDkgYzcgYzAgMDggMDAgMDAgMDAgNGQgMjkgYzggNGMgMDEgYzcgNGMg
MjkgYzIgZTkgNzYgZmYNCj4gPj4gZmYgZmYgY2MgY2MgY2MgY2MgZjMgMGYgMWUgZmEgZWIgMDcg
MGYgMDAgMmQgZTMgOGEgMzQgMDAgZmIgZjQgPGZhPg0KPiA+PiBjMyA2NiA2NiAyZSAwZiAxZiA4
NCAwMCAwMCAwMCAwMCAwMCAwZiAxZiA0MCAwMCBmMyAwZiAxZSBmYSA2NQ0KPiA+PiBSU1A6IDAw
MTg6ZmZmZmM5MDAwMDE3ZmUwMCBFRkxBR1M6IDAwMDAwMjAyDQo+ID4+IFJBWDogMDAwMDAwMDAw
MGRmYmVhMSBSQlg6IGRmZmZmYzAwMDAwMDAwMDAgUkNYOiBmZmZmZmZmZjg5YjFkYTljDQo+ID4+
IFJEWDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6IDAwMDAwMDAwMDAwMDAwMDEgUkRJOiAwMDAwMDAw
MDAwMDAwMDAwDQo+ID4+IFJCUDogMDAwMDAwMDAwMDAwMDAwNyBSMDg6IDAwMDAwMDAwMDAwMDAw
MDEgUjA5OiBmZmZmODg4MTE5ZmI2YzIzDQo+ID4+IFIxMDogZmZmZmVkMTAyMzNmNmQ4NCBSMTE6
IGRmZmZmYzAwMDAwMDAwMDAgUjEyOiAwMDAwMDAwMDAwMDAwMDAzDQo+ID4+IFIxMzogZmZmZjg4
ODEwMDgzMzkwMCBSMTQ6IGZmZmZmZmZmOGUxMTI4NTAgUjE1OiAwMDAwMDAwMDAwMDAwMDAwDQo+
ID4+IGRlZmF1bHRfaWRsZV9jYWxsKzB4NjcvMHhhMA0KPiA+PiBkb19pZGxlKzB4MzYxLzB4NDQw
DQo+ID4+IGNwdV9zdGFydHVwX2VudHJ5KzB4MTgvMHgyMA0KPiA+PiBzdGFydF9zZWNvbmRhcnkr
MHgyNTYvMHgzMDANCj4gPj4gc2Vjb25kYXJ5X3N0YXJ0dXBfNjRfbm9fdmVyaWZ5KzB4Y2UvMHhk
Yg0KPiA+PiA8L1RBU0s+DQo+ID4+IE1vZHVsZXMgbGlua2VkIGluOg0KPiA+PiBDUjI6IDAwMDAw
MDAwMDAwMDAwMDANCj4gPj4gLS0tWyBlbmQgdHJhY2UgMDAwMDAwMDAwMDAwMDAwMCBdLS0tDQo+
ID4+IFJJUDogMDAxMDoweDANCj4gPj4gQ29kZTogVW5hYmxlIHRvIGFjY2VzcyBvcGNvZGUgYnl0
ZXMgYXQgMHhmZmZmZmZmZmZmZmZmZmQ2Lg0KPiANCj4gSSBoYXZlIHNlZW4gdGhpcyBleGFjdCBz
aWduYXR1cmUgd2hlbiB0aGUgcHJvY2Vzc29yIHRyaWVzIHRvIGV4ZWN1dGUgYQ0KPiBmdW5jdGlv
biB0aGF0IGhhcyBhIE5VTEwgYWRkcmVzcy4gVGhhdCBjYXVzZXMgSVAgdG8gZ290byAwIGFuZCB0
aGUgZXhjZXB0aW9uLg0KPiBTb3VuZHMgbGlrZSBzb21ldGhpbmcgY29ycnVwdGVkIHJjdV9oZWFk
IChKdXN0IGEgZ3Vlc3MpLg0KDQpEaWQgYSBxdWljayB0ZXN0IHRvIGRpcmVjdGx5IGludm9rZSAi
Y2FsbF9yY3UoaGVhZCwgTlVMTCkiLCB0aGVuIHRoZSBrZXJuZWwgZ290IHBhbmljIA0Kd2l0aCBh
bG1vc3QgdGhlIHNhbWUgY2FsbCB0cmFjZSBhcyBhYm92ZSBhbmQgd2l0aCB0aGUgc2FtZSBSSVA6
DQoNCiAgICAgICBSSVA6IDAwMTA6MHgwDQogICAgICAgQ29kZTogVW5hYmxlIHRvIGFjY2VzcyBv
cGNvZGUgYnl0ZXMgYXQgMHhmZmZmZmZmZmZmZmZmZmQ2Lg0KDQpJZiBpbnZva2UgIiBjYWxsX3Jj
dShoZWFkLCBOVUxMICsgMSkiLCB0aGVuDQoNCiAgICAgICBSSVA6IDAwMTA6MHgxDQogICAgICAg
Q29kZTogVW5hYmxlIHRvIGFjY2VzcyBvcGNvZGUgYnl0ZXMgYXQgMHhmZmZmZmZmZmZmZmZmZmQ3
Lg0KDQpJZiBpbnZva2UgIiBjYWxsX3JjdShoZWFkLCBOVUxMICsgMikiLCB0aGVuDQoNCiAgICAg
ICBSSVA6IDAwMTA6MHgyDQogICAgICAgQ29kZTogVW5hYmxlIHRvIGFjY2VzcyBvcGNvZGUgYnl0
ZXMgYXQgMHhmZmZmZmZmZmZmZmZmZmQ4Lg0KDQpUaGUgbG9nIGFib3ZlIHRlbmRzIHRvIHNheSB5
b3VyIGd1ZXNzIChhIGNvcnJ1cHRlZCByY3VfaGVhZCkgaXMgcmVhc29uYWJsZS4g8J+Yig0KDQot
UWl1eHUNCg==
