Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E35E6F8611
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 17:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjEEPng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 11:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbjEEPne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 11:43:34 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2392F1893A;
        Fri,  5 May 2023 08:43:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSdF0R6La7dkWY2XyRJuS6jScibxoBXlIZxFMDtuqAQt1pb4UilFjqzZ87d5LpV4+OfmWK7eXn1oky1DK6gNcIsoABBv7D4nmGw/rwHNw5Fu4VGJZ9dKBrP+HBZ0HXoa7+4sYRSV1FqbfmA71NvE5MmwygJRSl+kiqmog8aD99GXvdwu8MtRE59IhN/pk0X+Fk2F/qT1bIveLE14fyYGhb+5+SDImB2NPoDXhpZ+xrnYaqxvsbPWIbc4Glt2xFmEmJopvapjjVV6yTG+jMURSfRMwwCyGy1vrLTxiHU0Y9jUoauMg9/S7LMNMSu+NdjqNFzkeEkGRU/qjU1r3UtHOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YInP6b2Ztsp2cerLrh4AVLfIFgFIidTOkAaie+xuhek=;
 b=SOcBAz3SPMBwusw5l3s5hxjHqo3gkW5hx2VmN6Y9R8qr7PbpQHI00wyy+3RWAGEbVRhj/5+XyPZVTGZ0Q5nqmySMkBvpa2Cf6+hYsXVr7ZoeQeQbL9BCRNQe6/wAa7pUOypL0gWkJAqpx2d1AwjNW+LZoQN+ZL4wayHQxioq2FOabFlN3pJ2Q1X1BF3GGTwzpVVWstlrIouwqlM5dsAaFa73B7Ah80GPc5cdC1CH3BZAAY6k2Ap2ttYatuNbm98zxaA3by8gmBQ+FgUsxtogO0oWM1Oa6JX7wXGsepT0HMzOl5L+vgYmru/9XHwmqlqfMsB01hxMRVUI6/EocDLv+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YInP6b2Ztsp2cerLrh4AVLfIFgFIidTOkAaie+xuhek=;
 b=EUh8PViRxMnfX2wUZx+smiQs+urQLb4ZweAIxMnp+ZtDEPTKIQMpQEwIjnkjwMY8oSgW1m0+RPVGX5feMvFzOkd6G/tz/Rjrja3jq6xNag0Idzp8Hs0iK8f39x7CkKDUSpabTYegKSfMu3S4Uou6eL7cRiGi2osuRScfUZntl60=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ0PR12MB8116.namprd12.prod.outlook.com (2603:10b6:a03:4ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Fri, 5 May
 2023 15:43:12 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::216f:6f0f:4a21:5709]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::216f:6f0f:4a21:5709%5]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 15:43:12 +0000
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
Subject: RE: [PATCH v4 0/7] x86/resctrl: Miscellaneous resctrl features
Thread-Topic: [PATCH v4 0/7] x86/resctrl: Miscellaneous resctrl features
Thread-Index: AQHZcYUbuzTOXhwvqk6f00fV4pAStq9KkKAAgAFZlyA=
Date:   Fri, 5 May 2023 15:43:12 +0000
Message-ID: <MW3PR12MB455312E6A33BA29FD355745595729@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
 <d0e72b31-1865-9e23-51c9-5c43cd71084e@intel.com>
In-Reply-To: <d0e72b31-1865-9e23-51c9-5c43cd71084e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-05T15:43:11Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4abd4854-0460-443e-a843-47ee199b8048;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-05-05T15:43:11Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 54f14cbf-71e0-4b32-9744-1d40f2b4bf8f
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|SJ0PR12MB8116:EE_
x-ms-office365-filtering-correlation-id: 8f5c1caa-b886-4e7a-abe9-08db4d7f6f37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: glHzzx7aoMGQKiWZKOccDiclKQJXxbFtWpLYioIe9SAwVowJZD9k2w1iunkewK0iE19WOaDur2Kd8g2L6InqjXMI7xIN4n7fM2N2M2H1/Slm+5k6JA3rB4Higxqz7bHXIo0+5tnt2ElqYnB96u7YzELGn+wqIMX4jp4OD7AL6CrKcrMx6m80tZ+G/D/RRX+eXJpd19oC2oAfCaduCKN0T28VWNyuICK02+PSKrmZsNh60+2TfY2ykONColIXBwXqjeZwkflcHpqfeTpL2Q7s3lU/L0Npn4+JyvESfYsgtX3QOpesZzJV29gpWLyGpnXblnlp6LNSH5yW+0EORkK8QzhgjE51QLFYEMNGPEXbk2hEI4MTJPFUYF7Gr/Lt/drB8XpKjNH+V0bGn9v9Rn8SekvbGSNkJukQlr/x/yBbzbAdjmDtdWUDGnSMUwqxe6Jl0DMtY+R8Fl6EIWHQY8K9f2X8A/tPdchOo79EyEMSRqgszAjkfUMVoZoHSzs16g6HH4k+CTLz0a3jXyIx8w32Lj+uG3GhRiwnA3eXeE/4RRa5DY/VZO2pQqFB0P4b/uHpU0vRsQO7UmbVeuONUBXCLdbdUFYFfzuKD0i8ffWAj+Dz1/GTCmdmQaCPh3NitaLzBipdu3iunacabHCkV9tqvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199021)(5660300002)(7406005)(8936002)(52536014)(7416002)(66476007)(8676002)(86362001)(966005)(186003)(71200400001)(26005)(53546011)(6506007)(38100700002)(122000001)(83380400001)(38070700005)(9686003)(54906003)(41300700001)(478600001)(110136005)(7696005)(66946007)(33656002)(76116006)(64756008)(66446008)(55016003)(66556008)(2906002)(4326008)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzNTVjVPdXJBckx1MlhtTWFrKzBTVS80ZjhmL3dHMlpDck1ScEY2SXVLY2gz?=
 =?utf-8?B?a296THF1ZTBuZzVUdi8wMy9PNGVTMFM4WnZFc1IyWkd3bXd5ano1ZXNsUzRC?=
 =?utf-8?B?djk5aWRHemdIWWxCR3JHb2FkeWV4QWcrMnBad2xmRGYrVzRLdXdyL0tzeFVj?=
 =?utf-8?B?SzhLZURQbm1BbW1DK3VwR1NzS3VWY0RIVWhKamRzZjk2UnFBWjUxRkd6NHFZ?=
 =?utf-8?B?dll5Wk9BVVRML1BJRW8wYmNaMHRRQllGS1ZmMitHc1EwRzNrWk9acmc0M3pn?=
 =?utf-8?B?YUNrY0ZpT3pMTHUvT1d6V0ZhZ3NEeC8xbGFqZ08ySmNzUFJhMSt5TDMvRDkv?=
 =?utf-8?B?ZGE3UWdxN3ljcjZYSmJtdUdJT1k2bGE2SUl4SmdJZmVjcHlBN2ZMSW83czlZ?=
 =?utf-8?B?bFF3b1QvWGowTFR2b2VXYzN4RlVvTitWK0NYdDQzNW8rZG9GM2VHRnV2N0pM?=
 =?utf-8?B?blRjUVRYVXk0bmcwVTNpQTYxZmJKeGpmSm0vQzBMUVZ3U0dtelVFc1p5czhR?=
 =?utf-8?B?TlJyS1FKSkEwSjVGRjBlYmx3K20rMm9YRkxtR2dUdFJyZ3hweEFPNVR3TUpn?=
 =?utf-8?B?M0dWYVRyQlE5NjRTUlZtNCtoSVowMkVsNWNQSTVhbmxublNaQjhiYjRYRVNl?=
 =?utf-8?B?WXJEemxWNGVJZGNFdFlRQ01PTGhPR1llU3l4dW01TEt2YmlTNnFUdzcraHFT?=
 =?utf-8?B?c0dXeEJjb2pNS01ZRzFhTGMzb01iSS9KdTJpNTBDTzlFWnpoUGVWeWJQREU3?=
 =?utf-8?B?a3QyT0EwcFFFM0xjY3dlNWR1U2tKbkNTOHJoMEpmZWltQUdsUEVweEU5QkJv?=
 =?utf-8?B?czZjSzNHbHU1ZjV1UVlFcHM3eDBmUkZhVWFlQ1Z3ODBZNTE0UGRkc3hHM08w?=
 =?utf-8?B?MnFlMWhnTmhPaFVmczRHS3NMWExiN2VpVjZ6cS9hMm1RcWVESWZrK29ZRGdy?=
 =?utf-8?B?Rm5JcUx0dURNYUNCNmM1dXNaQ09DSDF1c0lpeHpDT0lYL0F1Z1VKU0lHbjFl?=
 =?utf-8?B?WDhMODdQRTNUaUFNRXFPemtXS3k0ZU1xOVk4QmEzYy81V3EwalZUTXR3Skt1?=
 =?utf-8?B?ZlVWUlB6S2toWnZLaFNQWFp3OXVZckF1TDhmR203alBDVkRsWGpFQytMYW0x?=
 =?utf-8?B?Q2QvQXhXd25CVCtPWXFXeUs4YjE3UTJDeWtVNlFIWmxmOGFxbTZqbFEvOENH?=
 =?utf-8?B?dWFkYnR4K0k2WkhSR2oyNFlsdEIrSmk3MTdjN293UXFLeEYrTnk3dmRjcSsz?=
 =?utf-8?B?YTZlYThldm9naHRzUGFUeWxuRFhWK00weHl6VVVuR01YRzJmbmhiZS9ZZkVh?=
 =?utf-8?B?am5TVzRxUDRZSWJCbWFrcmxGZmpUZEVBN3N5QndncFFvRGNaVDZYWjhiY1N1?=
 =?utf-8?B?c0Iwb1BZcUhuUE5KVGoybHgzc0lIWitYQjV5QVF2blRUdVVQU25ickZYOGVw?=
 =?utf-8?B?VmhLKzRnYVNBWjdhVk5UVHRRRWZCMkk5R2g4VC8rY2w2TnQvd21BQ3JteE5v?=
 =?utf-8?B?cCtUbHdPMjRLeXdETjVxUVFCYlpld0NtWW4rd1BUb0ZoTTErU1k3MFErVERo?=
 =?utf-8?B?L3FMSnlDT2pVQnZhK3BCTWk2Nm5rUms4WVFzYWkxcnlzbzh1cW4xQU5zbXA0?=
 =?utf-8?B?MEJSQWxSMHpxVytScmRZWHdkS3J4Yi83Y1Y4K3ppVlVnblRRSHl1VmNXUEp0?=
 =?utf-8?B?REFYcmVrNml3T2tKbUowaHVtaDJ6RmJ5dGhudU9TT0NzMmdFVDZnVWVmSklY?=
 =?utf-8?B?dUpWTTQrZHFxdU52Ujg4MGUvOUpMdU9QdENEMWIvY2M1cDVFRWFVYVdJclBS?=
 =?utf-8?B?MDZMcWhTcGdCQzN1UXFBMFU2S0N1VkVpZ2diWGNaM2VhY2xTdFdZYWJ5R21k?=
 =?utf-8?B?WUwvaC8yaUhUd2VNWnlXMXhMcmVZUHUxTU5kREFPWVllY1QrV1VMeWhvVmRH?=
 =?utf-8?B?VkUwK2lqK3g2S25QR2tUVjBpaWZDM091MEtJRUExMG9OZWMxSm9VcDFiZ3pw?=
 =?utf-8?B?Z09uWnR0VThkSUxXUUQrT1ZMQWVxbzJVRUdyY1N0TGFzcFRnK1FJVEpzdjFQ?=
 =?utf-8?B?NjBvQzVhZVp6Yk1LMDZzcGxqK1lHVjNUTTdlY25uZnl4bjdTcDlzeTNuUklQ?=
 =?utf-8?Q?NEso=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5c1caa-b886-4e7a-abe9-08db4d7f6f37
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 15:43:12.4739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3VYsJJKwncj0Y1r5CaCv9O4N7RSNkSd5Quj32jTdweQUE+IHltxnACGtU55JN9QR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8116
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFJlaW5ldHRlLA0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJlaW5ldHRlIENoYXRyZSA8cmVpbmV0
dGUuY2hhdHJlQGludGVsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE1heSA0LCAyMDIzIDE6NTQg
UE0NCj4gVG86IE1vZ2VyLCBCYWJ1IDxCYWJ1Lk1vZ2VyQGFtZC5jb20+OyBjb3JiZXRAbHduLm5l
dDsNCj4gdGdseEBsaW51dHJvbml4LmRlOyBtaW5nb0ByZWRoYXQuY29tOyBicEBhbGllbjguZGUN
Cj4gQ2M6IGZlbmdodWEueXVAaW50ZWwuY29tOyBkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb207
IHg4NkBrZXJuZWwub3JnOw0KPiBocGFAenl0b3IuY29tOyBwYXVsbWNrQGtlcm5lbC5vcmc7IGFr
cG1AbGludXgtZm91bmRhdGlvbi5vcmc7DQo+IHF1aWNfbmVlcmFqdUBxdWljaW5jLmNvbTsgcmR1
bmxhcEBpbmZyYWRlYWQub3JnOw0KPiBkYW1pZW4ubGVtb2FsQG9wZW5zb3VyY2Uud2RjLmNvbTsg
c29uZ211Y2h1bkBieXRlZGFuY2UuY29tOw0KPiBwZXRlcnpAaW5mcmFkZWFkLm9yZzsganBvaW1i
b2VAa2VybmVsLm9yZzsgcGJvbnppbmlAcmVkaGF0LmNvbTsNCj4gY2hhbmcuc2Vvay5iYWVAaW50
ZWwuY29tOyBwYXdhbi5rdW1hci5ndXB0YUBsaW51eC5pbnRlbC5jb207DQo+IGptYXR0c29uQGdv
b2dsZS5jb207IGRhbmllbC5zbmVkZG9uQGxpbnV4LmludGVsLmNvbTsgRGFzMSwgU2FuZGlwYW4N
Cj4gPFNhbmRpcGFuLkRhc0BhbWQuY29tPjsgdG9ueS5sdWNrQGludGVsLmNvbTsgamFtZXMubW9y
c2VAYXJtLmNvbTsNCj4gbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsNCj4gYmFnYXNkb3RtZUBnbWFpbC5jb207IGVyYW5pYW5AZ29vZ2xlLmNv
bTsgY2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1Ow0KPiBqYXJra29Aa2VybmVsLm9yZzsgYWRy
aWFuLmh1bnRlckBpbnRlbC5jb207IHF1aWNfamlsZXNAcXVpY2luYy5jb207DQo+IHBldGVybmV3
bWFuQGdvb2dsZS5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAwLzddIHg4Ni9yZXNjdHJs
OiBNaXNjZWxsYW5lb3VzIHJlc2N0cmwgZmVhdHVyZXMNCj4gDQo+IEhpIEJhYnUsDQo+IA0KPiBP
biA0LzE3LzIwMjMgNDozMyBQTSwgQmFidSBNb2dlciB3cm90ZToNCj4gPiBUaGVzZSBzZXJpZXMg
YWRkcyBzdXBwb3J0IGZldyBtaW5vciBmZWF0dXJlcy4NCj4gPiAxLiBTdXBwb3J0IGFzc2lnbmlu
ZyBtdWx0aXBsZSB0YXNrcyB0byBjb250cm9sL21vbiBncm91cHMgaW4gb25lIGNvbW1hbmQuDQo+
ID4gMi4gQWRkIGRlYnVnIG1vdW50IG9wdGlvbiBmb3IgcmVzY3RybCBpbnRlcmZhY2UuDQo+ID4g
My4gQWRkIFJNSUQgYW5kIENMT1NJRCBpbiByZXNjdHJsIGludGVyZmFjZSB3aGVuIG1vdW50ZWQg
d2l0aCBkZWJ1Zw0KPiBvcHRpb24uDQo+ID4gNC4gV2hpbGUgZG9pbmcgdGhlc2UgYWJvdmUgY2hh
bmdlcywgZm91bmQgdGhhdCByZnR5cGUgZmxhZ3MgbmVlZGVkIHNvbWUNCj4gY2xlYW51cC4NCj4g
PiAgICBUaGV5IHdlcmUgbmFtZWQgaW5jb25zaXN0ZW50bHkuIFJlLWFycmFuZ2VkIHRoZW0gbXVj
aCBtb3JlIGNsZWFubHkNCj4gbm93Lg0KPiA+ICAgIEhvcGUgaXQgY2FuIGhlbHAgZnV0dXJlIGFk
ZGl0aW9ucy4NCj4gPg0KPiA+IC0tLQ0KPiA+IHY0OiBDaGFuZ2VzIHNpbmNlIHYzDQo+ID4gICAg
IEFkZHJlc3NlZCBjb21tZW50cyBmcm9tIFJlaW5ldHRlIGFuZCBvdGhlcnMuDQo+ID4gICAgIFJl
bW92ZWQgbmV3bGluZSByZXF1aXJlbWVudCB3aGVuIGFkZGluZyB0YXNrcy4NCj4gPiAgICAgRHJv
cHBlZCBvbmUgb2YgdGhlIGNoYW5nZXMgb24gZmxhZ3MuIEtlcHQgdGhlIGZsYWcgbmFtZXMgbW9z
dGx5IHNhbWUuDQo+ID4gICAgIENoYW5nZWQgdGhlIG5hbWVzIG9mIGNsb3NpZCBhbmQgcm1pZCB0
byBjdHJsX2h3X2lkIGFuZCBtb25faHdfaWQNCj4gcmVzcGVjdGl2ZWx5Lg0KPiA+ICAgICBKYW1l
cyBoYWQgc29tZSBjb25jZXJucyBhYm91dCBhZGRpbmcgdGhlc2UgZmlsZXMuIEJ1dCBJIHRoaW5n
IGl0IGlzIGJpZw0KPiBwcm9ibGVtLg0KPiA+ICAgICBQbGVhc2UgY29tbWVudCBiYWNrIGlmIHdl
IGNhbiBkbyBiZXR0ZXIuDQo+IA0KPiBGcm9tIHdoYXQgSSB1bmRlcnN0YW5kIHRoZSBwcmltYXJ5
IGNvbmNlcm4gd2FzIHRoZSBuYW1pbmcgb2YgdGhlIGZpbGVzLCB3aGljaA0KPiB5b3UgYWRkcmVz
cyBpbiB0aGlzIHZlcnNpb24uDQo+IA0KPiBBIHNlY29uZCBwb2ludCBJIHNhdyB3YXMgYSByZXF1
ZXN0IGZvciBpbnNpZ2h0IGludG8gd2h5IHVzZXIgc3BhY2UgbWF5IG5lZWQNCj4gdGhpcyAoSmFt
ZXMgcmVjb21tZW5kZWQgb2JmdXNjYXRpb24gd2hlbiB2YWx1ZSBpcyBvbmx5IHNoYXJlZCBiZXR3
ZWVuDQo+IGtlcm5lbCBpbnRlcmZhY2VzKS4NCj4gWW91IGRpZCBhbnN3ZXIgdGhpcyBpbiB5b3Vy
IHJlc3BvbnNlIGFuZCBzaW5jZSB0aGVyZSB3YXMgbm8gZm9sbG93LXVwIEkNCj4gY3VycmVudGx5
IGFzc3VtZSB0aGF0IHRoaXMgaGFzIGJlZW4gYW5zd2VyZWQuDQo+IA0KPiBVbmxlc3Mgd2UgaGVh
ciBvdGhlcndpc2UgZnJvbSBKYW1lcyBJIHRodXMgYmVsaWV2ZSB0aGF0IGhpcyBmZWVkYmFjayBp
cw0KPiBhZGRyZXNzZWQuDQoNCk9rLiBTb3VuZHMgZ29vZC4NCg0KPiANCj4gPiAgICAgVHJpZWQg
dG8gYWRkcmVzcyBSZWluZXR0ZSdzIGNvbW1lbnQgb24gcGF0Y2ggNy4gQnV0IGR1ZSB0byBjdXJy
ZW50IGNvZGUNCj4gZGVzaWduDQo+ID4gICAgIEkgY291bGQgbm90IGRvIGl0IGV4YWN0IHdheS4g
QnV0IGNoYW5nZWQgaXQgbGl0dGxlIGJpdCB0byBtYWtlIGl0IGVhc3kgZGVidWcNCj4gPiAgICAg
ZmlsZSBhZGRpdGlvbnMgaW4gdGhlIGZ1dHVyZS4NCj4gDQo+IENvdWxkIHlvdSBwbGVhc2UgZWxh
Ym9yYXRlPyBJdCBhY3R1YWxseSBsb29rcyBsaWtlIHlvdSBtYXkgYmUgaGVhZGVkIHRoZXJlIG5l
eHQNCj4gYWNjb3JkaW5nIHRvOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzkzM2Q4
YWUyLWQ4YjctNzQzNi01OTE4LQ0KPiBmNjM5NDA1YzllY2JAYW1kLmNvbS8NCg0KU29ycnksIEkg
d2FzIHRhbGtpbmcgYWJvdXQgdGhpcyBjb21tZW50Lg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGttbC9mZWYxMmM5ZS03ZDZmLWJjZDQtZjkyZS1lNzc2ZWI5ZTY3M2JAaW50ZWwuY29tLw0KDQpJ
IHRyaWVkIHRvIGFkZHJlc3MgaXQgaGVyZS4gDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21s
LzE2ODE3NzQ1MTAxMC4xNzU4ODQ3LjU2ODIxODQ5MTUyODI5NzQ1MS5zdGdpdEBibW9nZXItdWJ1
bnR1Lw0KDQpUaGlzIG1heSBub3QgYmUgdGhlIGV4YWN0IHdheSB5b3UgbWVudGlvbmVkLiAgUmVh
c29uIGlzLCBhZGRpbmcgdGhlIGZsYWdzIGJlZm9yZSByZHRncm91cF9hZGRfZmlsZXMgY2Fubm90
IGJlIGRvbmUuIEl0IGRvZXMgbm90IHVwZGF0ZSB0aGUgcmVzY3RybCByb290IGZpbGVzeXN0ZW0u
DQpUaGVzZSBmaWxlcyBoYXZlIHRvIGFkZGVkIGJ5IGNhbGxpbmcgcmR0Z3JvdXBfYWRkX2ZpbGUg
YW5kIGtlcm5mc19hY3RpdmF0ZSBpbiByZHRfZW5hYmxlX2N0eC4NClRoYW5rcw0KQmFidQ0KDQo=
