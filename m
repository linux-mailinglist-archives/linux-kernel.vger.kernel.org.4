Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22CE5E5CA3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 09:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiIVHrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 03:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiIVHrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 03:47:43 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9905422C7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 00:47:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hro5s57sG5neE3oxX59pcnCEVi/pmnM62yBFeZdMMWvlPYoW+DIj6g3vEi9fM9bxQj47XHHXUpaLi4kesnMfo8grjuLIa6Gf9E4eapv1vN57usqatil2cy/MUn5ofGH0KPxgOlJgpSr0xNh8AS10h3CVkWGeywPRYE5iPYeF2VkBsffV5BeOVHkiE6nfvnlcuhhMDtpCg0b4B3zVZlp9615k+We+SmHsQB8fO/VaqETPjwMc9HLOAbULSP+FN22uQfVisIg73zCOvJAKSDN3qW0bMluDA5dsvIV/u5jsvT0dTl4zW3HxJF+VE2qUjkIFHkHXYdr46BvKhR2sh2qUoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAQQPxyiXIkJz8wolXqZYWEsu9daa8AA5MvMo1nZZNM=;
 b=ODLrsiPBRLGY/Iykg59Z0iMt+CNzq0X5aKC+7WsK3xZLZ8K3wwT6DaPLQk1spzWbKfx/JRgN3MkfdD1jf9Ix7iVpomNrLFcm0rJo5CC45ziAPhcaTz6jUwyjhGEQteg2RlHi3yEZUnI1duQPNcl2Vm+PBjPgC9+Rbk7HvMEjHUP4E3SVIpspPkp4WPkX9149cj9GT3Ao+MR1H7NcYRYHvfpzlewO3DfdXkX7+grU99qXdjcT6VHSX/GmC+KdZryV4/TXmQLq1AI4ToJ4imHBQfn7ySRwmj+lUfOLZAckbGlY5UKq8F69EmsPcSdYODWxfdEH3otJJlOzIMCe7D/U+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAQQPxyiXIkJz8wolXqZYWEsu9daa8AA5MvMo1nZZNM=;
 b=LSXEtA9scJrqVvr5sMJ7r/BcUIS5bWkKA4YN/3n//mdOVbQJxiqxQpl4tGdvk5E9PgtdSd7p35RWBb6Bl4ashdQ/BNbf+5pj97EShEFQFxfzGuVnoe7YdOA2EaU0Ok6oVVdfLqqoG0eGoit07g0tGSBxPjM31rzMD7sxxMvMhj39Hyo7sBYyTaB0B35eoy80DWWViBwaO2Low6isJk5qYfPk9DMld2tjCimFnMNy6KgwilV7flk48SSqLpETbwR/0vMrQNYMZpI1uk5wr0iuvDTmudG//Y1TyakzOG7dft8gTQuYyn0z3ZZGOKOJ+DSRqIJcMymDO/FFq4m1XaJdLQ==
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 DM4PR12MB5938.namprd12.prod.outlook.com (2603:10b6:8:69::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.16; Thu, 22 Sep 2022 07:47:40 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::c42a:c673:1e4a:f357]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::c42a:c673:1e4a:f357%6]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 07:47:40 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Jason Wang <jasowang@redhat.com>,
        "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>,
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
Thread-Index: AQHYzi0gH9Mt5ZhE+EK/NJhRzVZV9a3q52cQgAAmcQCAAATFgA==
Date:   Thu, 22 Sep 2022 07:47:40 +0000
Message-ID: <DM8PR12MB5400D6550D2253E9964260F8AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <20220922024305.1718-1-jasowang@redhat.com>
 <20220922024305.1718-3-jasowang@redhat.com>
 <DM8PR12MB54005C65A85B32063A5E17A8AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20220922032858-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220922032858-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5400:EE_|DM4PR12MB5938:EE_
x-ms-office365-filtering-correlation-id: d56c2d88-9442-443e-861a-08da9c6eb9d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7lkOMw3YD6XjKzpy6wQJ/T3MxDAKTfUVieu80a+W/F+WfabrbRFsdB/c6ut9CwCP5yOSj8lpbEUKx30W9WW/6k3CdqoJYZnzxJoFqcVpZxePe3d/x4cItIpMtfTCC/z115vu/ORYro8zOjpZlI0O9B4KyD0jeXzfAL66W+HsWGd40BxRdRHZhZVfbDJj4loQ7XfMhenyiN53h3h9rtolHfwrDsuYD7rVTVe1O+NaABbkzcLc/Hp5uBkcT/XWlyqBTBUtuzE+N72L781wOW4ViYxd+yU16yLyCidRwHOL46Ow+Ih6c7czC4Ywm6jQq1te1SwxVdsHYgb9x+duEfxk1YJZX9/om4Uec6/h+1B/xOC13q6oQmV8tG4WjJ7oo0Hc1nfIXmjyMtsBJGVFpyV9Ex3lHE22oMQe/Wm21ySnCALI/htAQIf4fpe0QsB3Of8uOYKJYA70t2SCcNumcgziGESQsJ1MZLWOiDih4+33P0brzqeuGP7+0UQCrN9mdWZvo4eBhv4bRgLdB9JidsFUfViNs2mIJZweQEIXusbCGgVLOi6bJETraRxm2DXIe29rMayG29sSIFI+B1mCP7Z+eTMSPQQNWuo1DqX1lfySJrekp45VU6vXdJWzuqFhR1l91PEZbt3QspBpvM4XR119iz1ZbS36GOZxOFmYTWbraDl526kGuw6y98vs8BDhcRO69jKB7vJkF4IGmtgVga6J0i0H4PAda2H1lyR55O92055d+g1OmLzCEkz7twV9csTGtS+bCtN3jcrm2wO48YjRkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199015)(83380400001)(5660300002)(86362001)(33656002)(38070700005)(52536014)(122000001)(38100700002)(41300700001)(186003)(8936002)(2906002)(55016003)(76116006)(7696005)(4326008)(478600001)(9686003)(66476007)(66946007)(7416002)(66446008)(66556008)(8676002)(64756008)(71200400001)(54906003)(6506007)(26005)(53546011)(316002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2YwZzJGTXVHZXZWKzJkVktBSW9GT3lFNjVJK241Yyt2WVpWYjFoWnk3d2pM?=
 =?utf-8?B?WkNZK0RIZzl3M2R4QVVpNDBKbUhNK3ZkamtFM0w4dklHemJ3YktleS8xQkFm?=
 =?utf-8?B?RG9wSkx6TkdKSE9BREtOc1VQNHRic2VSaFJ3dGNydEJuZktiY1JheXpybUFM?=
 =?utf-8?B?eExRWDYrTTYreHJIeVZFakgvMmNSRkk5d2c5d3lab2lTejhBNlJJR1hoK2ZO?=
 =?utf-8?B?QXBtdWxJaWNoNE5Ua2NReUlybW0wcGlvcDdHTjNLV3FpMGltWkdoTFZJTUpJ?=
 =?utf-8?B?QjFhOGF3ejF3RFJTc0dJY2c0aklWYXVxTi91N0JDWWJLaklWaVpNbHZuTXpO?=
 =?utf-8?B?MWtsdFgzWlkzREZ6cnhmTkhuZ2hyVnU5MjVybk5hWjd2aVNUbHhzUWdVZU1B?=
 =?utf-8?B?ajd4ZkhpMFJKOThvbi9PTGFxNEVhcDNKOWNzdkdSTkFZd21OZ2c5UjB6VEc2?=
 =?utf-8?B?YTM5MHRDRjhKUUUwWmhxQW5JNHgrWGNQTXBsbGt5ZUNXV1V1ZlUxYTRES1Y3?=
 =?utf-8?B?SWdCRzhZSlFabUJQeFM5KzFEdU1VUUZ2cUR4OU9yVHhKVHd0L0tLMW93T0dJ?=
 =?utf-8?B?aEt5d2J3cWFNV0lIOW1IbE5DQjFEejJSRE9hUjFwa0xEdENDL3RNTUJUMXNn?=
 =?utf-8?B?UmZGcEVGWW5CVkQrWEJHMkZ2QWxjQ1J2dC9HdEFaNEZMa0xRcXFuMHVUUjg0?=
 =?utf-8?B?dVRKdktoMS9OalFqL00yWHZFRjNlb05yT0RFUjY2TGpRRmNTTUVzWk5YZzBV?=
 =?utf-8?B?OEk3a0JSY3B1UWdhTzN1VVVCbTdQRGhKaDBCd3hicURVeS9aUXF4SVllYnlE?=
 =?utf-8?B?Z0lqaVRJQW0vQlIxOFY0U2Q2OFFQUzVsdUdTN1JweEo2TWNkc3VESEtKbnIz?=
 =?utf-8?B?aW9DcC9BdVR2SWNycTcvMkFFMDBaKzRYbHhONC9ibHl4cC9aNkFlNDVaZXh2?=
 =?utf-8?B?OE0xeUdpQlFWMVhSWGFXUlRKZFB3VkhjcnhWM0dyNXdteXV0VktXM0tLK1VR?=
 =?utf-8?B?TlJkQVdtZ2htb1hMOEhYZlVpVFJzMDRvRzVxeHh2d3Vhek1qL2NwU3h5WXlB?=
 =?utf-8?B?bEZoMjZ1YWpFQTNVM3NWYTJDUSsvNVhCOWRaYTVVNXA2VGp6d3g0djMrS2ZV?=
 =?utf-8?B?dUpqU0FvRXpLWTVVOHNEeXN4WnphMGVMVm16NWVmOG1BVjluYWlXcHp5c01F?=
 =?utf-8?B?LzJVQXg1blRvTWlCM1FaU01NZVFXRGY3d28rMWVVb1R0WDRzcUJHSnpRR3Uy?=
 =?utf-8?B?Q1VSR3hCTi9xaXRXT2pldDVTNmJ1T0VGMFlveFE3UVZuODJTNGoyUlBUZDdw?=
 =?utf-8?B?eUtaZEMzVVB0d0JlR2hIalNqbFoyV1VQWEFQdzR1QWhDVlhPU1U2SmRjdHF1?=
 =?utf-8?B?MWZyWW14Z29wZVB6NW8xRGRaOGVMRWwreHhtVkkxL0UxaHR3bHZlamtoWWo5?=
 =?utf-8?B?ZUNVWHRUVVBaNzZ4cFB1eWlKZzAzYXR0aTF3NHdjYm03L0pHaFlLODZ2RG8y?=
 =?utf-8?B?bEFaQ0tGQkFWeVZmOTV4bGxjSG9uaGp0VUJQbFBqVTFqVUU0aUh0blZjSWo2?=
 =?utf-8?B?UWdnZkl1NU52YytHMk42RkNURXlhV3JYd0EwMVhtZEE3S3lsdERnVmNBcW5p?=
 =?utf-8?B?eGJ4RkUxa1dISFZNcjRDRkczb1ZGS3RjOGRySmV4MFhYc1RpMWRkU2RmY1ZJ?=
 =?utf-8?B?SmV5MEwrWFpqT2lLdkRYdWJnL012WHVaUzFQdW9EcEJFaUVqSmdPMXdjSzNP?=
 =?utf-8?B?cUlRbUtsYUR4Y3V3QUhrWDNVL3hGbWFaVzIwR216UGtOY09QMkdRbUhTZkY3?=
 =?utf-8?B?T1E1cnFRd0pkL3RLTWhtdEVodForUExxa2FIdjMvaW9GdDNMZk0yL1M5YTh2?=
 =?utf-8?B?QWFCdjJ6RkZRTlVUdjA4K2NJV2R0QXZSQnA4eGNQUDRCV3VtS2lDUlVkRGJw?=
 =?utf-8?B?cVpFQzMvUnJNSDNzSmhoV3UyMDRwVmRCaUx0VDhlUWFuamMvUEczMXBlUjUx?=
 =?utf-8?B?MlYzMjFCR1J0RjNFT2tyeDJ5WHRxWTZaOG91aytZNG9HMDIwck9HNFhOVTA4?=
 =?utf-8?B?a3ZVWENXSS9YakdZUVZqdFBPd3BZbE0zSFV4UUxaZjQyNnpwVFFralpoTmhQ?=
 =?utf-8?Q?OI7Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d56c2d88-9442-443e-861a-08da9c6eb9d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 07:47:40.3770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sumrxVOPfwVR1tkiqclLdcVCle92l8UJzZFQhm1PhZsrL3AV6DQF++62b4IrNpB+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5938
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFlbCBTLiBUc2ly
a2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1cnNkYXksIDIyIFNlcHRlbWJlciAyMDIy
IDEwOjMwDQo+IFRvOiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4NCj4gQ2M6IEphc29uIFdh
bmcgPGphc293YW5nQHJlZGhhdC5jb20+OyBzaS13ZWkubGl1QG9yYWNsZS5jb207IFBhcmF2DQo+
IFBhbmRpdCA8cGFyYXZAbnZpZGlhLmNvbT47IHd1em9uZ3lvbmdAbGludXguYWxpYmFiYS5jb207
DQo+IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOw0KPiBlcGVyZXptYUByZWRoYXQuY29tOyBsaW5nc2hhbi56aHVA
aW50ZWwuY29tOyBnZGF3YXJAeGlsaW54LmNvbTsNCj4gbHVsdUByZWRoYXQuY29tOyB4aWV5b25n
amlAYnl0ZWRhbmNlLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYyIDIvM10gdmRwYV9zaW1f
bmV0OiBzdXBwb3J0IGZlYXR1cmUgcHJvdmlzaW9uaW5nDQo+IA0KPiBPbiBUaHUsIFNlcCAyMiwg
MjAyMiBhdCAwNToxMzo1OUFNICswMDAwLCBFbGkgQ29oZW4gd3JvdGU6DQo+ID4gPiBGcm9tOiBK
YXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiA+ID4gU2VudDogVGh1cnNkYXksIDIy
IFNlcHRlbWJlciAyMDIyIDU6NDMNCj4gPiA+IFRvOiBtc3RAcmVkaGF0LmNvbTsgamFzb3dhbmdA
cmVkaGF0LmNvbQ0KPiA+ID4gQ2M6IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPjsgc2ktd2Vp
LmxpdUBvcmFjbGUuY29tOyBQYXJhdiBQYW5kaXQNCj4gPiA+IDxwYXJhdkBudmlkaWEuY29tPjsg
d3V6b25neW9uZ0BsaW51eC5hbGliYWJhLmNvbTsNCj4gPiA+IHZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+
ID4gZXBlcmV6bWFAcmVkaGF0LmNvbTsgbGluZ3NoYW4uemh1QGludGVsLmNvbTsgZ2Rhd2FyQHhp
bGlueC5jb207DQo+ID4gPiBsdWx1QHJlZGhhdC5jb207IHhpZXlvbmdqaUBieXRlZGFuY2UuY29t
DQo+ID4gPiBTdWJqZWN0OiBbUEFUQ0ggVjIgMi8zXSB2ZHBhX3NpbV9uZXQ6IHN1cHBvcnQgZmVh
dHVyZSBwcm92aXNpb25pbmcNCj4gPiA+DQo+ID4gPiBUaGlzIHBhdGNoIGltcGxlbWVudHMgZmVh
dHVyZXMgcHJvdmlzaW9uaW5nIGZvciB2ZHBhX3NpbV9uZXQuDQo+ID4gPg0KPiA+ID4gMSkgdmFs
aWRhdGluZyB0aGUgcHJvdmlzaW9uZWQgZmVhdHVyZXMgdG8gYmUgYSBzdWJzZXQgb2YgdGhlIHBh
cmVudA0KPiA+ID4gICAgZmVhdHVyZXMuDQo+ID4gPiAyKSBjbGVhcmluZyB0aGUgZmVhdHVyZXMg
dGhhdCBpcyBub3Qgd2FudGVkIGJ5IHRoZSB1c2Vyc3BhY2UNCj4gPiA+DQo+ID4gPiBGb3IgZXhh
bXBsZToNCj4gPiA+DQo+ID4gPiAjIHZkcGEgbWdtdGRldiBzaG93DQo+ID4gPiB2ZHBhc2ltX25l
dDoNCj4gPiA+ICAgc3VwcG9ydGVkX2NsYXNzZXMgbmV0DQo+ID4gPiAgIG1heF9zdXBwb3J0ZWRf
dnFzIDMNCj4gPiA+ICAgZGV2X2ZlYXR1cmVzIE1UVSBNQUMgQ1RSTF9WUSBDVFJMX01BQ19BRERS
IEFOWV9MQVlPVVQNCj4gPiA+IFZFUlNJT05fMSBBQ0NFU1NfUExBVEZPUk0NCj4gPiA+DQo+ID4g
PiAxKSBwcm92aXNpb24gdkRQQSBkZXZpY2Ugd2l0aCBhbGwgZmVhdHVyZXMgdGhhdCBhcmUgc3Vw
cG9ydGVkIGJ5IHRoZQ0KPiA+ID4gICAgbmV0IHNpbXVsYXRvcg0KPiA+ID4NCj4gPiA+ICMgdmRw
YSBkZXYgYWRkIG5hbWUgZGV2MSBtZ210ZGV2IHZkcGFzaW1fbmV0DQo+ID4gPiAjIHZkcGEgZGV2
IGNvbmZpZyBzaG93DQo+ID4gPiBkZXYxOiBtYWMgMDA6MDA6MDA6MDA6MDA6MDAgbGluayB1cCBs
aW5rX2Fubm91bmNlIGZhbHNlIG10dSAxNTAwDQo+ID4gPiAgIG5lZ290aWF0ZWRfZmVhdHVyZXMg
TVRVIE1BQyBDVFJMX1ZRIENUUkxfTUFDX0FERFIgVkVSU0lPTl8xDQo+ID4gPiBBQ0NFU1NfUExB
VEZPUk0NCj4gPiA+DQo+ID4gPiAyKSBwcm92aXNpb24gdkRQQSBkZXZpY2Ugd2l0aCBhIHN1YnNl
dCBvZiB0aGUgZmVhdHVyZXMNCj4gPiA+DQo+ID4gPiAjIHZkcGEgZGV2IGFkZCBuYW1lIGRldjEg
bWdtdGRldiB2ZHBhc2ltX25ldCBkZXZpY2VfZmVhdHVyZXMNCj4gPiA+IDB4MzAwMDIwMDAwDQo+
ID4NCj4gPiBIb3cgYWJvdXQgImZlYXR1cmVzX21hc2siIGluc3RlYWQgb2YgImRldmljZV9mZWF0
dXJlcyI/IENvdWxkIGF2b2lkDQo+IGNvbmZ1c2lvbi4NCj4gDQo+IE5vdCBzdXJlIEkgYWdyZWUu
DQo+IGZlYXR1cmVzX21hc2sgdG8gbWUgd291bGQgbWVhbiBpdCBpcyAmIHdpdGggZmVhdHVyZXMu
IE5vdCB0aGUgY2FzZSBoZXJlLg0KPiANCg0KDQpTZWUgdGhlIGNvZGUgYmVsb3cNCg0KQEAgLTI1
NCw2ICsyNTQsMTQgQEAgc3RhdGljIGludCB2ZHBhc2ltX25ldF9kZXZfYWRkKHN0cnVjdCB2ZHBh
X21nbXRfZGV2ICptZGV2LCBjb25zdCBjaGFyICpuYW1lLA0KIAlkZXZfYXR0ci53b3JrX2ZuID0g
dmRwYXNpbV9uZXRfd29yazsNCiAJZGV2X2F0dHIuYnVmZmVyX3NpemUgPSBQQUdFX1NJWkU7DQog
DQorCWlmIChjb25maWctPm1hc2sgJiBCSVRfVUxMKFZEUEFfQVRUUl9ERVZfRkVBVFVSRVMpKSB7
DQorCQlpZiAoY29uZmlnLT5kZXZpY2VfZmVhdHVyZXMgJg0KKwkJICAgIH5kZXZfYXR0ci5zdXBw
b3J0ZWRfZmVhdHVyZXMpDQorCQkJcmV0dXJuIC1FSU5WQUw7DQorCQlkZXZfYXR0ci5zdXBwb3J0
ZWRfZmVhdHVyZXMgJj0NCisJCQkgY29uZmlnLT5kZXZpY2VfZmVhdHVyZXM7DQorCX0NCisNCg0K
PiA+ID4gIyB2ZHBhIGRldiBjb25maWcgc2hvdw0KPiA+ID4gZGV2MTogbWFjIDAwOjAwOjAwOjAw
OjAwOjAwIGxpbmsgdXAgbGlua19hbm5vdW5jZSBmYWxzZSBtdHUgMTUwMA0KPiA+ID4gICBuZWdv
dGlhdGVkX2ZlYXR1cmVzIENUUkxfVlEgVkVSU0lPTl8xIEFDQ0VTU19QTEFURk9STQ0KPiA+ID4N
Cj4gPiA+IFJldmlld2VkLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4NCj4gPiA+IFNp
Z25lZC1vZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+ID4gPiAtLS0N
Cj4gPiA+ICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fbmV0LmMgfCAxMSArKysrKysr
KysrLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBh
X3NpbV9uZXQuYw0KPiA+ID4gYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fbmV0LmMN
Cj4gPiA+IGluZGV4IDg4NjQ0OWU4ODUwMi4uYTliYTAyYmUzNzhiIDEwMDY0NA0KPiA+ID4gLS0t
IGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX25ldC5jDQo+ID4gPiArKysgYi9kcml2
ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fbmV0LmMNCj4gPiA+IEBAIC0yNTQsNiArMjU0LDE0
IEBAIHN0YXRpYyBpbnQgdmRwYXNpbV9uZXRfZGV2X2FkZChzdHJ1Y3QNCj4gPiA+IHZkcGFfbWdt
dF9kZXYgKm1kZXYsIGNvbnN0IGNoYXIgKm5hbWUsDQo+ID4gPiAgCWRldl9hdHRyLndvcmtfZm4g
PSB2ZHBhc2ltX25ldF93b3JrOw0KPiA+ID4gIAlkZXZfYXR0ci5idWZmZXJfc2l6ZSA9IFBBR0Vf
U0laRTsNCj4gPiA+DQo+ID4gPiArCWlmIChjb25maWctPm1hc2sgJiBCSVRfVUxMKFZEUEFfQVRU
Ul9ERVZfRkVBVFVSRVMpKSB7DQo+ID4gPiArCQlpZiAoY29uZmlnLT5kZXZpY2VfZmVhdHVyZXMg
Jg0KPiA+ID4gKwkJICAgIH5kZXZfYXR0ci5zdXBwb3J0ZWRfZmVhdHVyZXMpDQo+ID4gPiArCQkJ
cmV0dXJuIC1FSU5WQUw7DQo+ID4gPiArCQlkZXZfYXR0ci5zdXBwb3J0ZWRfZmVhdHVyZXMgJj0N
Cj4gPiA+ICsJCQkgY29uZmlnLT5kZXZpY2VfZmVhdHVyZXM7DQo+ID4gPiArCX0NCj4gPiA+ICsN
Cj4gPiA+ICAJc2ltZGV2ID0gdmRwYXNpbV9jcmVhdGUoJmRldl9hdHRyKTsNCj4gPiA+ICAJaWYg
KElTX0VSUihzaW1kZXYpKQ0KPiA+ID4gIAkJcmV0dXJuIFBUUl9FUlIoc2ltZGV2KTsNCj4gPiA+
IEBAIC0yOTQsNyArMzAyLDggQEAgc3RhdGljIHN0cnVjdCB2ZHBhX21nbXRfZGV2IG1nbXRfZGV2
ID0gew0KPiA+ID4gIAkuaWRfdGFibGUgPSBpZF90YWJsZSwNCj4gPiA+ICAJLm9wcyA9ICZ2ZHBh
c2ltX25ldF9tZ210ZGV2X29wcywNCj4gPiA+ICAJLmNvbmZpZ19hdHRyX21hc2sgPSAoMSA8PCBW
RFBBX0FUVFJfREVWX05FVF9DRkdfTUFDQUREUiB8DQo+ID4gPiAtCQkJICAgICAxIDw8IFZEUEFf
QVRUUl9ERVZfTkVUX0NGR19NVFUpLA0KPiA+ID4gKwkJCSAgICAgMSA8PCBWRFBBX0FUVFJfREVW
X05FVF9DRkdfTVRVIHwNCj4gPiA+ICsJCSAgICAgICAgICAgICAxIDw8IFZEUEFfQVRUUl9ERVZf
RkVBVFVSRVMpLA0KPiA+ID4gIAkubWF4X3N1cHBvcnRlZF92cXMgPSBWRFBBU0lNX05FVF9WUV9O
VU0sDQo+ID4gPiAgCS5zdXBwb3J0ZWRfZmVhdHVyZXMgPSBWRFBBU0lNX05FVF9GRUFUVVJFUywN
Cj4gPiA+ICB9Ow0KPiA+ID4gLS0NCj4gPiA+IDIuMjUuMQ0KPiA+DQoNCg==
