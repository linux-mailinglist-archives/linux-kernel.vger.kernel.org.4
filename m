Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861D36511CF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 19:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbiLSS1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 13:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbiLSS1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 13:27:45 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F001C2;
        Mon, 19 Dec 2022 10:27:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERjcupQHbKwGVQrmc4MblP/3+W/f7WvZZpGzapsaYKhLFnvtcBvgo8B9C5gUIu+NxbJ8wmTjsR1Gb8RSxACouyq5wYv4Bsxz4dJchiIU62HiHiOq7LGcMG9KdGYb1nPtVRUowShcrOKgrcCyoffSf8aoz5u4Nov512BY5WEO9fwe7JcSNE3Y/j+fbZMFOjsCgLSWuMDrjbUKeHsPGWSfCel+P8sBVhjAeHg7OhoMhGkDKeQryBO416gj8CsuPeQ+dZHqoYNb8LClngHMPTsOvB2d+StdoA1FENcIx8AZAQ+95aDbPMURXo+TiFYkcM8wEmFQE7otNlOQBbRu4+0BTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Tlxl4/UXtr/Y+vmEiG0mOnLh7X3AJL2l5kvdb+0NWQ=;
 b=e1A4QZHzLJ8JYOSl1txWeeVVtdIRR1V7fSyTm//ZPq9eKC8SeYJzzcvqeOKs5gNk6Qe8OM0JJQhWCyR8zk4/YDDUCyunE411e4TprYVpEExkvBREQcW/27XxgMpoM3heolAWG9NwQFJnNC6CxROYy3Z+ZVWM2gPzzVovAqN20vq+VNvqgL7wpFShF5uOE2P5jKQfw+UqYA301m7BdojvP2wUhRZ9+Nujc6O2T04GbJb2t18025T2tqtH64E4ulVUZdSJcbSx4hMB8MW+im6nV9J+5++DKcWfRt3jEOlW8zPqtbfWF6c4WYWZGkEBrU1drtcQ0JSwGDJQ/TAc7YjrPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Tlxl4/UXtr/Y+vmEiG0mOnLh7X3AJL2l5kvdb+0NWQ=;
 b=Rr7ikCZXp0Wv+gDQ2//GiMYpS/ginE8h9JsgoEqZUDpmhkhtX6ysfNy0BM8EagX8xtEhvH01ZMNAji8+2y/nNE2VhqvhWQVf7+BxYV/9zOt/gBz1YJfIHxxKV5NpN/wY6s8YAvD2Kx/x1f1lb7T+DLoftqXs3oqGxXiPu1NJwSE=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB7574.namprd12.prod.outlook.com (2603:10b6:8:10e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 18:27:40 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%5]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 18:27:40 +0000
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
Subject: RE: [PATCH v9 09/13] x86/resctrl: Add sysfs interface to read
 mbm_local_bytes_config
Thread-Topic: [PATCH v9 09/13] x86/resctrl: Add sysfs interface to read
 mbm_local_bytes_config
Thread-Index: AQHZBZrQRIAWKyOE9Uim86BY+7f5ka5vTkAAgAZVg5A=
Date:   Mon, 19 Dec 2022 18:27:40 +0000
Message-ID: <MW3PR12MB4553D45CC8C4532B9740E4BC95E59@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
 <166990902305.17806.9650262646704189221.stgit@bmoger-ubuntu>
 <57b5dd79-9498-b450-25df-b9496bd46ec5@intel.com>
In-Reply-To: <57b5dd79-9498-b450-25df-b9496bd46ec5@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-19T18:27:01Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0941b2f4-977e-4ff6-80e0-fca6d333c2bb;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-19T18:27:39Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 66d0e979-6c58-47fd-9c41-af1e7b61cbe9
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|DM4PR12MB7574:EE_
x-ms-office365-filtering-correlation-id: 1191c58c-bc80-4e7c-0010-08dae1eeb65b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lOSyYU6EPqTZogHfxBvRcXfnfx8dNEYD7DqpyfhyJtUDhygUdVTJzbUg5JHvpi1C/A9m9f6xNv8dgh85nVlf9PBomE07MoAsz8bWjMumETtv8+pA8QR1LYTuWYiTg+83udgkCnmHxuNx/NUDCo2U+M/1RgTu3NGRMlKsn529KWSaIQH9pxTFvTEcdDnbGq3TYlotdBLSCP+KlEhLiONtSJLJcBAmOdihozXdIprQc5WyC3ZCgpfPoNmNjffaxhk9XPqI00WbBWh8lMmMBjF81kGSlohe6vB9nRsUjEW7QmF9XVYVIhCdR8+6GK0O4C9efkjB4Os7cxsUmRcN150aE6AI2cpD1Uhowk6EiAtUbR10mO290QqXAgz5hkNdluYfs4mF/wdq+C94JKsEM37xhdCJv8PaSghN62+Au7ph2atSoHeR8F14jDCVjnkZfRabgJoO4yBtZzq1e7J+fTrvBUkUXQglPDkGjzM7eIdb/XfODQq4fORhtaO5LK1Lk5OYrI+66wdyblqq7cQpOtKorfjHiQqtGAb1D57WHODHG7GoJKd/OWr0RMB5q4iJtcCY6fnq0N6uxe1xFbrF2PEna8mTxx+ApGj/Hz94Gt8MTmjjxTujfqE+TiKF3RECGc0sDpHInDnVsdCuEdwfpo6CMcGlMh/wsX4BU2ipi5mRJD5OYHXQUX1zZWeECBgYhw51w1HoLovsQPHi2wLDBo7fwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199015)(55016003)(38100700002)(54906003)(122000001)(478600001)(110136005)(2906002)(7416002)(7406005)(52536014)(316002)(66556008)(5660300002)(8936002)(64756008)(66446008)(66946007)(86362001)(66476007)(76116006)(4326008)(8676002)(186003)(26005)(83380400001)(71200400001)(38070700005)(41300700001)(33656002)(9686003)(7696005)(53546011)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VG8yNE5xVEpSQ2FsVW9kMVVFVkkxOW1kT3QzVkxjUUQwalNXSWtzcXVBNHVK?=
 =?utf-8?B?ay80dUdqa2hFREJ2aFNkRUpnZ0VVdU5XemNINHl5dzU1Y0c5cHJrd1Z6bUhO?=
 =?utf-8?B?SWZKcFZnTFQ3Uk9rSlFyU3U0a2tkaDdveWNNamFpTWNiTmxmWTZQQ1F3NjNh?=
 =?utf-8?B?MzlvMS9jS2VOL0t2d3F2NVhLVHRHcFdnaFNnS0dEV1pJTVZDK2JSaXU1ZW5H?=
 =?utf-8?B?S0hMWVdOT1lHQ0NKNUJaMnJZeVdBdDVUbUZ2U3ZBWnVOSlpJa0Nnb1htR2cv?=
 =?utf-8?B?SjRDbXJ5SXJON002cmJlblpXSUJybU9td2xQOE56Y2JsMDBiQ1FmeFhFUFRu?=
 =?utf-8?B?MlRWTmpqaExybTdTdmg1eDducGNxc3UydEJKNStMUXV4MnVKNjFjWXQ3VXJj?=
 =?utf-8?B?YmVoSEtYdXZYUENSOUZ3MzJFa3M4UFJhbWxGL2NsOENNSXBYa3RSOGxiN3I4?=
 =?utf-8?B?dE1EMlZXeTZKaFlKaWpyV3Zob1lnVUJXVWQ1ZG1ibjlEdEdqVFBrcEozZlc1?=
 =?utf-8?B?NjB4U0d4enZ1V21CZDFuWFB4aW9rRUhlUFlhRW1Bcm5xTDErZ1BzV1oyeWlw?=
 =?utf-8?B?Nlo3TVNwSmxraGc5QStWbm5ZZXR2cXc0U1JNMUU1STJZUFNIZ1lLeEhVMTVm?=
 =?utf-8?B?UmNvOGxGRHc3cXFiOGlSTENpekdjd1Y0UnNSNVpuNGlTUU5saDZEYmRmUXND?=
 =?utf-8?B?Zk1FWUhTT2VrWklFT2NGQ2V6MVlDN2VCTEhXWUtJdHgyOHJVVUJPcUFsMWFv?=
 =?utf-8?B?M3dSU3lEajBxM0gyNk1zd1FiUlFjSkc0b3kxU2RzczRDVm5QNUNYL1VlcXRX?=
 =?utf-8?B?RFFwdE5ZMXpFbGN0UnRxaVFkRWZaTWpzL3VPVTJpMXNyc3VFdkF2L3U0VFVZ?=
 =?utf-8?B?MytwaHJTVFh0ZmNYbFhaZXJqTzBwRkhMaVY1SER2QkF5ZEFWOVA1L243M2Ju?=
 =?utf-8?B?Q1c5MlFTSWhyUStWRHlpTThnZFlwalJhSEhtSEMxUkRaVWhvOWpzQXRjYncx?=
 =?utf-8?B?MlNWRkFHODJMZHRUUVpwVjRxZlhIZTNITWcyUDF1M2VjbXJhOXpxZjVkVnlv?=
 =?utf-8?B?TUk1R2VKOW5XRk1Eb1V1M2hGdFJremlqdHJHNXRJU3NoMFZ0SlF5L214MlA4?=
 =?utf-8?B?eUhxQktZRDVTOFhGVnpmbUYxZHZ4UXVSa3VzQ3o5NTEvYjlYRjdKMDJrL0JT?=
 =?utf-8?B?UUVQK2gxTVlFNUJKbUk1QzFjZmRGWnZodmJZQWdKVVR2SS9HZ3YrMlFqRlNn?=
 =?utf-8?B?K1IzRlVnZzFhdTZiVGdJRFkxV1JkOFlRQXNaaW9xR09Zb1d0VFFrdDUwVGR6?=
 =?utf-8?B?Zmp0SXRlbGNJRDJweUppa05DOWsxdEpqSVJqK0hFSmJSWmpOQWpzSXhwV1Qw?=
 =?utf-8?B?WmZWMENhZUJXL21lUk55anNyYTBqblYySUdyenF0Y3ZJYkxxUmNTditDcTJi?=
 =?utf-8?B?SWpJNVNRbG5hb2dubDRIKzhPZ1drYXM4dVd3NkhuRWwxZzlqeXZZVjdERGpY?=
 =?utf-8?B?MEUxR1RNK01qRFgvZWQ5Wk9kQ1lZbytFdEpIWUt6ZlNLbmlLaEVTMUVjL1FC?=
 =?utf-8?B?SmI0M3Q0eXlwZyt0K3lHRml3QWZhMzIvbXIxd1BPQXZpSStWOFcxK25HVzJV?=
 =?utf-8?B?NHBFM0xrSHNWRlJIcW1FUnYydkd1dTBJT2N6VEFUUUQxQWhRWDVXVnlhZXIx?=
 =?utf-8?B?V21yWjNnZHo4OUx0eXZ5d2tSbUNqc0VlWGhQQVBaZmNWWDRta1dBZmNBYjc5?=
 =?utf-8?B?YTkvVy83RmszMVhhWG5MY2ZpL0RhdjU3VW53bTIyODYzTmQ4aGdpNGY4ZWIx?=
 =?utf-8?B?MlA1VzlTcGZ0TVBXZzBCYzlCU0xTekU2S1dHdnRCazVXVnQwL3F4aDFiZTJM?=
 =?utf-8?B?UlJ2Z1UrbnloTUhnQVg0WDhLLzNkeHUzTHJmcGg3d0E2WjZORHZTRy83YzZX?=
 =?utf-8?B?TTQwT04vQlNQcTNMeUdnRncrQmppL0RRcDhmRGJaY2lDSWhMOStvS2NBUk4y?=
 =?utf-8?B?L3REWTdSdm8xeHNkcHZURUdPOEhmWld5TW8vT1kzdzNDNHVsS1NqYW8ycFpj?=
 =?utf-8?B?djlmTWhaSHNUT282WVJVaEtYNVE2SmVMeWowdUNuS2xNUXF5RzZKa1ZOUEwy?=
 =?utf-8?Q?TZPE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1191c58c-bc80-4e7c-0010-08dae1eeb65b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 18:27:40.3917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eEi7txLHGRG3DGCer+ers2/DORS8GYGWFjllKBYqzbvmw54vKiZj7Twq7cwMZSCC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7574
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
IDExOjQzIEFNDQo+IFRvOiBNb2dlciwgQmFidSA8QmFidS5Nb2dlckBhbWQuY29tPjsgY29yYmV0
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
ZXRlcm5ld21hbkBnb29nbGUuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjkgMDkvMTNdIHg4
Ni9yZXNjdHJsOiBBZGQgc3lzZnMgaW50ZXJmYWNlIHRvIHJlYWQNCj4gbWJtX2xvY2FsX2J5dGVz
X2NvbmZpZw0KPiANCj4gSGkgQmFidSwNCj4gDQo+IFNhbWUgYXMgb3RoZXIgY29tbWl0cyB0aGUg
c3ViamVjdCBjYW4gYmUgc2hvcnRlbmVkOg0KPiB4ODYvcmVzY3RybDogQWRkIGludGVyZmFjZSB0
byByZWFkIG1ibV9sb2NhbF9ieXRlc19jb25maWcNCg0KU3VyZS4NCj4gDQo+IE9uIDEyLzEvMjAy
MiA3OjM3IEFNLCBCYWJ1IE1vZ2VyIHdyb3RlOg0KPiA+IFRoZSBjdXJyZW50IGV2ZW50IGNvbmZp
Z3VyYXRpb24gY2FuIGJlIHZpZXdlZCBieSB0aGUgdXNlciBieSByZWFkaW5nDQo+ID4gdGhlIGNv
bmZpZ3VyYXRpb24gZmlsZSAvc3lzL2ZzL3Jlc2N0cmwvaW5mby9MM19NT04vbWJtX2xvY2FsX2J5
dGVzX2NvbmZpZy4NCj4gPiBUaGUgZXZlbnQgY29uZmlndXJhdGlvbiBzZXR0aW5ncyBhcmUgZG9t
YWluIHNwZWNpZmljIGFuZCB3aWxsIGFmZmVjdA0KPiA+IGFsbCB0aGUgQ1BVcyBpbiB0aGUgZG9t
YWluLg0KPiA+DQo+ID4gRm9sbG93aW5nIGFyZSB0aGUgdHlwZXMgb2YgZXZlbnRzIHN1cHBvcnRl
ZDoNCj4gPiA9PT09DQo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09DQo+ID4gQml0cyAgIERlc2NyaXB0aW9uDQo+ID4gPT09PQ0KPiA9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQ0KPiA+IDYgICAgICBEaXJ0eSBWaWN0aW1zIGZyb20gdGhlIFFPUyBkb21haW4gdG8gYWxsIHR5
cGVzIG9mIG1lbW9yeQ0KPiA+IDUgICAgICBSZWFkcyB0byBzbG93IG1lbW9yeSBpbiB0aGUgbm9u
LWxvY2FsIE5VTUEgZG9tYWluDQo+ID4gNCAgICAgIFJlYWRzIHRvIHNsb3cgbWVtb3J5IGluIHRo
ZSBsb2NhbCBOVU1BIGRvbWFpbg0KPiA+IDMgICAgICBOb24tdGVtcG9yYWwgd3JpdGVzIHRvIG5v
bi1sb2NhbCBOVU1BIGRvbWFpbg0KPiA+IDIgICAgICBOb24tdGVtcG9yYWwgd3JpdGVzIHRvIGxv
Y2FsIE5VTUEgZG9tYWluDQo+ID4gMSAgICAgIFJlYWRzIHRvIG1lbW9yeSBpbiB0aGUgbm9uLWxv
Y2FsIE5VTUEgZG9tYWluDQo+ID4gMCAgICAgIFJlYWRzIHRvIG1lbW9yeSBpbiB0aGUgbG9jYWwg
TlVNQSBkb21haW4NCj4gPiA9PT09DQo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID4NCj4gPiBCeSBkZWZhdWx0LCB0aGUgbWJt
X2xvY2FsX2J5dGVzX2NvbmZpZyBpcyBzZXQgdG8gMHgxNSB0byBjb3VudCBhbGwgdGhlDQo+ID4g
bG9jYWwgZXZlbnQgdHlwZXMuDQo+ID4NCj4gPiBGb3IgZXhhbXBsZToNCj4gPiAgICAgJGNhdCAv
c3lzL2ZzL3Jlc2N0cmwvaW5mby9MM19NT04vbWJtX2xvY2FsX2J5dGVzX2NvbmZpZw0KPiA+ICAg
ICAwPTB4MTU7MT0weDE1OzI9MHgxNTszPTB4MTUNCj4gPg0KPiA+ICAgICBJbiB0aGlzIGNhc2Us
IHRoZSBldmVudCBtYm1fbG9jYWxfYnl0ZXMgaXMgY3VycmVudGx5IGNvbmZpZ3VyZWQgd2l0aA0K
PiA+ICAgICAweDE1IG9uIGRvbWFpbnMgMCB0byAzLg0KPiANCj4gImN1cnJlbnRseSIgY2FuIGJl
IHJlbW92ZWQNCg0KU3VyZS4NCj4gDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCYWJ1IE1vZ2Vy
IDxiYWJ1Lm1vZ2VyQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gveDg2L2tlcm5lbC9jcHUv
cmVzY3RybC9tb25pdG9yLmMgIHwgICAgNCArKystDQo+ID4gIGFyY2gveDg2L2tlcm5lbC9jcHUv
cmVzY3RybC9yZHRncm91cC5jIHwgICAxNiArKysrKysrKysrKysrKysrDQo+ID4gIDIgZmlsZXMg
Y2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9tb25pdG9yLmMNCj4gPiBiL2FyY2gv
eDg2L2tlcm5lbC9jcHUvcmVzY3RybC9tb25pdG9yLmMNCj4gPiBpbmRleCAyYWZkZGViYzg2MzYu
LjdjOGEzYTc0NTA0MSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0
cmwvbW9uaXRvci5jDQo+ID4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL21vbml0
b3IuYw0KPiA+IEBAIC03ODgsOCArNzg4LDEwIEBAIGludCBfX2luaXQgcmR0X2dldF9tb25fbDNf
Y29uZmlnKHN0cnVjdA0KPiByZHRfcmVzb3VyY2UgKnIpDQo+ID4gIAkJCW1ibV90b3RhbF9ldmVu
dC5jb25maWd1cmFibGUgPSB0cnVlOw0KPiA+ICAJCQltYm1fY29uZmlnX3JmdHlwZV9pbml0KCJt
Ym1fdG90YWxfYnl0ZXNfY29uZmlnIik7DQo+ID4gIAkJfQ0KPiA+IC0JCWlmIChyZHRfY3B1X2hh
cyhYODZfRkVBVFVSRV9DUU1fTUJNX0xPQ0FMKSkNCj4gPiArCQlpZiAocmR0X2NwdV9oYXMoWDg2
X0ZFQVRVUkVfQ1FNX01CTV9MT0NBTCkpIHsNCj4gPiAgCQkJbWJtX2xvY2FsX2V2ZW50LmNvbmZp
Z3VyYWJsZSA9IHRydWU7DQo+ID4gKwkJCW1ibV9jb25maWdfcmZ0eXBlX2luaXQoIm1ibV9sb2Nh
bF9ieXRlc19jb25maWciKTsNCj4gPiArCQl9DQo+ID4gIAl9DQo+ID4NCj4gPiAgCWwzX21vbl9l
dnRfaW5pdChyKTsNCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJs
L3JkdGdyb3VwLmMNCj4gPiBiL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9yZHRncm91cC5j
DQo+ID4gaW5kZXggZTkzYjFjMjA2MTE2Li41ODBmM2NjZTE5ZTIgMTAwNjQ0DQo+ID4gLS0tIGEv
YXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL3JkdGdyb3VwLmMNCj4gPiArKysgYi9hcmNoL3g4
Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvcmR0Z3JvdXAuYw0KPiA+IEBAIC0xNTA3LDYgKzE1MDcsMTYg
QEAgc3RhdGljIGludCBtYm1fdG90YWxfYnl0ZXNfY29uZmlnX3Nob3coc3RydWN0DQo+IGtlcm5m
c19vcGVuX2ZpbGUgKm9mLA0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0
aWMgaW50IG1ibV9sb2NhbF9ieXRlc19jb25maWdfc2hvdyhzdHJ1Y3Qga2VybmZzX29wZW5fZmls
ZSAqb2YsDQo+ID4gKwkJCQkgICAgICAgc3RydWN0IHNlcV9maWxlICpzZXEsIHZvaWQgKnYpIHsN
Cj4gPiArCXN0cnVjdCByZHRfcmVzb3VyY2UgKnIgPSBvZi0+a24tPnBhcmVudC0+cHJpdjsNCj4g
PiArDQo+ID4gKwltYm1fY29uZmlnX3Nob3coc2VxLCByLCBRT1NfTDNfTUJNX0xPQ0FMX0VWRU5U
X0lEKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgLyogcmR0
Z3JvdXAgaW5mb3JtYXRpb24gZmlsZXMgZm9yIG9uZSBjYWNoZSByZXNvdXJjZS4gKi8gIHN0YXRp
Yw0KPiA+IHN0cnVjdCByZnR5cGUgcmVzX2NvbW1vbl9maWxlc1tdID0gew0KPiA+ICAJew0KPiA+
IEBAIC0xNjExLDYgKzE2MjEsMTIgQEAgc3RhdGljIHN0cnVjdCByZnR5cGUgcmVzX2NvbW1vbl9m
aWxlc1tdID0gew0KPiA+ICAJCS5rZl9vcHMJCT0gJnJkdGdyb3VwX2tmX3NpbmdsZV9vcHMsDQo+
ID4gIAkJLnNlcV9zaG93CT0gbWJtX3RvdGFsX2J5dGVzX2NvbmZpZ19zaG93LA0KPiA+ICAJfSwN
Cj4gPiArCXsNCj4gPiArCQkubmFtZQkJPSAibWJtX2xvY2FsX2J5dGVzX2NvbmZpZyIsDQo+ID4g
KwkJLm1vZGUJCT0gMDQ0NCwNCj4gPiArCQkua2Zfb3BzCQk9ICZyZHRncm91cF9rZl9zaW5nbGVf
b3BzLA0KPiA+ICsJCS5zZXFfc2hvdwk9IG1ibV9sb2NhbF9ieXRlc19jb25maWdfc2hvdywNCj4g
PiArCX0sDQo+ID4gIAl7DQo+ID4gIAkJLm5hbWUJCT0gImNwdXMiLA0KPiA+ICAJCS5tb2RlCQk9
IDA2NDQsDQo+ID4NCj4gPg0KPiANCj4gV2l0aCB0aGUgc3ViamVjdCBhbmQgY2hhbmdlbG9nIGNo
YW5nZXMgYWRkcmVzc2VkOg0KPiANCj4gUmV2aWV3ZWQtYnk6IFJlaW5ldHRlIENoYXRyZSA8cmVp
bmV0dGUuY2hhdHJlQGludGVsLmNvbT4NCg0KVGhhbmtzDQpCYWJ1DQo+IA0KPiBSZWluZXR0ZQ0K
