Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D73E6F548B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjECJWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjECJWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:22:11 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6A91BFA;
        Wed,  3 May 2023 02:22:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDtpW9FZbsZjxz6UULgCKeUliH3F/eD/dsI04gXZ6KUhdzuxCbWkLkQ/rIAZyWvZ2Oe+LEMh71mUwDuTA55pSvJlAKXEXdV+wgXsM5kMf8EUifi2ocI9x19ZdSnEjGVSN/66GWtx7eqJRQs2UeLieo5fp9LReB/Bf1ScIWgxGrk36QnDYwU6enMtHjnijSjlsTgB8k2dwCdgvPTxlDhn3hSLgFzcytkRfD+fAJzN+PV/tWrDPuV6hglW2aaqTIyHmglBVVFwmZbBIUkyNZGXnDcGdszQ35ofO26empN3orfA57hW03bnR+x5C/1zmz0ZmRwgADDo8mgAxXNxlw1BnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STGV8bq37CAP/futfhkg9f2LXWfrcdzmDi5OZ+toEUY=;
 b=ay1HhPHxUEabJrKwlGWcg1G5btIIjpP3o67GtEIsJWotJzEYLV+oQn41un3sq2nlpqP88r074S1ATU0LUglBwF9ePcmfjCXjbe2OSQb9liRc9ngeUX2wnZbkCOZa8iZsv4U+XQy11g9cq4ISU0NEN2XPlLaYNWzXj/+8PFaHIkogMtMvaJ8KcVJSUwAZlBVZ+Xq4oJxHghad3GzTjwJ+h+O1rsHUVEHWPtpwk1cgwL5KL262DzZyp37CoRn8ozQLky17M/I2BW71N6VOfVU6BsyEBx/xF+CvAmcNg/kzjMndYeLdESJdoSsSQpL8/HBBwH1zujBvLYkqovlyeGSTWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STGV8bq37CAP/futfhkg9f2LXWfrcdzmDi5OZ+toEUY=;
 b=GPscml+UXghnw9olVpdDHHJ4/oJDGtCZh/ss2lUtMIqF7bY3f6aX9c20MYyyMfCS0CraNfMjHMI3x3Jo+Wpm9zL3NVTj3JE+bFR2c3SuRn0TqhJiwWrE06QwsWRfN8psFXVx3Z/sOKltpTepRbYPLWT5W7s/rUNg7UUULZF+6frvePpYSdXwrt4q47DjjU3nPvGlLtz8TLr0B3HOkdr4Gv9XwBFoX3ckQHAbqq0vOACUm2rct1b1uLNGG2m4OsJotBPntB3ArUq/VohQcsf/Vz1R9GxpbalBTEdxsDbiEkQK3p4zj6K/+DxNLd+jrgFcr0VbZoBzUTNL3oxdQSNG3Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH0PR12MB5217.namprd12.prod.outlook.com (2603:10b6:610:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 09:22:07 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%6]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 09:22:07 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 01/12] nvme/rc: Auto convert test device size
 info
Thread-Topic: [PATCH blktests v3 01/12] nvme/rc: Auto convert test device size
 info
Thread-Index: AQHZfZW2AEir/sK1dUu7E7UVUst7pa9IRkqA
Date:   Wed, 3 May 2023 09:22:07 +0000
Message-ID: <c7532fd7-f9da-b8b3-a7d1-b72c18d8df11@nvidia.com>
References: <20230503080258.14525-1-dwagner@suse.de>
 <20230503080258.14525-2-dwagner@suse.de>
In-Reply-To: <20230503080258.14525-2-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH0PR12MB5217:EE_
x-ms-office365-filtering-correlation-id: 3cd3c08e-09a1-46fb-70ea-08db4bb7ddb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RzqFcRGXT8G5j3J5OupZ+j+F8tG8cQjv9jTYB9J/yAfytMRsv5fPD0Ll4clY3wW8xgl3g/UyH7F/E/H8B1o20tpl6UkN9a7NRhB/JduM5dyCXer/R0yI/9D1amHBpp6d3tG+Wj6+FG8C6kVjqEjiM5cLfTbdrs8AzJvlZEOXhPwPqiJPkOqk5HH75uvsWGRaiqyir+9j/5YrmbXMPuNUQQ3xQaWdW2DsUU7gHTSe+IyihVFamnijXM3Qlds5b367SV3pcz6mt2av3eQvbRPKmfj0sIf0Eis06CKZEroKSw8TUHWQ4Yv0iVSrdwYpl6yB1LrMaYh+Qat9xZz6sZXoYFI6gLK3JGv0EaKu4V3zz0GhZrpgcCiH0WOnTvpC+rBDoYYUKeZN58iyFlgOjz+y0tYS7kRSjFE2IrAnQbfVJ229xzcwKHcY1snuCHxw1IdX/Sh9YBo0N5SkAHqnKDUQafMrk9B+5cq7gEiTKi+SH/AeNvZinBhD2MQS20VpUjCnUBPsDQqJFHd5Ipv7y6uXc0b50P8v5e1MUdVjhGOJ9Red9nYcYMHu3hZ1WTpLMAGRbLT0d+1h/vvyNTjXrEEZzdZdLVwA/R5NE0E6Y/mEhIXP4kQxdZmYC93LXGcZY/xe5/KgTDZEriacOFI6k4zyOiaNSlaxu1hTcIgQHlB3ley4DudeBz3f2BIM4zYeEcOf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199021)(31686004)(6486002)(76116006)(66556008)(66476007)(66446008)(64756008)(4326008)(66946007)(71200400001)(478600001)(91956017)(316002)(54906003)(110136005)(31696002)(36756003)(86362001)(53546011)(6506007)(6512007)(8676002)(8936002)(5660300002)(4744005)(2906002)(41300700001)(38100700002)(38070700005)(186003)(122000001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmxPbnJsZnIwditqdU4xRjdkOFVXU1luLytFMS91ckwzaDBtbVhlVDR1ZldD?=
 =?utf-8?B?K1luOEpiL1c4QzJvcGxpVzFHalBMSk5RQTlDclN0Sms4c1hOeGdBZU16QXN3?=
 =?utf-8?B?QU96UXdVdVJ6dkE2cEpYZ1VBWjlhTWdCNnFSd3k4MHhmUEwvUGY0SHlZa3Mz?=
 =?utf-8?B?bHZ0N3UyRFE2WE5mL2tza1pUMFljNEZ2VjkzekhjSFFjeGoySmhHZUc0N1dN?=
 =?utf-8?B?dnU4ODFaVlB5RWdDSzc1SG1XK29VMENaQllkLzBjMWxEU3RqRWtNaHh5WDdU?=
 =?utf-8?B?T2c1cGFEMUp2QjNUT3M1dFNwSVR4RTExVUJkaWxDa1d0elBwZU9rTFZpMk5k?=
 =?utf-8?B?N0xBVG9hM0JqMlRSa0lvQjVzTllFNE1CVVU3MkhaRDhtaWZreG5LR1prYjRW?=
 =?utf-8?B?ZU9WdnpIdm9FcUVQZDVBcDBXVlRHZkcwNngxQ1hyUlVvWndCZHRaRXlrUHpX?=
 =?utf-8?B?L2lSWmcrU1dkNkcvS1h6ZmR2NGIybWJZZUpUY0lvTHdzR0drRlVoNDFNTkVQ?=
 =?utf-8?B?MDk1UnRaSGFqSGhFQTJBOXF4UHBEWFo3QUY4eUh0cmRFdmY1Ni83cC8vWVNJ?=
 =?utf-8?B?RkpzYkN1VHlLSFhiemFvZk1lR25DT3ppOEpTR0tQQ3Y3RnlnQTI5cVZ3RHhq?=
 =?utf-8?B?VzlWQ1VsRm90bE9oTU5EWnYwOERYc1RVdFYzcUUzU2hWanoxam5HYWp0YlBT?=
 =?utf-8?B?dThZeFpZU2d6Sy83UlR4S1dJMmcyQ25TSEIyWGpPMVZadm1OWG85TEZ4QVFT?=
 =?utf-8?B?b29vTWJXeVA5MFBVd0tqL2NhbnJqbVAvRElrN09wNW5maGxHaTczalhzS1ND?=
 =?utf-8?B?NU5xcXA3TW5FY0FENjhQdFUxaU5rcmIxVktxMytMR1Y4bG1DbEdGa2Y4Vitm?=
 =?utf-8?B?L2RnTTIyZ3ZFUS82ekc1VGZoN3RHZWFGUlAraGRFaFJoclRSaUlRWVZWVkRx?=
 =?utf-8?B?TmZqMS9DNDRPZjE2OFJ0Ujk1TG93V0FsL0ZhMi9TbFBXbDU3cWowSCtFRWZq?=
 =?utf-8?B?aTFCQlZoVk9DYU5XWUVmd3JjVEJGRTV2U1JzUHFyZnowdEszYTN3N21qTnBq?=
 =?utf-8?B?bGZhWCtnN3FpSmFxMndBQk1VUGhVWTF5QkpQVXl5clVuTkY3S1pubDV5Q0lp?=
 =?utf-8?B?WWVta3hVV0N0WHpTcGEwK3RQdlVhelFGK3dwUS96VGROQkR4cEZZZ1VqN3ph?=
 =?utf-8?B?Y1FrUW95d1hCM3IzNC9OQnFIWlhkMVpRMkd4SG1ZRDNqRC9nQTY0anFyM3Zy?=
 =?utf-8?B?MEphOVUySkxQL051NzU4MENpN3htMWFxamJzam9jcUpzRFFlSlNDaEJJM1Bs?=
 =?utf-8?B?S1NVU2JXKzVvMXB6azN1MEVQZy80UzU1MTExYmhTQ2NhVnRWUGhRT2s1cHQz?=
 =?utf-8?B?NENXRUhVekUyY0l6MEw3eE0xRUNTUkh4LzVBQUFqa0ZtMnBYVzF1Vm93N1l5?=
 =?utf-8?B?NnFKblBhRFB6Tis1bmJaaVQxWktxNHoyYmpFWlBETjN4K2tjc0hGUXloUjF2?=
 =?utf-8?B?SW02NVN0ZW1FVTI0QjFIMmVjc0xvam83blJld00vMFBzOG5MVHZhZ0RNdWJs?=
 =?utf-8?B?dmlUU0VzdjQwbTQzMUFKY2w4S2p2cGFQV1N5SDBPUTB4c0xyditjeXpubW1W?=
 =?utf-8?B?N2VrZ04wZXdVYW10U0w1S0ZDNUV0Y3RzZXNqT2c5bXJlRytXOHIrNXgwY0pJ?=
 =?utf-8?B?K2NqVEFtTlNobUpGRlVWTTRaeUgrMHVKb3hPYkRHUHFaMTgycGVZN1Y5RG9S?=
 =?utf-8?B?Nkx3Rjhaei91RXJNVzYxM2paMit0TG1uL045N0R5SXlnQkU5QWVQU2pQdm0v?=
 =?utf-8?B?clRNTlYzSitNVytGTUlyc21FaHkwdnIyRlFGai9OL3dNTENOZHZxYVhWdFlM?=
 =?utf-8?B?bEpBWnNMREhPc203ZjMwb0wwZGtLdjVEbWhzcjJ1aXZia3JSdzl6NEZYamRP?=
 =?utf-8?B?MGpQN1g5WmJwanJWT0cyZERFL1U0Um4zeDhPd1FaSEh4U3RzMUFzRWU3ZTRD?=
 =?utf-8?B?Q0orRkY4WU0wZFprc1RsUlFXNUQ5TElEWGhXRG9JaEs5eU56OEFZODVLWWJw?=
 =?utf-8?B?Z3k1eUxhZHlXNjl3MlBmNTZTQzBZaS8zRmlnTVREc3gvam5vYXQ4d3gyR3Uw?=
 =?utf-8?B?a2RaeWw5NWlqaVBpREptVVJqbW9yak9zWmJDRWRhUkErK2dFNlRUYmVPRVBK?=
 =?utf-8?Q?z0XEtgJLaZxAxjfo8zG++meFFQ82icFtq35e35N1XsqV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <288F172E56EED545B6112D9282C862B8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd3c08e-09a1-46fb-70ea-08db4bb7ddb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 09:22:07.3238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A4fYnYRkfONQ9hlsXbgvGe8tivNisygkQd/cWPzjuRIRoU/HNgQ469p9p8hOBkkAUUVYiVUTNFA1lgo3ZXFmAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5217
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

T24gNS8zLzIzIDAxOjAyLCBEYW5pZWwgV2FnbmVyIHdyb3RlOg0KPiBJbnRyb2R1Y2UgYSBjb252
ZXJ0X3RvX21iKCkgaGVscGVyIHdoaWNoIGNvbnZlcnRzIHRoZSBzaXplIGFyZ3VtZW50DQo+IHRv
IE1CeXRlcyBhbmQgdXNlIGluIHRlc3QgZGV2aWNlIHJlcXVpcmUgZnVuY3Rpb24uIFRoaXMgbWFr
ZXMgaXQNCj4gcG9zc2libGUgdG8gdXNlIHVzZXIgaW5wdXQgc3RyaW5ncyBpbiBmdXR1cmUuDQo+
DQo+IFJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4NCj4gU2lnbmVk
LW9mZi1ieTogRGFuaWVsIFdhZ25lciA8ZHdhZ25lckBzdXNlLmRlPg0KPiAtLS0NCj4NCg0KTXVj
aCBuZWVkZWQgbWIgaGVscGVyLCBsb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlh
IEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
