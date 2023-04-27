Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCEB6F0EC6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 01:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344316AbjD0XMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 19:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344037AbjD0XMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 19:12:16 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251F81FD2;
        Thu, 27 Apr 2023 16:12:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7WawvQke5jq6xv47X+0V1X+I84ZDvuoLuDmGuWltfagNU2b0nqhUOiHl1jFrcA/DTzJHfku/Et26rR+ilaoQ1800Ubg5dGf6CW7D5ss+9RnbTk6/QdLjhWn8NelWTNVenM4DwivtfydYjIKdu0FquvDlAKkVUoodsCGvchAUycwA8RoiXteXMVJkgGBqyvPKRCFYyWGPogZt11O6l138f3L9poWJobej4IljVQQtU+dvzFY3NNEuou2rrSjwygvWrKtPixRPjTXDCl0rTki4Za93QyJTdpaie39T7o2f3z35E40yo3t12OvMXPwQlA0Ktdg4qxNguKCbXhvbkWkIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMBy2UJHVsjKpnbogjT9iEaO9QTR+Xe/HEumQJU2FoM=;
 b=OUHYtKxtSDurGbIpwGEzn4axK6fAUz1svrFHPawSbwyclVaEncrYn8OFgc8bnFheDvZhYWBLyE1dhx7FlNac9FV7n7yuo5HIfFnA8kyGji4ez6WZC+FlSx1ELTlM9fw7EVf3T8GobNHWNPCcDbmkyVtzpGXe4WT8rcsbNgDKsS2vJbPcFav6aNXWfIeVNMEl/Tg64Hbd3xxdOBe1y33Pp4rg2bu96HtRWQEqR3UelDTnrnXyK1zCW3bzfNmMhYd03Tyg5cC5paI/zIibP2nic+5+vzQTCWmUJQj3lE/F62MNtsy6OCq5nW5uUAuyOOjnSvZjAS9U3Sm4I0yGU3nkaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMBy2UJHVsjKpnbogjT9iEaO9QTR+Xe/HEumQJU2FoM=;
 b=a1He6MNRw3rPsnSDNJgUbLNnMXXLIQc39NG+gwxtKmfA/uYnbtFSiv9TcoMBq/sODoKZ/QNIEZOsbKypPvrHxQnMN9mf7sq38wmTclH89LvASAoZ5z5iy7Ou01PvKPpYaxF8OHviU2SePE3LlWkm5+qk+hMgDkoDvkSVxxPGDkZH3AYWMhlVhmcN5U7Ocr88fqx3pCy175nfI82Fb6FAqYkjj1w0uEKY9Xno/wbSj01FgnO9yscOOmWHmPjW9GiK3LxHVmg6Khxq+75omZM7e89j/UZzzAG8KjjI5Tklr5P5LVsG7E+1pAntdBe8uov1cU8ZHNx11y3YmCHEhecrmA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB6206.namprd12.prod.outlook.com (2603:10b6:8:a7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.22; Thu, 27 Apr 2023 23:12:13 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%6]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 23:12:13 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH] nvmet: Reorder fields in 'struct nvmet_ns'
Thread-Topic: [PATCH] nvmet: Reorder fields in 'struct nvmet_ns'
Thread-Index: AQHZeUEoV9vRcEcRDUeYawN1RnJsFq8/yOIA
Date:   Thu, 27 Apr 2023 23:12:13 +0000
Message-ID: <67a9e53e-4ac9-7ba8-9713-96c1dfe1e341@nvidia.com>
References: <aea924d31f2bd2f740b1ccc6f462905bd6cab763.1682624855.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <aea924d31f2bd2f740b1ccc6f462905bd6cab763.1682624855.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB6206:EE_
x-ms-office365-filtering-correlation-id: 4b1ac1ab-4bbe-44c9-067b-08db4774d5bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ww8hxLvzZEI7NK2O4K8Qy/ATaOgxyJ+vqwo34CCAUGdHgTR94PmeI8PGabzyxjF1+qBWHcId/jVQ0w4cZwKYzrnt/cO3zJxEJCM1AbQYJRfelYa4048Z9LtiDXUGUyTR2RLgTaoJfmzuiVmcOcCwc4CBuTyaQf2maZuduZ0E39u1HmrzGFS+aUHUARM9Fg28SCI6Yb7isdmC6E+nb1DZLQac7ArnTAKAICmT8nJAE+Uy9+idtoZpoNkrzfiFo9Sk11WJgfzsbVJP4dISYr47OxBWrpDWmAQz17YmvAo8p6ilEPcA06tf6ChaGS5zc63YJkxIMaY3Wg33HjI4NWnw7hISWWBE8GhrXtkrlL/uzMCMo8GQo3Ijga1IerpEo0PMvoVjHPm4o7lP/gfUV1bzPOde4gib9HInl+cAjHDbZogCkLzN0/OZVE4900WmrUa6yLs0+vGy6Ac9TbS3jYXAX7ZYTTR6UqoaUplIPITrZzfO9AQO1G6N5I9y81qrbm7xTWxMr9rWwQD7ygQkLM4xNCybXPoSDNHG6Qlatzn36Q5rxsY+FpVzgpWijVTfD4/3TBC/gHGrc5yCQDvq6by/ds2OGK4RKw4/n7fHvAD8GPHHgE6DW/BEpZMAwMVSY9xi97DAOUM1aI1m9RfJnbJoe369KoDNYYil2IMC0hyUaxc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199021)(38100700002)(316002)(478600001)(41300700001)(122000001)(2906002)(31696002)(4744005)(38070700005)(54906003)(8676002)(71200400001)(6486002)(86362001)(66446008)(64756008)(66476007)(83380400001)(66556008)(8936002)(91956017)(66946007)(76116006)(5660300002)(4326008)(6916009)(31686004)(2616005)(6512007)(6506007)(36756003)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHZ4NGR6aUloRVM1S2J0a2xScEJFUmZwbE5xcGhrVmdKS3V3ejE5OTd5V1lK?=
 =?utf-8?B?Y1BDRVQyOVRCenZLMEt2MHZvM3FNQldHKy9DMWg2SlZ0d3VoNlhUNzA1T1lw?=
 =?utf-8?B?MjFhQ05LVWFIOHNFb0YyN3pVckxtZnMvQWJ5bGNhWWczbnI2K1dnSndjVUg3?=
 =?utf-8?B?ZGZyK3NqMG52MjZuUDdBUENMeGV5elpVOFFlNW1mNWExMTVmeW5sUnBtelJn?=
 =?utf-8?B?d2wvL3RLN09iMm8xUFBGMjJPZkJsZ0FRYkVpdVN2L0FMeUptc3dzdTU4SERF?=
 =?utf-8?B?VXA0TXJPaXNZQmlBaHdtbHBZT1VqK1hjb25IS1phY21pRmgxVWhjbGhuc2Za?=
 =?utf-8?B?UlJtMGpWeWtIa1ZGYXlkUkpzdlVtd2JOV29XWitIVS9EQnBydzdzelV4bGdx?=
 =?utf-8?B?RTdWUTVPV25iWGFlV0lzL2hXNzU3TWtxcExia2JQVjFtcEY1SnVBUHFNcW9X?=
 =?utf-8?B?SkFTN2p4RVoxQjFTOXE3Rk9CYk5HZi8zamtJbWJsNHczdVRkM2pDcG9BemZm?=
 =?utf-8?B?WFhYeHFnTE1hczgwb0FMYURjMXRUdmVmcnNvZk9FR2hhdVhFZ1FWdWdBNkcw?=
 =?utf-8?B?dkhJa0FldHJ6amQzNU45bzNMQjBRaXI2cjJIZ2l0K3JqRlMrMjlqeFhjQVpS?=
 =?utf-8?B?UG9lUkNRY0w4SjNvU0Z2ZWw0WjdycHJMTk4rcEZoNnczR2hVWkt2WWxlY0RK?=
 =?utf-8?B?VmVURi9EdnZwYUFwUVJCODVKOVJGd3VjZ0VJWm9UR3hkR0lMRHJpVXlYcGhF?=
 =?utf-8?B?QnpvZXlXUEltYzFEa0ZXRE8rM2lYMEdwNWpJejJyRkZlTHg5STI2dEVuZDI4?=
 =?utf-8?B?K1FYUHVKSDJ2WTRuY2xVRVhYOFFQaHpRNVhuR1VuVi9SK3czb1Y0QkJjb3V0?=
 =?utf-8?B?c2FVWmZibThSdmMyekJHejJQTXFOamRCQkVnaWxCSEJuVk5jWDFMZVQ4VUpF?=
 =?utf-8?B?QTBhZWp0NGY1K2ovRytyeHhuL1dwWXUydG4vQlN2eUlzVUhDUlQyWUlNcEZx?=
 =?utf-8?B?MEI2NGhIOFdyS0JEU2pPVVljYi96VE9JZFZVWmY4cjc2MGVnY3g4VkVoRThu?=
 =?utf-8?B?WlcvZTNaUFZCQmk0c2NHZTh4b0I0dXVtcUd1V01uZkJzWnF0QjZEcVBCbTRK?=
 =?utf-8?B?MmtOajBGblM0aG9mNnFaOEw5cUg2Z1ZjWHkxWFFBbnFxVkdNVWVLaC9NL2pn?=
 =?utf-8?B?a1B5M1d1bGVPSDU1WjlrWGRGZmhkdmsxZUl6VnZlTzNpcDYzSGszL0NHRzFu?=
 =?utf-8?B?ekp5cXloRUhBUG9PWVZKMUQvaHgrLzBXSlBGbkZFaEtpWWhTSVdmZDdJTys0?=
 =?utf-8?B?d2svZFZQM1I2S3lZZ0UxT0hOWVhIVkVMYlRrM0lxSU1wRS9PUlRoaUhhRUVB?=
 =?utf-8?B?SFlXWjFUV3QzdjdEeTFTdG1TUFMzRjg3eGVvV1RmdHgvaXlkeGdVWjk0a0k2?=
 =?utf-8?B?WmtsYUNwS21EVU1qSzA0YUFXeC80RTNpYUoydGF3aitFYXR0eG5Gc0JOakYx?=
 =?utf-8?B?eW1LUmRNSHJINjlPNVRGNlhmbGhDWWY2dURDRGh6czB1UGF6RHVRelVZY3lF?=
 =?utf-8?B?T2IzNjlGVDRDcHQyeXJDeDFWWEVIdzZmcEtPQk15OWFUNlJLUTR6MkNvN3Bt?=
 =?utf-8?B?blJJdzRwT3ZjMkFISkJzOU5Sa1NsTmRQZ0FtUklWQnhiT3paYUhrTVpDNWx1?=
 =?utf-8?B?OHlOWGhRa2tXRG5qNk1XbmRyT3o2ZXdVUXp5UG14ckkwbVNuNmEvSU1VMnRh?=
 =?utf-8?B?ZUJ4VXNkdWZPUGcwemlKUFBJWWl4TklRNzBnb2kySUVRTnFhQmN0SWk5V2N1?=
 =?utf-8?B?cGpLbnZMZ0t0TmVnRXJLR0MralJSeG13bTZQWDlPa05BUzRFQVJpY1l3VUda?=
 =?utf-8?B?MmE3YXZVUGZFdkIwRDJUWGdoMStpVnBSazRwRHo4eHBSOHQwYmZvZlo1cldG?=
 =?utf-8?B?UENxRkR4cFZzNm5hSHoxWXphazRPaElvMXByWmp3VEtqejFzazh5WXk4dXUr?=
 =?utf-8?B?Z0JiRFhvb2hwSTMwWXpTTUZmaENHN3dLZGcwYnFmdGdyakMwTWU1czM2Slhq?=
 =?utf-8?B?QmxIaFNtanVzb0pyTW1CMW9UaENkNnFXTnpJdG5TL1BHSDRoTEFlKzNIZEd5?=
 =?utf-8?B?VnlsVjkvOU5DbnJpUzFiQ3dWcjJ3YURuMGxoVThHc2JDbm0vN1BtMFZ2Nita?=
 =?utf-8?Q?uxK9CESA7Zmz2ZDZGpweOqxPHJjXR+2D+yZ2fAxkdPTX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E5A59E442238E4391E6BBA5EF54DB4C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1ac1ab-4bbe-44c9-067b-08db4774d5bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 23:12:13.0242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XZmNtRT7Nksd2Qv49tVi5dTe4QdeE/KjQ6AfA4brBTiM8rbVTxDzuZieR3lV7N/Hm1Ri/sXoHzznUDmZi8I/9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6206
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

KCtLZWl0aCwgZm9yIGhvc3Qgc2lkZSkNCj4gLS0tDQo+IE1vcmUgYWdncmVzc2l2ZSBncm91cGlu
ZyBjb3VsZCBiZSBkb25lIHRvIGJlIG1vcmUgZnV0dXJlIHByb29mLCBidXQgdGhlDQo+IHdheSB0
aGUgc3RydWN0IG52bWV0X25zIGlzIHdyaXR0ZW4gc3VnZ2VzdCB0aGF0IHNvbWUgZmllbGRzIHNo
b3VsZCBiZQ0KPiBrZXB0IHRvZ2V0aGVyLiBTbyBrZWVwIGdyb3VwaW5nIGFzLWlzLg0KPg0KPg0K
DQp5b3UgY2FuIHNlbmQgUkZDIGFuZCBJJ2xsIGJlIGhhcHB5IHRvIHRha2UgYSBsb29rIGlmIGl0
J3MgZ29pbmcNCmhhdmUgYW55IGJlbmVmaXQsIGl0IHdpbGwgdGFrZSBzb21lIHRpbWUgdGhvdWdo
Li4NCg0KZm9yIGhvc3Qgc2lkZSA6LQ0KDQp3aGlsZSB5b3UgYXJlIGF0IGl0LCBpdCBtaWdodCBi
ZSB1c2VmdWwgdG8gdGFrZSBhIGxvb2sgYXQgdGhlIHN0cnVjdHVyZXMNCnRoYXQgYXJlIGFjY2Vz
c2VkIGluIHRoZSBmYXN0IHBhdGggb24gdGhlIGhvc3Qgc2lkZSA/DQoNCnVubGVzcyB0aGVyZSBp
cyBzb21lIHJlYXNvbiBmb3Igbm90IGRvaW5nIHRoYXQgLi4uDQoNCi1jaw0KDQoNCg==
