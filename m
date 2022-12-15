Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5824A64DD4C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 16:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiLOPIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 10:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiLOPIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 10:08:22 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2665B30562;
        Thu, 15 Dec 2022 07:08:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agEm9CDXgKtWdwM08Ll3A1EiGqo1dOKLfR0F3GOEdTGOpC5Yq40pX4YXSzODpWNaPSaX1gcOkFWvFMxiribcQsSm64pOlott7/OBtVY9WG1zl72Bj5JMvVnIVtXpbCFAfB0LYzKOf8MQHLdMR6snODqytXsZzHtekBKaC01d3vtQtdpYtD8srg8ir9EexjmLFyNAzet4nHYw0+clNofd5itbcLvKUKpRowAok3Y04IH4cbZwN2MCbG09rMyX5o3gRRn/hE9KQJW4/EIbt8091P0zH8jdJ1zktp4EIwL9ZDhCCkHc1TmweTdaDL3pkcrZVvnBh6dboT+AAvixRinH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WZSGJNCxlUFxfSKfCrWTV5PuRPJ/siD4AzD8itHURg=;
 b=MeCe+gY2XyrMwgrrOT04w2BzhJ2PGpdXNDe7nMKi79fQFtTr9bbF6Qr2F7ab9qnt4pKRwRFHJvrdK0+HuRuBfSLYJ537Uds6KbQNLLm4zp/YmBmZcLkpcdrxZ3GvzwjtEyZZwHDR+E+uUS17g3r3no27fa2WC0Ze00TxJN6j+5Ffq5zM9K79xCc0+nTDZf2eoKNsAs2q5sJRg/O4D4D5t5IPxwPm0xYAJtKcSOZwfacPTtVixk/WRv6p47QEWoVWiZ9b0fMF9mALbSKhxGIwFsONueiFLjt2S2TRBS6Pl85dGcTdOM2MkTqI7wMaMjSU1wjt9eMbraCeT5ShoXkakw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WZSGJNCxlUFxfSKfCrWTV5PuRPJ/siD4AzD8itHURg=;
 b=IT+EbxscW6C8G2h6Yswk9H6F9LbPzxxE1Ln2bqu7cUDYlrRXKtpIXBIkiEbfaGFpcBnurzntJiyU2vy5gD9p5A1j+Y4f5rGSAghRrKdORk3owk4SXF9+KwHm+TnZw1z6nPFGdIxcdpwb3bGPIRDSlkbHjTNtiLt+8XjiEdVMQsM=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BY5PR12MB4933.namprd12.prod.outlook.com (2603:10b6:a03:1d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Thu, 15 Dec
 2022 15:08:18 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%5]) with mapi id 15.20.5880.019; Thu, 15 Dec 2022
 15:08:18 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
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
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>
Subject: RE: [PATCH v9 00/13] Support for AMD QoS new features
Thread-Topic: [PATCH v9 00/13] Support for AMD QoS new features
Thread-Index: AQHZBZqdPWUZgGQn2kuXVfR31D91jq5vIToA
Date:   Thu, 15 Dec 2022 15:08:18 +0000
Message-ID: <MW3PR12MB455392E4A81DB52A9B6B0DB195E19@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
In-Reply-To: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-15T15:02:15Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c7534123-b7ca-41dd-a3d5-51a69e9b3b72;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-15T15:08:16Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 8b9930fe-c735-4d80-bd67-290a61b3b1d7
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|BY5PR12MB4933:EE_
x-ms-office365-filtering-correlation-id: 7fc25363-2f99-4d3e-b79b-08dadeae32cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A+JS52Cr+zm7vaoi7sEdO26EupAXCkWxvS16ND+v/uRpmyFv9XqhPHDtwIoaUSwXzLB7w2JgEqqRQH7sURG5oGJq9kGZ1O3khBZRcJgnCnkWOwI90e+aOpNxomZV56uQjvaSZc5M4KzQaU4v4aHrqlrjakPFSfGiuwsTm/f0BGjg0Pkkp8ZJEA55ej9EP/P3hM1AmG0BFozxhXy28vOknvTLH604uWE3oxAUXD620bSU/ensYJmxJMbGJunXP6FkDpG2ShVI2v9xdx6CRBlsEyVRO/X0mvkbglgYQJ89AyzAUhLMI7E1RJujQhdutl4cOMYea28len+Wa6VGJ2zbySRYgYpDAAe3RVZrgQfRRt42Z/DNvQuW4uzfzsL9mf0BEcd1lxNzScFtnCj2BjaQ6R0i8ePEe8oGevmEgnSQKL8r5wa1/X5E/n/OkDJwp8BJvq2OPH189lfEcH8ySa1MPcyMgjKZ2qEo8Ko+F6xALjq+Ww064XcWx2RZlLNDw1vL7EANAcZIKUTHZeCoZF9xaGYeMupD345LL7UOCVqdUrnE1xTgkTAWzQZJaWgOaByRNuHvuMI+dCIZz4TsmqvSmzS+QAlWgM2r+VFbXTeeMMws0B9ySVgw/cxg5WagUHWKhUnxlx027hBGHxXFH+Gjx7P4gN8UoSZuNFyp5g/BhjHrkcudsdn8Sn3nmsM44qmHpML8kS9SEAPXMPLgLpmyi/5rSFvHrG7k0txPd/4M+UxXwNI3BGIrAPylecYSXcaJzgMEyDzbpMOQKbTs+/Avgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199015)(64756008)(54906003)(76116006)(5660300002)(66946007)(478600001)(45080400002)(4326008)(66446008)(7406005)(66556008)(8676002)(7416002)(66476007)(41300700001)(52536014)(316002)(9686003)(110136005)(7696005)(26005)(122000001)(38070700005)(55016003)(38100700002)(6506007)(966005)(53546011)(71200400001)(86362001)(83380400001)(186003)(8936002)(33656002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVErVVVnekxRTmR1WFVNRURiYkUyOU9vSmJpUXgxUzlDNlAySWRWMm1ZSWtl?=
 =?utf-8?B?T3B1T0l0L1NzSFk3WnZYTUk5azU4L3hTNHdkdUk3eFZUeWZscTJlN0Y0ajkz?=
 =?utf-8?B?WkpKUWUyR3ErNDl6Y3Axc29rN2pjT0s3VFJNUEhtZ3huUllva1E1ZGNNbXgr?=
 =?utf-8?B?NHJOdEhwbVplcXU1Z2NzVWxERGZsY3hBOXdLVVRtSUh0OWltN3hvVWV6YVlz?=
 =?utf-8?B?SFVkYVFKcm1VaS9BdU1pUFpKV3FDVFltU05TU0F4TFZ3OWJaMW9GcFYvMVEz?=
 =?utf-8?B?My8xVTRUQ2V0bDhPcUtzWU5VRUZjR0Y0RVJWZ2tEeExQSFBIQjJvNG5vOFU0?=
 =?utf-8?B?RVF5R1V6bFR0dGg1SjlJUlVta0RjNUhhQTJuVXNwaDlOYm5Ja3JjazZKS0hY?=
 =?utf-8?B?YVZtbFBCRFVvZ2Ftd2U0YTBkSlFrTHZDVjBkSU9wSWw5OGRzb3hBY0VlajEx?=
 =?utf-8?B?ajhudk15R1RkMm9ockhPZXRGUmd1Y216aTN4NWpKK04vbXN1M0NSb25hekl6?=
 =?utf-8?B?Wm8raFBGK1BGamJuNlRjK1JWUGlYZDFBOGlXZndVZjBNSVNYeWh2K3QxRHhO?=
 =?utf-8?B?dEwzczV1Y0VpbUs1VFR2WVdTNmgwQTI4ckl1WFc5TmVZUWdIUzR6KzZJNnRn?=
 =?utf-8?B?RDVQQVo3Rm5GQWtHVmJUdW9YSUFmYUlFVzBhT0N1V0U1Y2Z1YkJHd09KR3dt?=
 =?utf-8?B?UGxpTFQ5NlU5YlpPUTBZYlhxOENnQXViNmpHQ3Nxa21EcjV5cjdMUXRjSGRq?=
 =?utf-8?B?c3JyVXRBdHI5SVBmN0sxWTVtcGhVSSszcDBUM041UzlRN0NRWVRnVk44ZjRC?=
 =?utf-8?B?Mk5GTTViTVdxd1grZjhYb1A0cGwvRUl6NTBiZkliMVN0ZmJ1WHFCS3FFa3Va?=
 =?utf-8?B?OHNzUjlDTnJRdHRCSlNySWQvbGxMa3pKbDN2bTRyL0NIN2xKSkNQdm5Hcnk3?=
 =?utf-8?B?WnJac0V4d3NBcG0wVCtxRGlEUmxtQzViOG01SWZhOHhzVnRvTDJFT3dmNVFN?=
 =?utf-8?B?MXB5QjRpN05WRnNId1VlTjZEYzFNVHQ3VmsyMVJCT0NmNTM5dGk4UGVFamR6?=
 =?utf-8?B?ajdtUzBQM0l2SnB4SjYyY2xQREE3WHFLVnhrV1pCY3Y1TWRUckFmTVVEdEJY?=
 =?utf-8?B?ZHFTVG95c05qRW5KTzhGS2k3aTBjM010c3NWM0tjVk14VXNtUml0eVFzT2hT?=
 =?utf-8?B?bnozUWFneXRweHBYQitLNWZuSVVyeDRibXdXYVVmL1A4MTZxcGRUNjROQXRO?=
 =?utf-8?B?SDUxRUdhSlp2emVCQU1DZUVxVTVTT3FwVS90NmRVMitkeDU4NVozTFNTUWtX?=
 =?utf-8?B?eGd1ZzY2NU04K0U4aHN2TVZkT0JyUElBS24zS1N5bkNjbWZ0Q1FheEY1UlpM?=
 =?utf-8?B?Mm1BZUJqaWxHRnV3YlJnSTgxdnNoRjZ1aG92MXVXRlh6alVReU54KzNKeXdC?=
 =?utf-8?B?c3J1ZEVKSjVBRTNxc3IyVXBucUF0YXZRVDBpUy9BR1cwUzdSaGQzTzVtMFdV?=
 =?utf-8?B?N2NNVGZHWElBQi9TdGdHcWZvRXBKRW1sdkhuRmtvdjJSdGRkUGw3eVNWb0dt?=
 =?utf-8?B?eGNqY1duYkZDL3NuQ21qaUxuQk1EaHEyREZ2SXlMd0JManJJdDRHMzAzQW1i?=
 =?utf-8?B?ZHRRUWJwVytJRUxTcmp6QnVmRXFtM29BcG5XaHdHOEhpWmdGQy9OTmViQndi?=
 =?utf-8?B?N0JUNFVwSS9xY2MzUFZZMlhTdGNVTUVmMGk2ZnJxcGl2MWR4VjlQc3Vlci9h?=
 =?utf-8?B?THl0VTJSQ2djVWxSbXYzekZUYURmdUk5bmFnSGdTd2x3VUdmc29kRXFuNFJy?=
 =?utf-8?B?M1AxMmo4eHduTVYzODVVWG1iZGg1N3ltTmMxNGZGYXA0QktQV3czM1BOdHhj?=
 =?utf-8?B?QkwzVEFxRVErV0pWazR3RjNSNHdSaEFKSFlxUzBqWDNwTXNNeDFGbVJ0WE53?=
 =?utf-8?B?ZGlxdWpVWHVVMGlCSk9RZ2wyUXZIVUVaallGNXZYWHJVL21vOHU5RVJqZFhx?=
 =?utf-8?B?bXFxOXpkZWN6ejRtdHZOQ0ZNaUliV3hwaGpnaEJ5VTNiTGFrblBEQTVIQkFu?=
 =?utf-8?B?TlpybmNFd29uSGhxZ2lyTTlRaytyek11bUVrajZGR2RWR0NUUkJwb2NHWDNP?=
 =?utf-8?Q?REEI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc25363-2f99-4d3e-b79b-08dadeae32cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2022 15:08:18.3740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JpgP6ZsPVP20iC12PRUmJ73BD0eWLnr7AeF/9mrHChu4oHw7i53cL7a8om2+E1yZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFJlaW5ldHRlLA0KSSBhbSBw
bGFubmluZyByZWZyZXNoIHRoZSBzZXJpZXMuIEkgaGF2ZSBjb3VwbGUgb2YgY2hhbmdlcyBmb3Ig
cGF0Y2ggMTAuDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL01XM1BSMTJNQjQ1NTM4QTE3
RjU3QkY4MEMyMUJCNDZDNDk1MUQ5QE1XM1BSMTJNQjQ1NTMubmFtcHJkMTIucHJvZC5vdXRsb29r
LmNvbS8NCg0KTGV0IG1lIGtub3cgaWYgeW91IGhhdmUgYW55IG90aGVyIGNvbW1lbnRzLg0KVGhh
bmtzDQpCYWJ1DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTW9nZXIs
IEJhYnUgPEJhYnUuTW9nZXJAYW1kLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDEs
IDIwMjIgOTozNiBBTQ0KPiBUbzogY29yYmV0QGx3bi5uZXQ7IHJlaW5ldHRlLmNoYXRyZUBpbnRl
bC5jb207IHRnbHhAbGludXRyb25peC5kZTsNCj4gbWluZ29AcmVkaGF0LmNvbTsgYnBAYWxpZW44
LmRlDQo+IENjOiBmZW5naHVhLnl1QGludGVsLmNvbTsgZGF2ZS5oYW5zZW5AbGludXguaW50ZWwu
Y29tOyB4ODZAa2VybmVsLm9yZzsNCj4gaHBhQHp5dG9yLmNvbTsgcGF1bG1ja0BrZXJuZWwub3Jn
OyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOw0KPiBxdWljX25lZXJhanVAcXVpY2luYy5jb207
IHJkdW5sYXBAaW5mcmFkZWFkLm9yZzsNCj4gZGFtaWVuLmxlbW9hbEBvcGVuc291cmNlLndkYy5j
b207IHNvbmdtdWNodW5AYnl0ZWRhbmNlLmNvbTsNCj4gcGV0ZXJ6QGluZnJhZGVhZC5vcmc7IGpw
b2ltYm9lQGtlcm5lbC5vcmc7IHBib256aW5pQHJlZGhhdC5jb207IE1vZ2VyLA0KPiBCYWJ1IDxC
YWJ1Lk1vZ2VyQGFtZC5jb20+OyBjaGFuZy5zZW9rLmJhZUBpbnRlbC5jb207DQo+IHBhd2FuLmt1
bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbTsgam1hdHRzb25AZ29vZ2xlLmNvbTsNCj4gZGFuaWVs
LnNuZWRkb25AbGludXguaW50ZWwuY29tOyBEYXMxLCBTYW5kaXBhbiA8U2FuZGlwYW4uRGFzQGFt
ZC5jb20+Ow0KPiB0b255Lmx1Y2tAaW50ZWwuY29tOyBqYW1lcy5tb3JzZUBhcm0uY29tOyBsaW51
eC1kb2NAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBi
YWdhc2RvdG1lQGdtYWlsLmNvbTsgZXJhbmlhbkBnb29nbGUuY29tOw0KPiBjaHJpc3RvcGhlLmxl
cm95QGNzZ3JvdXAuZXU7IHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbTsNCj4gamFy
a2tvQGtlcm5lbC5vcmc7IGFkcmlhbi5odW50ZXJAaW50ZWwuY29tOyBxdWljX2ppbGVzQHF1aWNp
bmMuY29tOw0KPiBwZXRlcm5ld21hbkBnb29nbGUuY29tDQo+IFN1YmplY3Q6IFtQQVRDSCB2OSAw
MC8xM10gU3VwcG9ydCBmb3IgQU1EIFFvUyBuZXcgZmVhdHVyZXMNCj4gDQo+IE5ldyBBTUQgcHJv
Y2Vzc29ycyBjYW4gbm93IHN1cHBvcnQgZm9sbG93aW5nIFFvUyBmZWF0dXJlcy4NCj4gDQo+IDEu
IFNsb3cgTWVtb3J5IEJhbmR3aWR0aCBBbGxvY2F0aW9uIChTTUJBKQ0KPiAgICBXaXRoIHRoaXMg
ZmVhdHVyZSwgdGhlIFFPUyBlbmZvcmNlbWVudCBwb2xpY2llcyBjYW4gYmUgYXBwbGllZA0KPiAg
ICB0byB0aGUgZXh0ZXJuYWwgc2xvdyBtZW1vcnkgY29ubmVjdGVkIHRvIHRoZSBob3N0LiBRT1Mg
ZW5mb3JjZW1lbnQNCj4gICAgaXMgYWNjb21wbGlzaGVkIGJ5IGFzc2lnbmluZyBhIENsYXNzIE9m
IFNlcnZpY2UgKENPUykgdG8gYSBwcm9jZXNzb3INCj4gICAgYW5kIHNwZWNpZnlpbmcgYWxsb2Nh
dGlvbnMgb3IgbGltaXRzIGZvciB0aGF0IENPUyBmb3IgZWFjaCByZXNvdXJjZQ0KPiAgICB0byBi
ZSBhbGxvY2F0ZWQuDQo+IA0KPiAgICBDdXJyZW50bHksIENYTC5tZW1vcnkgaXMgdGhlIG9ubHkg
c3VwcG9ydGVkICJzbG93IiBtZW1vcnkgZGV2aWNlLiBXaXRoDQo+ICAgIHRoZSBzdXBwb3J0IG9m
IFNNQkEgZmVhdHVyZSB0aGUgaGFyZHdhcmUgZW5hYmxlcyBiYW5kd2lkdGggYWxsb2NhdGlvbg0K
PiAgICBvbiB0aGUgc2xvdyBtZW1vcnkgZGV2aWNlcy4NCj4gDQo+IDIuIEJhbmR3aWR0aCBNb25p
dG9yaW5nIEV2ZW50IENvbmZpZ3VyYXRpb24gKEJNRUMpDQo+ICAgIFRoZSBiYW5kd2lkdGggbW9u
aXRvcmluZyBldmVudHMgbWJtX3RvdGFsX2V2ZW50IGFuZCBtYm1fbG9jYWxfZXZlbnQNCj4gICAg
YXJlIHNldCB0byBjb3VudCBhbGwgdGhlIHRvdGFsIGFuZCBsb2NhbCByZWFkcy93cml0ZXMgcmVz
cGVjdGl2ZWx5Lg0KPiAgICBXaXRoIHRoZSBpbnRyb2R1Y3Rpb24gb2Ygc2xvdyBtZW1vcnksIHRo
ZSB0d28gY291bnRlcnMgYXJlIG5vdCBlbm91Z2gNCj4gICAgdG8gY291bnQgYWxsIHRoZSBkaWZm
ZXJlbnQgdHlwZXMgYXJlIG1lbW9yeSBldmVudHMuIFdpdGggdGhlIGZlYXR1cmUNCj4gICAgQk1F
QywgdGhlIHVzZXJzIGhhdmUgdGhlIG9wdGlvbiB0byBjb25maWd1cmUgbWJtX3RvdGFsX2V2ZW50
IGFuZA0KPiAgICBtYm1fbG9jYWxfZXZlbnQgdG8gY291bnQgdGhlIHNwZWNpZmljIHR5cGUgb2Yg
ZXZlbnRzLg0KPiANCj4gICAgRm9sbG93aW5nIGFyZSB0aGUgYml0bWFwcyBvZiBldmVudHMgc3Vw
cG9ydGVkLg0KPiAgICBCaXRzICAgIERlc2NyaXB0aW9uDQo+ICAgICAgNiAgICAgICBEaXJ0eSBW
aWN0aW1zIGZyb20gdGhlIFFPUyBkb21haW4gdG8gYWxsIHR5cGVzIG9mIG1lbW9yeQ0KPiAgICAg
IDUgICAgICAgUmVhZHMgdG8gc2xvdyBtZW1vcnkgaW4gdGhlIG5vbi1sb2NhbCBOVU1BIGRvbWFp
bg0KPiAgICAgIDQgICAgICAgUmVhZHMgdG8gc2xvdyBtZW1vcnkgaW4gdGhlIGxvY2FsIE5VTUEg
ZG9tYWluDQo+ICAgICAgMyAgICAgICBOb24tdGVtcG9yYWwgd3JpdGVzIHRvIG5vbi1sb2NhbCBO
VU1BIGRvbWFpbg0KPiAgICAgIDIgICAgICAgTm9uLXRlbXBvcmFsIHdyaXRlcyB0byBsb2NhbCBO
VU1BIGRvbWFpbg0KPiAgICAgIDEgICAgICAgUmVhZHMgdG8gbWVtb3J5IGluIHRoZSBub24tbG9j
YWwgTlVNQSBkb21haW4NCj4gICAgICAwICAgICAgIFJlYWRzIHRvIG1lbW9yeSBpbiB0aGUgbG9j
YWwgTlVNQSBkb21haW4NCj4gDQo+IFRoaXMgc2VyaWVzIGFkZHMgc3VwcG9ydCBmb3IgdGhlc2Ug
ZmVhdHVyZXMuDQo+IA0KPiBGZWF0dXJlIGRlc2NyaXB0aW9uIGlzIGF2YWlsYWJsZSBpbiB0aGUg
c3BlY2lmaWNhdGlvbiwgIkFNRDY0IFRlY2hub2xvZ3kNCj4gUGxhdGZvcm0gUXVhbGl0eSBvZiBT
ZXJ2aWNlIEV4dGVuc2lvbnMsIFJldmlzaW9uOiAxLjAzIFB1YmxpY2F0aW9uICMgNTYzNzUNCj4g
UmV2aXNpb246IDEuMDMgSXNzdWUgRGF0ZTogRmVicnVhcnkgMjAyMiIuDQo+IA0KPiBMaW5rOiBo
dHRwczovL3d3dy5hbWQuY29tL2VuL3N1cHBvcnQvdGVjaC1kb2NzL2FtZDY0LXRlY2hub2xvZ3kt
cGxhdGZvcm0tDQo+IHF1YWxpdHktc2VydmljZS1leHRlbnNpb25zDQo+IExpbms6IGh0dHBzOi8v
YnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjA2NTM3DQo+IC0tLQ0KPiB2OToN
Cj4gIFN1bW1hcnkgb2YgY2hhbmdlczoNCj4gIDEuIFJlYmFzZWQgb24gdG9wIG9mIGxhc3Rlc3Qg
dGlwL21hc3RlciBhcyBvZiAxMS8zMC4NCj4gIDIuIE1vc3Qgb2YgdGhlIGNoYW5nZXMgYXJlIHJl
c3VsdCBvZiB0aGUgY29tbWVudHMgZnJvbSBGZW5naHVhLCBSZWluZXR0ZSBhbmQNCj4gUGV0ZXIg
TmV3bWFuLg0KPiAgMy4gRml4ZWQgdGhlIGNwdWlkIGRlcGVuZGFuY3kuDQo+ICA0LiBBZGRlZCB0
aGUgX19pbml0IGF0dHJpYnV0ZSB0byByZHRfZ2V0X21vbl9sM19jb25maWcgYW5kDQo+IG1ibV9j
b25maWdfcmZ0eXBlX2luaXQuDQo+ICA1LiBBZGRlZCBuZXcgZnVuY3Rpb24gcmVzY3RybF9hcmNo
X3Jlc2V0X3JtaWRfYWxsIHRvIGNsZWFyIGFsbCBybWlkIHN0YXR1ZXMuDQo+ICA2LiBDaGFuZ2Vk
IG1vbl9ldmVudF9jb25maWdfaW5kZXhfZ2V0IGJhc2VkIG9uIFJlaW5ldHRlJ3MgY29tbWVudHMu
DQo+ICA3LiBDaGFuZ2VkIG1ibV9jb25maWdfcmZ0eXBlX2luaXQgdG8gdGFrZSBjYXJlIG9mIGZl
dyBleHRyYSBlcnJvciBoYW5kbGluZy4NCj4gIDguIEZldyBvdGhlciBtaW5vciBjaGFuZ2VzIGFu
ZCB0ZXh0IGNoYW5nZXMuDQo+IA0KPiB2ODoNCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xrbWwvMTY2NzU5MTg4MjY1LjMyODEyMDguMTE3NjkyNzcwNzk4MjY3NTQ0NTUucw0KPiB0Z2l0
QGJtb2dlci11YnVudHUvDQo+ICBDaGFuZ2VzOg0KPiAgMS4gUmVtb3ZlZCBpbml0IGF0dHJpYnV0
ZSBmb3IgcmR0X2NwdV9oYXMgdG8gbWFrZSBpdCBhdmFpbGFibGUgZm9yIGFsbCB0aGUgZmlsZXMu
DQo+ICAyLiBVcGRhdGVkIHRoZSBjaGFuZ2UgbG9nIGZvciBtb25fZmVhdHVyZXMgdG8gY29ycmVj
dCB0aGUgbmFtZXMgb2YgY29uZmlnDQo+IGZpbGVzLg0KPiAgMy4gQ2hhbmdlZCBjb25maWd1cmF0
aW9uIGZpbGUgbmFtZSBmcm9tIG1ibV90b3RhbF9jb25maWcgdG8NCj4gbWJtX3RvdGFsX2J5dGVz
X2NvbmZpZy4NCj4gICAgIFRoaXMgaXMgbW9yZSBjb25zaXN0YW50IHdpdGggb3RoZXIgY2hhbmdl
cy4NCj4gIDQuIEFkZGVkIGxvY2sgcHJvdGVjdGlvbiB3aGlsZSByZWFkaW5nL3dyaXRpbmcgdGhl
IGNvbmZpZyBmaWxlLg0KPiAgNS4gT3RoZXIgZmV3IG1pbm9yIHRleHQgY2hhbmdlcy4gSSBoYXZl
IGJlZW4gbWlzc2luZyBmZXcgY29tbWVudHMgaW4gbGFzdA0KPiBjb3VwbGUgb2YNCj4gICAgIHJl
dmlzaW9ucy4gSG9wZSBJIGhhdmUgYWRkcmVzc2VkIGFsbCBvZiB0aGVtIHRoaXMgdGltZS4NCj4g
DQo+IHY3Og0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8xNjY2MDQ1NDM4MzIu
NTM0NS45Njk2OTcwNDY5ODMwOTE5OTgyLnN0Z2l0QA0KPiBibW9nZXItdWJ1bnR1Lw0KPiAgQ2hh
bmdlczoNCj4gIE5vdCBtdWNoIG9mIGEgY2hhbmdlLiBNaXNzZWQgb25lIGNvbW1lbnQgZnJvbSBS
ZWluZXR0ZSBmcm9tIHY1LiBDb3JyZWN0ZWQNCj4gaXQgbm93Lg0KPiAgRmV3IGZvcm1hdCBjb3Jy
ZWN0aW9ucyBmcm9tIFNhbmpheWEuDQo+IA0KPiB2NjoNCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xrbWwvMTY2NTQzMzQ1NjA2LjIzODMwLjMxMjA2MjU0MDg2MDE1MzEzNjguc3RnaXQN
Cj4gQGJtb2dlci11YnVudHUvDQo+ICBTdW1tYXJ5IG9mIGNoYW5nZXM6DQo+ICAxLiBSZWJhc2Vk
IG9uIHRvcCBvZiBsYXN0ZXN0IHRpcCB0cmVlLiBGaXhlZCBmZXcgbWlub3IgY29uZmxpY3RzLg0K
PiAgMi4gRml4ZWQgZm9ybWF0IGlzc3VlIHdpdGggc2NhdHRlcmVkLmMuDQo+ICAzLiBSZW1vdmVk
IGNvbmZpZ19uYW1lIGZyb20gdGhlIHN0cnVjdHVyZSBtb25fZXZ0LiBJdCBpcyBub3QgcmVxdWly
ZWQuDQo+ICA0LiBUaGUgcmVhZC93cml0ZSBmb3JtYXQgZm9yIG1ibV90b3RhbF9jb25maWcgYW5k
IG1ibV9sb2NhbF9jb25maWcgd2lsbCBiZQ0KPiBzYW1lDQo+ICAgICBhcyBzY2hlbWF0YSBmb3Jt
YXQgImlkMD12YWwwO2lkMT12YWwxOy4uLiIuIFRoaXMgaXMgY29tbWVudCBmcm9tIEZlbmdodWEu
DQo+ICA1LiBBZGRlZCBtb3JlIGNvbW1lbnRzIE1TUl9JQTMyX0VWVF9DRkdfQkFTRSB3cml0bmcu
DQo+ICA1LiBGZXcgdGV4dCBjaGFuZ2VzIGluIHJlc2N0cmwucnN0DQo+IA0KPiB2NToNCj4gDQo+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMTY2NDMxMDE2NjE3LjM3MzM4Ny4xOTY4ODc1
MjgxMDgxMjUyNDY3LnN0Z2kNCj4gdEBibW9nZXItdWJ1bnR1Lw0KPiAgIFN1bW1hcnkgb2YgY2hh
bmdlcy4NCj4gICAxLiBTcGxpdCB0aGUgc2VyaWVzIGludG8gdHdvLiBUaGUgZmlyc3QgdHdvIHBh
dGNoZXMgYXJlIGJ1ZyBmaXhlcy4gU28sIHNlbnQgdGhlbQ0KPiBzZXBhcmF0ZS4NCj4gICAyLiBU
aGUgY29uZmlnIGZpbGVzIG1ibV90b3RhbF9jb25maWcgYW5kIG1ibV9sb2NhbF9jb25maWcgYXJl
IG5vdyB1bmRlcg0KPiAgICAgIC9zeXMvZnMvcmVzY3RybC9pbmZvL0wzX01PTi8uIFJlbW92ZWQg
dGhlc2UgY29uZmlnIGZpbGVzIGZyb20gbW9uIGdyb3Vwcy4NCj4gICAzLiBSYW4gImNoZWNrcGF0
Y2ggLS1zdHJpY3QgLS1jb2Rlc3BlbGwiIG9uIGFsbCB0aGUgcGF0Y2hlcy4gTG9va3MgZ29vZCB3
aXRoIGZldw0KPiBrbm93biBleGNlcHRpb25zLg0KPiAgIDQuIEZldyBtaW5vciB0ZXh0IGNoYW5n
ZXMgaW4gcmVzY3RybC5yc3QgZmlsZS4NCj4gDQo+IHY0Og0KPiANCj4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGttbC8xNjYyNTczNDgwODEuMTA0MzAxOC4xMTIyNzkyNDQ4ODc5MjMxNTkzMi5z
DQo+IHRnaXRAYm1vZ2VyLXVidW50dS8NCj4gICBHb3QgbnVtZXJpb3Mgb2YgY29tbWVudHMgZnJv
bSBSZWluZXR0ZSBDaGF0cmUuIEFkZHJlc3NlZCBtb3N0IG9mIHRoZW0uDQo+ICAgU3VtbWFyeSBv
ZiBjaGFuZ2VzLg0KPiAgIDEuIFJlbW92ZWQgbW9uX2NvbmZpZ3VyYWJsZSB1bmRlciAvc3lzL2Zz
L3Jlc2N0cmwvaW5mby9MM19NT04vLg0KPiAgIDIuIFVwZGF0ZWQgbW9uX2ZlYXR1cmVzIHRleHRz
IGlmIHRoZSBCTUVDIGlzIHN1cHBvcnRlZC4NCj4gICAzLiBBZGRlZCBtb3JlIGV4cGxhbmF0aW9u
IGFib3V0IHRoZSBzbG93IG1lbW9yeSBzdXBwb3J0Lg0KPiAgIDQuIFJlcGxhY2VkIHNtcF9jYWxs
X2Z1bmN0aW9uX21hbnkgd2l0aCBvbl9lYWNoX2NwdV9tYXNrIGNhbGwuDQo+ICAgNS4gUmVtb3Zl
ZCBhcmNoX2hhc19lbXB0eV9iaXRtYXBzDQo+ICAgNi4gRmV3IG90aGVyIHRleHQgY2hhbmdlcy4N
Cj4gICA3LiBSZW1vdmVkIFJldmlld2VkLWJ5IGlmIHRoZSBwYXRjaCBpcyBtb2RpZmllZC4NCj4g
ICA4LiBSZWJhc2VkIHRoZSBwYXRjaGVzIHRvIGxhdGVzdCB0aXAuDQo+IA0KPiB2MzoNCj4gDQo+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMTY2MTE3NTU5NzU2LjY2OTUuMTYwNDc0NjM1
MjY2MzQyOTA3MDEuc3RnaXQNCj4gQGJtb2dlci11YnVudHUvDQo+ICAgYS4gUmViYXNlZCB0aGUg
cGF0Y2hlcyB0byBsYXRlc3QgdGlwLiBSZXNvbHZlZCBzb21lIGNvbmZsaWN0cy4NCj4gICAgICBo
dHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90aXAvdGlwLmdp
dA0KPiAgIGIuIFRha2VuIGNhcmUgb2YgZmVlZGJhY2sgZnJvbSBCYWdhcyBTYW5qYXlhLg0KPiAg
IGMuIEFkZGVkIFJldmlld2VkIGJ5IGZyb20gTWluZ28uDQo+ICAgTm90ZTogSSBhbSBzdGlsbCBs
b29raW5nIGZvciBjb21tZW50cyBmcm9tIFJlaW5ldHRlIG9yIEZlbmdodWEuDQo+IA0KPiB2MjoN
Cj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMTY1OTM4NzE3MjIwLjcyNDk1OS4x
MDkzMTYyOTI4MzA4NzQ0Mzc4Mi5zdA0KPiBnaXRAYm1vZ2VyLXVidW50dS8NCj4gICBhLiBSZWJh
c2VkIHRoZSBwYXRjaGVzIHRvIGxhdGVzdCBzdGFibGUgdHJlZSAodjUuMTguMTUpLiBSZXNvbHZl
ZCBzb21lDQo+IGNvbmZsaWN0cy4NCj4gICBiLiBBZGRlZCB0aGUgcGF0Y2ggdG8gZml4IENCTSBp
c3N1ZSBvbiBBTUQuIFRoaXMgd2FzIG9yaWdpbmFsbHkgZGlzY3Vzc2VkDQo+ICAgICAgaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIyMDUxNzAwMTIzNC4zMTM3MTU3LTEtDQo+IGVyYW5p
YW5AZ29vZ2xlLmNvbS8NCj4gDQo+IHYxOg0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGttbC8xNjU3NTc1NDMyNTIuNDE2NDA4LjEzNTQ3MzM5MzA3MjM3NzEzNDY0LnN0DQo+IGdpdEBi
bW9nZXItdWJ1bnR1Lw0KPiANCj4gQmFidSBNb2dlciAoMTMpOg0KPiAgICAgICB4ODYvY3B1ZmVh
dHVyZXM6IEFkZCBTbG93IE1lbW9yeSBCYW5kd2lkdGggQWxsb2NhdGlvbiBmZWF0dXJlIGZsYWcN
Cj4gICAgICAgeDg2L3Jlc2N0cmw6IEFkZCBhIG5ldyByZXNvdXJjZSB0eXBlIFJEVF9SRVNPVVJD
RV9TTUJBDQo+ICAgICAgIHg4Ni9jcHVmZWF0dXJlczogQWRkIEJhbmR3aWR0aCBNb25pdG9yaW5n
IEV2ZW50IENvbmZpZ3VyYXRpb24gZmVhdHVyZQ0KPiBmbGFnDQo+ICAgICAgIHg4Ni9yZXNjdHJs
OiBJbmNsdWRlIG5ldyBmZWF0dXJlcyBpbiBjb21tYW5kIGxpbmUgb3B0aW9ucw0KPiAgICAgICB4
ODYvcmVzY3RybDogRGV0ZWN0IGFuZCBjb25maWd1cmUgU2xvdyBNZW1vcnkgQmFuZHdpZHRoIEFs
bG9jYXRpb24NCj4gICAgICAgeDg2L3Jlc2N0cmw6IEFkZCBfX2luaXQgYXR0cmlidXRlIHRvIHJk
dF9nZXRfbW9uX2wzX2NvbmZpZygpDQo+ICAgICAgIHg4Ni9yZXNjdHJsOiBJbnRyb2R1Y2UgZGF0
YSBzdHJ1Y3R1cmUgdG8gc3VwcG9ydCBtb25pdG9yIGNvbmZpZ3VyYXRpb24NCj4gICAgICAgeDg2
L3Jlc2N0cmw6IEFkZCBzeXNmcyBpbnRlcmZhY2UgdG8gcmVhZCBtYm1fdG90YWxfYnl0ZXNfY29u
ZmlnDQo+ICAgICAgIHg4Ni9yZXNjdHJsOiBBZGQgc3lzZnMgaW50ZXJmYWNlIHRvIHJlYWQgbWJt
X2xvY2FsX2J5dGVzX2NvbmZpZw0KPiAgICAgICB4ODYvcmVzY3RybDogQWRkIHN5c2ZzIGludGVy
ZmFjZSB0byB3cml0ZSBtYm1fdG90YWxfYnl0ZXNfY29uZmlnDQo+ICAgICAgIHg4Ni9yZXNjdHJs
OiBBZGQgc3lzZnMgaW50ZXJmYWNlIHRvIHdyaXRlIG1ibV9sb2NhbF9ieXRlc19jb25maWcNCj4g
ICAgICAgeDg2L3Jlc2N0cmw6IFJlcGxhY2Ugc21wX2NhbGxfZnVuY3Rpb25fbWFueSgpIHdpdGgg
b25fZWFjaF9jcHVfbWFzaygpDQo+ICAgICAgIERvY3VtZW50YXRpb24veDg2OiBVcGRhdGUgcmVz
Y3RybC5yc3QgZm9yIG5ldyBmZWF0dXJlcw0KPiANCj4gDQo+ICAuLi4vYWRtaW4tZ3VpZGUva2Vy
bmVsLXBhcmFtZXRlcnMudHh0ICAgICAgICAgfCAgIDIgKy0NCj4gIERvY3VtZW50YXRpb24veDg2
L3Jlc2N0cmwucnN0ICAgICAgICAgICAgICAgICB8IDEzOCArKysrKysrLQ0KPiAgYXJjaC94ODYv
aW5jbHVkZS9hc20vY3B1ZmVhdHVyZXMuaCAgICAgICAgICAgIHwgICAyICsNCj4gIGFyY2gveDg2
L2luY2x1ZGUvYXNtL21zci1pbmRleC5oICAgICAgICAgICAgICB8ICAgMiArDQo+ICBhcmNoL3g4
Ni9rZXJuZWwvY3B1L2NwdWlkLWRlcHMuYyAgICAgICAgICAgICAgfCAgIDIgKw0KPiAgYXJjaC94
ODYva2VybmVsL2NwdS9yZXNjdHJsL2NvcmUuYyAgICAgICAgICAgIHwgIDU0ICsrLQ0KPiAgYXJj
aC94ODYva2VybmVsL2NwdS9yZXNjdHJsL2N0cmxtb25kYXRhLmMgICAgIHwgICAyICstDQo+ICBh
cmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvaW50ZXJuYWwuaCAgICAgICAgfCAgMjggKysNCj4g
IGFyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9tb25pdG9yLmMgICAgICAgICB8ICAyNiArLQ0K
PiAgYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL3JkdGdyb3VwLmMgICAgICAgIHwgMzA5ICsr
KysrKysrKysrKysrKystLQ0KPiAgYXJjaC94ODYva2VybmVsL2NwdS9zY2F0dGVyZWQuYyAgICAg
ICAgICAgICAgIHwgICAyICsNCj4gIGluY2x1ZGUvbGludXgvcmVzY3RybC5oICAgICAgICAgICAg
ICAgICAgICAgICB8ICAxMCArDQo+ICAxMiBmaWxlcyBjaGFuZ2VkLCA1NDQgaW5zZXJ0aW9ucygr
KSwgMzMgZGVsZXRpb25zKC0pDQo+IA0KPiAtLQ0K
