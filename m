Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601B4705EEC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 06:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjEQEo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 00:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjEQEoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 00:44:25 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C759DC3;
        Tue, 16 May 2023 21:44:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KR0lVOYgzffdbg+5eEkpu8w4dL5rzguwBVaYObO8sTcoWf0F27j1772j+khYOFS+fLOujlwJsV6G1L7k+5eaoM2CIFjHCwsmx85WvcmtwkbTdJwCnhf5th1PMdlaPjVh6SqTgPDajlqGnMlofxDWV0KM02xHZ0g7JDfsjgp7WTywGAPqiBawHfMEhZsufmeLbWgrHJ9qBysaC0Mamb1Hlh3f3rt4uRS/zcd9Bg4a43ml01o7XT2hOwP+hau1qsa+qNiKMK5ZaHO1Y+TlqEBJ2XAQjucpOtB/cCP+tP9nmeC1m2jkI7fMFpa/WElRjbuqa7S+UMJajJNT0vNRHynD/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/Zjro1RMlQCwkgZDWZ0hJin+vQkzxaOJ7BcyCvPwOU=;
 b=gbDC6hdL9HiXsBDLB0l8dJDYQyTPxXwEHdxajkIgxILqw767ZDRCHzy+IhjUBv9vO4S0ERKsuYLShPd++35iLxfWGCob6OQmj8LqLiyJIn0TUlal5vwtyPwXUfrg5hwmR2sOSfp77+K+isQe6C4wmu6m+bYc/jTG3CXxXSVxw+n3FaK1pNJtZw6tqVX+L7W7BB3RO5327J0oVxSd0DKlZ2B4Ajmndo724/9G/GqdOjBuwOOXTC+bRpY1sdBNJvX6dbPW+wWbL0vZOwzUAwlU+KHtTlIHLm05hRkba7FLorW/RBIStSDMIV2xLfr9+FBPLjicBGH4g8EO5KqRwUT1fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/Zjro1RMlQCwkgZDWZ0hJin+vQkzxaOJ7BcyCvPwOU=;
 b=DClSkGSzlsreCeIy/IU4P+zLNRTDmfHc42v+UdUP1cjjaHkk2qSkO+YBZtbJs5z5ti/FbDlTszrAvY/tyFHtYcYXbL8TsRA8rWXtEYP7pyHHFIuj/8Qr2QhbcVZDSeVdsh0BdQvV1qv2UD9cNC28S7eu26j63bCHzRgwCBvjIz5Ha48RTZvcklln80eutz7gy+ySSP68+8kDt81jj2FUndcUOkTJmLqeFYEktt/RCpAJIVu6+4GNmLuSqXL+kWcd5WSkOcPow07ZHIxuAF0bhIrZP5GScryzTAViHd0OUqvNvbvtScqexHQdK/XGij3jAvdoJGC7mZybxF2yJ7unlQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 04:44:22 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6387.030; Wed, 17 May 2023
 04:44:22 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v4 09/11] nvme{045,047}: Calculate IO size for
 random fio jobs
Thread-Topic: [PATCH blktests v4 09/11] nvme{045,047}: Calculate IO size for
 random fio jobs
Thread-Index: AQHZhBJSSjhqp6+UyEGBfxLWuG1kt69d7FoA
Date:   Wed, 17 May 2023 04:44:22 +0000
Message-ID: <c5c2af7c-2b63-f30d-f568-c136dd6f6c5c@nvidia.com>
References: <20230511140953.17609-1-dwagner@suse.de>
 <20230511140953.17609-10-dwagner@suse.de>
In-Reply-To: <20230511140953.17609-10-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CY8PR12MB8297:EE_
x-ms-office365-filtering-correlation-id: 627cbfe3-95f0-4605-388f-08db56916294
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CQfWsYSnJb6XENIgNs62cWCcxFDTbh7T8zyKhhLTutwWfP6i2nZUrHeHLl8GzMXwPBVck2T79ot8YblFtn4DIU4De1TGOQaIuQG9u2vel+U6kp1ECmxSamptVeuFe3WDPz1H3QtwjsfGDdTiv9iJaPOR7Mj/IjL75IyeFqkYb/f8ZoU+JnY/xUTmBpbgY7XnLQwxgGk6UboKXym16DBe4y0wdManiZzfD2uOypX7LhFmrasXaC+pbCny2QAbpcKuIhd/eFkxeRXUHQDjVfalAieFrLVbAnT6qjiLhn+m5BWhe+Oaz8jTGsFf8owCJ886CtLahkp9FdyJgMEuu/snlSnQaBT+C3aRt+Od3zE1pTNuj8qNlSX/gAgSkhOzfOHWoO8ot4eMLZcH6Fy8Fp/2SjjRiOL86LSYTlyfjUL49jatsuIaHnnxf2h6VT0GuX02INFymCauSZd8odj0vWKgycs0iDE0Lob6cd2mfGwKgwhjVNthql5n88dd80G4KQakh+k2WtkFkrDyDqwNDE8j7b2gE3Km1Mqm5676zFUGd638m9UmNyWp+9j9G0Uvvt2p6u3K9KVSZ6YXfUNc5QPdKc4mkveBw5TR+TiZGJsdrSkkd3mfPu0dX0/z7m1C2j3stiWJuSAX3vhO+ODIcqUGTS5tBBZ6qrYz31sStl66R7sK3JObxh129tF0zVBJiOxp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199021)(38070700005)(6486002)(2616005)(36756003)(122000001)(6512007)(53546011)(38100700002)(6506007)(186003)(86362001)(110136005)(54906003)(31696002)(4744005)(2906002)(41300700001)(91956017)(8676002)(5660300002)(316002)(31686004)(8936002)(4326008)(64756008)(76116006)(66556008)(66446008)(66476007)(66946007)(71200400001)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akRiOVZTUHNRVmQvbkh6T2dGczRmYldxQ085VmtoOEo2enB0SG5EUFg1UHly?=
 =?utf-8?B?djhqb1c0L1dhdnV1aXpyMFVubFZmemtSdzhFK0FkMjBCZVY0YmEza01rek5M?=
 =?utf-8?B?TXJIT0tZdzRRUzBZYnRhTzdxdjFHdE94Qmg5NHcwZkRRT1hoTkw2K3EzUzRQ?=
 =?utf-8?B?K2VCOUtxSVRIcnlxTTlOZVROWkhpb25kZk1rNVFQQ09KTC9OeC9ORWMyRzA0?=
 =?utf-8?B?TmpDT1ZYcFh5MEg0WVd1VVk5S2tjOTdnUkNad0xTK0pJRWIxbzR6amVMcWM5?=
 =?utf-8?B?ZUlhSkF5WHdhZFlHVktaQUVtbi9vc2RZQTdZMVRLWmYycjFPWXgrN3M1eElX?=
 =?utf-8?B?VkViby96TmIxNlRUZG9UYTdITnB2R3lvWFo2TXZDR2lQd3FXRVF0OG9HSzhZ?=
 =?utf-8?B?U0V6UVdKVmRyMGozWjV2WTVMWS9SQ3JFVFRqeW8vR2FYNzhYb0lDSkFkNEtt?=
 =?utf-8?B?VFM2Zys2RmZDS0IvNW5BVmNCUUNaNHBOdE5nNCtYOEh3Z0x1MzBockNVMkor?=
 =?utf-8?B?ODVlL0JSVVhtcXB4SVJLQ1EyM3RRK0swZnM1WGZ1KzUrMFRXeTRMVExrK2to?=
 =?utf-8?B?WXQ1Vm9taUdhaldvUkpPbVFiWTB4MDhudUFUZE1rSXVLYkVTQWswRndVdUtz?=
 =?utf-8?B?WTNhMzZidGhQSlNFU0I1TTArd0lrUk1kWER1MEpmWkRBZHoxS3hkWHdqWFJn?=
 =?utf-8?B?T1Q2Z2I3V20zUXQ1YmFPZ3dLcC9lUEV4VlhOOWFiRFJMTFRyazJUTHpleUJZ?=
 =?utf-8?B?c2pTZmpNTGxETmtwUU5QWmFKMWNUeVQ0SVNLdjdpNUZjalhnSXk1SjJHeUo2?=
 =?utf-8?B?dTVUd0twZkFjOU5PQTBlYTc4US9YN0p6NTVndGhpZVhHeXErWHNCNHZhREVG?=
 =?utf-8?B?SC9ZUC9EN3VRNmdBR3pCUlJ4T3o2ZzF1VnUvL1V6ZnF4Nml0L2lEb2tJTUlH?=
 =?utf-8?B?cVJRak15dnBnSGJvNHFQVTRzTEZWZjFXZWdKRm9IUVNiVFdRNUdVMVFTQ0Nj?=
 =?utf-8?B?M2hLY1JUc3o0VTVRK0lwaFZQNHlDbnVqZDlTVnBwRC9wVnBHRkNjVVhqd1lI?=
 =?utf-8?B?VGFtVW5XRFZmK21ZMThnczh3RitnZTNpYTRQdVV6a2U3akFvb3hYeHdWRTVE?=
 =?utf-8?B?bU9nOXppMk5pTGRVVUtqWGJpbjA0N2UxTlIzRFU5WHBZUTMzSDIySlFpMEM2?=
 =?utf-8?B?RVMwcTl2c2I5Y2JWbUtZbmk5UE1DMGlxOERQZElGeGZBQ1FpSU9RTWFUcDZQ?=
 =?utf-8?B?T3hWaWNqYk5DN2o3RmFuTmlvOTZZcVhMUG52M3JrRXBnUEl1S2l5L0FPRnRt?=
 =?utf-8?B?NGFRZ3pvRWt3VGxaYURLeHpZSHdvUzdmRWxxMkpsakFSUmZ0Q1FUbXdKSGh2?=
 =?utf-8?B?M1NEcEdtN1N5UHRBUGRWbXFhbllQaUszVEgrRTVRYkhsSnV3c0lqZGZlLzYr?=
 =?utf-8?B?SXh6d2NTaVlVMDhjU1VuNzd6ZnY2dkYyYm45RXQ2NXhSYWdQbzg1dnFENEFY?=
 =?utf-8?B?cktQckc5OWFqQWtBM1hyWVdmNWNmYThxUkNhVkxmekgzcmJhNFJ1L3Y0S0Jq?=
 =?utf-8?B?b0V6djd4djFiQXcrdzJreVowWVNBZXRtUUcxblNHSUw1M2o1bTBCRFFRRmJD?=
 =?utf-8?B?S0h1d3hNeEJmNnNUbjV6eE1pekhQZUpMa1JvbWJkdUZjMURESXdHU2VBeXYy?=
 =?utf-8?B?dGlQTkpFLysvODh0WVpNTHEyUy9MbFRMVDkxOW1hTkZzUGlRR0M4TEs2QzVj?=
 =?utf-8?B?bk5KK2JvTFYrUHloNExTNFJNL0kvN3FoMU0wQVhBR2ExT29SRGp5Q2NOYnNE?=
 =?utf-8?B?UVlvNUJWWVlRbjlpdzNxaUNDNVV4dG02MWIxTUZONENidHJhZnBtNVZVZWd2?=
 =?utf-8?B?TjJSMU9sZ0w3OEZIZFpkajdtK3hxSWFabEZ1cnMyWWpHbGh5ZjJNNnRrMGkx?=
 =?utf-8?B?bnc0SjdPWDVGTDh0VzkrdGV4Vmd3N00vUGpLYm5ITmZIVlR0clZHZ0g3TlJ4?=
 =?utf-8?B?d1NhdXNoSVZ0RVJRdnZUWkwzV0prbVlTdDBNS2ZMUGhHMUxkVmRjL1hRbFNu?=
 =?utf-8?B?U1ptLy9KRVdFcWgrMDRHMjFjeEdIdXUxemFkWVFmd05qNUVvY09oR0lzZk5u?=
 =?utf-8?B?QW9OMFcvU2Zjc0tVQTRzTUUra3FQVVExdHZzajRxSGJYUlpuWG1HTk14UGV1?=
 =?utf-8?Q?yqZJqrEZUC9uHVhxAstX6ehZtGyK5nPeKV1qc8SSlPAt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3C80DB013A1324996FDDC57A24723C3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 627cbfe3-95f0-4605-388f-08db56916294
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 04:44:22.6869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E5hZhrSQ+UW49X7oE3BAoPw9j8Xq/WTXgK5cKbwJ6UeZjhet/G4YVlhcXc5L0peLHFj+ktGDj2kSYGBEm8dOxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8297
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8xMS8yMyAwNzowOSwgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4gX252bWVfY2FsY19ydW5f
aW9fc2l6ZSgpIHJldHVybnMgdGhlIGpvYnMgc2l6ZSBmb3IgX3J1bl9maW9fcmFuZF9pbygpDQo+
IGZ1bmN0aW9uLiBUaGUgam9icyBzaXplIGlzIHRoZSBzaXplIHBlciBqb2IsIHRodXMgd2UgaGF2
ZSB0byBkaXZpZGUNCj4gdGhyb3VnaCB0aGUgbnVtYmVyIG9mIENQVXMuDQoNCnNvcnJ5IEkgZGlk
bid0IHVuZGVyc3RhbmQgd2h5IHdlIGhhdmUgdG8gZGl2aWRlIHRocm91Z2ggbnVtYmVyIG9mDQpD
UFVzID8gaXNuJ3QgdGh0IHdpbGwgY2hhbmdlIHRoZSBjdXJyZW50IGpvYiBzaXplIG9mIHRoZSB0
ZXN0ID8NCg0KdW5sZXNzIHdlIGFyZSBpbmNyZWFzaW5nIHNvbWV3aGVyZSB3aGljaCBJIG1pc3Nl
ZCBpdCAuDQoNCi1jaw0KDQoNCg==
