Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEB16CF4FF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 23:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjC2VHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 17:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjC2VHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 17:07:41 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B3F9F;
        Wed, 29 Mar 2023 14:07:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GT9UQ5wy4f7n6fSw2HZcvdpw86VS8/SN5WJyukfO72Iyi1vyT9iMZiiuQPjBYTuCnRDMRnBkGjTlomgJ3XrWj+sm2bkES6eEDcZVx1m3ntVGdApEWsZiBIUOoW7pWXtcwra8RRsmjKy1zLJ0NsDBABsapDMm7DSaWzVTZ9muwjd63CoJkHF86gyySsQh1CEb5Lhijlfmm6C4gxiBBN8EbMIK37jDpPu/urR+056rSG21kbUX1XW308b5TMje8i4NT/DY1IEALDZpoqJ5cfzz5f4rgUyweniEXFkGv+pNjdXyf1wvBZXLKj/SkYgbOCJOfKh3Yyb/0ciEUvxRGkSGKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUm7tQIct+DU5YVyc9mv2izgRjEEakdvE6LhrRuf6/I=;
 b=NQ1GJprGbebdPzF6Q55GztOH9Wbkj8s9CHONFlA2fx6nYKQO2CAXGZzLdpb02o7w7nBa785mem/gBoGtJ7ke7PMw42PicybEB0fp+SMWn342ELFH2cKbs0uohzYuazYh6W/7Fg+iZTtcJ436hbcyedkPg6o2lRaBlVZMywwV/ytbOlhwQypnBPEE09IvXqYgEKSszlJcc2rg7YDjz1IrJtViqUITa25S0UxM4xDjulENJUmmeLCbU1eez66REReeLqcvkPAolFqnwewUz8RERrce91pYAiOuBmryETKBIGIHMvLlepV++aAL0HwKLDSnYC6aVqF7UbmeZMLI4KAGvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUm7tQIct+DU5YVyc9mv2izgRjEEakdvE6LhrRuf6/I=;
 b=dkbgToCrEDyGvoaJEKu06O68DbSriSPVeQHtBP/eMGpzma5mkbZSZ3kqmRMgXxsh/FkpHlJIuiwkJC3E1q1T8RpZuilxM8DneZFLwtPzbdItvyhycU6U9JJeUR9ghuAVFvwnglonzHuHGb/l4PmH2DSRl3YU6yHGIWsV9MxZd2npRKeep3APqGa5289CFcyc9qOx95Vu+l7xXjcLZ8qUcbRP4ZLv2xG+LhLDJSPY7T5Ne7SXfpBPX6MHkoonGrG5/0XctOKIqleR2KXr6Z+NnUx4SfagJVIY/yhjMu3kpsfUnZuPjAbWFf1UDuPYw4YAirldzYJB5vhtVxCbletsJw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS0PR12MB8198.namprd12.prod.outlook.com (2603:10b6:8:f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.32; Wed, 29 Mar
 2023 21:07:37 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6222.035; Wed, 29 Mar 2023
 21:07:37 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Tom Rix <trix@redhat.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [PATCH] scsi: target: core: remove unused prod_len variable
Thread-Topic: [PATCH] scsi: target: core: remove unused prod_len variable
Thread-Index: AQHZYkIGbUtUzcLmAE2kpRi25oy/tq8SQHUA
Date:   Wed, 29 Mar 2023 21:07:36 +0000
Message-ID: <6b50e660-f10d-82ae-4a15-86fb575dcab5@nvidia.com>
References: <20230329132421.1809362-1-trix@redhat.com>
In-Reply-To: <20230329132421.1809362-1-trix@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS0PR12MB8198:EE_
x-ms-office365-filtering-correlation-id: b4dc0347-a899-4ea0-ef5f-08db30999fa4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lTDm+wF555bhEgiZTFnmrFndQvx5lfHuvdCUXgzi8BsKh8Kk9yAnBfNBJ8gUAF2E+EaaRbbZ8dTNGlzHKNYaaztD4evMi/0W44ie24jnAq6bP/LX3sYNfMs+nKcxKn93TkCLyJdRdlm0jlk4c5I4ueCdERvmq6BLOIMirbAi6DW0D62NhfERhKRE/xMufhAaaNJzWK6LLfwurVc4Pfdjqa+FZQu14rITDkQFdlZYWwKuiaDQblLksDCx5MUJGtENQqp23xp2r42cLO/3u2hawoqxmCyeFTjijgoSwkErcSrxpV+pMKYXaJUaL8So/zuMZobDziqYwEKPkOiOQ1HSizbanYK0hTfw4rOPWWp/Ek6DhK9uL0BqXkN6KkLWpnaAi9PYv/y5oxLJcwCTsydbJuNz4IVDAUtyVMpArBZ1xQZlct0Ujx/VuGX10947OwWenUY9us8svG/aNa5NKx3/4s9Tx/GgayVTwx9TwFOpAEWrn80UfSJlFzGxDhEo7sr/OPmQQmnU9qzwDCnw6Hx+ithDuFQQfB6+o8CXY7+SWdVxFG9d0eXa5TGmjj2Gpcr5y0ocEKCF0UJ7GvMCnuhHKC/fQC5Th81pTGq3LO9nnvt0fGWGq9rpJc9Q0EH7TKI9c79FzHQ7CGhvC16L4Z7IEyMK3oCL1tiHGzOh40stHTGtockfucSRn+mO5QZ9mUOQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(451199021)(66446008)(71200400001)(6506007)(478600001)(2616005)(6486002)(26005)(316002)(110136005)(91956017)(31686004)(6512007)(53546011)(186003)(54906003)(76116006)(4326008)(66476007)(64756008)(8676002)(8936002)(5660300002)(122000001)(2906002)(4744005)(41300700001)(38100700002)(36756003)(38070700005)(66556008)(66946007)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXdDOGQ2TGpadFlhM3RJWGh3Uk9wbnBFY0Y3ZDFzQnNwK3JhWVlyU3FQQkdN?=
 =?utf-8?B?RWxLNnk3VmhpQ1ZkK0cvU1FEK013alQ3d1RQV2FhMjdtdkFPbm1UUTgycFZn?=
 =?utf-8?B?cVNyeVN1eHlaeTFydlVSSk9UcjdEODBIV1hCYXp2cDQ0L3hsazdmdmVXYWZ1?=
 =?utf-8?B?T0IxRGM2SmNSYU9tYWZrTFhjNzZReStHdVFqVm5pak9Xdml2Ui9VeXUrU1BV?=
 =?utf-8?B?c1hmZklrZjdWUVdqZUJieEFXdGMveWt3emgxaG1ZVXE1NTY1SGl6S1pnaEgr?=
 =?utf-8?B?Z0NRZ1NHYXNvbkZ2WVpmbll6N0tjZUtPZnlEK2JCMmJRZlNQc2dvUGk1OXFM?=
 =?utf-8?B?NXhjYWZGN0xXUnZzbWFDOHBkczNucmowVURram80OFA2bHNkUWs1dnVrYVpY?=
 =?utf-8?B?OTFIU3YwS1ZwWHFPQlhRa3ljcFJhUHpUZFNoWFhmWk85L1EvTE5XbmZteWMr?=
 =?utf-8?B?bnlmY3VnNEdaeWZxMC9NaEJydSsyZ1VST1p5dE80ZGZvc2lFZXNocGs3V1pJ?=
 =?utf-8?B?cnpBTDl5YU5hQ2tTZW41U3NybmFMd0xCV2NtczBmOU9TSDhjWmlIb3ZCbEJw?=
 =?utf-8?B?UG10dEwxeDhkUFgrNmlwc2Q1MEdFcEhlQTNlaGErYjdPeGJPS0FvcmJtUGcv?=
 =?utf-8?B?cHlwT3lPZ0lKU3hMNzl5Y01iTU1EQm9Mc1Frb0tDS3JhSDNiNTlKbVNGUmI0?=
 =?utf-8?B?RDIzMksvc0lUMXFyTWJxdmoraTVOU3Z0Rk9yZmVtR05HckZ0SWVFYVI0MlMy?=
 =?utf-8?B?L3hwMlMxQXluZXR3OTQ3OTVvM0Y3eFlybWR2R0ZVM3FRNVVvRHRDZVI5QWJJ?=
 =?utf-8?B?RHZqWjB5ZGw5US9tbm5zK2tjV040WFVlT2FnTWdBWEFtb3F2aHpyWHlPc1VZ?=
 =?utf-8?B?TEdYY2dnMUx4d3BZbEYrOFR1WXAzVmRJeklsYnozRmIrZ052Z2FDOThKSVdp?=
 =?utf-8?B?SEJieHZBM2NScjVubHpnRkRUdytRRGxORW1YRVRLaGFnY1BiUHZkUmhUY2xn?=
 =?utf-8?B?L1JxOS90aUFGcjd6Wk1QQ3pCcHRvb3l3QXJrS1ZTWEgxS1lJbmJkeFFFYmlZ?=
 =?utf-8?B?S1cwWFhzNm1wTWlNR1Zrc0RFekRHSmZpaGw5RTVnSHlLSnl5c1dJZGlZd0dV?=
 =?utf-8?B?YytKWThhMWRRaWptQk5OQ09tWEJ2WkZod2psb2syVGN1TEpOaTlwcldGOHhz?=
 =?utf-8?B?VjlIM0pqdEhHUUlvNzB1OEQyVDFQdmNFS0NZOWNTNFNRdFowaVdBK1J5RGNx?=
 =?utf-8?B?WTVTdkhtaGhMek9venluZUhBTjYxd2dKUW5kSXNCMEpnaEtMZlhTRDRmZ0Jy?=
 =?utf-8?B?VUNOZGNZTllSdGhZU2ZTelZXNmZyK3psQ1BhS29uazAwWUhIRUM2NXlIMmVL?=
 =?utf-8?B?U2pRWkE4SE81cGFHVWRuYTd2MExTUE00bXVwTUx6dm1yMjFIUStIYVE0NkZh?=
 =?utf-8?B?MjIrSW5ieHMyU3lSdEh2eWxHaFVXSVlYWGJTMHNLNStzQ0J6MDhuMDc2MVkx?=
 =?utf-8?B?ZHAwSmVYS1I5M2ZNbUhQVDVzK25YTFVmY28rVnRvVVh3OVNKNklEeTBaMEFa?=
 =?utf-8?B?emdEcXBuLzhoRjFVSXk0RVd5V0lwMkFvbUNMS2VHNlZxNHBVMTBOVmREank3?=
 =?utf-8?B?c2ExNUNqaEZmdlRLa0lWV1JKQ1FtLyszN0JZM2Y2WHhoRXhoKzVzc0VUVkZL?=
 =?utf-8?B?Y09QY3dDTlRucllUTTJlVHZrczBoRkJkN0Y2NGJOdGNnUzZsVzl0UHdXNVBV?=
 =?utf-8?B?SlhTdmltdGF5OEhOZis4b21JTHEwbExKY3hlanZVSmJLTDF4a1VJMmc3NklX?=
 =?utf-8?B?T0lyaVJ4TWxZczFRMFZtYThKQm9YeFZwektVSVpZSmJteGFxNTNiaDJ5THdh?=
 =?utf-8?B?NVc0bmRyQklRb2hTTjBHRGpZaHlqS0VLYjVrUGFjb3Rab054L3A4RTk1N0Zr?=
 =?utf-8?B?bG04TGIwVThqMWNxcWJ4SGJnQWlldDNUUEM2K3llZ05UdGh1UmJHRDl0N2l4?=
 =?utf-8?B?SW5PaVZYdVJZd2p4dWgySVo0ckVuY3BUSzZSTDRtK0JoZ2JTVlZwRGlIK1RI?=
 =?utf-8?B?bjhDZGoyUE8xVkdoQ2g1bng5M1NQa3VINUdsMGh1ZzhFa3JlOUJ4UitZU29D?=
 =?utf-8?Q?6rgyh2AfBixu0CovoA9ZXVedA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3995C671BF96A841B1439F034CA2B23B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4dc0347-a899-4ea0-ef5f-08db30999fa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 21:07:36.9465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: usK+fzMkJwGYIRLFu/yVO3A2hSxyMzwQPzxfrpVg1sLrBI3WnEVzNvK2+La5BiDKfLdHMSCQfuEaq74z4GE1Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8198
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8yOS8yMyAwNjoyNCwgVG9tIFJpeCB3cm90ZToNCj4gY2xhbmcgd2l0aCBXPTEgcmVwb3J0
cw0KPiBkcml2ZXJzL3RhcmdldC90YXJnZXRfY29yZV9zcGMuYzoyMjk6NjogZXJyb3I6IHZhcmlh
YmxlDQo+ICAgICdwcm9kX2xlbicgc2V0IGJ1dCBub3QgdXNlZCBbLVdlcnJvciwtV3VudXNlZC1i
dXQtc2V0LXZhcmlhYmxlXQ0KPiAgICAgICAgICB1MzIgcHJvZF9sZW47DQo+ICAgICAgICAgICAg
ICBeDQo+IFRoaXMgdmFyaWFibGUgaXMgbm90IHVzZWQgc28gcmVtb3ZlIGl0Lg0KPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBUb20gUml4IDx0cml4QHJlZGhhdC5jb20+DQo+IC0tLQ0KPg0KDQoNCkxvb2tz
IGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29t
Pg0KDQotY2sNCg0KDQo=
