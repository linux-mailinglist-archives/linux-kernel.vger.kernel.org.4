Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AD86B6E68
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 05:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjCMEZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 00:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCMEZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 00:25:47 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2082.outbound.protection.outlook.com [40.107.113.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAA92A6C7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 21:25:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VW81PyczM9EBI4M2RSZ6JrtZRYZPnxWxKMj+Tk8HOkemZo0Z5GN5sanlGwYuWi6iuVfvTdWqWHOkr3eFXznUcLzZegvPiqk4/8ae9fQdosGeUJzs3lbWBW6T4aw8tn0K+un38ppm9MonpInJ2HSKvdmEcnTHUL8HSDsAJugjPvpYcuaVFMmzWSJ1GTSEQg4KrF4JZAcTkBZDpzSqIutpPQGttlDGBzKPX407HE8Rq295cVebGY4eySfO8WfjzeXC98eJyhvCOUeD3TMXxjHbfXG89NJPpAkvYcAOloQBg9k1pOML1B6MZ22gfVaSva5DOsEJks8z6/+V2pyNxMlFRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKCdoVVvBSKN2CvohNTChhPirfREmvEv8nmFoS7lSu8=;
 b=FBGbHP+n/h+LzIp3Tsi5rDtVw//a7CrbZ4tIt4eqjmymRjKmvP9WdLq86ccd4x8j7QNfXDqupNMRF7UCeeH4+P3z3Nr/tslgCUDcEl4wNFpeoH3KHRCIKxEydyzQSNpzec7fQgBPRqpZNAmsGUK+ZK3VfpZGnDCjnyt7VGJvICVhjiz53dTy47mWOY+dneHj2btFMCMEA4zai1Pjy5slePdmt2K0KzZwY5khEsbZLazJ0NO+1T/aoA48Sy3eI5//fMsPDF0sXkesW95pjfMWpmcIvYmfpfnMgBAOWRkhReIOWpIIq9TY3vf9OIKv47aeC2x04Ma3c//DMoAzVcHzpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKCdoVVvBSKN2CvohNTChhPirfREmvEv8nmFoS7lSu8=;
 b=D89B+gqONW2zWQuRpQZjgE5c4+CNbGKCwZAEwmKIATKho05i4/h7/eXSvPqqTQ9DOyzCJGhHckKyZ/B9cHGU9voXdZ4v38caEooQre44infCdKY09EPvExP8EyU82UZv6A3aJXrzNKk9ZoBTjhAUI56RztTTZsBjjxMQyW9yyFk=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TY3PR01MB11382.jpnprd01.prod.outlook.com (2603:1096:400:371::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Mon, 13 Mar
 2023 04:25:43 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::3924:5b48:7ad7:ab0]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::3924:5b48:7ad7:ab0%9]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 04:25:43 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: memory-failure: correct HWPOISON_INJECT config
Thread-Topic: [PATCH] mm: memory-failure: correct HWPOISON_INJECT config
Thread-Index: AQHZU1LgSvd49rZqn022xVaBzabjI674IRWA
Date:   Mon, 13 Mar 2023 04:25:43 +0000
Message-ID: <20230313042539.GA87704@hori.linux.bs1.fc.nec.co.jp>
References: <20230310133843.76883-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20230310133843.76883-1-wangkefeng.wang@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|TY3PR01MB11382:EE_
x-ms-office365-filtering-correlation-id: c47c6f93-9e41-4004-4fa5-08db237b028e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AzB4U6v82jgmT/p8+R/CnyY3baulwVQIMjMoVGN2rv0/DTnuQaj4m01kesHRB6a2hNEEGfnkJIEWLr/uuNCBjnBticMaFhc6UZuTXZgAUG2P2WP0+N+kvj85Fw1LReZuLd/vqhqbmkFbTFOlL4LlP6Z4QCNlU7AupXtU+JGDUS77LCc6Kv9Nxzp9fm28fmpSF5ZPftWhSU84RuUY6RG59C6lOD1k7hiKna3XYvrMwvGPnHpTN7NdChpXivsqm4ZZoMLsm7YOok5X2nrSCVm563xwKeyBSv83MHnCMx1GxOloCsIA+mQZpH1Kgk7Pai0FZLz3TFpmtkB3MSUefZKVV9Hd1tmJaq7n7ifiViZJCsAWnmz4sDbOI4iOg0QmBfGJC9094Z0QCJCGFlIAdTFgQCgQcD3kAnnBgkaw0F3PIe6CApIgmm20GjbgW1Jpomqqu9YSte55pU+gRkwQM8R1uYQW5b/YpFaOwMeE3aFhLT+TKp0o/5M5lNznqhH/uwGGRO/owOhLVIFin9lv6YBD317XfXrQjXXtZ6DvdolqJvaUqE5FA82yeayn77g2cr8S13XLaz+H20IapbIQLE2p6dAUiw/bQHXoZW1uWVegIwCXmXAfcmkgbOFO6rB/FI+jfHXhJiVse8rI2pMkUu0TyXYOuIWGVSlOEfwtT+uEmznthjXeb7HfIDDLicz+eoAqX2REken4jzJuLUkDZfw8Bw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199018)(38070700005)(86362001)(33656002)(85182001)(122000001)(38100700002)(82960400001)(8936002)(316002)(66446008)(6916009)(66476007)(66556008)(4326008)(64756008)(66946007)(76116006)(8676002)(478600001)(54906003)(41300700001)(4744005)(5660300002)(2906002)(83380400001)(26005)(71200400001)(186003)(9686003)(6512007)(1076003)(6506007)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVBBa0JUT0t2a3BLS3lSOHdiaXFmOHRwZFZVV0lMdEhkZUg4eVM5Q3BPb01C?=
 =?utf-8?B?OHpCRUd0VjUyMlRIK05EdzN3bFlseXdmWWRPcFNKTDdBVGxpUks4Vnl0UEgv?=
 =?utf-8?B?SFBtUi9nRVNFT0FXTnNoOTZMVzdCdVg4VnA5dG5Kbm1qbjdrc3ZXWVBGWTFF?=
 =?utf-8?B?bnY1N05kOGw1RGNDYmIrQitPZXVnWjZBWmYxblNDYnpCSG5Cbkt3VjFYcnB3?=
 =?utf-8?B?THR5RVdHR1VFQ2V2R3dSU2FYbS9tcmNwd2NrWlA2ZGR3am03UG82Vmw2OEdP?=
 =?utf-8?B?THNiQ1RzWE5GdDhvcXlndXM4VEI0Tlh2R1RrMS9WM2U2UmhycDNOYUZlTTE2?=
 =?utf-8?B?LzJGd3R5TEt4bXJxUnBsZEFqZ2ZHQkZWOCtYSWNrYk9OSll0YTdyWk80Wkp2?=
 =?utf-8?B?eXc1Qm1YMnF4RWg1dzlOOFRqVWYwOFpWMmQ3T1J5RkxnNzNVYzhxVTU3c3I5?=
 =?utf-8?B?ZHJNU1RHMjlsRjRGOXlvS3N5KythTjdCc243UGtCcVJNVlkwSkFKck5nV3o4?=
 =?utf-8?B?L29iVzVKUy9wcGI5VmhhN010VkFDbU90STlEVEJRM200YmdyaDV3dElGVk1L?=
 =?utf-8?B?UTFDZ0M3Z1QvS2RmWjhLbnkrcUs5RGp2MGRFMVhZSlNZcjV4a1FKT2VkM2Fz?=
 =?utf-8?B?WnRCbU0vSDk3U1ZDelhPS0t6TmQ2QlI3bkxjQlFHdmdhWWQ0SnBpZjRIL3FF?=
 =?utf-8?B?anIvM2FZNkZHMi9xaEVKeWJkZXBLaEFJMGJMeFdoZldzY3NzamRXdmF6NGFZ?=
 =?utf-8?B?WGx2ckdYK2JTVmtSODZVTzVWY211N1dCek1CMUZRTHd3alVKM3kvTFlZNUhu?=
 =?utf-8?B?WUJ5NEoxcXkxd3dQU3dqU281Rm5iSmJqM3dvOW1kMW1teWNhZ1Eyblg4Q2xx?=
 =?utf-8?B?TWNhbldXL3AzTGZxL2VhT1EyQjV6dGVoOXpLRU1Bakd0OERHNkNPMEloUm9z?=
 =?utf-8?B?S091d2UwbCtUWWkrN1diK2FTcmx4TE85NHhzSzNUZm41dWV5QjZmS2IvT3hH?=
 =?utf-8?B?eGNtcVNVVnJKQ1ZCRXU4NmtXVkJHS2o4UVFUS3Y4QjgvZ2xhdWJ4YnEwVmFD?=
 =?utf-8?B?enlxTmpOai8yaDV4eXJWTWNPZlpxQ0svSG9naERRNkYrc3AxaEVDaXNleFBR?=
 =?utf-8?B?bVJ5dmJoZldzRytHQWlnL2ZMekNyVVVnK2tmNjMwS0ZBZUxWMjRBMWM5SW85?=
 =?utf-8?B?VWVUdzZxQnBZbzVCTHY1dFNrbm1vR1drOFl5bmFkVEd5K1RNNkZncXpyaWFx?=
 =?utf-8?B?d0E5NXpiYUpNbVdxUmRSUkZyajhseGZ2K29BWXRmWDhpWHVxV0dMNGRNUDR4?=
 =?utf-8?B?amhBZjI4ZTl0OTNrV1k3TU5uZDkyTml4L01pUGxsTzd1YTNKak5rT0YwMklL?=
 =?utf-8?B?akFlTzBzLzQ5NlZ6MlY2NE83SkVOeithSW9odFBsTHFPSVdjWlo1ZmFKTlVY?=
 =?utf-8?B?MGxJQWM1Qk01amRmWllrK0VUZHR0dnlQQWptckY3VkNtZFFGK0g0bWdTOEtU?=
 =?utf-8?B?d3lyRWVLNDcyNFVmQ2d2Ly8ySmNvRWN1b3h1Rm1SbTFJMXhKUGVPeUJ0cWNZ?=
 =?utf-8?B?Ynp4TVhBVkNUYndQNG0wamdNSmNQSER1K2M1eDg0RFNYMW5sN1gvTDVzemRn?=
 =?utf-8?B?MHFXczNUeHVxcnhiOTV0Mjh3M0VTVTMwbmpJNEFLR2prT3lXUGpZdVEraU8r?=
 =?utf-8?B?bW1CV2ppcFJUcnJZTFBROWZKcm54OEZGb0djY05sdEdXRVRuOEhQN0x5MXMw?=
 =?utf-8?B?Y3lCenpyTmJUME5LQkV1L1pVV0R4eG05L3lzTGpOSWNoWXpRUjZ5bXJELysr?=
 =?utf-8?B?NmNFZENzMWxhZWF2Mno2UlFVMk5CelRCdERoaGlRRytVS1psbW0raTJ0ckN4?=
 =?utf-8?B?T0czK0pyM0VBeG1oS1R6T2FEZFZpcU8rQXplM0hFRVlaQlNwR05ZQzAyM3JV?=
 =?utf-8?B?U20vbzhyT2ZwcVBlSitCb21OVXg5d3JrRkJ3SXM2K0x4MHZRb2JuOXZVNlhB?=
 =?utf-8?B?Y0RsM1dERGFNemJZRUl5YUZxZ0ROV2czNkZoQVRyTFRRZkxiWDhYSUd4UHhu?=
 =?utf-8?B?T0NjOXErU3k0Wlc4L3dYZ3VKanFHbVBoYmV0THFZbUF6ODBZR0ZqT2ljc2RY?=
 =?utf-8?B?K2NBcVl6SnlSZ0l5UThtdGZqK1Bid2d6NENoRW5iajd1b1pMNFl4WDFROHJn?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8221AB5E83E33C44A1E1B73A561E9318@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c47c6f93-9e41-4004-4fa5-08db237b028e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 04:25:43.3262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aU2sY80xFbIFx769exmOtaTgvmXK7FnfWeJsegPX6qqcSJ9MF/zoA9h73k1UIM51s7sZU1lsLbOONoH+IKreqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11382
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBNYXIgMTAsIDIwMjMgYXQgMDk6Mzg6NDNQTSArMDgwMCwgS2VmZW5nIFdhbmcgd3Jv
dGU6DQo+IFVzZSBJU19FTkFCTEVEKENPTkZJR19IV1BPSVNPTl9JTkpFQ1QpIHRvIGNoZWNrIHdo
ZXRoZXIgb3Igbm90IHRvDQo+IGVuYWJsZSBIV1BvaXNvbiBpbmplY3RvciBtb2R1bGUuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBLZWZlbmcgV2FuZyA8d2FuZ2tlZmVuZy53YW5nQGh1YXdlaS5jb20+
DQoNCkhpLCBLZWZlbmcsDQoNClRoYW5rcyBmb3IgdGhlIHBhdGNoLCBsb29rcyBnb29kIHRvIG1l
LCBidXQgYXMgQW5kcmV3IGNvbW1lbnRlZCwNCnBsZWFzZSBhZGQgc29tZSBpbmZvIGFib3V0IHRo
ZSBtb3RpdmF0aW9uIGluIHRoZSBjb21taXQgbG9nLg0KDQpXaXRoIHRoZSB1cGRhdGUsDQoNCkFj
a2VkLWJ5OiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg==
