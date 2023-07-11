Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3CF74E8D6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjGKISZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjGKISX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:18:23 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2069.outbound.protection.outlook.com [40.107.105.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C22E5C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 01:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UccfmIKgRvQ5c22KsMfYtgaMV1HHwHF39bAJoiFCgUU=;
 b=BbjAA5yBUicxfFmMol9gpzAnZ8X93b72NLEHipO9bYJlnpuxdCVO4qCJMqPg+poC6OLl+yWWUwCIEQolI3vh0PjfXEnV5tot3ub/nBSGZ9WD2kYxXSzh2/128JPp67dU8h9GHkzwsnK1X+Aitk1Kx14VLFe+YK0Gxkn63/AUM28=
Received: from DUZPR01CA0076.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::7) by AS8PR08MB7720.eurprd08.prod.outlook.com
 (2603:10a6:20b:508::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.29; Tue, 11 Jul
 2023 08:18:01 +0000
Received: from DBAEUR03FT058.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:46a:cafe::80) by DUZPR01CA0076.outlook.office365.com
 (2603:10a6:10:46a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32 via Frontend
 Transport; Tue, 11 Jul 2023 08:18:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT058.mail.protection.outlook.com (100.127.142.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.18 via Frontend Transport; Tue, 11 Jul 2023 08:18:00 +0000
Received: ("Tessian outbound 95df046a2e2c:v145"); Tue, 11 Jul 2023 08:18:00 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6e701e5c6388ae21
X-CR-MTA-TID: 64aa7808
Received: from 4264739d99c1.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 28642A04-4A4D-4BB6-ABAB-9BB6D4AB4345.1;
        Tue, 11 Jul 2023 08:17:54 +0000
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4264739d99c1.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 11 Jul 2023 08:17:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXiRwiMFEeujdKMMLL5/qMnY0HyHXb754h2QhEYZqzvVA0xwmhPjLmRkE59H7t1bqwllMd2+Vu80Aq7kyf7Rim1nEpO9JLIq1BFMQn+Sy5pPXHMmq27oEE+vxvPyFwQjMM046NV3Mhy2wOyLt2SpnC/3/Be8dgduNQOXBiMRRnKL6gfCUO70zR+4cL1T15r0xVoAS30++pRz3K+tBvidExJPCYDthibckv8MvDUtrn7qBMSzU0ZKxkanggKf955j2CRwxdlvI82i9xL8TUdylETsmorUMy22fzsTeIsVNgM+GivZW6CPDH/rkFT7Zh9Q2DxANdsAx0NMNyA4DLWPSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UccfmIKgRvQ5c22KsMfYtgaMV1HHwHF39bAJoiFCgUU=;
 b=h4dl/eU8j13Bhidsbt/1bXjFFsPGeqeMM0n9xrapR/oIKeZyzMDCAdMjm884vonHgp5CwKsOY2OTUjd15A2pRjXoJPU/J5HgZDz3Kz/WLOxThC96fv+aMoSb1fzeQ8C8xajI44k6tR+dpGxU88uWaQDgH/1fqQQnM6DTE/xhg27gq41QUhQZ79Z9L0EKuvlKuWD8o66O0gFwxAiao6SkheGiQLEaokAiKGsuKC6A2AlHyAiTAYw0qIC/huEbJIR0IRlbS18JYN0SQmkfEBf5t+61ch52X3CNHVLRJLlbThMGGLKO0uheYYkXK+pPCevx0GUs52f2j4FA1aOot8VcWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UccfmIKgRvQ5c22KsMfYtgaMV1HHwHF39bAJoiFCgUU=;
 b=BbjAA5yBUicxfFmMol9gpzAnZ8X93b72NLEHipO9bYJlnpuxdCVO4qCJMqPg+poC6OLl+yWWUwCIEQolI3vh0PjfXEnV5tot3ub/nBSGZ9WD2kYxXSzh2/128JPp67dU8h9GHkzwsnK1X+Aitk1Kx14VLFe+YK0Gxkn63/AUM28=
Received: from AM9PR08MB7165.eurprd08.prod.outlook.com (2603:10a6:20b:41f::23)
 by PA4PR08MB5920.eurprd08.prod.outlook.com (2603:10a6:102:ea::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 08:17:52 +0000
Received: from AM9PR08MB7165.eurprd08.prod.outlook.com
 ([fe80::a4db:63a3:ef32:ffd3]) by AM9PR08MB7165.eurprd08.prod.outlook.com
 ([fe80::a4db:63a3:ef32:ffd3%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 08:17:52 +0000
From:   Rahul Singh <Rahul.Singh@arm.com>
To:     Stefano Stabellini <sstabellini@kernel.org>
CC:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Jane Malalane <jane.malalane@citrix.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2] xen/evtchn: Introduce new IOCTL to bind static evtchn
Thread-Topic: [PATCH v2] xen/evtchn: Introduce new IOCTL to bind static evtchn
Thread-Index: AQHZqqDrFlYPmniBzkyAFz9id20VH6+iE7EAgAE9TgCADU1ZgIADrKEA
Date:   Tue, 11 Jul 2023 08:17:52 +0000
Message-ID: <13058DBB-CF04-4549-B1EF-E9FD870E63D2@arm.com>
References: <764d561e3aecb7e63e8601dc50aaef9fc40834e4.1688051342.git.rahul.singh@arm.com>
 <90c961d4-9d10-6fbc-b5f7-84d231264289@epam.com>
 <156827AA-3DFB-4DA2-BC82-7A27E77C2092@arm.com>
 <alpine.DEB.2.22.394.2307081710210.761183@ubuntu-linux-20-04-desktop>
In-Reply-To: <alpine.DEB.2.22.394.2307081710210.761183@ubuntu-linux-20-04-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: AM9PR08MB7165:EE_|PA4PR08MB5920:EE_|DBAEUR03FT058:EE_|AS8PR08MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: d41dda41-9406-4c54-185b-08db81e75775
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ALpK8/RhWLyPG78MgGWHEfMmxChTR3SICx15wD0cSgFbXQ9tUEVHj/csagrX4YfB2/xcKVfpZzYvu5Ivity1BnqlWqqP1QlzfGwJIws3RGD/uvKqOC8kNbB3f/ac4ICGqRTVt8OX0AqeN+arDiDDxQemhGXorkeXuKcQppTY91FyXNC6VCyUmEALSEGFv+IeZ50VyvTKjR7NWwxTmXVm2NilI6CF+1nF7Tb4easjlF3QvOr1WRRIgXXvyiL/OG6ukLtCr25N8Isy6ld6dWXfXk7lYiFxrXMkY49VfTDlYINONDL9s4wHiOdFRkGPxoa2+tWdOEij5CEgIQjNjcRzj5tsiNOloNWI+fttCqKdjiES8KNZIj5l/joUSJ1eFF0pe3AqL57cDdCJCMxs3y3yW+Igg1kA9glnhvYttHj/nucOgaeHyZyFrmLzIis+sJRfPhN3K9iC6cZkbj396qFXCJ3Vr82uckz1wwlEWcEbcocwVoj92byUCrwRV+hH+tL/qwol1VuokGrUYZmoaMUEa6LjSIJMeWvQqEdkNgKyU7mur6SFD7ZyLz17QSrHNe4ilnWlIh6ZOcoG8LZcVbJqMJyXBE2XNJCTSJjO8RWWW3V8XKGXO0+FtAc4GVhAogPgOMoQW75TNL4x9yzxJ6HhsA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7165.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(451199021)(6486002)(71200400001)(478600001)(122000001)(54906003)(38070700005)(8936002)(5660300002)(36756003)(2906002)(8676002)(33656002)(86362001)(4326008)(6916009)(316002)(91956017)(76116006)(38100700002)(66446008)(66476007)(64756008)(66556008)(66946007)(41300700001)(6506007)(26005)(53546011)(2616005)(6512007)(83380400001)(186003)(45980500001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A6D9404D720854AB2F45796C2FD8807@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5920
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT058.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: ce36e78f-e7f4-4b24-c890-08db81e75286
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wwbwcvqsi/kdKSg3uWnSMhpLZ35vjDVlvz+XzdE8YDAl+oRXsMTMTnlOX0NKwVacjQdnkzKf835gU/IhRTUMwKj6szqIWxryr0icikan9CZaPZBVbT0Ji6/wv9g5kXbMzwDjVat9vqCsU5d3DfRI/VqAHSDx5noAxxVGCCDIVYgTqdsB72yYrEnU5Le6f9p3GS+ncIctzETXvwhSGyJJSkb2nu6AgninBTpi2I5ZKnhybxOAn8wqUun5wybn0ArFyxK9jcIi5Zxms9MicRuJZM5hfvBV5keLTIRhHZ4Gr1WR+cIHv6aprZdTkoIQTsghbB72LO8N+JwEpC0y2n3lyXVlQbgSRr5D3oixeF+OiDFUDY1mI3spAHmib3sBXSW8scA70/gmd2DDyyXp3rDKWCVM9n6HkU01rft/4QkNz6dYT2/y33sBcezwPywyunioe5k0WH6ZY/5b1xUiD9KYHND89GbcX7uw5atsrdOWW4z4/FXVZdMQvNgvsaG1mKdbDPMWz21MkP+jJ2/0dKFeIpxzxeT5H0zlm4vIg3tdVtQy40p26hoVzq8Klbj2uPtL8VeWwOFnDH1t2vOWacR7kXZ1YLlL/N7leAb6OBoDYBdAN+aQo2qa0Y9lRNNh4wLOvIxxme8zpd/JQg7tWgC+OhwhA3+ABTp11OL92Ysp+858dgZCiRb8llwQml77/5IALEOvM0zTnCMBSKUr6OSc2oyrFDauZvIVeRhoQ3SKJWLLf3g40XvndlirFibV1dEE
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(46966006)(40470700004)(36840700001)(54906003)(81166007)(47076005)(356005)(6486002)(82740400003)(40460700003)(478600001)(6862004)(8676002)(5660300002)(2906002)(36756003)(8936002)(86362001)(33656002)(82310400005)(316002)(4326008)(40480700001)(70206006)(70586007)(83380400001)(41300700001)(26005)(6506007)(53546011)(186003)(336012)(2616005)(107886003)(6512007)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 08:18:00.7621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d41dda41-9406-4c54-185b-08db81e75775
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT058.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7720
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgLA0KDQo+IE9uIDkgSnVsIDIwMjMsIGF0IDE6MTAgYW0sIFN0ZWZhbm8gU3RhYmVsbGluaSA8
c3N0YWJlbGxpbmlAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIDMwIEp1biAyMDIz
LCBSYWh1bCBTaW5naCB3cm90ZToNCj4+IEhpIE9sZWtzYW5kciwNCj4+IA0KPj4gVGhhbmtzIGZv
ciByZXZpZXdpbmcgdGhlIGNvZGUuDQo+PiANCj4+PiBPbiAyOSBKdW4gMjAyMywgYXQgNzowNiBw
bSwgT2xla3NhbmRyIFR5c2hjaGVua28gPG9sZWtzYW5kcl90eXNoY2hlbmtvQGVwYW0uY29tPiB3
cm90ZToNCj4+PiANCj4+PiANCj4+PiANCj4+PiBPbiAyOS4wNi4yMyAxODo0NiwgUmFodWwgU2lu
Z2ggd3JvdGU6DQo+Pj4gDQo+Pj4gSGVsbG8gUmFodWwNCj4+PiANCj4+PiANCj4+Pj4gWGVuIDQu
MTcgc3VwcG9ydHMgdGhlIGNyZWF0aW9uIG9mIHN0YXRpYyBldnRjaG5zLiBUbyBhbGxvdyB1c2Vy
IHNwYWNlDQo+Pj4+IGFwcGxpY2F0aW9uIHRvIGJpbmQgc3RhdGljIGV2dGNobnMgaW50cm9kdWNl
IG5ldyBpb2N0bA0KPj4+PiAiSU9DVExfRVZUQ0hOX0JJTkRfU1RBVElDIi4gRXhpc3RpbmcgSU9D
VEwgZG9pbmcgbW9yZSB0aGFuIGJpbmRpbmcNCj4+Pj4gdGhhdOKAmXMgd2h5IHdlIG5lZWQgdG8g
aW50cm9kdWNlIHRoZSBuZXcgSU9DVEwgdG8gb25seSBiaW5kIHRoZSBzdGF0aWMNCj4+Pj4gZXZl
bnQgY2hhbm5lbHMuDQo+Pj4+IA0KPj4+PiBBbHNvLCBzdGF0aWMgZXZ0Y2hucyB0byBiZSBhdmFp
bGFibGUgZm9yIHVzZSBkdXJpbmcgdGhlIGxpZmV0aW1lIG9mIHRoZQ0KPj4+PiBndWVzdC4gV2hl
biB0aGUgYXBwbGljYXRpb24gZXhpdHMsIF9fdW5iaW5kX2Zyb21faXJxKCkgZW5kcyB1cCBiZWlu
Zw0KPj4+PiBjYWxsZWQgZnJvbSByZWxlYXNlKCkgZmlsZSBvcGVyYXRpb25zIGJlY2F1c2Ugb2Yg
dGhhdCBzdGF0aWMgZXZ0Y2hucw0KPj4+PiBhcmUgZ2V0dGluZyBjbG9zZWQuIFRvIGF2b2lkIGNs
b3NpbmcgdGhlIHN0YXRpYyBldmVudCBjaGFubmVsLCBhZGQgdGhlDQo+Pj4+IG5ldyBib29sIHZh
cmlhYmxlICJpc19zdGF0aWMiIGluICJzdHJ1Y3QgaXJxX2luZm8iIHRvIG1hcmsgdGhlIGV2ZW50
DQo+Pj4+IGNoYW5uZWwgc3RhdGljIHdoZW4gY3JlYXRpbmcgdGhlIGV2ZW50IGNoYW5uZWwgdG8g
YXZvaWQgY2xvc2luZyB0aGUNCj4+Pj4gc3RhdGljIGV2dGNobi4NCj4+Pj4gDQo+Pj4+IFNpZ25l
ZC1vZmYtYnk6IFJhaHVsIFNpbmdoIDxyYWh1bC5zaW5naEBhcm0uY29tPg0KPj4+PiAtLS0NCj4+
Pj4gdjI6DQo+Pj4+ICogVXNlIGJvb2wgaW4gcGxhY2UgdTggdG8gZGVmaW5lIGlzX3N0YXRpYyB2
YXJpYWJsZS4NCj4+Pj4gKiBBdm9pZCBjbG9zaW5nIHRoZSBzdGF0aWMgZXZ0Y2hucyBpbiBlcnJv
ciBwYXRoLg0KPj4+IA0KPj4+IA0KPj4+IFBhdGNoIGxvb2tzIGdvb2QgdG8gbWUsIGp1c3QgYSBu
aXQgKHF1ZXN0aW9uKSBiZWxvdy4NCj4+PiANCj4+PiANCj4+Pj4gLS0tDQo+Pj4+IGRyaXZlcnMv
eGVuL2V2ZW50cy9ldmVudHNfYmFzZS5jIHwgIDcgKysrKystLQ0KPj4+PiBkcml2ZXJzL3hlbi9l
dnRjaG4uYyAgICAgICAgICAgICB8IDMwICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQ0K
Pj4+PiBpbmNsdWRlL3VhcGkveGVuL2V2dGNobi5oICAgICAgICB8ICA5ICsrKysrKysrKw0KPj4+
PiBpbmNsdWRlL3hlbi9ldmVudHMuaCAgICAgICAgICAgICB8ICAyICstDQo+Pj4+IDQgZmlsZXMg
Y2hhbmdlZCwgMzcgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+Pj4+IA0KPj4+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy94ZW4vZXZlbnRzL2V2ZW50c19iYXNlLmMgYi9kcml2ZXJzL3hl
bi9ldmVudHMvZXZlbnRzX2Jhc2UuYw0KPj4+PiBpbmRleCBjNzcxNWY4YmQ0NTIuLjVkM2I1Yzdj
ZmU2NCAxMDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVycy94ZW4vZXZlbnRzL2V2ZW50c19iYXNlLmMN
Cj4+Pj4gKysrIGIvZHJpdmVycy94ZW4vZXZlbnRzL2V2ZW50c19iYXNlLmMNCj4+Pj4gQEAgLTEx
Miw2ICsxMTIsNyBAQCBzdHJ1Y3QgaXJxX2luZm8gew0KPj4+PiAgdW5zaWduZWQgaW50IGlycV9l
cG9jaDsgLyogSWYgZW9pX2NwdSB2YWxpZDogaXJxX2Vwb2NoIG9mIGV2ZW50ICovDQo+Pj4+ICB1
NjQgZW9pX3RpbWU7ICAgICAgICAgICAvKiBUaW1lIGluIGppZmZpZXMgd2hlbiB0byBFT0kuICov
DQo+Pj4+ICByYXdfc3BpbmxvY2tfdCBsb2NrOw0KPj4+PiArIGJvb2wgaXNfc3RhdGljOyAgICAg
ICAgICAgLyogSXMgZXZlbnQgY2hhbm5lbCBzdGF0aWMgKi8NCj4+Pj4gDQo+Pj4+ICB1bmlvbiB7
DQo+Pj4+ICB1bnNpZ25lZCBzaG9ydCB2aXJxOw0KPj4+PiBAQCAtOTgyLDcgKzk4Myw4IEBAIHN0
YXRpYyB2b2lkIF9fdW5iaW5kX2Zyb21faXJxKHVuc2lnbmVkIGludCBpcnEpDQo+Pj4+ICB1bnNp
Z25lZCBpbnQgY3B1ID0gY3B1X2Zyb21faXJxKGlycSk7DQo+Pj4+ICBzdHJ1Y3QgeGVuYnVzX2Rl
dmljZSAqZGV2Ow0KPj4+PiANCj4+Pj4gLSB4ZW5fZXZ0Y2huX2Nsb3NlKGV2dGNobik7DQo+Pj4+
ICsgaWYgKCFpbmZvLT5pc19zdGF0aWMpDQo+Pj4+ICsgeGVuX2V2dGNobl9jbG9zZShldnRjaG4p
Ow0KPj4+PiANCj4+Pj4gIHN3aXRjaCAodHlwZV9mcm9tX2lycShpcnEpKSB7DQo+Pj4+ICBjYXNl
IElSUVRfVklSUToNCj4+Pj4gQEAgLTE1NzQsNyArMTU3Niw3IEBAIGludCB4ZW5fc2V0X2lycV9w
cmlvcml0eSh1bnNpZ25lZCBpcnEsIHVuc2lnbmVkIHByaW9yaXR5KQ0KPj4+PiB9DQo+Pj4+IEVY
UE9SVF9TWU1CT0xfR1BMKHhlbl9zZXRfaXJxX3ByaW9yaXR5KTsNCj4+Pj4gDQo+Pj4+IC1pbnQg
ZXZ0Y2huX21ha2VfcmVmY291bnRlZChldnRjaG5fcG9ydF90IGV2dGNobikNCj4+Pj4gK2ludCBl
dnRjaG5fbWFrZV9yZWZjb3VudGVkKGV2dGNobl9wb3J0X3QgZXZ0Y2huLCBib29sIGlzX3N0YXRp
YykNCj4+Pj4gew0KPj4+PiAgaW50IGlycSA9IGdldF9ldnRjaG5fdG9faXJxKGV2dGNobik7DQo+
Pj4+ICBzdHJ1Y3QgaXJxX2luZm8gKmluZm87DQo+Pj4+IEBAIC0xNTkwLDYgKzE1OTIsNyBAQCBp
bnQgZXZ0Y2huX21ha2VfcmVmY291bnRlZChldnRjaG5fcG9ydF90IGV2dGNobikNCj4+Pj4gIFdB
Uk5fT04oaW5mby0+cmVmY250ICE9IC0xKTsNCj4+Pj4gDQo+Pj4+ICBpbmZvLT5yZWZjbnQgPSAx
Ow0KPj4+PiArIGluZm8tPmlzX3N0YXRpYyA9IGlzX3N0YXRpYzsNCj4+Pj4gDQo+Pj4+ICByZXR1
cm4gMDsNCj4+Pj4gfQ0KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy94ZW4vZXZ0Y2huLmMgYi9k
cml2ZXJzL3hlbi9ldnRjaG4uYw0KPj4+PiBpbmRleCBjOTk0MTVhNzAwNTEuLmU2ZDIzMDM0Nzhi
MiAxMDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVycy94ZW4vZXZ0Y2huLmMNCj4+Pj4gKysrIGIvZHJp
dmVycy94ZW4vZXZ0Y2huLmMNCj4+Pj4gQEAgLTM2Niw3ICszNjYsOCBAQCBzdGF0aWMgaW50IGV2
dGNobl9yZXNpemVfcmluZyhzdHJ1Y3QgcGVyX3VzZXJfZGF0YSAqdSkNCj4+Pj4gIHJldHVybiAw
Ow0KPj4+PiB9DQo+Pj4+IA0KPj4+PiAtc3RhdGljIGludCBldnRjaG5fYmluZF90b191c2VyKHN0
cnVjdCBwZXJfdXNlcl9kYXRhICp1LCBldnRjaG5fcG9ydF90IHBvcnQpDQo+Pj4+ICtzdGF0aWMg
aW50IGV2dGNobl9iaW5kX3RvX3VzZXIoc3RydWN0IHBlcl91c2VyX2RhdGEgKnUsIGV2dGNobl9w
b3J0X3QgcG9ydCwNCj4+Pj4gKyBib29sIGlzX3N0YXRpYykNCj4+Pj4gew0KPj4+PiAgc3RydWN0
IHVzZXJfZXZ0Y2huICpldnRjaG47DQo+Pj4+ICBzdHJ1Y3QgZXZ0Y2huX2Nsb3NlIGNsb3NlOw0K
Pj4+PiBAQCAtNDAyLDE0ICs0MDMsMTYgQEAgc3RhdGljIGludCBldnRjaG5fYmluZF90b191c2Vy
KHN0cnVjdCBwZXJfdXNlcl9kYXRhICp1LCBldnRjaG5fcG9ydF90IHBvcnQpDQo+Pj4+ICBpZiAo
cmMgPCAwKQ0KPj4+PiAgZ290byBlcnI7DQo+Pj4+IA0KPj4+PiAtIHJjID0gZXZ0Y2huX21ha2Vf
cmVmY291bnRlZChwb3J0KTsNCj4+Pj4gKyByYyA9IGV2dGNobl9tYWtlX3JlZmNvdW50ZWQocG9y
dCwgaXNfc3RhdGljKTsNCj4+Pj4gIHJldHVybiByYzsNCj4+Pj4gDQo+Pj4+IGVycjoNCj4+Pj4g
IC8qIGJpbmQgZmFpbGVkLCBzaG91bGQgY2xvc2UgdGhlIHBvcnQgbm93ICovDQo+Pj4+IC0gY2xv
c2UucG9ydCA9IHBvcnQ7DQo+Pj4+IC0gaWYgKEhZUEVSVklTT1JfZXZlbnRfY2hhbm5lbF9vcChF
VlRDSE5PUF9jbG9zZSwgJmNsb3NlKSAhPSAwKQ0KPj4+PiAtIEJVRygpOw0KPj4+PiArIGlmICgh
aXNfc3RhdGljKSB7DQo+Pj4gDQo+Pj4gDQo+Pj4gSSB0aGluayBub3cgInN0cnVjdCBldnRjaG5f
Y2xvc2UgY2xvc2U7IiBjYW4gYmUgcGxhY2VkIGhlcmUgYXMgaXQgaXMgbm90IA0KPj4+IHVzZWQg
b3V0c2lkZSBvZiB0aGlzIGJsb2NrLg0KPj4+IA0KPj4+IEFsc28gdGhpcyBibG9jayBsb29rcyBs
aWtlIGFuIG9wZW4tY29kZWQgdmVyc2lvbiBvZiB4ZW5fZXZ0Y2huX2Nsb3NlKCkNCj4+PiBkZWZp
bmVkIGF0IGV2ZW50c19iYXNlLmMsIHNvIG1heWJlIGl0IGlzIHdvcnRoIG1ha2luZyB4ZW5fZXZ0
Y2huX2Nsb3NlKCkgDQo+Pj4gc3RhdGljIGlubGluZSBhbmQgcGxhY2luZyBpdCBpbnRvIGV2ZW50
cy5oLCB0aGVuIGNhbGxpbmcgaGVscGVyIGhlcmU/DQo+Pj4gUGxlYXNlIG5vdGUsIEkgd2lsbCBi
ZSBvayBlaXRoZXIgd2F5Lg0KPj4gDQo+PiBNYWtlIHNlbnNlLiBJIHdpbGwgbW9kaWZ5IHRoZSBw
YXRjaCBhcyBwZXIgeW91ciByZXF1ZXN0IGluIHRoZSBuZXh0IHZlcnNpb24uDQo+PiBJIHdpbGwg
d2FpdCBmb3Igb3RoZXIgbWFpbnRhaW5lcnMgdG8gcmV2aWV3IHRoZSBwYXRjaCBiZWZvcmUgc2Vu
ZGluZyB0aGUNCj4+IG5leHQgdmVyc2lvbi4NCj4gDQo+IEkgZG9uJ3QgaGF2ZSBhbnkgZnVydGhl
ciBjb21tZW50cy4NCg0KVGhhbmtzIGZvciB0aGUgdXBkYXRlLiBJIHdpbGwgc2VuZCB0aGUgbmV4
dCB2ZXJzaW9uLg0KDQoNClJlZ2FyZHMsDQpSYWh1bA0KDQoNCg==
