Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0380696762
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbjBNOwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbjBNOwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:52:09 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778FA2B616;
        Tue, 14 Feb 2023 06:52:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jA1MFYRhsHWi4zNNZCkpX96EAWxNZFmT+tqQKidchi42CQNwXLFSJBWt2x21Vb4mFfjqqOJIGDdsUcoy4Ll5xm50/iPn9+IO/GvIcvoi/aydtX2NL8Y69K1x0FhaZakyOpNy6WRmlT4SP/x+5OxBwXWrGIV4RnTGRJ6Fdv/+CQ8AgWMvzvkZlI+xX3EjLaSWmfBNpSwclrKXnETwrZPjiTk/r/mbHhPjP6vMZA43edSVraHBKWFRR3OxniehMKnqWqx254QlKllgd6dRB9DhmOAbZ/ot3PFMWR91D8voiWGD1PcKgbMI0CpATLiPp2pzLugXdFC8GKAk27QDPwMhCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gthuif1Ysx24behAqTJfZKhNh3mx9SLlj3+YnV5uOL0=;
 b=OQTeAA27Wjj/rh34ThK2hx1FVN+QnB9s43P2s8OjG8YkRIjKK4RtWSxMfM+clTzTdj/3FFjwkVjnmqcAMOCbQFiFihDvE483StslQjKkT1odUCLtxtLKLAx5jJgnpB3LoxCDlmSFLJeezMMTebolxNWrH9mfa9V7lWxNFvoZujuqzX/NM1SlU84vR+Z82puhYiZSYidn3iQfdl8NHIvZPizCYgZi9d3mv0i62+BmThHKYgKElPztZB+Nr+94yF9HQ9dPJciFDeNzd6jaBAOS4ZoLA/s7uWsg6/Rgda+2gmmbr+3s8ItmEOuW+zRs4fOyMWcJRhT/6IJK8g5ytezRlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gthuif1Ysx24behAqTJfZKhNh3mx9SLlj3+YnV5uOL0=;
 b=SbHlk03V3U7p8tV5io9DrOhbMiwO6z5HrZTtCV5UCfOwVdmvgxAJ6JcSeoH8fccm6xqjndADORkb1T+Q2VG76DzNrKL1g6RXbenksqf5wnuPpTWFSh93HHJVCYp52h433WaMVOb2J0udVNL2HXikUts4qDOHxDeyYwV57s/kKxg=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.26; Tue, 14 Feb 2023 14:52:06 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%5]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 14:52:06 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dbilios@stdio.gr" <dbilios@stdio.gr>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH 2/2] ACPI: x86: Add more systems to quirk list for forcing
 StorageD3Enable
Thread-Topic: [PATCH 2/2] ACPI: x86: Add more systems to quirk list for
 forcing StorageD3Enable
Thread-Index: AQHZP/Mm6AFdqfdHpUiBXMFpR3XHoq7OhvgAgAAAQpA=
Date:   Tue, 14 Feb 2023 14:52:06 +0000
Message-ID: <MN0PR12MB61018CBDE5DBBAB7C65F9F4AE2A29@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230213213537.6121-1-mario.limonciello@amd.com>
 <20230213213537.6121-2-mario.limonciello@amd.com>
 <CAJZ5v0j0GYyrF33=7ginfhYMrNyD=EDUK0RuHHYkKJ2VZAQnsQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0j0GYyrF33=7ginfhYMrNyD=EDUK0RuHHYkKJ2VZAQnsQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-14T14:52:07Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e740256e-5b95-4c38-8261-90f91343eaf5;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-02-14T14:52:07Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: a4a7b1b1-0496-482a-a27c-540a35a363f0
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DM8PR12MB5430:EE_
x-ms-office365-filtering-correlation-id: b5e402b9-d1b4-4e97-508f-08db0e9b0a70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EFEVolwzLroBagoKcOZ3gdTAluJsQG6fm/Pn+ZH1E5Tx53tHRnTYjxDca89H2b8QMSS8xmfW+2P1JARnClntUtIR0wjEhhm86qHM5vUDBHF3asBwKvA0zmZgae+mrS//+lH6+RjteT5Z2ZBjvj6FveaSfWwAt084XahvggstwtbX8g+9IVAC0qx1ycOE6mulrOZR6ysglg/gmLo22eusmtcW/zfaSJKEAdMMRkk97Dw24zT9cFiUuwSkmspwlgANnd1SvAsbA/ziWPd+A9TqXm+XHk7Mnld/nmBqUx7b9YKLlNsCFkesh+gTbtldPv5H0ppeKuDuxmZD46Wt/rthoGYrkCRDHbcJ3MFSTQGLbwD2VqfHA43SXnwDYaeXXAUJ3d+CRlBjTR2/4eKsxLq8kAGCMnzermACHCWJhcR2EWnmBtLTLrkFfhnBn53CdTj8NByU1MYRaU4Jhz1H+c07qOCg/w0YEoP3ny3/zujDam+WzYQ4MZxikhqLW1WjqwR0m000A6XhuN8+9NoMyJ1d6VxTJaHGwAlDANesxTPCWlztRz+DItaCFsOt0nUxEubxYBjrrEqmaUjjNeXdaAm4zKbKvW4fmJMAiLlNxszkmPYAaAEWf/+RhE2jGohBwRK7uKIBRC/8iHlZbkQIZ8PmDZvoeKdz0v28IrP7bHc8moxY16FaeOR/RQGmxxeANn+UukDBZEKxSd53Uk9l9StnCmXhWCjak9jYL43qLXTPi08=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199018)(6506007)(9686003)(186003)(26005)(71200400001)(53546011)(33656002)(83380400001)(8936002)(52536014)(8676002)(6916009)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(5660300002)(41300700001)(2906002)(55016003)(7696005)(966005)(478600001)(54906003)(316002)(38070700005)(122000001)(38100700002)(66899018)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDBPRE5temJXZTIxdmROd0RZMFFGck9NYVNWY3JOY0JoaTJ6ZlFnRC9BNlJ5?=
 =?utf-8?B?SUVKWmdZbGF6VEw1b2lSdzEzcW9WM2lSaGtGZWpJL1lPcytmR280UWhtamhX?=
 =?utf-8?B?eVRCRWtaK25sUDNoN0RBRGtPT3ozUUkvb2pSNDZWSlFUejJQMDhkMFNlQ1Z6?=
 =?utf-8?B?aDBycGZWb1dTUis0aG4wREpwdCt4L1FJRUlnbjFMY2Q5OWt0em5tcXpmOWdt?=
 =?utf-8?B?Z2I2THMzZ1BwaC94WDMxekxMYWhtMW9ydy90U2w0dmY4bHpDMzBYUWRjRjhY?=
 =?utf-8?B?WUhuQVllMTB2UytXSC9NRGdJeUMzY0lnb2pST0Qrckw0N1dQekxpQTMrZW9v?=
 =?utf-8?B?R0pUa1l2M0RPcFI3MjZkVWs0amhxeVhZeVBBcWs5NlB4RjBWQ0ZRZDBzbitp?=
 =?utf-8?B?c0VqTDkwZTdmUENDM3l6aStKcyt0WDVnZnRTa0hWbzVLNXRFOTByMTlwUTFm?=
 =?utf-8?B?b0s0UC80aERUTllTZW4rOGZHQno1RnFMTkE0bkZGTyszZjBZcjA5N1QwNE5a?=
 =?utf-8?B?OWtkMUtZYWJ6dDVPZlR2ZEh5Z0FMQjRsZjZQdDZqakxKZERhSllmcU1EcUlp?=
 =?utf-8?B?bk5PN1A1UFFVeDVSRmFsUGhrWmE4WUJVeStYOVdtdTIraG8rRFdnbTVQVXIx?=
 =?utf-8?B?SlJVRGhXWW4zNUZQbnF6eW1VaFN1N2RRSWs2RURxQUVPSVh1RThVM2FjSlFx?=
 =?utf-8?B?RlM0YkVCdXBKUU0vaUVrV0pUNitHYUMzNWNObkNuNGhFKzQzREJFcFhzSFkw?=
 =?utf-8?B?WERXOTRFU2xrVm93RmtMVmE4WnRzZitBd0JMUkxVNHp1SElCSitXdjJNQi9Q?=
 =?utf-8?B?aTFmQnJlVDVISlUrdTBESmRDVDlhZDFHMWIwUkJmTmRhUU5nN2lGUXFtR0FT?=
 =?utf-8?B?L3ROWkt0RGdPWDBXUVhFaElyS3ZLK1VWQWU2SGpUaSttelJ6czhrNUZ4bml0?=
 =?utf-8?B?NmxONjYzR25KTVJoUVI1cHZGZ2Zrc2FQZUZiMjBDYnYrQk1qTUFWNlk0WTJu?=
 =?utf-8?B?aVk3a09wMVE3ZlNmNnpQRGpBL2htd0VJUWRwMlpUTzhLeHFwdU52ZUhCbWhW?=
 =?utf-8?B?dk13NnUzaHEySUs2U0JqTU9kRnNENEJveklOVCtHRFRqb2ZKNThnRXlFQWgy?=
 =?utf-8?B?Ujc2SUt5Z2twM0t4N0RkWWRFVnNUM3Biam92OHVndkYyN09VQlk2VFcxRVg1?=
 =?utf-8?B?dFI3cXFZcXRlY3BEMWhONTRMSkhNVlc5UG5wcG1QWE92ZWhTOTVsSndpZ25p?=
 =?utf-8?B?ZWZjeHhLeDVLanR6TWMzUFBrUUxOeTE0WFZ1MWlOMVczc3RhRnNQSnFNdDdp?=
 =?utf-8?B?ZXdicHlyWnR6UEpCZ3NOMndleVEzMytZSmJRK3ZtR0VDaWlVNWwvdXRXeEYr?=
 =?utf-8?B?UFB2K3NscnlqYnBlUWk3MmlDTEtYb1p0NEZobzZVT0Fla0tDR1RYOFFPYkY0?=
 =?utf-8?B?aTEyT0dTeGg1WUJjektYTHI0S0xacE91ZUZXVkxEUXh5MjZNdXFsZyt1S3lG?=
 =?utf-8?B?a25DbHI5R3hKQm9WVlNUY1pIVCtaSGtmMVZFc1BRRG5Tb1pKL2M4NTFUQXVR?=
 =?utf-8?B?OFd6eXA4VVFTb2lBai85U2Y5ZXJxcmI3bzhFTnpqaEZoN0pUWkhyeEwvaGRU?=
 =?utf-8?B?a2Z4ZnU1dk45ejRIaFFLKzVOeGFmOWFXQkpQS0VWeWZnQ20xOEN3bE5jVU84?=
 =?utf-8?B?Ykd1RzhSZDBjYXVQcC82V2dHOURabEpjNXQvSnBOODZ3VWFjVXc4SVE1QlhI?=
 =?utf-8?B?Q2ZoTTYwMzhIdHc1ZWJmZTVuaXhXcG9TTVU1UnhrUlVuU2ZXTVh3dUxmcEZO?=
 =?utf-8?B?ZGhWWDAzMWtTeW1NNEFEZnkvVTAxZ2NQaGVNSDFqaHpYd1FxVkp0Y1V0ZzVy?=
 =?utf-8?B?YlNpRjZRWVErT1ozVmRJbDdDYVVHRTRVZVp2KytzQkMxSG9CQUlNQW05Tk55?=
 =?utf-8?B?ck5ycFRBaEMzaGh1dElVVWd0TURpYWJocm5FUytJalZOait3Z0l0SHBRempt?=
 =?utf-8?B?Ui9GdWlKR1F5SjF1VUE4Vm4yOGJVWFdNTWN5Q0Q3YjFLTWxjalNUc05jVEVt?=
 =?utf-8?B?MkFkVUMwa0hJRTU2T0JydEVZeDdMeE1QeFlWWWlvemlLN3pCdWlVendsRVZs?=
 =?utf-8?Q?/l8Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e402b9-d1b4-4e97-508f-08db0e9b0a70
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 14:52:06.0285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m749odLUbtkVDq/GBnu90S3QYIjnQQM4NtnrziHx5/dRAURBQdHztP60/DRp271yuIi4yUKMTlYQCkonNQ+uBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5430
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9y
Zz4NCj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgMTQsIDIwMjMgMDg6NDkNCj4gVG86IExpbW9u
Y2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT4NCj4gQ2M6IHJhZmFlbEBr
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkYmlsaW9zQHN0ZGlvLmdy
OyBMZW4NCj4gQnJvd24gPGxlbmJAa2VybmVsLm9yZz47IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBBQ1BJOiB4ODY6IEFkZCBtb3JlIHN5c3Rl
bXMgdG8gcXVpcmsgbGlzdCBmb3IgZm9yY2luZw0KPiBTdG9yYWdlRDNFbmFibGUNCj4gDQo+IE9u
IE1vbiwgRmViIDEzLCAyMDIzIGF0IDEwOjM1IFBNIE1hcmlvIExpbW9uY2llbGxvDQo+IDxtYXJp
by5saW1vbmNpZWxsb0BhbWQuY29tPiB3cm90ZToNCj4gPg0KPiA+IGNvbW1pdCAwMThkNjcxMWMy
NmU0ICgiQUNQSTogeDg2OiBBZGQgYSBxdWlyayBmb3IgRGVsbCBJbnNwaXJvbiAxNCAyLWluLTEN
Cj4gPiBmb3IgU3RvcmFnZUQzRW5hYmxlIikgaW50cm9kdWNlZCBhIHF1aXJrIHRvIGFsbG93IGEg
c3lzdGVtIHdpdGggYW1iaWd1b3VzDQo+ID4gdXNlIG9mIF9BRFIgMCB0byBmb3JjZSBTdG9yYWdl
RDNFbmFibGUuDQo+ID4NCj4gPiBJdCBpcyByZXBvcnRlZCB0aGF0IFZvc3RybyA1NjI2IHN1ZmZl
cnMgc2FtZSBzeW1wdG9tcy4gQWRkIHRoaXMgb3RoZXINCj4gPiBzeXN0ZW0gdG8gdGhlIGxpc3Qg
YXMgd2VsbC4NCj4gPg0KPiA+IFN1Z2dlc3RlZC1ieTogZGJpbGlvc0BzdGRpby5ncg0KPiA+IExp
bms6IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjE3MDAzDQo+
ID4gU2lnbmVkLW9mZi1ieTogTWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFt
ZC5jb20+DQo+IA0KPiBDYW4geW91IHBsZWFzZSBjb21iaW5lIHRoZXNlIHR3byBwYXRjaGVzIGlu
dG8gb25lPw0KPiANCj4gT3IgYXQgbGVhc3QgbWFrZSB0aGUgc3ViamVjdHMgZGlmZmVyPw0KDQpJ
IGxlZnQgdGhlbSBzcGxpdCBzbyB0aGF0IHdlIGNvdWxkIHJldmVydCBvbmUgaWYgdGhlIEJJT1Mg
aXMgZml4ZWQgb24gb25lDQppbiB0aGUgZnV0dXJlLiAgSGFwcHkgdG8gcmVzcGluIHdpdGggc2Vw
YXJhdGUgc3ViamVjdHMuDQoNCkJ1dCBiZWZvcmUgSSByZXNwaW47IHNvbWV0aGluZyBlbHNlIEkg
d2FudCB0byBvZmZlciBhcyBhbiBpZGVhIHRvIGF2b2lkIHRoaXMgbGlzdA0KZ3Jvd2luZy4NCg0K
VGhleSBhbGwgdXNlIHRoZSBzYW1lIENQVS4gIFNvIHdlIGNvdWxkIGp1c3QgYWRkIHRoZSBDUFUg
bW9kZWwgdGhhdCBhbGwgb2YgdGhlc2UNCnVzZSB0byB0aGUgZm9yY2UgU3RvcmFnZUQzRW5hYmxl
IGxpc3QgYW5kIHRha2Ugb3V0IHRoZSB3aG9sZSAoZ3Jvd2luZykgbGlzdC4NCg0KV2hpY2ggd2F5
IHdvdWxkIHlvdSBwcmVmZXI/DQoNCj4gDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvYWNwaS94ODYv
dXRpbHMuYyB8IDcgKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL3g4Ni91dGlscy5jIGIvZHJpdmVy
cy9hY3BpL3g4Ni91dGlscy5jDQo+ID4gaW5kZXggMzQwOWNlNjUxM2FmYS4uYjFkMjQ3MThmNzNk
NyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2FjcGkveDg2L3V0aWxzLmMNCj4gPiArKysgYi9k
cml2ZXJzL2FjcGkveDg2L3V0aWxzLmMNCj4gPiBAQCAtMjE0LDYgKzIxNCw3IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgZG1pX3N5c3RlbV9pZA0KPiBmb3JjZV9zdG9yYWdlX2QzX2RtaVtdID0gew0K
PiA+ICAgICAgICAgICAgICAgICAgKiBidXQgLk5WTUUgaXMgbmVlZGVkIHRvIGdldCBTdG9yYWdl
RDNFbmFibGUgbm9kZQ0KPiA+ICAgICAgICAgICAgICAgICAgKiBodHRwczovL2J1Z3ppbGxhLmtl
cm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIxNjQ0MA0KPiA+ICAgICAgICAgICAgICAgICAgKiBo
dHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIxNjc3Mw0KPiA+ICsg
ICAgICAgICAgICAgICAgKiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dp
P2lkPTIxNzAwMw0KPiA+ICAgICAgICAgICAgICAgICAgKi8NCj4gPiAgICAgICAgICAgICAgICAg
Lm1hdGNoZXMgPSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgRE1JX01BVENIKERNSV9T
WVNfVkVORE9SLCAiRGVsbCBJbmMuIiksDQo+ID4gQEAgLTIzMiw2ICsyMzMsMTIgQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBkbWlfc3lzdGVtX2lkDQo+IGZvcmNlX3N0b3JhZ2VfZDNfZG1pW10gPSB7
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgRE1JX01BVENIKERNSV9QUk9EVUNUX05BTUUs
ICJJbnNwaXJvbiAxNiA1NjI1IiksDQo+ID4gICAgICAgICAgICAgICAgIH0NCj4gPiAgICAgICAg
IH0sDQo+ID4gKyAgICAgICB7DQo+ID4gKyAgICAgICAgICAgICAgIC5tYXRjaGVzID0gew0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIERNSV9NQVRDSChETUlfU1lTX1ZFTkRPUiwgIkRlbGwg
SW5jLiIpLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIERNSV9NQVRDSChETUlfUFJPRFVD
VF9OQU1FLCAiVm9zdHJvIDU2MjUiKSwNCj4gPiArICAgICAgICAgICAgICAgfQ0KPiA+ICsgICAg
ICAgfSwNCj4gPiAgICAgICAgIHt9DQo+ID4gIH07DQo+ID4NCj4gPiAtLQ0KPiA+IDIuMzQuMQ0K
PiA+DQo=
