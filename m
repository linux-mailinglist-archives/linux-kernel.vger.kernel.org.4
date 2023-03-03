Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A6D6A944B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 10:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjCCJjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 04:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjCCJjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 04:39:49 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126B216899;
        Fri,  3 Mar 2023 01:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677836386; x=1709372386;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LuXBskyNMntT0mfP3oI4CJMwm/5SbtiN7DmGqPzFv5M=;
  b=QuBvqdTCKtFUAcmWT+ZgzTCjixICvQrbcKtew06Ehg2dG1K1y365KY7r
   Wal7NJTKKj5XjGfHH0hNI2MNjbO3/gHpaBV7LNJwI2HierH9dMaQJKT/K
   syrTxnHMaaA0TEnasNHt4gN9KPSiTpBL79Rf9wxbSZxy7lMoHfiXruCFY
   lqmqKeoq3+cdlMBCk9IvABUsoBe5J4bN7ml3ay1QLXH7c7HtOAqZC2ADf
   WrL3xvRU0PEEh+EXtU+uRd833nBb2PNJq1FhQQZX7T4xYdNhwTFKCrt7f
   O4G4qjsnyc5LCzC+Fd7rW6v3QIeVjJY7zvT7iq75BigmNgDXh2zYJo9MA
   w==;
X-IronPort-AV: E=Sophos;i="5.98,230,1673884800"; 
   d="scan'208";a="229683182"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2023 17:39:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MompCjPxt1FeIsi/+ajK3osYQZ03LdtXvPYAhZQHYQVw/1CG1V4xwJf/mt37s6NLs+zcUFUAcEutdvA4PxEXn5Ad5BwOu2YFy4mE+6o51DFw5xtgo9vzW89oePxGhHynKfqxMtezh67jB4el4RWhe7yWpTUfDEkPATETOMeRSElJhAWtyAeuVZKpYXbkvJgQSXUgeE/TEn0M651I0C9kLDwUCbuIPYcHZVENEsQdktv2NHcolXu4gpBs2kjIbixCuZViAn7uG6sBz2s43XdUNHtOGglb6H5p2gAtssLzq2qB1Q86Jb7oWYGkdf3oFZLPjZH5+y+CxX+9+WsL0/L0gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuXBskyNMntT0mfP3oI4CJMwm/5SbtiN7DmGqPzFv5M=;
 b=Ju00ahfg1HTRr4LEOBwgEOv5kGSZNpe2jDQHpe+dEJlweJ4Vwt/cUh0JJKfZ7g3Fve2G2iwJifnF8yvf1CvKbe6IPOuAJu0pZwrZow/91XrbqI2isg1jHfrDsn3pXhUJ70iL37ittCR8HjWyYsd/5nL4sYImpkkMtI+XamFlNEg4vN9EQrKpx6ZCJ6kTlmvKyQb8JRnBmTH7/p67TRtgGm39k+cxfr3g8geTBZDG1DrDnidA/U41xZo1cw3J3w/LiIJRzeOxbwd05vFw861uwEtwOtIceNbUt0FhiRDbZWhbFUFaO20RFuDm+Ze/XKOhH5ei3UAwqowciCjTek9g2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuXBskyNMntT0mfP3oI4CJMwm/5SbtiN7DmGqPzFv5M=;
 b=QFXBM8h9XeH6kwu7P7tMkmQEcPs4/oh5kiFC9BVuwIxICjrOyXM395UQNY7wSfg0q2Yd3J39J3CmEetIuteOf/q8/xcZI9ORnyePQPRD2+tYDllCYbN5NcB+cO8QeBsOcGF0kPk/khGlUX6GUKYWHQOv3smtkeaydRAIPQnbPis=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SA2PR04MB7692.namprd04.prod.outlook.com (2603:10b6:806:137::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Fri, 3 Mar
 2023 09:39:42 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ee92:8a0e:803f:4244]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ee92:8a0e:803f:4244%4]) with mapi id 15.20.6156.019; Fri, 3 Mar 2023
 09:39:42 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bean Huo <huobean@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Wenchao Chen <wenchao.chen666@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christian Lohle <cloehle@hyperstone.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] mmc: core: Disable REQ_FUA if the eMMC supports an
 internal cache
Thread-Topic: [RFC PATCH] mmc: core: Disable REQ_FUA if the eMMC supports an
 internal cache
Thread-Index: AQHZTRVlmdiu5jdy/kOzGvaaPem9+q7nldUAgAE27gA=
Date:   Fri, 3 Mar 2023 09:39:42 +0000
Message-ID: <DM6PR04MB657530D5D51EF32A442C1409FCB39@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230302144330.274947-1-ulf.hansson@linaro.org>
 <58bb34de-e333-00bd-ae3f-4ddf0e56aa5d@gmail.com>
In-Reply-To: <58bb34de-e333-00bd-ae3f-4ddf0e56aa5d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SA2PR04MB7692:EE_
x-ms-office365-filtering-correlation-id: 07bbef99-f74f-46f6-24d1-08db1bcb379a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8ooU2LQeI9Jfc/pQ8sEFkbNHVhjQVeyLtcXZKhIyqJH69Kc3Z5ylhX0EKU+m4hAFi1HRbyM8V3d8Sp8e2tss0L6W7aepEHmFoN7kVd1v1FozwcmnWUeoE8KeXlmMPQALnxP7GJRuCJTxQOHEEM50o60FEISVGJe9iG1Pi2HXPALXSs7q93LCPwjzY0W2JA6bSykRyt1ke/gikmyw/liwFAjsENLiic7BUx58MNG9d+dPWzC7r6cT9941db5VaaYdEsQBN3WeqqjCYL3+ySutGNeO7GFRKPRUrklAl00Y+Rd4HQJTrZYGf/LnbojDz/qGAVAkwo1tezxyF6o3iHRNQHsSy+5tmbLy2aqdFD4KTODDCezo4CjgYB0O3dppsq6YCJqqgltPvDFYa3sTYbeCLqvtICLHI9KVFCfO3Q7wG6xClBRGdQPIcTd+7E3Lx798OPiGbwyWiSmv9OmnBsCLke6O/ZSTlw4KaRDGhBo3lpuHawChffeR3b23kS5fejBd1IoFCI15VnpAVPVyj2vU+4Romp/U4YW4e5bPwBlIZENAbrapRjk1oc5blkMJJgPhwFq2sfZwseC/jiww1kQaqa/CoKxlJivvOcOT+mHdJs3/frAWWfnpR17jfdqywKs8V5tqIqHTmcWb4Ag0GQzcDTMGp4FlA6aWsAbHw3WEQX9E4bGwfQ4/tNb21UZZJxNvFJXTFn0ZTVyzhaS8ueKZTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199018)(7696005)(66446008)(86362001)(33656002)(55016003)(66556008)(8936002)(64756008)(5660300002)(41300700001)(4326008)(66476007)(66946007)(2906002)(38100700002)(8676002)(38070700005)(82960400001)(52536014)(122000001)(71200400001)(478600001)(316002)(54906003)(110136005)(76116006)(83380400001)(6506007)(53546011)(9686003)(186003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTRRaTVucGp6R255WnhieDEvZXM5c0ZUMlQ5M1p0bThCM1h4d3d0K1lTWHQz?=
 =?utf-8?B?ZTdXWnlLVDQwWEJCd2tQVkxrMmZQaXYxMVRNc0hKWlNPMzF6NzlLYjJ1UDRD?=
 =?utf-8?B?ZWJUaDlReTliejdqK1FxYlF0VVp3bkVRdHpjUFloUGNwcnBZT3VRdkVUeisv?=
 =?utf-8?B?a2tpQ3h2R0dvMy9vSzJteXdmL2hsUDV5R0MrbTZ3Wktjd1hTbkF5VHB6Y3V2?=
 =?utf-8?B?akZFZkFZeHpJUURGM053SVdTY2x1dnQrR3hFb1libVBDRTJXajVNYzlSNEcr?=
 =?utf-8?B?Z2RGY0FZR1RnbmV3eGt3MkZ5N2VFVUhhQ1JjRE04N25CY0NXd0lmN05IeDVn?=
 =?utf-8?B?dVVvaE1kbXM5ZTYralRSb0VrcnVsSHpZaWxIWVZnVWgwbjVMMEcyY0lIVi8x?=
 =?utf-8?B?S2Nhb2xBbk54ZHFaSlFSempuaWNsZ3RsUVl5SXFMNDRTZGRUWHVjZ0ttb0pw?=
 =?utf-8?B?MGxhZHVmNkxDRXd1cTFyTHd4dmMvYkp1ekZTNmdwdkRZbGtzTTB5TTZlcTJM?=
 =?utf-8?B?d2xzZ0JNNUJTdEsycjd6V1JmaDB3SlB0M0JZTXBZQWdoSmpvdW9tTzdvcXE0?=
 =?utf-8?B?MzBnaWhvQ0NHVmdhdU9pd2NnSW1oV3ppczU3bkJxZEN1elUzTldmRFZnSUpW?=
 =?utf-8?B?ODNRMHhSV2w3TzZ6M010YU1EWCs2aGpZTG9wUFdXRHR0NWdKQzQ0TW4xTSsw?=
 =?utf-8?B?Zk1mUmpOVmlCNHk1ZkNma1ZKUEFuSTNLaWtDc01UM1hUUVg2akZ0b0I3dXBl?=
 =?utf-8?B?ZmF4d0tCY0tRaDBmaUVCZ3ZqYSt1L1RadXZUcFNBSkJmSFZPai9XVjk1NXlx?=
 =?utf-8?B?dFdETUJnVVJhcHFWODBranZKb3hxVU12bHB0UTZ2Z05WcXcyTjlIVDZFQmZ3?=
 =?utf-8?B?T0J4Lzh6S3g1UzA1amhVVFZ4UnZEOE5GZUtpMUNibDdVaVl4Q3hFdE5GR2dj?=
 =?utf-8?B?WVNxSHNmMVg5cGNZc1pDYzV4TnVZcy9nR3VtQ2JmcC9mTi8vQ2M2RkhpL1Vz?=
 =?utf-8?B?M2dYZ1B4UzM3aW9va3NPclArVk1RTW9vbXpEdzZva1VjeUZUeWZwc1NSSE1m?=
 =?utf-8?B?YlVMZjVVb0VBcWdVLzkrTmZSd0prVU5JVTYvZXAvTzQ0b0wzMzNTazVhUFc3?=
 =?utf-8?B?NVl0ZDdzZTh2T2drN2F4WGxnblQvNUQ3L1VGUWFUWmdFR3J0aHFSbDRzT2hq?=
 =?utf-8?B?c1VOZW5NYkFsS1dLSlVYL2NtMWkrcUx2ZnpxTUJrdVdoMGdKVGJCRGVXOUlU?=
 =?utf-8?B?Mnp3Rk0veFBFS0xFY0E3cktoSDlTOWxFVVYrRm45c2tEZGI1MjVPRmJUMkNx?=
 =?utf-8?B?WG5lUmtHZlYzalV5dVpoU1E0OWxIMTRRdkY1QU9ZWWhCQXEyT2dDQy8xdy8y?=
 =?utf-8?B?L09uYW4yL09vMmR0VWt4cHhJQ29kaTZMc2h3OWNuZzBheXh2dnFJaG56WExR?=
 =?utf-8?B?TS9vZUFuYzVudzdLSktVQTZDRXNCVUtScE1iRm1tTjZlYVpPUUY1Q0lkQ2p5?=
 =?utf-8?B?Y3RDbmJLSEhLOTZtSzFhMG9Yb0c3VEVWcDVxSndFNEdPZTRIaHZwanJTUlpG?=
 =?utf-8?B?MTR1Z28vdHdoSDZmaXRZbWovSjRhQnFDQXNwMTZjQzhER0U0ODFrcVR6WDFq?=
 =?utf-8?B?dHhjdVNXY05pc2hGeU9FVVZnNSsvVjArNjdPczByTGxwaTltcDhzaDRaQTNO?=
 =?utf-8?B?V3E2dXNQYWw4eDF1ckdJOG84c3JyVjhuQkIwaEhjNWJCN2xQUXFtQ1hVbW5I?=
 =?utf-8?B?UXZ1RmI2RllBa05jYWN0Nlk5bEJSbnh4TnNoOEpQUnVxRmpPMk9HMExYREVm?=
 =?utf-8?B?cU53T1I4R3l0c1JFTjg0a3A1d1ZFbWNuNXNiSklEMno0Smd3MlM1QnhxNmdN?=
 =?utf-8?B?MUt4MDlmMWZrdmlqYUJoYWtSbzhBNE9vcXVISHlWZ2M0SkZTQlkwVWFwRUh0?=
 =?utf-8?B?VmFINE1LZ2NFK1ZmM25BR05GdUZ3NTcvUDdMNGk1RytCSlhRMVNTeXIxQi9N?=
 =?utf-8?B?NzhiVzg2K3dMYUJ3Mit1TnRwZ1krZWtNRlVYQnoyaUZuRmtVdXlGVEd5amp2?=
 =?utf-8?B?OWJ1VkN6MlNDNGUvd0dObkNjaU95aVdhdjVaMVdwUE4wcUhxMHV5ZzZIN1Bj?=
 =?utf-8?Q?wt6JyNxYxyPsyglYFMG4Fr/gS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: epRwLaEICkX3rXxDuR1ZBO6mOBjaqvDHFYmpWZT9Rloe0B3UQ1a671z2a1PRUpvI5hdHS3lPJG9RbslkIVAJcYQJhadZeTEOA5AwENaPR+6OlPPnTeEr/yPOpfql5UWzfPMsYe1z82FaGlBpHvffCqNA2OsecQZJhpSvscb6pN4O25W5XV3p/mt44RzmC2tWQ8OL8xxJQyQt5NQyTLW+5P08A/BG3htgcKaFGCH0H+LkjJP1J1Z3wvmPG3wwYRXwWrZXellFQklj5xQRpe+8QmGbev0S/iG8FpqKeGtd2sl0Yx1PUWcwqSycp2w6DflqENR52KOuZB5R8Y44ce9xa1vGnFMdOqxgCGPwSuZwGhT8+2gSrHwmqJqFfSEOUq4a/e+8PQiFl3Yhq6ckGZln2AQQz+/GjidMLyAh3RMNKKPpnbDi4TLcz7cJwtnLZF77W8q+3MKDuE0OAhYaekf8JZPhZcSlTC8Ld2eEaxAJjL2dnJFiIcKDFCe/msa6urlRyTjBR2tY160gD3FB6QTVQtgzGxIUHVKKBA3t33M5zLczdQiLSxCVmKt8es+rgJUnXRxEC4PWQAdr2GmbqxpjgfOhRhkIZwfdpqz86ysQvMSv9DsTKIRbujKdCOxp3SKYm0qMP+kyidfNmW3GvuA791fIFOxuSl1RBDU0rb9HuV7TEyxwyXO42u6Ib1ukdgJSWUrruhdq08EZtZOvFWrKyIv/2ulZzXUSxedd/PGgAoTkgsJO9uTMwKOe5ZsFQ8ddE0evcRn1SCV3aZN1XEM5Bx5kFSIIdeZxrayZ+1DXP7KMh4TRvIxOSa37uPGZ3BEICdAqPCq86niDmPIVuA85KnT0x9x3hDbmIiMs/3ZH/UEqPn8Z7Ru3AGzHHpjsJpiVdBG6Krzs5u3pjrmEksXI4qDWxcCfD79EmizRvoo6TCU=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07bbef99-f74f-46f6-24d1-08db1bcb379a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 09:39:42.7748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dfdn76GFFt6lid6TWs0GxG6rfzTD8tIe7F5bs7OBfoJHIiwOTX2WfvlYGed9VMJ73qRgEUEq57Cv1N0/u2ErIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7692
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAwMi4wMy4yMyAzOjQzIFBNLCBVbGYgSGFuc3NvbiB3cm90ZToNCj4gPiBSRVFfRlVBIGlz
IGluIGdlbmVyYWwgc3VwcG9ydGVkIGZvciBlTU1DIGNhcmRzLCB3aGljaCB0cmFuc2xhdGVzIGlu
dG8NCj4gPiBzbyBjYWxsZWQgInJlbGlhYmxlIHdyaXRlcyIuIFRvIHN1cHBvcnQgdGhlc2Ugd3Jp
dGUgb3BlcmF0aW9ucywgdGhlDQo+ID4gQ01EMjMgKE1NQ19DQVBfQ01EMjMpLCBuZWVkcyB0byBi
ZSBzdXBwb3J0ZWQgYnkgdGhlIG1tYyBob3N0IHRvbywNCj4gPiB3aGljaCBpcyBjb21tb24gYnV0
IG5vdCBhbHdheXMgdGhlIGNhc2UuDQo+ID4NCj4gPiBGb3Igc29tZSBlTU1DIGRldmljZXMsIGl0
IGhhcyBiZWVuIHJlcG9ydGVkIHRoYXQgcmVsaWFibGUgd3JpdGVzIGFyZQ0KPiA+IHF1aXRlIGNv
c3RseSwgbGVhZGluZyB0byBwZXJmb3JtYW5jZSBkZWdyYWRhdGlvbnMuDQo+ID4NCj4gPiBJbiBh
IHdheSB0byBpbXByb3ZlIHRoZSBzaXR1YXRpb24sIGxldCdzIGF2b2lkIGFubm91bmNpbmcgUkVR
X0ZVQQ0KPiA+IHN1cHBvcnQgaWYgdGhlIGVNTUMgc3VwcG9ydHMgYW4gaW50ZXJuYWwgY2FjaGUs
IGFzIHRoYXQgYWxsb3dzIHVzIHRvDQo+ID4gcmVseSBzb2xlbHkgb24gZmx1c2gtcmVxdWVzdHMg
KFJFUV9PUF9GTFVTSCkgaW5zdGVhZCwgd2hpY2ggc2VlbXMgdG8gYmUgYQ0KPiBsb3QgY2hlYXBl
ci4NCj4gPiBOb3RlIHRoYXQsIHRob3NlIG1tYyBob3N0cyB0aGF0IGxhY2tzIENNRDIzIHN1cHBv
cnQgYXJlIGFscmVhZHkgdXNpbmcNCj4gPiB0aGlzIHR5cGUgb2YgY29uZmlndXJhdGlvbiwgd2hh
dGV2ZXIgdGhhdCBjb3VsZCBtZWFuLg0KPiA+DQo+ID4gUmVwb3J0ZWQtYnk6IFdlbmNoYW8gQ2hl
bjx3ZW5jaGFvLmNoZW42NjZAZ21haWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFVsZiBIYW5z
c29uPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQo+IEFja2VkLWJ5OiBCZWFuIEh1byA8YmVhbmh1
b0BtaWNyb24uY29tPg0KQWNrZWQtYnk6IEF2cmkgQWx0bWFuIDxhdnJpLmFsdG1hbkB3ZGMuY29t
Pg0KDQpBbm90aGVyIG9wdGlvbiBtaWdodCBiZSwgYWxsb3dpbmcgdG8gcmVwb3J0ICJicm9rZW5f
ZnVhIiwNCnNob3VsZCB0aGUgcGxhdGZvcm0gb3duZXIgY2hvb3NlcyB0bywgbXVjaCBsaWtlIHNj
c2kgZG9lcyBwZXIgc2Rldi4NCg0KVGhhbmtzLA0KQXZyaQ0K
