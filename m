Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4ED695492
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 00:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjBMXSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 18:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBMXSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 18:18:38 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CC01284B;
        Mon, 13 Feb 2023 15:18:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dy7WTq26I1SW/Uay5R35f6rAAMoncmX/9YzBeriUJ1zFWEKRiZnFXUZR8RfysgAxIx9RXmnLCtXX/dzuwE3v3dB+3mcXoZzBcm6mTjeZk2Y2wWuTB7JSIRQU5slyfNygNBZvT9sTq/6CgYE+LQDcz6afNDQ/DR4BdKqiY9YUVnXc7urISm83vllHvMZc5rIykFDui47VmM6XLqgprGIHc7a4OkmzVEosF770DEa4UWAQFs/NgD9aD6Uq1uiH9SrlSqseazbsykLK6WK07GkUCGOnHiggenQh3hPIJWpJpXgr36Gbh81NgYXgq0eVkJ/tDFlP4w6vj7VZn/J2rrf6/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWVOe1wjKEUF/4ChjgAgClWXFHK4d3QSYV00LrcpOIo=;
 b=YHPgbX18ZZYsBozfHMwqJuBuQdR+anaJjtRCTNaoXSG2OO91mLglVUBkaK2sgK9YVotR0KldlceJLOusxmhm8kMXO398QF4Qxoht/TyGJ8fJnxVf2mROeIAMK1tmfVHGxR9P0OPeseJUqwIuUB2tAl3zqK4Kc3NcKqDAitDcYA/DWbrwzS7x2529GF1vT59bxIvZk4BEHZlbQStO2B89S+kjzwLShMD14grrSLTfA+T6qc4d7ZSm8iVUBQsvx7Z+NoeBwtSyyNsUh/vnKqwNokCwXP5Bsh0Mr0/5KyXrGUnuV2yIRggiCzxZeN5Usht1o8yyglp6WFJ6SjM+KCy3bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWVOe1wjKEUF/4ChjgAgClWXFHK4d3QSYV00LrcpOIo=;
 b=ViX5yIgdt27QKCJiQ46sWFdcH5PRFpSJP175Hw+z1B6N0U2IrefgqSpV86OgGRsxvxuYacwcy99VDAUC21hd61K1aXUEVosLpp8J0n0PQBI9OMtbERYISeUUooYoif3CMNAx8mSTvjvRFOUnQYfjdDn9qqn0zfkOYBlapL+8Y+DOhQpabN/fAFB2m3jzUfbNFwJ+XLrdrdCmgJH9fRh4JK902xA9LqeJNFXa259ZH0j7zLB7zl84qDIDVg75lpwPysJDlZXH3EDulD3tlBVtk/GA1l6ZNSmER1C9i+zY7lP5Ah6K9Hx78I7IwrGmycBK2n9UR2oupEI5d1WwnumXNg==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 23:18:35 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::5f35:2f2d:94a4:f7c3]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::5f35:2f2d:94a4:f7c3%4]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 23:18:35 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] Support NVIDIA BlueField-3 GPIO controller
Thread-Topic: [PATCH v3 1/2] Support NVIDIA BlueField-3 GPIO controller
Thread-Index: AQHZPWDY+ddv+dcyBkKpM1yxALtQwq7MreSAgADZ75A=
Date:   Mon, 13 Feb 2023 23:18:35 +0000
Message-ID: <CH2PR12MB3895FEF883A6568727030CE2D7DD9@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20230210150319.200799-1-asmaa@nvidia.com>
 <20230210150319.200799-2-asmaa@nvidia.com>
 <CACRpkdZB6nqsuMSH1Aq32kMcJuC29W987eUOdxNb37kx5KQ4tg@mail.gmail.com>
In-Reply-To: <CACRpkdZB6nqsuMSH1Aq32kMcJuC29W987eUOdxNb37kx5KQ4tg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|IA1PR12MB6305:EE_
x-ms-office365-filtering-correlation-id: ab8e87af-2c4b-4d16-f2d6-08db0e18a155
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Za3UDWG2rPx6kcZsFZ6LDxglb6h+tUckRM3mhNDN9WNXj5LrTireSbAHLC/DxUe80RouGjhg8PIjcfqsd+uGEdz+iKphxhHA5ltDecWUog0mPk2MV930leERcVqQhEDzDe1j7stZpNLOrpobj3hETEDjpWgriryHCAdz7JX1KMy1sqVvHD3cpaTIM4E65hVech20qqWT6SUsq9DUHrHfb8LNC174rFwJg4MSVktCwzecpjdPMptmJbXRe9RLGkgp2nBKp4BsaiR93zsiWiuufTpMgahRgokmWCCK9MdDKYWMo4DSqQE5CrndpLjdunSWDI06IXfaKc9UuTY2D8v3uRUL/o/Lr3SoOOQKC3LwrZEPdGMHiQaRTYMbXef9Xf103bUQDR7YpM5bEBFkq88nNX9rNL2hObWi26ahNXsKg53/X5Ku+9USWqGITuO5QhUTsKWY9mh0jUiSWJ/1DUUe/r2f7ouIIFPdJU1uhNLrhuDTbnSsbiBkrzSf6WPZPSJPREQ4TSsdNLOkc1+AZ6+uaidr1ZCfyvB8sQwVj+lIh7lP/gv5hWXPmWS8elDrxlhgIDQErqg6nu/cjqZScxz8VxYI8ZnMaZsK9Vp/RF2FIu1tNnaxrcyzp+832mFzD+xUSv9ez+VHfsW0Bo6u6MHAfVb98Ae+/2qmO7mC7CUjLdK9LHWClwWtJFk7KIFV+ZSFG0/tY3NCOf4K2t8V39J1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199018)(86362001)(38070700005)(55016003)(33656002)(122000001)(38100700002)(5660300002)(4744005)(2906002)(76116006)(71200400001)(7696005)(64756008)(66476007)(6916009)(66556008)(54906003)(52536014)(8936002)(66946007)(316002)(41300700001)(8676002)(66446008)(4326008)(9686003)(26005)(6506007)(186003)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlRSYWp2aXNHUWR3Q3VwV2xENGtRTmR6U1ZncVAzL0wxbVdXd2lGRE5YTUhF?=
 =?utf-8?B?VG04Q2o2R0JQQXpkRzRVd1hmeTBFdHNMSUFLekZ2SnhwdlNMY3FETHpOWVJV?=
 =?utf-8?B?ZE9vd0xTWE1NclFPL0w2dlI2YVJGSlNCamxDL1hsMWRuZU41bU9PbEkzWmJv?=
 =?utf-8?B?ankxQVJ0by9jbDFHY2lReW5wc0pUbldsc2JXR2ZJRm1RUjlxcGc5NFBNYXFq?=
 =?utf-8?B?aHRXMkdjSGFzT3h2eEUxSm90bUdhVzBTNkpjYzFRcVVUWk43blBzdXltaU1y?=
 =?utf-8?B?ZXJ4UVhvYlNDUHcwcmJqTWNCUm9jd3IwdUo5Q1RIc0FnM24yMUdGc3R3dDht?=
 =?utf-8?B?QnM5OGJibFMvS3drY1ZBb1lVcTZtaDFEQWNxTThIMms5eEsvS1ZIaDIvZFlU?=
 =?utf-8?B?L0srTlFIWjhGb0k2WlJhN3pVbGhLWGpkMHM5a281cUpvbzJ2OW8wRG1WaTBV?=
 =?utf-8?B?eEQyam9lNjJjL2tCVDQ2MkdVNDVhRVovaGc4Y21xeWszRUhrM0lLZWtXMEJD?=
 =?utf-8?B?VUtVdi9EdlcwdGxNSXV0RUcraTU3alhTSlJMc0xGbTdyM1Znbmt2U2V6UU9w?=
 =?utf-8?B?WEZ0RmppTlRnT21LNm5ha2hvR0hkTE9pTGUzdzkyejJtMUwwcld3NG8zT29V?=
 =?utf-8?B?OHBCUHpaNTBWMlp3dFhCZng5K3ZiNnZQakRUV3ZpMjRFUFhaMG5taVhRb0Rh?=
 =?utf-8?B?MnJaWUhFUzJiUFVqTXpHaU5hY05aaEJmaW1wYlVSaWlQWklXK0tuVHg1amN5?=
 =?utf-8?B?dXlPdGhyYTZSTmdqd0czU1FBdGY4enc2bytqSDhlMDJWUXMvVFhsN0Y2SnJK?=
 =?utf-8?B?VzBKaUo3Y0Z6SXdYdlhWQnhsdTlKczRUbWVmWUJwVTVYZzZzNzlTaCtNMTR6?=
 =?utf-8?B?bkhhMFljZDE2WXRlQnE5QnVPVk9nT1J0Unl2THc5OW1VbzRYemwyUjFOWCtD?=
 =?utf-8?B?T0xZcE94QVRnV3lLSGt0R3BPckxqbjFFUCtDenIrSW5nZEIwdWxaZDZ4UzF2?=
 =?utf-8?B?Vml6SmFVNDB0NHpFeGVsYkpnc2hRb01YVFNzU1VFOGpXNUFVeUdXOHRPK05I?=
 =?utf-8?B?NDR4WlZhZ04yc3RlMWJYbjFEQnU1WGdJbndPM3lra04zV0didWIrK2doZWls?=
 =?utf-8?B?N2FvZGFjalFGUU9CcTk0VGU3Q0NkaGNkeHo4VUNhUlRVT3lNRE00bW8yUWNs?=
 =?utf-8?B?RFZPSjFUZXkxczhsOVVTVzFEaXdFV2Jxd3RGdjVwUlZQVFpyWEFSQ2RoblZV?=
 =?utf-8?B?bzgwcEkxdHpuWHVneHJndEh2d0lEOTN3aE9pNnd1Rzh4SEVYMW9hN3hRcFVE?=
 =?utf-8?B?eE9peHU1NGFkcE44SHlqckNkREdCKysrTW80YlhTQTRYN1VvY0xDeGZRNWtF?=
 =?utf-8?B?Nk1qejhwclI3cWxuVm54SFZ0Q2prV0VhTmRJYUxSWDJkcVdVcnF0cTJ0bUtr?=
 =?utf-8?B?bm4rS1ZlMVZseWluVGI2V0ovb1o5ZGxzSVF6dEd5NHpwdG0rRHdFc0JkZjFH?=
 =?utf-8?B?eGR3cm56UjlISEE3Z0E1ZS9QemZXeFBSTFpQc3g5bDg3ZHFnajFkOVY2TmE4?=
 =?utf-8?B?b05teVFWOWprbWxzamcrWFBsbkU3ZkJBczhvWDY4UE1sWXRINUh0L2k0eEsz?=
 =?utf-8?B?SWZTK1VBSlBwcGtpNFErb0FwY1hjMjNyajFENFBCN3dKODFQVWhEOFR4OFdP?=
 =?utf-8?B?Q3J4N1phTDRlUEs3dUtPaVVpWEN4SmNNMjhNNXN6Mk1wRmZ5VjZ6Wm0vRHBh?=
 =?utf-8?B?MWoyQlBJcEV0RXl0dENUeXhuUGZqNWwvSFJMY3hrVVJGdmxoWkJ3L1ZScmJX?=
 =?utf-8?B?bGsyejI3MnY4RUhBOU14NlR4VmkxR1ZWK2p3UW9VbHRLb2ZUYzBaeEZrNFJU?=
 =?utf-8?B?bHZQdSs5QkpPTXEzZ0JxMzYrWU8wSmtqTjdHSlFNTENPaUZrQ24zOWJQQTR4?=
 =?utf-8?B?TTAzY0VRNU9lQWxyb2tMakZMOGxqZU1UUm9rMEZtNjUvSG1ROTJ6Y0FBRHV0?=
 =?utf-8?B?aDV1cHlqWUxoMXp6TGNZa0xaN0hVWnc3KzIwRDdxY1paVDh1aDcxb0NpdTNk?=
 =?utf-8?B?T3dpRlY4M0dKRjd6a1RRbWY3VlFCc1lia3NLRkdnbWE2TWpFalhXdXBnc3FQ?=
 =?utf-8?Q?S3EM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8e87af-2c4b-4d16-f2d6-08db0e18a155
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 23:18:35.1513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XUuSOAYdnO7F3U4dtaITutPggIfwaGYU5/2pWUuXP/chhJGprDs1gS58LRYuPtPGsWt2Yk8AzPxgoKppng4JcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBCbHVlRmllbGQtMyBoYXMgNTYgR1BJT3MgYnV0IHRoZSB1c2VyIGlzIG9ubHkgYWxsb3dlZCB0
byBjaGFuZ2Ugc29tZSANCj4gb2YgdGhlbSBpbnRvIEdQSU8gbW9kZS4gVXNlIHZhbGlkX21hc2sg
dG8gbWFrZSBpdCBpbXBvc3NpYmxlIHRvIGFsdGVyIA0KPiB0aGUgcmVzdCBvZiB0aGUgR1BJT3Mu
DQo+DQo+IFNpZ25lZC1vZmYtYnk6IEFzbWFhIE1uZWJoaSA8YXNtYWFAbnZpZGlhLmNvbT4NCg0K
RXhjZWxsZW50IHdvcmsgQXNtYWEsDQpSZXZpZXdlZC1ieTogTGludXMgV2FsbGVpaiA8bGludXMu
d2FsbGVpakBsaW5hcm8ub3JnPg0KDQpUaGFuayB5b3UgdmVyeSBtdWNoIExpbnVzIQ0KQW5keSBh
ZGRlZCBmZXcgY29tbWVudHMgd2hpY2ggSSB3aWxsIGFkZHJlc3Mgc2hvcnRseSBpbiB2NC4NCg==
