Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F596DE6AB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 23:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjDKVtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 17:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDKVtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 17:49:35 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFA43ABF;
        Tue, 11 Apr 2023 14:49:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbOBHeG92h0D9avx0J9GbMHac0oDISqySuVRBtKJnrDJ/rhsIb9e2JctWs3NLSuCKB+A8UGEZUfJVjPj4cPP+Y7FWPeAU3xms+LkrDFi6uptVBTs7+XsS0bpZbAEB2w+mDG0rTFWMz041PTbYeqBIj/GaLgJ3YUuCXpRq8qYGMlSut3QGHS3sYKINVJQfQQa3Les8k1DJ3+oFvJoKAbTNaZO1E/uoYxf4HjlHC3iFAlt0097s+9QnzOwQa4ocpkoH2MsX/pIdZwwcWxxcaOpJY1zPhqgUMxsdu/GInGeCeGAdTU57fHmi1S9o7o1qrfKs30IJB+WzrNc20eduPbMRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUbSzageRj5/OJZjcFytIHRkvQdPr+ChBwGQyWsXM3c=;
 b=f20sMCE8mwdBv/VzPUnNJ7+WTfwPkhPxF1tepYJerEKX0a4FFVX4ciBVMToxR3RBQ2sjZiYJ2+/00qkUz1RhRoSXe7h0AE1W3V2Ni8xC/GC+1RmqJ59T9qfznms5egYkQUMoKNGNXvxaSSJK2czC71ox7r3tWIiBxbr1iXN2nqvQeWi/pMr0TAFIYc0OjRp/O/4qbbeHtDeZKFhukCmoFIJZm020xtWbs2VXUGvkNlI0kMJETglmMo2TdKxcY9fbvSkL2SLyc9BhU6znjWjIVwziTU6k8etfP5gTspd7VLZncobpnzOo4Z55NqDGfT/nt26CenCZ8GdEJTBp/6OINA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUbSzageRj5/OJZjcFytIHRkvQdPr+ChBwGQyWsXM3c=;
 b=hFg1rjMDFC64sNCcHmd+Pn+MkTFDn5UEkZ0RxTTaMifZ/bKcQjyeoyobYgl3JZGLwi2r8cA+BmYlgcPGSrG+5niEEa3ceMpYEvJdR8dLj0sNSNTNQ+bGHLOf6KQoitYv4Zl7kzLyPuCZLm17U/KtIH8y8hkqV9FpW7MGedTzOuA=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB8483.namprd12.prod.outlook.com (2603:10b6:610:15c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Tue, 11 Apr
 2023 21:49:30 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe%2]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 21:49:30 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Box David E <david.e.box@intel.com>,
        "jstultz@google.com" <jstultz@google.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "svenva@chromium.org" <svenva@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>
CC:     "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "rrangel@chromium.org" <rrangel@chromium.org>,
        Jain Rajat <rajatja@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH v7 1/4] PM: Add sysfs files to represent time spent in
 hardware sleep state
Thread-Topic: [PATCH v7 1/4] PM: Add sysfs files to represent time spent in
 hardware sleep state
Thread-Index: AQHZbLsTW0gey5h1D0eBBvPHht10M68mo4eAgAABJWA=
Date:   Tue, 11 Apr 2023 21:49:30 +0000
Message-ID: <MN0PR12MB6101BDD7A3DB5AD251B63495E29A9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230411211719.4549-1-mario.limonciello@amd.com>
 <20230411211719.4549-2-mario.limonciello@amd.com>
 <2a6a377b-4c39-6c2a-c0ee-733120270424@redhat.com>
In-Reply-To: <2a6a377b-4c39-6c2a-c0ee-733120270424@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-04-11T21:49:28Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=5ab6a8a9-c24b-4b3b-a946-f8bb0e9b5b3b;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-04-11T21:49:28Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: e9d117a8-5bd4-48b3-8854-879078e451c0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|CH3PR12MB8483:EE_
x-ms-office365-filtering-correlation-id: 83cf5665-4493-46e7-a043-08db3ad6a116
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R8e+gDsOeMxzOylfyTwQeEKZg7B0jIZSGQycfYPmzAqmBpMPYY+1vOnExfrwSvsuYvhUIwPitUSmmQUiOTvllzEpVWuut8NycZosLsjrnG9Yxg+BiVexPMe1UeZSVHIn8rdy9T5ESujhO/9thTHs50+sR9SQgLPHW6iZueIsBEC/7PsvPxaF7K6x0x3dRur6+m4Hpjfhje8VVwjWo4G/UUDZxuaPFfcrP3yfm/RaPy2jOOHIAHmSHtXIaGfkAVXUVJksz0/V5IF4TIgf5Ai7gjEAPWAixuGTDV/N/mJGhIpTpAHal7Yaa/EzfOMNzDLflRbxp4JEcSBnJ28nDXBMLQTRhX46ET7iljxVpMw7VJxqxgRy/sIlAAiMWIEOuiYZ7Dys9Nv8HXKQEZiEyllz+lkELN9ng3U+k0KFk6FULmnEZA4A88iK5y3yeMVZeWKpIm6aACS1ajade36giYFL1+TKGY0zYdylI4sWlGBcyAk+6irKCvxpB921+K6ATJGCn2EtZb+U7+a5VDBeH753vYc88bUfM+tAEjFmHN2/9J4LgNZRnKvI/kYf4uUszeDegM0JeFq/aOoCU2w/YddnodTDbL+fj4lwO2hlSgX1zcfvuQtQWL+5QmzRLxm5tpT7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199021)(71200400001)(478600001)(7696005)(53546011)(26005)(316002)(110136005)(9686003)(6506007)(186003)(54906003)(2906002)(5660300002)(66446008)(4326008)(76116006)(66946007)(8676002)(66476007)(64756008)(7416002)(41300700001)(8936002)(66556008)(52536014)(122000001)(83380400001)(55016003)(86362001)(33656002)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K05vOUVkeTIwUDcwZUsrWHhSa1hTbjJmRlVTTkpuUUhQSzdaaWtNVVBmUGVu?=
 =?utf-8?B?K1VCNFlPbWhvWDBmSDlNeGFOS2hYUzQyODlRUnNKeG1RakN2MGhjY2tBWFdw?=
 =?utf-8?B?bkc2MW52SStIWUJjK1k5emtsbCtuMEl6LzQ3dXRyM29HN2RSK0JpUWF5UzRi?=
 =?utf-8?B?QzVjVWdqaUgvQ0RQWTQ4cGYrTkJmNERCcmtRMW9vbHIyRy9TL3RCVHRMbGxp?=
 =?utf-8?B?WlQwU3gvNzVvM29xMFZOSEtwOVBla2RmM3ZieG5JYXo5K2FKUGtUWjRSZG9u?=
 =?utf-8?B?R1YzMEplM0F6Skc0clRqalBDQnZNc25oS0MyNmJlM2VLT09jOVFGeHVkeitj?=
 =?utf-8?B?VTNjR3ZIK1dKbFRidEdFNyttMlN2VUR5bENXSlZUbjM0MVI2L2p1WGIzUHY1?=
 =?utf-8?B?WEc2SEsya1hobHRVekpPM0tLWU5JUDFUc3QxaTN2SjZyQm45RU1LUDlhKzA1?=
 =?utf-8?B?SmozWTdxbmFUU2dZUFJhbmMydjNwQjlJNldJQncyRVN2NVU3clc5aDd4S2JW?=
 =?utf-8?B?dGZSWCtKWlNpdEUvTHNwZ0lqL3A2QVBRK29XVnlrTnhMT2dQUjVCMmxmQ3Vj?=
 =?utf-8?B?QmpsbjNzd0MwM215MTZ3b0RUa3FVT09PSjFRTTRWdWZHdUN0UVZVVUxjRGNu?=
 =?utf-8?B?YU5WU1lPTS9nc1B3cGRqWCtiRzdLQkl0OVhrN1hmZEhiMGNhd3ZBTlY1Qk5Y?=
 =?utf-8?B?TEdNQWNOQjAvRVRjZGFQWkpuZlFidFM3RjZBaGF4R2tlWDhxTERKZlkvTGZL?=
 =?utf-8?B?ZFdKRVNBOU9wZDFBQXpmQ2xYcFF1aUUyejA5SWQ5ZC9rWUlUYW1scko3dlpt?=
 =?utf-8?B?OWFsWm9uYkhmNXE0UW1rOGxPNkNpeWNRYm5EV2o3MUNlejBVak11OGpqSGor?=
 =?utf-8?B?ZkR3SG5LYkxGdTJ4dEk4RWM4ZnIzcysxNWxWeS85eC9FQUUxUll0YjI4V3JQ?=
 =?utf-8?B?Z0JPTUpsS0lPNUlESWdoaERjOHR3c29oUTh4eUpyZ0dwZ09oaXFNbHdacVVm?=
 =?utf-8?B?ekZYNTNTU21MamNNdVFxaUJCUnloTjJRL0J6dzVHd1gxYUlsbkl0TXIwL1lX?=
 =?utf-8?B?aUNhVDBEeHEvNlBjTEFLa0JNZS9nUUJHUmpvTThRVFp6K1VpOFhNamo1OGFG?=
 =?utf-8?B?aXNpdG1pL016Q0ZHNVo3cmpuWUdwN2wxYm9pb1FScmpPVGhmR2t4L1lCZjFS?=
 =?utf-8?B?a1VrNjd1bEVUQVRKN2h0MTdQYm9KS0hiclU3SDVha3l3K3pxaUFmQ3hSaG5p?=
 =?utf-8?B?b1FacE1sV0hUSHhmSlVHVXdOcWNjYUlUOTVzdVBMTWJ3TXk1L09qL2pVcnVJ?=
 =?utf-8?B?Y3FVdWRSbUl6WmY2T1BlMG9pZ2h3OUptRTBDNlZNS0FYY1VrY05nNFUwTXJr?=
 =?utf-8?B?Vk5lcnJvRlRvRVk4SnlTb1RpZnQ3OTZHejRIWjh4MXNhRHBsN3N6dGJGUnp2?=
 =?utf-8?B?N3lrTXFHQjZCY3VTMWpNdGVvN3d0Q2dWeTBzbjBxUGhLOXU0bG00bmQwSHMv?=
 =?utf-8?B?K3lZTWFsSVFjaE9NdVlPUUtncE56S3ZNMmRLSnRRamlDOW9LWWNwSWhtZ2xT?=
 =?utf-8?B?UHY0eFl0ckc3cHZ4V1FSTnc3L3J3VjNFdjcydlNyNldlZE84MXUyMTNSbFN1?=
 =?utf-8?B?NEEvQkY2R09keWh6bElPUGNtLzZLeUhBbEZtQlNIbVZHeWVVakVvZkx0clJI?=
 =?utf-8?B?dzNHd1Q1anVHVldCYnVBejVPZFp0VTU5V0QwMjRnaDRSbFNGOHBMNXFJQUNM?=
 =?utf-8?B?bjc2UEtWRUg1U012dE9yTlRtdjF2RjMwZ2w4NzlsbVhKT295TVVjaWVubUFI?=
 =?utf-8?B?RHNCUUFxU0IydmE4K3JSL3VPVmJlZFZld0NaZmwya1pFVW1uT3RzdTlMU3hu?=
 =?utf-8?B?djdtSUUzb2VBdlF0UjJ2SGZDNGtSaGZpNnBJNHcrNGNNdzdTZEJFZHRGOWhN?=
 =?utf-8?B?TTN4Q0lGeWxxRDJ5NzR5KzQrSS90eGlEM1dnSHZ5MWF0ZFhPWFkzUktHMExy?=
 =?utf-8?B?RlJuaXZ5cHljMkxwY0d0ODBwTU1adGUvcUJRSytTdXZYQVYzanJqL3EvOGk5?=
 =?utf-8?B?TU9QYWlnQ1JOejNmS0RrVndoNEM2bmlBQzA1K2NuY2tnNVFKZUZySDM3dWph?=
 =?utf-8?Q?4S6U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cf5665-4493-46e7-a043-08db3ad6a116
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 21:49:30.2475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TrxpCBBMPtdripGKwQ9Kls6uB3AZvvzT1TkOUZcGnAIld1Q1MIhq+dQPpoQyWdQM9IJ9Ks2nRBHnmFf1vGIeag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8483
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KPiANCj4gT24gNC8xMS8yMyAyMzoxNywgTWFyaW8gTGltb25jaWVsbG8gd3Jv
dGU6DQo+ID4gVXNlcnNwYWNlIGNhbid0IGVhc2lseSBkaXNjb3ZlciBob3cgbXVjaCBvZiBhIHNs
ZWVwIGN5Y2xlIHdhcyBzcGVudCBpbiBhDQo+ID4gaGFyZHdhcmUgc2xlZXAgc3RhdGUgd2l0aG91
dCB1c2luZyBrZXJuZWwgdHJhY2luZyBhbmQgdmVuZG9yIHNwZWNpZmljIHN5c2ZzDQo+ID4gb3Ig
ZGVidWdmcyBmaWxlcy4NCj4gPg0KPiA+IFRvIG1ha2UgdGhpcyBpbmZvcm1hdGlvbiBtb3JlIGRp
c2NvdmVyYWJsZSwgaW50cm9kdWNlIHR3byBuZXcgc3lzZnMgZmlsZXM6DQo+ID4gMSkgVGhlIHRp
bWUgc3BlbnQgaW4gYSBodyBzbGVlcCBzdGF0ZSBmb3IgbGFzdCBjeWNsZS4NCj4gPiAyKSBUaGUg
dGltZSBzcGVudCBpbiBhIGh3IHNsZWVwIHN0YXRlIHNpbmNlIHRoZSBrZXJuZWwgYm9vdGVkDQo+
ID4gQm90aCBvZiB0aGVzZSBmaWxlcyB3aWxsIGJlIHByZXNlbnQgb25seSBpZiB0aGUgc3lzdGVt
IHN1cHBvcnRzIHMyaWRsZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hcmlvIExpbW9uY2ll
bGxvIDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+IHY2LT52NzoNCj4g
PiAgKiBSZW5hbWUgdG8gbWF4X2h3X3NsZWVwIChEYXZpZCBFIEJveCkNCj4gPiAgKiBEcm9wIG92
ZXJmbG93IGNoZWNrcyAoRGF2aWQgRSBCb3gpDQo+ID4gdjUtPnY2Og0KPiA+ICAqIEFkZCB0b3Rh
bCBhdHRyaWJ1dGUgYXMgd2VsbA0KPiA+ICAqIENoYW5nZSB0ZXh0IGZvciBkb2N1bWVudGF0aW9u
DQo+ID4gICogQWRqdXN0IGZsb3cgb2YgaXNfdmlzaWJsZSBjYWxsYmFjay4NCj4gPiAgKiBJZiBv
dmVyZmxvdyB3YXMgZGV0ZWN0ZWQgaW4gdG90YWwgYXR0cmlidXRlIHJldHVybiAtRU9WRVJGTE9X
DQo+ID4gICogUmVuYW1lIHN5bWJvbA0KPiA+ICAqIEFkZCBzdHViIGZvciBzeW1ib2wgZm9yIGJ1
aWxkcyB3aXRob3V0IENPTkZJR19QTV9TTEVFUA0KPiA+IHY0LT52NToNCj4gPiAgKiBQcm92aWRl
IHRpbWUgaW4gbWljcm9zZWNvbmRzIGluc3RlYWQgb2YgcGVyY2VudC4gVXNlcnNwYWNlIGNhbiBj
b252ZXJ0DQo+ID4gICAgdGhpcyBpZiBkZXNpcmFibGUuDQo+ID4gLS0tDQo+ID4gIERvY3VtZW50
YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtcG93ZXIgfCAyNCArKysrKysrKysrKysrKysrDQo+ID4g
IGluY2x1ZGUvbGludXgvc3VzcGVuZC5oICAgICAgICAgICAgICAgfCAgNSArKysrDQo+ID4gIGtl
cm5lbC9wb3dlci9tYWluLmMgICAgICAgICAgICAgICAgICAgfCA0MCArKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCA2OSBpbnNlcnRpb25zKCspDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1wb3dlcg0K
PiBiL0RvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtcG93ZXINCj4gPiBpbmRleCBmOTlk
NDMzZmYzMTEuLjA3MjNiNGRhZGZiZSAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL0FC
SS90ZXN0aW5nL3N5c2ZzLXBvd2VyDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGlu
Zy9zeXNmcy1wb3dlcg0KPiA+IEBAIC00MTMsNiArNDEzLDMwIEBAIERlc2NyaXB0aW9uOg0KPiA+
ICAJCVRoZSAvc3lzL3Bvd2VyL3N1c3BlbmRfc3RhdHMvbGFzdF9mYWlsZWRfc3RlcCBmaWxlIGNv
bnRhaW5zDQo+ID4gIAkJdGhlIGxhc3QgZmFpbGVkIHN0ZXAgaW4gdGhlIHN1c3BlbmQvcmVzdW1l
IHBhdGguDQo+ID4NCj4gPiArV2hhdDoJCS9zeXMvcG93ZXIvc3VzcGVuZF9zdGF0cy9sYXN0X2h3
X3NsZWVwDQo+ID4gK0RhdGU6CQlKdW5lIDIwMjMNCj4gPiArQ29udGFjdDoJTWFyaW8gTGltb25j
aWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+DQo+ID4gK0Rlc2NyaXB0aW9uOg0KPiA+
ICsJCVRoZSAvc3lzL3Bvd2VyL3N1c3BlbmRfc3RhdHMvbGFzdF9od19zbGVlcCBmaWxlDQo+ID4g
KwkJY29udGFpbnMgdGhlIGR1cmF0aW9uIG9mIHRpbWUgc3BlbnQgaW4gYSBoYXJkd2FyZSBzbGVl
cA0KPiA+ICsJCXN0YXRlIGluIHRoZSBtb3N0IHJlY2VudCBzeXN0ZW0gc3VzcGVuZC1yZXN1bWUg
Y3ljbGUuDQo+ID4gKwkJVGhpcyBudW1iZXIgaXMgbWVhc3VyZWQgaW4gbWljcm9zZWNvbmRzLg0K
PiA+ICsNCj4gPiArCQlOT1RFOiBMaW1pdGF0aW9ucyBpbiB0aGUgc2l6ZSBvZiB0aGUgaGFyZHdh
cmUgY291bnRlcnMgbWF5DQo+ID4gKwkJY2F1c2UgdGhpcyB2YWx1ZSB0byBiZSBpbmFjY3VyYXRl
IGluIGxvbmdlciBzbGVlcCBjeWNsZXMuDQo+IA0KPiBIbW0gSSB0aG91Z2h0IHRoYXQgdGhlIHBs
YW4gd2FzIHRvIGFkZCBhIHNlcGFyYXRlIHN5c2ZzIGF0dHIgd2l0aA0KPiB0aGUgbWF4IHRpbWUg
dGhhdCB0aGUgaHcgY291bGQgcmVwcmVzZW50IGhlcmUsIHNvIHRoYXQgdXNlcnNwYWNlDQo+IGFj
dHVhbGx5IGtub3cgd2hhdCBjb25zdGl0dXRlcyBhICJsb25nZXIgc2xlZXAgY3ljbGUiID8NCj4g
DQo+IFRoYXQgd291bGQgc2VlbSBiZXR0ZXIgdGhlbiBzdWNoIGEgaGFuZHdhdnkgY29tbWVudCBp
biB0aGUgQUJJIGRvY3M/DQoNCkkgb2J2aW91c2x5IG1pc3VuZGVyc3Rvb2Qgd2hhdCB5b3Ugd2Vy
ZSBzdWdnZXN0aW5nLg0KSSBkb24ndCBiZWxpZXZlIHdlIGhhdmUgYSB3YXkgdG8gcHJvZ3JhbW1h
dGljYWxseSBkZXRlcm1pbmUgd2hhdCB0aGUgaGFyZHdhcmUNCkludGVybmFsbHkgdXNlcyBmb3Ig
aXQncyBjb3VudGVyIHRvIGtub3cgdGhpcy4NCg0KU28gaXQgd291bGQgbmVlZCB0byBiZSBhIHRh
YmxlIG9mIHNvbWUgc29ydHMgdGhhdCBhIGdpdmVuIHN5c3RlbSBjYW4gc3VwcG9ydA0Kc3VjaCB2
YWx1ZS4gIElmIHdlIGRvIHRoYXQsIHdlIGNhbiBhY3R1YWxseSBrbm93IHdoZXRoZXIgdG8gcmV0
dXJuIGFuIGVycm9yIGNvZGUNCmxpa2UgLUVPVkVSRkxPVyBvciAtRUlOVkFMIHRvbyBpZiB0aGUg
c3VzcGVuZCB3YXMgdG9vIGxvbmcuDQoNCkkgd291bGQgbmVlZCBJbnRlbCBndXlzIHRvIHNoYXJl
IHRoaXMgaW5mb3JtYXRpb24gdGhvdWdoIHdoaWNoIHN5c3RlbXMgaGF2ZQ0Kd2hpY2ggc2l6ZSBv
ZiBjb3VudGVycyB0byBtYWtlIHRoaXMgaGFwcGVuLg0KDQo+IA0KPiA+ICsNCj4gPiArV2hhdDoJ
CS9zeXMvcG93ZXIvc3VzcGVuZF9zdGF0cy9tYXhfaHdfc2xlZXANCj4gPiArRGF0ZToJCUp1bmUg
MjAyMw0KPiA+ICtDb250YWN0OglNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9A
YW1kLmNvbT4NCj4gPiArRGVzY3JpcHRpb246DQo+ID4gKwkJVGhlIC9zeXMvcG93ZXIvc3VzcGVu
ZF9zdGF0cy9tYXhfaHdfc2xlZXAgZmlsZQ0KPiA+ICsJCWNvbnRhaW5zIHRoZSBhZ2dyZWdhdGUg
b2YgdGltZSBzcGVudCBpbiBhIGhhcmR3YXJlIHNsZWVwDQo+ID4gKwkJc3RhdGUgc2luY2UgdGhl
IGtlcm5lbCB3YXMgYm9vdGVkLiBUaGlzIG51bWJlcg0KPiA+ICsJCWlzIG1lYXN1cmVkIGluIG1p
Y3Jvc2Vjb25kcy4NCj4gPiArDQo+ID4gKwkJTk9URTogTGltaXRhdGlvbnMgaW4gdGhlIHNpemUg
b2YgdGhlIGhhcmR3YXJlIGNvdW50ZXJzIG1heQ0KPiA+ICsJCWNhdXNlIHRoaXMgdmFsdWUgdG8g
YmUgaW5hY2N1cmF0ZSBpbiBsb25nZXIgc2xlZXAgY3ljbGVzLg0KPiANCj4gTWF5YmUgInRvdGFs
X2h3X3NsZWVwIiBpbnN0ZWFkIG9mICJtYXhfaHdfc2xlZXAiID8gQWxzbyBzaW5jZSBtYXggdG8N
Cj4gbWUgc291bmRzIGxpa2UgdGhlIGxpbWl0IG9mIHRoZSBsb25nZXN0IHNsZWVwIHRoZSBodyBj
b3VudGVycyBjYW4NCj4gcmVnaXN0ZXIsIHNvIHRoYXQgaXMgYml0IGNvbmZ1c2luZyB3aXRoIHRo
ZSBkaXNjdXNzaW9uIGFib3V0IHRob3NlDQo+IGxpbWl0cy4NCg0KdG90YWxfaHdfc2xlZXAgaXMg
YWN0dWFsbHkgd2hhdCB3YXMgaW4gdjYgYW5kIG1heF9od19zbGVlcCBpcyB3aGF0IHN1Z2dlc3Rl
ZC4NClRoYXQncyB3aHkgSSBnb3QgY29uZnVzZWQgYWJvdXQgd2hhdCB5b3UgZ3V5cyBtZWFudC4N
Cg0KPiANCj4gUmVnYXJkcywNCj4gDQo+IEhhbnMNCj4gDQo+IA0KPiANCj4gPiArDQo+ID4gIFdo
YXQ6CQkvc3lzL3Bvd2VyL3N5bmNfb25fc3VzcGVuZA0KPiA+ICBEYXRlOgkJT2N0b2JlciAyMDE5
DQo+ID4gIENvbnRhY3Q6CUpvbmFzIE1ldXJlciA8am9uYXNAZnJlZXNvdXJjZXMub3JnPg0KPiA+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3N1c3BlbmQuaCBiL2luY2x1ZGUvbGludXgvc3Vz
cGVuZC5oDQo+ID4gaW5kZXggY2ZlMTlhMDI4OTE4Li44MTllOTY3N2ZkMTAgMTAwNjQ0DQo+ID4g
LS0tIGEvaW5jbHVkZS9saW51eC9zdXNwZW5kLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3N1
c3BlbmQuaA0KPiA+IEBAIC02OCw2ICs2OCw4IEBAIHN0cnVjdCBzdXNwZW5kX3N0YXRzIHsNCj4g
PiAgCWludAlsYXN0X2ZhaWxlZF9lcnJubzsNCj4gPiAgCWludAllcnJub1tSRUNfRkFJTEVEX05V
TV07DQo+ID4gIAlpbnQJbGFzdF9mYWlsZWRfc3RlcDsNCj4gPiArCXU2NAlsYXN0X2h3X3NsZWVw
Ow0KPiA+ICsJdTY0CW1heF9od19zbGVlcDsNCj4gPiAgCWVudW0gc3VzcGVuZF9zdGF0X3N0ZXAJ
ZmFpbGVkX3N0ZXBzW1JFQ19GQUlMRURfTlVNXTsNCj4gPiAgfTsNCj4gPg0KPiA+IEBAIC00ODks
NiArNDkxLDcgQEAgdm9pZCByZXN0b3JlX3Byb2Nlc3Nvcl9zdGF0ZSh2b2lkKTsNCj4gPiAgZXh0
ZXJuIGludCByZWdpc3Rlcl9wbV9ub3RpZmllcihzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKm5iKTsN
Cj4gPiAgZXh0ZXJuIGludCB1bnJlZ2lzdGVyX3BtX25vdGlmaWVyKHN0cnVjdCBub3RpZmllcl9i
bG9jayAqbmIpOw0KPiA+ICBleHRlcm4gdm9pZCBrc3lzX3N5bmNfaGVscGVyKHZvaWQpOw0KPiA+
ICtleHRlcm4gdm9pZCBwbV9yZXBvcnRfaHdfc2xlZXBfdGltZSh1NjQgdCk7DQo+ID4NCj4gPiAg
I2RlZmluZSBwbV9ub3RpZmllcihmbiwgcHJpKSB7CQkJCVwNCj4gPiAgCXN0YXRpYyBzdHJ1Y3Qg
bm90aWZpZXJfYmxvY2sgZm4jI19uYiA9CQkJXA0KPiA+IEBAIC01MjYsNiArNTI5LDggQEAgc3Rh
dGljIGlubGluZSBpbnQgdW5yZWdpc3Rlcl9wbV9ub3RpZmllcihzdHJ1Y3QNCj4gbm90aWZpZXJf
YmxvY2sgKm5iKQ0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgaW5s
aW5lIHZvaWQgcG1fcmVwb3J0X2h3X3NsZWVwX3RpbWUodTY0IHQpIHt9Ow0KPiA+ICsNCj4gPiAg
c3RhdGljIGlubGluZSB2b2lkIGtzeXNfc3luY19oZWxwZXIodm9pZCkge30NCj4gPg0KPiA+ICAj
ZGVmaW5lIHBtX25vdGlmaWVyKGZuLCBwcmkpCWRvIHsgKHZvaWQpKGZuKTsgfSB3aGlsZSAoMCkN
Cj4gPiBkaWZmIC0tZ2l0IGEva2VybmVsL3Bvd2VyL21haW4uYyBiL2tlcm5lbC9wb3dlci9tYWlu
LmMNCj4gPiBpbmRleCAzMWVjNGE5YjlkNzAuLmE1NTQ2YjkxZWNjOSAxMDA2NDQNCj4gPiAtLS0g
YS9rZXJuZWwvcG93ZXIvbWFpbi5jDQo+ID4gKysrIGIva2VybmVsL3Bvd2VyL21haW4uYw0KPiA+
IEBAIC02LDYgKzYsNyBAQA0KPiA+ICAgKiBDb3B5cmlnaHQgKGMpIDIwMDMgT3BlbiBTb3VyY2Ug
RGV2ZWxvcG1lbnQgTGFiDQo+ID4gICAqLw0KPiA+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9hY3Bp
Lmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9leHBvcnQuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4
L2tvYmplY3QuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3N0cmluZy5oPg0KPiA+IEBAIC04Myw2
ICs4NCwxMyBAQCBpbnQgdW5yZWdpc3Rlcl9wbV9ub3RpZmllcihzdHJ1Y3Qgbm90aWZpZXJfYmxv
Y2sgKm5iKQ0KPiA+ICB9DQo+ID4gIEVYUE9SVF9TWU1CT0xfR1BMKHVucmVnaXN0ZXJfcG1fbm90
aWZpZXIpOw0KPiA+DQo+ID4gK3ZvaWQgcG1fcmVwb3J0X2h3X3NsZWVwX3RpbWUodTY0IHQpDQo+
ID4gK3sNCj4gPiArCXN1c3BlbmRfc3RhdHMubGFzdF9od19zbGVlcCA9IHQ7DQo+ID4gKwlzdXNw
ZW5kX3N0YXRzLm1heF9od19zbGVlcCArPSB0Ow0KPiA+ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0xf
R1BMKHBtX3JlcG9ydF9od19zbGVlcF90aW1lKTsNCj4gPiArDQo+ID4gIGludCBwbV9ub3RpZmll
cl9jYWxsX2NoYWluX3JvYnVzdCh1bnNpZ25lZCBsb25nIHZhbF91cCwgdW5zaWduZWQgbG9uZw0K
PiB2YWxfZG93bikNCj4gPiAgew0KPiA+ICAJaW50IHJldDsNCj4gPiBAQCAtMzc3LDYgKzM4NSwy
MiBAQCBzdGF0aWMgc3NpemVfdCBsYXN0X2ZhaWxlZF9zdGVwX3Nob3coc3RydWN0IGtvYmplY3QN
Cj4gKmtvYmosDQo+ID4gIH0NCj4gPiAgc3RhdGljIHN0cnVjdCBrb2JqX2F0dHJpYnV0ZSBsYXN0
X2ZhaWxlZF9zdGVwID0NCj4gX19BVFRSX1JPKGxhc3RfZmFpbGVkX3N0ZXApOw0KPiA+DQo+ID4g
K3N0YXRpYyBzc2l6ZV90IGxhc3RfaHdfc2xlZXBfc2hvdyhzdHJ1Y3Qga29iamVjdCAqa29iaiwN
Cj4gPiArCQlzdHJ1Y3Qga29ial9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1ZikNCj4gPiArew0K
PiA+ICsJcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAiJWxsdVxuIiwgc3VzcGVuZF9zdGF0cy5sYXN0
X2h3X3NsZWVwKTsNCj4gPiArfQ0KPiA+ICtzdGF0aWMgc3RydWN0IGtvYmpfYXR0cmlidXRlIGxh
c3RfaHdfc2xlZXAgPSBfX0FUVFJfUk8obGFzdF9od19zbGVlcCk7DQo+ID4gKw0KPiA+ICtzdGF0
aWMgc3NpemVfdCBtYXhfaHdfc2xlZXBfc2hvdyhzdHJ1Y3Qga29iamVjdCAqa29iaiwNCj4gPiAr
CQlzdHJ1Y3Qga29ial9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1ZikNCj4gPiArew0KPiA+ICsJ
aWYgKHN1c3BlbmRfc3RhdHMubWF4X2h3X3NsZWVwID09IC1FT1ZFUkZMT1cpDQo+ID4gKwkJcmV0
dXJuIHN1c3BlbmRfc3RhdHMubWF4X2h3X3NsZWVwOw0KPiA+ICsJcmV0dXJuIHN5c2ZzX2VtaXQo
YnVmLCAiJWxsdVxuIiwgc3VzcGVuZF9zdGF0cy5tYXhfaHdfc2xlZXApOw0KPiA+ICt9DQo+ID4g
K3N0YXRpYyBzdHJ1Y3Qga29ial9hdHRyaWJ1dGUgbWF4X2h3X3NsZWVwID0NCj4gX19BVFRSX1JP
KG1heF9od19zbGVlcCk7DQo+ID4gKw0KPiA+ICBzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqc3Vz
cGVuZF9hdHRyc1tdID0gew0KPiA+ICAJJnN1Y2Nlc3MuYXR0ciwNCj4gPiAgCSZmYWlsLmF0dHIs
DQo+ID4gQEAgLTM5MSwxMiArNDE1LDI4IEBAIHN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICpzdXNw
ZW5kX2F0dHJzW10gPSB7DQo+ID4gIAkmbGFzdF9mYWlsZWRfZGV2LmF0dHIsDQo+ID4gIAkmbGFz
dF9mYWlsZWRfZXJybm8uYXR0ciwNCj4gPiAgCSZsYXN0X2ZhaWxlZF9zdGVwLmF0dHIsDQo+ID4g
KwkmbGFzdF9od19zbGVlcC5hdHRyLA0KPiA+ICsJJm1heF9od19zbGVlcC5hdHRyLA0KPiA+ICAJ
TlVMTCwNCj4gPiAgfTsNCj4gPg0KPiA+ICtzdGF0aWMgdW1vZGVfdCBzdXNwZW5kX2F0dHJfaXNf
dmlzaWJsZShzdHJ1Y3Qga29iamVjdCAqa29iaiwgc3RydWN0DQo+IGF0dHJpYnV0ZSAqYXR0ciwg
aW50IGlkeCkNCj4gPiArew0KPiA+ICsJaWYgKGF0dHIgIT0gJmxhc3RfaHdfc2xlZXAuYXR0ciAm
Jg0KPiA+ICsJICAgIGF0dHIgIT0gJm1heF9od19zbGVlcC5hdHRyKQ0KPiA+ICsJCXJldHVybiAw
NDQ0Ow0KPiA+ICsNCj4gPiArI2lmZGVmIENPTkZJR19BQ1BJDQo+ID4gKwlpZiAoYWNwaV9nYmxf
RkFEVC5mbGFncyAmIEFDUElfRkFEVF9MT1dfUE9XRVJfUzApDQo+ID4gKwkJcmV0dXJuIDA0NDQ7
DQo+ID4gKyNlbmRpZg0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgYXR0cmlidXRlX2dyb3VwIHN1c3BlbmRfYXR0cl9ncm91cCA9IHsNCj4g
PiAgCS5uYW1lID0gInN1c3BlbmRfc3RhdHMiLA0KPiA+ICAJLmF0dHJzID0gc3VzcGVuZF9hdHRy
cywNCj4gPiArCS5pc192aXNpYmxlID0gc3VzcGVuZF9hdHRyX2lzX3Zpc2libGUsDQo+ID4gIH07
DQo+ID4NCj4gPiAgI2lmZGVmIENPTkZJR19ERUJVR19GUw0K
