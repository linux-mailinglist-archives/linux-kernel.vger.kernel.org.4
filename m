Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1576F8387
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjEENKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjEENKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:10:30 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8533A84
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 06:10:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhTgqR8E2qC/sDz9/DgULX/gQTWIVvQhgIg90SkiaoEvqCgw8ADo6fr0Mszn3ULlfEb3A+NlnRfhfKGGXOPEih9Y2300ODoCADG/FqsFnkodpBpviQkK0AW8efyQnsoDlRQl19CNRLyLdTM0W6zDJT1+HgD23Ah2iSqjH3eTowW1ouWeqtQqkVc59wkDjUs/pEjyno/vwAHEuzqO7VdkTw8kEnypFTKLX61koBUUYqDtB+6WrAFWfJjDqAee5A+KPxZ1qZHrLJ7GgOtRJWnVFMOwsjd1g8j184+eDsNA9ar+rTj7SFxmXkc8G7rQrAa0niHFOl1me3XbQdeDbcxAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8IZwxrGzlkK1p2GczQmGHr271QBY10Mi3sdr1wQ89g=;
 b=euFKK5qinDc64jLrWjVQuIxS5xyfUGNs2I5iidO4UmpOOtDAPOSEjFfSUtM7klba3Ba1Hc0P+9c6/M+B0psxcNYXhgtvwQMpIAWlWJ+SfEVgp8s1VvHn2+e+N2BGokbChCC2ebMyz9q9/N72Ls3TULnqbxwzLxbpkmqkPt20dqdYp9WGH9kng3hgK72D1XeiodkkJuVwe5Qh28KOdPFcXQKEw4Tl6m3d5UBILPgKJS0ctSB+ChtQXLH45PxoAJcSJhzL55tboosHLwvk/Q3jB7QE3pB7eillknpRG8HxycUaPu+9UaPPr47No9lBuLPujWxl4VutBAOr6YWTp6oKtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8IZwxrGzlkK1p2GczQmGHr271QBY10Mi3sdr1wQ89g=;
 b=JuEFuId1OMOcUmYthQXYBD6vOI3G7Dq3hoi5FfziTKS3LFrFTo2h+Q+DqqBB5c8nqZUgoObDL/EZIl4X0v3uQfFj09bDHvJ/+7VJu6sG4k2dX6Ucdv5Yqkh4+gBobktvuAMD3HVe0mQqpZEpGaie6m+cuB0w2WRvhMWsv6OMHVc=
Received: from MW2PR1901MB2041.namprd19.prod.outlook.com
 (2603:10b6:302:12::15) by SN7PR19MB7522.namprd19.prod.outlook.com
 (2603:10b6:806:34b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.11; Fri, 5 May
 2023 13:10:27 +0000
Received: from MW2PR1901MB2041.namprd19.prod.outlook.com
 ([fe80::70cb:42fc:67e4:9760]) by MW2PR1901MB2041.namprd19.prod.outlook.com
 ([fe80::70cb:42fc:67e4:9760%4]) with mapi id 15.20.6387.011; Fri, 5 May 2023
 13:10:26 +0000
From:   Bernd Schubert <bschubert@ddn.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Andrei Vagin <avagin@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: fuse uring / wake_up on the same core
Thread-Topic: fuse uring / wake_up on the same core
Thread-Index: AQHZXonZnrNnGQvxikaxtbJ88GLEB68OcL2AgC/yZYCAAOYogIAAE+eAgADLvYCAAVIbgIAEtDAAgAAvKICAAqcqAIAAmmAAgAJI6wA=
Date:   Fri, 5 May 2023 13:10:26 +0000
Message-ID: <7bc9fdd6-a1b5-505e-3a0b-71a18084cc57@ddn.com>
References: <d0ed1dbd-1b7e-bf98-65c0-7f61dd1a3228@ddn.com>
 <20230327102845.GB7701@hirez.programming.kicks-ass.net>
 <20230427122417.2452-1-hdanton@sina.com>
 <20230428014443.2539-1-hdanton@sina.com>
 <d954ca54-2a3f-b111-7ba5-41169de473ce@ddn.com>
 <20230502003335.3253-1-hdanton@sina.com>
 <20230504021656.3823-1-hdanton@sina.com>
In-Reply-To: <20230504021656.3823-1-hdanton@sina.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR1901MB2041:EE_|SN7PR19MB7522:EE_
x-ms-office365-filtering-correlation-id: 5533c4b2-ed65-4c10-32db-08db4d6a181d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /u0mOL/iS6RwU422VQguqqzhlFPd1+b41c79+o5xrPHoEED8hA4z1SjFl5Wu6fauhKHmlurHKZAqniFQUKhcRrG8/Lw3NvYzWPJnmMyWh1/NwyAJ9JX47ZNmx96n+skdDYOd0/3ApC94tYYEo/9C01dULklvlSeGsejHR6OhPPBkh6RUml52N41e8symCxQM0vzGCdc9L2jWDbJwzJUwehnGARk5+RthsZLB+h/G1WG7X67+M5NA8+zeqEMOIcKggHcbcnovW98MxtcMeZArfwJ95ArsUyMpRjOX5O3ixRvVQ91JfFMScVS4YhaYH6PZYkv9z6K4avlq2HAGymoD/qeLt97MoYOes1lkNL9J2YOpcioGFN50qKOC3O6n7ciHAN6TTx5amDm6KfDQISitOJs+lVR4ITatgseN2Ob8gHWK75nZq8Xp25MWwKpQEoI4Sp0xeqxibDjPbP6UySqIYEkcSnohU1BdpSQBzctrzn2fy8U10uXfdTjR8UtIGLIzGz+WexfkNaiWNP5IzMeOfaGoXU8TuG4OfqsatIj5VGCJutlIrJs9PfpjFPaHM3WbMSog6sPar4BMtY+GBtosGSAlYovPXPA/jY1/XgIMFR+5E5awdvMQQweFkJb6zygVxSob2hQOjcnwd3MKUFl9EQUX4QlWUyEgrsJeFbddQUqx3pnm7lU5QeQFWttEhnuQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR1901MB2041.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(396003)(39850400004)(451199021)(31686004)(4326008)(76116006)(66476007)(66446008)(64756008)(6916009)(71200400001)(6486002)(66556008)(66946007)(91956017)(316002)(54906003)(31696002)(36756003)(478600001)(86362001)(53546011)(2616005)(6506007)(6512007)(41300700001)(8676002)(5660300002)(8936002)(2906002)(4744005)(186003)(122000001)(38070700005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkdxVlVFN2ZaOVljbi9sTzBMNDUwaldQRm85eC8zclphdHJSSWluZDJRa3hV?=
 =?utf-8?B?V0x6NFRZNFpnSmt3WmhlK1VjcDgzVXV5b0MxNDBPWm5IWjdrRmJDdXduZUMz?=
 =?utf-8?B?R21XbTZycDVCT29STDEwOHFobE5weXdXbXJGemo4Z3dzUGFWWURUZUN2aEd5?=
 =?utf-8?B?ZnZJMFJwc2ZCakNJVTQ3eWJEbmczdHpoQWZNRVBzOHNrYUE2QzNzaG1mb3h0?=
 =?utf-8?B?RCs3TFgveDNDOEdIN3ZvL1lIOHUwL2xyalpFbGU3aW44Zlp5dHg4SXl6QXBT?=
 =?utf-8?B?NHlXNEdsTlk0eHB6dU1jQ1ZEbnRWWTNLY1Q1ZTI5UXlMaEd6V3UvanE4VG9l?=
 =?utf-8?B?Z2ZFUTZCNVpIRk9ma25WaVRBaml4bkIrVlBvUDdQQ0MxNVRKU3hlcHZqVEY5?=
 =?utf-8?B?SThUdDRaME1hTDRrVDlHM2lCNTZQUVJiYW9ucFduNk85cktZb1RlYTF1M1ZF?=
 =?utf-8?B?ZTI4dWdOYW1aQnhrNkUrRkJpSEpGQ2VyNEVTOGRUNHY3eFUvNC82YjJhUWtW?=
 =?utf-8?B?S0pHL3RCazU1TkNZRDlESEZlNVJNMm5TeU5Oc0ZudG8zaW9taTByMGVqKzNw?=
 =?utf-8?B?bjJmWjZTWEFXS2NDMnVjZ3hDcUsxM1BsS25kNkVDWVR1Q1BzU1FqeEJiZW0v?=
 =?utf-8?B?ODRrMEIydkkzTU9tOEFqcVN4cWNtY0VPQTJ3SVkyaUtzMUcvaUFQeW10cVJo?=
 =?utf-8?B?bVdnaTJVcGRCYi8vQTVjWXoycmF0TS91emxCYXhrV2QzMWR0aXNDaDFwTDU4?=
 =?utf-8?B?UE1vMFJwNjA2RUhMdkNlVjY5cDRkZUNFWlVLTHhxQ2NhdWs2d2oyVytBcGZv?=
 =?utf-8?B?dXVSZG15Qk9zMSt3YWZHc3Fub2NKNkVlYmE0Z0xHeE9lRkVRVHYyMTkrb0Vh?=
 =?utf-8?B?UFRFcUxNbUk2bFF1YUhUck9WcHFVTXpBWFNLbGRVQTNyVUNyS1VCc1hiMCtB?=
 =?utf-8?B?bE1VOEwvVGJBdHBubmwwMGswSHBydlc4TFJmOS9WaFZJSkM2NmZxdFYwUHhH?=
 =?utf-8?B?bUlEcCtSQ2NhV1JYRHkzMWZGbzNyR1VHWFFGeTI0TXAyQmR6OGtQMFNuc1VO?=
 =?utf-8?B?WDFjKzJrN3BPdHdOb1FIL1psQ1NKT1VkTE9pMHByVWhQS3MvQVdxRXg3YkRh?=
 =?utf-8?B?cmRQRVA1WCt3akF1NlRBRElHWHpQY0toS2Y0cXJnWTFpWG16bzQvZ1pPUlZi?=
 =?utf-8?B?R3ZuMHd1U1lDa2RoZHVYUCt6Ymx4bXFXYWpoaHVCRXhreEtuUDBQUk10c1cr?=
 =?utf-8?B?My9oTjY2SnhlTHlZN2U4K0ZMRzJsVUVOdTFwYWZWNjY4ekZKc1B6c3l6cTNX?=
 =?utf-8?B?bXRtaFNsYVRZRTlvNGhSTWkyM1EwWEgvSGkrVDYrNGZoSmRFb0krcTJWNnRR?=
 =?utf-8?B?ZENvKzQ5dWt0dHkxYnQvTW5BZlBNMzNHcWgzMU9tTGVYOEVpL3NER1lSQ3hM?=
 =?utf-8?B?MU9MVGk3Szg5blVsVzU5R0pHeTJJYWxidXVMaW5URU9oR0IyTnczSmN5bVB5?=
 =?utf-8?B?K09BOVJMMVNFUERkV25paExlK1RYTEVVOFBadHpUV0l1dmhwT1JJZlZ6Q2ZZ?=
 =?utf-8?B?NFRpRThpekNaYkVqcm9DS3dTUlJGd21FVXcrM2VVVjFwRkRSMTNHK2ZTMThr?=
 =?utf-8?B?dFZqSnYwcHh3OGtZMGtTb0ZqbjJhaktvcS9ZMHA1UDB5U0hFL1hNRW8wUlps?=
 =?utf-8?B?TktRYVRSZ2lsMmN1R293azdVZ3pjeVF6MXY0N0Ezem9PSXpnbzJKT2xrcmFF?=
 =?utf-8?B?WW9xQm5EY2JNRm5XS3NoTFdaR2dYakVlRjEydU9pNnU4dEQ1R2FEMHpMbXI3?=
 =?utf-8?B?aXVyZE80TGY3bE1FdFRDaDFVNUsrNFlIQjdDeW81cVJZTlBZb3FIU0c2dHJo?=
 =?utf-8?B?TDZ3U3lrcCt3TG8rUlB4alZyeVNacTNMR1RoSENQNTc3cUFhWnRMNGczOUt1?=
 =?utf-8?B?cUN2ZUlOL3lRRkdEZ1l3Vkd4bjFQQ3B5WFArdWVTY1pER2NxbzFLTDBiNVp1?=
 =?utf-8?B?d0JzL2dwbnR5VTFaUDRKdmlHa3QwMDB1MEtFYi9EWmlHS1hNS2owdk1ia1Jo?=
 =?utf-8?B?L2lRL0EzRlJnc1JudzExSEM1S3pEbUlIQXRTNmF3bVFHUFNueVE1NUUzeEx6?=
 =?utf-8?B?SnJpWE1WVC84YlQwSE1GUzR5aDhmcmpIbWZUTlcveXNKK2FBV2RIaUp3c3Ux?=
 =?utf-8?Q?/axuHXp0VLRadBj0jZrJRZ0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB70EC0B6D61F946AD6E9C4782BC59D3@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR1901MB2041.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5533c4b2-ed65-4c10-32db-08db4d6a181d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 13:10:26.9183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FYoY/cdNDN0NbZ/QLYXIkF37VpVsTThfUel62+TrKXEIdcKTGQQuugzQ/vU1ut7TAcSr3sSoFuHDk0SUHbGM2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB7522
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS80LzIzIDA0OjE2LCBIaWxsZiBEYW50b24gd3JvdGU6DQo+IA0KPj4gKwkJICAgIHRpbWVf
YWZ0ZXIoamlmZmllcywgcC0+c2Vlc2F3X2ppZmZpZXMgKyAxMCksDQo+PiArCQkgICAgY3B1bWFz
a190ZXN0X2NwdShjcHUsIHAtPmNwdXNfcHRyKSkNCj4+ICsJCQlyZXR1cm4gY3B1Ow0KDQpBYm92
ZSBpcyBhIGJpZyB0eXBvLCBJIGRvbid0IGV2ZW4gc2VlIG9uIHRoZSBmaXJzdCBnbGFuY2UgaG93
IHRoaXMgDQpjb21waWxlZCBhdCBhbGwuDQoNClRoaXMgd2FzIHN1cHBvc2VkIHRvIGJlDQoNCmlm
IChwLT5zZWVzYXdfcmVxICYmIGN1cnJlbnQtPnNlZXNhd19wcm9jICYmDQogICAgIHRpbWVfYWZ0
ZXIoamlmZmllcywgcC0+c2Vlc2F3X2ppZmZpZXMgKyAxMCkgJiYNCiAgICAgY3B1bWFza190ZXN0
X2NwdShjcHUsIHAtPmNwdXNfcHRyKSkNCg0KDQpBbnl3YXksIEkgbm93IHVuZGVyc3RhbmQgdGhh
dCB0aGUgV0ZfVFRXVSBmbGFnIGlzIHJlbGF0ZWQgdG8gd2FpdHEgLSB3ZSANCmRvbid0IG5lZWQg
dGhlIHRpbWVvdXQgYXQgYWxsLiBCdXQgdGhlbiBpZiB0aGUgbWFpbiBpc3N1ZSBpcyBhYm91dCB3
YWl0cSANCm1pZ3JhdGlvbiwgSSBkb24ndCB1bmRlcnN0YW5kIHlldCB3aHkgQW5kcmVpJ3MgV0Zf
Q1VSUkVOVF9DUFUgaXMgbm90IA0Kc3VmZmljaWVudC4gSSdtIGdvaW5nIHRvIGludmVzdGlnYXRl
IHRoYXQgbmV4dC4gUHJvYmFibHkgbXVjaCBlYXNpZXIgdG8gDQpnZXQgdGhhdCBhY2NlcHRlZCB0
aGF0IGEgcmF0aGVyIGZ1c2Ugc3BlY2lmaWMgc2Vlc2F3Lg0KDQoNClRoYW5rcywNCkJlcm5kDQoN
Cg0K
