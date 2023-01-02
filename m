Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C0765AE7A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 09:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjABI6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 03:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjABI6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 03:58:07 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2010.outbound.protection.outlook.com [40.92.103.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE235D42;
        Mon,  2 Jan 2023 00:58:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+Fr7GrcF5JYpS0xYfMI2s4gUCBp+FaX4ax2/EC5JsDmoLKHy/DflXrD4gCiMnKqcPTLLsMCJOuluhglBk620xV+Vtrp8S9e563Ir5Y4ZqeSdc2JWF9rGLgcL+tjGrTiSIw5QnzoiZ9rRAILG+tgijhu+phzcyRuE+D2xHWiL6AJ8su3Kz51olbMoQp0xRfjMjXDB4MEc7LFKFSWVOEHNG94AOh0sNy7HYqllZK4EZSkrRNmxqrZQ8tj4IVJ7OFFjSZMbFq/FVkMaEk90fnDwGdrVy2FG61+TXSfs/dJ2UcaBDVfpnbm78F2awnTkBXj5V6WlVAYU4lByRQCr+X41w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKtu76cex8BLz752TpTbimE6zgCfQRBzqGUJYtIIVHk=;
 b=gg+n0KwMXj+zyWoa2MUKYkIabRRrdlJa2HULZHxM647Jpce0egOe0qQZbxaNV4D4Kp2HoQo/j2OMxJRSWUYXTI8NupinAuRKExObbmDrslfkRbFT4CAh6mzTAiryZVcmQYNSYLZD2scLw9z6q6B1NmvfUBWXoLPGw+D9tMK4ek9MVeHY7t6MO920gq8YPMzObCVwxuSz3FMjAsQSLiidj1Md2ONTyuiBeYd9ZlybTEMxvFdTp2bLPmVxkWIGDdtCLz9Ng80Hnlmt+l8w996mCmaA2VQB25ss1XgCRLitEUhqYL9039EpCCHQd5S6F1jKbAK94D9tLvOlAMnCZhb5mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKtu76cex8BLz752TpTbimE6zgCfQRBzqGUJYtIIVHk=;
 b=WZ4H9V6nF3olRUvrIqx3G4OdZJrMpr+8PlQz1qhBTrOYJx98BIT5wn6o90v/rh4RHpqTVJ0y1JfIeyk6I7oQ/sJF440a1ZhvvoEeLo9HBJptD2GfMmL652DynQEyQn5g2x+KN997V9CgA8BvrjnZGEVvM7jncED0PQBIh5MZVtYP2EzHwxwo88p97WTSpMsnRJ+sTtHXBZBIaazazRX6ZZiZqsrOF5tjTOfC6+6tok8c9FaZsHF9Nf22pc3xEDx35Igs0pz+4gGoRerB+kKJCjC1yrwjXMtRCiVUNNhCJ88t03j1fWzBnWQfAiME6vb2mh7teltbGvxfCbpE44D/bQ==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 MAZPR01MB7359.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:43::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Mon, 2 Jan 2023 08:57:57 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f90e:46bc:7a0f:23bc]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::f90e:46bc:7a0f:23bc%7]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 08:57:57 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Hector Martin <marcan@marcan.st>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        "arend.vanspriel@broadcom.com" <arend.vanspriel@broadcom.com>,
        "aspriel@gmail.com" <aspriel@gmail.com>,
        "ranky.lin@broadcom.com" <ranky.lin@broadcom.com>,
        "hante.meuleman@broadcom.com" <hante.meuleman@broadcom.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "lina@asahilina.net" <lina@asahilina.net>
Subject: Re: [REGRESSION] Wi-Fi fails to work on BCM4364B2 chips since kernel
 6.1
Thread-Topic: [REGRESSION] Wi-Fi fails to work on BCM4364B2 chips since kernel
 6.1
Thread-Index: AQHZHn5ZLDf3Fy+rxkWipAeJzt4Ega6K0KqAgAAC6IA=
Date:   Mon, 2 Jan 2023 08:57:57 +0000
Message-ID: <F9EFCCD1-4407-42CC-8316-2F58AAC1AE7F@live.com>
References: <F8829A7C-909E-4A1F-A22C-668220C5C06D@live.com>
 <f36dd8e3-9905-f04a-ed34-4be91ed1fec6@marcan.st>
In-Reply-To: <f36dd8e3-9905-f04a-ed34-4be91ed1fec6@marcan.st>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [X39JxZ841wvcF9kZKoxjwWZl3h2T8svX61DsIDcmN2X6wZQSzBKRrQBysb4xb2s4]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|MAZPR01MB7359:EE_
x-ms-office365-filtering-correlation-id: 1be4628d-b51d-492b-528a-08daec9f71ab
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RIWSTF89hae9ZHDrerul3huHXJXx0aCQKd6B4jE6RuRo0I6o+g0JqcbgDNJUnjyCdIppUbygIPvRzGpwmMWLImXGnoYysHCiTRG7ADdroaYtRMmLXmvUgItsIRPqu7e1yRJpCoenRCREFA2+D6KOPEkR4F8l/h5exWSyIoXomod2hsk7UF1/N9hOXXAts2EPioCDCwJWddypHu/Zyc5kdHSEnssJNOxIYBgdTMIvFXF0ZSqIsmwbDBpc7Boe+o/A5Z7abvSXvwhZlLFRbwVyLt/mIg1WmpqVklQFxxQXnED8Q/4yMPT1FBjc+KnMZU30/9uvqtbCLlTweLXj7iaU1fAoaxkeIyu2WlThgopsVNpCp+tsket53XyFcYUy2AbuNF2oT09t21CFCWIAHatGJyzIaBXkrBZsTX0u3OEQADtGqS7x/c7M6+mYKsExfcRKjZSMvcx9l4ZYeyGb/orHWrt63v8N2wLSMu0HwJrNddrbpPE9vW8jO+NnNsqLS4h/k2eATigUlxoCKVUQZ10K79C9RGUTWRzgbF1l3y8Yqg+qmN9IfOp4E3Q9NucCQkG8YS3AhEOTl60kbReAOParz0QhWccn8V84irWFsfbPCXC85s5p6iQYBf45RNRsZDRi2XEcmRsbxcBi0H3pE7b4jA==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1t+9h3PZ0UeHTqG46n36WBclCuZjBwKRI4JRuZnlZ6Tk6DaDh+DLJeDAY1Hc?=
 =?us-ascii?Q?xkDXTQ+IEWEtMRCEXFknUKlLOuQC+zN5IwnxXv8WioVqNTIIxjfkdQIyd6hn?=
 =?us-ascii?Q?dBSA+x2Z7TCMrAbmDfNiLxmgCq4sqYh+T4wYyDdeHqeZP+snhxcPwwuc70is?=
 =?us-ascii?Q?y2A6UROTB+tFyqw8nEadnM6OyD5JtrjC0DAW0vHJnzALdU+4FvUtINgq5rKY?=
 =?us-ascii?Q?jm5Rd30Lv6VyfkdcZT2q+ArhYm1akK2HsVZNBIoAKXAE8i4ZaiHmd/bq2eMS?=
 =?us-ascii?Q?+nBESVf7r0yLSJtg2KU49WUORbHi7RfpmIL72ESACv3GmEw9qbIGDPgs4p86?=
 =?us-ascii?Q?06/U4Qzu57las/QhSTc2tgvmZZF/jCwBOOgVSUphUbKNRdw+M7L9DhzPS7KM?=
 =?us-ascii?Q?5yoTPp1l7/pKWD8XTcOa6vTQboUfDV0JisP46lABLzmuDNepMtajhUyVsg6D?=
 =?us-ascii?Q?KPAy4hMsNe+0T5j9C7uKOTZEZ6mWAyOWZa4suggHPvmvOnngr+p9D4EeA8qg?=
 =?us-ascii?Q?dvVcJc8SuuWR7oEZ4etVBimjp9uHH7Fx4K9TVdAiv+OA5cCJ6AnB0dveLvax?=
 =?us-ascii?Q?3ZaTGQixFBTGbnQNxFEfXfNLLbOg9cwnlMeGY/Q4EHdAxBCE6xpxP5asbZ1L?=
 =?us-ascii?Q?LhtDGM3tbSNaYbEy8nVZYZOw1WXferi0hR788DNf1/8Mz/lXAoGjJZXvI19e?=
 =?us-ascii?Q?UK8I667IfUr/C2nsCpl/ujWn02RVB9CF/RwrdB4IUBg0H/TXJiMIZD3i3jE3?=
 =?us-ascii?Q?txwV0UGFc10vd+EgvDn04Kgprx3QPULLuk5B1frkDdgpzm2jifblguPbOKce?=
 =?us-ascii?Q?k7Zkf3Cv9nvHvRb1i4s7NJ4F4Zdj1QV6CpEIKR9EyRE4zDPN0Aw0qiNY5mY7?=
 =?us-ascii?Q?rUIzEayuNTgjxm7bcHjjn8D2IYOhYIRfvIZjGc8yvSKT6xlEKLgATh66fMB2?=
 =?us-ascii?Q?evIQoTAdZDrkWi+s654yxuoSSdHCsNMwZxyhgyK7e9T16J3F4Hk3W6P8mqWD?=
 =?us-ascii?Q?nHmrGLRDi7wTIXrOV2BvfBREKF2fccZw6bwIRm+PhsIWxCw6wRQtssshUCpp?=
 =?us-ascii?Q?DXg5VXTkgXr4ds0TBYRIvWub6BaJhbAw1ARxU/9ToJ9n4eUqdNAQaP1V2Xx6?=
 =?us-ascii?Q?jeGshvx0EWQ5zGqaCdU9qauOIlzmGXutgafwBbjZilRiikujQ8KhCAa6PIOF?=
 =?us-ascii?Q?+6L3S8Kk4b5VbwIUA0pwHiqe7GcrjNczucptAPA+7gPpoVcdYH+KP4HF4Bsi?=
 =?us-ascii?Q?KV9WWGoOUmEhVlSgnUuLgZ8piG7iEw104GlgZ9aXOQaNRN0WDtsqedrR3Au/?=
 =?us-ascii?Q?l4edSv81M2z4PGSVyGrqk0hnWb5ZN/V6cSfOijaaMXD8mQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <554BBF1AE706644FA7222788ADEFEA23@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be4628d-b51d-492b-528a-08daec9f71ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2023 08:57:57.6886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7359
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> You are using a downstream patched tree, specifically one with further
> Broadcom patches not yet upstream from my Asahi Linux tree and probably
> others.
>=20
> Please do not spam upstream developers with issues from downstream
> trees. If you have an issue with my tree, you can report it on GitHub.
> If you are using another tree, report it to its maintainer. If you can
> reproduce this with *vanilla* 6.1 then you can report it upstream.
>=20
> - Hector

I am sorry for the same Hector, but I sent that cause bcm4364 wifi chip is =
already supported upstream. If I ain't wrong, don't the Asahi Linux patches=
 provide OTP support only for these chips?=
