Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A785B8DF6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 19:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiINRQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 13:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiINRQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 13:16:46 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6F28274C;
        Wed, 14 Sep 2022 10:16:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPc1y7J8/KJrycJ/qaMu/C4AqyFTeFhkzL0LQ2IhWn6Ba2bGpPbN8nxhg8I0KmSikuutrw9pucgHCDdajfYho6PbsDcKJ+H1/dwl8LkfeLd1CMj/0+zHkp5/KWQE+kkWHADLs7rKqipIh296TfuN4I4lEyzX6Rnq4RkBztmVE+D/eRQCXJ+BL+BYWhV91JfOLQis7Fb7Jjdjllray0JJr+6YfRhBOJby1EQqpRgsoGhuGSRTa0PwtMHHLtrGPE0j1j6ZEmpEGOZpc5WChIk+/A7v2/tNiYGjz5IjWF1kudWA3470T9DRMOsEDDWp/8YsQVQ92/K6Vqu9INOp+6S/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bTZWdiaUsw8QydRW0rbJf8DPFm5ws+HM2M/GsP/ecY=;
 b=OBrQBM5NRgSn2oJ++VsFcpbr36THz0kirwWoGNFPz2XXDYCssQFJTjSz3PuU2p73TWdUxH9MSGjMYQaLCh1sdPpqx3Yf5SlddJodEA9oSi6kpujMqF2QyIeAD8LAiR4IGsQjqj98ujCXK+H9gvWXhVdxzHyOB9NUPr300qDWPvZCKW5LRQ8XP+O1OFhFBcvX8/YZFaHMesr1C9Us0Ulb2yyfE3zJQ/5F7TfMQXSCOL0jJSU3ZCwsymBkVN3RLWLZQ86pEreSK5w98uj0ePYNVnULZneicFSd5Rtp0EYc4EgdQ/uAspbvJyncOf/oOM/ZE9J4S/WDxUGP/H6FR1nZUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bTZWdiaUsw8QydRW0rbJf8DPFm5ws+HM2M/GsP/ecY=;
 b=Lupo4Oc76uHfYZZb3JBrN4YVFaJ82bqPKeaCXEhv7JaXiFnkNz9lI08YvG7fJ9DMdIOpFOwxdWzZoUDGBoGoo5cq+tp/XUPglsi3rxpaV+ETCDC26VKj3NkVmC+XyVya/MwLRNSQseZ5zDUQSo4s5fHzcTqutBvP0maDBY+QgSKF2XzLgwr+FwzlmvZVIj9opo6eWY+m05bn28c52Fi1LC2IbqlmTlZsPA06Mo+Ewespw51yfZfRu/5B5PSoMukBdWDEtCtPdN6mCieTmVeg7Z0dGgLW+alUByq9PV3TyNWgINsxnj6Opl5Nfni4beSHCY08XTxYDvrte++Nu7wJ/A==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BY5PR12MB4052.namprd12.prod.outlook.com (2603:10b6:a03:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 17:16:43 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 17:16:43 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Pankaj Raghav <p.raghav@samsung.com>, "hch@lst.de" <hch@lst.de>,
        "agk@redhat.com" <agk@redhat.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "snitzer@kernel.org" <snitzer@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Johannes.Thumshirn@wdc.com" <Johannes.Thumshirn@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        "matias.bjorling@wdc.com" <matias.bjorling@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "hare@suse.de" <hare@suse.de>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v13 05/13] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Thread-Topic: [PATCH v13 05/13] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Thread-Index: AQHYxoDlUEd88ndSUkKvafplxc42Uq3fLoOA
Date:   Wed, 14 Sep 2022 17:16:43 +0000
Message-ID: <cdb385ee-25c9-a82b-2b36-92b5b2e5d198@nvidia.com>
References: <20220912082204.51189-1-p.raghav@samsung.com>
 <CGME20220912082211eucas1p2d7cbc34d8ba679e525442128698a1116@eucas1p2.samsung.com>
 <20220912082204.51189-6-p.raghav@samsung.com>
In-Reply-To: <20220912082204.51189-6-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BY5PR12MB4052:EE_
x-ms-office365-filtering-correlation-id: cd2f4efb-14ca-4afc-b5fb-08da9674e58c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LPUiZjvfK6SiH9qbo71qYIaIQdOEXD6TxvUiQ+uvNmHeZxMn9oh3iD+vq+kbnrl9LSButrwpsR59ILUEL0WtHU5GteB7TLcLtEBROktLQW979vkHBBnHohHYhUr7dnKSq2Ycemf6P6+q3tZJ+C+xt88sh9s2Za/tdBe2G6jhcFWt+joAaBAdYpmn5ChdyZk1nPQyR3BOGR0lsB4lM5lyJZj2fu9nX0A9CQWNE4T93k7H1EzDpVtKZktSJsoDzg6lRKvH4vX4XheuLCUSTlQ8DoFflwMsn4XtEqDrFDEbEzmvtvo1IqXcatQwDg0nHba6OsoTE5rqC8C8muwKBnZjN+YZVUSiZS2rmodO/yN0Tw8OctJf6g5ErBPnswFAMFeQOD0nky+X7j6b4Ej+Ix3y82z06r5R2Sf8R/I80ZHf2zqaXIk1dbQ4kFHCimBV5vlylLg+wvt9ridvk71Vb82veVKmNDJ+ZGgxxS+/JfaVUY8UZ9JmLS++2U5WJQrO4etdWtZUOWV6Yveu+HLmsggiNPIpx1PmwkNykNKLvovN3h5tCNWjtBE2PNyRV06XVGBBQLEdS1rfOiP5vwEwCMyk/GTDpvA9VFdM7ReHqQTFUsbmLdCdwO6NdoVwHkkQ/GPuKksMExBqtPdvDRdMS617J2t+r+dayKBAcrXGv/60zresNkkknEpdYqBE+bmWq1Ub2eIQdBXNoZz0u7kVVwIwKBRgGrH1N78rdJkEuynjCHNOgGqhVdbOD0z75xDm+DyISrf4U7sI+N+1FRuAQwii5Bwe2BUtBNJoHAVNvzu+wX/yTlArrZLmImv29bxBwmvg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199015)(8936002)(71200400001)(110136005)(6512007)(83380400001)(38100700002)(8676002)(26005)(31696002)(38070700005)(478600001)(66946007)(6506007)(4326008)(86362001)(7416002)(66476007)(66446008)(64756008)(186003)(76116006)(66556008)(6486002)(53546011)(5660300002)(91956017)(2616005)(4744005)(54906003)(36756003)(122000001)(31686004)(2906002)(316002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmlkK3RxZmYrNDBDaGNvQmV4MTRVTDFCNnd6S3Q5aFlnN3ZHaC9UTmtLSEVw?=
 =?utf-8?B?eXBaaVR2eXdUeENSaCtlb1N0bkkwNm5zMFIwVVNsN3VRdVVmSStMMHpHbi9Y?=
 =?utf-8?B?bzg1L1ZOeW1vNjBadzQveU5Uek93ZmxSUWg0V2FKT3QyMGxYT01yWUt0TTAy?=
 =?utf-8?B?TXVwakE2WG1sdDF4MGsvMHVMTWhNY2FnVFphNklub21PNE1QakJNWmNFOWMz?=
 =?utf-8?B?aTlOdHJIM0hRSkd2ZWhjejI4THlkMVNnc2NlUlg0aTg1ZGZVRWRrS2tIeGVU?=
 =?utf-8?B?dUJWRTllSXB0eit6dloxZ3dIWlUrNjFoZXNqVE82UmxPcElvWVJMVkhzN0tC?=
 =?utf-8?B?NndXYkE5Mm5URVFPbDkvTG9JbEpZREc0RHcrZGpXZ2tHL1Q0RFpwUndmUnV4?=
 =?utf-8?B?U0x3Q1RxbC9WS0hteG4rS1V3a0c3VXRFNlpiREVVbm0yZ0tiNjdLZTJVUTRW?=
 =?utf-8?B?OWNVcHJvMm5HVTRuNCt5Tm9zSVdKRGdaTkthUHphWmpPRncvZnlkRmJlOExZ?=
 =?utf-8?B?cVMwTTB0M3U2d3JuZDEycGFwZDVLQkZ1VmtFN2ZxM3JDZENiQUpOeDVJRS9m?=
 =?utf-8?B?aUJZTFpVTG5GSkowYWNlbTFQcHdpbDU4MmdEZ25vc3psZldYaDJQRk1Eb0ZD?=
 =?utf-8?B?eFZnYXNsb1BsUjRoYUpIN0ZUYlhMNDl4MUJuL3VGOWZ1WUR6VzdocDA3eUJu?=
 =?utf-8?B?cDFwS21UbDdFVGt3cDR4NWp2ZW9HcW9rVWZORi8zL3NmOFJMbFB6Y1ZKZHRL?=
 =?utf-8?B?Q2o0c1hVdGduNlViQjVWTjhMSzE0MzZFL0wvazQ2WVZmV0pyWDdSSUkycTRv?=
 =?utf-8?B?QkZXT285WWN3RlR0MFdwT0dtNGR2bXAwRFcrbndzNnpyQWFDTzRGSS9EK3dw?=
 =?utf-8?B?UWI5NUY3RnJTUDR1dVAvZUpZUzFhc2ZDZE5XOWhMTHFQcTJwUXhteG42M2E2?=
 =?utf-8?B?RVFCbUdJMDJLME5qei9XTTJaVWp3emR1SGR3a3ZTcWJnVmw1SmVhcnlkSmRB?=
 =?utf-8?B?dFhCanhta0hLVmxZNExXcnQvNm5Ia1hlMlJMaUJGbGZLUlpjTTFRd1lncW5y?=
 =?utf-8?B?dFV2UGYvUzI3UzNoY1JVK1BJcVk3ZmxpU0hSUmphb1Q1cytQQXFHYUFXWEhi?=
 =?utf-8?B?SWJaMDl3OGVlVjVmbGJSRjhkNUFDNC9UZzBtdlRwSW5XTmppTkllQ0NyOTRi?=
 =?utf-8?B?WXM0RW5lYnVtTklSV3J0K2w0UlFWNWpHMHRHZjdmTDJBNU16czVaMjVoV29U?=
 =?utf-8?B?dHRON0FZeDBISURmSkZKWFNxVnZkY2F0YXBhdXNKSUxwYVlEVWE1WENCMFMy?=
 =?utf-8?B?Y25qREZ3Y01LNTYyek1hYXpwMHRJY0NVUkdkakNOTkVzV2pMM1UyNWFrZ1BT?=
 =?utf-8?B?bDdsbExWZ0FLWFFBK3AwTUIyRUVMbXQzYmh5aFJrVWRsMkxIdFZKV0Q1M3dN?=
 =?utf-8?B?NlNWMU0xLzhObFhvaGxTWUVkUmI0OTB1Z2ZFQmxVYkZoMndmVExudXpXY2h5?=
 =?utf-8?B?U3NQcDE3cmNEaG5mMVRoVFUydDRQNEVRU3RjZVhsUmN5cHVOZ2xLRVNWU1cw?=
 =?utf-8?B?T1ZWSnlCUkJQS2tTV2hlVHdpaVJONDFIMkJmU2JkaHU3WEVLUm54MEQyekU1?=
 =?utf-8?B?U0hlUFpxc3htNXV5QzR1Z0s4dGJUYzdjZWZkTUlaVkROVTFkRW1tNkRrQUxp?=
 =?utf-8?B?cGhBdEJWTyszVUJWYXdqbXBPaVdRZVlRU1VGV2k3dnhXZDhWbTZYMkFrNzBI?=
 =?utf-8?B?dWUyWEdrR0VKTk1Wbnl0QlFxandiUUJTR3FwYW83RXJVeWdmWEtLM1hJZkc3?=
 =?utf-8?B?SDAwYWFBU2JNZGlhODFkUkJCaXZTelB5dVcydnBLWVBmcmRCWGRYZFI3TG1O?=
 =?utf-8?B?M05neDJKeitLSGFZelhWODZTODliS1RIZjl1OThmOFh3M2ZCaE5xa0hBTWVH?=
 =?utf-8?B?VmlTVCtuSW9FSmFJWEFiOTl3OFp5bjdTc3ZFcGEzbGdCRFBpU2t6ZzFZQkJj?=
 =?utf-8?B?Zm5mUGZBaVlzelBMK0VNbk1lS05VMXRUTlBiZTRVK3hjakJONTVVbkE3bHV4?=
 =?utf-8?B?c0NQM0hwVXRKc1ZRVTYxb2N0eU5rSHhJTlcyRWQrVmVXODRUTEFyM2xKZXIr?=
 =?utf-8?Q?5TlPxym6SXsKvqGY8JF1Xeon+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE9B28D7A0890A48AEA40060561D3170@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2f4efb-14ca-4afc-b5fb-08da9674e58c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2022 17:16:43.7767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oyZsaP3EyPpv8iS4eUIjjGFtZ8OMul4UnNnCMuCuQLoVKDri1UfXjpWgApxa5XJwkwbaj+hczc1Un/poJeEwmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4052
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8xMi8yMDIyIDE6MjEgQU0sIFBhbmthaiBSYWdoYXYgd3JvdGU6DQo+IFJlbW92ZSB0aGUg
Y29uZGl0aW9uIHdoaWNoIGRpc2FsbG93cyBub24tcG93ZXJfb2ZfMiB6b25lIHNpemUgWk5TIGRy
aXZlDQo+IHRvIGJlIHVwZGF0ZWQgYW5kIHVzZSBnZW5lcmljIG1ldGhvZCB0byBjYWxjdWxhdGUg
bnVtYmVyIG9mIHpvbmVzDQo+IGluc3RlYWQgb2YgcmVseWluZyBvbiBsb2cgYW5kIHNoaWZ0IGJh
c2VkIGNhbGN1bGF0aW9uIG9uIHpvbmUgc2l6ZS4NCj4gDQo+IFRoZSBwb3dlcl9vZl8yIGNhbGN1
bGF0aW9uIGhhcyBiZWVuIHJlcGxhY2VkIGRpcmVjdGx5IHdpdGggZ2VuZXJpYw0KPiBjYWxjdWxh
dGlvbiB3aXRob3V0IHNwZWNpYWwgaGFuZGxpbmcuIEJvdGggbW9kaWZpZWQgZnVuY3Rpb25zIGFy
ZSBub3QNCj4gdXNlZCBpbiBob3QgcGF0aHMsIHRoZXkgYXJlIG9ubHkgdXNlZCBkdXJpbmcgaW5p
dGlhbGl6YXRpb24gJg0KPiByZXZhbGlkYXRpb24gb2YgdGhlIFpOUyBkZXZpY2UuDQo+IA0KPiBB
cyByb3VuZGRvd24gbWFjcm8gZnJvbSBtYXRoLmggZG9lcyBub3Qgd29yayBmb3IgMzIgYml0IGFy
Y2hpdGVjdHVyZXMsDQo+IHJvdW5kIGRvd24gb3BlcmF0aW9uIGlzIG9wZW4gY29kZWQuDQo+IA0K
PiBSZXZpZXdlZC1ieTogTHVpcyBDaGFtYmVybGFpbiA8bWNncm9mQGtlcm5lbC5vcmc+DQo+IFJl
dmlld2VkIGJ5OiBBZGFtIE1hbnphbmFyZXMgPGEubWFuemFuYXJlc0BzYW1zdW5nLmNvbT4NCj4g
UmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPg0KPiBSZXZpZXdlZC1i
eTogQmFydCBWYW4gQXNzY2hlIDxidmFuYXNzY2hlQGFjbS5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6
IFBhbmthaiBSYWdoYXYgPHAucmFnaGF2QHNhbXN1bmcuY29tPg0KPg0KDQoNClJldmlld2VkLWJ5
OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
