Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E657D6FC236
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbjEIJAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbjEII7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:59:53 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2124.outbound.protection.outlook.com [40.107.113.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE1CDC4B
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 01:59:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7ODB3RE/CePRxgwpfoVmXaPeNaTW6syZ0wwjgQtVdF5jXpUgiFLCRx1hJOrjb+5I7wDIWNd2WNDM9sbvDs5b0R+UTW8Z8HaeaO+7mIotobE08M63Q+ZJ9v4yCAXyhI96wMmPHGB/dcWQb/0jGCtC+lVyvI6V6Mt+db0M8FJyuRNBxJ+VLRqhO4s8VgyeFWl5vTSmhCioE7Bn6ik5KPFruiKPU0mJv2G5WHXtJR+EGcv6mkkD5Hp/KiA8OahIGoTiD1SBnHPXpUE1bx24rp9145Cz+ZjuTCRmXdSSoXZnc3Am1czYz0z3FwGXqnsuj9m9JUjWbd7zU3iDW3FGs5T5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoEPW4pJPjTaDQtJCGErFBLMIl+KIo5ITejHqEP0i+A=;
 b=PQixmvu/o2yjofxsNgCNp89e+nAvNDzb1QlTFAZ1vc95JT0bXzF7+NK3/d6MVok8S3lmyTqs1y+E0grlaOwMzqF1z8z5e8zM8/nQXOSm7sOZt+Y+4poC62w1iLDzgb+j3A3p0Poi+0SSHCqtn9rLQTjzbhG9eGcEuF7ZVNOr6aQxNs8m1MTs7b6qf2JVq8YMCL+v833bI3IQvgnumKeoLM0X2sbg0cWG+QbiM55ERSD+us+0VsxsDbXM2oNyhlWi2NxDXqhzseUhAjZfrYSbsSsdS4UbW1mAG3W4WqyPmyd0yekrsGXIx0SbRt/PynF54JusH4GpOtHpiVaZAj018g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoEPW4pJPjTaDQtJCGErFBLMIl+KIo5ITejHqEP0i+A=;
 b=jcr/r3REV5tlZFLuaL0a58XpYhyrDeOWG+rpckKPieNqyPdYKZZiW4czXsAOPvHIQsrled4QzWvvSllfuTDTtqjvwDm4dyKCtnOuumw2AnTIAnX+mFSbUbqEoPihjovj2LGsLYwyGWTK7Hu3MtHkhREIAmoh24kl2S+x1RQ3Zjs=
Received: from OS3PR01MB8460.jpnprd01.prod.outlook.com (2603:1096:604:197::13)
 by TY3PR01MB10419.jpnprd01.prod.outlook.com (2603:1096:400:257::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 08:59:43 +0000
Received: from OS3PR01MB8460.jpnprd01.prod.outlook.com
 ([fe80::1813:de93:4f41:149e]) by OS3PR01MB8460.jpnprd01.prod.outlook.com
 ([fe80::1813:de93:4f41:149e%6]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 08:59:43 +0000
From:   DLG Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
To:     Marek Vasut <marex@denx.de>,
        DLG Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        kernel <kernel@dh-electronics.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V4 3/3] regulator: da9062: Make the use of IRQ optional
Thread-Topic: [PATCH V4 3/3] regulator: da9062: Make the use of IRQ optional
Thread-Index: AQHZUm0IF1GSksUHy0Oy5/nCFvmu+68xu+CAgA2JkvCAEJBXgIACLIvg
Date:   Tue, 9 May 2023 08:59:43 +0000
Message-ID: <OS3PR01MB8460C4A6047EE4590D4F791FC2769@OS3PR01MB8460.jpnprd01.prod.outlook.com>
References: <20230309092254.56279-1-cniedermaier@dh-electronics.com>
 <20230309092254.56279-3-cniedermaier@dh-electronics.com>
 <bb6f5cf8afd54836959ebfb0455b81dc@dh-electronics.com>
 <TYCPR01MB847111D756F520761D720716C26A9@TYCPR01MB8471.jpnprd01.prod.outlook.com>
 <02349503-4542-cbfd-2a2f-379fe8284cca@denx.de>
In-Reply-To: <02349503-4542-cbfd-2a2f-379fe8284cca@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB8460:EE_|TY3PR01MB10419:EE_
x-ms-office365-filtering-correlation-id: dbebceb0-a9b5-4330-5dbf-08db506bbb32
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2/LOcmPbzL6CULAcsf1cpRJjLGHbOM6d28HOeNuUsp0VHWEBYdXCp9xRWEUlzuEb8yAlfeeLqghUojEsalj48GW/NJ5IFePsbt1oIwaOWM+/9g/FCNTKZi3UGKQPLqrpydI/201J8SZnDthfAOdbVY1YMqyJEEa19TRBp/Mr0hNjew+44ft2OI4sijmZHTQXv4LcCuxS/g/UhR7BpMl4yp5HQGE/7VPSD2NXmASI3Y+XuitjEDjAwWKtorOTWGCah2sJEldbHEy+oXe9B1ygY1s0ddDA7FJPdt0wFoklOadZRMfItgvCXpNrBSKjRDVvIQGmtMhQ6vNWtzyvVIBlZKm5TTJ+e8Y+rMzEeObOnml7WOPVc85d9naCTErrQrTQmUBGXme+I/QavoqssNhCDgncNASFTyOZdhTXejq6eiXGUaLH+VRr+r6AAcSoFWQB9T5JSBkni8vGfqcxMXVIzkMbOjujwZh7djtWFiLFVQ0nAgqpHfhE81s9cnwKhons04Vdz4FWXrWhnQG0sQ51fqrJ/5NwuksH2eoEcHt/NT21ckeaN/xPsnniZPPBPrgV0OK35MuN6kuhMjPSayA8J81UHHSbsn0pFy3HlNK6nYtPQ0GhUtAQ61jmKzNdCYfA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8460.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199021)(2906002)(186003)(4744005)(6506007)(9686003)(53546011)(33656002)(38100700002)(83380400001)(55016003)(122000001)(316002)(38070700005)(71200400001)(76116006)(66946007)(66446008)(64756008)(41300700001)(66556008)(66476007)(7696005)(4326008)(110136005)(54906003)(86362001)(478600001)(8936002)(8676002)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0xwU0hkZWkvZTR0TGoyTCtJaVhGZVZYUzVTL1JtWUh5MlZsWXVqK0lUUDMw?=
 =?utf-8?B?dG9hU0hVUjZSK1ROVWk1MVlzY0RZVGR3Q3B4b0ZMcGNDNm1xd0ZWb0owR3ZZ?=
 =?utf-8?B?VVRaS3ZWZ25GMEhpdnBHcHFkQ2p1eTBYSndCSE5JZDhrWnlTcXNZQ0UvYXVE?=
 =?utf-8?B?YjJkUmk0cVNGM1BoMGxvOUVQNUZicTB2YkRtdmpESGRxa3ZuUWxkSFVMVGRi?=
 =?utf-8?B?YlZqUlI2UytpalExY1ZGNkdlYTg5TXhaMlE4RnNhMEk5U3cxSER0M2xVUHpT?=
 =?utf-8?B?aTN0cUZuZGIvQmxUaHZ4WW80ak9CSllNQ0Y5aGgvaU80dms2d1hncGVXU3FR?=
 =?utf-8?B?dUFsOUc4aERodlc0UzNDZkVKZVh0eGlpU1pQbjRQQmtEbkpSSjA1U2IyUlVU?=
 =?utf-8?B?TTBTWWhHUXJCbUhzb2VESUUzSGEvNFBKb290eXRJSnZ6Qkg1Ukx3eFF6Zjgx?=
 =?utf-8?B?QUhVRi8rRUZMbGZXaWw1a0JKb3ZqV1ZtQU1LVEJtOUN4MEsrRk5mK3RLVytY?=
 =?utf-8?B?Z3Npbytob1NCNTRxMGpKNXYxNDRrUExFaGpRdkl2TnBrRmw1S3JUSjFYY3o1?=
 =?utf-8?B?cW9ZemVqUUU0QytEZXNrRUZOMU1qTnh6elBqVEVSYkx6cmFvRlNzSHROOHBI?=
 =?utf-8?B?VVlmbkQzaS9XZitnclNjbjZSY3FkR0xsNnlJaDNpUndWVmNRZHdpV1Y2c3Ny?=
 =?utf-8?B?dE5yeDR1Z0VHTjJjb3lOSytMU0JiZXhlQXZKQzZpK1dCdGRRZEVxNmowYnp6?=
 =?utf-8?B?NmJocllXMXRzK0hmalZWMUk4cWRCV1QydlpiTnBjYklvblhLVjNkMnhLZmZy?=
 =?utf-8?B?Tm1lOHdWSU9raXYzaHNpSFFvbUtEQ1owQm1rYjBEVDR4SzBnWjhDL0JLZW9V?=
 =?utf-8?B?U0dydUlMcXFnRUhGUjl1OGJsUHd2SUxYNHhPZ0ZYNkNNcXlBMGJ6Ti9IR3Zi?=
 =?utf-8?B?K2w0UVpRdWtpVUlFdndTR2VsaVkxSkN4MXhGNlpFV3VrU0lvSnQxYzNiQnBR?=
 =?utf-8?B?MUJvRVZXdW43Szlaa0toQnVyRmRMWkpDSTZMUWVMcU5kV1YxbDd6L2plSVNs?=
 =?utf-8?B?aDlwVXFQRzlSTDR5emNOVlZ5bW5jaHluYmdxOXhISGlzWk1RV3FkV1ovWXZh?=
 =?utf-8?B?QkRKYXI2NWUxYXhTOHNUYUxGVkNQMThsRy9vVFJRYUNyYjBURC9zRXUwK2VJ?=
 =?utf-8?B?WUhaL3N2UWZSUmp2dGpLMjB6eFowWjh1L0tzUk5yR1ozUlFPUURZRWtNODRU?=
 =?utf-8?B?YktoYXlaT2FlZS8waXFCT2J2VVJHRVdaT2RyMmNGV3dkODlRNW1rSzc1SnI1?=
 =?utf-8?B?amxZZllyVmFJRElzdm1VNkdTQzRrWU45RXJhSkJDSThKV0toQTFiTzlWbEVE?=
 =?utf-8?B?aTRvOWkvVGZtOFprbFVRYWtINWtiUVErT0R0cnVEa2d2cTlrdHZFVHR6eUxR?=
 =?utf-8?B?ZFh6dHhHQ3ErRDRsM09FM29BRXVOVkJKTjYwMVFFUDBrSUVEck1NbkltSmMw?=
 =?utf-8?B?UmEvdlViWXF6UWZiZ25DeU4vbmU0emtrY3lGaWRNVFc0NzY0TUNjL05DUVha?=
 =?utf-8?B?dTNHTFhWMmZBRWh6RlV3YzR4aWRNRVV4eDBKNWpIeXJqK0UyWW5zNjZkSzU2?=
 =?utf-8?B?VmVHcUVtZmZJa1lGRzZmVHNVaE1rWHR4UG9ienpROUdlZUFVQ2N0WHhZZXhm?=
 =?utf-8?B?TitaTm0wWHo3RjIrUXJMbFBEZnBnSTloUXQra3dPdlJTazlvcjdIclNLL3Zh?=
 =?utf-8?B?RHdvdWZNRy9CWHF4My9HSis0R2ZEanZYRkVMVEV0R0gzbVY0L2I4L1hud1Nr?=
 =?utf-8?B?N0xaU1I4QWkraGx2TzU0YTFEZTE4cjgrZXpnMVNiclpwYjJKbEM5dldEcXRN?=
 =?utf-8?B?NEEwcmdjSUphRlJ4YWplUFNsdE1RU2hWWDZKVTRLSXpuS1lzZHV3V2dEdFpE?=
 =?utf-8?B?am41NStHbVk5TGRibkdJMXR0OEN2WTllMTN4WjRLYXZuRzdJMVFELzl3VTho?=
 =?utf-8?B?OGcrNFFmM3V3Z21UczNheHVhODRhOUxlSEcxa1VnYXlGYnQ4QXY5TjZkRGND?=
 =?utf-8?B?a2RpdFJ1WkxwY0k5VVVNMC9ld3ZRcjlqeUR0K1ZEQkw2TzQ4WkpVZXJFQzRV?=
 =?utf-8?B?bUt6SE5Fb3orV0kyZVNUK0xtbW1BdW8rL3l0L0NjUGlTZ3hteEZPTDRhWVdI?=
 =?utf-8?Q?f75zBaurlZI+8KqOTIJK0PWrdJxbiuOeful+t4965o+N?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8460.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbebceb0-a9b5-4330-5dbf-08db506bbb32
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 08:59:43.5090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iDoEjaW+TaS+ewCcVYHkl7QsrrjNiO8GBvn7FO5ZeIQ351RvwpuPGovWQd0NfjGnZ8sPMhMLt7NeJ40peCcxf5fLHhYFjfPvM43BGkK1MrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10419
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDggTWF5IDIwMjMgMDA6NDEsIE1hcmVrIFZhc3V0IHdyb3RlOg0KDQo+PiBJdCBsb29rcyBm
aW5lIG5vdzsgc29ycnkgSSBkaWRuJ3Qgbm90aWNlIGJlZm9yZS4NCj4NCj5JIHRoaW5rIGEgZm9y
bWFsIFJldmlld2VkLWJ5IC8gQWNrZWQtYnkgd291bGQgYmUgbmljZS4NCg0KSXQncyBhbHJlYWR5
IHRoZXJlIGluIHRoZSBwYXRjaCAtIG9ibGlxdWVseSByZWZlcnJlZCB0byBieSAiYmVmb3JlIiwg
dGhlIGFwb2xvZ3kgYmVjYXVzZSBJJ2QgbWlzc2VkIHRoYXQgd2hpY2ggdGhlIHJvYm90IHBpY2tl
ZCB1cCBvbiBhZnRlciBJJ2QgbG9va2VkIGF0IGl0Lg0KDQo=
