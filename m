Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D26650EB2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiLSPe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiLSPeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:34:50 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E281E31;
        Mon, 19 Dec 2022 07:34:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMPnrOB7HkluFpB+OuwP3wCphDD+hUefXJVXstGqJLBaDatV7U6eyeLYCLIblF1EY3HheX6NhjWhitG0+nmJB1Mfx+rmgDVQASTAuDHCo0gTf+lfAVyecEqBS0xTOsbfVu2A2Bakbln4RCfPC12/Im1uZfEDGyF61d4+RHbLf5BHnXDjMJk3+A28HV13WyDJuyjLFka6V8nSfB3ryKm6vqVMRrKK8/nOfto3r4Am+nTCzDVkzJ+tN8JQ6Wz/sEzjuBdtPvfN/7yeAH/exG80aW0qI4pM30R/J2vjtVheb78+FQOGGyHnODjrmxziYrpLYrphgnKIBOx2ua01zloYQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPQVdlfgAJF1GsBgvrzV9YW5+S3YU7fk17KDREytwro=;
 b=WIcRMtrLIzFxS/JqLNe+vrxBHnGjdTLJA4xzJdkMCOeIKugxD2eucq+ij8ZqKwO+jD7+b5LmsNrSK2y+4kEdw7jJGrRtJbqGbu6anMFTwzPi5+1K0e/vrDlETqswoCBQEQwdqPJam10K6uwcRBRNl6fPewemt9e5+JAm6KVqLY186B4w3dBcC+ttgowoS7YDQTgrvBVXdPhYViOeaG/zY4h4Y2XvgYK6DYKE1W2pxwwLCiRWwVfUpA6FLMINpozz2nGoEenktExFL8O9zla//83R+Jt7RUVgymjRtWCOlXHijwVgKm44SPzsoXSeX5tZE8O9jyiXfqQdKwbuECDzcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPQVdlfgAJF1GsBgvrzV9YW5+S3YU7fk17KDREytwro=;
 b=KDBxIrd3ch9tEm2ct+7uCCb6eO9WfZQ5U/9cescQCDlhp1nS/Xp57wWjpb5uRg5D5H6zQd27jTG/jUR4ymUjkk6TWeZwTK/G/YdZGvQlWmITzo7zsJJHCWo3C3mqPtstNnK7sSLmoIHBOnyzPN1kA63IdFhI1vq9+welYDAOgxI=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW4PR12MB7310.namprd12.prod.outlook.com (2603:10b6:303:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 15:34:46 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%5]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 15:34:46 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "eranian@google.com" <eranian@google.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>
Subject: RE: [PATCH v9 05/13] x86/resctrl: Detect and configure Slow Memory
 Bandwidth Allocation
Thread-Topic: [PATCH v9 05/13] x86/resctrl: Detect and configure Slow Memory
 Bandwidth Allocation
Thread-Index: AQHZBZq1Zx/tNGrR0U6kPUUy9KSweK5vRgIAgAYthYA=
Date:   Mon, 19 Dec 2022 15:34:46 +0000
Message-ID: <MW3PR12MB4553D743F85EAF41BF5260CE95E59@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
 <166990899399.17806.8574636266624372983.stgit@bmoger-ubuntu>
 <392f2e9a-27d0-15c9-923d-6c829c6ae5fb@intel.com>
In-Reply-To: <392f2e9a-27d0-15c9-923d-6c829c6ae5fb@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-19T15:34:22Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a9979efd-429e-455b-be75-0a0bd97c46ec;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-19T15:34:45Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 79150149-0169-464c-8f82-ededf14126df
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|MW4PR12MB7310:EE_
x-ms-office365-filtering-correlation-id: e2068385-6230-453b-f086-08dae1d68f2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Yt33l4D1QMZ8afIS3ONUHZ7S3SIGmYjXLnPY4Q/WZMH/jj7taLq5m5axMjuDBEwro4lG7mwHAMXsg3qAl1hBgOoZyVl7jJFmwjqUPpSHch7fX2pSssBZi8BcevDcHpeyPQjNUxIBJ8S9wg4J1/rk9GC/MZc+OmmjSCuKh73KoKqiTUaRIQrGZCpPd+zOhrhRJA10gZ/AvIL/SqmcFShYqzENL3gYiGGr7oOKTkT5Tk7nPd9kgEwMuVGxKjdytXVI/G0YxsFlct4csYB0Z8tL//WTzJDLDohXFFk0L3vNw2rpu0Sk7Hr7tfkBJW+MlriEPqdFY1g+CwYRvmqaXdh9O6slAeUx5Hg+/P0dc0nnrU3jNV3+TIOAqu93sLIrlS/cH6mMlazpezVGuj+0VeqvIiFiGSGVdCUpJ7/WqJVxdoU6Mo7jN9JUqDk2CY50CrfIrGwyxZeZ086xNJ38BOfoAiM5absoeYR9/YHE7tBmlGsVh4RqXO9OSoGZ71mDzY95gSYh6LZwZ+aX+AnT7Yml6qn9z9RY0T4cQqYYUfK8mnuE7KKrzGwQVmMuGCpYaisa7mHpScfvKzjtrULz+fTzUm7YC0M9cKk9r2zBGCi2Rze8xSp04FF5Y2xvWlcXt1+BYL/c4cxbQfytmJinshgfVwavIp77NNRb0gInEzyhhtzM+Or0YsJWFJGRkV+8YAjuoRow1xJT4i8yqRGNuE+sw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199015)(55016003)(33656002)(7416002)(66946007)(4326008)(64756008)(66446008)(66556008)(76116006)(7406005)(83380400001)(8676002)(5660300002)(66476007)(52536014)(8936002)(7696005)(53546011)(6506007)(71200400001)(478600001)(110136005)(54906003)(316002)(9686003)(186003)(26005)(41300700001)(86362001)(38070700005)(2906002)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHkzaTRvMUJWVldhVHlSckRzNDdaSWdJUjZOcXZOZ2U1amF4WUx4UWx6SkdK?=
 =?utf-8?B?TUJaekdGMEMwblF4enRmbVRaN0ZjSGdQTi90SzdEdE9aTGhOeldVUU9nZnFO?=
 =?utf-8?B?aGdoUkpBK0xqWjMxR3lwWU8yRnAzUzFkOUw4RSt5MW5SOVZhc0VCbUJTQTdx?=
 =?utf-8?B?OWpuckp2T3ZnM05IVEhQM3lrWlo2RmxuSC85T1U1RUxQMmZWUmN5cWhkZ09X?=
 =?utf-8?B?Uno0SXNGKzZTd3VnTzdHTGx3N2UvS21qZjVodXNCL1g4RGxrUFBqTjhLTlpW?=
 =?utf-8?B?cFp6L2hNTFVzVjFnTTlqODM5S2JvekVCQkhCRDYyRUhtZzdvTzhqU3NLT0k5?=
 =?utf-8?B?Nkt3Y29ZRnhDdW1jY3VPNEVXRE9hSWxpa2JDWW85N0ZBVjUwamp0c1pnL3FU?=
 =?utf-8?B?Q0hJazIrcjZUa0h5NXJBTDY1Mm1rd0V1NDlXSDhlR0xxT3VyZ0ZSK2hlUTlk?=
 =?utf-8?B?UlZBU0ZBSzZZNUtvYWlqRERKVkpqcWxsdzhGQUFyREh4ekYzMHNHQXk2bHBw?=
 =?utf-8?B?bVRQMFJGTHFsQm50c0lydXpRQUEvL00yZzFiZlcyemNJRnBIYnJnWEhqN1JJ?=
 =?utf-8?B?L3hEMlZJOW9teVgwVVhxS3dkdURlR0RZSUlJb0ppa043YnBxcGx5cWtmZkNk?=
 =?utf-8?B?dHN4bGlvS1gxS3NzdTFpeG9ORjhvMU1SZ0xtSFB5bStTY1M2VW44alJDMWxS?=
 =?utf-8?B?WnpDTHFmc1pudUprQk5ueVkycU56TzZKUVhyTFZZME9IekdTUW9WMzQ0OVNZ?=
 =?utf-8?B?WEtmZUppOFpENWdPZGs4ZTlnWERoR2VLdkVxNzRYQVdJUGJPT0d6U0JaNTVC?=
 =?utf-8?B?UkJObVptdXh6MXZMaStLUkNzZ1RVYmdBTmgvdkRyUkNaSlNDc0dFU2VRVTJX?=
 =?utf-8?B?NS9tTkJQazJYVmVqdkxQVUYyNk5SM2x2aWxKczYyaWppanBWRlFkOUo3S05Q?=
 =?utf-8?B?dFN2WGJDcUcyMnB0WTBCYzVrUXJqZkFycXBna28zaHdkbHp5MnFqdG81ZnVG?=
 =?utf-8?B?dE8wWkVZMGFDUWovUjZXenhCQ2tGbFVQT3RtcFE2RlphSU82RCtadWNMRHcv?=
 =?utf-8?B?ZVFwMHczWVNiRmxpQjBpakoweU5lZkVDMGw0QkVvd29mV2ltQnVpRE5GV1Yv?=
 =?utf-8?B?NlBGZURLV1M0WUwwaW1TTXFMV0c5Q0huVkFmMkpyaFplUHVPai9LMDVMWTBP?=
 =?utf-8?B?T25HRSswTEZPNWlEY1VKanRFRGNOMXNDeHQ1RVM1cHgwR3dIb2E1ZmdkdzdZ?=
 =?utf-8?B?REtaS3ZxVlhVbFVIeTdXakg5YlNSSGpPbW5JQjcrQWZrZ21TREZsaWdvNUxZ?=
 =?utf-8?B?QmY3WFhhekdGTC9pem95L0FmWnQxOEtKeU1mdllPTGVyTWk4N3VTSkxkaW1P?=
 =?utf-8?B?WnZQZndadkhscmh0SGhjVVZFK1ZMOXU5djNZeGhaWnlpdVdZcFA0OWYxNmlV?=
 =?utf-8?B?TXdIdnFnYzVHbzNBTmNKdEltSnVCSEpoWDlxUFdxWG1JcDhySEU4eXhqR1Bt?=
 =?utf-8?B?V2hDcTF5ZmFMajI3TjFGQy8wSkdxR3pKdXRJbWh4U1lUMkNEY0ZGaHFETnFQ?=
 =?utf-8?B?VnR2Q2ZMcnFySXIzSURPR2w0SWVZOTVaaHdjanhqR05VU2g2M0d5NDN1TWpF?=
 =?utf-8?B?d21pank4aExzZVN0dkswUS9HaHltRmdpdm1SZWJKVTFHSGFKR3pIeTRxMHU2?=
 =?utf-8?B?WjFhaGtEb1NRTlo1SVAwMFZlSzZab0xuZHI2THA1MmFadkcwK29BK0RSYTRE?=
 =?utf-8?B?cGNLWlp4K2FMSzlDSlRXQ1oyV0ZQN1lOM1VCeEJ5N2ZFdHpVU2thanpKeHlR?=
 =?utf-8?B?RlR1cUExQ3ZDbmpCVnRWSmhURUY4WWplaEZlVGRlSklsRVBiT1V2MjlmT2da?=
 =?utf-8?B?QnlFNWZzaDJNelJpNU42Y2dHSGcweVM5eWk4aXZEMUlMbVRhMVpwdFRFTkp6?=
 =?utf-8?B?aERFbFRNVDBFUkUvU1lTVnVETlBxRXNHTHc5M3U2dlJQaTU4ZDAzM1V3S3py?=
 =?utf-8?B?Z0hWMG9BVzVwZDNOdzU1T2NUeS9kVXRTRHI4QWF5bitoa0NocU5aMGVqa3NW?=
 =?utf-8?B?N0NVOUl0T1RzRG11cEdFcCtUTmZWVDB3NVJhNmFwc200RlE0RnpzNkh4K1Rr?=
 =?utf-8?Q?yHdo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2068385-6230-453b-f086-08dae1d68f2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 15:34:46.7412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t3BtedAD6IybostQQXDWOxlPpett7xfv99dGkL3qjngA9UkwKgMnPsyUOjkNo/Lo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7310
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFJlaW5ldHRlIENoYXRyZSA8cmVpbmV0dGUuY2hhdHJlQGlu
dGVsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDE1LCAyMDIyIDExOjE0IEFNDQo+
IFRvOiBNb2dlciwgQmFidSA8QmFidS5Nb2dlckBhbWQuY29tPjsgY29yYmV0QGx3bi5uZXQ7DQo+
IHRnbHhAbGludXRyb25peC5kZTsgbWluZ29AcmVkaGF0LmNvbTsgYnBAYWxpZW44LmRlDQo+IENj
OiBmZW5naHVhLnl1QGludGVsLmNvbTsgZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tOyB4ODZA
a2VybmVsLm9yZzsNCj4gaHBhQHp5dG9yLmNvbTsgcGF1bG1ja0BrZXJuZWwub3JnOyBha3BtQGxp
bnV4LWZvdW5kYXRpb24ub3JnOw0KPiBxdWljX25lZXJhanVAcXVpY2luYy5jb207IHJkdW5sYXBA
aW5mcmFkZWFkLm9yZzsNCj4gZGFtaWVuLmxlbW9hbEBvcGVuc291cmNlLndkYy5jb207IHNvbmdt
dWNodW5AYnl0ZWRhbmNlLmNvbTsNCj4gcGV0ZXJ6QGluZnJhZGVhZC5vcmc7IGpwb2ltYm9lQGtl
cm5lbC5vcmc7IHBib256aW5pQHJlZGhhdC5jb207DQo+IGNoYW5nLnNlb2suYmFlQGludGVsLmNv
bTsgcGF3YW4ua3VtYXIuZ3VwdGFAbGludXguaW50ZWwuY29tOw0KPiBqbWF0dHNvbkBnb29nbGUu
Y29tOyBkYW5pZWwuc25lZGRvbkBsaW51eC5pbnRlbC5jb207IERhczEsIFNhbmRpcGFuDQo+IDxT
YW5kaXBhbi5EYXNAYW1kLmNvbT47IHRvbnkubHVja0BpbnRlbC5jb207IGphbWVzLm1vcnNlQGFy
bS5jb207DQo+IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7DQo+IGJhZ2FzZG90bWVAZ21haWwuY29tOyBlcmFuaWFuQGdvb2dsZS5jb207IGNo
cmlzdG9waGUubGVyb3lAY3Nncm91cC5ldTsNCj4gamFya2tvQGtlcm5lbC5vcmc7IGFkcmlhbi5o
dW50ZXJAaW50ZWwuY29tOyBxdWljX2ppbGVzQHF1aWNpbmMuY29tOw0KPiBwZXRlcm5ld21hbkBn
b29nbGUuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjkgMDUvMTNdIHg4Ni9yZXNjdHJsOiBE
ZXRlY3QgYW5kIGNvbmZpZ3VyZSBTbG93IE1lbW9yeQ0KPiBCYW5kd2lkdGggQWxsb2NhdGlvbg0K
PiANCj4gSGkgQmFidSwNCj4gDQo+IE9uIDEyLzEvMjAyMiA3OjM2IEFNLCBCYWJ1IE1vZ2VyIHdy
b3RlOg0KPiA+IFRoZSBRb1Mgc2xvdyBtZW1vcnkgY29uZmlndXJhdGlvbiBkZXRhaWxzIGFyZSBh
dmFpbGFibGUgdmlhDQo+ID4gQ1BVSURfRm44MDAwMDAyMF9FRFhfeDAyLiBEZXRlY3QgdGhlIGF2
YWlsYWJsZSBkZXRhaWxzIGFuZCBpbml0aWFsaXplDQo+ID4gdGhlIHJlc3QgdG8gZGVmYXVsdHMu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCYWJ1IE1vZ2VyIDxiYWJ1Lm1vZ2VyQGFtZC5jb20+
DQo+ID4gLS0tDQo+ID4gIGFyY2gveDg2L2luY2x1ZGUvYXNtL21zci1pbmRleC5oICAgICAgICAg
IHwgICAgMSArDQo+ID4gIGFyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9jb3JlLmMgICAgICAg
IHwgICAzNg0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPiA+ICBhcmNoL3g4Ni9r
ZXJuZWwvY3B1L3Jlc2N0cmwvY3RybG1vbmRhdGEuYyB8ICAgIDIgKy0NCj4gPiAgYXJjaC94ODYv
a2VybmVsL2NwdS9yZXNjdHJsL3JkdGdyb3VwLmMgICAgfCAgICA4ICsrKystLQ0KPiA+ICA0IGZp
bGVzIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vbXNyLWluZGV4LmgNCj4gPiBiL2FyY2gv
eDg2L2luY2x1ZGUvYXNtL21zci1pbmRleC5oDQo+ID4gaW5kZXggMzdmZjQ3NTUyYmNiLi5lMGE0
MDAyN2FhNjIgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vbXNyLWluZGV4
LmgNCj4gPiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc3ItaW5kZXguaA0KPiA+IEBAIC0x
MDYxLDYgKzEwNjEsNyBAQA0KPiA+DQo+ID4gIC8qIC0gQU1EOiAqLw0KPiA+ICAjZGVmaW5lIE1T
Ul9JQTMyX01CQV9CV19CQVNFCQkweGMwMDAwMjAwDQo+ID4gKyNkZWZpbmUgTVNSX0lBMzJfU01C
QV9CV19CQVNFCQkweGMwMDAwMjgwDQo+ID4NCj4gPiAgLyogTVNSX0lBMzJfVk1YX01JU0MgYml0
cyAqLw0KPiA+ICAjZGVmaW5lIE1TUl9JQTMyX1ZNWF9NSVNDX0lOVEVMX1BUICAgICAgICAgICAg
ICAgICAoMVVMTCA8PCAxNCkNCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9y
ZXNjdHJsL2NvcmUuYw0KPiA+IGIvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL2NvcmUuYw0K
PiA+IGluZGV4IDEwYThjOWQ5NmYzMi4uYjRmYzg1MWY2NDg5IDEwMDY0NA0KPiA+IC0tLSBhL2Fy
Y2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9jb3JlLmMNCj4gPiArKysgYi9hcmNoL3g4Ni9rZXJu
ZWwvY3B1L3Jlc2N0cmwvY29yZS5jDQo+ID4gQEAgLTE2Miw2ICsxNjIsMTMgQEAgYm9vbCBpc19t
YmFfc2Moc3RydWN0IHJkdF9yZXNvdXJjZSAqcikNCj4gPiAgCWlmICghcikNCj4gPiAgCQlyZXR1
cm4NCj4gcmR0X3Jlc291cmNlc19hbGxbUkRUX1JFU09VUkNFX01CQV0ucl9yZXNjdHJsLm1lbWJ3
Lm1iYV9zYzsNCj4gPg0KPiA+ICsJLyoNCj4gPiArCSAqIFRoZSBzb2Z0d2FyZSBjb250cm9sbGVy
IHN1cHBvcnQgaXMgb25seSBhcHBsaWNhYmxlIHRvIE1CQSByZXNvdXJjZS4NCj4gPiArCSAqIE1h
a2Ugc3VyZSB0byBjaGVjayBmb3IgcmVzb3VyY2UgdHlwZS4NCj4gPiArCSAqLw0KPiA+ICsJaWYg
KHItPnJpZCAhPSBSRFRfUkVTT1VSQ0VfTUJBKQ0KPiA+ICsJCXJldHVybiBmYWxzZTsNCj4gPiAr
DQo+ID4gIAlyZXR1cm4gci0+bWVtYncubWJhX3NjOw0KPiA+ICB9DQo+ID4NCj4gPiBAQCAtMjI1
LDkgKzIzMiwxNSBAQCBzdGF0aWMgYm9vbCBfX3JkdF9nZXRfbWVtX2NvbmZpZ19hbWQoc3RydWN0
DQo+IHJkdF9yZXNvdXJjZSAqcikNCj4gPiAgCXN0cnVjdCByZHRfaHdfcmVzb3VyY2UgKmh3X3Jl
cyA9IHJlc2N0cmxfdG9fYXJjaF9yZXMocik7DQo+ID4gIAl1bmlvbiBjcHVpZF8weDEwXzNfZWF4
IGVheDsNCj4gPiAgCXVuaW9uIGNwdWlkXzB4MTBfeF9lZHggZWR4Ow0KPiA+IC0JdTMyIGVieCwg
ZWN4Ow0KPiA+ICsJdTMyIGVieCwgZWN4LCBzdWJsZWFmOw0KPiA+DQo+ID4gLQljcHVpZF9jb3Vu
dCgweDgwMDAwMDIwLCAxLCAmZWF4LmZ1bGwsICZlYngsICZlY3gsICZlZHguZnVsbCk7DQo+ID4g
KwkvKg0KPiA+ICsJICogUXVlcnkgQ1BVSURfRm44MDAwMDAyMF9FRFhfeDAxIGZvciBNQkEgYW5k
DQo+ID4gKwkgKiBDUFVJRF9GbjgwMDAwMDIwX0VEWF94MDIgZm9yIFNNQkENCj4gPiArCSAqLw0K
PiA+ICsJc3VibGVhZiA9IChyLT5yaWQgPT0gUkRUX1JFU09VUkNFX1NNQkEpID8gMiA6ICAxOw0K
PiA+ICsNCj4gPiArCWNwdWlkX2NvdW50KDB4ODAwMDAwMjAsIHN1YmxlYWYsICZlYXguZnVsbCwg
JmVieCwgJmVjeCwgJmVkeC5mdWxsKTsNCj4gPiAgCWh3X3Jlcy0+bnVtX2Nsb3NpZCA9IGVkeC5z
cGxpdC5jb3NfbWF4ICsgMTsNCj4gPiAgCXItPmRlZmF1bHRfY3RybCA9IE1BWF9NQkFfQldfQU1E
Ow0KPiA+DQo+ID4gQEAgLTc1MCw2ICs3NjMsMTkgQEAgc3RhdGljIF9faW5pdCBib29sIGdldF9t
ZW1fY29uZmlnKHZvaWQpDQo+ID4gIAlyZXR1cm4gZmFsc2U7DQo+ID4gIH0NCj4gPg0KPiA+ICtz
dGF0aWMgX19pbml0IGJvb2wgZ2V0X3Nsb3dfbWVtX2NvbmZpZyh2b2lkKSB7DQo+ID4gKwlzdHJ1
Y3QgcmR0X2h3X3Jlc291cmNlICpod19yZXMgPQ0KPiA+ICsmcmR0X3Jlc291cmNlc19hbGxbUkRU
X1JFU09VUkNFX1NNQkFdOw0KPiA+ICsNCj4gPiArCWlmICghcmR0X2NwdV9oYXMoWDg2X0ZFQVRV
UkVfU01CQSkpDQo+ID4gKwkJcmV0dXJuIGZhbHNlOw0KPiA+ICsNCj4gPiArCWlmIChib290X2Nw
dV9kYXRhLng4Nl92ZW5kb3IgPT0gWDg2X1ZFTkRPUl9BTUQpDQo+ID4gKwkJcmV0dXJuIF9fcmR0
X2dldF9tZW1fY29uZmlnX2FtZCgmaHdfcmVzLT5yX3Jlc2N0cmwpOw0KPiA+ICsNCj4gPiArCXJl
dHVybiBmYWxzZTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIF9faW5pdCBib29sIGdldF9y
ZHRfYWxsb2NfcmVzb3VyY2VzKHZvaWQpICB7DQo+ID4gIAlzdHJ1Y3QgcmR0X3Jlc291cmNlICpy
Ow0KPiA+IEBAIC03ODAsNiArODA2LDkgQEAgc3RhdGljIF9faW5pdCBib29sIGdldF9yZHRfYWxs
b2NfcmVzb3VyY2VzKHZvaWQpDQo+ID4gIAlpZiAoZ2V0X21lbV9jb25maWcoKSkNCj4gPiAgCQly
ZXQgPSB0cnVlOw0KPiA+DQo+ID4gKwlpZiAoZ2V0X3Nsb3dfbWVtX2NvbmZpZygpKQ0KPiA+ICsJ
CXJldCA9IHRydWU7DQo+ID4gKw0KPiA+ICAJcmV0dXJuIHJldDsNCj4gPiAgfQ0KPiA+DQo+ID4g
QEAgLTg2OSw2ICs4OTgsOSBAQCBzdGF0aWMgX19pbml0IHZvaWQgcmR0X2luaXRfcmVzX2RlZnNf
YW1kKHZvaWQpDQo+ID4gIAkJfSBlbHNlIGlmIChyLT5yaWQgPT0gUkRUX1JFU09VUkNFX01CQSkg
ew0KPiA+ICAJCQlod19yZXMtPm1zcl9iYXNlID0gTVNSX0lBMzJfTUJBX0JXX0JBU0U7DQo+ID4g
IAkJCWh3X3Jlcy0+bXNyX3VwZGF0ZSA9IG1iYV93cm1zcl9hbWQ7DQo+ID4gKwkJfSBlbHNlIGlm
IChyLT5yaWQgPT0gUkRUX1JFU09VUkNFX1NNQkEpIHsNCj4gPiArCQkJaHdfcmVzLT5tc3JfYmFz
ZSA9IE1TUl9JQTMyX1NNQkFfQldfQkFTRTsNCj4gPiArCQkJaHdfcmVzLT5tc3JfdXBkYXRlID0g
bWJhX3dybXNyX2FtZDsNCj4gPiAgCQl9DQo+ID4gIAl9DQo+ID4gIH0NCj4gPiBkaWZmIC0tZ2l0
IGEvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL2N0cmxtb25kYXRhLmMNCj4gPiBiL2FyY2gv
eDg2L2tlcm5lbC9jcHUvcmVzY3RybC9jdHJsbW9uZGF0YS5jDQo+ID4gaW5kZXggMWRmMGUzMjYy
YmNhLi4yZGQ0YjhjNDdmMjMgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9y
ZXNjdHJsL2N0cmxtb25kYXRhLmMNCj4gPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0
cmwvY3RybG1vbmRhdGEuYw0KPiA+IEBAIC0yMDksNyArMjA5LDcgQEAgc3RhdGljIGludCBwYXJz
ZV9saW5lKGNoYXIgKmxpbmUsIHN0cnVjdCByZXNjdHJsX3NjaGVtYQ0KPiAqcywNCj4gPiAgCXVu
c2lnbmVkIGxvbmcgZG9tX2lkOw0KPiA+DQo+ID4gIAlpZiAocmR0Z3JwLT5tb2RlID09IFJEVF9N
T0RFX1BTRVVET19MT0NLU0VUVVAgJiYNCj4gPiAtCSAgICByLT5yaWQgPT0gUkRUX1JFU09VUkNF
X01CQSkgew0KPiA+ICsJICAgIChyLT5yaWQgPT0gUkRUX1JFU09VUkNFX01CQSB8fCByLT5yaWQg
PT0NCj4gUkRUX1JFU09VUkNFX1NNQkEpKSB7DQo+ID4gIAkJcmR0X2xhc3RfY21kX3B1dHMoIkNh
bm5vdCBwc2V1ZG8tbG9jayBNQkEgcmVzb3VyY2VcbiIpOw0KPiA+ICAJCXJldHVybiAtRUlOVkFM
Ow0KPiA+ICAJfQ0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwv
cmR0Z3JvdXAuYw0KPiA+IGIvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL3JkdGdyb3VwLmMN
Cj4gPiBpbmRleCBlNWE0OGYwNWU3ODcuLjhhM2RhZmMwZGJmNyAxMDA2NDQNCj4gPiAtLS0gYS9h
cmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvcmR0Z3JvdXAuYw0KPiA+ICsrKyBiL2FyY2gveDg2
L2tlcm5lbC9jcHUvcmVzY3RybC9yZHRncm91cC5jDQo+ID4gQEAgLTEyMTMsNyArMTIxMyw3IEBA
IHN0YXRpYyBib29sIHJkdGdyb3VwX21vZGVfdGVzdF9leGNsdXNpdmUoc3RydWN0DQo+ID4gcmR0
Z3JvdXAgKnJkdGdycCkNCj4gPg0KPiA+ICAJbGlzdF9mb3JfZWFjaF9lbnRyeShzLCAmcmVzY3Ry
bF9zY2hlbWFfYWxsLCBsaXN0KSB7DQo+ID4gIAkJciA9IHMtPnJlczsNCj4gPiAtCQlpZiAoci0+
cmlkID09IFJEVF9SRVNPVVJDRV9NQkEpDQo+ID4gKwkJaWYgKHItPnJpZCA9PSBSRFRfUkVTT1VS
Q0VfTUJBIHx8IHItPnJpZCA9PQ0KPiBSRFRfUkVTT1VSQ0VfU01CQSkNCj4gPiAgCQkJY29udGlu
dWU7DQo+ID4gIAkJaGFzX2NhY2hlID0gdHJ1ZTsNCj4gPiAgCQlsaXN0X2Zvcl9lYWNoX2VudHJ5
KGQsICZyLT5kb21haW5zLCBsaXN0KSB7IEBAIC0xNDAyLDcNCj4gKzE0MDIsOCBAQA0KPiA+IHN0
YXRpYyBpbnQgcmR0Z3JvdXBfc2l6ZV9zaG93KHN0cnVjdCBrZXJuZnNfb3Blbl9maWxlICpvZiwN
Cj4gPiAgCQkJCQljdHJsID0gcmVzY3RybF9hcmNoX2dldF9jb25maWcociwgZCwNCj4gPiAgCQkJ
CQkJCQkgICAgICAgY2xvc2lkLA0KPiA+ICAJCQkJCQkJCSAgICAgICB0eXBlKTsNCj4gPiAtCQkJ
CWlmIChyLT5yaWQgPT0gUkRUX1JFU09VUkNFX01CQSkNCj4gPiArCQkJCWlmIChyLT5yaWQgPT0g
UkRUX1JFU09VUkNFX01CQSB8fA0KPiA+ICsJCQkJICAgIHItPnJpZCA9PSBSRFRfUkVTT1VSQ0Vf
U01CQSkNCj4gPiAgCQkJCQlzaXplID0gY3RybDsNCj4gPiAgCQkJCWVsc2UNCj4gPiAgCQkJCQlz
aXplID0gcmR0Z3JvdXBfY2JtX3RvX3NpemUociwgZCwgY3RybCk7DQo+IEBAIC0yODQ1LDcgKzI4
NDYsOCBAQA0KPiA+IHN0YXRpYyBpbnQgcmR0Z3JvdXBfaW5pdF9hbGxvYyhzdHJ1Y3QgcmR0Z3Jv
dXAgKnJkdGdycCkNCj4gPg0KPiA+ICAJbGlzdF9mb3JfZWFjaF9lbnRyeShzLCAmcmVzY3RybF9z
Y2hlbWFfYWxsLCBsaXN0KSB7DQo+ID4gIAkJciA9IHMtPnJlczsNCj4gPiAtCQlpZiAoci0+cmlk
ID09IFJEVF9SRVNPVVJDRV9NQkEpIHsNCj4gPiArCQlpZiAoci0+cmlkID09IFJEVF9SRVNPVVJD
RV9NQkEgfHwNCj4gPiArCQkgICAgci0+cmlkID09IFJEVF9SRVNPVVJDRV9TTUJBKSB7DQo+ID4g
IAkJCXJkdGdyb3VwX2luaXRfbWJhKHIsIHJkdGdycC0+Y2xvc2lkKTsNCj4gPiAgCQkJaWYgKGlz
X21iYV9zYyhyKSkNCj4gPiAgCQkJCWNvbnRpbnVlOw0KPiA+DQo+ID4NCj4gDQo+IFJldmlld2Vk
LWJ5OiBSZWluZXR0ZSBDaGF0cmUgPHJlaW5ldHRlLmNoYXRyZUBpbnRlbC5jb20+DQoNClRoYW5r
IHlvdQ0KQmFidQ0KPiANCj4gUmVpbmV0dGUNCg==
