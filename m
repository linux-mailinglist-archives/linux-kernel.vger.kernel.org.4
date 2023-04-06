Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A3C6D8ECC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 07:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbjDFF0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 01:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjDFF0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 01:26:05 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2043.outbound.protection.outlook.com [40.107.105.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F2D4C2D;
        Wed,  5 Apr 2023 22:26:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwuXtxa3cMmPdDPnna9UbxHfWTeZL5hxP45N8WVjy5JKYwGCh/OOfkD/nWWCqjFyfKix7uDfjdwzOnuxFGqR5UjUdLleqcsdDUwdVLRaL4icNRH/Cil6FrITxWGeMibRydctSBfHrwiXHjIigtgCEpuAnW3bCuh3wObrqOw75UpjHfwjz52g7v55YdpLB/qeDla+CiKjt3cfj8iMjBYiLbq+PknNtZnqvNah1fhhtbg1/ch8OOL+lVg7KxoSCIShqEYXqgGACKol0L4Fjcxjz4cMJ4kkbJYnDBNvhy10EgGD4W86YJfgXuYvTdoGfy5rYvvIrAH17Nau5rEojyf2/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/eFHBYv2NghYWEQItMqgR8wKF4tBsQXP6DgqGvnp18=;
 b=Cj5W1lCjV8eiEMgatzwhkuld7J8y6vCYFY0GJtdyZ5SDqyp1j31EKN8gvc8ja461P9ABVmdRpZKnJ7iAcneieCrGSUbgHL+q80xDeEy5UR0yqIliIjYxqfgV1lqxRWfGrRmsctRJ4hCl/o79D0uxvz7x2V3pIrVbpNN/DSux6vYZ8ZQnRSLnVgQSbboXOxtK877SSDLdKJIiC0nWHYUAGa3kQ6Nq7nAjxvZOgIMEYl1x97nfkxAedlEYvmBRlMi1XyXaJ4E4RthtLjq6qg//QmgtnfF8KaIs4V1hxyitNjGqlOUb6Q/hL7yXCGXkEEAdkYGJsMTipOL8b67lVdr3xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/eFHBYv2NghYWEQItMqgR8wKF4tBsQXP6DgqGvnp18=;
 b=qnEM8CuKQVBd3ebSPm9S3sH47uGs6r5muBWHCDwMGEySXaRPvlj7rpOC4fQezUxJt44HsEWGRynSdnBle0qX0Lrc5yxkMt/wtgYb08dHt/NRHf2oH3y33GkrARPD+8EfnmiHmwYh5owfrCZKcSnraO/G1bq95l8zmPMxMyHt6oKlvX1HzL5EnCjH/RN6C/8vpdXwuKzyxQxekYKi6j1np9UV77yTKB5m9F9UlAGRgt0zlJ78gNwAJm3uWPCmsfIZs+3fQXx7feE3TR864w6dNsbqaWZuzhiXXrTWDUNtejfHPFIY/Rs0QzEBL2lPNyGO8sdjZ+4k5HQxTq0HZ9x8TQ==
Received: from AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:517::18)
 by PRAPR10MB5178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:27b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.22; Thu, 6 Apr
 2023 05:26:02 +0000
Received: from AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7268:b477:8203:8c6a]) by AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7268:b477:8203:8c6a%9]) with mapi id 15.20.6277.028; Thu, 6 Apr 2023
 05:26:01 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/9] tty: n_gsm: add missing description to gsm_config
Thread-Topic: [PATCH 3/9] tty: n_gsm: add missing description to gsm_config
Thread-Index: AQHZZ5dDYdQ+PRRBNkeLoW5FSUlKaa8dwV4g
Date:   Thu, 6 Apr 2023 05:26:01 +0000
Message-ID: <AS4PR10MB5895ADDAF211A669CCF7F8C5E0919@AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM>
References: <20230405054730.3850-1-daniel.starke@siemens.com>
 <20230405054730.3850-3-daniel.starke@siemens.com>
 <9d7289fe-7a3-2cfe-b023-a892528044e4@linux.intel.com>
In-Reply-To: <9d7289fe-7a3-2cfe-b023-a892528044e4@linux.intel.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-04-06T05:26:01Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Privileged;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=27e90ecf-a9e1-41e0-80e0-abcdffb1c330;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR10MB5895:EE_|PRAPR10MB5178:EE_
x-ms-office365-filtering-correlation-id: c9c8c2f1-3083-4cbe-4911-08db365f6948
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d0m6333Am+cMjNBed/xBgFb5auc8zulygOlmToWCqhuhgmWm4mptosHu17qetfC//TC73Cs5+gDenu3n3tcrLuvaRPX9LdembvcnhcxHDH8N+MFA3O/bWTgGC7LQJsPhVAX7QmNhp14UNgcSk4djF1QhruHwb/Z31AZa7+Ic7sV+gUXrR3mSgDTlEZ7cVb9flxeOVoXzd0llIxWXjQCodFpUhRuO+I5CNN/zvGz6keY5pZ42ufN2sI+VqIxV18u24nPBOO6DSi8Q1SGbWjiMKrbdMHcasa5qx4xp4MZ837351H4ha4u7HvHpC57v1wPrlm0MB7qNDo6A/C3Zf0hqLicQ5bCjRq6f09ZE7f7LiVTmc6oTm4NM2dPY2sgBOLHwBhnovDaZ3jI+NI4jwpInvZWN0K8gsLVTWCWCugRGC3Kyods57s7Jgehz47PBN6fnFxacS7GZeufmCn+u9Jyjm/3mZevIVCBPSYn0CDwXRwgkmb7wEqAh1OPmGXqanc2+SSJMHR7jbfSie9tTmxRLR7Cp/1zZ1JBMnjJZQMQCcFaVEpO8VQDFvytw1wM+g2OCAs0ERNy+A4JFobWhqNB4CirMLZMGXDjY2yTjQfaMdzI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(86362001)(38070700005)(2906002)(33656002)(7696005)(55016003)(71200400001)(966005)(186003)(83380400001)(6506007)(4326008)(9686003)(26005)(66446008)(478600001)(122000001)(76116006)(66946007)(6916009)(66476007)(82960400001)(8676002)(41300700001)(66556008)(5660300002)(38100700002)(64756008)(4744005)(54906003)(316002)(8936002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dlGBerlM+cwcjlQtiWQMoAP2CvdSsH6TlC4bJTBPO2IkXboNqvBeUmJVq0?=
 =?iso-8859-1?Q?cLjorGMjs3LpY7DQMEDzgwhqUUK1jDJUSsHBHhumc7UfYJyCvH5Fr3HYK3?=
 =?iso-8859-1?Q?7AMxsibgNPYazRTz92+KlcMQxL68XTL78U8/X2fUMcq1VClfiAdM204ur1?=
 =?iso-8859-1?Q?gwSe+LlCQvxMy1UnVDgggsbXM68VMjk3HmxSpgDDLuu47P+0cNps2bjm9d?=
 =?iso-8859-1?Q?5E5JePAVvFouN5pqgBdBIM4n/HTyKGOgKcbkpf0fmUKiOGnQxfB4Yf/t7V?=
 =?iso-8859-1?Q?P+z1oe/LYDIu8ekEy8vf51nitw0i8/Wb6w4pQEBcrW5Z1NhI33EVCNyuGA?=
 =?iso-8859-1?Q?CCHfKVXBTGuj7l8DbItk5oG8R7ypzi2Uih0y6VL0wgO21DVuailxI8KaQl?=
 =?iso-8859-1?Q?80rRrmfBpsxPzHwgRgLilYO9sQD/S0huNGV0fT69XupYIlT+DrBRGkCzr0?=
 =?iso-8859-1?Q?QhdY6zQpAD/V2J9PcIUrP+vqT1mQ58CtD+Y1ZBn5hoBiwaiW82Eun15fNi?=
 =?iso-8859-1?Q?x9dBBakc4YqxHlnUfJsO2xRBGAHYLUbAU6tSbJAtn+LL6CULC48O8o7Z5u?=
 =?iso-8859-1?Q?B6E3Lb77gQAQeBB+5SDntJRAfkIoopqqSddV7fOGfEfzSc4iFejsXJXRsn?=
 =?iso-8859-1?Q?1IjRmwTiGDxx8zFCn5Vp94Xvr3fRw0KPTm4VX2EBAKBsSW5t/uRRSNb1as?=
 =?iso-8859-1?Q?a6g1qs7wSHrETOyKU9hyCoLHuMxgm6C3m0PDHkYge/K16yD5ywnjyo34rI?=
 =?iso-8859-1?Q?UpFYVpOaX8gHUPSYE/LPjUyo+W5utLaD17+hXcv/WSm9iaJqWolgenBYfI?=
 =?iso-8859-1?Q?Y1+GbQ/C+3/Dtq4hTOQuFpDlto3DF/pWv/hbfu/fyc5nCmP7cEz9/IDaoR?=
 =?iso-8859-1?Q?xu7AEJhYuKLhq3dpwJPtGaGhCeTPc/EE1YuaP2eVwgTtAxfxioBv7AaecD?=
 =?iso-8859-1?Q?nGOpEm2eVq+75DibuPUEABv2U+W8OG48YOBwKcRSQuw1GLu1egIPZ3K1Mo?=
 =?iso-8859-1?Q?6jhkmCk+6ETRaIyW+KoagloV2GcyHNRdj+5UQHwCF6MbNElSZmXsoxdYPw?=
 =?iso-8859-1?Q?XOB3sMrkAY17wEcvqFOLSqxMX6Y4Az+fH8lgceetWCVyQSQTiqiAv93fR7?=
 =?iso-8859-1?Q?3XQuY3PsbwV8TCEUIKp1yc64r3DcOGQVDt3AQ9FRbzadSn5wMbdRyXBQc4?=
 =?iso-8859-1?Q?A4nIfEXSRhLcZ5mmuFr8IERJm7m4OCEQ3qzh7aNd5DMOjRnfkmMhLuz12S?=
 =?iso-8859-1?Q?ptb4a1lmEKHxQrW0hPhmi9gIhN0MxB6y8NdEmkA56kEoUaDeMumGaQedQS?=
 =?iso-8859-1?Q?yq3S3xSn2tCFRpdnkpwmrd27dv5syuraC+BqjFVVHuEsq7FpHu41NEaW09?=
 =?iso-8859-1?Q?4cCJbMdfuqsj4XhqacbSWLyrsGQuD1CKVHJgmQj1frBdRRr35v9BmYyuES?=
 =?iso-8859-1?Q?6QR3F/XhCuWYje2jqvSI0Pr7tLqM5KVMgPcOCV/4G+FF8H4gD5aBCRJX68?=
 =?iso-8859-1?Q?Dko32xQFDBJ9Hy0noKYxVzhY91DsSjfsztPuGnWBpiynjY8B2ZeqIrL6ZU?=
 =?iso-8859-1?Q?4ICv4tnI3X9RNmdoWsaqNHVReMyqsw4EnUdzYRG6crShX4O28penuBzh84?=
 =?iso-8859-1?Q?8mAzqnjbg3K0S/Hxv18pgTiCDBSizZZkn+?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c8c2f1-3083-4cbe-4911-08db365f6948
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 05:26:01.8863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3DBPUfvP1UA0koQDwMXGsXQ64iZAP+XeGhIure1Sb4NYM3bP4DWOfWINtAOIdT7k56zYsF6Fe+ZOVPvJ8KpjNid46Rq4lB49rOd/EJAupVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5178
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +	unsigned int mru;	/* Maximum incoming frame payload size */
> > +	unsigned int mtu;	/* Maximum outgoing frame payload size */
>=20
> I'm used to "payload" referring in networking context to "useful" part of=
=20
> the frame but MTU/MRU probably includes headers too? Maybe just say
> "frame size"?

Just frame size is incorrect, as the basic/advanced option mode header and
byte stuffing do not count against this number. See 'gsm0_receive' and
'gsm1_receive' and also ch. 5.7.2 of the standard. The outgoing limit is
applied in 'gsm_dlci_data_output' and 'gsm_dlci_data_output_framed'.

Link: https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDe=
tails.aspx?specificationId=3D1516

Best regards,
Daniel Starke
