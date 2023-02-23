Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9D46A11A3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 22:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjBWVIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 16:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjBWVHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 16:07:55 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A78C6A6F;
        Thu, 23 Feb 2023 13:07:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBDBbKr0O1cKb+kkhh/UjK1F2R2o5k+AgjJToNZvuKUzJGySouGSffO8FicBJOBIdvSCa11ffRc8t3JHS/3RA5T3AWl1h82ITqhrLLQCagtZCH6RbCKOv5n/8d56Wd1cF37V2ekifl8lgKkoRKQz33XYakhDI6boc8yHYAyCNbMVKsAdDRkFUysPFkDstvPx7kiREm4E2xMw7tXOSUMaTfjcJl9/M/7jSui+R+MEY18xUVTd482Mv8oK0TglNKi1UO4DzYUC+Um/Gwn0Iz3mmyG2Jw9/oFYYknbo1gXxjbP6ziYjPO3hCOVDtqpEEuXVpQKNsbKuAJh8vP/G9362rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QO6G3CIudMv0TbNjexOchWmlGf/ugxzqjVwfh7YZf2s=;
 b=cEutV0Yt9VdMeI8/TRPGvWvrOsQOkUICDgwmfbENmPMgKsCWaWOsOJS2rpKg6RcgEGiO2i222gFOW4zg35EFVMgG4k3UEyik2FCfKaK+ojHRkK8dVUaEH7sWafOxfBMPcM5ul/7bjckQ5bG6QfDqDVQiJ8VxUMxSg8z6vzzyQhWRHVXqdMqqgmDhzILGEr5dwwmCnVTYPUsuBG/H5qMDDTB3Do0WDYRfOxCHYgo0TeNaK45O3kbMuqm8ZAo5aPzAgBBKiZFW5pJVi4WD4hi+V12hd70wo9JO6cB9uhGCYx8qzmTuBiywY4Qa9dLYjlS2s9ni4Qf6qbhtl0LdILbMXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QO6G3CIudMv0TbNjexOchWmlGf/ugxzqjVwfh7YZf2s=;
 b=BQ08E7l1xmfvVCthk6PI10jUJbQ9oduhIi6INoHon8c38xQ1OyPdMuJBVVf6XgHX/Bv7ADyJ30K+2HcG7ocJj/QbFQq7mcKjAgOMkeKalJCmLo3MqYPbnXMWjGSfY8jiuV1XAvEHK60ZFJqTJhewAwwFXTiWLL7ONeaaV+t1JuWxzh/rvjhZr42mem8B0JcYHWLlDVC/eZcWWf/rEu1L3k3ROaq2+LqTZ08Hmq0ZT5bW/ZksbUGpy5Td/8FJtPf4wVdY4mXq7mp5PuPjBZrFHb546VcV3ZNELDo6zVUli73ee89wF2UKVpfAVXjwmXUH21kDd4/puL/gnW6if3D+gQ==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by DS0PR12MB8220.namprd12.prod.outlook.com (2603:10b6:8:f5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 21:07:50 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::5f35:2f2d:94a4:f7c3]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::5f35:2f2d:94a4:f7c3%4]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 21:07:50 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "niyas.sait@linaro.org" <niyas.sait@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v4 2/2] pinctrl: pinctrl-mlxbf: Add pinctrl driver support
Thread-Topic: [PATCH v4 2/2] pinctrl: pinctrl-mlxbf: Add pinctrl driver
 support
Thread-Index: AQHZQxaXis8h0J8vyUGnQ7U8Uh2ONa7Tx+kAgAlAt3A=
Date:   Thu, 23 Feb 2023 21:07:50 +0000
Message-ID: <CH2PR12MB38959833A5A4073F8B2A84FDD7AB9@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <cover.1676042188.git.asmaa@nvidia.com>
 <cover.1676668853.git.asmaa@nvidia.com>
 <4cda8cfc37fb15a0c3b180ab4c34a6f6f859fe3c.1676668853.git.asmaa@nvidia.com>
 <CAHp75VeTbV7CyVZrXsrm8rqLnYdOunzTDhanqzceyJ3KyPjdwA@mail.gmail.com>
In-Reply-To: <CAHp75VeTbV7CyVZrXsrm8rqLnYdOunzTDhanqzceyJ3KyPjdwA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|DS0PR12MB8220:EE_
x-ms-office365-filtering-correlation-id: 29c74630-9276-4862-fb9d-08db15e2058a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: txi3fC6DlVGy7oFZ9luyDUuPUkjLv50jsft6NxPa9WJ41NYx6FU2qwmeFbY6o1f5oTX9+nmafu51Q9VntzYEI2Xq6HwNF/j0U/WqlZjys9CbWj8C7yk6fecAbct+ylrREnJuU21MCrsBh1yaFAYD/9Jjs03/+XemSODWen+MBFrk+xFFW5uGBuUXXFLFQGMUIa31z0BjpIguuwDb7uShydZk39GOLpGlzXtWfiryC6bRBbFHbsv8kz6Ryf0JS617bJbjiAjykSEZzqfu67HEU5d9AiZVu/qbLx3WcnzkypAwa/ce1Lkipn3tgN+j3dDTws0VPQo7mNAJze+kp6lw/HKIrChaUOm0boyu4mWOuRGI0zN5Gtqa079Nukow5P/q/6TY2MwVDTOMWi8MQ3XhODB1ou4lEL+PY0pi21ozp0C67i2z5fUuDZXr3XogDXUxqbuPq7WFNgyUnu5sAJxgO7QYG5TOAMyYGBdqCpNCn46p++wlwSnzEF+GaCXhM034nhA/7kfiVnHq9VFjROu4nn0BDtJ2l4HD6/iRbXBZhmqZTGS6WCWxNSao2yjeQ7zVvlWf2xhUHUehOM6uIi8+j03JoGq7pdIIgF8EVezNBilbruG7OkNoi1RbabsZqENDpo4/RGEPUjqwwVZtRIgA1Qni3Q+/LN4V5dE4VqzGVh4v9RqU4MDQP/2MnfxDLySIMGWEwdwPRFV+IHuI4DeGQO3OgwUc8iGV5v3VTQb+i4UyEfo1bc6XLPGUqPbzfSCF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199018)(4744005)(5660300002)(9686003)(2906002)(478600001)(71200400001)(83380400001)(26005)(186003)(6506007)(38070700005)(54906003)(122000001)(38100700002)(55016003)(66946007)(76116006)(66476007)(66446008)(6916009)(64756008)(316002)(8676002)(8936002)(66556008)(4326008)(33656002)(7696005)(52536014)(86362001)(966005)(41300700001)(84970400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWtUcVFadDlQV241eUlMei9NS3BTMVh0YjFBc0hKTWMwS0l4YVR2TlFYM0JN?=
 =?utf-8?B?TDB5d0lFTnU4UGkxQTQ4ZHkwTlNIclBzS1FmUjQ3OVJWVUhERUw1WFZHSXVq?=
 =?utf-8?B?cGxqV0VEMlZWUFZySXludDY3bnlCY2JvdTBXNUUvYWw4dzZhejh2YlUxQnNk?=
 =?utf-8?B?NnlxeWpNZHZEemV5dG1PV3F5RzIzRlZPam1FTFpwMDczdEFxNjJQcVlOUkhR?=
 =?utf-8?B?MlJaRStpTjMreENlcjBnNEdWMkNoa2xVL01SNkp5MzA1VzRCOTZEMGpGUjVT?=
 =?utf-8?B?UkFTdVNGRnZtb1pkOVR4SGk0S3NUR3FVNmNCU1V5TlFyMkQwRFVFQktZQVlz?=
 =?utf-8?B?ZERsU3JQTUd1bjIvTGlPc1JCMXlpRThwb04wcDlmdkJiSkc4M1pONktVeHox?=
 =?utf-8?B?TW0xTnJrK3pSL2kycExSajVtUVFXWnZNalh3TWxIbGRIMEhaZzArYy9Kdjcy?=
 =?utf-8?B?eENwVzB6UmZxUUpjT0ljQjdBUTZldzE4eGV6YjRTY2NWNE5yb292U3pDU2d1?=
 =?utf-8?B?Qml2YjJjNkNlRHFpV056NnBKNGJVdDJ5N2xaN1crZUllNzNBQkQwamxiRGVT?=
 =?utf-8?B?NWMxd3VvMmlQSTBySDd5cEpLcUxIT256REt4dXpTeTFtZWJ6WmwvdXVYc2dN?=
 =?utf-8?B?WnNMcmdJeHhwTkkxeEZTcldmMHdmZU1qaUc1aVpBVFF4RzlObVJEbkdwZDFO?=
 =?utf-8?B?YzRDai9EZGJCN1ZiTnFYUDEyTUxMMENoejBoUS9xQWZlOUtUajhoOVl0dHo4?=
 =?utf-8?B?VCtndnBMMzRZRnVraldtYnBPYXl6NENFc1pNZGNrT1Z2ZC96MTQ4TmVHZTZm?=
 =?utf-8?B?bE55emlEK1JVeWx0Y0t6U2Q3cmxkd3h1TzVETCsyQitNcU1zRUNLejI3NUxj?=
 =?utf-8?B?MWJhZFNvVm5LRGJocDM1S25yZ3p5TTk2SWdFVVhjNC9pWVdCdVF5NVIzVHB5?=
 =?utf-8?B?MTNTUi9oOG1KSWlEZ2pyZDE2b1hIOWV4N2pQMFdBb3pHTXFSc2F5N3pLL1N0?=
 =?utf-8?B?YWhOL21DaFdadk1EQXBLSStKMnB6NDBpbWJkb0M5NGRqdjV0a3Yrd0JJakl2?=
 =?utf-8?B?WGxVUDJqa29uQ3ZHZTkzdzlabGgwemZYYmpkcjBTNnJLbGpvNXVZdUFuaTRm?=
 =?utf-8?B?TTF1UjJ3RUxUd3hvazZwdThCUWtMeEdBL0lJNlZpR2xJaHdVeHpEUndsTk1S?=
 =?utf-8?B?U08zcCt1azBXc3NpMDhwTGxBS3lSd1pzTUdicnJWZHEyc2paQ053OWhxQlVX?=
 =?utf-8?B?cG5nay9IMTEwd21lZ29iRUJIUTZiM2hUV0pXWlVVTnFOZjI0T0lPRVNOMDFl?=
 =?utf-8?B?V1RxamwzbTdWT0ZZUEkyUDFaejBqVGpCeU5qM2pBRURvLzE4T09KSCs5aU41?=
 =?utf-8?B?bk1PTnlUcnh1OUxCK1RqZmk0Z29jclJEcnZ2d2s2NS9RT1BpNVY1YnF2ckh6?=
 =?utf-8?B?U3hkelplSC9rOURYNnVBWGVWay9ibFRGZHlweXJlVHRoQnp4c2tjTFZFUmZj?=
 =?utf-8?B?N05LcFE5c09mTGFEQ2l6bE5Fc2UvaTdzWFg1eW9yMzB1SDRVdlV3c3lUZGNY?=
 =?utf-8?B?aURBRmtBTGNwNTg4ZUJZa21ienJYYkIzSzFNZEFQWUNKNSs5eVBDWXJFOHpE?=
 =?utf-8?B?RnFpVWd0aS9oNGlCazZUWVRQWmZRRXNqaEZhN1REcTBTV2Nla0ZKYkROSUEr?=
 =?utf-8?B?cmF3Q2FSa2kwY3dSbGhJZk5rWFk0ZklQM0lXRk93cmJqYUNsL3YxOUxLakZw?=
 =?utf-8?B?QjJnV3cvNU43c0JLYnlTQUY4OGozOGdYSU9TakdjVmFUNExQOFlKL0tPS05W?=
 =?utf-8?B?SFJka29hLzE5N1VKWWJtTkRhUUpNVDR4LzJrU3lzSzR3eFE2MlR5SmtNWU05?=
 =?utf-8?B?SlMxTWlxMFJVNkNCOUltL0diSmtubDJTbURFSjNrajluSnI3bmE2S25EOXBH?=
 =?utf-8?B?NjY3LzZhSTdvSEl1TGh3QUZQdkN1QVFONGVVaXl0cG5sV1VXNDRrTUhjNE41?=
 =?utf-8?B?YjI4M095YkpreWJucUp0d0FTR2ZFc1lselIwQkpPMUh5cTFaWkxtODRJQlVq?=
 =?utf-8?B?a2t0VlJRSzVhMDlSRDBsamJuTWRwK3RHMjE3QjE1cnJ0UlpScVRvcFI3WVEv?=
 =?utf-8?Q?NGuw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c74630-9276-4862-fb9d-08db15e2058a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 21:07:50.2531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6TP3je8cm2gGESU/aB2b2KnrS99bh1QQbzv3rCUsjf9FB4QFnZzjAbxxHZFNMHVaG6HEeQO5M1sjLRSWH+ujMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8220
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHsNCj4gPiArICAgICAgIGNvbnN0IGNoYXIgKm5hbWU7
DQo+ID4gKyAgICAgICBjb25zdCBjaGFyICogY29uc3QgKmdyb3VwX25hbWVzOw0KPiANCj4gVXNl
IHRoaXMgaW5zdGVhZA0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2Vy
bmVsL2dpdC9saW51c3cvbGludXgtDQo+IHBpbmN0cmwuZ2l0L3RyZWUvaW5jbHVkZS9saW51eC9w
aW5jdHJsL3BpbmN0cmwuaD9oPWRldmVsI24yMTUNCj4gYW5kIHRoaXMNCj4gaHR0cHM6Ly9naXQu
a2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbGludXN3L2xpbnV4LQ0KPiBwaW5j
dHJsLmdpdC90cmVlL2luY2x1ZGUvbGludXgvcGluY3RybC9waW5jdHJsLmg/aD1kZXZlbCNuMjIy
DQo+IA0KPiA+ICt9IG1seGJmX3BteF9mdW5jc1tdID0gew0KPiANCj4gPiArfTsNCg0Kc28gY29w
eSB0aGF0IHN0cnVjdCBkZWZpbml0aW9uIGFuZCBtYWNybyB0byBteSBkcml2ZXI/IChJIGRvbuKA
mXQgc2VlIHRoZXNlIGNvZGUgY2hhbmdlcyBpbiBtYXN0ZXIpICANCg0KPiANCj4gPiArICAgICAg
IC8qIFRoaXMgcmVzb3VyY2UgaXMgc2hhcmVkIHNvIHVzZSBkZXZtX2lvcmVtYXAgKi8NCj4gDQo+
IENhbiB5b3UgZWxhYm9yYXRlIG9uIHdobyBhY3R1YWxseSByZXF1ZXN0cyB0aGUgcmVnaW9uPyBB
bmQgd2h5IGlzIGl0IG5vdA0KPiBfdGhpc18gZHJpdmVyPw0KDQpUaGlzIHJlc291cmNlIGlzIHNo
YXJlZCB3aXRoIHRoZSBncGlvLW1seGJmMy5jIGRyaXZlci4gVGhlIGdwaW8tbWx4YmYzLmMgZHJp
dmVyIGRvZXMgbm90IGFjY2VzcyB0aGUgc2FtZSBvZmZzZXRzIGFzIHRoZSBwaW5jdHJsLW1seGJm
My5jIGRyaXZlciwgYnV0IGl0IGFjY2Vzc2VzIHNldmVyYWwgb3RoZXIgcmVnaXN0ZXJzIG9mZnNl
dHMgaW4gYmV0d2Vlbi4NCg0KDQo=
