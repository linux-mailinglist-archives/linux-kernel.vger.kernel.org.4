Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C495E5A77
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 07:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiIVFOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 01:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiIVFOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 01:14:02 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9AEAB40B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 22:14:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INmmK4toU9zCjIBYwW1UV3EZ9y4VkPrCNNpbCT/Y03xw3uIPqV24NVkliqh7zGipP0veZy+D6e1TXaE5MGl5L9sAS2aHvpICBRWNxCpnloUB2SB0SXWY6ow6AWu8q/D9bnX2JekT0q3LE2FHoYNb9kg+6ibVS/lK0WYe4PVrNcx8CIQaUj9vAxABCUWJKh3uTN6NLHLEbV1jBJ+RttxX4oXwqyxYR5W+lNzuooMK3RJuga65gUtYM3kb8tuGU0lt1BeDkNJcumf2T3OMAfBT9aVtpOqmQ1qE2dEj0akXSTz+de3FtEZXH2eUhGJmOgzF4+3EK+6z0CUwPTQrvKQTCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjuWN5A/TbKoIQCLlYklhzJgdQ/XP728FzSL/t4Csso=;
 b=kdYV6L3XgyX0AucYCYghZT0G4Jvi1NspgAMKUoBoalsGT3G3o5FzIgDAKsbWMGDmztPRGNqbuPzNHIla7yPqO+XGLr7iIPvpX8K6l1gbSHws0cIHAVg+njK6CLLY+wR59NeE9cJ74RwCpwv8sbZKlA7aaTaE7QqonH75wcqqNZjh/LtiIklOcqltT4xQomX5dTCwvxe4gENrm0A/qeWgXu0gbXfgRg/b566YL1UTCKVWH2Bhyy52sIrHjU09P+KXzO2Z9xh64miaQOuumvTak+sLwont0z5F3ipXN5wv12lVhnhJy4env+DqouRkpTSdx19dNwQiX8MrVAc1C2yJfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjuWN5A/TbKoIQCLlYklhzJgdQ/XP728FzSL/t4Csso=;
 b=Wn+2WXjI3CWzcRip9uV7jKJc4+g94KnA25jaijO1Yns20BQ5CMbDHXCsQJ9/3/HuahEKe+Wl6F7NXpj08kN6Lf48CWVRauvRyFjPuCVfXmA7qSoBXXZufHM+YkPvkjcEGIM4G7rsnqZRi2DZIm2DjwCpt2RGpYC+pzPQmnyIyG8SUvgC64UuJF5V3GvHrhO63S3MG6Agb6y4lkBwDjjvdJX07XGcpzKGYoVvR7RDf+tYRQAxqO+bz9ZLpGI4LdvX+lzSdw6i/e+6EkIL3UXSQmWotC7pG60qefFRZW6hwXTJyLcHpwUKOrTxj+Puj91HltpMHhwi7yaj5nHhObWPIQ==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 SA1PR12MB7341.namprd12.prod.outlook.com (2603:10b6:806:2ba::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 05:13:59 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::c42a:c673:1e4a:f357]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::c42a:c673:1e4a:f357%6]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 05:13:59 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
CC:     "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>,
        Parav Pandit <parav@nvidia.com>,
        "wuzongyong@linux.alibaba.com" <wuzongyong@linux.alibaba.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>,
        "gdawar@xilinx.com" <gdawar@xilinx.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "xieyongji@bytedance.com" <xieyongji@bytedance.com>
Subject: RE: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
Thread-Topic: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
Thread-Index: AQHYzi0gH9Mt5ZhE+EK/NJhRzVZV9a3q52cQ
Date:   Thu, 22 Sep 2022 05:13:59 +0000
Message-ID: <DM8PR12MB54005C65A85B32063A5E17A8AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20220922024305.1718-1-jasowang@redhat.com>
 <20220922024305.1718-3-jasowang@redhat.com>
In-Reply-To: <20220922024305.1718-3-jasowang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5400:EE_|SA1PR12MB7341:EE_
x-ms-office365-filtering-correlation-id: 4d2d162e-8adb-4003-ff31-08da9c594182
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A9/2WBFz0XOetRRMTVy19Sfht9OuoYEho/x3O4WFLH3wIWMYS9nivFgOodK8ZhqFDvd1uZEpTMi87CTqEeUJhrzfL3DM5kQVhUhMAEhbHht4+CkB/oc4V9qsEte2RUeY5uYYmu+dK0KxLlbW63MUCeVMHbZQl/ZbW+t3EMBz9Fguwwa5YzyUeY/nH+Hl71Q6FX+G0HcRi4t2Vt1zlyfEqpwgdPWzDwbxZ81LJDKy99cyrIkeDvjjJQbZQh0RUPCR01Nf6Oqjtx9xcGFMiFBZVHESsIo7ksP38GXV1qaVWjbefjdoWjRMHeUmUX9IbZgR3wBZDfGBYZ3/WLVWW9rRO9sZ9wypIcZdNhqa2dDvveIuTEv8pNfGx4xwzRrtNlmSXiEF9sc6GkzcrK2/rDT7EigGuM+zvauaj4Kmua8FFbq0n2ktOWzrhe6PclqKL8sS8MGSC8X/aAWGxGlCcxWQ1uS6zkQxY9tL3/HIVTpfcqRLnVEbRoyuFLP3kWmSTj7rfHvwWmUgP+oYesheZ8Zr6cSnYjD2FAttuogor82XSId/oYHrUMGml00dVHH+L2lg+puCIYmJA2p+6u+wJbPFUXHZ/OUGZCB5f9XRs6mOqK0QyGxykUTx95+VqMO3Wv4wakNR6XYSk6Rv++3Y/C7zfzBrEueMo9h00vQvEvdlUfy9+oSZeEH9ooAQGF+1uzxDyKVxYr4+fS9U15MZJ1I0/bLa8gmvz6xckXbKok/etXXBdUJL2QNskLeuON3qckqF8R5NejJI2iVunV4oGSkDFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199015)(53546011)(4326008)(122000001)(8676002)(66476007)(110136005)(76116006)(38100700002)(316002)(66946007)(66556008)(66446008)(64756008)(55016003)(54906003)(9686003)(33656002)(7696005)(6506007)(186003)(478600001)(83380400001)(86362001)(71200400001)(5660300002)(26005)(8936002)(2906002)(7416002)(52536014)(41300700001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ly9mUW1pejBQN3YzS1JYOEhrbllxY0lHbnFCbUJaSFhIU05ReHZlN0N1dTlG?=
 =?utf-8?B?NzF4cmIzQ2NwRXdiekJSTU50bmI0WHhUWWtBLzVnYVlsNno3bDAvcFBEcE16?=
 =?utf-8?B?TDZvK1VGY242ZXoyNEd5dlkwZ29SYUt2N2JOTE1GZU9hZGk5bHdBS3NCeTAr?=
 =?utf-8?B?cWc4VXJJQzdmUGdSaHJZb0N3YWpKQnlyZEI2aE1oV3VYYlhyMDF2YVduTU9B?=
 =?utf-8?B?WjNvQzdSVWtlZXVlaU1tRWxwNU5VWVNSN0xqVXcvcXEyZnVxZmx0QmRkTGJn?=
 =?utf-8?B?V1ZJQVJpWmllaHhiNldFdnpHOEUwanFWWDJNQmtRSS80UXo5TWlQT2FpSzgw?=
 =?utf-8?B?cGszMjhGeU5rL1BtRU9xQlhpUU5ZaEl6QmcrUENDejdiQ2xNaTVhZDhtTTZv?=
 =?utf-8?B?NTJhd1g4SjZmSzliMlFNWGdSbzJvdXpjeDRBWHVaOVpoNTVvcC9SVURaUmtI?=
 =?utf-8?B?SVNTbStWTy95Y21JQmFydlRoaDFObGplamttMTB4cTFUdUpUSjZlZE1Wa3hT?=
 =?utf-8?B?dHZ4TFdTOHZVRktSaEVBdzZHcXdWaXpvL3poNWg3cDNuVzd0MUcyaVAwNHNX?=
 =?utf-8?B?Z1YyblJTYTJOazNUWlFKZkVwVWY1UjdQN1ZsczMyRUwxYm93Um5Qd255aG5H?=
 =?utf-8?B?Q0FyMnJOMlFRV2J2cW1XektrdjFGRTdwQ0xNMjJ1L3VOQWJvVUFIOTAxNUp5?=
 =?utf-8?B?U0NpcDVIb2EvekJqRExld1o3VlBQWU5pc3JCTWZkNEVDMWhtL3lEYXJIdVpW?=
 =?utf-8?B?OWRZZlFPZFQvaUx3d0NPMmcwSmdlcmw0VW5sS2IzS25PdDA0QlIxN2FBbHBO?=
 =?utf-8?B?UFpqanZYWVI3a0llaDlidjYwbnNLTTV0cFZKTDNrVm5udHY3dlBqcVZiaHFV?=
 =?utf-8?B?TWU4RW1oVGxuT2dmMzJUTVI1NDZtQlhyTzV6S08vWGY3R21IRGtrcUFZQXhs?=
 =?utf-8?B?cDNKT0x5RFhOSGM1VmVQQ04yNU5OQjlnSTlZa0lDTGpFSnpVN04rL0VUY1lM?=
 =?utf-8?B?dXZOUS9qTXVPWHZreFdXcXNFYW9LNjBkWkRiZFhQVlV3ZTA5WlVKcFVRS1c3?=
 =?utf-8?B?QWxPN2pLN1k1Y0Q1d0x5eFJtSzhDODFqQ0taV0VxemprNUdUTGZLcGIxQlY0?=
 =?utf-8?B?N0VlQ01tVnZMTDhUL3lFRHBqeGVEYnJuRys3TzZrSjBXK1FlTm5Bc1dyWWVV?=
 =?utf-8?B?M2E3UTdYSUdUVmFmT2UxOW95TXlhNlg0RGVXb1d0ajBabjYxRnJ4UnptRkp2?=
 =?utf-8?B?M2tGaGF6WHNzMWt2RENxN25mUFlHYU45ZEVha2FsbTVQamN5aXl4Q1owU2oz?=
 =?utf-8?B?OEF6YTYrNlVGV0Uwc0VZWU9OQTlYM1o5ZmpCZW5yRnQrc0FjRUNveXRGd2oz?=
 =?utf-8?B?SkRkaWh5eGozT2dkVGJIbkJuVWk5SzVoNG53bHBqSUdYa3BxSms0S0FyLytw?=
 =?utf-8?B?MEVac21rYWJ0S3lpU29MZEtxTFdISEtITnppKzFoa1h4YjZoQmp6SUFPVEwr?=
 =?utf-8?B?L0VoTFR3bk1VY2x6VVdocWFOVHFOZGZSRmpCV2JrSjNZR0ZCakQwU1RoNHN4?=
 =?utf-8?B?QUJvUEN0dG1BSWhHMFI3NS9waFZEUVd3TFpTV243MTllTXUweDVCOE9JaHpy?=
 =?utf-8?B?cU1RQ3ZlMUI0VmRXM3czNzhaRTJTK0Y5SDBOSmtJdS9FRjNaUy80VnY4dGxF?=
 =?utf-8?B?RUZNc3kvbzBpRThkc2Nvb2VTVnRFaHhEc2FwNStWQVJVOE9jK3ZBQnRjVG4v?=
 =?utf-8?B?TDMxeEZ6MHdWMXhMMjVkMVl2NFk0UzAvekVKOTVZRytMWHo1dmtDK2J4QUZs?=
 =?utf-8?B?SmUvUVVZWUtxclk4aWI1dU51bFYvYzZjOFV4bllwUFVnb3JaZm5ha1NiM1po?=
 =?utf-8?B?eTJXaE5sT2FDdlMxeUdGQUlsKzh2N0J1NEV1S1ZFRnpSTzd5REtHSGl3Q3gx?=
 =?utf-8?B?YXVidWo2d1FKMDdtYlFLWmtORDJ1a1FNL20rU2J4TkdnMkRFbXMyVU9BS3NG?=
 =?utf-8?B?bU44SUtxcDZGOGJyR1Jkb2FIYVpVZmRwOGZjcHBLd0lic1ZKMURuUmFGQ0Vk?=
 =?utf-8?B?SEtVenUwb3YvK2NKZjFsTlBnR091ZkhwV0dObHV5YjBlRFRXTzAyNlNnVVhn?=
 =?utf-8?Q?kROo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2d162e-8adb-4003-ff31-08da9c594182
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 05:13:59.1004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MbSlH7ZMMsATIJzGIP6dZulEZ7LZJLtlUI+i6Jk6LwH6FVcZh947IerTqUQGefXh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7341
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiBTZW50OiBUaHVyc2Rh
eSwgMjIgU2VwdGVtYmVyIDIwMjIgNTo0Mw0KPiBUbzogbXN0QHJlZGhhdC5jb207IGphc293YW5n
QHJlZGhhdC5jb20NCj4gQ2M6IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPjsgc2ktd2VpLmxp
dUBvcmFjbGUuY29tOyBQYXJhdiBQYW5kaXQNCj4gPHBhcmF2QG52aWRpYS5jb20+OyB3dXpvbmd5
b25nQGxpbnV4LmFsaWJhYmEuY29tOw0KPiB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gZXBlcmV6bWFAcmVk
aGF0LmNvbTsgbGluZ3NoYW4uemh1QGludGVsLmNvbTsgZ2Rhd2FyQHhpbGlueC5jb207DQo+IGx1
bHVAcmVkaGF0LmNvbTsgeGlleW9uZ2ppQGJ5dGVkYW5jZS5jb20NCj4gU3ViamVjdDogW1BBVENI
IFYyIDIvM10gdmRwYV9zaW1fbmV0OiBzdXBwb3J0IGZlYXR1cmUgcHJvdmlzaW9uaW5nDQo+IA0K
PiBUaGlzIHBhdGNoIGltcGxlbWVudHMgZmVhdHVyZXMgcHJvdmlzaW9uaW5nIGZvciB2ZHBhX3Np
bV9uZXQuDQo+IA0KPiAxKSB2YWxpZGF0aW5nIHRoZSBwcm92aXNpb25lZCBmZWF0dXJlcyB0byBi
ZSBhIHN1YnNldCBvZiB0aGUgcGFyZW50DQo+ICAgIGZlYXR1cmVzLg0KPiAyKSBjbGVhcmluZyB0
aGUgZmVhdHVyZXMgdGhhdCBpcyBub3Qgd2FudGVkIGJ5IHRoZSB1c2Vyc3BhY2UNCj4gDQo+IEZv
ciBleGFtcGxlOg0KPiANCj4gIyB2ZHBhIG1nbXRkZXYgc2hvdw0KPiB2ZHBhc2ltX25ldDoNCj4g
ICBzdXBwb3J0ZWRfY2xhc3NlcyBuZXQNCj4gICBtYXhfc3VwcG9ydGVkX3ZxcyAzDQo+ICAgZGV2
X2ZlYXR1cmVzIE1UVSBNQUMgQ1RSTF9WUSBDVFJMX01BQ19BRERSIEFOWV9MQVlPVVQNCj4gVkVS
U0lPTl8xIEFDQ0VTU19QTEFURk9STQ0KPiANCj4gMSkgcHJvdmlzaW9uIHZEUEEgZGV2aWNlIHdp
dGggYWxsIGZlYXR1cmVzIHRoYXQgYXJlIHN1cHBvcnRlZCBieSB0aGUNCj4gICAgbmV0IHNpbXVs
YXRvcg0KPiANCj4gIyB2ZHBhIGRldiBhZGQgbmFtZSBkZXYxIG1nbXRkZXYgdmRwYXNpbV9uZXQN
Cj4gIyB2ZHBhIGRldiBjb25maWcgc2hvdw0KPiBkZXYxOiBtYWMgMDA6MDA6MDA6MDA6MDA6MDAg
bGluayB1cCBsaW5rX2Fubm91bmNlIGZhbHNlIG10dSAxNTAwDQo+ICAgbmVnb3RpYXRlZF9mZWF0
dXJlcyBNVFUgTUFDIENUUkxfVlEgQ1RSTF9NQUNfQUREUiBWRVJTSU9OXzENCj4gQUNDRVNTX1BM
QVRGT1JNDQo+IA0KPiAyKSBwcm92aXNpb24gdkRQQSBkZXZpY2Ugd2l0aCBhIHN1YnNldCBvZiB0
aGUgZmVhdHVyZXMNCj4gDQo+ICMgdmRwYSBkZXYgYWRkIG5hbWUgZGV2MSBtZ210ZGV2IHZkcGFz
aW1fbmV0IGRldmljZV9mZWF0dXJlcw0KPiAweDMwMDAyMDAwMA0KDQpIb3cgYWJvdXQgImZlYXR1
cmVzX21hc2siIGluc3RlYWQgb2YgImRldmljZV9mZWF0dXJlcyI/IENvdWxkIGF2b2lkIGNvbmZ1
c2lvbi4NCg0KPiAjIHZkcGEgZGV2IGNvbmZpZyBzaG93DQo+IGRldjE6IG1hYyAwMDowMDowMDow
MDowMDowMCBsaW5rIHVwIGxpbmtfYW5ub3VuY2UgZmFsc2UgbXR1IDE1MDANCj4gICBuZWdvdGlh
dGVkX2ZlYXR1cmVzIENUUkxfVlEgVkVSU0lPTl8xIEFDQ0VTU19QTEFURk9STQ0KPiANCj4gUmV2
aWV3ZWQtYnk6IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBK
YXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvdmRwYS92
ZHBhX3NpbS92ZHBhX3NpbV9uZXQuYyB8IDExICsrKysrKysrKystDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMTAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9uZXQuYw0KPiBiL2RyaXZlcnMvdmRwYS92ZHBh
X3NpbS92ZHBhX3NpbV9uZXQuYw0KPiBpbmRleCA4ODY0NDllODg1MDIuLmE5YmEwMmJlMzc4YiAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX25ldC5jDQo+ICsr
KyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9uZXQuYw0KPiBAQCAtMjU0LDYgKzI1
NCwxNCBAQCBzdGF0aWMgaW50IHZkcGFzaW1fbmV0X2Rldl9hZGQoc3RydWN0DQo+IHZkcGFfbWdt
dF9kZXYgKm1kZXYsIGNvbnN0IGNoYXIgKm5hbWUsDQo+ICAJZGV2X2F0dHIud29ya19mbiA9IHZk
cGFzaW1fbmV0X3dvcms7DQo+ICAJZGV2X2F0dHIuYnVmZmVyX3NpemUgPSBQQUdFX1NJWkU7DQo+
IA0KPiArCWlmIChjb25maWctPm1hc2sgJiBCSVRfVUxMKFZEUEFfQVRUUl9ERVZfRkVBVFVSRVMp
KSB7DQo+ICsJCWlmIChjb25maWctPmRldmljZV9mZWF0dXJlcyAmDQo+ICsJCSAgICB+ZGV2X2F0
dHIuc3VwcG9ydGVkX2ZlYXR1cmVzKQ0KPiArCQkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJCWRldl9h
dHRyLnN1cHBvcnRlZF9mZWF0dXJlcyAmPQ0KPiArCQkJIGNvbmZpZy0+ZGV2aWNlX2ZlYXR1cmVz
Ow0KPiArCX0NCj4gKw0KPiAgCXNpbWRldiA9IHZkcGFzaW1fY3JlYXRlKCZkZXZfYXR0cik7DQo+
ICAJaWYgKElTX0VSUihzaW1kZXYpKQ0KPiAgCQlyZXR1cm4gUFRSX0VSUihzaW1kZXYpOw0KPiBA
QCAtMjk0LDcgKzMwMiw4IEBAIHN0YXRpYyBzdHJ1Y3QgdmRwYV9tZ210X2RldiBtZ210X2RldiA9
IHsNCj4gIAkuaWRfdGFibGUgPSBpZF90YWJsZSwNCj4gIAkub3BzID0gJnZkcGFzaW1fbmV0X21n
bXRkZXZfb3BzLA0KPiAgCS5jb25maWdfYXR0cl9tYXNrID0gKDEgPDwgVkRQQV9BVFRSX0RFVl9O
RVRfQ0ZHX01BQ0FERFIgfA0KPiAtCQkJICAgICAxIDw8IFZEUEFfQVRUUl9ERVZfTkVUX0NGR19N
VFUpLA0KPiArCQkJICAgICAxIDw8IFZEUEFfQVRUUl9ERVZfTkVUX0NGR19NVFUgfA0KPiArCQkg
ICAgICAgICAgICAgMSA8PCBWRFBBX0FUVFJfREVWX0ZFQVRVUkVTKSwNCj4gIAkubWF4X3N1cHBv
cnRlZF92cXMgPSBWRFBBU0lNX05FVF9WUV9OVU0sDQo+ICAJLnN1cHBvcnRlZF9mZWF0dXJlcyA9
IFZEUEFTSU1fTkVUX0ZFQVRVUkVTLA0KPiAgfTsNCj4gLS0NCj4gMi4yNS4xDQoNCg==
