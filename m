Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4076F54F5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjECJlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjECJlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:41:44 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD1744A4;
        Wed,  3 May 2023 02:41:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nO1Q+HyqFPVMbcCviA7pXNSxh3nfFkbpD1RWkaMzarWkEkT8UF57cZSpFc7+6T9c8GI0g4BpOn/REtS2pXmv6Jpa47vxQe6grf8oSoB7DT3rl41Ay6EmHEtaOzTlYhAyYQpn2jo9RblJ7yxT/4CDzaxXBYda+raiRdjy/loJZgoR5MNEUha4bZrvBuA881QPSukA0Pz1K8wr3yS43tu6XP/nsnRenTkmSspvLquxkHFXNsB5ERCQ5ppNDrVbPcXwxIR33/h2YRKD4aX9oj+K4MI2joMerYn2zrr8s7NmZgGmplMGC+9twqQObvGbFtCZX6bPWbR1TgtJwW9iqlNfqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KCvTCjSAqFtmcOvD/GXyuga+43SPi70GSOPbWnlhsc=;
 b=WMlR+LnGVQwoIyz6QtiIbE1DfxlMb7ovYNXLEV/bnpFeWn0GtNdihoomimbHa3XaID7sVWu/t46rmtfZtqp/0xQATFpfWTfqkeCCY7SbVsMZDGEKrqhi3FHStZ1hyHct+raClMve9KdrkwtH7QGN/tOdUFwqy03QtS+Dsp0DxRUZXw2bgLKyveS1r4pH1ed1yGYEb6M55irGUO5KanW0LJZu6Sa42vZGp5Bf6C96SR90NC9+OHXKDt57efV2brPq/BW0a9Dw3xHnnEC0wUdmcTguTlChxxHizqXrKbuwE60CPOLEeeoK4JAoNI20lfmFxPBVUTy5ENC7+1eb6et94w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KCvTCjSAqFtmcOvD/GXyuga+43SPi70GSOPbWnlhsc=;
 b=ckeC0A0YSYrmA2nEUcaaJ3qWaVZ2p4zspNqY6AITDsv/fMF+VDjbj27twjLQN7anfM+FmTEsvMq9xlrYScKPygwvy6CBgoUKaa/tNyf8XLF6ZX4amOqckHyFcSjqe8L4e5cjP9tmM012xEPkjFvUEU77669n5Y3qne5Dj2ScSuCfZS9ZDfaAqdgWa4acxGF5y7R7uCO9okmpl6KGEywkPlWF8dhWcQ9OvP2LosfUWNu1RkYJ2VgqRVOBPmdrGy5OhcxwGxKCcwDi8qjAD+tGbsu2EBvRR02EVD4O28VlEsYGtwtDyIDt3MOb2hqJSZR0M2vkcaLPBno/U6gmP+sS+w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN0PR12MB5737.namprd12.prod.outlook.com (2603:10b6:208:370::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 09:41:37 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%6]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 09:41:37 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 09/12] common/fio: Limit number of random jobs
Thread-Topic: [PATCH blktests v3 09/12] common/fio: Limit number of random
 jobs
Thread-Index: AQHZfZW4HmjkjzpblECxXYEAHu0pVK9IS7wA
Date:   Wed, 3 May 2023 09:41:37 +0000
Message-ID: <99a6cc5f-31b2-787c-f448-53239a351ddd@nvidia.com>
References: <20230503080258.14525-1-dwagner@suse.de>
 <20230503080258.14525-10-dwagner@suse.de>
In-Reply-To: <20230503080258.14525-10-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MN0PR12MB5737:EE_
x-ms-office365-filtering-correlation-id: 4a31ecaa-7746-4da8-aea1-08db4bba96df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9ed30oT41tZMLqF69NDHaZV7ndtnuC34qkanTdp4DgyDJnycg7AiCOx48sJTiryuf/nlBBItRRjKD+IMumDKpWcBtAdisE9faME406ntnQhjewtXwb49CeFeqN8Sh2aCgL+REeaLPug5O2X4Zs88ysHPj7nobdBkoy2cOdltaPXIWT9Fjwc9SWfBKs7MQ8uTIkHZG0WrsbjUI2z90GhpM5xDvjAIjQZ18kvmp5LKGLTeU979esR/UGsZ+6khxKCwTpC1eSfRfSDzjnQNYPN0WJBDE3WvTpVo8cp/D41edaLyaxcjGjBaVeqS9FJdYAkHaNj9Y4k1cbJZ1clbvXsK7YNbhsjKYEtd38FEy9YzKBEclNraVfTx5SpxOQJKdngaE77m4TNIZtQSmYl23mxfxsiy4ihgM2krdEws+aIHMlc3vgGDLiVIytCqmOevacT9PKKeN1rCDLL4Vt0rdoZgZyeciIZATLrpkskQgV2JRL+2IVUxHdNVFapxvU909c9fcwJI+JDj6YDODf8EPXpyiXO5+dH6JMvrXZsUiH+0mn+/m9B74dZwm/8mXm3Nu6kffeOmUJQdMwfe1BuvmQhqW+jZ3ahOvXAdD3Qj18JrYoJuPhRJ9Y53WSJSt5uyarz5bbsbDYmitfHGoRxQw7AYSCuM8bT4N+oAdmvRm5aNAAYg3rQa4jOeZsei34yB6bYb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(451199021)(83380400001)(31686004)(54906003)(38100700002)(122000001)(186003)(41300700001)(110136005)(86362001)(2616005)(6512007)(6506007)(53546011)(31696002)(5660300002)(8676002)(8936002)(478600001)(2906002)(4744005)(38070700005)(36756003)(316002)(4326008)(6486002)(71200400001)(66946007)(66556008)(66476007)(66446008)(64756008)(91956017)(76116006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0dmVkxsZW91STJBNCtjbUlqR2hCSTVWaEUwc25zTC8rK0YxSmJ0bDlIS3Ar?=
 =?utf-8?B?cVhWL29NblhvbmVaajBsbi8xdHpNL2hjZEF5WWxMNDlRckNZb2IvWXF6ajJn?=
 =?utf-8?B?NmxyaFBYNVVCY1hDTEM1ZzFXYnBlVWcydVlWc1pPbzZYdXBNMkk5VGtyMWhG?=
 =?utf-8?B?QUd3eHFmaEZCSU1hZmlJYm13RjV4STRCQkNpMEFYUEtDTUVnMmo2dFlHOXN3?=
 =?utf-8?B?V05aZkNFRjZVOGtuQ0txKzNOaGQ3QnNZTEhhMkZnYlVyUS9pTGtlY2srdzNC?=
 =?utf-8?B?Z2ttSlpLZ1RHUWcrREFCSDZEajVDQUEvOUM0a0Q2WUhCSTN0d3I2b3A5TFVn?=
 =?utf-8?B?dWtOak44d202ZFI3UW9nZ2o4UGl6T1ZPQTdISzlKa2l1V0laYmVkMmhqbitK?=
 =?utf-8?B?S1ZrMHBPVk81dmpsUitXMjN4ZTMzRTVmaUhmQ0Z0bzJOMUZwZ281RXlVT2or?=
 =?utf-8?B?ek9Rby9sYjZQUVE3YXUzSm9sZUlDeEZPRDhVekV0azA1WEFRbG5CYmpHUnYx?=
 =?utf-8?B?NVIrK2hhZVkrUndwY0dSNzhYak92TUNCT1Y5TnJwdVlpYXBIejJFems2N1Vn?=
 =?utf-8?B?cDlldHMyY3d3aFVVdWc2NjFBVFhFZ1NQYnc0djJWOFdITENCTXlTK0hvbUpS?=
 =?utf-8?B?WUtySG01OHVzdGhuOFhOS0t6cjl2Um52T2o0TEw4bHZ3Y1RUZ2RoRk1vM2U2?=
 =?utf-8?B?cVZlUWVjTzNtUWF6MlZ2eGF3RUczUlp0ZWdzY3dTOENBd2Y3SUp5S3RxazJp?=
 =?utf-8?B?bVBmZGhLbjIwMHdNTlVkOU1vQ0ZESVVmVmRtNE5aTHBtbjB5RzEvQUVub2dm?=
 =?utf-8?B?N2IvTG9QanJVZDc0Q2phWUhBL1ZOYUhuaXI0YWhHWDM4WjI2Z1N3ZkNkMStD?=
 =?utf-8?B?YythOHhVY0x0Szk5cnNRK01wMENxQTR5V3YzbUVDZFFNOUZCVDlhdU1vOXlY?=
 =?utf-8?B?dWpvaTRYSVRnYUNwRkw3T096bFl6TnFVUG9RcG9GUWxMU1hGaTZVRXVVSmxn?=
 =?utf-8?B?UVV1ZnUzTEpRNk1ud0pIemo0VE4zUWp0SSt1TXY0SUY4RUd4SGZlUXo0bHpV?=
 =?utf-8?B?V0Nnd0RJZGlwUkhvVUwxUUVybWpXNjhhS1pRL3NSdTRCc2ZTUnFTbDNzZmoz?=
 =?utf-8?B?YnFvQlp0QURsUmM2TWN6RkNReUk4OUQ2M2d6bmYrRDlLUDlyWVA1TjduQmpi?=
 =?utf-8?B?SlRoWW1xWW9rcjlQUGlnVFNmRjZRRmJkdWJGdEVUc01lR0p2OHoxNTduV2py?=
 =?utf-8?B?NGRSdDRDOG85aUs3cjNWZkV5WmNuNXZTQXY0TWJnZjFqVXhyS1JJbVhTMXU1?=
 =?utf-8?B?TVhibC9saVhPZHcrRUZwSlFpamh5N1hCSm9NdFlxeEpQbFY4WnlGNEdCRThj?=
 =?utf-8?B?OWNoS1AvL1VoRUpCUG9mN1F6dUVLRTFSQTNkM2VzYmROWTJDRTd6Nm5XS0xE?=
 =?utf-8?B?VzRpNGQ5ZEJYdnRGUGlDUHY3Tlg0eGNlcWlFUTVmaXlNcHNYUWtJWG1jNEc3?=
 =?utf-8?B?SzlNY0JqQWpVd1c2U3RWMTlzbCtHdG4zS1ZwdEFpRUxLRWlORHZpSnV1eHF4?=
 =?utf-8?B?czRnblJFOGJRUm41WlNXakh4RFhNN3Vhc1crYWpBbHNlTHBZZ0ZtSTBNYmZS?=
 =?utf-8?B?dSt5QnR6eklaQ1JpelhielI0VS9uSGthaytBK3NmT2R2NGsvZXBURW5pWGs1?=
 =?utf-8?B?VmNQcytQOUR4RU1iV0dKa1YyMGtTQlR3RllaR2dmc0hvNVh2bk9NTzhWdy9z?=
 =?utf-8?B?KzN4Y0FoODB6ZCs5Z1hDMlAwb3lWN2ppRFF3M2RhbGR5Y2J3My93K3hhaHYr?=
 =?utf-8?B?aHFSWXNMbUlmQWhKUFJoUUVvQkNhYisrSElRWkpVRjlpWm5pU0l1bVBtV1k0?=
 =?utf-8?B?YVZ4a3FpM3R2d0NleDFVb21ERndhdk9QVVJ5c0RRb3BTZHgzYTJES0xNN3JX?=
 =?utf-8?B?WUpCNHRUOEFUVkgzdzVLdWtjdXBaNndtbks4dDRwQ21pUkg2bmYvNG91Q0dU?=
 =?utf-8?B?cG5kM1FYSnRyMFRiMDlvd0JJSklhYXhQNmZPZkh1WEpaZHY1M1o4TTdDd3Bs?=
 =?utf-8?B?YXBvSnpLWWswY1ZXQ1pLZ1ozLzNLam5QTDMzeGx0RjdCT2toTU5SQlp5blQv?=
 =?utf-8?B?YnZRQUFsbytGOGl4VVkrMGRqdjNySVUvYW44S0pTZ2pUVjFlWVRzM2lPWXYy?=
 =?utf-8?Q?FcQ0sQ0HycWVYA91Uga5ZarEUqAZpiRPmvpMmZWpASiS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C9175129048F441A508ACCA7D9AEF2C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a31ecaa-7746-4da8-aea1-08db4bba96df
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 09:41:37.0303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: onu2FOrt8prRGrOpS0sgsJcPNvobqE4QvcrcEjOvi/LZ+nwlAm48HiGg476TbTP54diE6ApISzdU4aRIHpVKXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5737
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

T24gNS8zLzIzIDAxOjAyLCBEYW5pZWwgV2FnbmVyIHdyb3RlOg0KPiBMaW1pdCB0aGUgbnVtYmVy
IG9mIHJhbmRvbSB0aHJlYWRzIHRvIDMyIGZvciBiaWcgbWFjaGluZXMuIFRoaXMgc3RpbGwNCj4g
Z2l2ZXMgZW5vdWdoIHJhbmRvbW5lc3MgYnV0IGxpbWl0cyB0aGUgcmVzb3VyY2UgdXNhZ2UuDQo+
DQo+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBXYWduZXIgPGR3YWduZXJAc3VzZS5kZT4NCj4gLS0t
DQoNCkkgZG9uJ3QgdGhpbmsgd2Ugc2hvdWxkIGNoYW5nZSB0aGlzLCB0aGUgcG9pbnQgb2YgYWxs
IHRoZSB0ZXN0cyBpcw0KdG8gbm90IGxpbWl0IHRoZSByZXNvdXJjZXMgYnV0IHVzZSB0aHJlYWRz
IGF0IGxlYXN0IGVxdWFsIHRvDQokKG5wcm9jKSwgc2VlIHJlY2VudCBwYXRjaGVzIGZyb20gbGVu
b3ZvIHRoZXkgaGF2ZSA0NDggY29yZXMsDQpsaW1pdGluZyAzMiBpcyA8IDEwJSBDUFVzIGFuZCB0
aGF0IGlzIHJlYWxseSBzbWFsbCBudW1iZXIgZm9yDQphIGxhcmdlIG1hY2hpbmUgaWYgd2UgZGVj
aWRlIHRvIHJ1biB0ZXN0cyBvbiB0aGF0IG1hY2hpbmUgLi4uDQoNCi1jaw0KDQoNCg==
