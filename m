Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FD46AC495
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjCFPO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjCFPO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:14:26 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287CE27D41;
        Mon,  6 Mar 2023 07:14:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIWnqBFBg+1Xlrq3sWenWE9mSfSbg7ZaN3MUpVfVy+wI2tOTZYKZnMo9zeGixeCkHwZ7xPwaZ1Vi98arIWoOAh4azazJRmL3Vc3WJD8bXJ0q2t66j9a9NvT4CDysHU0GEnqWob23LmK1rpuOhA6Cl3ar8eA3wJN6sS73kO8PVRZY1pe+LuZqp7ScQvHTqNuych/IY+qNPlZjHyuH3YoIzNx5VtnH1FuWmbgpMdWmmUAudWG/lCgqzf5R8U4dPgqGaddirE5DezP77VZ+RGgxa3URw4Dy22nYq9WDKp9AStq1M5a1090j9I498qrzCX8rZZzsDINnAUY3dbJdc/UFvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTNDvconQkCn0To4FR706F2mhGepPLNso/cZ03Omet4=;
 b=d7vfteMQ3l3B2eWIFeFIFWXQAFxndvhvaxT6LuamolwwKK/LgTEEgi/tUscFa5G4jZfHJLfxTplT11sn1xG9Nbdd3c/RZvLvinIP6P49pgdd0NTVQzi3LisUleAFt6a5iKor18CPTiO/sfem7M0ZvV88KHxfGTEqQFLnZRCnQM/GBGKzjvckwcXmBk2h+D0vWzT1BqM2k5r2OuTfSYhcoGanobghSqoL2gaGChaNacCtClm0HsN8dc5e2Us215t61KSADENTGgrvmDMmnr1+5mmK28qYiFdSWeTepTto5HF7Gt6qwpltTFu0rA/a5WAyaOlERPedVFUZYbLGdgI/yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTNDvconQkCn0To4FR706F2mhGepPLNso/cZ03Omet4=;
 b=NoLun0xPraV2MSIIQSIaLPfxklpCrLuhnSqyIONozXGfg4a3MqOH9oNVj12DtgauFuKHblTpHQQdOueSEOTs7kHVSDslLs0leunXRItlJ46SsQBClWANiyq1fKErT6sD5kJ2bkEdkVfl2/iXuR/hL77C1z36pmUvtbUJw3k8ZKk=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 15:14:07 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614%9]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 15:14:07 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 0/3] Fix problems fetching TBT3 DROM from AMD USB4
 routers
Thread-Topic: [PATCH v4 0/3] Fix problems fetching TBT3 DROM from AMD USB4
 routers
Thread-Index: AQHZR8ro+wTDMT6+GE+/UoHe567zba7tlKaAgABYKyA=
Date:   Mon, 6 Mar 2023 15:14:07 +0000
Message-ID: <MN0PR12MB6101C93AC579DB2E23952D83E2B69@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230223210743.9819-1-mario.limonciello@amd.com>
 <20230306095753.GD62143@black.fi.intel.com>
In-Reply-To: <20230306095753.GD62143@black.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-03-06T15:14:05Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=c0e0704b-4488-44d4-9062-62b94d73420b;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-03-06T15:14:05Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 646c1155-d6a3-4506-b52c-5ba2fcf47ff6
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DM6PR12MB4370:EE_
x-ms-office365-filtering-correlation-id: d4ebde34-efc6-4157-dfb4-08db1e556e25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SqRcYuuEp2k+4rq3oFjETPBrFkeg/lGlmQh5yQQ743F9gZvxJOl62gX4NNBoJ5w0RWu2J6n+p3A52lPbZXrSuuAnZ4lPet8nnzZXKhUR4lEL5xdTOdw3C2/IixxlmiLMTIbq9outLNGC1nNkzaObsPTemrQcTnOSNwqzWh28QQgw0FI9ZnnLhrKgFUXjZWaLs08lBhueCVxnLmy6oUpR83nZ7Xemahct46g9TnCuTQq8BJpRgzLWeCFSOjT71kzZ7P5TjTSkzcZbPx448V+ulQecuI+8rxVmt7+aUevD313F0ShFiVTCV67U5o24xkpYDLTHaI1lf23Pxj88QkYrsrzC1w2CFcdEGiX9p51abQV9ML1Zsc4iITzmlzS8w/ZGzDSx+kTx+mC50NG3JXtF3rSBOofe5/oZdbYdE0+RwPaDC90jfnWjzp64ropY4SVm47Tziv9qbcT6Ltaqr9TFHugZDZq91nMYt5OvmJ1Y7epTnfNEHI5XgKy/IC7jfufxRPpf/Oef1bQjfDMXijUdWm+7gtVnvJNQeX251CHaydBkhkcXx3Cl5PCcoX9NGOoRwcsL0dTFWFoBzVJKX0mF78nedyLqnhyI+xkpPBd36lnamH7iOor/1ELhoktNMr3jRDEow7YPlrol8FhBnyXTe0DCar+lTBsOtdn+yWh35Uf/KIgdrrOTZgRKteoZOgRc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199018)(84970400001)(66574015)(83380400001)(33656002)(478600001)(54906003)(55016003)(38070700005)(316002)(38100700002)(122000001)(7696005)(5660300002)(6506007)(53546011)(186003)(9686003)(41300700001)(66476007)(71200400001)(52536014)(66446008)(66946007)(64756008)(76116006)(8936002)(8676002)(66556008)(2906002)(6916009)(4326008)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1czV25MTkxnTG44QUxXd2MxQ0xZNmdzcGpNQnlyMkZKdTl1VzhYR25IQUtI?=
 =?utf-8?B?QXJkM1UyaGtRbVM0d0tndDVqd01waXZCVUs5elBES0xOTEN3UGdIdjF3V3hB?=
 =?utf-8?B?a0J3VGpOTGVqTU1QcFFtSUFiM3JiSmZXL2FUSUZubkMwWG1KZXg5UG1FQlFh?=
 =?utf-8?B?eDlRL1FEaWhlVVMrMkRUTFdsWGJWVDZ0ZkJncVdjNUZZMUZ3M2dpdDZ1cE9i?=
 =?utf-8?B?ZmhuaUp2QnpjK3ZCTXNkbStkd09lS1Y1eWxRTGsrbXZyQ3RkRG5OTFRrR2hR?=
 =?utf-8?B?UU1lOGtkWW5IVThlM1JNWkIrNGFFQlJkV0JueThYVHc0dGRkRkxoRllMK3Js?=
 =?utf-8?B?VUNSNVNlREtERnpkeUwxUk42cHNIT0sxczN6UllVdTBkSzRMeld2OEtXaW9y?=
 =?utf-8?B?QTU2clgxY2ovRndtYVRTQVpIY3lQdTRsVjFmbGRmSTJkajlKR3VTbERwQUFu?=
 =?utf-8?B?elBEOGIycGVadkswamprcnJjR3J5amFZWjQ2elo5WFV4eWd2c3ZPMVIzaXVF?=
 =?utf-8?B?UWRma3k2TmJqbjUwMFpkYzN3cENUdlB2WXVLKzJXZEg3elF1REZBZHJQUHpl?=
 =?utf-8?B?dXFUUnlybkpqNnVPQmh4OXZOSDAzRWJqaDZ5REFYeEkySXhHbXVTakZpOWVF?=
 =?utf-8?B?aHd4TVJCajZuTjBQdFVTaWdINCt4Wm52UDhiNkYrU2oyTkhiNmN6U1dib2ox?=
 =?utf-8?B?VWdQZGZqQ2RPRDRSdWFzY2ZvbFBxZklEUlNWTDJHRXVLZzRqQWlNRlRuM1dU?=
 =?utf-8?B?b3gyakNhYXB5Z1RlemVTWEp3REl6WXV3NEl5cmUrUXViVmM3TEJtczJyeW9y?=
 =?utf-8?B?bEI0MnQ4QkFNekNWMGg1Yi9qRHBBYkQ0bmZEOHAveEw5M3FJY1JXSmVuTHpP?=
 =?utf-8?B?MGRxOFBZMnlTTmFPcDd2aW95cm5tSGpCSmpHbmd1UjhSUGQ4MUcrSUZJTkgv?=
 =?utf-8?B?ZVBGbVdvZFM5L2duTEZyc2liYnZrSkNyNko4bVY0SWI4d29GbFdROTdDQjRI?=
 =?utf-8?B?aVZmNjFpU2NEOU9hdEdMK08waXhaN0g5UGs4OVI4dzhoWlA0ZkZEK1ErNmVV?=
 =?utf-8?B?bHorTHBHTS9CWm91aG5jcysyM2VYbW91SGlLaTVJbWEvM2Q5eFllOUlOallY?=
 =?utf-8?B?SzlvWU5EYlc4WWlpNUFyN3Z0aXJwMlM5WW9INFFzOEpyZU9RSmZrVnVqcXdE?=
 =?utf-8?B?Yk8wa0JPMUNwZjlURTRIS1paQzdZUm1MQjY1aUV6ZlJhdm8ycGQ5UjBBWHY2?=
 =?utf-8?B?S3BsUnZXU1dsYXhHcE1DQ3pkTDVRK3N6RnBYejJrbnQrUnc2OVpRMXRQeUtz?=
 =?utf-8?B?T0NmelVPTGhiZTZZRE9RUzNkTjBvZ293ZXU3VkJpVkVGUm5EaWo4cnNSNjVj?=
 =?utf-8?B?V3hQaHU1dFU0VlRHVjUrQVp5bEZiZVBPL1ZuU3ZiYndUeTFEQ3Q4TVBLNVJO?=
 =?utf-8?B?VmVuVUVjTGJDSDNLZmt5d2g3bEcrQWthUGVLcTFBbmhUbHcxSHVCVXA5YlJS?=
 =?utf-8?B?QUlrSmxLeEhEd2F2OFptTnRjQjViVExSdnUzU1ZjSG44NnVoLzV1eXhncm0w?=
 =?utf-8?B?Q0d2RlgwRWxKUlkveDdnYXBXSVFhcjF1eTFUb2l0QzN4NzhQQmlGRGdlS2RZ?=
 =?utf-8?B?UHQ5M0JpRDB5b2czVFllYWt0aFE2cUdKRnRrZVRsZm40eHRScXZSTElNZzQx?=
 =?utf-8?B?VHUxZTNlMEMyMGZWTHpqMG9qMktkVUc3cjhaSnpyM0NUN1Q0NHZHVzN0bTRm?=
 =?utf-8?B?YWt4YlVzb0hISUZQTWpEbXhGU2w1VUZ5c2x3RE9IbjkrWDNhOGVsWUVubjZH?=
 =?utf-8?B?dkpYdGZ6cVowUEw4czd2MTVDb2I0WHF6V3ljUy9HWUgxeEVkbE5Za3U4cURo?=
 =?utf-8?B?ZVFvcXlSUC9pU0d1RUlwWWZGRG5YeUROVjdUUThpMmJpdkhyYUd1SFJ3OGF6?=
 =?utf-8?B?ZlFZS29uUVRWRllJVWQzUUZwaHdyMU1XTjEzMUNxMms5Sk9GRVFNT1ROUDhD?=
 =?utf-8?B?WElzNUt5Y0ZMRHR6WkZVVWpoakp2MHB1dk9WYkI3eHNjWXJmZnc3ZEdOMVhj?=
 =?utf-8?B?U3pBNDhnRXJoOG0rQzRZZFAvZk5TV05PWWt5WjFiNEZjSXlqMFBqazhmRWN3?=
 =?utf-8?B?MCtaNWFqUmxPRTNjZjZvREVhdjZiSGdSQmxlRzV3M0ZXS3M1UlpHSlcvTi9T?=
 =?utf-8?Q?d4VIzIY5qHI90/2qNE1013A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ebde34-efc6-4157-dfb4-08db1e556e25
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 15:14:07.1774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8QWjnJWc8cagkOlJi+KLKwb7BpaRUgVfVmjx3DZmUI0+1a73V6btBIfzkny7JPMD+1d4kbN8bibXoUfsJKf+yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWlr
YSBXZXN0ZXJiZXJnIDxtaWthLndlc3RlcmJlcmdAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBN
b25kYXksIE1hcmNoIDYsIDIwMjMgMDM6NTgNCj4gVG86IExpbW9uY2llbGxvLCBNYXJpbyA8TWFy
aW8uTGltb25jaWVsbG9AYW1kLmNvbT4NCj4gQ2M6IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7
IE1laHRhLCBTYW5qdSA8U2FuanUuTWVodGFAYW1kLmNvbT47DQo+IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAwLzNdIEZpeCBwcm9ibGVtcyBm
ZXRjaGluZyBUQlQzIERST00gZnJvbSBBTUQNCj4gVVNCNCByb3V0ZXJzDQo+IA0KPiBIaSBNYXJp
bywNCj4gDQo+IE9uIFRodSwgRmViIDIzLCAyMDIzIGF0IDAzOjA3OjQwUE0gLTA2MDAsIE1hcmlv
IExpbW9uY2llbGxvIHdyb3RlOg0KPiA+IFRCVDMgZGV2aWNlcyB3aGVuIGNvbm5lY3RlZCB0byBh
biBBTUQgVVNCNCByb3V0ZXIgb2NjYXNpb25hbGx5IGZhaWwgdG8NCj4gPiBwcm9wZXJseSByZXNw
b25kIHRvIHJlcXVlc3RzIGZvciB0aGUgRFJPTSB2aWEgYml0IGJhbmdpbmcuDQo+ID4NCj4gPiBE
ZXBlbmRpbmcgdXBvbiB3aGljaCBwYXJ0IG9mIHRoZSByZXF1ZXN0IGZhaWxlZCB3aWxsIGltcGFj
dCB0aGUgc2V2ZXJpdHkuDQo+ID4gQSBudW1iZXIgb2Ygd29ya2Fyb3VuZHMgaGF2ZSBiZWVuIHB1
dCBpbiBwbGFjZSB0byBsZXQgdGhlIGRyaXZlciBoYW5kbGUNCj4gPiB0aGUgZmFpbGVkIHJlcXVl
c3RzOg0KPiA+DQo+ID4gY29tbWl0IGU4NzQ5MWE5ZmQ0ZTMgKCJ0aHVuZGVyYm9sdDogUmV0cnkg
RFJPTSByZWFkcyBmb3IgbW9yZSBmYWlsdXJlDQo+IHNjZW5hcmlvcyIpDQo+ID4gY29tbWl0IGEy
ODNkZTNlYzY0NmYgKCJ0aHVuZGVyYm9sdDogRG8gbm90IHJlc3VtZSByb3V0ZXJzIGlmIFVJRCBp
cyBub3QNCj4gc2V0IikNCj4gPiBjb21taXQgNjkxNTgxMmJiZDEwOSAoInRodW5kZXJib2x0OiBE
byBub3QgbWFrZSBEUk9NIHJlYWQgc3VjY2Vzcw0KPiBjb21wdWxzb3J5IikNCj4gPiBjb21taXQg
ZjAyMmZmN2JmMzc3ICgidGh1bmRlcmJvbHQ6IFJldHJ5IERST00gcmVhZCBvbmNlIGlmIHBhcnNp
bmcgZmFpbHMiKQ0KPiA+DQo+ID4gU3RpbGwgZXZlbiB3aXRoIHRoZXNlIGNoYW5nZXMgdGhlIGZh
aWx1cmVzIGRvIG1ha2UgaXQgdGhyb3VnaC4gSW4gY29tcGFyaW5nDQo+ID4gb3RoZXIgQ00gaW1w
bGVtZW50YXRpb25zIHV0aWxpemVkIG9uIEFNRCBzeXN0ZW1zLCB0aGV5IGFsbCBhY2Nlc3MgdGhl
DQo+ID4gRFJPTSBkaXJlY3RseSBmcm9tIHRoZSBOVk0uDQo+ID4NCj4gPiBUbyBhdm9pZCB0cmln
Z2VyaW5nIHRoaXMgaXNzdWUsIHRyeSB0byBnZXQgdGhlIERST00gZGlyZWN0bHkgZnJvbSB0aGUg
TlZNDQo+ID4gaW4gTGludXggYXMgd2VsbCB3aGVuIGRldmljZXMgaGF2ZSBhbiBMQy4NCj4gPg0K
PiA+IHY0Og0KPiA+ICAqIFN0eWxlIGZpeHVwcw0KPiA+ICAqIEZpeHVwIGZvciB3cm9uZyBwYXRo
IGZvciBVU0I0IGRldmljZXMNCj4gPg0KPiA+IE1hcmlvIExpbW9uY2llbGxvICgzKToNCj4gPiAg
IHRodW5kZXJib2x0OiBBZGp1c3QgaG93IE5WTSByZWFkaW5nIHdvcmtzDQo+ID4gICB0aHVuZGVy
Ym9sdDogdXNlIGB0Yl9lZXByb21fZ2V0X2Ryb21fb2Zmc2V0YCB0byBkaXNjb3ZlciBEUk9NIG9m
ZnNldA0KPiA+ICAgdGh1bmRlcmJvbHQ6IFJlZmFjdG9yIERST00gcmVhZGluZw0KPiANCj4gSSBz
cGxpdCB0aGUgZGV2aWNlIHNpZGUgaW50byBhIHNlcGFyYXRlIGZ1bmN0aW9uIHRvbywgcmVuYW1l
ZCByb290DQo+IHN3aXRjaCB0byBob3N0IHJvdXRlciAoYXMgdGhhdCdzIHRoZSBjb3JyZWN0IFVT
QjQgdGVybSksIGFuZCBmaXhlZCBhDQo+IGNvdXBsZSBzdHlsZSBpc3N1ZXMgYW5kIGFwcGxpZWQg
dG8gdGh1bmRlcmJvbHQuZ2l0L25leHQsIHRoYW5rcyENCj4gDQo+IFBsZWFzZSBjaGVjayB0aGF0
IEkgZGlkIG5vdCBtZXNzIHVwIGFueXRoaW5nIDopDQoNClRoZXkgbG9vayBnb29kLCB0aGFua3Mh
DQoNCldvdWxkIHlvdSBjb25zaWRlciB0byB0YWtlIDhkN2Y0NTkxMDdmNzRmYmJkZGUzZGQ1YjM4
NzRkMmU3NDhjYjhhMjEgdG8NCnRoZSBSQyB0aG91Z2gsIG9yIHdvdWxkIHByZWZlciB0byBsZXQg
aXQgYmFrZSBpbiBuZXh0Pw0K
