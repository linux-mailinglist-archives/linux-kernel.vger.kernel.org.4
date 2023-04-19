Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9F96E7660
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbjDSJfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjDSJe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:34:59 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F90C10D2;
        Wed, 19 Apr 2023 02:34:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyRp3N5MwqXkY2mcuZ1KPN9ScgULpADuxAOlrbXD3MFaG+NGPLS/x1n1PHA4f2wayQF1TkK5ZfF2ls8eYoLDuZNGLaQUhw6NvbC3HoGUspEp2jcBOJIKghYcXjB7F1y/qyE/m2SUFt08bNhi3RStr8l7fZvHjAiLX0Xb7dPCUx6gknKH8V/QvXzR95Nz6s69wrDhIt7scVYnssuXcK3ZakXI0tfLkxRXRf6avhJATN/IrYFOU8YDIyEIEi108v6OlmCc+ouDsgwZrBStxPocXTAls874BLjgeygBGSRwLsxocVbA3JCHpeFYn/4o4aja1bFaCjKN6ESKgAaJepGp1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPr6GAjFx0KQRkZf0MXPBIcPapd9YT6OAspJ/FX0SqU=;
 b=mUjXEGbSC5psX0S/LTJc1fx+GKJdzxcKlOu3pH1olqs5dzuJuw++C8qjoXuRxBMIaugRiBTtNBrH2LyWrXGsftdUoSdKOCmqMPUA11AYEU50kSzU/dW8gQd09ZIJN8qoNaYR3KOWvwm+0iDq51BdrQi13vjOMjeIbAF0UxphpOGRO2lDzltFrWbGJnpTaPlT9ii+itGVTqO89LBwSC8ATdNKGAFmRBv/wyaxzGTQ4QNr1NPJRcjSKdVbbd/Exnr91tMGmH3jOwLXLl+UWMFXPqcX6rmpOYDmoKilN5M+EVfTMpopUfXVgF/Sm0SUC6Bg1jiGJHlGSR71cM229AeCNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPr6GAjFx0KQRkZf0MXPBIcPapd9YT6OAspJ/FX0SqU=;
 b=cmLGFz0JDRlQaNtDjKP3z1dfrVvECwMYremsI5UAr0I+jsnyQfP6Ygw2t57HsT/oSXjD5vrvQYpwKUPIdX3gQaoPw7IiU2sWOAC3oiZeFxqT45R9+7hVn78bvF8mNxc+5CBUCq4Fr1T/6oM6WziBDiXW6XhRjYzrZvMm8m063d3PBc3bn3cqzBueG3HsQsWFx2+nbqbnvSUga4MApvuSBRXLohhhEiHKImcMTH2FQsNdMyMHKIgeCQhFqp5LvckbAqj1JPQ2TExJMVOygn55eb5q1MiJ4I3X0OL1qgFGZjbquHAhzSmOLfQ2A5aq1xOYaAG4KgYxkEQvG/rq2cHQbg==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by CY8PR12MB8213.namprd12.prod.outlook.com (2603:10b6:930:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 09:34:55 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::bff7:b47d:5567:71c1]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::bff7:b47d:5567:71c1%3]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 09:34:55 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [RFC v1 0/1] nvme testsuite runtime optimization
Thread-Topic: [RFC v1 0/1] nvme testsuite runtime optimization
Thread-Index: AQHZcpzgQRAsytyJiEWmAIUqEW+1V68yXyyA
Date:   Wed, 19 Apr 2023 09:34:55 +0000
Message-ID: <f0d2ddd5-37d6-8fba-a5e3-965fb9f41474@nvidia.com>
References: <20230419085643.25714-1-dwagner@suse.de>
In-Reply-To: <20230419085643.25714-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4659:EE_|CY8PR12MB8213:EE_
x-ms-office365-filtering-correlation-id: 96762fbd-2f7d-416f-505d-08db40b955ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +/3lRZR5qFEKIT5OGlg2A89cN195dVJNUUEb969IRNTuXqfK88nZROpWZPGyI/ieVb8LdPrBTpFtKq8EwMF7nIyzUPs2fWr2LLW0DuGucv6ykAmNt4//Kz/y4HKtMobkGELYG5VRrMsY/ENw40MHzPOs5NTpuRU6brpbuRC0O4Jnhji0PXvO31QUXvZvylB73uGxg0f5G3iGXuQxbncbknVxGRFbuYRC3ytpfiD23XYEEba43c1w8NXs5bsi7vJmMPwTByG8XWQ6zuxObpkH9sJAOFZCj3neU97TusSjCl+Ww6HJ6ksXY81H1POAYvejctUnuocZRbEqgBmy2eLJRPJyHilbNmHwcJhRuKciyk+LMxtENNzJJ33bTJaK43TrjCpVvpGIYEdQFnvrGO7qwUgQ2BxhDzLsuuWYblKUHC87olNWcF8NjxYuNog2UM4AXxPa8VBvF22/tvS2V0EF8V3FL5Keaa8As2YfmwEozUjtR/LvkjdxgBxRqzINV8R78mRPzoeKo5Nmry9Dwsuz6VWS1XJnkxSYr/CXdeiUl6kV6h02JD3SB4fvDXMgBsQTdDsw5m9s8W6QuQir/RWprCFxY9J2kl/iI49slwo3kk+L4F61xSkycQ77XqurmshjcbTr8iOO99sx7SLFiOUYmKDHtN8hJD5qQZo5JY6wrRzKSJ8Uhn6351iQlOIQTXl8Hitz2iK7D9frVT8ZrRYWZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199021)(86362001)(31696002)(36756003)(83380400001)(66476007)(4326008)(110136005)(316002)(91956017)(66446008)(6486002)(66946007)(54906003)(64756008)(76116006)(8676002)(66556008)(41300700001)(478600001)(71200400001)(8936002)(5660300002)(2906002)(38070700005)(186003)(122000001)(38100700002)(53546011)(6506007)(6512007)(2616005)(31686004)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZSt6RWVkTXc5ZEFtMlpmY3BzTGxSTm9TRFpmZFNjQjA1Ym13cmxpdHBSOGdM?=
 =?utf-8?B?bTduaFlLcDJuTlMyenZ6VWJrUitER1JRSUZTT2VTT1J5M2ljc2s4NnFQTVk2?=
 =?utf-8?B?R2JWVzlIa1pENW9EcnU0dFhKR3FYdGFkODBCR0JHZnhVVWRZdVhMRVNMTnFY?=
 =?utf-8?B?dG94c2tFbmkwV1JkY01kckRzMWliNmlxU3NRUCtMQURYR1E1enoyWXVZY3FK?=
 =?utf-8?B?and6dVhZRkVLWG00RXUxSy9naTljOUVkZVJmK3NGSTZtUGdzWXh3UXp6WHBU?=
 =?utf-8?B?cndZRm1VblVSdkY5VngwbEdzRmNibWFXbElkdGZ2ZjFFdFBycEZmK3NRcldx?=
 =?utf-8?B?TkhLQjErTzdkOW5nVU14QWhES251ZnkyU1Znb2NEb0x5bXJLdlAzbzhSSWZm?=
 =?utf-8?B?ZWl0YVVudWRkNkZWQU8xVVVtbmkwWGRpSHprdW9SQlNYMUJLT0kxd0c2c3F4?=
 =?utf-8?B?V3F3T1NHeGhtV3BscjFJaC91ajZHSWYvTU4vNnNtTUJIVnpiZURnQzNESi85?=
 =?utf-8?B?dDFsQ0RUaDFhYVlFTndoU2F6bldNTGdFM29vajd1dEt0d2ZHZ3V1by9YRVUr?=
 =?utf-8?B?NzdGKzVwZEVXcDNkNGR2dk4xcjFyRXNCUGZUbDM3bkJUc0NsT051Y0gvUEFR?=
 =?utf-8?B?WG1URnlEZ2RuZ2NzZWI3SEtHK3BaTEgrMDhQcmg1WSsvRDBPYU9aZGF4WjR2?=
 =?utf-8?B?WVFoQTFyRysxUzdQVGpKUTRWTVR4RjNMa0hQVThDMEdLNkorcWRmUXQ5ZkFS?=
 =?utf-8?B?dzdTcGxDakVpbHpqVWRlUVhrRGFUWFV0enlQalU2THkwbytzRDh2dzY2MWx6?=
 =?utf-8?B?d1ZRRGxnZ2pVbUhiSi9hV2ZxSnpBUGtFWVE1T1FEV0hkREhlcmhRMUpublF4?=
 =?utf-8?B?dHFVSWYrSFZ4UGd3YXR3TkwvNDZteU44TUpqdmJISEdDNlM5QTV0ajVoMHJi?=
 =?utf-8?B?STJRK1BhdFg4R3lUR3JNTTVhc1Q0RXNsNXprY3Q0TUQ4bFFRNDhiNWhESjJw?=
 =?utf-8?B?a1hhbjA2NS9KWTZqSFI1ajBMNVZLbXJmSWU4NG1pSVl6MjUzZUxTRW93eXVz?=
 =?utf-8?B?WnpZTEd0NG13TCs3NlY1YUtSYk1ia3R5YlY0c2R3YjFVNFdXOTJoK0ZaS0Jt?=
 =?utf-8?B?UlFYbmNxSW44RzVxYTRjQ2FINXl6ampMUnFVMkRrNjJEejR4TjdNdU5pTUxT?=
 =?utf-8?B?cUU5dHlkL0hWcDdBZ05KU2d3OWdub3h5YUtWcU9TdnIxcDVqeUQ4bTNPRmc0?=
 =?utf-8?B?dVRibjMvV3BrZTBSNVMvcUNGTTVDOENpYnRhTmtaWG1qSkkwK285MWZKUkEy?=
 =?utf-8?B?NitqVS9iUWl1R1hjL1l6WjZiam1va0RBNnpMazFabnRjbkJxdWJ1MlBsanFy?=
 =?utf-8?B?czArMnQ0c1locis2dnErdkYrTXJTOHg4T3p0VXBmcUx0QjR6N0V6Z1ZqK1dL?=
 =?utf-8?B?T0FUVTQwUUlrWjV1RUJERHFpWDZtN1pPR3BQZnVQRDBOd3RDSGphZlNJM2NN?=
 =?utf-8?B?ZVdldi84dG1IUTdLUEF0cGZZU1hVQ3pobDJxWUhZVTFUeGE0cTg1Sk82OG9n?=
 =?utf-8?B?dzdlUUZXR1VjYnVOV3B2eEN6RGMzdytUK2h5ZkJrWnhJZW5VQnVveDFvVWEv?=
 =?utf-8?B?bWxsbjJaMTdCN3VhcmxkUnk2UEJkRjI5VkhoVzdFVTM5U1UzbVRVU2ZxQzVB?=
 =?utf-8?B?bjlRTTdCMlMwMTM0YS9LS1hacUwveDYzV3dua0tZVFJmWnNyNGx5SkhOaHAx?=
 =?utf-8?B?eDFZc0VnOXRMUzROWk5Kc0FjN3pZclpUZmNNbndiWmlBTFZjZWYxT3ZBSDJt?=
 =?utf-8?B?MUtyUXpzRTVCKzhvVy9KdWhTb25sbmFhYllTSU5EcHYzSUV6NGJMelN0YVF5?=
 =?utf-8?B?dXJQaEVrRnJKT3BsN0VSZmRXd0dxYllaZFVYTkYwY3d6TERIaTAzS0FobGVt?=
 =?utf-8?B?NlBwZkhzc1NyREpESEYrMlBJZFl4dGpZaWo1RjRzSXBRcmVHVGgyOEFZb05w?=
 =?utf-8?B?M3RIVVlwUk0wRnhxc3JieGNRdVFLdUxPT2g2SHBwckRENGdqUXY0Z0cxOFd0?=
 =?utf-8?B?RVZWVkJLeFBhbVNTYnorZlRnUnVjb05halRpcm9jUXBxdWJLWmFZdlZqem5a?=
 =?utf-8?B?eUs2Z2VGOWoxQm4yM2djTStxNk41TnVNMm1yZ29rc2hOdU5tM0E3TjN6TzlT?=
 =?utf-8?Q?ieiUyAsvEhobjqjXx3MSZ8k7IVPBgmlivdMldTEE+KLh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BA1D988530FE9489E6A048E44ECB386@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96762fbd-2f7d-416f-505d-08db40b955ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 09:34:55.7002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n23OrlTRXPXBLNECs5Z1vdYYJKQV2qnN5z2SFKdo8fuNhfI7oytN3oljN3Ebf0oVbKgwt5AH3KBULn5yH3NGGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8213
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xOS8yMyAwMTo1NiwgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4gV2hpbGUgdGVzdGluZyB0
aGUgZmMgdHJhbnNwb3J0IEkgZ290IGEgYml0IHRpcmVkIG9mIHdhaXQgZm9yIHRoZSBJL08gam9i
cyB0bw0KPiBmaW5pc2guIFRodXMgaGVyZSBzb21lIHJ1bnRpbWUgb3B0aW1pemF0aW9uLg0KPg0K
PiBXaXRoIGEgc21hbGwvc2xvdyBWTSBJIGdvdCBmb2xsb3dpbmcgdmFsdWVzOg0KPg0KPiB3aXRo
ICdvcHRpbWl6YXRpb25zJw0KPiAgICBsb29wOg0KPiAgICAgIHJlYWwgICAgNG00My45ODFzDQo+
ICAgICAgdXNlciAgICAwbTE3Ljc1NHMNCj4gICAgICBzeXMgICAgIDJtNi4yNDlzDQo+DQo+ICAg
IHJkbWE6DQo+ICAgICAgcmVhbCAgICAybTM1LjE2MHMNCj4gICAgICB1c2VyICAgIDBtNi4yNjRz
DQo+ICAgICAgc3lzICAgICAwbTU2LjIzMHMNCj4NCj4gICAgdGNwOg0KPiAgICAgIHJlYWwgICAg
Mm0zMC4zOTFzDQo+ICAgICAgdXNlciAgICAwbTUuNzcwcw0KPiAgICAgIHN5cyAgICAgMG00Ni4w
MDdzDQo+DQo+ICAgIGZjOg0KPiAgICAgIHJlYWwgICAgMm0xOS43MzhzDQo+ICAgICAgdXNlciAg
ICAwbTYuMDEycw0KPiAgICAgIHN5cyAgICAgMG00Mi4yMDFzDQo+DQo+IGJhc2U6DQo+ICAgIGxv
b3A6DQo+ICAgICAgcmVhbCAgICA3bTM1LjA2MXMNCj4gICAgICB1c2VyICAgIDBtMjMuNDkzcw0K
PiAgICAgIHN5cyAgICAgMm01NC44NjZzDQo+DQo+ICAgIHJkbWE6DQo+ICAgICAgcmVhbCAgICA4
bTI5LjM0N3MNCj4gICAgICB1c2VyICAgIDBtMTMuMDc4cw0KPiAgICAgIHN5cyAgICAgMW01My4x
NThzDQo+DQo+ICAgIHRjcDoNCj4gICAgICByZWFsICAgIDhtMTEuMzU3cw0KPiAgICAgIHVzZXIg
ICAgMG0xMy4wMzNzDQo+ICAgICAgc3lzICAgICAybTQzLjE1NnMNCj4NCj4gICAgZmM6DQo+ICAg
ICAgcmVhbCAgICA1bTQ2LjYxNXMNCj4gICAgICB1c2VyICAgIDBtMTIuODE5cw0KPiAgICAgIHN5
cyAgICAgMW00Ni4zMzhzDQo+DQo+DQoNClRob3NlIGpvYnMgYXJlIG1lYW50IHRvIGJlIHJ1biBm
b3IgYXQgbGVhc3QgMUcgdG8gZXN0YWJsaXNoDQpjb25maWRlbmNlIG9uIHRoZSBkYXRhIHNldCBh
bmQgdGhlIHN5c3RlbSB1bmRlciB0ZXN0IHNpbmNlIFNTRHMNCmFyZSBpbiBUQnMgbm93YWRheXMg
YW5kIHdlIGRvbid0IGV2ZW4gZ2V0IGFueXdoZXJlIGNsb3NlIHRvIHRoYXQsDQp3aXRoIHlvdXIg
c3VnZ2VzdGlvbiB3ZSBhcmUgZ29pbmcgZXZlbiBsb3dlciAuLi4NCg0Kd2UgY2Fubm90IGNoYW5n
ZSB0aGUgZGF0YXNldCBzaXplIGZvciBzbG93IFZNcywgaW5zdGVhZCBhZGQNCmEgY29tbWFuZCBs
aW5lIGFyZ3VtZW50IGFuZCBwYXNzIGl0IHRvIHRlc3RzIGUuZy4NCm52bWVfdmVyaWZpY2F0aW9u
X3NpemU9WFhYIHNpbWlsYXIgdG8gbnZtZV90cnR5cGUgYnV0IGRvbid0IGNoYW5nZQ0KdGhlIGRl
ZmF1bHQgdmFsdWVzIHdoaWNoIHdlIGhhdmUgYmVlbiB0ZXN0aW5nIGZvciB5ZWFycyBub3cNCg0K
VGVzdGluZyBpcyBzdXBwb3NlZCB0byBiZSB0aW1lIGNvbnN1bWluZyBlc3BlY2lhbGx5IHZlcmlm
aWNhdGlvbiBqb2JzLi4NCg0KLWNrDQoNCg0K
