Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE39E710A28
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 12:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbjEYKdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 06:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjEYKc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 06:32:58 -0400
Received: from CO1PR02CU002.outbound.protection.outlook.com (mail-westus2azon11010006.outbound.protection.outlook.com [52.101.46.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D968E6;
        Thu, 25 May 2023 03:32:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2o5IiZRhJM62J26zuKCsohcWsQZoQOW2pLv3PhIH+pyKA7C0ggKJ7hhbanobp+xbklH/fM5IRkwd2eGhpBdc1uy+kezCatv2s5CNm5udGByBJkA+mDzhjE6eAM0t6tv9qPwNqlmrsz9wY0dfusWxxAYMcsMTmI7U/iVZuMPSt/LIuakMcI3o+6IgT73iqlf9fmZJpS/2S2b+S9X90RQhLA2fnvd9o0kmlBHmxXAoUYWcdUNULDXvvrrLE5Of518U6RIycDwXhFqqoYi4YYOjAziBD3uqgFcQ7g/ORfa8P5pMp+eHS0V7NLEidFkhm67WaE9EbxOj0BgWPV8id7tXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnAQEHnEb0OJwNVuxTtmxh/i7oot0IgnpZKIGpHa3Ls=;
 b=SJ7IcRANrcASolZDQqyBQmncnXafVb+pZk7nNNMd93VjMfTdpXsbik3MAp+5adJCW1Z0v/50aesgv/a9PLeTnlcZT8KvTPfsk9nBLPAgyHtnp6EdicEd8Kv3tLazlaLUCW50Iudu+NiXTQdoUft3f4Bq9xZIydQ3HrI0B+CrhjBeuB1nvIDo1J4y9yzHn9BAYBNNSACJcEULSwzbaL5NknEwkfnd9sFFRIr1sG6BjIyABIVuzXu6aVzvVvXSowlRm3aXziwamNUWCcyGP6IfoBs44RWFUGVFxSaTxByb37RMXl8QfabWw1bZqC2IIUSBRJzIYCXKQzmK/le6lRbecQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnAQEHnEb0OJwNVuxTtmxh/i7oot0IgnpZKIGpHa3Ls=;
 b=KXyzWrF59uZRdBXMCWj3s62+rVVpVDZDCryRRD0tvGq1khUEwxKy3aYEXC2JaH4evgvOBigpvt1f6j/oJCyCAnkaW4Vx8lwky6VvWC2zShDCEvgbxMEpyIA74YuYS0Is6thrCdZRIBvKnodsXOrIguWiPXJbTywBZdTiK+tyH5Y=
Received: from BYAPR05MB4469.namprd05.prod.outlook.com (2603:10b6:a02:f4::21)
 by CH3PR05MB9578.namprd05.prod.outlook.com (2603:10b6:610:152::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14; Thu, 25 May
 2023 10:32:54 +0000
Received: from BYAPR05MB4469.namprd05.prod.outlook.com
 ([fe80::4389:dd0e:c4c0:eaad]) by BYAPR05MB4469.namprd05.prod.outlook.com
 ([fe80::4389:dd0e:c4c0:eaad%7]) with mapi id 15.20.6411.027; Thu, 25 May 2023
 10:32:53 +0000
From:   Keerthana Kalyanasundaram <keerthanak@vmware.com>
To:     "keescook@chromium.org" <keescook@chromium.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Alexey Makhalov <amakhalov@vmware.com>,
        Ajay Kaher <akaher@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>
Subject: Re: PROBLEM: Using Randomize structure layout GCC plugin doesn't
 generate proper debuginfo
Thread-Topic: PROBLEM: Using Randomize structure layout GCC plugin doesn't
 generate proper debuginfo
Thread-Index: AQHZjvKjA7TD2X+h3UmjBY+ofxwuxK9qypMA
Date:   Thu, 25 May 2023 10:32:53 +0000
Message-ID: <15A87C96-F904-4B59-939B-80653410A56E@vmware.com>
References: <DF6066B2-35AE-40BE-A217-D3C48DBF6751@vmware.com>
In-Reply-To: <DF6066B2-35AE-40BE-A217-D3C48DBF6751@vmware.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR05MB4469:EE_|CH3PR05MB9578:EE_
x-ms-office365-filtering-correlation-id: 0a72668b-f8d1-44a1-d6f2-08db5d0b65a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C4CZ/nrVW33DuulRcvzhCdTvliLxHhqSgHDT2jcGF6C6PkpOOfcEzEqGD/zqmZgj4qtRF0EwEXAq+ppd0owxth0sni6rr54GPhgp/zv1lRjVue81Ae2aAsRjSqZ0KJX44/6TotMeKJLb9SXrGmIplJrGRVOnLC+1q68sMmS/k63HXspZfuaTL1SrivLuynxSItszQLuE4VbpRO9qzguH6/huMEKhPI9PUOKC9Zf4nS8Xb6dTYmSRV9Nfy3FTh0TBCw5qS55PeIivIqE1Cm78i6thCwx5E7VF8ZSyjOMR9hrsr0ek7HJtOCDJL163MvDmsngk73R/UdPfPMIyTfv+oNa1MRk++qZF/a+tmmpU6Cp/Bvkg+ZFjeJCyk7WHKjDrPD9D6iQ2w8fIj0XNGDnV/di5btul99OHjJR2l30LdjQzERWqc1N5UZmbsDHxnZigZQ963sTAJGSHP4ArETMy/frldR5J1MOBt4UmxMv2Au5pKm7SiVlrhwioslXsR/V6zsWCPSUnm1zaDPh6zik+sKEf/nzUB7AfT5IjdF30e0Ww/VTQMcgiNb88awUzLpdwqIo/wrGkatxKz95HwY2K/bGNECzYwf/7SsmyEclav7t2MTNzsz8zGhhfmnTXnQaH0bpepZ8VvBQ99bk5qeaAFy80NSFaFeiMDdcCx4aSOrIm/zCHqqecD4ZuElh4ybLUe7dreqiTdd1huiIYj/E76E1ykClWofZLNP7/s3gPl/A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4469.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199021)(26005)(2616005)(6506007)(966005)(53546011)(6512007)(478600001)(38070700005)(41300700001)(107886003)(6486002)(86362001)(316002)(71200400001)(4326008)(33656002)(66556008)(66946007)(66476007)(76116006)(66446008)(64756008)(36756003)(91956017)(83380400001)(38100700002)(8676002)(122000001)(8936002)(110136005)(54906003)(5660300002)(2906002)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzBBTHBsNXQ3UjhZMk9OQ1dQR05xbDVsVHNLMXZVeVJ3NnkrVDdseHFhaEZE?=
 =?utf-8?B?TGc1aFdOWjRaWERRelIwNFIzQ3dRM3R1dWhQQktuVEp5S2ZuVldlZTB5RTBE?=
 =?utf-8?B?RnpOcjh1cE92YnVLNGpRRXhHS3YyZDdqYkVMQmkvVDFrZ2hTeXhRVVAva3k1?=
 =?utf-8?B?aEVMQnNSTlp6czIrZ2YrT3dOaHpmVUc4b2FteEpYOXV4clVHa2tuZ1M1Smt5?=
 =?utf-8?B?RUdXdWs4Z0xKS1R5c1NFUVZLVno0M3hIMi9aYWJSZlNLRHlZeGIxd01NWnhU?=
 =?utf-8?B?VGpPTGI0VHdKZ2w2SGNOWnl3YldVY3d2dDgxR1VNY0c0RWl5N0FCa3padE1h?=
 =?utf-8?B?eVZEZlVXdGdLK20vUkRnNFhDNEsyK0h0cjlHRDVRS0czSVJwWnNWYWdxbFJZ?=
 =?utf-8?B?U2tHWno3ZFZVOGU3US9wbFBZYmZ2V2xvYTdXV0M0LzR5RGIwdi9HVm85aktl?=
 =?utf-8?B?eU9uRDNGNEMzZHZOZXRZaGJUR2pLOWFFaXBnWisrejJCT2laS2M0bFFST2Nr?=
 =?utf-8?B?emk1S0VMRUFPZE00ODJ1VUg3WXFDTkl5Tlord0JMbnJYQmU1ZVNOUzVWSGRH?=
 =?utf-8?B?MXhIVmNNNmp3SGhYWmtCN3hRMWN6bFBXY2c2N0RiQitmeDJGYzlHd2ROejZh?=
 =?utf-8?B?QWJDNHJ1TkFPd2ZyaG5MU3kwMVgrbE5zY2VwWG5YaThXZjcvVXdLSGtLQXIw?=
 =?utf-8?B?UDBJeVJtRktUdHFoTERxanpra3c2VWhCMG53QURWU3NtRXRXbmpMNFhEU1ht?=
 =?utf-8?B?RFUxbmw4VXZNLzdmTXZWZmZKMjQ3UmlnMDV0S1ZvL083N1FFQmNtd3RaQ0lR?=
 =?utf-8?B?dFFDQ2tZS09VOStjZ2pZVnBLNGxFRU5nYy9FS0N0UmNXUmJYbWt6cFdxRmpt?=
 =?utf-8?B?MVVmTDFwYjg5TzNjQy8ybkhQL25XTnhPS1hXMGcvOEtzVW5qN0UzV1V6dzk2?=
 =?utf-8?B?YmVGWWdoaFQzUEtQV2pGY0FCNDBOcjR5TmN0bFlYekc5cXpJc0J0UnJhMFRE?=
 =?utf-8?B?VUMrWWxsOTdOMWRFeXBRTFl2a2Y3NEhtVnQ0cUJBT3dMNzZEcGF5b0JrTkdj?=
 =?utf-8?B?V0xtZWVXRXY2NkRpZVhSMXkxbFM3aFE5bjVFSHNPVldOdEI5SEwzdy8yL25O?=
 =?utf-8?B?YWZKYkRSR29jZFlTZ3JUaHlzeFkzNElrdlQ0c3g3RWUxNHZlTlpyMWJsM1dy?=
 =?utf-8?B?akFXU05oNm5sTXVzNm5YTW54T3ZvaXR3enJTN2ZSODI2S1M3NllGTVJ0dlZz?=
 =?utf-8?B?ZmN1bWdlVTFuVUNKU01FSk9KYjE1Rmp2QU1TczJRVUcrRnpBQnd5dUdEcWZv?=
 =?utf-8?B?L3NpaHNEdnZyMEduNXo4TlZxbkJrbTFkRG1ta3dodnBVR3ByaGpSc3BldU96?=
 =?utf-8?B?Szh0S0QzeFE4Vlh3YWJqYVJVWHlhTlF0Yi9WZUVtQXpJdkVjbjljWWgwR3cv?=
 =?utf-8?B?ZE9tRXdXbjZ1RmJ5L1Zpd1Z4ZHdERGYxbXNOaGZHcVZiSDY4ZWRmV1U4S1BU?=
 =?utf-8?B?dWw5bm9ERldLelpXMndLbWlCWkpQbGtnSUtNMDJZbHBrYUNLaElZRzUzaWI0?=
 =?utf-8?B?c25VOEFsMytpOXZ1YmZHai9QWEtFMmhIdjlKdThNbmdqZGsreldJSGhNVmda?=
 =?utf-8?B?eUhjUnNHamJyaXJxeWRBUW5SU2Ixc2xqS1JnVGZ3bmNsUldaZW50cjNLSUoz?=
 =?utf-8?B?MUFnM29KUlpxQjVSZ3dkYWc0WW5OcHp4RTBQUW4zTWhwdlNHRFdTdzNXcy9D?=
 =?utf-8?B?eUNSVkFJdy9PUmtHbEVrSFRySnFkSllrRXVYVkVRQ3lJclViaHNqWDF6ZEtJ?=
 =?utf-8?B?SmlRYTRJTU1rTDZvd3VXOTJmam40WXFYY09qUERDQWZtUXl3eHNleG5CWE1v?=
 =?utf-8?B?VUpKNVpwQjB4SmlkYm14NTJGU1FMMGpxbWNiUXFMdEY4VGpyWDFMMnl0aTRu?=
 =?utf-8?B?dGZZcEdKWUJNWXdUc25JLzNIWXh0Y2RheURDTUN5elJVU3o4eTdkM3NxSjVl?=
 =?utf-8?B?RTFmaXVEdFh5d2dwU1N4RmY5eEVIR2tLbDhJdS9Hb2M5ZnZzMVRrZkpsTU9z?=
 =?utf-8?B?bVpWcmhqWk5Pa09XVTQyUWxlQ052Y3BzQit4UUQ1ckZtUk1rUkwzN0dCY2hL?=
 =?utf-8?B?WXgvM2RzTmNTZlJVeUpDakhhd0FEMHhYWXZsZE9kUm1NYW91eTE3Mi9DR1Uv?=
 =?utf-8?B?Z3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB76758B3D521F438B46951FC8F8D1BF@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4469.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a72668b-f8d1-44a1-d6f2-08db5d0b65a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 10:32:53.4257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: raU2srDZ81ACKXKJHgyKTniu71zx0NQRUcnSsZmNzRys/BzUSCBiQfypYukBRbxZdpnki+3NFA2uPi4xTKVyYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR05MB9578
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGxlYXNlIGZpbmQgdGhlIHNhbXBsZSBDIHByb2dyYW0gYW5kIHNjcmlwdCBiZWxvdy4NCg0KU2Ft
cGxlIEMgcHJvZ3JhbSAoZmlsZW5hbWU6IHRlc3QuYykNCg0Kc3RydWN0IGNwdV9pbmZvIHsNCglm
bG9hdCBmaXJzdDsNCgljaGFyIHNlY29uZDsNCgl1bmlvbiB7DQoJCWludCBjYXBbNV07DQoJCWxv
bmcgYWxpZ25fdmFyOw0KCX07DQp9IF9fYXR0cmlidXRlX18oKF9fZGVzaWduYXRlZF9pbml0X18p
KSBfX2F0dHJpYnV0ZV9fKChyYW5kb21pemVfbGF5b3V0KSk7DQppbnQgbWFpbih2b2lkKQ0Kew0K
CXN0cnVjdCBjcHVfaW5mbyBib290X2NwdV9kYXRhID0gew0KCQkJLmZpcnN0ID0gMTAsDQoJCQku
c2Vjb25kID0gMTEsDQoJCQkuY2FwID0gezEsMiwzLDQsNX0sDQoJfTsNCglyZXR1cm4gMDsNCn0N
Ci4uLg0KDQpTY3JpcHQgdG8gY29tcGlsZSB0aGUgQyBmaWxlIHdpdGggcmFuZHN0cnVjdCBwbHVn
aW4gKGZpbGVuYW1lOiB0ZXN0LnNoKQ0KDQojIS9iaW4vc2gNCg0KYXNzZXJ0X2NvbW1hbmRfdHJ1
ZSgpDQp7DQogICAgbG9jYWwgY29tbWFuZD0kMQ0KICAgIGxvY2FsIG91dHB1dD0NCiAgICBvdXRw
dXQ9IiQoZXZhbCAiJDEiKSINCiAgICBpZiBbICQ/IC1uZSAwIF07IHRoZW4NCiAgICAgICBlY2hv
ICIkY29tbWFuZCBGQUlMRUQhISINCiAgICAgICBleGl0IDENCiAgICBmaQ0KfQ0KDQplY2hvICJE
T1dOTE9BRCBSQU5EU1RSVUNUIFBMVUdJTiBDT0RFIg0KYXNzZXJ0X2NvbW1hbmRfdHJ1ZSAiY3Vy
bCAtayAtbyByYW5kb21pemVfbGF5b3V0X3BsdWdpbi5jIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3N0YWJsZS9saW51eC5naXQvcGxhaW4vc2NyaXB0cy9n
Y2MtcGx1Z2lucy9yYW5kb21pemVfbGF5b3V0X3BsdWdpbi5jP2g9bGludXgtNi4zLnkiDQphc3Nl
cnRfY29tbWFuZF90cnVlICJjdXJsIC1rIC1vIGdjYy1jb21tb24uaCBodHRwczovL2dpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9zdGFibGUvbGludXguZ2l0L3BsYWluL3Nj
cmlwdHMvZ2NjLXBsdWdpbnMvZ2NjLWNvbW1vbi5oP2g9bGludXgtNi4zLnkiDQphc3NlcnRfY29t
bWFuZF90cnVlICJjdXJsIC1rIC1vIGdjYy1nZW5lcmF0ZS1naW1wbGUtcGFzcy5oIGh0dHBzOi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3N0YWJsZS9saW51eC5naXQv
cGxhaW4vc2NyaXB0cy9nY2MtcGx1Z2lucy9nY2MtZ2VuZXJhdGUtZ2ltcGxlLXBhc3MuaD9oPWxp
bnV4LTYuMy55Ig0KYXNzZXJ0X2NvbW1hbmRfdHJ1ZSAiY3VybCAtayAtbyBnY2MtZ2VuZXJhdGUt
aXBhLXBhc3MuaCBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC9zdGFibGUvbGludXguZ2l0L3BsYWluL3NjcmlwdHMvZ2NjLXBsdWdpbnMvZ2NjLWdlbmVyYXRl
LWlwYS1wYXNzLmg/aD1saW51eC02LjMueSINCmFzc2VydF9jb21tYW5kX3RydWUgImN1cmwgLWsg
LW8gZ2NjLWdlbmVyYXRlLXJ0bC1wYXNzLmggaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvc3RhYmxlL2xpbnV4LmdpdC9wbGFpbi9zY3JpcHRzL2djYy1wbHVn
aW5zL2djYy1nZW5lcmF0ZS1ydGwtcGFzcy5oP2g9bGludXgtNi4zLnkiDQphc3NlcnRfY29tbWFu
ZF90cnVlICJjdXJsIC1rIC1vIGdjYy1nZW5lcmF0ZS1zaW1wbGVfaXBhLXBhc3MuaCBodHRwczov
L2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9zdGFibGUvbGludXguZ2l0
L3BsYWluL3NjcmlwdHMvZ2NjLXBsdWdpbnMvZ2NjLWdlbmVyYXRlLXNpbXBsZV9pcGEtcGFzcy5o
P2g9bGludXgtNi4zLnkiDQoNCmVjaG8gIkNPTVBJTEUgUkFORFNUUlVDVCBQTFVHSU4iDQpnY2Nf
dmVyc2lvbj0kKGdjYyAtZHVtcHZlcnNpb24pDQphc3NlcnRfY29tbWFuZF90cnVlICJnKysgLVdh
bGwgLU8yIC1mUElDIC1Xbm8tdW51c2VkLXZhcmlhYmxlIC1EUExVR0lOX1ZFUlNJT049J1wiNi4z
LnlcIicgLUkgL3Vzci9saWIvZ2NjL3g4Nl82NC11bmtub3duLWxpbnV4LWdudS8ke2djY192ZXJz
aW9ufS9wbHVnaW4vaW5jbHVkZSAtc3RkPWdudSsrMTEgLWZuby1ydHRpIC1mbm8tZXhjZXB0aW9u
cyAtZmFzeW5jaHJvbm91cy11bndpbmQtdGFibGVzIC1nZ2RiIC1Xbm8tbmFycm93aW5nIC1Xbm8t
dW51c2VkLXZhcmlhYmxlIC1Xbm8tZm9ybWF0LWRpYWcgLXNoYXJlZCAtbyByYW5kb21pemVfbGF5
b3V0X3BsdWdpbi5zbyByYW5kb21pemVfbGF5b3V0X3BsdWdpbi5jIg0KDQplY2hvICJDT01QSUxF
IHRlc3QuYyBXSVRIIFJBTkRTVFJVQ1QgUExVR0lOIg0KYXNzZXJ0X2NvbW1hbmRfdHJ1ZSAiZ2Nj
IC1nIC1EUkFORFNUUlVDVCAtZnBsdWdpbj0uL3JhbmRvbWl6ZV9sYXlvdXRfcGx1Z2luLnNvIC1m
cGx1Z2luLWFyZy1yYW5kb21pemVfbGF5b3V0X3BsdWdpbi1wZXJmb3JtYW5jZS1tb2RlIC1jIC1v
IHRlc3QtcmFuZHN0cnVjdC5vIHRlc3QuYyINCg0KZWNobyAiQ09NUElMRSB0ZXN0LmMgV0lIVE9V
VCBSQU5EU1RSVUNUIFBMVUdJTiINCmFzc2VydF9jb21tYW5kX3RydWUgImdjYyAtZyAtYyAtbyB0
ZXN0LW5vLXJhbmRzdHJ1Y3QubyB0ZXN0LmMiDQoNCmVjaG8gIklOU1BFQ1QgT0JKRFVNUCINCmFz
c2VydF9jb21tYW5kX3RydWUgImdkYiB0ZXN0LXJhbmRzdHJ1Y3QubyAtcSAtZXg9J3NldCBwYWdp
bmF0aW9uIG9mZicgLWV4PSdwdHlwZSBzdHJ1Y3QgY3B1X2luZm8nIC1leCBxIHwgdGFpbCAtbiAr
MiA+IHN0cnVjdC1jcHVfaW5mby1yYW5kc3RydWN0Ig0KYXNzZXJ0X2NvbW1hbmRfdHJ1ZSAiZ2Ri
IHRlc3Qtbm8tcmFuZHN0cnVjdC5vIC1xIC1leD0nc2V0IHBhZ2luYXRpb24gb2ZmJyAtZXg9J3B0
eXBlIHN0cnVjdCBjcHVfaW5mbycgLWV4IHEgfCB0YWlsIC1uICsyID4gc3RydWN0LWNwdV9pbmZv
LW5vLXJhbmRzdHJ1Y3QiDQphc3NlcnRfY29tbWFuZF90cnVlICJkaWZmIHN0cnVjdC1jcHVfaW5m
by1yYW5kc3RydWN0IHN0cnVjdC1jcHVfaW5mby1uby1yYW5kc3RydWN04oCdDQoNCi4uLg0KDQpS
YW5kc2VlZCAoZmlsZW5hbWU6IHJhbmRvbWl6ZV9sYXlvdXRfc2VlZC5oKQ0KDQpjb25zdCBjaGFy
ICpyYW5kc3RydWN0X3NlZWQgPSAiOGQwMWZlYzM4MGI3MDUyMGM5ZjFlYzMzMzIzMTAyMWUxZDA0
ZjhmYjY0Yzg1OGY3MzMzMTg3ZTc5ZWUyMTExZuKAnTsNCg0KDQpUaGFua3MNCktlZXJ0aGFuYQ0K
DQoNCg0KPiBPbiAyNS1NYXktMjAyMywgYXQgMzo1MSBQTSwgS2VlcnRoYW5hIEthbHlhbmFzdW5k
YXJhbSA8a2VlcnRoYW5ha0B2bXdhcmUuY29tPiB3cm90ZToNCj4gDQo+IEhlbGxvLA0KPiANCj4g
SeKAmW0gcmVwb3J0aW5nIHRoaXMgYnVnIGluIHJhbmRvbWl6ZSBzdHJjdHVyZSBsYXlvdXQgcGx1
Z2luIGluIEdDQyBwbHVnaW5zIGNvZGUgb2YgbGludXgga2VybmVsIHRyZWUuDQo+IFdoZW4gSSBj
b21waWxlIHRoZSBrZXJuZWwgd2l0aCByYW5kb21pemUgc3RydWN0dXJlIGxheW91dCBHQ0MgcGx1
Z2luLCB0aGUgcmVzdWx0aW5nIGRlYnVnaW5mbyBkb2VzIG5vdCBoYXZlIHRoZSByYW5kb21pc2Vk
IHN0cnVjdHVyZXMuDQo+IA0KPiBUbyByZXByb2R1Y2UgdGhpcywgSSBoYXZlIGEgQyBzYW1wbGUg
cHJvZ3JhbSBhbmQgYSBzY3JpcHQgdG8gY29tcGlsZSB0aGUgcHJvZ3JhbSB3aXRoIGFuZCB3aXRo
b3V0IHJhbmRvbWl6ZV9sYXlvdXRfcGx1Z2luDQo+IGZyb20gbGludXgga2VybmVsLCB0aGUgcmVz
dWx0ZWQgZGVidWdpbmZvIGluIGJvdGggY2FzZXMgYXJlIHNhbWUuIFRob3VnaCB0aGUgcGx1Z2lu
IHNodWZmbGVzIHRoZSBzdHJ1Y3R1cmUgbWVtYmVycywgdGhlIHJlc3VsdGluZyBkZWJ1Z2luZm8g
DQo+IGhhcyB1bnNodWZmbGVkIHN0cnVjdHVyZS4NCj4gDQo+IEkgaGF2ZSBmb3VuZCBhbiBvbGQg
YnVnIGluIEdDQyByZXBvcnRpbmcgdGhlIHNhbWUgaHR0cHM6Ly9nY2MuZ251Lm9yZy9idWd6aWxs
YS9zaG93X2J1Zy5jZ2k/aWQ9ODQwNTIgVGhpcyBidWcgaGFzIGJlZW4gY2xvc2VkIGFzIGludmFs
aWQgdGhvdWdoIHRoZXJlIHdhcyBhIGNvbnZlcnNhdGlvbiBiZXR3ZWVuIFBhWCBtYWludGFpbmVy
cyBhbmQgR0NDIGRldnMuDQo+IA0KPiBJIGFzc3VtZSB0aGlzIGlzc3VlIGhhcyBiZWVuIHRoZXJl
IHNpbmNlIHRoZSByYW5kb21pemVfbGF5b3V0X3BsdWdpbiBoYXMgYmVlbiBhZGRlZCBpbiBrZXJu
ZWwuIFBsZWFzZSBjb3JyZWN0IG1lIGlmIEnigJltIHdyb25nLg0KPiANCj4gUGxlYXNlIGxldCBt
ZSBrbm93LCBpZiB5b3UgbmVlZCBtb3JlIGluZm9ybWF0aW9uLiBJIGhvcGUgeW91IGFyZSBhYmxl
IHRvIGZpeCB0aGlzIGlzc3VlLg0KPiANCj4gVGhhbmtzDQo+IEtlZXJ0aGFuYQ0KDQoNCg0K
