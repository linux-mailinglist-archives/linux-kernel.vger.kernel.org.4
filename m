Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E00C690994
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjBINNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBINNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:13:00 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2133.outbound.protection.outlook.com [40.107.117.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1073B4109B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 05:12:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnPS7yhQz1sXBylrCDQ+tKYbCjJP9MdO/mbYsw8i8V+Hpz+UmhQWrjbpW40oyYDJUYtW8qyNlvXq9RY0ueg8dWi4OcHFQfDMfwDqUKLze5uvf2iECQlAzJEKpJZ8pAm+4YvEiqJO+laRfTIbsAhCl45oVU5OelO7a7XLlHhdtkmJVD72+pKR1jfMKYlUeipG/RQZ/t+u95YUFx81g4bme8McxBKD8Ke1OkGiViZhPhVerYc0jrPJUrwNBLE3tmzCD8BOSuuYDb5RQ8XPNc5g81n4dV0/fUpRfcOb9maLK7aPKf2f5wvcHIzxbWomsQyP55iT+JA/HrCjQFMtRGoA1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvMAN21OQu3eUfGbDnkVR5NET0JNvw3BowH2/m7mYFM=;
 b=JRT57S/FtwWBYtAp105O15ZxUs9iaI8Pl3zbMDEVl6FGvFG5Y4f2q8e9/x3+15hnZOka4HLUY8yM1CVnLS0dsBHQojaCUnisrDakRtp8ytkHgE/gj4Ozo2XKl4+znnIL9cOyU7ZJtZS2MOGyb3D5NWQDD+0nzoBKtViJSdhxxYa9Ckk2vJmQCo5UrJjG/xlHc4UL7TaPiMHfidPoUIOtteDguvub5vwmtTvjCdLscjZUUDUUwA5w35UXbNRe2QlkggHwaQ0Pe0fdK5J00C+GP4F/7wukfBmR7G+YLkwwxdXi6sXHp5APM8V5WI+t/GD5aYHzKugIwm51RpwbPGnZ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvMAN21OQu3eUfGbDnkVR5NET0JNvw3BowH2/m7mYFM=;
 b=IIySzlA1zLZb7pzJGBXc57PK877YJ/m8eJyd70huN8rs/2VNDWE/SUmzOjKH7zVTEBotY+li2rDxYOOZrGb0WEt3WpGO3d3HyleP1hkfQB5i3WTf4i9HuQcmOgfN6w2xLLi3sWlbcBPox8nKx4zwL3P2dyY2M8ViQpnrq3CoqGQ=
Received: from OS3PR01MB8460.jpnprd01.prod.outlook.com (2603:1096:604:197::13)
 by TY3PR01MB11907.jpnprd01.prod.outlook.com (2603:1096:400:409::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 13:12:54 +0000
Received: from OS3PR01MB8460.jpnprd01.prod.outlook.com
 ([fe80::e332:554a:7:7135]) by OS3PR01MB8460.jpnprd01.prod.outlook.com
 ([fe80::e332:554a:7:7135%4]) with mapi id 15.20.6086.018; Thu, 9 Feb 2023
 13:12:54 +0000
From:   DLG Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
        "kernel@dh-electronics.com" <kernel@dh-electronics.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 1/2] mfd: da9062: Remove IRQ requirement
Thread-Topic: [PATCH V2 1/2] mfd: da9062: Remove IRQ requirement
Thread-Index: AQHZPHS1YH4sf27ldEiKgRx1HuGWWq7GlnHw
Date:   Thu, 9 Feb 2023 13:12:53 +0000
Message-ID: <OS3PR01MB8460238997E7E63788DBF60DC2D99@OS3PR01MB8460.jpnprd01.prod.outlook.com>
References: <20230209105144.9351-1-cniedermaier@dh-electronics.com>
In-Reply-To: <20230209105144.9351-1-cniedermaier@dh-electronics.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB8460:EE_|TY3PR01MB11907:EE_
x-ms-office365-filtering-correlation-id: d0ba4d11-9ddc-4a15-f75d-08db0a9f5ab2
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Y6W3NY6gGe3hzzTopdBfiQ/OTPdzCXHrC03HdrI212k7XTxx0WajoJTGWm1KT589Mr5FBcZ747si2axZ8+ISMPdongU/kGsZwv5OGnrM0pwWOjUw4fb5ujBpbXBcsvuKcuJvxkg06ixJUsCt4mrfPE32kJBF0eXgAgb+KfKa6Qr2wt77ViaNNc82VkMKqHadVjpAxrgpNv+7PzADfhLaLjaeEfWS5MQboymzsoXzQQkppeyvZxAvdu+ZUkpIaWhkK3zOW9w6wl3Mk6xUnlaYVfAad8q3j9njY9qRbHQc8MXawjjZZ1zPYKOuOtwiLeX2HY6GWjHvi5weZQ/9wxCgOzh8pvwa7YdIpoGXQ/FTLWUKaa2q30SFM8we6gmAFD1lbYQQdD/cGY6lzDL1A1WlQvcReJ3Z+FRCYbquCJaCixtzvx+LUz3T7t6VUDLo7UCgzzAaLPUQiP0uUfIts1YY/3DYEs3kQHVwMfsFKc/Kk0pEZqQbcmZPCG60ge0dnAuKx3HiK2FVK59Ye61VuczzytaND2D7ckpqfaVeiDz5nt1odVAfXGsgKb9ogA5ecGtAZnmn4ojvID+dANQmxA/K+c3SWBjOdPU0GwVkHmUnKO2r5o9E7W1fy7c4+b77+7udVGBlKchG7XpXYHpvcWxsRxksxDOPjacye2/QrWzCGJsFC+y3eMyY9XIM7wSVQ0qSOzWGh3ihr0qu1kv8PI/+5lkGqw8P4JHkY61h/Fm8Mo3IyOJxbb6fTQJ8RaymV6G
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8460.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199018)(4326008)(8676002)(76116006)(66556008)(66946007)(66476007)(66446008)(86362001)(41300700001)(38100700002)(122000001)(64756008)(186003)(26005)(33656002)(2906002)(55016003)(38070700005)(71200400001)(52536014)(478600001)(6506007)(55236004)(53546011)(9686003)(316002)(8936002)(110136005)(7696005)(5660300002)(7416002)(54906003)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hrt0O6D5fIaHxPnX2LGQn3GmtQ8NsH+PIHdKXDNSAjM7rQ5EjPMDnV7bDkqH?=
 =?us-ascii?Q?EtJP6pM7wzjUzQXltIEdz7rdDes2kg0jZsza5vYjf9Os1rPwMcL7WB5gxZVA?=
 =?us-ascii?Q?uPDE5qSd3GEEVxxikTnJhbA3yo9dX8gTXvHAsYXfiU1GVXrKJjYVKE5PWBbM?=
 =?us-ascii?Q?2fFN7GGHUcaBO5D52EIYS4+yq4BvyNRtAq3n8U4dEXGPxFdyljCGdExQqKhZ?=
 =?us-ascii?Q?Vtt+rxpe8UzG7aneHpMySEIF96ZWM4P07bgTlRzl9UnK1/bQ4L2U863B/IEo?=
 =?us-ascii?Q?Rl0CqDKN2wBpnFM/MGsqxPE2KUdMzrlDfdgU3Xd7cY4hT/EjhTrbd5UuB+LE?=
 =?us-ascii?Q?/4NmWKJiuF6waUhENDmUlwUK7QRnVlZMKX/jeVkup+jY/4aUMNodXxrG3ZLw?=
 =?us-ascii?Q?psG582On4avjK/szPkxpKux13Fj88Q578vh4JGKUpv7iw8lfudMNdFGhWNGF?=
 =?us-ascii?Q?YghSvv1A79qHOxyEYfYRFqgWlzPL8LAEKI+E0Hm75DUkI/0R2HsIpFtSW31Y?=
 =?us-ascii?Q?kasniZW8Uti/bQx8Zu6+1FrZafvnNKk7qiaVpqU3sdS0bUP7SMmZZH0+m1Ho?=
 =?us-ascii?Q?CGntpD2mLvFIYRAxJAcU5BIgj3+igDMPwLMs3JLEI+kElk5YV+33X3OfWns/?=
 =?us-ascii?Q?mS/u6mzhZrC9uT3PTpBabPY9oHmwTWT5Eg4xxbn8oZn8/HdhGkOSF7E8FAyD?=
 =?us-ascii?Q?7f7iPlGhjPolPWyZ8xyJfOq7eCj2TXAYMahFGKakIpj0/1e1U3nOSXTY0YpJ?=
 =?us-ascii?Q?j5K1KE7sY3Fyy9QIt/LooH9Vuc8sr38IY90hTzNfQ4q51xP8WpveWCTvSYbi?=
 =?us-ascii?Q?SYCKttk5GkTnf7aXp/kplxkkh+gYaPGzV1rv9Si5nZk4dCUcZwC5dAtToMEw?=
 =?us-ascii?Q?vGRcEX/ZX/eV+DiQFgtvcZG8/2uYLBiIoA726mbABoDYqJAOkLapd0aS9SR6?=
 =?us-ascii?Q?a2JUkDTup52NSPMVZ4EG90hAn0eo9pqYGVhxT4g4VDbq5mwEqgrTRh/xAgXo?=
 =?us-ascii?Q?k/leb2gDWce2c27uh763UsPRBRdUd7xT3UnUIjduZ/4BfSt3L/09bIpVxVvh?=
 =?us-ascii?Q?AZszpX3OQHxRlmLIgOKqg7yp4m4cLCnvkFFCW6dHp0PxhH5Mq++FkNeTQe9m?=
 =?us-ascii?Q?XdwRMKAEqKT/0R86Pr7nwG67Lp6GXFRBZ5ePz/c9RIHeFTXEM1GJh/+nrzBH?=
 =?us-ascii?Q?u13QDEA7oa+b3mgdg7Wi7lt1Hwlu9tmrs4alIhPKEeNH9jatKFotQwGOW4BT?=
 =?us-ascii?Q?XzzWq9mE5bF6tVzbACtbSyUeU1+Vt3B1QgMMz+0y6nQAVLENl4rruh9/m5k3?=
 =?us-ascii?Q?knUe8mDPOi4yUfaNaGhCgdXFI6y5XPwRN4ca3iI/mVm5sbrZgdAnW5SjHGOK?=
 =?us-ascii?Q?jbzlu24e40+FU08jAjzMcmvvBa8xAB+4N7nWIGdNJZBsOvnQJ8+RKrh0jbLT?=
 =?us-ascii?Q?HujPz3Fy/2CIcoX4BvmjANjKnpJ9XQB1UzutOsmF/642lCmKK3R3p8kiypGl?=
 =?us-ascii?Q?m1cPzqzg1d429crQbbJT7R+M9Y3B0YuHqTmuKftkMOZdd0JWM8shtB7ahGkK?=
 =?us-ascii?Q?VELqlEGRKIukzf14rmyyQfsv39J4Dxb/hO23wb6xqF2PQQfK19b+bb3yomry?=
 =?us-ascii?Q?wg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8460.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ba4d11-9ddc-4a15-f75d-08db0a9f5ab2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 13:12:54.0500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ti9O+wI1NM+g+6m3gXOELDAxXl4PMyneMmLpjAmmyMoVCbc+NvEkw8vYN+Cj4Tz45GuGX9BD/J2lEW+iKfz4NtcLkbxQwIfJ9rRkMNnldZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11907
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/23 11:51, Christoph Niedermaier wrote:
> This patch removes the requirement for an IRQ, because for the core=20
> functionality IRQ isn't needed. So this makes the DA9061/62 chip=20
> useable for designs which haven't connected the IRQ pin.
>=20
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> ---
> Cc: Support Opensource <support.opensource@diasemi.com>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Marek Vasut <marex@denx.de>
> Cc: kernel@dh-electronics.com
> Cc: linux-kernel@vger.kernel.org
> To: linux-arm-kernel@lists.infradead.org
> ---
> V2: - Rebase on current next 20230209
>      - Add Lee Jones to Cc list

Thanks!

Reviewed-by: Adam Ward <Adam.Ward.Opensouce@diasemi.com>
