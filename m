Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF356511B0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 19:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbiLSSVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 13:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiLSSVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 13:21:20 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199D22DD8;
        Mon, 19 Dec 2022 10:21:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKxVlF2C9UtOiRcygnPo63sGQE2fzv8UeFZ567sESwqJM72iB4jnAGVBg3FzwFrUp5U2djpDBeXZQ230xZrD5jDNnmypUVpjJYi88HYJMTFhNEm+rOs6mU4yu1flda0hY0D17BjGYnMchwmdatxnIfiGF4vbCvezU5bjPwbNkYpKnWzY8viJky6xzOu/UR3Gj+pEXBQ6JO6hKrhBkHQuVIdXz0Fit6dN6H9a1GKbKzk1w02sYID2N/9l8P9lQP1iwUcUoJsAv+WjqgPzjWHAMmAXpyFF36oZp3g6R4TU7wLTbcqh7+1Ji7hWPimpZPJAhr+NlIEkc6V/8LIBMlLCYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtDnubjf1vH/cdQg4uEJEHwZc+dNBuOWO7ju21QVyBY=;
 b=bKVkBeUWY4j8xTLb5+B+C02evjTIAnTDkC9soReF7x4pJg1WsTbCJ7s+224Kh0UT/Y3QaMs8YHwTe4cSEqB0B4F1zlbF+REZ+nvIViRslE/bdbecI+CwgtYUSd99t4koHeID1FGnDLWxA4/4DrIOwfjE0rwn1F0cBIB+XMlIfs2cImBuVk3pSOTmRaLwhnYc4lJpAO8hlOLvoN9+HyMvUHsxsp9xGHiSKd8b4sscFNLNTkOFSBDAz8LjmUr/OX4GBs5abpcTKgKd1Q87CjDctjX6IOXimHCCCrdsPryLz7KGRFBUk3VXcDVMuzqbYjBfRgHgVafgp9jS4DLwLRV3Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtDnubjf1vH/cdQg4uEJEHwZc+dNBuOWO7ju21QVyBY=;
 b=LdXHrqJmbw74ZQis9g5+CZnI2P0/r7tnwFI7sGJNv7i8J2VhjA6afMS4Zk6OyTSkWEnfiDRFC6GOElLsmbN8MVVZXbRz+mwdpHCZRFa39DZX5j3hog+2D6khBubCqsDKlVfzAZDCWM6usqxqauQ5LkJczbcyE0yez76tbJSHMQM=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH8PR12MB7135.namprd12.prod.outlook.com (2603:10b6:510:22c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 18:21:16 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%5]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 18:21:16 +0000
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
Subject: RE: [PATCH v9 08/13] x86/resctrl: Add sysfs interface to read
 mbm_total_bytes_config
Thread-Topic: [PATCH v9 08/13] x86/resctrl: Add sysfs interface to read
 mbm_total_bytes_config
Thread-Index: AQHZBZrLo8d/Hhppk02L8PRQxHqwJq5vTY6AgAZSGQA=
Date:   Mon, 19 Dec 2022 18:21:16 +0000
Message-ID: <MW3PR12MB4553379157EDF6DECDB3BA6495E59@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
 <166990901578.17806.14559688057407662110.stgit@bmoger-ubuntu>
 <512cd6bc-d474-6362-974f-75a690d2fa97@intel.com>
In-Reply-To: <512cd6bc-d474-6362-974f-75a690d2fa97@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-19T18:12:19Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=19680491-7fa9-46f8-8c26-5f9b4d4f21a4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-19T18:21:14Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 2f8dfe59-3b59-4a45-8e64-0ce119a152f2
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|PH8PR12MB7135:EE_
x-ms-office365-filtering-correlation-id: 122fa20d-4fe6-4b8e-af98-08dae1edd186
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mluEQ8WzHvXBbcQEQ73Q23Yt3XuLpaGcmEDkt7RCDnjyx7eLBmwfewWkwvKDZ/tOYIWRWvFQIZgjDpv4tz5XPEpjoF9xEK0Grezvw8kA7rHrRDXxBVckodHkgfhKpG+q8pHf9ooqWj6JL8FiiEp4bPcsbnfwmEYGL8CyyzzjWuvK4ii1BRpkNkJCoidnb4RRSngPkd6vpblId3DYtLXIsEdA2RAXKniYHHjQrssVoG8swh8sbfOB7WUDrG88xjDkJq6F5Tv+FPqIOnufhsq3ExgcGMg6RV5+qoY77/konguNVpnJSRalPhnZYAgDibw/bF1DNXKCr9V932R6JiP/4HA/oHfD3JPAYt2IEwUovqnky5MBsKEjqs2JGyxnbl36eLyoJD/25KMkR27a64AGNy8ggP9B+lFlACWPlU8Ke7i8oeSRobs/G6eLfKkvx5bh+TRzp6oDHafUD1hhaY+UXxrlzl23FMnawv9E7fZNUBb7RVP6MPt3yNQ98D1wXCcrcq/6NuKOhgaIw4voQ6iHfcOqaU5bhvHQ9mxe9hLO1UUIU4IUtY1BbdwlAJU7zDuvh6y5drhfyxtZ+ogMaCAv4j+ZJtC3R9btFHZHAenxgLZcAActndyqHmdPMwMqJ/zI6FSt1Ber7phg701iLle0Nxw26GvbaYMVJncVYqbbYLc3CH+ZT5zzqZn2qu71jkn9zy3APmfu4qy2CicH0WbV8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(451199015)(122000001)(38100700002)(41300700001)(52536014)(76116006)(8936002)(4326008)(66476007)(66446008)(66556008)(64756008)(5660300002)(8676002)(7416002)(83380400001)(7406005)(66946007)(38070700005)(55016003)(86362001)(33656002)(71200400001)(478600001)(2906002)(54906003)(9686003)(53546011)(26005)(186003)(110136005)(316002)(6506007)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjN5VzRLOEVNMzdhK001T2lzckJFeFRwbVppNHFLSUdKSGhyYktBazVPZXgr?=
 =?utf-8?B?aUIvMTArK1dKNnYvWXQxWmVlbEh4OG9CZlNVZjh5dGFBVGVpdVRqUEI1RE15?=
 =?utf-8?B?MDlNRnJOVS8zaDNxelUxU250OWs3em9LOWo1RVlyRmFMOXAwR1F4YmJyZitw?=
 =?utf-8?B?K20wN2FQdm9EaDJUYU9aYk9SNThBWFdOWTUxRUpwVHBPbHA5K0VIV3lwS2pR?=
 =?utf-8?B?b0hQZHRsZHJYQkVkUW1rWVhJQUREZXhHL1BsY0FhUjRPa2U5cEttZnB6NjJX?=
 =?utf-8?B?ZVlUUlRMRXpoLzE2dXhlYU9HVlpzTU81em1UamNrTGsyOUFkZzhDcUREU0U2?=
 =?utf-8?B?OG1JbnFKdVptOGVWTEJ2dDhDTXF6QS9WeGNkSXBoUm1iRjFsa2hRZkFSdDBO?=
 =?utf-8?B?RTZ6ajUvcGV1WGtxOG1OaHd1d2FtR1U1MGlZNlRaREd6R3BuSkV2a0V3Wnpq?=
 =?utf-8?B?Mit5ai8zNkJiZ1BsWFFDVkVmcE5mRkVJT29rM1UzcldUTzVwS0lvNW5PU1By?=
 =?utf-8?B?ek9hV2Q0TTQrL0FybzE5V3p2M245SG4yQ25ia1g5Tzl1NUpmRXZtb2VDSkla?=
 =?utf-8?B?M29HL1ZmTWtoZVdrWHpFUXVZdlhSeTFQellNbUx2dUFucVFlRnJRUVY5ZFp6?=
 =?utf-8?B?SS9xQVoxVzFkMXpCRy9KUUVIZFZPM09BdFhKZVg1bzM5Wk4rSlVTY3lNQXNU?=
 =?utf-8?B?c3htTFUvcmtHY0RQTlVBUTN3Wlp2SGE4SXphbGhEcEdZRGxWZ3Ric1FCRVcx?=
 =?utf-8?B?b0UyaHoxcG9sOEd6cGE2MVU4UXo3cmRnUFVNeGxJQ2srbzFEQ1VJekRoY1dV?=
 =?utf-8?B?aVpKRXdEcGw3R29Gd2VxNEJYaWxvdlpPNjRYaGh0bFdnejdhODZKYTFGRk9E?=
 =?utf-8?B?aWNSVXBJdkhSN0xzUTcxeFlLMlVnVWJ5WWxvTWlNN0dKK2JBQXBuTGJ3TFV2?=
 =?utf-8?B?WERZZlFrL2xocFNsZkE4RnAzZ285TnI4eWtCZ0VWd0svbWN0a1JDSExwVXVL?=
 =?utf-8?B?cWd1bkFqbGJnR3dhbjc3TUJhSFRraWpaakd1Q1F0dDhYbUZVRThVRi9ZSlpj?=
 =?utf-8?B?MmNKYVRDbk5iOE9wOGc4bzhJSXptU1hrUG94YVV4b1FsQTRsMDdwZ0hUZnl4?=
 =?utf-8?B?aEVxMUlTL1gyUWdiZWZsQ1l4YjJZMTFaemtCYWtBOEYrbTMwTzcxcVQxSXVF?=
 =?utf-8?B?VksvaDhGYzdBYTlzR2tObTR1WTREZG5oYkMzaWljbE5BTzNMNUhTZ1lLRVJt?=
 =?utf-8?B?T1BsckVaK3VtNEp0R09IS0N3d2ozSlpNeUJYdzFRT3Yzd1hYU1YxY0xJdjZX?=
 =?utf-8?B?WGJ5eEtEWUMrY3RvbGtscVdJeWJXVGRjQ1VBQ0NueGpTYU9QMTNoc0JEYjdF?=
 =?utf-8?B?SUgvNzRWT05xNVpWSHJFd1ZsNWZFMlFDMWI1U1M3cjNLdUFLZVV4dVlCd1cy?=
 =?utf-8?B?VUtxd0NiL0x4K3FIUWNpNkNQWEpmWHo3emwxM0JKVGdnRm53UEE3UTFYL2la?=
 =?utf-8?B?RENSRHV3RG10eDQwdy9yYUl1SXdOTzRVK0oreFkrODlOdnhEeDFpTktqem0z?=
 =?utf-8?B?SjIzYU80RjNvOEpjbStxMGVRWVJpa3pLdFhBbFo1MTBvaUxNd0ZCOEdnWHdn?=
 =?utf-8?B?Z0dVbGhxSS9PTDMwenBIUzV0c2lRSUtTZlVTUVRaTE5POHhJY1VHaEhSb1BT?=
 =?utf-8?B?WTZRbDl6MTZNVU9zSEVyYXRXblI3RmFWTWJzYUx0RHBFdUU1SEpKNmYwWVhw?=
 =?utf-8?B?Zmk4akZkZENRQ1NTbk1PMFVpUHU3M1MrNGpvbDI0TllFZGRmTmw1N1k4Y2ZL?=
 =?utf-8?B?RE5mQUp3UlZDM3JiUVJzdFdnalhUdml6Z1NoN1VId0llYXJ0d2pjYjBvRm9n?=
 =?utf-8?B?djd1dFFUSG4wNUVGWFZmVllCVVBEb3Rhdm1HcFNPVldUdDc5SEFSQmxPOTEx?=
 =?utf-8?B?VThmWC94ZE94a09ON2QwOTh5UWhaYVJKNTg2Yy9nRTRWYjNWR2l2MHh4RDFq?=
 =?utf-8?B?b1FZb0dhMGpTSEcvTmxyVGVuY1VSUnEyYjhTTnBadVFhTGtLUWNLWnROWTVT?=
 =?utf-8?B?Q2NhZ2VoS3pLTFhnUmhFTnJqSmltS2FSaFB0Y0Q0UWNNVHFJQWNVK0lwK1cw?=
 =?utf-8?Q?HOPw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 122fa20d-4fe6-4b8e-af98-08dae1edd186
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 18:21:16.4640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5bOoZoKc5PLsWYocWI+KvdC9vU87wVfvns5onO53R4rODmpYujkTHqkWZZZ7nIss
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7135
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFJlaW5ldHRlLA0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJlaW5ldHRlIENoYXRyZSA8cmVpbmV0
dGUuY2hhdHJlQGludGVsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDE1LCAyMDIy
IDExOjQxIEFNDQo+IFRvOiBNb2dlciwgQmFidSA8QmFidS5Nb2dlckBhbWQuY29tPjsgY29yYmV0
QGx3bi5uZXQ7DQo+IHRnbHhAbGludXRyb25peC5kZTsgbWluZ29AcmVkaGF0LmNvbTsgYnBAYWxp
ZW44LmRlDQo+IENjOiBmZW5naHVhLnl1QGludGVsLmNvbTsgZGF2ZS5oYW5zZW5AbGludXguaW50
ZWwuY29tOyB4ODZAa2VybmVsLm9yZzsNCj4gaHBhQHp5dG9yLmNvbTsgcGF1bG1ja0BrZXJuZWwu
b3JnOyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOw0KPiBxdWljX25lZXJhanVAcXVpY2luYy5j
b207IHJkdW5sYXBAaW5mcmFkZWFkLm9yZzsNCj4gZGFtaWVuLmxlbW9hbEBvcGVuc291cmNlLndk
Yy5jb207IHNvbmdtdWNodW5AYnl0ZWRhbmNlLmNvbTsNCj4gcGV0ZXJ6QGluZnJhZGVhZC5vcmc7
IGpwb2ltYm9lQGtlcm5lbC5vcmc7IHBib256aW5pQHJlZGhhdC5jb207DQo+IGNoYW5nLnNlb2su
YmFlQGludGVsLmNvbTsgcGF3YW4ua3VtYXIuZ3VwdGFAbGludXguaW50ZWwuY29tOw0KPiBqbWF0
dHNvbkBnb29nbGUuY29tOyBkYW5pZWwuc25lZGRvbkBsaW51eC5pbnRlbC5jb207IERhczEsIFNh
bmRpcGFuDQo+IDxTYW5kaXBhbi5EYXNAYW1kLmNvbT47IHRvbnkubHVja0BpbnRlbC5jb207IGph
bWVzLm1vcnNlQGFybS5jb207DQo+IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGJhZ2FzZG90bWVAZ21haWwuY29tOyBlcmFuaWFuQGdv
b2dsZS5jb207IGNocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldTsNCj4gamFya2tvQGtlcm5lbC5v
cmc7IGFkcmlhbi5odW50ZXJAaW50ZWwuY29tOyBxdWljX2ppbGVzQHF1aWNpbmMuY29tOw0KPiBw
ZXRlcm5ld21hbkBnb29nbGUuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjkgMDgvMTNdIHg4
Ni9yZXNjdHJsOiBBZGQgc3lzZnMgaW50ZXJmYWNlIHRvIHJlYWQNCj4gbWJtX3RvdGFsX2J5dGVz
X2NvbmZpZw0KPiANCj4gSGkgQmFidSwNCj4gDQo+IEkgd291bGQgbGlrZSB0byBzZWNvbmQgSmFt
ZXMncyBzdWdnZXN0aW9uIHRvIHJlcGxhY2Ugc3lzZnMgd2l0aCByZXNjdHJsIG9yIGp1c3QNCj4g
cmVtb3ZlIGl0LiBJIGFtIGNvbmNlcm5lZCB0aGF0IHlvdSBtZW50aW9uZWQgaW4gcmVjZW50IG1l
c3NhZ2UgdGhhdCB5b3Ugb25seQ0KPiBwbGFuIGNoYW5nZXMgdG8gcGF0Y2ggMTAgd2hpbGUgSmFt
ZXMgaGlnaGxpZ2h0ZWQgdGhhdCB0aGlzIG5lZWRzIHRvIGJlDQo+IGFkZHJlc3NlZCBpbiBlbnRp
cmUgc2VyaWVzLiBDb3VsZCB5b3UgcGxlYXNlIGVuc3VyZSB0aGF0IHlvdSBjaGVjayBhbGwgdGhl
DQo+IHBhdGNoZXM/DQoNCk9rLiBTdXJlLiBXaWxsIHJlbW92ZSBpdC4NCng4Ni9yZXNjdHJsOiBB
ZGQgaW50ZXJmYWNlIHRvIHdyaXRlIG1ibV90b3RhbF9ieXRlc19jb25maWcNCg0KV2lsbCBjaGVj
ayBvdGhlciBwYXRjaGVzIGZvciBzaW1pbGFyIGNoYW5nZXMuDQogDQo+IA0KPiBPbiAxMi8xLzIw
MjIgNzozNiBBTSwgQmFidSBNb2dlciB3cm90ZToNCj4gPiBUaGUgY3VycmVudCBldmVudCBjb25m
aWd1cmF0aW9uIGNhbiBiZSB2aWV3ZWQgYnkgdGhlIHVzZXIgYnkgcmVhZGluZw0KPiANCj4gV2hh
dCAiY3VycmVudCIgbWVhbnMgaXMgbm90IGNsZWFyIGFuZCB0aGUgdGVybSBjb3VsZCBqdXN0IGJl
IHJlbW92ZWQuDQoNCldpbGwgcmVtb3ZlIGl0Lg0KPiANCj4gPiB0aGUgY29uZmlndXJhdGlvbiBm
aWxlIC9zeXMvZnMvcmVzY3RybC9pbmZvL0wzX01PTi9tYm1fdG90YWxfYnl0ZXNfY29uZmlnLg0K
PiA+IFRoZSBldmVudCBjb25maWd1cmF0aW9uIHNldHRpbmdzIGFyZSBkb21haW4gc3BlY2lmaWMg
YW5kIHdpbGwgYWZmZWN0DQo+ID4gYWxsIHRoZSBDUFVzIGluIHRoZSBkb21haW4uDQo+ID4NCj4g
PiBGb2xsb3dpbmcgYXJlIHRoZSB0eXBlcyBvZiBldmVudHMgc3VwcG9ydGVkOg0KPiA+ID09PT0N
Cj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0NCj4gPiBCaXRzICAgRGVzY3JpcHRpb24NCj4gPiA9PT09DQo+ID09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID4gNiAgICAg
IERpcnR5IFZpY3RpbXMgZnJvbSB0aGUgUU9TIGRvbWFpbiB0byBhbGwgdHlwZXMgb2YgbWVtb3J5
DQo+ID4gNSAgICAgIFJlYWRzIHRvIHNsb3cgbWVtb3J5IGluIHRoZSBub24tbG9jYWwgTlVNQSBk
b21haW4NCj4gPiA0ICAgICAgUmVhZHMgdG8gc2xvdyBtZW1vcnkgaW4gdGhlIGxvY2FsIE5VTUEg
ZG9tYWluDQo+ID4gMyAgICAgIE5vbi10ZW1wb3JhbCB3cml0ZXMgdG8gbm9uLWxvY2FsIE5VTUEg
ZG9tYWluDQo+ID4gMiAgICAgIE5vbi10ZW1wb3JhbCB3cml0ZXMgdG8gbG9jYWwgTlVNQSBkb21h
aW4NCj4gPiAxICAgICAgUmVhZHMgdG8gbWVtb3J5IGluIHRoZSBub24tbG9jYWwgTlVNQSBkb21h
aW4NCj4gPiAwICAgICAgUmVhZHMgdG8gbWVtb3J5IGluIHRoZSBsb2NhbCBOVU1BIGRvbWFpbg0K
PiA+ID09PT0NCj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0NCj4gPg0KPiA+IEJ5IGRlZmF1bHQsIHRoZSBtYm1fdG90YWxfYnl0ZXNf
Y29uZmlnIGlzIHNldCB0byAweDdmIHRvIGNvdW50IGFsbCB0aGUNCj4gPiBldmVudCB0eXBlcy4N
Cj4gPg0KPiA+IEZvciBleGFtcGxlOg0KPiA+ICAgICAkY2F0IC9zeXMvZnMvcmVzY3RybC9pbmZv
L0wzX01PTi9tYm1fdG90YWxfYnl0ZXNfY29uZmlnDQo+ID4gICAgIDA9MHg3ZjsxPTB4N2Y7Mj0w
eDdmOzM9MHg3Zg0KPiA+DQo+ID4gICAgIEluIHRoaXMgY2FzZSwgdGhlIGV2ZW50IG1ibV90b3Rh
bF9ieXRlcyBpcyBjdXJyZW50bHkgY29uZmlndXJlZA0KPiA+ICAgICB3aXRoIDB4N2Ygb24gZG9t
YWlucyAwIHRvIDMuDQo+IA0KPiAiY3VycmVudGx5IiBjYW4gYmUgcmVtb3ZlZCBzaW5jZSBpdCBh
bHJlYWR5IHN0YXJ0cyB3aXRoICJJbiB0aGlzIGNhc2UiLg0KDQpTdXJlLg0KPiANCj4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogQmFidSBNb2dlciA8YmFidS5tb2dlckBhbWQuY29tPg0KPiA+IC0tLQ0K
PiA+ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc3ItaW5kZXguaCAgICAgICB8ICAgIDENCj4gPiAg
YXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL2ludGVybmFsLmggfCAgIDI0ICsrKysrKysrDQo+
ID4gIGFyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9tb25pdG9yLmMgIHwgICAgNCArDQo+ID4g
IGFyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9yZHRncm91cC5jIHwgICA5OQ0KPiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDEyNyBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gDQo+IC4uLg0KPiANCj4gPiBkaWZmIC0t
Z2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL3JkdGdyb3VwLmMNCj4gPiBiL2FyY2gv
eDg2L2tlcm5lbC9jcHUvcmVzY3RybC9yZHRncm91cC5jDQo+ID4gaW5kZXggODM0MmZlYjU0YTdm
Li5lOTNiMWMyMDYxMTYgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9yZXNj
dHJsL3JkdGdyb3VwLmMNCj4gPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvcmR0
Z3JvdXAuYw0KPiA+IEBAIC0xNDIzLDYgKzE0MjMsOTAgQEAgc3RhdGljIGludCByZHRncm91cF9z
aXplX3Nob3coc3RydWN0DQo+IGtlcm5mc19vcGVuX2ZpbGUgKm9mLA0KPiA+ICAJcmV0dXJuIHJl
dDsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0cnVjdCBtb25fY29uZmlnX2luZm8gew0KPiA+ICsJdTMy
IGV2dGlkOw0KPiA+ICsJdTMyIG1vbl9jb25maWc7DQo+ID4gK307DQo+ID4gKw0KPiA+ICsjZGVm
aW5lIElOVkFMSURfQ09ORklHX0lOREVYICAgVUlOVF9NQVgNCj4gPiArDQo+ID4gKy8qKg0KPiA+
ICsgKiBtb25fZXZlbnRfY29uZmlnX2luZGV4X2dldCAtIGdldCB0aGUgaW5kZXggZm9yIHRoZSBj
b25maWd1cmFibGUNCj4gPiArZXZlbnQNCj4gDQo+IENvdWxkIHlvdSBzYXkgImdldCB0aGUgaGFy
ZHdhcmUgaW5kZXgiIHRvIGhlbHAgY2xhcmlmeSB3aGF0IHRoZSBpbmRleCBpcyBmb3I/DQoNClN1
cmUuDQoNCj4gDQo+ID4gKyAqIEBldnRpZDogZXZlbnQgaWQuDQo+ID4gKyAqDQo+ID4gKyAqIFJl
dHVybjogMCBmb3IgZXZ0aWQgPT0gUU9TX0wzX01CTV9UT1RBTF9FVkVOVF9JRA0KPiA+ICsgKiAg
ICAgICAgIDEgZm9yIGV2dGlkID09IFFPU19MM19NQk1fTE9DQUxfRVZFTlRfSUQNCj4gPiArICog
ICAgICAgICBJTlZBTElEX0NPTkZJR19JTkRFWCBmb3IgaW52YWxpZCBldnRpZA0KPiA+ICsgKi8N
Cj4gPiArc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQgbW9uX2V2ZW50X2NvbmZpZ19pbmRleF9n
ZXQodTMyIGV2dGlkKSB7DQo+ID4gKwlzd2l0Y2ggKGV2dGlkKSB7DQo+ID4gKwljYXNlIFFPU19M
M19NQk1fVE9UQUxfRVZFTlRfSUQ6DQo+ID4gKwkJcmV0dXJuIDA7DQo+ID4gKwljYXNlIFFPU19M
M19NQk1fTE9DQUxfRVZFTlRfSUQ6DQo+ID4gKwkJcmV0dXJuIDE7DQo+ID4gKwlkZWZhdWx0Og0K
PiA+ICsJCS8qIFdBUk4gKi8NCj4gPiArCQlyZXR1cm4gSU5WQUxJRF9DT05GSUdfSU5ERVg7DQo+
ID4gKwl9DQo+ID4gK30NCj4gDQo+IEkgc2VlIHRoYXQgeW91IGNvcGllZCBteSBzYW1wbGUgY29k
ZSBoZXJlLiBNeSBpbnRlbnRpb24gd2FzIHRoYXQgdGhlDQo+IC8qIFdBUk4gKi8gY29tbWVudCBi
ZSByZXBsYWNlZCB3aXRoIGFuIGFjdHVhbCB3YXJuaW5nLiBBcyBhIGNvbW1lbnQgaXQNCj4gZG9l
cyBub3QgYWRkIHZhbHVlLiBTaW5jZSB0aGUgY2FsbGVyIG5vdyBwcmludHMgYSBzdWJ0bGVyIHdh
cm5pbmcgaXQgY291bGQganVzdA0KPiBiZToNCj4gDQo+IAkvKiBTaG91bGQgbmV2ZXIgcmVhY2gg
aGVyZSAqLw0KPiAJcmV0dXJuIElOVkFMSURfQ09ORklHX0lOREVYOw0KDQpTdXJlLg0KPiANCj4g
PiArDQo+ID4gK3N0YXRpYyB2b2lkIG1vbl9ldmVudF9jb25maWdfcmVhZCh2b2lkICppbmZvKSB7
DQo+ID4gKwlzdHJ1Y3QgbW9uX2NvbmZpZ19pbmZvICptb25faW5mbyA9IGluZm87DQo+ID4gKwl1
MzIgaCwgaW5kZXg7DQo+IA0KPiBpbmRleCBjYW4gYmUgInVuc2lnbmVkIGludCIgYXMgcmV0dXJu
ZWQgYnkgbW9uX2V2ZW50X2NvbmZpZ19pbmRleF9nZXQoKQ0KDQpPay4gU3VyZQ0KDQo+IA0KPiA+
ICsNCj4gPiArCWluZGV4ID0gbW9uX2V2ZW50X2NvbmZpZ19pbmRleF9nZXQobW9uX2luZm8tPmV2
dGlkKTsNCj4gPiArCWlmIChpbmRleCA9PSBJTlZBTElEX0NPTkZJR19JTkRFWCkgew0KPiA+ICsJ
CXByX3dhcm5fb25jZSgiSW52YWxpZCBldmVudCBpZCAlZFxuIiwgbW9uX2luZm8tPmV2dGlkKTsN
Cj4gPiArCQlyZXR1cm47DQo+ID4gKwl9DQo+ID4gKwlyZG1zcihNU1JfSUEzMl9FVlRfQ0ZHX0JB
U0UgKyBpbmRleCwgbW9uX2luZm8tPm1vbl9jb25maWcsIGgpOw0KPiA+ICsNCj4gPiArCS8qIFJl
cG9ydCBvbmx5IHRoZSB2YWxpZCBldmVudCBjb25maWd1cmF0aW9uIGJpdHMgKi8NCj4gPiArCW1v
bl9pbmZvLT5tb25fY29uZmlnICY9IE1BWF9FVlRfQ09ORklHX0JJVFM7IH0NCj4gPiArDQo+ID4g
K3N0YXRpYyB2b2lkIG1vbmRhdGFfY29uZmlnX3JlYWQoc3RydWN0IHJkdF9kb21haW4gKmQsIHN0
cnVjdA0KPiA+ICttb25fY29uZmlnX2luZm8gKm1vbl9pbmZvKSB7DQo+ID4gKwlzbXBfY2FsbF9m
dW5jdGlvbl9hbnkoJmQtPmNwdV9tYXNrLCBtb25fZXZlbnRfY29uZmlnX3JlYWQsDQo+IG1vbl9p
bmZvLA0KPiA+ICsxKTsgfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBtYm1fY29uZmlnX3Nob3co
c3RydWN0IHNlcV9maWxlICpzLCBzdHJ1Y3QgcmR0X3Jlc291cmNlDQo+ID4gKypyLCB1MzIgZXZ0
aWQpIHsNCj4gPiArCXN0cnVjdCBtb25fY29uZmlnX2luZm8gbW9uX2luZm8gPSB7MH07DQo+ID4g
KwlzdHJ1Y3QgcmR0X2RvbWFpbiAqZG9tOw0KPiA+ICsJYm9vbCBzZXAgPSBmYWxzZTsNCj4gPiAr
DQo+ID4gKwltdXRleF9sb2NrKCZyZHRncm91cF9tdXRleCk7DQo+ID4gKw0KPiA+ICsJbGlzdF9m
b3JfZWFjaF9lbnRyeShkb20sICZyLT5kb21haW5zLCBsaXN0KSB7DQo+ID4gKwkJaWYgKHNlcCkN
Cj4gPiArCQkJc2VxX3B1dHMocywgIjsiKTsNCj4gPiArDQo+ID4gKwkJbW9uX2luZm8uZXZ0aWQg
PSBldnRpZDsNCj4gPiArCQltb25kYXRhX2NvbmZpZ19yZWFkKGRvbSwgJm1vbl9pbmZvKTsNCj4g
PiArDQo+IA0KPiBGb3Igcm9idXN0bmVzcywgcGxlYXNlIHJlc2V0IG1vbl9jb25maWcgYmVmb3Jl
IGNhbGxpbmcgbW9uZGF0YV9jb25maWdfcmVhZCgpLg0KPiBTaW5jZQ0KPiBtb25fZXZlbnRfY29u
ZmlnX3JlYWQoKSBtYXkgKHllcyB0aGlzIGlzIHZlcnkgdW5saWtlbHkpIGV4aXQgZWFybHkgdGhl
bg0KPiBtb25fY29uZmlnIHdpbGwgY29udGFpbiB0aGUgZGF0YSBmcm9tIHRoZSBwcmV2aW91cyBk
b21haW4uDQoNClN1cmUuIEkgY2FuIGNhbGwgbWVtc2V0IHRvIHJlc2V0Lg0KVGhhbmtzDQpCYWJ1
DQoNCj4gDQo+ID4gKwkJc2VxX3ByaW50ZihzLCAiJWQ9MHglMDJ4IiwgZG9tLT5pZCwgbW9uX2lu
Zm8ubW9uX2NvbmZpZyk7DQo+ID4gKwkJc2VwID0gdHJ1ZTsNCj4gPiArCX0NCj4gPiArCXNlcV9w
dXRzKHMsICJcbiIpOw0KPiA+ICsNCj4gPiArCW11dGV4X3VubG9jaygmcmR0Z3JvdXBfbXV0ZXgp
Ow0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiANCj4gLi4uDQo+IA0K
PiBSZWluZXR0ZQ0K
