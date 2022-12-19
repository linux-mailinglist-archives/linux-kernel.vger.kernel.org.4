Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1C6650F59
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbiLSPxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbiLSPx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:53:26 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F1713DDF;
        Mon, 19 Dec 2022 07:51:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MaeFxeLRaJGMPu8N8X4Fp07gdQV0d6Hrpoa4lIl19gDc6euu/EsmF4MQBNyu+roNTua3H96qGGfm/8y0HKn1BmnRn1/i9FzMNrwVesASp6f0ITiX2464hZ7vZisQMQ9ya8t5q4opCws1XVVJPiqGXv2yt9lEGtU8ftvw9i/uxmzSn6+sd/2+By+zFkbfaXyVaSWAJ05Avlx+B6cBc67gzb6yzft0CP17IA1ZHLVOO/iItUL799BkFb/LGDTETjwos9YwBfsyGoL3OnSVkbf+m3PDz/t3ptSNGASYVWpD1SYQF2bIEcsRSWawRmESismr7rjp7vO6xOdfcLr9EyQjmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vbl6gYZauoTTFXTZKDGLYYiBPp4eLyiT2+94M7O1Oc=;
 b=BVbBN5bxANaWth4hNjJxZHQnhKCi7bCvZCYH2OyTIgQjQcYwJRCNf6ykaMsGpgeueLlesK0BpvfjRPToXK+b/bXOcZlcZWK8PbhR3V9Rn9UJ5E4y1E+n1dGfh1xpTV3JVPTn62I7nQupTODXPuxLg35fTmHVAkXLdgN9LLhHKesjux578KEwR4t3LuxZF6DlKoMtHed4IWvobcORdHLSq9XoC9hcgIs39HEd8D/AI1yAR5tSRe28HkWfSHBwWwZpeTtETWh3hl6Jab8s4mMS2Yso1osb7YBqFwWEbYgosvIChdyVLn/cTjAaBXC7ywi6/0MkqaLTz6iqsND8g+GSIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vbl6gYZauoTTFXTZKDGLYYiBPp4eLyiT2+94M7O1Oc=;
 b=o2w6tQGiqKhC5dVDo5xCfJHlI1m/hT96MpwixKJQIjRYGcsioHa+3Jy/GTv2TmwLAwSUXSmUDgV78+fTIYX7i28GfYymdRdlMZfoYxtqXC/7PZ3BI70aq9icfrJzsXMmLSDAWTmMRQAuBne2228u+eCrE1mYlsnYolq3LYu2gUg=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM6PR12MB4188.namprd12.prod.outlook.com (2603:10b6:5:215::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 15:51:29 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%5]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 15:51:29 +0000
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
Subject: RE: [PATCH v9 06/13] x86/resctrl: Add __init attribute to
 rdt_get_mon_l3_config()
Thread-Topic: [PATCH v9 06/13] x86/resctrl: Add __init attribute to
 rdt_get_mon_l3_config()
Thread-Index: AQHZBZrF9YX7kqOO/k+zvGNKOWVBB65vRvGAgAYwqHA=
Date:   Mon, 19 Dec 2022 15:51:29 +0000
Message-ID: <MW3PR12MB4553BA5B46B87EEF27B2914295E59@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
 <166990900117.17806.4506067708943298894.stgit@bmoger-ubuntu>
 <70e6b0a3-a18e-ff10-1df0-3b6790692bda@intel.com>
In-Reply-To: <70e6b0a3-a18e-ff10-1df0-3b6790692bda@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-19T15:48:57Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a3085bda-4679-4c05-bc4c-69ca49e15463;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-19T15:51:27Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 1ee62527-21dd-488a-93ea-30eedebf62cb
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|DM6PR12MB4188:EE_
x-ms-office365-filtering-correlation-id: d2709e88-ffa2-4663-8ca6-08dae1d8e4a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fzc2W9e0/1sUFSBrV2o+nI4aNWvz3na5DCpUoXdQW1Muoia5mRi7yk/PBMgGfVGA3vm5skeeY5S+sm/wZXWTQTM+zB65w+7qxk7aPnNde5yvt/CbTNsAzpYIPo2V4b3oGnHG/ePFl288fNq8e0wjnsDGKzerD7jpBBJhmHTsKQIaEYtHPxV+4iiaFvInm9w6MEioSSGf2noO+pCw7y/iZxW03jtWtNeqSH51sqBcvpRLAca0gB8SuO7PERfZNWormOvu3UYQG+ThdiMXpb9g5VJv0ClAFnKbnPdS70uk0Mn8fs8VnTsJInrzo2goY4x1oH0hdzFPrWHj3OM+MwHQHPptkGfGtfHIMfberujr9nlecYAQwyyOHGqt391hz78sabmLNcppdqluBj0Q/a1umO6wcHeeKv114SUqoyPNjKfNaylx6LfaFE4L21yj1EINe2ZFTWNbDxRdFKSvu6EtIjFAhxPUR9kJM5+5H5XALON0ZCO6hSBgAq9rCXjvP5qlvaGaNHIpmaMA4RBdKQQ7I5ifG0TjZae2KVrBXXBdSPRKG/inh1Q40e+jTW3C4SyfqkDxJcizY5G2VLM0eYz7dYhe72wr1gLnRsPb3Cc5bHohkukALVLvjIyoRIwJTV1WGtxhDz8pjPwpA64Roivi6nBScmEzfuRuCmpifvd5v3fvqYloL3UvnTAQoYnUBWPr49jerkt8Z7jYg3/o9Fe2nw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199015)(2906002)(38100700002)(122000001)(38070700005)(5660300002)(83380400001)(7406005)(41300700001)(7416002)(52536014)(66476007)(66556008)(8676002)(66946007)(64756008)(66446008)(4326008)(76116006)(8936002)(55016003)(316002)(26005)(53546011)(110136005)(186003)(9686003)(54906003)(86362001)(478600001)(7696005)(33656002)(6506007)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enpxaHdxaXhnVWZBTEdHYXplR0ttOW9WNDRVRWFYTXdSMldEUVB3WitrVDli?=
 =?utf-8?B?NXNVVlplRStjanNSOVMrdUE5L2FmL2JMWGJjN253czVlWG1SclBNaWhmd2Fp?=
 =?utf-8?B?cmcwejNDdDIzNEVZSElvdCtUa2lWRDVJVHFJQ1lyd1d5bGRrSmxHT05ldUZu?=
 =?utf-8?B?cENuU1VhdU51WEdTZmVCczBadkJsVDVYaHd4VEVxZllJc29CTGhDWTU1NmxB?=
 =?utf-8?B?UVJicXRKSy93dVU4VzExRERWcjB3dTNyK0cvSDY1ZGJ2VlU4RmtCWk51eFNy?=
 =?utf-8?B?MjhwSHhjYmt3VThMTWYxV3FOMEZVbzlxc2NlQmU4K2VBRTZZRUUxODAzNzcz?=
 =?utf-8?B?ajlUNkF6Ky9LVG00SHRia3FrRVJZUW9uMzZLbVA3ZVRzY2prVlhsL21qcC9K?=
 =?utf-8?B?RGZqT3I4cCtzRHdFMXpXTkJKbWl2ZTRFenRWUTh5THdFSTlFRHJDVXZDMU9v?=
 =?utf-8?B?REtrRXdRdnh5b0JMbG1ZazRVcVA3bFRsRkxjSmF4clNVZlUvVjQ1QXNOd3Iy?=
 =?utf-8?B?ckxoWHpIZi9BaDBjOVpuQ1p1WmxDbnJqTm9yTjlvOHc2ZDIxL3ZtcjgxcjZZ?=
 =?utf-8?B?UmNPTUh4d3FaN3ZCMnIxN0VacnFUQ3VPSkdGWmVpcHdmUDFzNHNlMUlkeDF2?=
 =?utf-8?B?eUR1V3FKTnJWWUk4ZVN3bXpyclhNVmVZMFZnNzVwSVN3bTh0WW1idUJBKzN2?=
 =?utf-8?B?dHg3VEFqaGYvK3ZFeGpKSVRzQURHdWJpU3VIZ2R1eVhJekwxUW12clBYdEZp?=
 =?utf-8?B?RmVHNkxwV21JZHJLSStNcTZXTUpTTGpWNTA1ekVoYXFFQ215TTN5emdIMWUv?=
 =?utf-8?B?Q0lKV0MyWEVnSjVOT0hlOEcwNmwwQ3llTmtZUkVWdEFtbFJnaWdYSXFlTWZa?=
 =?utf-8?B?WWdqcjdvbkxJZS8zbEw0UFBZY3Nhbnp4TXlYYnpQc0VNK29jVmRGSFdBMXNG?=
 =?utf-8?B?UExwTUFTRG5tUXgvVE9YQjYvODNxU1BOYXp6ZWxOMWdPeFZYTWR0M1ZwWTVI?=
 =?utf-8?B?K1NPVVg3U3ZqL3FkbjV6ZnFxT3cveTFWODNnekZuNGNKb040dFpvZWxVSzhr?=
 =?utf-8?B?aVM4aTA2U1FqaUhDU1JpTkViaEpqMWdzaG5JNEthOElWd1k1U1crN3ptWUwz?=
 =?utf-8?B?WHV4aFRwUUhwbVN2YjRJMWRESkMzZUFpS0FQWEp4RnFXSnZCT1MwWTd4MG9u?=
 =?utf-8?B?U0xvZVNzVkZ6a2dSVGFUS3JkdXVLcXh2d1Qrdjg4V1pNN284UloraC9wWjEr?=
 =?utf-8?B?MGxTNGVYcWl6RngrcjhzTHUvWHVwcDI3Y2NqME5vemgrbjZXZjRJT3BFMThV?=
 =?utf-8?B?c01IUkpQZ1djWWdkbjJ0WEszdlRDS1pBSHlGSnNtRXBZUVAwb1o0Qmw1WC9B?=
 =?utf-8?B?SVROc3RPVStzVjJ4N1cxSDdHSkc2ZHZzU2pyMllKR1RqeTRaSmVOQkI5dzJE?=
 =?utf-8?B?MEJiZEcwMmZ4WEg4akZYN0ZVQnZpWnpIZGJ0d3RZMFNrR0ZEWE55ZnNnUFg3?=
 =?utf-8?B?dlBBRXhjQTdHZkFxNDBCR1h4Ky9OL1AydndubHh5bUxqNUxwdERYc1hXUmtG?=
 =?utf-8?B?RkZTRHFZTnQvN09NaXdwVmxUZU1yQ3RuVkpYYldNcmFJNlhzbDkyRUJ5Vno2?=
 =?utf-8?B?a0YwbDVONmdwY2hWa3ROVkt4c0NiZkFFdnYyOVVTeis2VGtGMWZUeGx4bjRa?=
 =?utf-8?B?VVRyU25xL3ZObTkwREZjNFhqTTJ1K0tRMUlMK2J3MG1XY0RFZmRDRVoyemtG?=
 =?utf-8?B?TXlYQStHYUt5aGNObmQwd3FveHA2ZjR2Zkt3L2RpM2xGMis1Z3AzenE5aFQ0?=
 =?utf-8?B?UGppclFwTnVIRkpVV2hjU01aZ1FuVldhTlJIa0lGTzc3NWZHeDdJVDhiVC9O?=
 =?utf-8?B?T293M0VyUzBoSTJXc0ozNHNQbTBxVEJTaVRaVHhNWWpnZksvYmJJZEFmVVJ1?=
 =?utf-8?B?RTF1RlY5N0pXeHhsU2hscEhiUU96MXBFc1pTYkdKK1BXQ09iMnQrdm9pWHUr?=
 =?utf-8?B?cVVMY0RGWnhjV0RBTmxiUjdPa1NLSVpucnZ1SlYwRGs0Y0Q3cUgvdmlOZmlO?=
 =?utf-8?B?VURKVFhaWEdGd01acWl0NEREMDlMWklXV3JlUWJydnp3NXJvY3lNNEZ5U2d1?=
 =?utf-8?Q?eB5o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2709e88-ffa2-4663-8ca6-08dae1d8e4a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 15:51:29.1158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cxjlaVifRb4qRS91C2/NDKqrbZ+6Bn2SjinQwx6wDoTM8oNx08cnhjnwZrzyZTzM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4188
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
IDExOjE3IEFNDQo+IFRvOiBNb2dlciwgQmFidSA8QmFidS5Nb2dlckBhbWQuY29tPjsgY29yYmV0
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
ZXRlcm5ld21hbkBnb29nbGUuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjkgMDYvMTNdIHg4
Ni9yZXNjdHJsOiBBZGQgX19pbml0IGF0dHJpYnV0ZSB0bw0KPiByZHRfZ2V0X21vbl9sM19jb25m
aWcoKQ0KPiANCj4gSGkgQmFidSwNCj4gDQo+IE9uIDEyLzEvMjAyMiA3OjM2IEFNLCBCYWJ1IE1v
Z2VyIHdyb3RlOg0KPiA+IFRoZSBmdW5jdGlvbiByZHRfZ2V0X21vbl9sM19jb25maWcoKSBuZWVk
cyB0byBjYWxsIHJkdF9jcHVfaGFzKCkgdG8NCj4gDQo+IE5vIG5lZWQgdG8gc2F5ICJUaGUgZnVu
Y3Rpb24iIC4uLiBieSB1c2luZyAoKSBhZnRlciBhIG5hbWUgaXQgaXMgY2xlYXIgdGhhdCBpdCBp
cyBhDQo+IGZ1bmN0aW9uLg0KDQpPaw0KPiANCj4gVG8gc3VwcG9ydCB0aGlzIGNoYW5nZSBpdCBj
b3VsZCBwZXJoYXBzIGJlOg0KPiAiSW4gYW4gdXBjb21pbmcgY2hhbmdlIHJkdF9nZXRfbW9uX2wz
X2NvbmZpZygpIG5lZWRzIHRvIGNhbGwNCj4gcmR0X2NwdV9oYXMoKSB0byAuLi4iDQoNClN1cmUu
DQo+IA0KPiA+IHF1ZXJ5IHRoZSBtb25pdG9yIHJlbGF0ZWQgZmVhdHVyZXMuIEl0IGNhbm5vdCBi
ZSBjYWxsZWQgcmlnaHQgbm93DQo+ID4gYmVjYXVzZSByZHRfY3B1X2hhcygpIGhhcyB0aGUgX19p
bml0IGF0dHJpYnV0ZSBidXQNCj4gPiByZHRfZ2V0X21vbl9sM19jb25maWcoKSBkb2Vzbid0LiBT
bywgYWRkIHRoZSBfX2luaXQgYXR0cmlidXRlIHRvDQo+ID4gcmR0X2dldF9tb25fbDNfY29uZmln
KCkgdG8gcmVzb2x2ZSBpdC4NCj4gDQo+IFBsZWFzZSBwbGFjZSB0aGUgc29sdXRpb24gZGVzY3Jp
cHRpb24gaW4gYSBuZXcgcGFyYWdyYXBoIGFuZCBkcm9wIHRoZSAiU28sIi4NCj4gVGhlIGRlc2Ny
aXB0aW9uIGNvdWxkIGFsc28gYmUgZXhwYW5kZWQgdG8gc3VwcG9ydCB0aGlzIGNoYW5nZS4gRm9y
IGV4YW1wbGU6DQo+IA0KPiAiQWRkIHRoZSBfX2luaXQgYXR0cmlidXRlIHRvIHJkdF9nZXRfbW9u
X2wzX2NvbmZpZygpIHRoYXQgaXMgb25seSBjYWxsZWQgYnkNCj4gZ2V0X3JkdF9tb25fcmVzb3Vy
Y2VzKCkgdGhhdCBhbHJlYWR5IGhhcyB0aGUgX19pbml0IGF0dHJpYnV0ZS4gQWxzbyBtYWtlDQo+
IHJkdF9jcHVfaGFzKCkgYXZhaWxhYmxlIHRvIGJ5IHJkdF9nZXRfbW9uX2wzX2NvbmZpZygpIHZp
YSB0aGUgaW50ZXJuYWwgaGVhZGVyDQo+IGZpbGUuIg0KPiANClN1cmUuDQo+IA0KPiA+DQo+ID4g
QWxzbywgbWFrZSB0aGUgZnVuY3Rpb24gcmR0X2NwdV9oYXMoKSBhdmFpbGFibGUgb3V0c2lkZSBj
b3JlLmMgZmlsZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJhYnUgTW9nZXIgPGJhYnUubW9n
ZXJAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL2Nv
cmUuYyAgICAgfCAgICAyICstDQo+ID4gIGFyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9pbnRl
cm5hbC5oIHwgICAgMSArDQo+ID4gIGFyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9tb25pdG9y
LmMgIHwgICAgMiArLQ0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jl
c2N0cmwvY29yZS5jDQo+ID4gYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvY29yZS5jDQo+
ID4gaW5kZXggYjRmYzg1MWY2NDg5Li4wMzBkM2I0MDk3NjggMTAwNjQ0DQo+ID4gLS0tIGEvYXJj
aC94ODYva2VybmVsL2NwdS9yZXNjdHJsL2NvcmUuYw0KPiA+ICsrKyBiL2FyY2gveDg2L2tlcm5l
bC9jcHUvcmVzY3RybC9jb3JlLmMNCj4gPiBAQCAtNzI4LDcgKzcyOCw3IEBAIHN0YXRpYyBpbnQg
X19pbml0IHNldF9yZHRfb3B0aW9ucyhjaGFyICpzdHIpICB9DQo+ID4gX19zZXR1cCgicmR0Iiwg
c2V0X3JkdF9vcHRpb25zKTsNCj4gPg0KPiA+IC1zdGF0aWMgYm9vbCBfX2luaXQgcmR0X2NwdV9o
YXMoaW50IGZsYWcpDQo+ID4gK2Jvb2wgX19pbml0IHJkdF9jcHVfaGFzKGludCBmbGFnKQ0KPiA+
ICB7DQo+ID4gIAlib29sIHJldCA9IGJvb3RfY3B1X2hhcyhmbGFnKTsNCj4gPiAgCXN0cnVjdCBy
ZHRfb3B0aW9ucyAqbzsNCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9yZXNj
dHJsL2ludGVybmFsLmgNCj4gPiBiL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9pbnRlcm5h
bC5oDQo+ID4gaW5kZXggZmRiYmY2NjMxMmVjLi43YmJmYzEwMDk0YjYgMTAwNjQ0DQo+ID4gLS0t
IGEvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL2ludGVybmFsLmgNCj4gPiArKysgYi9hcmNo
L3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvaW50ZXJuYWwuaA0KPiA+IEBAIC01MTIsNiArNTEyLDcg
QEAgdm9pZCBjbG9zaWRfZnJlZShpbnQgY2xvc2lkKTsgIGludA0KPiA+IGFsbG9jX3JtaWQodm9p
ZCk7ICB2b2lkIGZyZWVfcm1pZCh1MzIgcm1pZCk7ICBpbnQNCj4gPiByZHRfZ2V0X21vbl9sM19j
b25maWcoc3RydWN0IHJkdF9yZXNvdXJjZSAqcik7DQo+ID4gK2Jvb2wgcmR0X2NwdV9oYXMoaW50
IGZsYWcpOw0KPiANCj4gUGxlYXNlIGFsc28gYWRkIF9faW5pdCBhdHRyaWJ1dGUgaGVyZSBieSB1
c2luZyB0aGUgc2FtZSBzdHlsZSBhcyB0aGUgb3RoZXINCj4gZnVuY3Rpb25zIGluIHRoaXMgZmls
ZSB0aGF0IG5lZWQgX19pbml0Lg0KT2sNClRoYW5rcw0KQmFidQ0KPiANCj4gPiAgdm9pZCBtb25f
ZXZlbnRfY291bnQodm9pZCAqaW5mbyk7DQo+ID4gIGludCByZHRncm91cF9tb25kYXRhX3Nob3co
c3RydWN0IHNlcV9maWxlICptLCB2b2lkICphcmcpOyAgdm9pZA0KPiA+IG1vbl9ldmVudF9yZWFk
KHN0cnVjdCBybWlkX3JlYWQgKnJyLCBzdHJ1Y3QgcmR0X3Jlc291cmNlICpyLCBkaWZmDQo+ID4g
LS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvbW9uaXRvci5jDQo+ID4gYi9hcmNo
L3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvbW9uaXRvci5jDQo+ID4gaW5kZXggZWZlMGMzMGQzYTEy
Li5lMzNlOGQ4YmQ3OTYgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9yZXNj
dHJsL21vbml0b3IuYw0KPiA+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9tb25p
dG9yLmMNCj4gPiBAQCAtNzQ2LDcgKzc0Niw3IEBAIHN0YXRpYyB2b2lkIGwzX21vbl9ldnRfaW5p
dChzdHJ1Y3QgcmR0X3Jlc291cmNlICpyKQ0KPiA+ICAJCWxpc3RfYWRkX3RhaWwoJm1ibV9sb2Nh
bF9ldmVudC5saXN0LCAmci0+ZXZ0X2xpc3QpOyAgfQ0KPiA+DQo+ID4gLWludCByZHRfZ2V0X21v
bl9sM19jb25maWcoc3RydWN0IHJkdF9yZXNvdXJjZSAqcikNCj4gPiAraW50IF9faW5pdCByZHRf
Z2V0X21vbl9sM19jb25maWcoc3RydWN0IHJkdF9yZXNvdXJjZSAqcikNCj4gPiAgew0KPiA+ICAJ
dW5zaWduZWQgaW50IG1ibV9vZmZzZXQgPQ0KPiBib290X2NwdV9kYXRhLng4Nl9jYWNoZV9tYm1f
d2lkdGhfb2Zmc2V0Ow0KPiA+ICAJc3RydWN0IHJkdF9od19yZXNvdXJjZSAqaHdfcmVzID0gcmVz
Y3RybF90b19hcmNoX3JlcyhyKTsNCj4gPg0KPiA+DQo+IA0KPiBUaGFuayB5b3UNCj4gDQo+IFJl
aW5ldHRlDQo=
