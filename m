Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38152736138
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 03:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjFTBlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 21:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFTBlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 21:41:53 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88889119
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 18:41:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLcy58XolNATkVgaoKxi55ewmoCFBrXj31fgpTRa0uyq0zk1evQ3dtstZbDayLtczxvmnbDuwuj1ukFP6ztDJHabIKRJS+hH+SwbKchffI9cHNJba2Td0GtBbfWQvj67MzIdBMmsWzONFOJjN1o+9+XGEOYRBX4fi3/jBd0zdSBkqBnjsrolIT98g6ncBsb7V5/EaaDK/5FAw+NcXwNM2yTcYDW3nglai3KXJHshU0S7O1rQtcHSXb9le0/wXJn463gkFkw72vinsoy/0vfMva3xYfEZOdLf1ED3lG9TSQkBwi0zanPrb1hPop79VhQ4I1aR6vJ6EePDF4hUyJ34kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjSmoklfqOF7WqyvGhUGFXsho+hUiRYqBUZnklg0E6U=;
 b=crAJDNv+BXbeOU5TbA+GuUu1YzmXg7QoCgPz6e+q/ZeLX4OSBeHZPtPSmhhcB7TK4bgmmg7mZX7gEFO2fyFuYfMzqqJ6lIh0n5qhFDgrBkntr02uaVfqk3jDSmCqAdXkanr/m15L4UpM5cRCaHnV36QCvpbsyYMQHUm6qkjdJYGXTdlS0SFKovlboL4cGjJ/8ZnnzgqE2jj5iiJhyyI059q/2OmGXb2dn6mQyM8L2DHmvLkYJWSySjh8FdCgZwKJGxRDSetTRy8ysoz+E2vlIU6bRhADNDdazV285xXB0oj/MPJvmMkkIb+/OE/JzzK8vNdXNcgSX49KcNGtLl2eKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjSmoklfqOF7WqyvGhUGFXsho+hUiRYqBUZnklg0E6U=;
 b=mtpzUlrhUVj/DUC2x2LFpxqZwEokSqO5zugmWDJJ7b4QV105DXaYc0bLAk/1EwyYgyV6ZYmkBE1FolaKnPNDqP2UGyYOigLbdYgqMB+hs/SaXOAs8haGDDspHvD4INqWH1H5rRq2A8GfHqGyiYxuiAXjqv86XTZYo3bqiEpOnoebk+G2MMzJFC1BaN1Q+IFv7GVqlyWvSjIuTPGaX1VqV+BV36B9bj4zd/858EDHfOkw1rpYkmWHiv8i26FDhDqXYGKHxC4/1grCDP7Rmw7mar2aho3iQKAdBphvKgFfYu6f/2U8fLsyxn0KUEQv2OwHcs6LYC4UenDTSPdo8OhowA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA1PR12MB6602.namprd12.prod.outlook.com (2603:10b6:208:3a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Tue, 20 Jun
 2023 01:41:49 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 01:41:49 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Breno Leitao <leitao@debian.org>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     "leit@fb.com" <leit@fb.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nvme: Print capabilities changes just once
Thread-Topic: [PATCH v2] nvme: Print capabilities changes just once
Thread-Index: AQHZn268WqR8UAYd7ky35PfJONdMiK+S8eSA
Date:   Tue, 20 Jun 2023 01:41:49 +0000
Message-ID: <f1a64a98-43d6-0665-cb01-143b9d51adb6@nvidia.com>
References: <20230615094903.1341683-1-leitao@debian.org>
In-Reply-To: <20230615094903.1341683-1-leitao@debian.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA1PR12MB6602:EE_
x-ms-office365-filtering-correlation-id: f757aad3-d051-4789-c090-08db712f83c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 47xN+uSa3XDc4czBr0gpDJlq5WwK0uokmcu7uuJY/OHbP05JIjFhD8QEBvunOIW7x8sJme0fIWLpZVpvERKsQG3Rzqd6VFcrKiAPgzdbIy2bKQDb5vmNxcc2OFHNjLXQ4yUyTahjwm+AlsZsNe2S85aq71JrOa5qEEyy11rFMQ4RAwfN7v3qIC9lCrcJCGXhhsOwsBFPu9iTg8Eako0mIvQz/nFpjafNI4MFWbDc4GEGuk0tgxacdYPhmqwhl4bbJ0zoslsAaBRQC4ehBs+PaCL8//H0oee8eyarDbavwDibPHDZSeDy9xZdWQ9n5KAknOef2NXZRqotI7Q9c45gMfCsJT3eSd3dc5kakD0ZuSci+OrTXctUUqQ7YozeafBwS1jVjxI7GyUJfa6Cae2w9NNDPD/cpKflLmQwgaThEcMYlPTc2mMhUd7RtbYWtwTmXG+GOkwwcISxQl799gcHg2ZVcV7TRnJkTlKdCGv93AdWnJrItuzJPUHO/fsdWiGvz3TRXBY4Sg3/AQ/RcEyg+vMcsUqOTLxsWrDl4YK5DwzWvNX/qcsIczeNk6mowJzK7gH5Y2d12gGOjuagMF8NuhACLWIdAwDlzeB+5L6W5/47yuyNs7q8cFgoxx/jRQ7LDV3SsmY7S5PCnAEsXzbCqaxzu7xwqiggq3i1q0cIs0By47ocaymJAhG+xYVVSSSt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199021)(2616005)(8936002)(83380400001)(8676002)(41300700001)(6486002)(2906002)(36756003)(6506007)(53546011)(4744005)(186003)(6512007)(5660300002)(64756008)(31686004)(66556008)(66476007)(91956017)(478600001)(86362001)(31696002)(76116006)(66446008)(66946007)(4326008)(38100700002)(122000001)(38070700005)(54906003)(110136005)(316002)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0Rvb1B1WEJ1dktpRUJnck4wUlhrVUsrNDg2ZWp3TURqWmxFaGFxSE1taGM3?=
 =?utf-8?B?Z3pYRDNaaWgrM29JbGppQ0orbExQMHVtM0tjYU51Vk1sdkozUDNJQ28yYVB3?=
 =?utf-8?B?VEhmeDJjRXVRRFkyeWJvODlJRStzbzh2T1hhNXlRNG4rY2ltWnY4UDA5a2Fq?=
 =?utf-8?B?cXArTkVDUVpXWDAzRzZsNFJrL1V5cm93V2dtbTVRVEtxOEpZamFZd0plbm40?=
 =?utf-8?B?Q1g4MjBGSlF2eWVBWFBOR3AvOVFXa3Vob1NPL0pkR1U2YWlBYzJtcnpGZ1ZL?=
 =?utf-8?B?Y0I2TTJBL2crbDdPaEd6SEdzQ2FlQjlBR3pWY1hyU0hlcU56Vkh2TURjRXNH?=
 =?utf-8?B?SUJWUkdFYWQ4bXd6dUtxbTlMN09EQ0tSMFA1VjhEa1hRdmZRYUo3QTBxdS9h?=
 =?utf-8?B?NU1tMmxTWFE3bWVtL3d2d00zVkloRTQ3MElFczVHVVl0TFVZTTVkRHJzampB?=
 =?utf-8?B?OTVVenlFcCtZemp3QUdHLzI2bG1RWnZNb2tuN2RPOXk1NWZZRmxvd3VqVUUr?=
 =?utf-8?B?VWtvN1h5dnBwWnVhSnQyQWFtSzBRa3RFUVVmaGJ5dUxEWEo4WEtUUUVIZ2Q2?=
 =?utf-8?B?anhtK1pIdFd5NDBPTXZybS90VThGUEVxdmk1N0VGaVUxSWt6dktKUy9aVVZr?=
 =?utf-8?B?elVhcjBITmtDenNrQUJDMExCNUNZdjRsZjVEaWd4TW5MaEtvYmNtSHNOUTA2?=
 =?utf-8?B?SjhWK2lwWWNBazd6ZVorcm5WMEtoSitVdE0xUDFBOWdaZWVDa2FYOCtyYkp6?=
 =?utf-8?B?amlKZ291aEsxNkJUOG5iT3Z6VGZPdWlvS3ZzNjl6bWJSVno1bVRMZWlTS1J3?=
 =?utf-8?B?aC90a0ZiYlRBNjgzQ2lmRUN1eUpOZUhRWmZrU3J5LzZJdHVZbXhKb3FEaDFC?=
 =?utf-8?B?WmhBb3RqWkRGa0FlY1FES3lSUGRBdGpock9oRFNnbHQvSVlXb0MrVXJrb2VE?=
 =?utf-8?B?bDllWGZvR1Focm9MR2psZ3dQQVJOSC9lbnVScEM5ZlplOUJUUkdTaWZTbDRy?=
 =?utf-8?B?SGJsR3lrdjQ5NzhsT0cwRjFyaXVnN1Y1akZ3YzhLb1FaK3hiaWxGclpFc3Zy?=
 =?utf-8?B?Zkp5ZkJUQTNtbDAwN1ljWmpyVHB6SFZRS1E3d1Jya0JrVjVsT3dsSFZyTkgv?=
 =?utf-8?B?NmprSVRLeklnbnBqU2tzNzg2TXhudkJBOWtHQSsrdFZtSTZpMjVnN2xuRys0?=
 =?utf-8?B?QjFPd0xtZ2dDUm1vN1VFZGFOTlpTaHlOUHRBekR4d3ZkM2ltcTJ2UGdIWFJB?=
 =?utf-8?B?amZycUdhTk1EbkJPMU1JQTFMZ0FTM2QyOWEwd3kyNitRSWF0cVJKc3hHRFhp?=
 =?utf-8?B?aDVUeFV0b2FtZlZ2Y1JuSEFnLzVPbzZza1ZkRS8ydEo5KzRSMnFjTENlU3E1?=
 =?utf-8?B?M2hDRVZVTGc2dGNEcm5rZ0k4d0kxaGVkNHM0MzdhS0tYVFFDWW43NWhDWjRF?=
 =?utf-8?B?Zy91ZVBJRUFiWm1HU3U2aTFmL2RMeCtVWW1iSjZteDVtdjJZdVJ4QmxTMW1q?=
 =?utf-8?B?RFFHNGgvU0YzdmJGVHBiUXljMFlWR3RpeDMxV2tOMGRTVEVVNVRFUWRoclQy?=
 =?utf-8?B?REdkTk0zZTRkZTVBSktmcE5heWtpSjR4SVEzMTF4SGxoS2NNVll3MTFSS0xz?=
 =?utf-8?B?dDNQSTZOalFxRTY3OTdUbTY3L25mT2JNZDlrR1lEQWF0dFB6SEhRSEoxeHZr?=
 =?utf-8?B?Mno3dFZFVDZjaUk4cWQwUEgzRnEybXFhb2hrbnRSTWZNdGwzK1lIQ3NvRGJO?=
 =?utf-8?B?b3E1U2NKQ0pQZ2tSZTBmdnpUQzN0WDg2OUZMZ2hxa2lUSUJHWCtpem8xRHdK?=
 =?utf-8?B?UUI3dElBeDl4bUlwcmJjaDQ4VWNVWTdEMW4rRTFQOGlGcWFobGY3UE50TVRC?=
 =?utf-8?B?cTJRd1dnVzFJNmpQaU9zc3NkQWdjZXJXeURQTExSQ2RLQ1NkcTZMVFdWaUxt?=
 =?utf-8?B?cnplS1o1WnZMa0xSSzVvNG5jVkJMbmV0cTkzdGVydkgyenNhZjFrUW5IVVE5?=
 =?utf-8?B?aHNaSllicTNNSnl3MWpJUTVxeW56c2dDaTJTMEdLUUhUUU40Q1gxS3FlQkY0?=
 =?utf-8?B?TWRaNVJteU9TODdCWkZiU1d2YllPWFpET1BCL1kwRWFUN0M4WjRKQVg2Mk15?=
 =?utf-8?B?aE1NakRhWkhNdFJaYXAyV3R2TjB5R3ZaZ2N6N3UxSDk0UXcydk42d0JuTnhF?=
 =?utf-8?Q?hvDGu0D6+utoBU54jD91PK5pzXkqU5kzX/X1MlihpqUt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0581155BEC811548BF736E1120D65E7D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f757aad3-d051-4789-c090-08db712f83c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 01:41:49.0565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IMBCJm49F74OoOger6JOKvFKwjmqatKxF4M3QqKdA8xPMYNTXGwitD02bHdqN3jdo8XbZ4sCXwzBOp+iOP5xjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6602
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8xNS8yMDIzIDI6NDkgQU0sIEJyZW5vIExlaXRhbyB3cm90ZToNCj4gVGhpcyBjdXJyZW50
IGRldl9pbmZvKCkgY291bGQgYmUgdmVyeSB2ZXJib3NlIGFuZCBiZWluZyBwcmludGVkIHZlcnkN
Cj4gZnJlcXVlbnRseSBkZXBlbmRpbmcgb24gc29tZSB1c2Vyc3BhY2UgYXBwbGljYXRpb24gc2Vu
ZGluZyBzb21lIHNwZWNpZmljDQo+IGNvbW1hbmRzLg0KPiANCj4gSnVzdCBwcmludCB0aGlzIG1l
c3NhZ2Ugb25jZSBhbmQgc2tpcCBpdCB1bnRpbCB0aGUgY29udHJvbGxlciByZXNldHMuDQo+IFVz
ZSBhIGNvbnRyb2xsZXIgZmxhZyAoTlZNRV9DVFJMX0RJUlRZX0NBUEFCSUxJVFkpIHRvIHRyYWNr
IGlmIHRoZQ0KPiBjYXBhYmlsaXR5IG5lZWRzIGEgcmVzZXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBCcmVubyBMZWl0YW8gPGxlaXRhb0BkZWJpYW4ub3JnPg0KPiAtLS0NCg0KUmV2aWV3ZWQtYnk6
IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
