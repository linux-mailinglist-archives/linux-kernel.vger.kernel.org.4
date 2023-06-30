Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45169743C54
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 15:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjF3NDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 09:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjF3NDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 09:03:17 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD91735AF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 06:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqJAx2BPfBEJD6SvNK4oobkVPaJXT7YGMmK/A5Njl+w=;
 b=Nf1K9pCU7CPBs1XlE16mSdJdYR0Ks4JtRGn5ETkkUyPO0EskDyS7/do2jQI4oyRj/HbSzPrGE8WS1qTKxtimJhJe0ZDjQ+L5x8KNGqO4f51FYBSb3n9oEPKUs9hwsaD0rT885rm+sg1dzivZFrL33fRY63HWJr1IZajH1PBGmNU=
Received: from AS8P251CA0002.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:2f2::15)
 by AS8PR08MB6070.eurprd08.prod.outlook.com (2603:10a6:20b:290::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 13:03:04 +0000
Received: from AM7EUR03FT035.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:2f2:cafe::af) by AS8P251CA0002.outlook.office365.com
 (2603:10a6:20b:2f2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 13:03:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT035.mail.protection.outlook.com (100.127.141.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.22 via Frontend Transport; Fri, 30 Jun 2023 13:03:04 +0000
Received: ("Tessian outbound b11b8bb4dfe8:v142"); Fri, 30 Jun 2023 13:03:04 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a3c79a00d6d3fc06
X-CR-MTA-TID: 64aa7808
Received: from b99cba4c4eae.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F181D9F3-4E76-4847-95F3-F02D250F1E4F.1;
        Fri, 30 Jun 2023 13:02:57 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b99cba4c4eae.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 30 Jun 2023 13:02:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8hk78AR9XhAmm4pSBamxYSUoJKQ1wrKpvG1f9AuJgFAV4+7gkA3DJtJIOIwlKHSXhJVWx2HbKeRtmpgDHdTwyOnoNeoDojruE5Ooa2ErLol4Q1bAVwXCsjvUIofqi/RoY5vBujpQGcXnF6cnqdV9yAIuBRm6l9VY6WZ+0iYfr/WuSuuEuXNDGcn9jFKTVIyTcLDwSWjVLHTv/5ijgW2q00swIfDLxsSbNYrYPCvuUCrgp0QD0dUJYj0QSY4c+NhpAedlSYzsikX4gLj+/rr/12YZncDHK4I+D7hl82ozP4ZytwakO4gmkwYytbD4onxJmGm0VxyrK5Pn4aWbaU4XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqJAx2BPfBEJD6SvNK4oobkVPaJXT7YGMmK/A5Njl+w=;
 b=i3cL0S3GNV9YTG7PXG3ZruEwPZsNVs6svCc/oC+vHk5u27xsGTgZ88mKRkLJMJ/lmV9jCtd7O3hVE5U9KaBsamDRInOs2fag11ueENsQsBSDPXveH9grU3FP8wX5uzU2bVG+gWbKrBuFfW5AX3QDJKre9ml/bt1rgnfBShESAuxWwPaZbSHK47HEViQylvsbig95gt/ncgRnbRV1vWI9teb3W7QdnOsM2SDMvglGo2difG9HLfPnE2/w3EWSumPt+I4gJb5pED1aMlCnX+PlLmVAibdx7ln4kTik9lCJXUTB+Htsfmpd3ciEBsjfdSHIirzQO2BALV96gbb+v3NHOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqJAx2BPfBEJD6SvNK4oobkVPaJXT7YGMmK/A5Njl+w=;
 b=Nf1K9pCU7CPBs1XlE16mSdJdYR0Ks4JtRGn5ETkkUyPO0EskDyS7/do2jQI4oyRj/HbSzPrGE8WS1qTKxtimJhJe0ZDjQ+L5x8KNGqO4f51FYBSb3n9oEPKUs9hwsaD0rT885rm+sg1dzivZFrL33fRY63HWJr1IZajH1PBGmNU=
Received: from PAXPR08MB7154.eurprd08.prod.outlook.com (2603:10a6:102:207::17)
 by DU0PR08MB8346.eurprd08.prod.outlook.com (2603:10a6:10:40a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 13:02:54 +0000
Received: from PAXPR08MB7154.eurprd08.prod.outlook.com
 ([fe80::cc5c:8572:5323:11ed]) by PAXPR08MB7154.eurprd08.prod.outlook.com
 ([fe80::cc5c:8572:5323:11ed%3]) with mapi id 15.20.6521.026; Fri, 30 Jun 2023
 13:02:54 +0000
From:   Rahul Singh <Rahul.Singh@arm.com>
To:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
CC:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Jane Malalane <jane.malalane@citrix.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2] xen/evtchn: Introduce new IOCTL to bind static evtchn
Thread-Topic: [PATCH v2] xen/evtchn: Introduce new IOCTL to bind static evtchn
Thread-Index: AQHZqqDrFlYPmniBzkyAFz9id20VH6+iE7EAgAE9TgA=
Date:   Fri, 30 Jun 2023 13:02:53 +0000
Message-ID: <156827AA-3DFB-4DA2-BC82-7A27E77C2092@arm.com>
References: <764d561e3aecb7e63e8601dc50aaef9fc40834e4.1688051342.git.rahul.singh@arm.com>
 <90c961d4-9d10-6fbc-b5f7-84d231264289@epam.com>
In-Reply-To: <90c961d4-9d10-6fbc-b5f7-84d231264289@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: PAXPR08MB7154:EE_|DU0PR08MB8346:EE_|AM7EUR03FT035:EE_|AS8PR08MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: bdd6ffb9-2801-4a70-6409-08db796a57bf
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: cMC2QjwlC+ezXUByUNuFThw5UQJVxGBAtuKtQn3ILSFZiazaehztSfASG8YzcgwkuwvZGLv8KhWs/Pscow1HY+8r6Kjw2z/N42t6HiiN4BzSlwemsK8/IbU/vPIxS9xJfgL9jA3/hvfTNey0hbLUD8xza+YFuWfPOJgMoeN1Z1kx1TpDmGsdCfgQg+1thsqVzQU2YdXOxUO8skdZKceYBScUxzEDwnkcwBceLLdKjcL9gM4eyyPX0StnclBriH3c2esvXKWDaYCbGL2QWRxWBqAZbHlCO/j+hUlDhkNZnZnLMZqBPEAUyuxf3tEUuwS8UMohhvoy7kjsu5MrT+YcZr3/bwMxlXsvqm47rzGv5eQvu/C7Brpk3KKJ9ZEWiWrGid/qAWzpxOIYnn6os9xlqiUtiZoiBOwRMQKj7mqJn5n0Mkw9k0LRDzDaP3taXZ2fwpzEo3d4MaAOV7S7pLv7ZRxaKKlnaIeONrcuzLCaALmK0DAqh7Csq52S8Li2gWMfmrQ8cWoHXGri4kF6REKu6t6ppzUToyGFS+jf+8Zvkfr+twfzeaLAsLUs4VSHYxbSgOPUMRmOBKj0oUy4woG14SkDyxhlLcF5J753BggKQTgxhheNcczaWgPJ6h7+dkwDNrgXL/6Gvkq/qB1ntGsn4Q==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB7154.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199021)(5660300002)(91956017)(66946007)(76116006)(66556008)(66446008)(4326008)(33656002)(64756008)(66476007)(6916009)(478600001)(316002)(36756003)(8936002)(8676002)(2906002)(6512007)(26005)(54906003)(38070700005)(41300700001)(6486002)(71200400001)(186003)(53546011)(6506007)(122000001)(86362001)(38100700002)(83380400001)(2616005)(45980500001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB70DDA4DFC21B4891BE0026BCE6A08C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8346
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT035.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f8174a25-d247-41a7-37bd-08db796a5134
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NZFC34polMqJdXxSnmeZz9yOfLOCPQVKAr8hUmI3aAU4oe4H5p6GDVr5fyQviB8wcpD5vwY19gVFuUGyH8Av2xDLkswX/Px8ADBYqrztsNvc+c1MAfiAELxNPL+AsY8GFh8Vq43DjGUKSxnF2gjBmkPzCknTc1J1sFlD5Cq6+q4Ggo2vaX/zT6GnXCAvSENuAZL/PEQdrrVO3HppEm/+LQhoJ7fZqBwkAmPvEhB+YjeZ8Enk15s91ovt3IqKIkzgQuIa+Tkv1RwybrDmo4aTuh//LCd76HqnLXMCEvh3SycJDhQyqn7NCqpoTUNftkKLM7UPWE1LEyiTDg3HOedv/zvVrPiuhr3zPksO/Wl6S/p3KFK3zoeYBMi2KBuzseVFDxZmcq4XNdeJf85nrTHqOuHJ8hmwpd7RTykobwExL/uEypdnDHiyTizn317Lgtcy6MEH3oxQFXbbVkGPOTaYPkTFSXk2Tq8KEv21KyJx9fw5Gclq/KdEGJ5DwUrDyIZ02rB74C77D6SmY7Lw+P/vpWcG+N1drBlaF8YsIdh3D29QeliXqqfMlCIk1vEhvRWmSAKTbWkkMZrwHtRAndXCKvdNYNGf8kaxkINL3inV6B+h9MbLX4RE75BT1xyupXr+Fiahvlqg9J6PdmOCKr+SsE15TgtTbKS+5kLVCmwp8Bp5qbmcPCN2sFYbLf0xOx8ykCDQJ8GVt7gYpNpcFa+KJLjPRacZ/CLOH1eXzhXaAaN9qC9V6cD6u5KsAuiF/oko
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199021)(36840700001)(46966006)(40470700004)(186003)(6862004)(8676002)(8936002)(53546011)(478600001)(26005)(4326008)(70586007)(70206006)(6506007)(316002)(86362001)(356005)(6486002)(107886003)(5660300002)(81166007)(82740400003)(40460700003)(6512007)(2906002)(2616005)(82310400005)(40480700001)(47076005)(336012)(83380400001)(54906003)(33656002)(36756003)(36860700001)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 13:03:04.7931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd6ffb9-2801-4a70-6409-08db796a57bf
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT035.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6070
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgT2xla3NhbmRyLA0KDQpUaGFua3MgZm9yIHJldmlld2luZyB0aGUgY29kZS4NCg0KPiBPbiAy
OSBKdW4gMjAyMywgYXQgNzowNiBwbSwgT2xla3NhbmRyIFR5c2hjaGVua28gPG9sZWtzYW5kcl90
eXNoY2hlbmtvQGVwYW0uY29tPiB3cm90ZToNCj4gDQo+IA0KPiANCj4gT24gMjkuMDYuMjMgMTg6
NDYsIFJhaHVsIFNpbmdoIHdyb3RlOg0KPiANCj4gSGVsbG8gUmFodWwNCj4gDQo+IA0KPj4gWGVu
IDQuMTcgc3VwcG9ydHMgdGhlIGNyZWF0aW9uIG9mIHN0YXRpYyBldnRjaG5zLiBUbyBhbGxvdyB1
c2VyIHNwYWNlDQo+PiBhcHBsaWNhdGlvbiB0byBiaW5kIHN0YXRpYyBldnRjaG5zIGludHJvZHVj
ZSBuZXcgaW9jdGwNCj4+ICJJT0NUTF9FVlRDSE5fQklORF9TVEFUSUMiLiBFeGlzdGluZyBJT0NU
TCBkb2luZyBtb3JlIHRoYW4gYmluZGluZw0KPj4gdGhhdOKAmXMgd2h5IHdlIG5lZWQgdG8gaW50
cm9kdWNlIHRoZSBuZXcgSU9DVEwgdG8gb25seSBiaW5kIHRoZSBzdGF0aWMNCj4+IGV2ZW50IGNo
YW5uZWxzLg0KPj4gDQo+PiBBbHNvLCBzdGF0aWMgZXZ0Y2hucyB0byBiZSBhdmFpbGFibGUgZm9y
IHVzZSBkdXJpbmcgdGhlIGxpZmV0aW1lIG9mIHRoZQ0KPj4gZ3Vlc3QuIFdoZW4gdGhlIGFwcGxp
Y2F0aW9uIGV4aXRzLCBfX3VuYmluZF9mcm9tX2lycSgpIGVuZHMgdXAgYmVpbmcNCj4+IGNhbGxl
ZCBmcm9tIHJlbGVhc2UoKSBmaWxlIG9wZXJhdGlvbnMgYmVjYXVzZSBvZiB0aGF0IHN0YXRpYyBl
dnRjaG5zDQo+PiBhcmUgZ2V0dGluZyBjbG9zZWQuIFRvIGF2b2lkIGNsb3NpbmcgdGhlIHN0YXRp
YyBldmVudCBjaGFubmVsLCBhZGQgdGhlDQo+PiBuZXcgYm9vbCB2YXJpYWJsZSAiaXNfc3RhdGlj
IiBpbiAic3RydWN0IGlycV9pbmZvIiB0byBtYXJrIHRoZSBldmVudA0KPj4gY2hhbm5lbCBzdGF0
aWMgd2hlbiBjcmVhdGluZyB0aGUgZXZlbnQgY2hhbm5lbCB0byBhdm9pZCBjbG9zaW5nIHRoZQ0K
Pj4gc3RhdGljIGV2dGNobi4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogUmFodWwgU2luZ2ggPHJh
aHVsLnNpbmdoQGFybS5jb20+DQo+PiAtLS0NCj4+IHYyOg0KPj4gICogVXNlIGJvb2wgaW4gcGxh
Y2UgdTggdG8gZGVmaW5lIGlzX3N0YXRpYyB2YXJpYWJsZS4NCj4+ICAqIEF2b2lkIGNsb3Npbmcg
dGhlIHN0YXRpYyBldnRjaG5zIGluIGVycm9yIHBhdGguDQo+IA0KPiANCj4gUGF0Y2ggbG9va3Mg
Z29vZCB0byBtZSwganVzdCBhIG5pdCAocXVlc3Rpb24pIGJlbG93Lg0KPiANCj4gDQo+PiAtLS0N
Cj4+ICBkcml2ZXJzL3hlbi9ldmVudHMvZXZlbnRzX2Jhc2UuYyB8ICA3ICsrKysrLS0NCj4+ICBk
cml2ZXJzL3hlbi9ldnRjaG4uYyAgICAgICAgICAgICB8IDMwICsrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tLQ0KPj4gIGluY2x1ZGUvdWFwaS94ZW4vZXZ0Y2huLmggICAgICAgIHwgIDkgKysr
KysrKysrDQo+PiAgaW5jbHVkZS94ZW4vZXZlbnRzLmggICAgICAgICAgICAgfCAgMiArLQ0KPj4g
IDQgZmlsZXMgY2hhbmdlZCwgMzcgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+PiAN
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3hlbi9ldmVudHMvZXZlbnRzX2Jhc2UuYyBiL2RyaXZl
cnMveGVuL2V2ZW50cy9ldmVudHNfYmFzZS5jDQo+PiBpbmRleCBjNzcxNWY4YmQ0NTIuLjVkM2I1
YzdjZmU2NCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMveGVuL2V2ZW50cy9ldmVudHNfYmFzZS5j
DQo+PiArKysgYi9kcml2ZXJzL3hlbi9ldmVudHMvZXZlbnRzX2Jhc2UuYw0KPj4gQEAgLTExMiw2
ICsxMTIsNyBAQCBzdHJ1Y3QgaXJxX2luZm8gew0KPj4gICB1bnNpZ25lZCBpbnQgaXJxX2Vwb2No
OyAvKiBJZiBlb2lfY3B1IHZhbGlkOiBpcnFfZXBvY2ggb2YgZXZlbnQgKi8NCj4+ICAgdTY0IGVv
aV90aW1lOyAgICAgICAgICAgLyogVGltZSBpbiBqaWZmaWVzIHdoZW4gdG8gRU9JLiAqLw0KPj4g
ICByYXdfc3BpbmxvY2tfdCBsb2NrOw0KPj4gKyBib29sIGlzX3N0YXRpYzsgICAgICAgICAgIC8q
IElzIGV2ZW50IGNoYW5uZWwgc3RhdGljICovDQo+PiANCj4+ICAgdW5pb24gew0KPj4gICB1bnNp
Z25lZCBzaG9ydCB2aXJxOw0KPj4gQEAgLTk4Miw3ICs5ODMsOCBAQCBzdGF0aWMgdm9pZCBfX3Vu
YmluZF9mcm9tX2lycSh1bnNpZ25lZCBpbnQgaXJxKQ0KPj4gICB1bnNpZ25lZCBpbnQgY3B1ID0g
Y3B1X2Zyb21faXJxKGlycSk7DQo+PiAgIHN0cnVjdCB4ZW5idXNfZGV2aWNlICpkZXY7DQo+PiAN
Cj4+IC0geGVuX2V2dGNobl9jbG9zZShldnRjaG4pOw0KPj4gKyBpZiAoIWluZm8tPmlzX3N0YXRp
YykNCj4+ICsgeGVuX2V2dGNobl9jbG9zZShldnRjaG4pOw0KPj4gDQo+PiAgIHN3aXRjaCAodHlw
ZV9mcm9tX2lycShpcnEpKSB7DQo+PiAgIGNhc2UgSVJRVF9WSVJROg0KPj4gQEAgLTE1NzQsNyAr
MTU3Niw3IEBAIGludCB4ZW5fc2V0X2lycV9wcmlvcml0eSh1bnNpZ25lZCBpcnEsIHVuc2lnbmVk
IHByaW9yaXR5KQ0KPj4gIH0NCj4+ICBFWFBPUlRfU1lNQk9MX0dQTCh4ZW5fc2V0X2lycV9wcmlv
cml0eSk7DQo+PiANCj4+IC1pbnQgZXZ0Y2huX21ha2VfcmVmY291bnRlZChldnRjaG5fcG9ydF90
IGV2dGNobikNCj4+ICtpbnQgZXZ0Y2huX21ha2VfcmVmY291bnRlZChldnRjaG5fcG9ydF90IGV2
dGNobiwgYm9vbCBpc19zdGF0aWMpDQo+PiAgew0KPj4gICBpbnQgaXJxID0gZ2V0X2V2dGNobl90
b19pcnEoZXZ0Y2huKTsNCj4+ICAgc3RydWN0IGlycV9pbmZvICppbmZvOw0KPj4gQEAgLTE1OTAs
NiArMTU5Miw3IEBAIGludCBldnRjaG5fbWFrZV9yZWZjb3VudGVkKGV2dGNobl9wb3J0X3QgZXZ0
Y2huKQ0KPj4gICBXQVJOX09OKGluZm8tPnJlZmNudCAhPSAtMSk7DQo+PiANCj4+ICAgaW5mby0+
cmVmY250ID0gMTsNCj4+ICsgaW5mby0+aXNfc3RhdGljID0gaXNfc3RhdGljOw0KPj4gDQo+PiAg
IHJldHVybiAwOw0KPj4gIH0NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3hlbi9ldnRjaG4uYyBi
L2RyaXZlcnMveGVuL2V2dGNobi5jDQo+PiBpbmRleCBjOTk0MTVhNzAwNTEuLmU2ZDIzMDM0Nzhi
MiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMveGVuL2V2dGNobi5jDQo+PiArKysgYi9kcml2ZXJz
L3hlbi9ldnRjaG4uYw0KPj4gQEAgLTM2Niw3ICszNjYsOCBAQCBzdGF0aWMgaW50IGV2dGNobl9y
ZXNpemVfcmluZyhzdHJ1Y3QgcGVyX3VzZXJfZGF0YSAqdSkNCj4+ICAgcmV0dXJuIDA7DQo+PiAg
fQ0KPj4gDQo+PiAtc3RhdGljIGludCBldnRjaG5fYmluZF90b191c2VyKHN0cnVjdCBwZXJfdXNl
cl9kYXRhICp1LCBldnRjaG5fcG9ydF90IHBvcnQpDQo+PiArc3RhdGljIGludCBldnRjaG5fYmlu
ZF90b191c2VyKHN0cnVjdCBwZXJfdXNlcl9kYXRhICp1LCBldnRjaG5fcG9ydF90IHBvcnQsDQo+
PiArIGJvb2wgaXNfc3RhdGljKQ0KPj4gIHsNCj4+ICAgc3RydWN0IHVzZXJfZXZ0Y2huICpldnRj
aG47DQo+PiAgIHN0cnVjdCBldnRjaG5fY2xvc2UgY2xvc2U7DQo+PiBAQCAtNDAyLDE0ICs0MDMs
MTYgQEAgc3RhdGljIGludCBldnRjaG5fYmluZF90b191c2VyKHN0cnVjdCBwZXJfdXNlcl9kYXRh
ICp1LCBldnRjaG5fcG9ydF90IHBvcnQpDQo+PiAgIGlmIChyYyA8IDApDQo+PiAgIGdvdG8gZXJy
Ow0KPj4gDQo+PiAtIHJjID0gZXZ0Y2huX21ha2VfcmVmY291bnRlZChwb3J0KTsNCj4+ICsgcmMg
PSBldnRjaG5fbWFrZV9yZWZjb3VudGVkKHBvcnQsIGlzX3N0YXRpYyk7DQo+PiAgIHJldHVybiBy
YzsNCj4+IA0KPj4gIGVycjoNCj4+ICAgLyogYmluZCBmYWlsZWQsIHNob3VsZCBjbG9zZSB0aGUg
cG9ydCBub3cgKi8NCj4+IC0gY2xvc2UucG9ydCA9IHBvcnQ7DQo+PiAtIGlmIChIWVBFUlZJU09S
X2V2ZW50X2NoYW5uZWxfb3AoRVZUQ0hOT1BfY2xvc2UsICZjbG9zZSkgIT0gMCkNCj4+IC0gQlVH
KCk7DQo+PiArIGlmICghaXNfc3RhdGljKSB7DQo+IA0KPiANCj4gSSB0aGluayBub3cgInN0cnVj
dCBldnRjaG5fY2xvc2UgY2xvc2U7IiBjYW4gYmUgcGxhY2VkIGhlcmUgYXMgaXQgaXMgbm90IA0K
PiB1c2VkIG91dHNpZGUgb2YgdGhpcyBibG9jay4NCj4gDQo+IEFsc28gdGhpcyBibG9jayBsb29r
cyBsaWtlIGFuIG9wZW4tY29kZWQgdmVyc2lvbiBvZiB4ZW5fZXZ0Y2huX2Nsb3NlKCkNCj4gZGVm
aW5lZCBhdCBldmVudHNfYmFzZS5jLCBzbyBtYXliZSBpdCBpcyB3b3J0aCBtYWtpbmcgeGVuX2V2
dGNobl9jbG9zZSgpIA0KPiBzdGF0aWMgaW5saW5lIGFuZCBwbGFjaW5nIGl0IGludG8gZXZlbnRz
LmgsIHRoZW4gY2FsbGluZyBoZWxwZXIgaGVyZT8NCj4gUGxlYXNlIG5vdGUsIEkgd2lsbCBiZSBv
ayBlaXRoZXIgd2F5Lg0KDQpNYWtlIHNlbnNlLiBJIHdpbGwgbW9kaWZ5IHRoZSBwYXRjaCBhcyBw
ZXIgeW91ciByZXF1ZXN0IGluIHRoZSBuZXh0IHZlcnNpb24uDQpJIHdpbGwgd2FpdCBmb3Igb3Ro
ZXIgbWFpbnRhaW5lcnMgdG8gcmV2aWV3IHRoZSBwYXRjaCBiZWZvcmUgc2VuZGluZyB0aGUNCm5l
eHQgdmVyc2lvbi4NCg0KUmVnYXJkcywNClJhaHVsIA0KDQoNCg==
