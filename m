Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689EE6BBF4C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjCOVpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjCOVpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:45:10 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BE96A048;
        Wed, 15 Mar 2023 14:45:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOi65Nxazns646+sUMk2YSR6CtstNpjkE2KIa/oN9Wff/Mzak1plP6SS0gUCQrELCLGyF6Or38YzGD7BUd/tL73VRIgpGDO6PghMk/fG/WdMEfHtNC9HdH+vC9i9dZx8EZc73SbZ8lVbDbkX9bLQ71wYxTjmAvGAtVWbjKkUtMz9dfvFU/TP6fTlzaAQFdo1c+q/d/y5AtXyiQRmKUWiG5YfHiCP33Kx/GS9fByAddSYvhORPNicpE92E1t850o1RyruEIR5pYjv17Ps45DmruHFkE1VHSmMQ6rkaAE+MExJP8MctbtB5t3on2sHmBL02jnuk511YhsMvAHqeBgySQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGNbNSAGWZ3ZRWl1WZ2aYuBdXvo4uDwSrRg5Qj+1xl0=;
 b=nuP16m94VzgmD7vvE/7Dkk49J2RUsXaTpac67EuX3xmV643oH5UngRSXORE118iy0eJhU4Q2I9Ra5Qzaf1qKUkl8LjRNr1voyzbHrRPEaqzGr4TQrpqvJSgAtksq/EiS2e31mJAGWz0SxnHqspbwBj34tHT/OrQtp+0sYLiNcfMN40hQszK38/wM+6U0qL6pNSMyeMdThqwSGaOJptGc0HcgGLV7O3RayjXAiEil3FXDzW8Tec6xckKnejhVzcDYH79UtbDFW8f+/LFLx7l9ZaZsq36MVPgqVWjtR4rlmDqqD3mwOUdGVW1CyHrM5whUkRPNNtn/Gb0LOaWyz33Mzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGNbNSAGWZ3ZRWl1WZ2aYuBdXvo4uDwSrRg5Qj+1xl0=;
 b=kelbdnvD4k0m/qu+U55X6upTiKYvxtFpb3YE51uPSc/M3kxq/GQ88VtwJnw47NXsQtIigPa+Dgpn0kFJp6RBmGo3b41fdc5+/Hrbgkk4HZsGqLQ8tlhA9h29ywEoWCJ4rkEOlP9KA94+qh12Nyw41s71dOhbFxYC9BVNfAtZtPICBokgMDuhyL7tKIj44hxUIsWkDxaV7CUMZtkMgkCp6PX8ams3Ec0wSOUhkVpxqCEnMWByXuV2iV8wcqUH6YYk+4IA7EepXx+vjD3QxH83S06IHV62btnDjGn6up3fFWHxmAiBr0rnfFXj5j03KIQ51N2oTGRRUAiR3bBJ1ICouQ==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by IA0PR12MB8984.namprd12.prod.outlook.com (2603:10b6:208:492::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Wed, 15 Mar
 2023 21:45:06 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::b22f:ead7:357e:803a]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::b22f:ead7:357e:803a%4]) with mapi id 15.20.6178.026; Wed, 15 Mar 2023
 21:45:06 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "niyas.sait@linaro.org" <niyas.sait@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v5 2/2] pinctrl: pinctrl-mlxbf: Add pinctrl driver support
Thread-Topic: [PATCH v5 2/2] pinctrl: pinctrl-mlxbf: Add pinctrl driver
 support
Thread-Index: AQHZVsKheB0M6Xe3dkWsOzRk87Ypn677kYaAgADPbCA=
Date:   Wed, 15 Mar 2023 21:45:06 +0000
Message-ID: <CH2PR12MB38951C5F7140436C118EFD77D7BF9@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20230314221609.22433-1-asmaa@nvidia.com>
 <20230314221609.22433-3-asmaa@nvidia.com>
 <CAHp75VeMWvywh1PmA5SxStqM17e4KjU1voPr2rdYCyZVdEsRPA@mail.gmail.com>
In-Reply-To: <CAHp75VeMWvywh1PmA5SxStqM17e4KjU1voPr2rdYCyZVdEsRPA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|IA0PR12MB8984:EE_
x-ms-office365-filtering-correlation-id: 7093dd85-725c-4a7b-7d47-08db259e8a80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RhTqwq/Z2ctUpmucZIbdUdb8gFjE1IL94zJDgYJeGrIgChxVGyXtMPd7RZIkwCPa/dIN+1QmQhvLGp1YII4b9NFGkYdK0AtQtZ63qWvXcy0xa43GcwOzb3YbU0+UfdA2H78HkPHvVRdMkyE5Y2opdnXJF4BE9wPNjUCPvWqCGj0+xHG7sztgK6YSD5OOgpT9CgtfTnyQ5gFuwqsbVYPHtfp5b+8YbGHshSvxsRogvR0DnmhUwyu6mjDvWwcRmQBch2u7sKsIsrm5B7/Thf6NOF3akc8n+cffEur4/d/E4PDqsihbRogNisBea2wKjj1mlFvgDFIbCM62CeoeslZcPUi4vc1PkKiha5A/XLQM3gz65OVqy9ileqzo2G/sDaW6kYgdz+v0LQJzEJ8iJIpiIBYxXp6znF1n3EBWHIGjuRearmU9sJqOU2OIIVZxd6/Z78tyFzUa0qVdKoKHSItGhKiJ5EWw1L/WNtUd8B2iq1swxX9n8TbcqLG6oy/57JDC0S3jbN7dkp6f/T8R0zQXwcOBHFL0+8+TMPJd0O+LkKKSoSbQfaLUzQh5pXuqbT0Ifpg04+SB600tu/xx/n67hKQQaWhvjAPPWpUOHz1jQPkTtuwdSGrE5ZD6C66Ax7UqsUeK0s9Mrt1g0zYaw1BlYempMH5IEDfO959jkIZZLINU5noxUgP55o3j8WaqFCPUTngziH26Fbd6kYBrRVl+TA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199018)(38070700005)(33656002)(122000001)(38100700002)(8936002)(41300700001)(5660300002)(52536014)(86362001)(7696005)(2906002)(4744005)(55016003)(64756008)(83380400001)(54906003)(26005)(9686003)(186003)(316002)(6506007)(8676002)(66556008)(66446008)(6916009)(71200400001)(478600001)(4326008)(66946007)(76116006)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1F3ZXJyWTBsWmpSZGkxZWwxc1ppUm9zQU5CeXJsbElYcEtrQVZTNXVPb29E?=
 =?utf-8?B?aUxwa1VhcXdvL1N0ZEJwK0ROQ2hmMG5xUVVSNmFsazdBUTdsSzZIaUxmVmJ2?=
 =?utf-8?B?TVltNnpMaGwwZjB1NWEweW8rZHcyK2l5VTYrRXVjbzNLa0NLdkFNR1JJQnAy?=
 =?utf-8?B?b2dpdmxlMFp4cUFrM2lBVzFSdG9QMlUwODl3L0dKWDBxVHRCRk1mY2w2Mko5?=
 =?utf-8?B?OG5ObnEwSFRrVlJoYm1sZ1ZYWFBxOTZTcnFIR09VN3V0UEpJZnRNVVROR21Q?=
 =?utf-8?B?ZG1NcWlBZTFNQjVuYTd4NWNzenlsM2FORTNDOHUzMk1LaTNlb1RabnF2c2lZ?=
 =?utf-8?B?K3I4eVZDNXc1d3RuTFZmb2hoKzc0YUo0VnN4d3Zwb3Y3ckhPVWNPOFdZSGFB?=
 =?utf-8?B?WktjNDl3b3BVNHZUb2xVamhuY0FrKzBuWnVVaVc4OVI0YllxUHBQNDBoZjUz?=
 =?utf-8?B?UjFCRERRMTUrSDFpZUxzbHIxRFliUDRkNzBONE8ydWkvUEYyZk9EbnE2dmoy?=
 =?utf-8?B?YmhYeDJ5TDdUUi9kdmMyd05RTkVJZlRoa0VHZEtkRzVRR1RtV3VzRmg3NXgz?=
 =?utf-8?B?MlhkSHlzaEIwSXgzYWRmTnBLdVFIVHNYa0RLL3V2aytIajJLRjlGVUFwWVlu?=
 =?utf-8?B?NXBrUWhuQUVVZ0IxcWpDSHp4RGkxb1FMRXlmV2FNbjlsMnBRQ1dHNkNiN3FR?=
 =?utf-8?B?ZlZ3R1hyTzlpNzJNUWpRQXl2T0FDQ3d3Qm8yV2dTSzB5ZE5FUytTOXBhdklk?=
 =?utf-8?B?MUhoRG03V2J5eERBUHQ4TjRMZXV3WVZQeFdhWEVjU1RIclE5RVJ3eGE4dGE0?=
 =?utf-8?B?VTFZYTNJVksyMFEwK3dqakVoQjQrRXRPQmE3MDY4ODUvVmh4ZkNQTzBlb0FY?=
 =?utf-8?B?ejl3dlNIam5yczZCc1Z0SDJqK3JlVldhQ0lWaGxkU09BdUcwbXhtL3VtSGlO?=
 =?utf-8?B?b3QvaG13bEkvVzhrcW5tbWp6VElNNkFBTXFtd1prNkpTWVFPR3J0cVlLV0VJ?=
 =?utf-8?B?UFlwVXRJdGN2V2xvam9Db3dwbEhnVFhkRU56TjFpZVZ4QVhpNTJ0a294clBJ?=
 =?utf-8?B?a3FwNEhDeXB0QUVrbUJBZWFVVmVzWkpDMlBVUUNnNFJqQ2JWRzBkTXQwWUVo?=
 =?utf-8?B?bUFaNUx3R2I2d1QrOFAzRzZ0ejhLQU45RlVxc09zWlUzUnRkQ2pReFNxZ0xW?=
 =?utf-8?B?ZTRlR21wd3NMTDRkVnBZcjRUdkhJdk81ekZySGIwYmJpRFdHTkkxRHNYaldD?=
 =?utf-8?B?Q1N5MXhodyszZ09NYi84K3lWQmlTNTBzU1RXYk1qdU1CaXJOMTlHNEpvYm9j?=
 =?utf-8?B?YVNmcmhhTWVkVXM5VjhocVp6QmJIL1lnaTJwODJEQmNTU0FjRGh1dFp6dTdG?=
 =?utf-8?B?aTYzK2xNZmFMRytDQk1GZmRsc1VuSWV3OCs2ajlxNjkzTHJDOUMzRXB2OXcv?=
 =?utf-8?B?ZDZBY2xvV2lpZTdMNkRxMXNUQ21rbEJMU3phcnpJSjN0SHNLaGxHU1gwTjVC?=
 =?utf-8?B?MkZrUEdHTGZvamxKVFVsRnZvYTIxVWgycHFvYmQrWWZYeloxeDZ1ekYxM002?=
 =?utf-8?B?SENoNW9QMjFFbTlaeXR3VlJlZ0tHaDBPcU5tY0ZNNDhJMzZnRW1HNFF1TDA1?=
 =?utf-8?B?VHphazJFcnpIbEt3bDJRdm9FUDA0MjY4S0JBQ0RYUU8vdndENmt6UjRCWUdr?=
 =?utf-8?B?UkhjQzRQbVZoYWs0U0pUdVkzaHhCQXc2Mk0yWkpyRDJCQXVRZkI2Q0tKa0F6?=
 =?utf-8?B?Z3BBN242TER2b1FCK0NCTWtIblhoQkhqZG03bUhDYllyNEFlcmVoVG9lSWZM?=
 =?utf-8?B?T09RcGtaT05pVEp5T3FLVWhZNnBzMVAvRURlOUdvSUtVQ0lFbXUra3lqQ09B?=
 =?utf-8?B?UlFQWXF4ekZLMnJkdnd6MU5RM3N2SmdyNU1qcVJjT0ZVUVhlaC9NOGtZdU9h?=
 =?utf-8?B?WmVzQ2JzS2V5RmtESXZmcElqamNGSnU1Rk1TNFBzYUVQZklsUlpIak4wRm5t?=
 =?utf-8?B?c0ZQVFZqaDZ5czVTdWRDNUtJakJLUHJRaFNoZ0JhN3dZLzFPUjlMWWs0KzRC?=
 =?utf-8?B?V1h2NW40bmwzUEx0SFpBY0ZhcFlDNUZLQjRzWnpsdlFZbTJ6ZFpVNkJEZjdR?=
 =?utf-8?Q?YRMQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7093dd85-725c-4a7b-7d47-08db259e8a80
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 21:45:06.1169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZRmHumTsIui0O2uxtXyk4S7aZ+gyuJ8NTMXzIqpEYpMXwN2bDFG7Llm8RJCsVzILnd57Jv7DiBeHDLHxcgDQEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8984
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICtzdHJ1Y3QgbWx4YmYzX3BpbmN0cmwgew0KPiA+ICsgICAgICAgdm9pZCBfX2lvbWVtICpm
d19jdHJsX3NldDA7DQo+ID4gKyAgICAgICB2b2lkIF9faW9tZW0gKmZ3X2N0cmxfY2xyMDsNCj4g
PiArICAgICAgIHZvaWQgX19pb21lbSAqZndfY3RybF9zZXQxOw0KPiA+ICsgICAgICAgdm9pZCBf
X2lvbWVtICpmd19jdHJsX2NscjE7DQo+IA0KPiA+ICsgICAgICAgc3RydWN0IGRldmljZSAqZGV2
Ow0KPiA+ICsgICAgICAgc3RydWN0IHBpbmN0cmxfZGV2ICpwY3RsOw0KPiANCj4gRGVwZW5kaW5n
IG9uIHdoYXQgaXMgdXNlZCBtb3JlIG9mdGVuIGluIHRoZSBjb2RlIHlvdSBjYW4gc2h1ZmZsZSB0
aGUgb3JkZXINCj4gYW5kIHNhdmUgYSBmZXcgYnl0ZXMgaW4gdGhlIGdlbmVyYXRlZCBjb2RlLiBZ
b3UgbWF5IHBsYXkgd2l0aCBibG9hdC1vLQ0KPiBtZXRlciB0byBjaGVjay4NCg0KSSBtb3ZlZCBh
cm91bmQgc29tZSBvZiB0aGUgc3RydWN0cyBhYm92ZSBhbmQgaXQgaGFzbuKAmXQgY2hhbmdlZCB0
aGUgc2l6ZSBvZiB0aGUgc3RydWN0LiBJIGFsc28gcGxheWVkIGFyb3VuZA0KV2l0aCBibG9hdC1v
LW1ldGVyIHRvIGNvbXBhcmUgdGhlIGdlbmVyYXRlZCAubyBmaWxlcyBhbmQgSSBkb27igJl0IHNl
ZSBhIGRpZmZlcmVuY2UuDQo=
