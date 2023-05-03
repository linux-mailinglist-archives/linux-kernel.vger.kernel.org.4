Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5555B6F54BC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjECJ3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjECJ3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:29:20 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9510A59C8;
        Wed,  3 May 2023 02:29:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpwz2WCi3bAH9TVPtM0XeNGJJYl2fGOLhovh9dsKBqkRnpovIfkvQAuce8xIl2II140zX6GDFiFBUsYG5Qo2MK3NDl9Yws1kVviA98qNQ8Aqewd5oXo1PnYj3ZR/zSfCikSWsooAidgk4w4VRMliZKorJlvcJwDQoCb2TNPKEujK6K/PC1bqUA3TBUl7lHsPAOcVlYbZnOFuyHYafEJ5xBBiBj6jOaV5OXMN8rxFWEp+b9I+vRyFcSnZEc8lHI7Ghdf/afuraGvanLr1H4FhGo3xv+izWyYZvm/89ODiUJOU4KfuQ4erKgWLVtshR5+LljvCsyTXi6yymW9XQsxXGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNRQNTvW1FS0pe3E0KuIyspWtQP1yhoBWx17KGr1F/o=;
 b=UiZ1c2mOHORfypA2aiGqaEyZ9ZuWrGHQfNBQ0gsdRlk5Ve43yQIFgUAPl1tFtB9fML1qtEzboGTvPw5Uwm2vh+jh5DXt0xPVubYi/DdwVLsgKeXoUs7QVldljzANtt0FhMlyLGWfwlMdOGueXVZdNm18VCRAii7eH/3GLuoyA6IdxBxjEFMt7HJiK+xv36FesogFBXOhDSr6m42VZfLaabUKlCns+mCiKdwAX+WA0U4+DquKFsEDMdZO54uX79G/Os72y1S51V29cxEgh1+xGXG4uyiOYmyr5sHF1dslW4CHSs3WETmSMwarNP23VmXF3CH1Cm3UTpu9rkOjfihSMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNRQNTvW1FS0pe3E0KuIyspWtQP1yhoBWx17KGr1F/o=;
 b=nw/woZuGIoZSEYe2cxuZeTFFurWSu1GcHGh4hgJLlfYPrMMqiKciHbErCCH7GD/x8WfWqRQqIFad4V5B227vWBlVINl+FTs5N4S191H3gAJAeaWjTZePEEG49I8jdD9PFlDVBlkO1KxcXGoJuOvmOmkBmFgZeE+2c5iLw8aZ2kB5wMAMfPGatwpu5OKe14cKBhgzajwR2BUJgB2OOzfxNvvddxS7M6nJ2vOod6mSq9OzbRhPdfDKYdAm8cSRANltMp/NJB++4VuNmK7gVBXkv1/L5sfiKbMfJ8zSG1/gSvGifc8BfLO22S6O4MDDS9vtmXbxxJTIU01UemJuOJ4j1A==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 09:29:04 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%6]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 09:29:04 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 04/12] common/xfs: Limit fio size job to fit
 into xfs fs
Thread-Topic: [PATCH blktests v3 04/12] common/xfs: Limit fio size job to fit
 into xfs fs
Thread-Index: AQHZfZW25OetHZqxo0WfgSUuEuJcT69ISDqA
Date:   Wed, 3 May 2023 09:29:04 +0000
Message-ID: <74e9c631-23cd-705c-7043-88f345598ad1@nvidia.com>
References: <20230503080258.14525-1-dwagner@suse.de>
 <20230503080258.14525-5-dwagner@suse.de>
In-Reply-To: <20230503080258.14525-5-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BY5PR12MB4164:EE_
x-ms-office365-filtering-correlation-id: 6a59a58c-3573-4452-f2b0-08db4bb8d640
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jaDjejPoWgvFDS/nD8DZGwlIg/FCBu6XbuOR9oyhGNE2I2x9qwOb0+J3AlEHJPHmYSmetQ4TBbjp1FMlyeF3K8rCYGwsS1uzwpvkL94LhG8xjzYCTqm+4bwHzmZZfyYwO4/VCPcUgHv+FFlrdobwab61lzWSZXUcvZuBAn+usOqKinssIQla+siItB1iJn01ul6/oGoQVbNf3y6lWoLb09DgJa/wXtG11cnNcUpFl8wfjhdx8QFGacLPoeovk5pL6SN9qSKgPVyn98IqpE8TVMtC10HQ0pePFlyARFfLYpK/duHuZTlYFmNpIIH4v2KzdNsJs/bMsS/SFpwy88M7P+RZ/t0GySqB/qHgWe2oEDRV217fbBlL/QcXBElDH+1ddePVCt62VCVJOdRvVSpicWM0AQ2LuDSQpNBo/1o2kI4CAm85c5XTHfCCwTrnZLF41c3TT0fRwySQS/M+oG0RzOxnJjQOjW8kGdsYe5SP7hQJWTbua0ZsIkCd9lPzDwDxDcMV+agIW+F1czEAXXqFbLgIDKuvgJORZ593w+HTJOfvaoFLCvhf+AUxSURi5cJ/11rpL6DeitV424uOJH7HY6gG2W1CNgG8E2g2nmK5i8wfNt5MlkeZHiFKW11HgiPHk31v0hmtT9+AqYFwBuJb7jAtpXV7niHgZ35d3xaKLttkBHjYQTDs0mpeNyysJDnf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(2906002)(122000001)(38100700002)(38070700005)(2616005)(83380400001)(6506007)(6512007)(186003)(53546011)(36756003)(8676002)(8936002)(5660300002)(64756008)(66446008)(110136005)(86362001)(31696002)(71200400001)(54906003)(6486002)(316002)(4326008)(478600001)(41300700001)(66476007)(66556008)(66946007)(76116006)(91956017)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0ZEWGU3L0w3VkNITUtZTjRHWUt2OVFnSTQ5M093TlZlbXkyV2VJOUhnQURj?=
 =?utf-8?B?c1h1a2wvZ1VUY2dxemJOaDFCcXArWWRwdlk4YzE1YVAxVm14Y1o4NGZDRnZj?=
 =?utf-8?B?K1hYRjBUeFIxbEM2UVdyQVk5MFNiNmdjWGZJNjhqTlQ4WEhNT205VXp3Yitp?=
 =?utf-8?B?NVlTOW9KYUtXUWdpNHdQSkYrcU1Rai9OcEhhZzlJSk01YUVZdnNJVjRDWUNz?=
 =?utf-8?B?YVliRkpRTnNGcUx6L1ZTcnBhUUZFUWdlNHVtOG1INGlUY0RsS3dTZ1NwSVNl?=
 =?utf-8?B?SGJhbzVSZnRrOWZrcUc3eU9rbjhZbTBiUW4yZ2Q1d0xjRXZuUERWamx1d3Ey?=
 =?utf-8?B?MmVTZnMvTzhDYVE3V0RHbDN3T1VhcGdSc1FGZmlsai9nZGtVSldKSzI1aFR3?=
 =?utf-8?B?RWtwbDk4SHByTFgzbHpQYmQrVXRrY1kyTW9Xck1OUUFqNStmVFBRWGdyQldp?=
 =?utf-8?B?RE1neDJoSUNPZkVCVkRzNUFaUklBdldPcjA0aEd3TGQ1b1BpR0xnVi9TL2tp?=
 =?utf-8?B?ckhRM1BHdlZ5cFg0eW9IN1lFUjd1N1VhSU14VEt2UTF3Zyt6TW1uTGR2anpV?=
 =?utf-8?B?OW1lY3VLZmNCNSsrYmowSnZuaVZYRkVlZXlLcDFRTFpvMFdvcXFxcjJRSWN1?=
 =?utf-8?B?MzN6VzhuNUtac0VUanhVRnNPMGRWTFRCK2l3SFFWVDU0ZDhzbC9PTlkrWGVu?=
 =?utf-8?B?V2E4V3FJNVp1eWtWSzhUcCtzR1YrditFcXYxdVA2WFc2ejkvZ1JVZ2RMOFdn?=
 =?utf-8?B?aWhJZmlBeDFqQUJrcWRyemxkZE9kazZYS1E5ZFdLdFJ1cko0WFExRy9PZllz?=
 =?utf-8?B?ZU1McE5VUjNXSUZVWVhiTzhTZVA1eCtnRzl3SU1mc3YyMVJpQTFGM2NzcWxG?=
 =?utf-8?B?L3BBZGNtNzhWdldUQzJMbW50eDZvNzNFcDZyTEdoM1cyNjVzWTBZT2UxVXFE?=
 =?utf-8?B?cXpaa0x1WFZOdHUzK2JwWGJJYmw3MU5sZlBGanJmZVJiaENBQXRYcTQ2NWcw?=
 =?utf-8?B?RWtJYlc2a1Vzc3lPTHN4ajFwdXhld0pxUnlrTzlVR0dPamdzMEQ5TUZxbVc2?=
 =?utf-8?B?MnFBMmllV21nVU1pMTQ0eWI3VVN2RTJVUW44UXErN1UvVFFNVGxYR3hGdzZJ?=
 =?utf-8?B?UkpwVXg4OGFVVlFGR3FkYVI4TURuRnZmMHVOQzFZc2JsT2xpSlRZOXpoSWxN?=
 =?utf-8?B?NUp0QmdLRlBueDFFdFVkSk5JMVJHcnY4cFRBS2ZkZmx0TUNjOU1mM1B6dXlG?=
 =?utf-8?B?ZXpRMXltcDhzSFUyWjlrNHh4MmtkaXJxVnFtRzgxV0tDVHJXdm1qY2RpWlZz?=
 =?utf-8?B?UjZqMHdOaW4rR0xkUHhUUzhIWUxJZTJpaWNOeWpMdkxzOUVjMEw1bXhYQllS?=
 =?utf-8?B?eTM4RzFtMndQK3VRZGxEZ2o0S1ROS0hFdkU2VkNHaTd0Qy9Kb1daaFN2ZUhZ?=
 =?utf-8?B?WkVUREVNUWtHQUZzci9yRWhLMHJ0RkVDT1ZGUGdJMnlEazdBY2N4c0k4ZkE4?=
 =?utf-8?B?STRYRHRQQk9UeUdKKzVsWks0TFpIYS9GUFh5WlhQRHBDM2xuM3pXNUhEQjVi?=
 =?utf-8?B?ckgwZ0JQN3JZd0RmRENwTVh4SHFMYXFEbk1VSnRqVGkyNUdSTmx1M3NQUmJP?=
 =?utf-8?B?NitiNW5nSnFRZ0ZaVVlVTitxaHpnVGlHeE40UUVkUFMrY2lnbk91ajI1bHd0?=
 =?utf-8?B?ZzJYcWZWc1BFM2NHbFVmRDVHdzB5MlAzdG8yUXpiTjZyUnpMS1BYTGZ6VDFq?=
 =?utf-8?B?MWYzZHM4QXBKK0wwNTdOQUhabm1RamV6ZFRrL0padDIwMld5TnpOZ0pKd0s3?=
 =?utf-8?B?T1ZwSVFHQy9vQjdab0JCTVlJTGpYT3FZVWtocnFEOWZ6NnEwZnBPclhTYnR0?=
 =?utf-8?B?bDdJOWVVSElEcUlETW9jRHZuUHRVUW43Q2NtczVYbnpTbnFZZnZTWWRCSU5D?=
 =?utf-8?B?UFl1bTVhUVJIek40MCtRSFJqbXVITmRwR3Rhd0R6ZVl2c0ZCWTNHUVViSW92?=
 =?utf-8?B?TEtBY2tldmZLVk9qYi9EZVJBelc2L0NjbzVLYkVmZDV1dU5kMDhhRElYUExj?=
 =?utf-8?B?M3h4V2xKOHhab2l6aDhKM1dXRVVEZk1EcVd6K2w5YWlzKzdEd2szejNwWjVZ?=
 =?utf-8?B?ZVJ4d1QyWjlXSGdnb0FuQllGNkVlNTVTK0c2cFNTcjBSazhOdFhraTZWOTJT?=
 =?utf-8?Q?y9ed9pSy+sDGO0sKeTONKTDC6bSYbi9kt1k4apb+VbKI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75226E3A30C9AF448E690D7228C9AD2A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a59a58c-3573-4452-f2b0-08db4bb8d640
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 09:29:04.3186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kt8kkgPCYGp/+ArPoIENPZm+HHmpQsRg/qSwAKBiHlWr2kM4wyis3GQE9ufzVTKyAQBAyU4RlH2BUIWbdg608g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8zLzIzIDAxOjAyLCBEYW5pZWwgV2FnbmVyIHdyb3RlOg0KPiBUaGUgdXNhYmxlIGNhcGFj
aXR5IG9mIHRoZSBmaWxlc3lzdGVtIGlzIGxlc3MgdGhhbiB0aGUgcmF3DQo+IHBhcnRpdGlvbi9k
ZXZpY2Ugc2l6ZSBkdWUgdG8gdGhlIGFkZGl0aW9uYWwgbWV0YS9sb2cgZGF0YS4NCj4NCj4gRW5z
dXJlIHRoYXQgdGhlIGpvYiBzaXplIGZvciBmaW8gaXMgbm90IGV4Y2VlZGluZyB0aGUgbGltaXRz
Lg0KPg0KPiBCZWNhdXNlIHdlIGhhdmUgaGFyZCBjb2RlZCB0aGUgcGF0aCB3aGVyZSB3ZSBtb3Vu
dCB0aGUgZmlsZXN5c3RlbQ0KPiBhbmQgZG9uJ3Qgd2FudCB0byBleHBvc2UgdGhpcywgd2UganVz
dCB1cGRhdGUgbWF4IHNpemUgaW5zaWRlDQo+IF94ZnNfcnVuX2Zpb192ZXJpZnlfaW8oKS4gTm8g
bmVlZCB0byBsZWFrIHRoaXMgaW50byB0aGUgY2FsbGVyLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBE
YW5pZWwgV2FnbmVyIDxkd2FnbmVyQHN1c2UuZGU+DQo+IC0tLQ0KPiAgIGNvbW1vbi94ZnMgfCAz
ICsrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdp
dCBhL2NvbW1vbi94ZnMgYi9jb21tb24veGZzDQo+IGluZGV4IDQxM2MyODIwZmZhZi4uMzdjZTg1
ODc4ZGYyIDEwMDY0NA0KPiAtLS0gYS9jb21tb24veGZzDQo+ICsrKyBiL2NvbW1vbi94ZnMNCj4g
QEAgLTM3LDYgKzM3LDkgQEAgX3hmc19ydW5fZmlvX3ZlcmlmeV9pbygpIHsNCj4gICAJCXN6X21i
PSIke2F2YWlsX21ifSINCj4gICAJZWxzZQ0KPiAgIAkJc3pfbWI9IiQoY29udmVydF90b19tYiAi
JHtzen0iKSINCj4gKwkJaWYgW1sgIiR7c3pfbWJ9IiAtZ3QgIiR7YXZhaWxfbWJ9IiBdXTsgdGhl
bg0KPiArCQkJc3pfbWI9IiR7YXZhaWxfbWJ9Ig0KPiArCQlmaQ0KPiAgIAlmaQ0KPiAgIA0KPiAg
IAlfcnVuX2Zpb192ZXJpZnlfaW8gLS1zaXplPSIke3N6X21ifW0iIC0tZGlyZWN0b3J5PSIke21v
dW50X2Rpcn0vIg0KDQoNCnRoaXMgaXMgZXhhY3RseSBob3cgaXQgc2hvdWxkIHRvIHN0YXJ0IHdp
dGgsIHRoZSBvbmx5DQppcyBub3cgd2UgYXJlIHNpbGVudGx5IHJlZHVjaW5nIHRoZSBmaW8gam9i
IHNpemUgbWF5YmUgdGhhdCBpcyBva2F5ID8NCg0Kb3Igd2Ugc2hvdWxkIGVycm9yIG91dCBoZXJl
IGluc3RlYWQgb2YgYmVpbmcgc21hcnQgPw0KDQotY2sNCg0KDQo=
