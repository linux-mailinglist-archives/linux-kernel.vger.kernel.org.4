Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4187E646594
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 01:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiLHADA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 19:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiLHACo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 19:02:44 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D600260FF;
        Wed,  7 Dec 2022 16:02:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQOtrk6nsOMJD5LoFUrdxzwhlW2TB/6Ujsqu6+5Vq+DmsWLDgBdo3iCOr3XtcpJWyqfofV8upkkl48w9oQGEfl10UFQtbOIVxBx6H0ntJgB/Exg6j+MNqLHcLciLBS1pQ/+iMyQ6mOx32+OXSbBhbfnaYkcQbF23iC4TimXAbmMXqJmqykDgirbUaYOjC2bPTmVQDR2IoEcI5HprmidZCTln3cu6MiDLT+ai2Npwy9oHGJSkVbdGY5HqFLpf1WQXAMesYOGuyN3aoAf+m/nRiH3Q4okndYBhEXxF6iR65IxvyrNhGfVGHjPS/k3d022TFdaO27Q1Styx+BqvpL5LTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gG+J1hzeRFSUF/6kTaLlIhUNzyut5EQFboMBM6kmJuU=;
 b=dEnkO5VN4uERTk5eWqktLKnIHEELAotfUjTBQS/f6a4EZAZNUIFUkUUfVHjY6DSab0g3n6xP4Qnn4LGzPY27oM2MpTSSguh77CRJSIPs5z/44bnxaJ7D8plmHaEq97P0QDXLoViBMTeIN+IZQxc824aoRCPPubEkDDkfy0SRI+4MRTcxnePPWUD9RrP7k0at490w3R/6+im2FPFw8g4A6r5JjvEPk7J5wPaquUKHyjD9ZQYVSR/GRa5MQj/Y2Gc33JxgdNj8u+/NnKGwzhgr7cAU+36Io8fWnp2YaTjevBZVnPs2IYSlxmF7jcscJt8YPFXN73EhRkB/gv9T/bDeUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gG+J1hzeRFSUF/6kTaLlIhUNzyut5EQFboMBM6kmJuU=;
 b=ZUofOHMYnEMIhF9X+jAU0KDJdjiv119FHik4F+67T2/e8ziQsqLLVud34ly0iG7l4REZXIUEK/vISiRpIvlighRD0VA/ZXKG0Xx3vPldU7P1t0dUmiXyfxU4LIa3H+ZuTdTDVTqo2MU+9WPKqdMSOBnXOIlfOq8A7ORfyYgAuXg=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ0PR12MB6880.namprd12.prod.outlook.com (2603:10b6:a03:485::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 00:02:31 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%5]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 00:02:31 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     James Morse <james.morse@arm.com>
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
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "eranian@google.com" <eranian@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>
Subject: RE: [PATCH v8 10/13] x86/resctrl: Add sysfs interface to write
 mbm_total_bytes_config
Thread-Topic: [PATCH v8 10/13] x86/resctrl: Add sysfs interface to write
 mbm_total_bytes_config
Thread-Index: AQHY8Ig1NUxgMo+j/USgNFOHQRk/GK5i31sAgABoqPA=
Date:   Thu, 8 Dec 2022 00:02:31 +0000
Message-ID: <MW3PR12MB45538A17F57BF80C21BB46C4951D9@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <166759188265.3281208.11769277079826754455.stgit@bmoger-ubuntu>
 <166759206900.3281208.11975514088019160962.stgit@bmoger-ubuntu>
 <7ce5bcda-bb42-4166-ab7e-8a07b8fb28a7@arm.com>
In-Reply-To: <7ce5bcda-bb42-4166-ab7e-8a07b8fb28a7@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-07T23:35:07Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6c351628-f3d4-4510-9994-df902b5a60c1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-08T00:02:29Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 615fd66e-65fc-4806-9b66-7b811a053eb6
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|SJ0PR12MB6880:EE_
x-ms-office365-filtering-correlation-id: 4d5ab1f5-ba41-41d3-53ae-08dad8af8066
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MtSRzaxby0airBTOhcg3ArzdTb6cywGQFRGIrEf8U6Z5qZ2sFCZM8PZzEO8qcNOC+uiRFxGLEfGqIN0Tod9o+XBq4UeIr7z7VcaE+T0pPx+iNqfGpDcuChNvP+YUdUrH3vS6vzvElM6QkGjN7L8phemwoXfGzFzxn8auGGtbQ4wI2TTWU364LzmKN24riwDwUPCUhOis4LkgTUsDDjSFDZJBaZxjWC2j7dhv0h2ZUMV2AIdlRfE60kUa9VtBx7zVR8JISvGr/fN19vulzZ3lXOYVbLOiAkab8ECNKuUi/UXz0rALfhQFbsIbRFSpX/nSeVcwKhXdw7HiuwJt75zq7DN1oWOVtzPogqcPfi9a9m1BLLWN7dGOA/kg9s3h4ASVeqzCZQuSQ4R0OZ+mIE9kQjXVsUAp0g5fiesqsbMs5dfCwU7ApCI2vyrpx6J4DeFqccvY9rd7K3AtImoP4oef+PjXm1QfopvixvrQW2HJ13x+mVi7W7lX2cCkyRqtoQMWM2RTzQEEzwG2gb8Joy8rGj0XZX6lBAupnDIHp/z82PoPk6l315KaF4c1kBO7QNryTtExZzAN4Y8BRyHg7+5TBHsBC3f6n06waQRuWXoOpLj8MAqI6E6tmZHVT+Q+JfJuW6XQ2d53QRulsLe8qPLn92/86O6o+HZRgdnQW5kVw1OR0ZpJzXpe7dnOWJb7Mj5Vc818SjlEQFucZmSeX5o4Gg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199015)(52536014)(71200400001)(55016003)(7416002)(2906002)(33656002)(83380400001)(38070700005)(4326008)(5660300002)(8936002)(76116006)(66446008)(38100700002)(6916009)(316002)(478600001)(186003)(54906003)(66946007)(66556008)(122000001)(86362001)(66476007)(41300700001)(8676002)(7696005)(64756008)(26005)(53546011)(9686003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUNFNHFVOGY3V1JValpwNnVCRTlJamhCbDkzODRsRnBmNXUzWlB4NEpRYllN?=
 =?utf-8?B?bk1US0k2MkFrcmg2cStMN3lIY3I3TEYwUDFOLzhtMTB5emt3amNIYk5rcWE2?=
 =?utf-8?B?YWJ1K1V1bVpwMjQ4bHRiTGJMdk42NVNjcWJMcVp2Rk5EbTliOXJsZnI3dWRL?=
 =?utf-8?B?UkRJcjJjQVcwZWpNcVpwSThsbU9Vc0tydGw2Z1FRVUxHdGhTNG1UcUNwNmsy?=
 =?utf-8?B?QXV2NXArVm9zL0tXMlhEVWFENUtjMktnWXUzMHBnaHRxM01TZXJlc1lqRWJR?=
 =?utf-8?B?cGpJM2NmSnNpYXhtT09OYlI4dDJmMFk4R1NiOEwzR2ZOcHBhaDZsbEdic3o3?=
 =?utf-8?B?ajVSTHNsZmhhOTdDVFMzaU4yeHQ0WUVRbDFPNmVicmE3RFl6TVJpTHova3B3?=
 =?utf-8?B?Z0thZjlXSmtFci9URitabXBoczlGZUFEWlhDbTFhdHE3YUdZK0ppTFRPc1FS?=
 =?utf-8?B?ZXZ4YlVaRTZydm1SK0ZURThuSSs4ZXUwYzFjS0lKZzQzSkVQa1MxZ2FBTW55?=
 =?utf-8?B?RUxvY0JmeVFmRVhDN1V2U0dYR081Mi9XR0FtL3JKSXNqUjA0cm9xbmRiL3Z3?=
 =?utf-8?B?TUJ3VmZCRmNxNW9MMkFtOC9qTG5sTTRkSm5XbnlmV0NLKzdlT3I4d1FoSTVY?=
 =?utf-8?B?bHQ1bkI0a0phc2NCUW5SMmhLZ0x2OG9FemdNUHdzYjZSNkR0L0NNR013M3Rm?=
 =?utf-8?B?NTZRdDF1OG1aNWFlZFlIRXM4TVA2WndSeFJHaFBlV0xKckI1UWhVZElBUnBz?=
 =?utf-8?B?Z2NTaXhMMnFhSVU0TFN6bnZZWVVYTGdkV0czY2lOYS9LS1poN3BHa2ZYT1lH?=
 =?utf-8?B?K3hmVmEyRVlqOEVQYmF4RXA3aDM0dVh4VitsNm1ucnZJa3pIaCtKUG1pc2FY?=
 =?utf-8?B?cHhZVUNoQjQ0STJuUlhBRkM5Wkp2Mjh6ZmtuWTZQcXM3eHFrd0tUZTd2UHFy?=
 =?utf-8?B?eXVtOW9DRXZKWFZJQnpLbHRBWUdkZFZHYk9RSUxHMVZOTWF6aCswTFV0alVI?=
 =?utf-8?B?M0ZwS2dCYUt2VXBRM2RHak1TTUZBZCtBYytiR1hQYStEZHJURWMwc1JMM2hm?=
 =?utf-8?B?N0lJb0dBQXQ1UTRRZEFQdVpydUt3K0dlSTNTMmxHNlhsTUxORzZQTnVoNkZa?=
 =?utf-8?B?YW5hanBwLzI3Ry9nczZlbmNUckJzY1lJM1E4aGJ5OEhKSytGZHJwNWdmbW02?=
 =?utf-8?B?RWh1UURybHQvZlhiRlpCTmFoTnJlK1lxcGIxYlBOY2d5Vkh3OFRXbTVnc3JM?=
 =?utf-8?B?b1VvYUhYQ0JMNlBoRDJCbXJES05sb3lxOTB3WDJDdWI0U3pOYkJvVW42dVdw?=
 =?utf-8?B?QVViNWMxWWJPcDh1TUFIOEJSd29VT3RCSFI5ZmptbXBNLzFXZUd3aHEwM0p6?=
 =?utf-8?B?WmlLRUN0eFpSRVZ6MlQvcEVFWjd6bE9wNmN4RUlPRUVzWmtwbWdMemFvNFhG?=
 =?utf-8?B?ajAvdnZUUDFjN1IzQksrOHowWTJiQU9WRlBNSkwvaUJ4aFNWMEw2dkNYc3Yz?=
 =?utf-8?B?UnhsNHE3Rzl2MWk3eWRHTFpyWnNNbHJqYkZmc2NEaGducU1VSHBBaVZIQWJP?=
 =?utf-8?B?NXBqSFVrMFAreGxIeWs0VFhEaFNTYmVveFdHZGZ2UFVwc0VsUjIvU3BRV1NI?=
 =?utf-8?B?b0w4dFVZQlNiZHkvSndVcGFSOVBCQ2M3cW85SEtaWVZGRXFzdERjMUpRa1ZK?=
 =?utf-8?B?OFIya09EZGYvbXZJdDkveFF0MTNad2hHeWhLMlJjTE5ZOVdQakZteVFjQkJ1?=
 =?utf-8?B?NU5YSjZpTXBOejBPYXBzMWdsclN0NVZMVmhzbzFPZjNxMVduZFBTaHlib0hp?=
 =?utf-8?B?L3diOVlNTzRRQ2paRzMyRVpUZVRhN0hBSWpLM2JXWW41MGpQa2V3VmU5VHov?=
 =?utf-8?B?MzBWMmR6czZGaWlVUnRHQmZlenlXbkFrdEpWR21jemtPd3c0ZnJWWlNZZEN6?=
 =?utf-8?B?MUVhRzE1Y1ZkNlpVSlE4OUZCUk5YUmM1WWp2RUhyYVpZMnlzM0ZEc0lWT21U?=
 =?utf-8?B?TzlJVGc5N1JLelN4VUppaXphbXRBUFE0cTl1NnVsRTlqZ0h5aFBkMXhoNkI1?=
 =?utf-8?B?dlBNK05oYlBYUkk0VHYxSndZcFcvSklkenVGaG14eUxyK3RkSW5NMFRDTkVC?=
 =?utf-8?Q?tySs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5ab1f5-ba41-41d3-53ae-08dad8af8066
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2022 00:02:31.1256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mmF9ogRbmCOCl9sdLp/ssFnBLzkJC38JnN7rUkkWi8XvomHgaYpq2TzeeHPSrKXb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6880
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEphbWVzLA0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEphbWVzIE1vcnNlIDxqYW1lcy5tb3JzZUBh
cm0uY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIERlY2VtYmVyIDcsIDIwMjIgMTE6MjEgQU0NCj4g
VG86IE1vZ2VyLCBCYWJ1IDxCYWJ1Lk1vZ2VyQGFtZC5jb20+DQo+IENjOiBmZW5naHVhLnl1QGlu
dGVsLmNvbTsgZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tOyB4ODZAa2VybmVsLm9yZzsNCj4g
aHBhQHp5dG9yLmNvbTsgcGF1bG1ja0BrZXJuZWwub3JnOyBha3BtQGxpbnV4LWZvdW5kYXRpb24u
b3JnOw0KPiBxdWljX25lZXJhanVAcXVpY2luYy5jb207IHJkdW5sYXBAaW5mcmFkZWFkLm9yZzsN
Cj4gZGFtaWVuLmxlbW9hbEBvcGVuc291cmNlLndkYy5jb207IHNvbmdtdWNodW5AYnl0ZWRhbmNl
LmNvbTsNCj4gcGV0ZXJ6QGluZnJhZGVhZC5vcmc7IGpwb2ltYm9lQGtlcm5lbC5vcmc7IHBib256
aW5pQHJlZGhhdC5jb207DQo+IGNoYW5nLnNlb2suYmFlQGludGVsLmNvbTsgcGF3YW4ua3VtYXIu
Z3VwdGFAbGludXguaW50ZWwuY29tOw0KPiBqbWF0dHNvbkBnb29nbGUuY29tOyBkYW5pZWwuc25l
ZGRvbkBsaW51eC5pbnRlbC5jb207IERhczEsIFNhbmRpcGFuDQo+IDxTYW5kaXBhbi5EYXNAYW1k
LmNvbT47IHRvbnkubHVja0BpbnRlbC5jb207IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7DQo+
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGJhZ2FzZG90bWVAZ21haWwuY29tOyBlcmFu
aWFuQGdvb2dsZS5jb207DQo+IGNvcmJldEBsd24ubmV0OyB0Z2x4QGxpbnV0cm9uaXguZGU7IG1p
bmdvQHJlZGhhdC5jb207IGJwQGFsaWVuOC5kZTsNCj4gcmVpbmV0dGUuY2hhdHJlQGludGVsLmNv
bQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY4IDEwLzEzXSB4ODYvcmVzY3RybDogQWRkIHN5c2Zz
IGludGVyZmFjZSB0byB3cml0ZQ0KPiBtYm1fdG90YWxfYnl0ZXNfY29uZmlnDQo+IA0KPiBIaSBC
YWJ1LA0KPiANCj4gKE5pdDogYWxsIHRoZSAnc3lzZnMnIGluIHRoZSBzdWJqZWN0cyBzaG91bGQg
cmVhbGx5IGJlICdyZXNjdHJsJywgYnV0IGFzIHRoZXkgYWxyZWFkeQ0KPiBoYXZlICd4ODYvcmVz
Y3RybCcsIGNvdWxkIHlvdSBqdXN0IHJlbW92ZSB0aGUgc3lzZnM/DQo+IFRoaXMgcGF0Y2ggd291
bGQgYmUgIng4Ni9yZXNjdHJsOiBBZGQgaW50ZXJmYWNlIHRvIHdyaXRlDQo+IG1ibV90b3RhbF9i
eXRlc19jb25maWciKQ0KDQpTdXJlLiBXaWxsIGNoYW5nZSBpdC4NCj4gDQo+IE9uIDA0LzExLzIw
MjIgMjA6MDEsIEJhYnUgTW9nZXIgd3JvdGU6DQo+ID4gVGhlIGN1cnJlbnQgZXZlbnQgY29uZmln
dXJhdGlvbiBmb3IgbWJtX3RvdGFsX2J5dGVzIGNhbiBiZSBjaGFuZ2VkIGJ5DQo+ID4gdGhlIHVz
ZXIgYnkgd3JpdGluZyB0byB0aGUgZmlsZQ0KPiA+IC9zeXMvZnMvcmVzY3RybC9pbmZvL0wzX01P
Ti9tYm1fdG90YWxfYnl0ZXNfY29uZmlnLg0KPiA+DQo+ID4gVGhlIGV2ZW50IGNvbmZpZ3VyYXRp
b24gc2V0dGluZ3MgYXJlIGRvbWFpbiBzcGVjaWZpYyBhbmQgd2lsbCBhZmZlY3QNCj4gPiBhbGwg
dGhlIENQVXMgaW4gdGhlIGRvbWFpbi4NCj4gPg0KPiA+IEZvbGxvd2luZyBhcmUgdGhlIHR5cGVz
IG9mIGV2ZW50cyBzdXBwb3J0ZWQ6DQo+ID4NCj4gPiA9PT09DQo+ID09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID4gQml0cyAgIERl
c2NyaXB0aW9uDQo+ID4gPT09PQ0KPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+IDYgICAgICBEaXJ0eSBWaWN0aW1zIGZyb20g
dGhlIFFPUyBkb21haW4gdG8gYWxsIHR5cGVzIG9mIG1lbW9yeQ0KPiA+IDUgICAgICBSZWFkcyB0
byBzbG93IG1lbW9yeSBpbiB0aGUgbm9uLWxvY2FsIE5VTUEgZG9tYWluDQo+ID4gNCAgICAgIFJl
YWRzIHRvIHNsb3cgbWVtb3J5IGluIHRoZSBsb2NhbCBOVU1BIGRvbWFpbg0KPiA+IDMgICAgICBO
b24tdGVtcG9yYWwgd3JpdGVzIHRvIG5vbi1sb2NhbCBOVU1BIGRvbWFpbg0KPiA+IDIgICAgICBO
b24tdGVtcG9yYWwgd3JpdGVzIHRvIGxvY2FsIE5VTUEgZG9tYWluDQo+ID4gMSAgICAgIFJlYWRz
IHRvIG1lbW9yeSBpbiB0aGUgbm9uLWxvY2FsIE5VTUEgZG9tYWluDQo+ID4gMCAgICAgIFJlYWRz
IHRvIG1lbW9yeSBpbiB0aGUgbG9jYWwgTlVNQSBkb21haW4NCj4gPiA9PT09DQo+ID09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID4N
Cj4gPiBGb3IgZXhhbXBsZToNCj4gPiBUbyBjaGFuZ2UgdGhlIG1ibV90b3RhbF9ieXRlcyB0byBj
b3VudCBvbmx5IHJlYWRzIG9uIGRvbWFpbiAwLCB0aGUNCj4gPiBiaXRzIDAsIDEsIDQgYW5kIDUg
bmVlZHMgdG8gYmUgc2V0LCB3aGljaCBpcyAxMTAwMTFiIChpbiBoZXggMHgzMykuDQo+ID4gUnVu
IHRoZSBjb21tYW5kLg0KPiA+IAkkZWNobyAgMD0weDMzID4gL3N5cy9mcy9yZXNjdHJsL2luZm8v
TDNfTU9OL21ibV90b3RhbF9ieXRlc19jb25maWcNCj4gPg0KPiA+IFRvIGNoYW5nZSB0aGUgbWJt
X3RvdGFsX2J5dGVzIHRvIGNvdW50IGFsbCB0aGUgc2xvdyBtZW1vcnkgcmVhZHMgb24NCj4gPiBk
b21haW4gMSwgdGhlIGJpdHMgNCBhbmQgNSBuZWVkcyB0byBiZSBzZXQgd2hpY2ggaXMgMTEwMDAw
YiAoaW4gaGV4IDB4MzApLg0KPiA+IFJ1biB0aGUgY29tbWFuZC4NCj4gPiAJJGVjaG8gIDE9MHgz
MCA+IC9zeXMvZnMvcmVzY3RybC9pbmZvL0wzX01PTi9tYm1fdG90YWxfYnl0ZXNfY29uZmlnDQo+
IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvcmR0Z3JvdXAu
Yw0KPiA+IGIvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL3JkdGdyb3VwLmMNCj4gPiBpbmRl
eCAxOGY5NTg4YTQxY2YuLjBjZGNjYjY5Mzg2ZSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9r
ZXJuZWwvY3B1L3Jlc2N0cmwvcmR0Z3JvdXAuYw0KPiA+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9j
cHUvcmVzY3RybC9yZHRncm91cC5jDQo+ID4gQEAgLTE1MDUsNiArMTUwNSwxMzMgQEAgc3RhdGlj
IGludCBtYm1fbG9jYWxfYnl0ZXNfY29uZmlnX3Nob3coc3RydWN0DQo+IGtlcm5mc19vcGVuX2Zp
bGUgKm9mLA0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCBt
b25fZXZlbnRfY29uZmlnX3dyaXRlKHZvaWQgKmluZm8pIHsNCj4gPiArCXN0cnVjdCBtb25fY29u
ZmlnX2luZm8gKm1vbl9pbmZvID0gaW5mbzsNCj4gPiArCXUzMiBpbmRleDsNCj4gPiArDQo+ID4g
KwlpbmRleCA9IG1vbl9ldmVudF9jb25maWdfaW5kZXhfZ2V0KG1vbl9pbmZvLT5ldnRpZCk7DQo+
ID4gKwlpZiAoaW5kZXggPj0gTUFYX0NPTkZJR19FVkVOVFMpIHsNCj4gPiArCQlwcl93YXJuX29u
Y2UoIkludmFsaWQgZXZlbnQgaWQgJWRcbiIsIG1vbl9pbmZvLT5ldnRpZCk7DQo+ID4gKwkJcmV0
dXJuOw0KPiA+ICsJfQ0KPiA+ICsJd3Jtc3IoTVNSX0lBMzJfRVZUX0NGR19CQVNFICsgaW5kZXgs
IG1vbl9pbmZvLT5tb25fY29uZmlnLCAwKTsNCj4gfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBt
Ym1fY29uZmlnX3dyaXRlKHN0cnVjdCByZHRfcmVzb3VyY2UgKnIsIHN0cnVjdCByZHRfZG9tYWlu
ICpkLA0KPiA+ICsJCQkgICAgdTMyIGV2dGlkLCB1MzIgdmFsKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1
Y3QgbW9uX2NvbmZpZ19pbmZvIG1vbl9pbmZvID0gezB9Ow0KPiA+ICsJaW50IHJldCA9IDA7DQo+
ID4gKw0KPiA+ICsJcmR0X2xhc3RfY21kX2NsZWFyKCk7DQo+ID4gKw0KPiA+ICsJLyogbW9uX2Nv
bmZpZyBjYW5ub3QgYmUgbW9yZSB0aGFuIHRoZSBzdXBwb3J0ZWQgc2V0IG9mIGV2ZW50cyAqLw0K
PiA+ICsJaWYgKHZhbCA+IE1BWF9FVlRfQ09ORklHX0JJVFMpIHsNCj4gPiArCQlyZHRfbGFzdF9j
bWRfcHV0cygiSW52YWxpZCBldmVudCBjb25maWd1cmF0aW9uXG4iKTsNCj4gPiArCQlyZXR1cm4g
LUVJTlZBTDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwkvKg0KPiA+ICsJICogUmVhZCB0aGUgY3Vy
cmVudCBjb25maWcgdmFsdWUgZmlyc3QuIElmIGJvdGggYXJlIHNhbWUgdGhlbg0KPiA+ICsJICog
d2UgZG9uJ3QgbmVlZCB0byB3cml0ZSBpdCBhZ2Fpbi4NCj4gPiArCSAqLw0KPiA+ICsJbW9uX2lu
Zm8uZXZ0aWQgPSBldnRpZDsNCj4gDQo+ID4gKwltb25kYXRhX2NvbmZpZ19yZWFkKGQsICZtb25f
aW5mbyk7DQo+IA0KPiBUaGlzIHJlYWRzIHRoZSBNU1Igb24gdGhpcyBDUFUsIHdoaWNoIGdldHMg
dGhlIHJlc3VsdCBmb3IgdGhpcyBkb21haW4uLi4NCg0KWzFdIE5vLiBUaGlzIHJlYWQgaGFwcGVu
cyBhdCB0aGUgdGFyZ2V0IGRvbWFpbi4gDQoNCnN0YXRpYyB2b2lkIG1vbmRhdGFfY29uZmlnX3Jl
YWQoc3RydWN0IHJkdF9kb21haW4gKmQsIHN0cnVjdCBtb25fY29uZmlnX2luZm8gKm1vbl9pbmZv
KQ0Kew0KICAgICAgICBzbXBfY2FsbF9mdW5jdGlvbl9hbnkoJmQtPmNwdV9tYXNrLCBtb25fZXZl
bnRfY29uZmlnX3JlYWQsIG1vbl9pbmZvLCAxKTsNCn0NCg0KPiANCj4gDQo+ID4gKwlpZiAobW9u
X2luZm8ubW9uX2NvbmZpZyA9PSB2YWwpDQo+ID4gKwkJZ290byB3cml0ZV9leGl0Ow0KPiA+ICsN
Cj4gPiArCW1vbl9pbmZvLm1vbl9jb25maWcgPSB2YWw7DQo+ID4gKw0KPiA+ICsJLyoNCj4gPiAr
CSAqIFVwZGF0ZSBNU1JfSUEzMl9FVlRfQ0ZHX0JBU0UgTVNScyBvbiBhbGwgdGhlIENQVXMgaW4g
dGhlDQo+ID4gKwkgKiBkb21haW4uIFRoZSBNU1JzIG9mZnNldCBmcm9tIE1TUiBNU1JfSUEzMl9F
VlRfQ0ZHX0JBU0UNCj4gPiArCSAqIGFyZSBzY29wZWQgYXQgdGhlIGRvbWFpbiBsZXZlbC4gV3Jp
dGluZyBhbnkgb2YgdGhlc2UgTVNScw0KPiA+ICsJICogb24gb25lIENQVSBpcyBzdXBwb3NlZCB0
byBiZSBvYnNlcnZlZCBieSBhbGwgQ1BVcyBpbiB0aGUNCj4gPiArCSAqIGRvbWFpbi4gSG93ZXZl
ciwgdGhlIGhhcmR3YXJlIHRlYW0gcmVjb21tZW5kcyB0byB1cGRhdGUNCj4gPiArCSAqIHRoZXNl
IE1TUnMgb24gYWxsIHRoZSBDUFVzIGluIHRoZSBkb21haW4uDQo+ID4gKwkgKi8NCj4gDQo+ID4g
Kwlvbl9lYWNoX2NwdV9tYXNrKCZkLT5jcHVfbWFzaywgbW9uX2V2ZW50X2NvbmZpZ193cml0ZSwN
Cj4gJm1vbl9pbmZvLA0KPiA+ICsxKTsNCj4gDQo+IC4uLiBidXQgaGVyZSB5b3UgSVBJIGFsbCB0
aGUgQ1BVcyBpbiB0aGUgdGFyZ2V0IGRvbWFpbiB0byB1cGRhdGUgdGhlbS4NCg0KWzJdIFRoZXJl
IGhhdmUgYmVlbiBzb21lIGNoYW5nZXMgaW4gdGhpcyBhcmVhIHJlY2VudGx5LiBUaGUgcmVxdWly
ZW1lbnQgb2Ygd3JpdGluZyB0aGUgdmFsdWUgb24gYWxsIHRoZSBDUFVzIGluIHRoZSBkb21haW4g
aXMgbm90IHJlcXVpcmVkIGFueW1vcmUuIEkgYW0gd29ya2luZyBvbiB2ZXJpZnlpbmcgdGhpcyBy
aWdodCBub3cuICBJZiBldmVyeXRoaW5nIHdvcmtzLCB0aGVuIEkgY2FuIGRvIA0Kc21wX2NhbGxf
ZnVuY3Rpb25fYW55KCZkLT5jcHVfbWFzaywgbW9uX2V2ZW50X2NvbmZpZ193cml0ZSwgICZtb25f
aW5mbywgMSk7DQoNCkkgd2lsbCBjb25maXJtIHRoaXMgc29vbi4NCg0KPiANCj4gVGhpcyBtZWFu
cyB5b3UgdW5uZWNlc3NhcmlseSBJUEkgdGhlIENQVXMgaW4gdGhlIHRhcmdldCBkb21haW4gaWYg
dGhleSBhbHJlYWR5DQo+IGhhZCB0aGlzIHZhbHVlLCBidXQgdGhlIHdyaXRlIHN5c2NhbGwgb2Nj
dXJyZWQgb24gYSBkb21haW4gdGhhdCBkaWZmZXJzLiBUaGlzIGlzbid0DQo+IHdoYXQgeW91IGlu
dGVuZGVkLCBidXQgaXRzIGJlbmlnbi4NCj4gTW9yZSBvZiBhIHByb2JsZW0gaXM6IFdvbid0IHRo
aXMgZ2V0IHNraXBwZWQgaWYgdGhlIHdyaXRlIHN5c2NhbGwgb2NjdXJzIG9uIGENCj4gZG9tYWlu
IHRoYXQgaGFwcGVucyB0byBoYXZlIHRoZSB0YXJnZXQgY29uZmlndXJhdGlvbiBhbHJlYWR5Pw0K
DQpEbyB5b3Ugc3RpbGwgdGhpbmsgdGhpcyBpcyBhIHByb2JsZW0gYWZ0ZXIgbXkgY29tbWVudCBb
MV0gYWJvdmU/ICBPciBBbSBJIG1pc3Npbmcgc29tZXRoaW5nPw0KDQo+IA0KPiBCZWNhdXNlIHlv
dSBuZWVkIHRoZSBzYW1lIHZhbHVlIHRvIGJlIHdyaXR0ZW4gb24gZXZlcnkgQ1BVIC4uLiB3aGF0
IGhhcHBlbnMNCj4gdG8gQ1BVcyB0aGF0IGFyZSBvZmZsaW5lIHdoZW4gdGhlIGNvbmZpZ3VyYXRp
b24gaXMgY2hhbmdlZD8gRG8gdGhleSBrZWVwIHRoZWlyDQo+IHByZXZpb3VzIHZhbHVlLCBvciBk
b2VzIGl0IGdldCByZXNldD8NCg0KVGhlIGNvbnRlbnRzIG9mIHRoaXMgTVNSIHJlZ2lzdGVyIGFy
ZSBoZWxkIG91dHNpZGUgb2YgYWxsIHRoZSBjb3Jlcy4gIElmIHRoZSB2YWx1ZSBjaGFuZ2VzIHdo
aWxlIGEgY3B1IGlzIG9mZmxpbmUsIGFuZCBpdCByZWFkcyBpdCBvbmNlIGl0IGNvbWVzIG9ubGlu
ZSwgaXQgd2lsbCBnZXQgdGhlIG5ldyB2YWx1ZS4NCj4gDQo+IA0KPiBJIHRoaW5rIHRoaXMgaXMg
YmVzdCBzb2x2ZWQgd2l0aCBhIHBlcmNwdSB2YXJpYWJsZSBmb3IgdGhlIGN1cnJlbnQgdmFsdWUg
b2YgdGhlDQo+IE1TUi4gWW91IGNhbiB0aGVuIHJlYWQgaXQgZm9yIENQVXMgaW4gYSByZW1vdGUg
ZG9tYWluLCBhbmQgb25seSBpc3N1ZSBJUElzIHRvDQo+ICdzeW5jJyB0aGUgdmFsdWUgaWYgbmVl
ZGVkLiBZb3UgY2FuIHRoZW4gcmUtdXNlIHRoZSBzeW5jIGNhbGwgaW4NCj4gcmVzY3RybF9vbmxp
bmVfY3B1KCkgdG8gc2V0IHRoZSBNU1IgdG8gd2hhdGV2ZXIgdmFsdWUgaXQgc2hvdWxkIGN1cnJl
bnRseSBiZS4NCg0KVGhpcyBtYXkgbm90IGJlIHJlcXVpcmVkIHdpdGggbXkgY29tbWVudCAxIGFu
ZCAyIGFib3ZlLg0KDQo+IA0KPiANCj4gPiArDQo+ID4gKwkvKg0KPiA+ICsJICogV2hlbiBhbiBF
dmVudCBDb25maWd1cmF0aW9uIGlzIGNoYW5nZWQsIHRoZSBiYW5kd2lkdGggY291bnRlcnMNCj4g
PiArCSAqIGZvciBhbGwgUk1JRHMgYW5kIEV2ZW50cyB3aWxsIGJlIGNsZWFyZWQgYnkgdGhlIGhh
cmR3YXJlLiBUaGUNCj4gPiArCSAqIGhhcmR3YXJlIGFsc28gc2V0cyBNU1JfSUEzMl9RTV9DVFIu
VW5hdmFpbGFibGUgKGJpdCA2MikgZm9yDQo+ID4gKwkgKiBldmVyeSBSTUlEIG9uIHRoZSBuZXh0
IHJlYWQgdG8gYW55IGV2ZW50IGZvciBldmVyeSBSTUlELg0KPiA+ICsJICogU3Vic2VxdWVudCBy
ZWFkcyB3aWxsIGhhdmUgTVNSX0lBMzJfUU1fQ1RSLlVuYXZhaWxhYmxlIChiaXQgNjIpDQo+ID4g
KwkgKiBjbGVhcmVkIHdoaWxlIGl0IGlzIHRyYWNrZWQgYnkgdGhlIGhhcmR3YXJlLiBDbGVhciB0
aGUNCj4gPiArCSAqIG1ibV9sb2NhbCBhbmQgbWJtX3RvdGFsIGNvdW50cyBmb3IgYWxsIHRoZSBS
TUlEcy4NCj4gPiArCSAqLw0KPiA+ICsJbWVtc2V0KGQtPm1ibV9sb2NhbCwgMCwgc2l6ZW9mKHN0
cnVjdCBtYm1fc3RhdGUpICogci0+bnVtX3JtaWQpOw0KPiA+ICsJbWVtc2V0KGQtPm1ibV90b3Rh
bCwgMCwgc2l6ZW9mKHN0cnVjdCBtYm1fc3RhdGUpICogci0+bnVtX3JtaWQpOw0KPiA+ICsNCj4g
PiArd3JpdGVfZXhpdDoNCj4gPiArCXJldHVybiByZXQ7DQo+ID4gK30NCj4gDQo+IA0KPiA+ICtz
dGF0aWMgaW50IG1vbl9jb25maWdfcGFyc2Uoc3RydWN0IHJkdF9yZXNvdXJjZSAqciwgY2hhciAq
dG9rLCB1MzINCj4gPiArZXZ0aWQpIHsNCj4gPiArCWNoYXIgKmRvbV9zdHIgPSBOVUxMLCAqaWRf
c3RyOw0KPiA+ICsJdW5zaWduZWQgbG9uZyBkb21faWQsIHZhbDsNCj4gPiArCXN0cnVjdCByZHRf
ZG9tYWluICpkOw0KPiA+ICsJaW50IHJldCA9IDA7DQo+ID4gKw0KPiA+ICtuZXh0Og0KPiA+ICsJ
aWYgKCF0b2sgfHwgdG9rWzBdID09ICdcMCcpDQo+ID4gKwkJcmV0dXJuIDA7DQo+ID4gKw0KPiA+
ICsJLyogU3RhcnQgcHJvY2Vzc2luZyB0aGUgc3RyaW5ncyBmb3IgZWFjaCBkb21haW4gKi8NCj4g
PiArCWRvbV9zdHIgPSBzdHJpbShzdHJzZXAoJnRvaywgIjsiKSk7DQo+ID4gKwlpZF9zdHIgPSBz
dHJzZXAoJmRvbV9zdHIsICI9Iik7DQo+ID4gKw0KPiA+ICsJaWYgKCFkb21fc3RyIHx8IGtzdHJ0
b3VsKGlkX3N0ciwgMTAsICZkb21faWQpKSB7DQo+ID4gKwkJcmR0X2xhc3RfY21kX3B1dHMoIk1p
c3NpbmcgJz0nIG9yIG5vbi1udW1lcmljIGRvbWFpbiBpZFxuIik7DQo+ID4gKwkJcmV0dXJuIC1F
SU5WQUw7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJaWYgKCFkb21fc3RyIHx8IGtzdHJ0b3VsKGRv
bV9zdHIsIDE2LCAmdmFsKSkgew0KPiA+ICsJCXJkdF9sYXN0X2NtZF9wdXRzKCJNaXNzaW5nICc9
JyBvciBub24tbnVtZXJpYyBldmVudA0KPiBjb25maWd1cmF0aW9uIHZhbHVlXG4iKTsNCj4gPiAr
CQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArCX0NCj4gDQo+IFRoaXMgaXMgcGFyc2luZyB0aGUgc2Ft
ZSBmb3JtYXQgc3RyaW5ncyBhcyBwYXJzZV9saW5lKCkuIElzIHRoZXJlIGFueSBjaGFuY2UgdGhh
dA0KPiBjb2RlIGNvdWxkIGJlIHJlLXVzZWQgaW5zdGVhZCBvZiBkdXBsaWNhdGVkPyBUaGlzIHdh
eSBhbnl0aGluZyB0aGF0IGlzIGFkZGVkIHRvDQo+IHRoZSBmb3JtYXQgKG9yIGJ1Z3MgZm91bmQh
KSBvbmx5IG5lZWQgc3VwcG9ydGluZyBpbiBvbmNlIHBsYWNlLg0KDQpJIGhhdmUgY2hlY2tlZCBv
biByZXVzaW5nIHRoZSBwYXJzZV9saW5lLiBUaGUgcGFyc2VfbGluZSBpcyBzcGVjaWZpY2FsbHkg
d3JpdHRlbiBmb3Igc2NoZW1hdGEuICBXZSBjYW4ndCByZXVzZSBwYXJzZV9saW5lIHdpdGhvdXQg
Y2hhbmdpbmcgaXQgY29tcGxldGVseS4NCg0KVGhhbmtzDQpCYWJ1DQo+IA0KPiANCj4gDQo+ID4g
KwlsaXN0X2Zvcl9lYWNoX2VudHJ5KGQsICZyLT5kb21haW5zLCBsaXN0KSB7DQo+ID4gKwkJaWYg
KGQtPmlkID09IGRvbV9pZCkgew0KPiA+ICsJCQlyZXQgPSBtYm1fY29uZmlnX3dyaXRlKHIsIGQs
IGV2dGlkLCB2YWwpOw0KPiA+ICsJCQlpZiAocmV0KQ0KPiA+ICsJCQkJcmV0dXJuIC1FSU5WQUw7
DQo+ID4gKwkJCWdvdG8gbmV4dDsNCj4gPiArCQl9DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0
dXJuIC1FSU5WQUw7DQo+ID4gK30NCj4gDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBKYW1lcw0K
