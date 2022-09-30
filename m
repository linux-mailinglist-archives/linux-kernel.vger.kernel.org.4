Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04845F10DA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 19:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiI3R3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 13:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbiI3R3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 13:29:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E651E16D8;
        Fri, 30 Sep 2022 10:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664558927; x=1696094927;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DQJNhFXuXRTJMOnRpRP8VD1B23Osujct3WQ2htpPoMo=;
  b=J2Q2grGBicl6xFMab+dIVukG3Di9eGbOZG0v47fzIyIeyHtZ53/7c23E
   SYmyO5bSWRb7pCG83Ofhl734ul8MGzHTBQCBm5VucksLeqUGNwMANMY/x
   7N8QhjZP+7FcrzgCGPIbkG2q8JbPxfi6xVvbBc4Xix1e6fjMpdLfB2QQ3
   R651w2aMntY31/CTWKk0LM0JFZACLjlNj8+012pnL0KgiV7uMQVTHtCGC
   FuWBXYB3r7Pgp7duxBd2/Z5SUbNZcZ6ydPSDTU1Q0nBkGsMBrjMyzyILf
   Rjs3kmCKGbrGGd6qogxpFpHCoCxkH968d6p9UCGlPpOHAmPrEhAOPQCdB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="289408245"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="289408245"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 10:28:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="618058784"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="618058784"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 30 Sep 2022 10:28:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 10:28:45 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 10:28:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 30 Sep 2022 10:28:45 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 30 Sep 2022 10:28:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3rcFspisViWMPn5JEQ2J9WiPB0Kbp0zqk/gVfP8BxkPpD3AvWy9iZ7ClqqzM/gkrAmc0wPTEQKlH8GEgVxUji126itzzqFfvy+9uUhBZdIvyMuFTJwDUpj0D6yXmsZtIyLbTzlkogw6n2GaQVK0sv2pmxeVEuyoPxVInI5NePNv6bMD7fMAlnC94crItPT1qs373hnjDsyFzkqs4yh1We/EhwkcVV6Tb3sujGLAYuQkFQVSEV4sQ5Y8rsVodhCm8n+7Dqth62P23HU9Y0aUwj0V58yIgRQfrMPlanTKxYFTD/uxxJmue1cTF0Ayj1vzs+DHxEQn6A1VkmKnAn8/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQJNhFXuXRTJMOnRpRP8VD1B23Osujct3WQ2htpPoMo=;
 b=W9c3dFECwfbCsN0jvSoS7Y52SLh7YjKcT4qT6QkbqjU1hNvQ/vPyhOJCRzASN5lmb40OoUpYrR6L9OhG2ziFTsuaV5MSg+WfwN3jezNbVbIB6xzgcZhHNtePd8bOSglCObVFjQr1nQKXIsUY9/9qhrb1FaLAQtpbTMhHA1lKUzJChuE8NwvWTddVO1ef92hYi/ysYOPK5Xq8oB8igimCTO6IbQfcANz/sqailC9Q07lxmEj37ZxfVtuxkd8bo7UMUHeEIxfGEIOXcLOc4/K82V608dH7vh2qLTLLBO/j+fkeJS1sMBb4fcHIaOTYlFDB55TumzcDyMwJmnQDGqy38A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CO1PR11MB4801.namprd11.prod.outlook.com (2603:10b6:303:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 17:28:38 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60%5]) with mapi id 15.20.5612.022; Fri, 30 Sep 2022
 17:28:37 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Bird, Tim" <Tim.Bird@sony.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thorsten Leemhuis <linux@leemhuis.info>
CC:     Slade Watkins <srw@sladewatkins.net>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "workflows@vger.kernel.org" <workflows@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "ksummit@lists.linux.dev" <ksummit@lists.linux.dev>
Subject: RE: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
Thread-Topic: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
Thread-Index: AQHY0/dwcgyMNpaNMU+A0Xg6SV2jB632VGCAgAALngCAAAe6gIAABgmAgAAICACAAAj6gIAAHisAgAEbCACAAD+pgIAAMWcAgAARdCA=
Date:   Fri, 30 Sep 2022 17:28:35 +0000
Message-ID: <SJ1PR11MB60836F8B9E045C5542D01ADAFC569@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
 <93a37d72-9a88-2eec-5125-9db3d67f5b65@gmx.com>
 <20220929130410.hxtmwmoogzkwcey7@meerkat.local>
 <7b427b41-9446-063d-3161-e43eb2e353f9@gmx.com>
 <20220929135325.4riz4ijva2vc7q5p@meerkat.local>
 <95c3384b-53d0-fd6c-6ec5-a7e03fdeddfc@gmx.com>
 <F300ED64-5E8E-4060-89DC-C98BC5FF08E6@sladewatkins.net>
 <YzXK6Px+BrNuuMZH@pendragon.ideasonboard.com>
 <a86adc6d-05db-ec2e-c5de-d280aad9fb8a@leemhuis.info>
 <Yzbtuz6L1jlDCf9/@pendragon.ideasonboard.com>
 <BYAPR13MB250377AAFCC43AC34E244795FD569@BYAPR13MB2503.namprd13.prod.outlook.com>
In-Reply-To: <BYAPR13MB250377AAFCC43AC34E244795FD569@BYAPR13MB2503.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CO1PR11MB4801:EE_
x-ms-office365-filtering-correlation-id: 405438b7-6c02-4801-66f4-08daa30935d2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2FbF+MKtZYOVGhNQW0Y1iIQIqoFP9Jxh24gdkTHCvJM8kLcLS2ROvms8vdze6IJYshM0uMub/URLakmXaoxHoNhq701rAfTsxnqYFufxWF+GmcG5KJ+U0NjwSHI3peI96IGwxfywX4LF22piGvWHP8fd56Vh/YO6h0Dn4zQLIOrmhkkTaBOr/7kj9ta76b7aR+MBYP3+aF6I1T9RF6sF61qSj4p0yJ27UTl+ANHxNqR34OL9j1Ag5hzs93OaRERLwoKj1PRvI04pLmdRL4xjG5PCS67R7B/jASfoXfQR/E1b75W2CgyAUQWNTRl46MxT+NkeqeTU6duzFhjpaPhFlfSTWCKougpMKnciXWGQQrS2pfHNSJLbJzumIQj+Neeuw1h+4lUz5QRSBZx5oiPoW2hvxD+B8DQVedmAYTk5eXpDKy23C0/9YSkhRoSwwOTNNh2WUczsv93j4gHpbfGd4IgDqBPqqQSZL+oJ73t8XBR3j+vrcmx3DV7+PtWRbrDsMskZCjEj8S0PvKL6lKK85WrXv2l+7wTGvnS9441ocsXqGTGuLNn9RcWzTH6G8MH8fB0qaq/PjXS+h1+OFfBMaIN8I+7ioF5e3k4BB+0yIQnRe7hwRQkV/Y+Hatx6SGb7rG5nP8hEuGPowSQ+U56rS+vK/VgxDHLWbv5Nb7mVhRsc9qMXBEHrhqLazIeAO9tNSHlhEW0DzhdkgmtRkyQFF935jVpyXieJxaG0ixG0WdV55oVEBxntg6lZdYSC1hf/EQE6DA58rZo4+I2Sd1DseA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199015)(4744005)(7416002)(8676002)(316002)(54906003)(8936002)(66476007)(6506007)(7696005)(33656002)(5660300002)(52536014)(66946007)(64756008)(66556008)(9686003)(66446008)(4326008)(76116006)(41300700001)(38070700005)(26005)(38100700002)(122000001)(82960400001)(186003)(86362001)(2906002)(55016003)(83380400001)(478600001)(71200400001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjNJNlFweGVoSldZNTRRMkZoSCtHNGxvVlhFc0xzU1hpNFIwQnc1NmxpM2RT?=
 =?utf-8?B?bEdtaVAvRVo3WjdSQlJkSHo4S2ppNzd6SnRlR3d5bER3M0hTR1JSMXhuWTZa?=
 =?utf-8?B?UGhRNFJtZEhqaUxvZjdMMmlnQmtDMElJZUl0YnB1dUlnKzg2N25CN0VRSTgv?=
 =?utf-8?B?WFN3MjBUQ2NkdW9xMCtpREJPTnZqemR1UFh3UXVVdmQzd0FXWlZCM2puRU5U?=
 =?utf-8?B?cm0wdDk0d0RnY1VmZEkzT203QUIyR0Nkdy93SHRiUFE2bW02a2ErdzErZnJa?=
 =?utf-8?B?VVBUTmpiaVZYYkJsWjAzRm4xUzdyT0pHRFRuVi9ISHNGbnYyN1VyWDdkdHk5?=
 =?utf-8?B?Rjd1S1lldFFGci9oVzJoc0tObjVlSkJ6TCtDL1dzdjFrMk1UR0xOandhMXpO?=
 =?utf-8?B?TWwwOXlia1RYekM4U21XTjdYV3RkUEVrN3V4dHNzUjlqNTBYdlpiQmlLTS9O?=
 =?utf-8?B?WXNJMVZSaHBhaHZFbHhmZmltS2tMdEJDLytyajBzR3lIODFVWkI1SG5QSHVV?=
 =?utf-8?B?WHhzdHU0STJHa0loMUhSR25jNjFPTWplNUkyZzAzQ2d6Rm11SjZmWE04cmd0?=
 =?utf-8?B?WUt5R052Um4xMHc3ZC9HMjNiVUpIZ2F1ay9iRnZiMDQ3amg3ZDBaZFpJY0l5?=
 =?utf-8?B?WGZKTVc3OTJyQVV6aTNmNXAvRkExMkVNeFlUK0VTYTFQWWdWb0czdmRHcGNz?=
 =?utf-8?B?d2I0a01EYzUxa096a2lJWnR3emxJZEtZV0EzSE1FMHlsQnVLV0pBUXp0cEti?=
 =?utf-8?B?MDZZaDRORGV5NEVodUNFYklTcms2SmVPZlk5allaZ2ROYytBTkxZRTZsb0Ry?=
 =?utf-8?B?WUY0QlJTOGdQSTBaUUVRd1pnRWxmRjNZbndGaXdaNGczR3pSS0dYYitiVUgv?=
 =?utf-8?B?UmpseC9UWDI0djFnbnZJbE1wYkVCOTNmbjR5ek5lRnBHYTRFQVZPbnJvMkxp?=
 =?utf-8?B?MWNiUzEwV0dQQ3AwWGF1eSs1N2JHMTNQVEpkQlhFUlFpQjhZeVRtRzgvRVZH?=
 =?utf-8?B?TEduZDBmbHMvOE5HVzduWkpDcVF5WVNZTE8zQk5BOHpESENReHdCcW9uQy9K?=
 =?utf-8?B?bWJZY2IzOTgreURoZWJmOVg0WUQ2ZHVldHlYOVQvenBXNUVPUEVyQ3Z5WWZG?=
 =?utf-8?B?QnJ2UHNMWnhJUkJaQ3I4VDZIeUU4MUJqc2FGbm50Z245QktUc0JTNmhOdUNI?=
 =?utf-8?B?Tlo2SG5rcXZXRjh0bEJORTdoSGkrTU95UUE2WnZOQ2R5RDRCdWwxNnZDeG9s?=
 =?utf-8?B?U1piZ2J6RmdpcCt6bTBUR3A1RndHbHkzQmJxRllUMm10R0JVTVpUd3BjNGRi?=
 =?utf-8?B?R3hiRGl2Q2ppTFgzdG9mam9EVXl0NkdiVDR5YTNJSm1tUVN3Y2FiWFVuOU9k?=
 =?utf-8?B?blFZWTN6aW90RlhHempuN0x2amNlbDJFaHJVWVhDamVhL0xGTDNFUXVLN0tU?=
 =?utf-8?B?dklubmZiWXFQd0o3a3djRGtxWjcydlRURlRySFdSd0MzWGQ4ZEw1Y20yOWlK?=
 =?utf-8?B?aXdNVVYrN2lXNFFtYmZxZnU1WnJyOVBmRkhDcGlBVHVZNXZVRFRtbm9sd2tC?=
 =?utf-8?B?cGNCMWU0VnpYdUpiQm0wMnJQd0dyeHJ6Sy9CNjFOdUZCMzhzbm15dWJqWXpi?=
 =?utf-8?B?b1NmSVp3YnQ5ZFV3V1dsWEpmTzZGQVRucFVQUWRISnNEem40eGx0bmF4T0Zi?=
 =?utf-8?B?dVdjM2Z0STQ5OUxkU1V3eVRCM1g3RkV6NDdyMFNkNUw5cEFBSzhEUXg4ejBo?=
 =?utf-8?B?ZEsweEJPNkRTMHpiWWtnbnpML0VoQjk4Uno2aVpycnNmYUxVM1J1U09BdzBP?=
 =?utf-8?B?K3NUU0lEZVRmME1jVVZzOTJHY3JtK0ZTVnBocHl6NEtWS1QvZThFQzh3NHJE?=
 =?utf-8?B?b2dkcExXRHFNL2lHTlg4SjJlT2s4T2QvSEliaFhTbS9EMEhMYTZTc0c5M2Fu?=
 =?utf-8?B?QnBDRVh4cis1UjZ1RVgvV1lkYU1jSnpYMVJsc1VjOHQ3Wk8zb1d1emNOdGk3?=
 =?utf-8?B?YWJLMWpPTTg4NUk3dWFwdDlJWi96QkJRbHBBdnlFd2l4MGRMSHVLZE9Ud3hE?=
 =?utf-8?B?aWNib2hQeW14R3pyYXhLTERVQmlxOVd0KzJ3MEFneDgxeHFaZFdvYlgvc1Jl?=
 =?utf-8?Q?dzQY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 405438b7-6c02-4801-66f4-08daa30935d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 17:28:37.8892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c6JckS/5yTp3mucjETTHrz+ow1crXLG8qqAcj5Ol//MkX4ve0FO3x6NPciyQY6i1kd1p9bROjfDlEMNCCI+d/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4801
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBFLW1haWxzIHNlbnQgZnJvbSBhIHdlYiBpbnRlcmZhY2UgY291bGQgaGF2ZSBhcyBtdWNoIHN0
cnVjdHVyZSBhcyB5b3UnZCBsaWtlLg0KPiBTbyBvbmUgYXZlbnVlIHdvdWxkIGJlIHRvIHNldCB1
cCBhIG5pY2UgaW50ZXJmYWNlIGZvciBidWcgcmVwb3J0aW5nLCB0aGF0IGp1c3QNCj4gZGVsaXZl
cmVkIHRoZSBmb3JtIGRhdGEgaW4gZS1tYWlsIGZvcm1hdCB0byB0aGUgcHJvcG9zZWQgYnVnLXJl
Y2VpdmluZyBtYWlsIGxpc3QuDQoNCldlYiBpbnRlcmZhY2VzIGhhdmUgdGhlIGFkdmFudGFnZSB0
aGF0IHRoZXkgY2FuIGJlIGZ1bGwgb2YgYm94ZXMgd2hpY2ggaW5kaWNhdGUNCnVzZWZ1bCBkZXRh
aWxzIHRvIHN1cHBseS4gTGlrZSB3aGF0IGtlcm5lbCB2ZXJzaW9uPyBEaWQgdGhpcyB3b3JrIG9u
IGFuIG9sZGVyIHZlcnNpb24sDQppcyBzbywgd2hpY2ggb25lPyBXaGljaCBDUFUgdmVuZG9yL21v
ZGVsIGFyZSB5b3UgdXNpbmc/IElzIHRoZXJlIGFuIGVycm9yIG1lc3NhZ2U/DQpBcmUgdGhlcmUg
d2FybmluZ3MgaW4gdGhlIGNvbnNvbGUgbG9nIGJlZm9yZSB0aGUgZXJyb3I/IENhbiB5b3UgdXBs
b2FkIGEgZnVsbCBjb25zb2xlIGxvZz8NCkRvZXMgdGhpcyBoYXBwZW4gcmVwZWF0YWJseT8gV2hh
dCBhcmUgdGhlIHN0ZXBzIHRvIHJlcHJvZHVjZT8NCg0KRXRjLmV0Yy4NCg0KU29tZXRpbWVzIGl0
IHRha2VzIGEgZmV3IHJvdW5kIHRyaXBzIGJ5IGUtbWFpbCB0byBlc3RhYmxpc2ggdGhlIGJhc2Vs
aW5lIGZhY3RzLg0KDQotVG9ueQ0K
