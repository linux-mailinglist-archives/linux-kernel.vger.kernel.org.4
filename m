Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA786643FD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238285AbjAJPD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbjAJPDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:03:14 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA3C5DE7D;
        Tue, 10 Jan 2023 07:02:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZ7QODZeiM10o0awBkgLU2Ej1U7LDJrTHxT1AXVx+yjHjVEP04S7sPFamWo25vH7jOmiA+zzhSTxfSpRX6h8Ez1hI9yEjK+41xUmMHu2DsJU6rVFsxP5A3P086KwspIFdd1zbcFXe1GizPjxk8ljdhGU740+/j28D5ycOiv5U1kmQWzgHJ4ZEV8S6oXP1IV5GfG2YdDqtgFuhWo0cfpLTNAd3ot1u8Y7pB1mvgd1vXmxsPzMl9XqlAId39EplFrn4bGIArbjFlzgaCsufZCQ/H7vII7ezuI5G+rmLwbyVWhmIs+vkdv9Wzf8Azd1Q8yDfUzFOGI1Wq69mAVFrQAo+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0ledbvKfmU0P4RQ6/NdtRmxsiIkIxk0TLo75uwu7P4=;
 b=kgO3OpdmpmGBKsyGFwWQ9Q3E4kow8VNfZum8hOV8+E7+LmETCNcwxeR1uQfvndnfjyMUoSR3ER/QmznW2TGwTaDBnd0j+ldV0jpIxtn5hG7YzQqJUy6hBypmu71Q+70nJ3AgkrnW73k2+YP9dedXJ5WSzhCOdNC5jUUCEYxa605TH+rsj7FZ0RSLZ6C4Jbqadlec93lrDvfa78sKKAbjy6psPeFKGMWfT4Pf6UXWRq4aWM3poMks0WGUL5u1Vh96Sv0J6Ghfb/UEu9RtNfDFP2IggyIqn+O9fkO0ZUkuTVK1HlEK3RD0cRqXRHzIP7/+OMd5ZpLKRn4cjgJO2dAidA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0ledbvKfmU0P4RQ6/NdtRmxsiIkIxk0TLo75uwu7P4=;
 b=FQE7uo42b3YnjaSnu3xH8DiKbLkDJtMverx0qsF3HO+WudvuO6etCwHhOHPo6UseCh+QeqtIF9IipLv0AT0N52RV537VyaKSZivlLmH5l87SDnG0MQZ/lwfFZFygFR9Ayqy8tqDMOrpErgN/hQl1/0g5lXsuiuUUteZW646bC0k=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by CH2PR12MB4263.namprd12.prod.outlook.com (2603:10b6:610:a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 15:02:53 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed%7]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 15:02:53 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] cpufreq: amd-pstate: fix kernel hang issue while
 amd-pstate unregistering
Thread-Topic: [PATCH v2] cpufreq: amd-pstate: fix kernel hang issue while
 amd-pstate unregistering
Thread-Index: AQHZJPINTK0PqeAMqE2QJ8mOse67Ga6XnE0AgAAgpnA=
Date:   Tue, 10 Jan 2023 15:02:52 +0000
Message-ID: <DM4PR12MB5278AFE3DA531200BE960EED9CFF9@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20230110124940.1622798-1-perry.yuan@amd.com>
 <CAJZ5v0j1ioh5aSRMB8DTvtKzX22n3AmLfgmDmbKCYQMAoJx6aQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0j1ioh5aSRMB8DTvtKzX22n3AmLfgmDmbKCYQMAoJx6aQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-10T15:02:50Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=923e4197-8182-411d-ab11-cc813ec728dd;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-01-10T15:02:50Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 9a6788eb-eae5-4bed-b1f4-83b1f749afe9
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|CH2PR12MB4263:EE_
x-ms-office365-filtering-correlation-id: 76ef6330-bcfb-4ebe-f99a-08daf31bbf92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: frfgE7jhRweZ7ncmtyurRX7/08xfcZpvPM62gj77Dgr2tCzp6Gbe4fMjXE7gfzNcuOg4y8dpJSdRiRhT0SGnJQ7n7qwK7ZMiHlg/IO8EjAOa5Wf0FDRGr686VhlAf0RKGOBL2Cyo7vckEc4SWjPZWs8mXzo0efz+gGJxtD2wiaay05sacAGVPjMxxcRB/8p62YOFOBNzQt3F6GtUfwnOR/XmAShdvy6iiQtu0R/b8ZLn4axFY2lmIhG9EtYHrBoMrVRMnmwR220L6wHlT0vX2XDkUd+u9o0ebhO5HCcqTzODAfrNrluER3Z7EjXNDLaBTdb5yXHA1EvjyhEt8E1f4p9c5eZBOqxFT4ZaW0aGa/3ywwZQ3eramsM/BP4Wa1ASAOlsZMXUM7k2gevrVONLup0Qp4eczD/Drg7xM2tEZHgn+lROVj3GkgHyMT9wA3LIikZds8+Cg+1siLo4mqvOwr56ghOmyKqThFEamgULKr8nhno3AUEOWc/t7PSe4lot8PtIpNOHRpxQdXN5E86JjYey048pNYwXn5n9QSb59TX0jFRPcceD39SGm2bcM+erKFrWxVw4QWxwBjGM0zmp3ZQw2fjM4gweICRlzttRV1KRRfHR7RiS8dAzlyMMIh5bKZw1nBiqcwtiufreFBa64li2Qv//hTQ4BrIK4TWrbL+shneN9+skHTVl1h8RxgoWiLVMsVumqR1E7CjC+iu6tQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199015)(6506007)(122000001)(38100700002)(2906002)(53546011)(33656002)(38070700005)(26005)(7696005)(186003)(9686003)(478600001)(71200400001)(316002)(5660300002)(8936002)(52536014)(83380400001)(86362001)(41300700001)(55016003)(66446008)(76116006)(8676002)(4326008)(54906003)(66556008)(64756008)(66476007)(66946007)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGtqeFJHUHN0ZE1NOVU0a2ZMZzIzWktPd3hzdS9idEt3VE9hQ1VDaXhSOXk0?=
 =?utf-8?B?R1N1YTJiWVN6OWVIYXVRaDZuaW9ZK3FCekJGMlRhV0g3Yko1SWhvWjFESnFa?=
 =?utf-8?B?Q2JRc2lVNitDeVR1Sml2V0lzYmUzMHRnbHdmV3RBR3lDem1seVRnalFGQlJt?=
 =?utf-8?B?SmE1OTlvUHAzc1o5dk1BWUphYzRjbzZYeGkyWHpJTkEzaVJnQ0xKL3RaNU5P?=
 =?utf-8?B?QVQ2RFV0R2krZWRQbEZUYzZCS0tMVHRYYmw4Yk9la2lLN0phVUg4dGhNV3JN?=
 =?utf-8?B?RndSMEZ2ck5SejRiL2l2b3Q0V3hkdlVYV3EvT3NpSVdmNDE0OURKL082anFW?=
 =?utf-8?B?RnZUMUdHcVdMNStNZG1FbU9nTW5zdWVPVEI0QVc5bEZVdFA5RXdrMVY5NFpu?=
 =?utf-8?B?Qm1zT0wxMzdPbzNOR0RVdG0wdXd0VGN2Z2NQTVlUb0xwTGR5eVloVVBEUE1a?=
 =?utf-8?B?RTZ2VTNQb3BNaG8yZlVoMUFkTnlIcGpaN2l5QXFDU1FiZFRDSDh0M3ZWZ1d5?=
 =?utf-8?B?L3N4ZDR3U2s1NVJobVdySEh2aytVbGlzbXowRjRrd1FCZ2VHbDFPTHlFNVo2?=
 =?utf-8?B?eTJnYjU2QmNJNXhtc0ZKVEwyamMrWUVKbnlpSDhkY0k0TjE4bFEwL0htK1gv?=
 =?utf-8?B?emtLelhZNURRM0hqK1JPUlpJTGZ6aDZZMWRES04rWFNFYit3czNTSVpMRS9l?=
 =?utf-8?B?MXVhYU5sakZXOVN5VEdZNXJGczA0WCt2MGxvZlQrVW5BRHB5NEtXUHQzUWZt?=
 =?utf-8?B?c24walo2M2ZTSXFVNUcrNzNudEgveUZ1MzNqQ09ZTlg5TGpBM2ZkQ1hJL3VO?=
 =?utf-8?B?aDJ3ak1TQUFwS2hWZlhGVDdMNUhVaFJ6NDl5dDRPK0lycGFhb09yNmFiVnZM?=
 =?utf-8?B?WE9CRks4bHA0enFoK213VnVMSDlIcjVXL0FIVUVzZ2FyYlFCRTN0VGRoUEg4?=
 =?utf-8?B?YldFUENLV1BYMUFDUjRONUx2aXRIRWI1bmFyTkN4NlY2a1pMdVB3aERpd2dL?=
 =?utf-8?B?RUZoV2dTZGZVdE5Gd05FbFJUQUVldVpYYUhhTlh3Y1NuMWxtQmtMZjNDeDRY?=
 =?utf-8?B?QzdvRnk4MGZzcmVGSW55Yk5QekxmUXhxNE05R0IyU1NPNElHZVozeVczK2VE?=
 =?utf-8?B?cWRnV2tlckJrVXAxcVdoZDk4Yis5TWdkYkVoQUY0RnEweWQzd3JiN1ZQS1Ft?=
 =?utf-8?B?UHkwZUJZWmRhMnZKV2pPZ3RPc1QrMkwxem8wM3pUZnNLeVBlQVBlNjg0V1Y3?=
 =?utf-8?B?ck5WVWtDNXRNNVdmd1pLWDFhYnNRNUlFS3UvRWk0UlluYjhpTURCdzVXaHhh?=
 =?utf-8?B?ZCtyUWJiT0RhSVd4U09xdU95NUliU3RWbm5McWIvRDB0Z0kzL1hSMVJGTE5W?=
 =?utf-8?B?SnJCOWNpQ29kR1BxRHZKNytTaFVSYmVnQmp5cHRMa3h4T2tjOHVqc2FmeWNi?=
 =?utf-8?B?V0lEYk1JYkFhY2NLOEJlNlFRRVRIb3R0ckdpZTAxalAvNU8zVG1xeml5WVY3?=
 =?utf-8?B?NjBSVkFNdHRtR0lvbVgrcTdpbVdNZDdpYi9Bb1VCdThGUWpVUi9hM0J3clRH?=
 =?utf-8?B?a043eW1zZmp5eU1KaVBqLzRLRHdnT2N1dVA5K3R5a3JYTiszdUNNbERvMU1o?=
 =?utf-8?B?WndKdWh4M1FuSmsrRklGQUgrZ2N5ODRuYzFvM1diNUQ4YjQvNkxJM1pSTmM1?=
 =?utf-8?B?VzF5cUR6dkVsL01VMkN3REhCdEVNcUlIZ21sMG5WUXJMNVhYUDhlbmZBZ1ZY?=
 =?utf-8?B?aWZyWmtLdFlZUW1RSXVJZmxZM2FHcXJiZWVJRDJGa0h6RVRhOWZKQU5LRTFm?=
 =?utf-8?B?QnB1cklrVWZPcmdLMlEwZlBYdE1FWElVeWJYMDJxUWFlMjRjWnFRZ3d2OGNp?=
 =?utf-8?B?L3Z1bXBIVi9MK3BYZVZiMmtzZUxQTHpVMmVHM2VzUFRiTGQ5UTB3UlVoZWpr?=
 =?utf-8?B?dXkwYUYwVnZ2dEgwRUQrUWdRckxIdWgzbkJIcGpwM1FNRXA4V3N1Y2ZpT3Bz?=
 =?utf-8?B?cWZsWkJLQXo0cXJmeW1jbmQxVlVMOWRScUJkQ0plRi9wcGtvalRpNThLZFFJ?=
 =?utf-8?B?YllRNTU4TEVvL0ZaY0Zmd05WUlZEeWNHU1ZTRlZuelliQ05VeGtBVTR4eDYv?=
 =?utf-8?Q?yk1rIPG3Oo7j1KJwWcm3tvY7R?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ef6330-bcfb-4ebe-f99a-08daf31bbf92
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 15:02:52.9624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V8iWJKxHnkNzpffoSC9cFa9TAG56CbT5ymUmUMYxdI3OylwStYghfvHg+Ju8QkR2zGyQ4gPkNavZq5Y/W95xlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4263
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFJhZmFlbDoNCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVs
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgMTAsIDIwMjMgODo1OCBQTQ0K
PiBUbzogWXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT4NCj4gQ2M6IHJhZmFlbC5qLnd5
c29ja2lAaW50ZWwuY29tOyBMaW1vbmNpZWxsbywgTWFyaW8NCj4gPE1hcmlvLkxpbW9uY2llbGxv
QGFtZC5jb20+OyBIdWFuZywgUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT47DQo+IHZpcmVzaC5rdW1h
ckBsaW5hcm8ub3JnOyBTaGFybWEsIERlZXBhayA8RGVlcGFrLlNoYXJtYUBhbWQuY29tPjsNCj4g
Rm9udGVub3QsIE5hdGhhbiA8TmF0aGFuLkZvbnRlbm90QGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4
YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBIdWFuZywgU2hpbW1lcg0KPiA8
U2hpbW1lci5IdWFuZ0BhbWQuY29tPjsgRHUsIFhpYW9qaWFuIDxYaWFvamlhbi5EdUBhbWQuY29t
PjsgTWVuZywNCj4gTGkgKEphc3NtaW5lKSA8TGkuTWVuZ0BhbWQuY29tPjsgS2FybnksIFd5ZXMg
PFd5ZXMuS2FybnlAYW1kLmNvbT47DQo+IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBjcHVmcmVx
OiBhbWQtcHN0YXRlOiBmaXgga2VybmVsIGhhbmcgaXNzdWUgd2hpbGUNCj4gYW1kLXBzdGF0ZSB1
bnJlZ2lzdGVyaW5nDQo+IA0KPiBPbiBUdWUsIEphbiAxMCwgMjAyMyBhdCAxOjUwIFBNIFBlcnJ5
IFl1YW4gPHBlcnJ5Lnl1YW5AYW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBJbiB0aGUgYW1kX3Bz
dGF0ZV9hZGp1c3RfcGVyZigpLCB0aGVyZSBpcyBvbmUgY3B1ZnJlcV9jcHVfZ2V0KCkgY2FsbA0K
PiA+IHRvIGluY3JlYXNlIGluY3JlbWVudHMgdGhlIGtvYmplY3QgcmVmZXJlbmNlIGNvdW50IG9m
IHBvbGljeSBhbmQgbWFrZQ0KPiA+IGl0IGFzIGJ1c3kuIFRoZXJlZm9yZSwgYSBjb3JyZXNwb25k
aW5nIGNhbGwgdG8gY3B1ZnJlcV9jcHVfcHV0KCkgaXMNCj4gPiBuZWVkZWQgdG8gZGVjcmVtZW50
IHRoZSBrb2JqZWN0IHJlZmVyZW5jZSBjb3VudCBiYWNrLCBpdCB3aWxsIHJlc29sdmUNCj4gPiB0
aGUga2VybmVsIGhhbmcgaXNzdWUgd2hlbiB1bnJlZ2lzdGVyaW5nIHRoZSBhbWQtcHN0YXRlIGRy
aXZlciBhbmQNCj4gPiByZWdpc3RlciB0aGUgYGFtZF9wc3RhdGVfZXBwYCBkcml2ZXIgaW5zdGFu
Y2UuDQo+ID4NCj4gPiBBY2tlZC1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4NCj4g
PiBSZXZpZXdlZC1ieTogTWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5j
b20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVycnkgWXVhbiA8cGVycnkueXVhbkBhbWQuY29tPg0K
PiA+IFRlc3RlZC1ieTogV3llcyBLYXJueSA8d3llcy5rYXJueUBhbWQuY29tPg0KPiA+IENjOiBz
dGFibGVAdmdlci5rZXJuZWwub3JnDQo+IA0KPiBDYW4geW91IHByb3ZpZGUgYSBGaXhlcyB0YWcs
IHBsZWFzZT8NCg0KDQpTdXJlLCBsZXQgbWUgYWRkIHRoZSBGaXhlcyB0YWcgaW4gdjMNCg0KPiAN
Cj4gQWxzbywgd2hhdCdzIHRoZSBkaWZmZXJlbmNlIGJldHdlZW4gdGhpcyBhbmQgdGhlIHByZXZp
b3VzIHZlcnNpb24/DQoNCkp1c3QgYWRkIHRoZSAgIlRlc3RlZC1ieTogV3llcyBLYXJueSA8d3ll
cy5rYXJueUBhbWQuY29tPiIgIGluIHYyLiANCg0KPiANCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9j
cHVmcmVxL2FtZC1wc3RhdGUuYyB8IDEgKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5j
DQo+ID4gYi9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jIGluZGV4IDIwNGUzOTAwNmRkYS4u
YzE3YmQ4NDVmNWZjIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRl
LmMNCj4gPiArKysgYi9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+ID4gQEAgLTMwNyw2
ICszMDcsNyBAQCBzdGF0aWMgdm9pZCBhbWRfcHN0YXRlX2FkanVzdF9wZXJmKHVuc2lnbmVkIGlu
dA0KPiBjcHUsDQo+ID4gICAgICAgICAgICAgICAgIG1heF9wZXJmID0gbWluX3BlcmY7DQo+ID4N
Cj4gPiAgICAgICAgIGFtZF9wc3RhdGVfdXBkYXRlKGNwdWRhdGEsIG1pbl9wZXJmLCBkZXNfcGVy
ZiwgbWF4X3BlcmYsDQo+ID4gdHJ1ZSk7DQo+ID4gKyAgICAgICBjcHVmcmVxX2NwdV9wdXQocG9s
aWN5KTsNCj4gPiAgfQ0KPiA+DQo+ID4gIHN0YXRpYyBpbnQgYW1kX2dldF9taW5fZnJlcShzdHJ1
Y3QgYW1kX2NwdWRhdGEgKmNwdWRhdGEpDQo+ID4gLS0NCj4gPiAyLjM0LjENCj4gPg0K
