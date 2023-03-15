Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49416BB400
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjCONLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjCONLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:11:23 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B56A18B0;
        Wed, 15 Mar 2023 06:11:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYa8pVw6UIeXq5zF8b2k8tYOE8c/uwNJz5ScpFJMChoABdNEPTzWEYwHUdE8Kg4Fas7URXHdy/r2ryMhS6cpyvoFrxsjPI6US4KpA71lObf/ZAsbJoy1wzTAx09mfN1O+CNFGeQUTb0apyXZGBfNxKkdjNIGiW/Vdn+f9kCS+JRit24MCeKuSQAtHazprGjrehPAf78P0DEs5cAQtj+Gi1Ih55rIQlkPeJItlvxS7wwsQB2LlOMMak7FnCr9ID5BQzPvR/AVIuQUTVsZLMUvPyq3RlPs9VamN4/JNP1wSxiBAYecJhZFb6AJQaqu1RZmfhW3DBNjTY6MUvuwXhHwTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7weyDeq/ZK6RQ1VMQLJV7ko/vwbE1qFUwwzQeZjozSU=;
 b=ELHyZaFSDayoa6mOOajb299Do+mC7aGpCoT2hqf2sKc4cXG8e4ivgGHnx4rMnnloXA1esbDkwVeerOe+qUsRf9jiZG8mfz77jXEq/hiKMEjSeHDnvZ+HvBVRQb5s1QHeQN5YhLt1IEvq7JatR/0GnOvvGQ0J20pz30KT4J5616npuGPslucFjSlpaDdQcbUPNVq2XwcqF0OgKZS7Eh33FeZmmx640MmILQ0L8r7QxyIkHHXfxKslaE30354Q3438lgn5txrjLG2R26JGqzoz28AZPcTTctvNfL7bfvCNZQJfI7r1tHjO85arrWHfrW9uIzUe7gKxrAcOzqc32sRBjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7weyDeq/ZK6RQ1VMQLJV7ko/vwbE1qFUwwzQeZjozSU=;
 b=ZCL1ECViXtq1iBeUv7RTdRwFH1jX9h37VPP8LfMK6FUvJUbjW+HJggdPNB4t4Ig6RXk5CeN2Zo8kw4L8pG9c9tEPg8Ka3+FfdK2pwdBpbO2pF3p02dtDqg/Lz14a/Iq4H3zi+fmtklYBG6VqwpqEjejDvUfsu1bzkScxaEryhTjQwnaZE3bn22potyvjHjG5PUm3h3fcHcfHjgSXlv1jrkqvLQEvug6996lv0Mc3VpbFulEn5RKWkyBuWb+Ob45Senclis1CWxWh9s1CJ4qwam7GEtqvTiqxbeX24FLciDqW5OaMTJcmTPqbnPU2rrPFIpOLR2W1Q/1b4ZW0FpNlnA==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by PH7PR12MB6562.namprd12.prod.outlook.com (2603:10b6:510:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Wed, 15 Mar
 2023 13:11:10 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::b22f:ead7:357e:803a]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::b22f:ead7:357e:803a%4]) with mapi id 15.20.6178.026; Wed, 15 Mar 2023
 13:11:09 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v5 0/2] Support Nvidia BlueField-3 GPIO driver and pin
 controller
Thread-Topic: [PATCH v5 0/2] Support Nvidia BlueField-3 GPIO driver and pin
 controller
Thread-Index: AQHZVsKd+tNibM09JkKO3XVBEY9qw677n8UAgAAwCVA=
Date:   Wed, 15 Mar 2023 13:11:09 +0000
Message-ID: <CH2PR12MB38959655C1CB93623B3A6FB8D7BF9@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20230314221609.22433-1-asmaa@nvidia.com>
 <CACRpkdZPR9TVOOGUQd1n_O-wdh6pHCtfGuEWm0HyyVWPFGMFOA@mail.gmail.com>
In-Reply-To: <CACRpkdZPR9TVOOGUQd1n_O-wdh6pHCtfGuEWm0HyyVWPFGMFOA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|PH7PR12MB6562:EE_
x-ms-office365-filtering-correlation-id: 9ce80972-24bd-4338-7fb7-08db2556be8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QeM2ZpPFmmsvFcVyj0IfdHYaZv3pCj3EVwzLKQn//324aOEaTEr5zELGQu1kUTIXf16t5Sb4OX5Une/XL0HA19rM+z8433QUjTFDEnznGwmmrb/wlJv8VLesxLky1M107W+FV3ktSsQ7n4c3SkEKYWF1oGnVJqmwxfX+tZsitGFqmm9MJd0ZlMKIs4ciLsogcmNxsKrSvgmPWaLo2Ghoh2v7ldg2CLboUJSoVP1gqwIqVP56WRrbvJOwmlNZXhVz5AkuDjXwjyXhRXoGR/Oz7Zf30MfjYvpe7hcaBg3K1sKsVwadpGS5spa0VlSlbJSt4kHGvM8KE88VACv+JoKtN6Wu9rDTE5rRg9nLWJpn2EAuc8+Mgk9qTIwqDkopsqg52ihCCIsX1wf/YnN0sGbR7cO+BPjxVfco5JConP6G6/V96EY6rVJkU/6UfWqqcTJFMi/JIBgETzJphZzHbRsQTozjCKyz9zvOIRnhKp8kylK7xwGnDflf5xC8spmMnR/DLQZ+Q8mog9JeYfflqC6pfJlhIWC1jr/ZJlHvHDXhQGypAJztRmSeHDrC3Pgac9RVG6beZEDsMKXExlILl+Pox7BXUmy2nr/6Zml88r1aaKp/pDtvVwVKet//24zA78RDQkivfkNwCeob1dqlqLHGhEbvuoG8rg2oA6lhPetzXeuMgT/lP4oPxrtLKf2HU/4asRF9Q23RxG2Dp5nCjILZSQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199018)(5660300002)(4326008)(52536014)(8936002)(33656002)(41300700001)(6506007)(26005)(186003)(6916009)(86362001)(83380400001)(4744005)(9686003)(2906002)(76116006)(66946007)(66476007)(8676002)(478600001)(64756008)(54906003)(71200400001)(316002)(55016003)(66446008)(7696005)(38070700005)(38100700002)(66556008)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnRxNlBiREx3SERWVGVDVmJVTkVoYmc4bkxwYXlBWU5XejN0TWtPQnREVHIv?=
 =?utf-8?B?dk5iUUF1SjNmSTJHL2pkbGVvR0VlMTZ4YlY1eUgzUkFRR2NhNUVoYWl0b09S?=
 =?utf-8?B?NFUxd0dtOUN3QWl1cnl2dXAxZUpNZG9HekQ3c290QU9MMFpYR0dHZEJTNmRP?=
 =?utf-8?B?QTY3aWRNclJ5KytHT3hwbWhaN1IxNUtVcWdYMjc4ZC9uTWM5WVdTS09UR0dZ?=
 =?utf-8?B?OXJKOE1MNno5ejRiejE0cHViTHZTNkdsVEdFZTB5cWhpOFYyNjJsSmJOWmJn?=
 =?utf-8?B?eEJzYWw3WE53b0llREpSZllVT0RlNys2bHl4UG56dHlqTHNzNms2U1ZTS0Uz?=
 =?utf-8?B?VXFFWFV5MkdWcVhjZVBHT1EyOWlKVFBjR054a29qZkdxZHc5RDMzMCsyVFpl?=
 =?utf-8?B?S1c3YXlnaGRGOXl5aUxpWElRUUk2QXJoaE9zVm51bVhMUkFnSXFmRnllM21U?=
 =?utf-8?B?VGpQaklqaVRaNUE0akxKZUR3UDh6a3BjWVNXOVdacXBCVUszYVI3MzErY1B3?=
 =?utf-8?B?cmk5aU1XNWFReGgzZ05iaTlsa1Q0NG9UcHRteVpoaityYVV1UVFhSlRNL1NS?=
 =?utf-8?B?dFc0S1hRSGkzUjl3Y1RDWUFFOXU3QjFvZS92bGtzVnRiTFVSTG5xYXM5V0t1?=
 =?utf-8?B?ZjJ2SlJOY01iN1FuMEtDTWR5UmxESHA5cWYvbnFqWFl3QWw5dFNZVTJkWEdy?=
 =?utf-8?B?MkxjSkFqMTFudVZ0OGhOMXloOHljcExMSkpneURFVmJ4enp5QTQ2S0poOFht?=
 =?utf-8?B?ZzNLaWxoeUJ3UXRjU1hOS1pRTFRUbVc0RTVvYWlwcjI2V2RvZ3BJTHVIT295?=
 =?utf-8?B?emRWam1PZklJTkEwNnlqUGluQzFSem1jY2k2U0szS0Q5VHlIY2xOL1I5N0Nk?=
 =?utf-8?B?Y1pNaktTTXlrbmVMM0dELzJyNStpN1FLOVh1a3B0WllyQlhlQUlVdStVbjBa?=
 =?utf-8?B?M042QVJGVnZlbjZNWW5Pbm5STEowaUVvVGUrL0c1RzlIbzZNR0F5OEgzaXpt?=
 =?utf-8?B?Z2ZEOWtxdlN6VjgzWEtic2lFdXJpYWxVRktJM2k3cXVHczFtQ3NHb1d0SE50?=
 =?utf-8?B?aHppYTZZVS9nM3BXSlgyVngyclpKczlqTjN0SzJqTml2V0R3RWNmRHZyMUxh?=
 =?utf-8?B?a1F2V1psc0dscHk2OCs5Z05DSmR5MWY5SG4vNjVQc1RKVGcxZHBuV1JXNU1i?=
 =?utf-8?B?b0IvZjhaTDlOZTVtUDR5dW0ydncwYW83aHczY0JoYjhmL0FnSWUvRERNM3FS?=
 =?utf-8?B?ZDMvL2tMUWg0TEVBanhNU01zRFUybE50Uk4ybmZDS290S3ZOMTRzMnRkVENW?=
 =?utf-8?B?NW1CRndOMTZrMEVVTmYrWWR3aERRRmNhdGdERmFYeG1idW1Hb3NHazZ1MHhx?=
 =?utf-8?B?NnU5NTJyekd0NFA1OXpFUWFNbXdLVnlQOHYyeTZiU0NBdThNUXBCTHlJYjVY?=
 =?utf-8?B?amc0Q0tFNmM1MUFjOVVLdHVWd2tNNEFaUXh4aE5Sckwzb3JVdjE0eFFyRUpl?=
 =?utf-8?B?eTUvTnNWbm5YUkZ4Yml3aTJwMExBaGlKQXp4YXdBckJUQmdmN0VUNmFLUG9C?=
 =?utf-8?B?Uzc2aEVHT0dyUk1DUU43aEhWQTFrcGJhRktVQTdaQnZ2YmI0TTh1OWtRYnRz?=
 =?utf-8?B?bzh5N3pnbjFtYlFWOWVVUll4NDROZDZxdDQ4M1VOUllkWXdudEc3VTdDMlZX?=
 =?utf-8?B?TFkrM29XQlJDVStUUUNOSXBkajFNRVplbjM1MXcyakMrVUNXbk5jbjE0bjdJ?=
 =?utf-8?B?blhIcGpFYXZuUFgxb2NtaTlkQko3bG1zQXlFbDVPN1c5em1Tck1YaE9MbnJx?=
 =?utf-8?B?YVg4bjlYRnZNQjlRZTFFQXFxMXBNKzFIVDE0cnFzVHc3NlBLZWgrMFE1Skw3?=
 =?utf-8?B?djZVRTEwQUhUcVRzU2ZzN0VYZDB2N2x5Vjk5d0tyQTd4NjJOOS95WUZrcGYv?=
 =?utf-8?B?WElmTnlmODR5aHlDVll6NmtUNWZSMGxCOTBGVTBKakRBb3I4djRzeitjMk9k?=
 =?utf-8?B?RENoT3FWbDNzRGpVK21uT25neXNNMU1ocThmZWFLWmZHbnpIcU0ybDlpaTcw?=
 =?utf-8?B?V2ptblcrZndSaXJ4bjBwN3lJUGh3MzBzTnNMcWhjT2E0dGRMRDRCM0dWQnNj?=
 =?utf-8?Q?l0n8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce80972-24bd-4338-7fb7-08db2556be8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 13:11:09.7194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v5aArW8hxMJjHkYhui/hkBoEwAi8rCQo6yfBfdf4wl7Tey8JOBGptQrF7MDlSoNxCYs1cwJE8V2jO5MzC/aeYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6562
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBIaSBBc2FtYWEsDQo+IA0KPiB0aGFua3MgZm9yIHlvdXIgcGF0Y2hlcyENCj4gDQo+IE9uY2Ug
eW91IGhhdmUgYWRkcmVzc2VkIHRoZSBmaW5hbCByZXZpZXcgY29tbWVudHMgZnJvbSBBbmR5LCBk
byB0aGVzZQ0KPiBkcml2ZXJzIGhhdmUgY29tcGlsZSB0aW1lIGRlcGVuZW5jaWVzIHNvIHdlIG5l
ZWQgdG8gbWVyZ2UgdGhlbSBib3RoIGF0DQo+IHRoZSBzYW1lIHRpbWUgb3IgY2FuIHRoZSB0d28g
cGF0Y2hlcyBiZSBhcHBsaWVkIGluZGl2aWR1YWxseSB0byBHUElPIGFuZA0KPiBwaW4gY29udHJv
bD8NCj4gDQo+IEJUVzogYmlnIHRoYW5rcyB0byBBbmR5IGZvciB0aGUgYmlnIGludmVzdG1lbnQg
aW4gcmV2aWV3aW5nIHRoaXMgZHJpdmVyIQ0KDQpIaSBMaW51cywNCg0KVGhlc2UgZHJpdmVycyBk
b27igJl0IGhhdmUgYW55IGNvbXBpbGUgZGVwZW5kZW5jeSBvbiBlYWNoIG90aGVyLg0KDQpBbmQg
eWVzISBUaGFuayB5b3UgQW5keSBmb3IgeW91ciByZXZpZXcsIEkgbGVhcm5lZCBhIGxvdCENCg0K
VGhhbmtzLg0KQXNtYWENCg==
