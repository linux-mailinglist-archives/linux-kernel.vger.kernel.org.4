Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5BB67EBDF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 18:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbjA0RCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 12:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjA0RCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 12:02:39 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78C21E5FA
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 09:02:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FE4Z4vlRBJExMapM4kaeFmh4EePkQr9W8lQcygM2WZjPn8OqC8ZlHxDKaa5/wn0j9nYuibkIeqGcdqoF5CmUxCNMallwzTrr+caBLa43XIMyYykpXy0BUdxCqSKbhGoqG4k8JxRWu2HDWrUMbWdOZzcteVpYDr9vqGOR6346ZD0vyq4nAlKt2pq7hJrkwDwzn04pU6ZOiEQvAsS2xP3TD/gOoOu43ACcxpY/jGNffBpy0gBZYNVMpA/xHNWR02qLfdayu2LDg3J5XCWmDJBgsiwcIihdDAAEkR56zgEqAFz5DomJSPFbh4X71M6kpS5DkNoGrciM1A1cZPREQSWp4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moG79oVLcCypNCLgXUPopwoDQUkfRhc90/izjGb2pWc=;
 b=c6ereqRi5h2maOCNJi/5cxBmp5WHiJ08AOyD9ngkYKnCcTf/HDRLvVqnlUiWr12e9qsGssCQKhtjrrY9HpqtQqcqeb1QVStWqVmSNVHqRo7KVKR1rgvq5abYq+TnXXtHHcITE16eqeiq7bo4r+hXGCd1D5yGlfQB7eBm3nlXSm0RN1ZAFGptLkXJn0apBBorap7Fp1/30D3UFpiNKyRGtGkax5hst/bJ7PSNvGuvf6+OFng06C917V8P1zsPWqSK4wx7/3Zq747bYNW7rGD+SRjKGD/9a5GT6ZCNsGgV7a0Jikhlq5QxlefbM5rIhAc9MeXF9TrKzw+/OATHYbz7Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moG79oVLcCypNCLgXUPopwoDQUkfRhc90/izjGb2pWc=;
 b=tXBXgYGhumxVzMwMcG8FuB6xOiUQ2WYwwPIQ6nG7C4uMPUpF2sNZOMFe9Z4r6pHA0N0eMUqs/M9OolAGoEeRGpjJzmEx+w4qpCOpRaHaiCv1Jfl1QKXQLPHZXPXkBpbuSd6ANw3cNn37NEBv+23XLuUYsujqS0sRJSEOLI5Lpog=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ1PR12MB6122.namprd12.prod.outlook.com (2603:10b6:a03:45b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23; Fri, 27 Jan
 2023 17:02:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%7]) with mapi id 15.20.6043.022; Fri, 27 Jan 2023
 17:02:25 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Jaroslav Kysela <jkysela@redhat.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        "Saba Kareem, Syed" <Syed.SabaKareem@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Pananchikkal, Renjith" <Renjith.Pananchikkal@amd.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: RE: [PATCH 1/6] ASoC: amd: yc: Adjust the gain for PDM DMIC
Thread-Topic: [PATCH 1/6] ASoC: amd: yc: Adjust the gain for PDM DMIC
Thread-Index: AQHZMmi4VeY+7wtNKUGUzjnMkPoj6a6yes4AgAABj1A=
Date:   Fri, 27 Jan 2023 17:02:25 +0000
Message-ID: <MN0PR12MB61013899FFB60BF73E7EB484E2CC9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230127160134.2658-1-mario.limonciello@amd.com>
 <20230127160134.2658-2-mario.limonciello@amd.com>
 <Y9QBbPtopFD1DGsD@sirena.org.uk>
In-Reply-To: <Y9QBbPtopFD1DGsD@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-27T17:02:23Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4e2376a1-63a5-4ec2-b304-4a436afd0faa;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-01-27T17:02:23Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 71231f46-10bc-47ef-88a0-4be53d3a6c53
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|SJ1PR12MB6122:EE_
x-ms-office365-filtering-correlation-id: 1ef6db93-222e-449c-8d96-08db00884388
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KbuvrJZT2FRMBTCBuflgmzIcHSVUjc2sE/Z1z+tuufopDKsHyVELQOj2SAZoJsRpIvGumPMK6x+VvehJQJ8Emc0x6FDHkPXDdzTeUkyp7uszv2QKmQUYOnTKOZY6y+BRd9KJhFbWEemtaShVDJIaBWlTvcl54u/XLoZGLrhkjgU7LINKC+lNSobDYYb3GCcApChdBoJDrJhnJGNaLPQI4SyGGSjBluTEU97cpNgpchW4G4JAIF3YyEMf9XoFEPFkUVeegcScpTOY6ug98LYuclR/jnI3sW5+Xf0QxeTung24AoSz+0Pe6ck6BZnLO2ZX4qmwy35iScOTTcjqaShulOI1DaQYnJp701JRAXhGnc2+L5tCvIqHzM62qvHFCWEj9NQTIkWdjNRxeGKpqKqvEPxP4zxMAMHRcwNQv7hCRO8Pnb4G31+BwVF2x4xrJNbmT0oP4qkWzl3WksqLnq73TY534CFKQ000ifwOswThSG4CIDWB6Eurk+eOOXmv6LVSZuJA18/Nn1YAcCmk2nFZNpxQ2pK7bFXpv5iVgub/v5kBsaxIS+sFefDBZszHDoY2T9Uj5IgkBRdqI6QPOgDwGm9k2wfkBlmDVluJeaNF6DU5tPBgHbPFFCfN6Iz18Nb7LiKrzsj88y/zfZVKxf8lfh4RsY6cldre0BmzsjohAMnjqYN+63ot8MGLSyA8aD6uMvVOp1rhqQGOkgI8SkBVDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199018)(122000001)(8676002)(4326008)(64756008)(6506007)(66446008)(54906003)(76116006)(6916009)(38100700002)(86362001)(66946007)(66476007)(66556008)(53546011)(26005)(186003)(9686003)(5660300002)(478600001)(41300700001)(2906002)(38070700005)(33656002)(83380400001)(55016003)(316002)(7696005)(8936002)(71200400001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qcmYapEPsRW+6CtNz9KiAagIwdGinibx8FQaHguUQGlTYX2RUR7oxroL1GNk?=
 =?us-ascii?Q?L4X2V67ReFx2DT1zOz+5ruP6c1rVwODzF7GQVAFzlOsURXAeBMim2rG2VC4h?=
 =?us-ascii?Q?/gEfbJA/I47+y4LSlipQwKqkvNQGcvmjwadtc8KQRA8wyILctH05HUSYqWxR?=
 =?us-ascii?Q?XT/kuw/KX1XvlrBxPAQ7qUomMou3yOLhRnMQ91s2KnQcfkydTIjbwUSto/vs?=
 =?us-ascii?Q?RnKlwWOStxstDWvDhSSnEPnkTnbI7+lh8yhocFQqsHdiB4LmGhoCxpfZsTnc?=
 =?us-ascii?Q?3ES9xgclG1dSFNkWTwsPizdeuuD2hd7FL8i/YHnkL7YOcIc79beBIRkLJ+k2?=
 =?us-ascii?Q?ZsXqNzvboHgbeeSVezksDCbqwQZY+mEWq9NjDqrWq5Rew7AnMpKd/GP6fq5w?=
 =?us-ascii?Q?RQUEVBdiUHGtg4ZyNpP+r2mYYgwCFXf5lgW0kooIZIWGwLKPL7ro5ZRKBw4Z?=
 =?us-ascii?Q?Lyb0VryLjDpXrrXelKDJnGwfTLunyo5+nnL4nsAhIlHCGoxKY5IUbp5mR6WA?=
 =?us-ascii?Q?JF3hng3Y77jO8LKG3YYbFHWDn9s5VagIg2SqcO5E/yFi1Cphlcb7d5c7MzHh?=
 =?us-ascii?Q?jEB314ehisiiYG5jgRbOFP4mqU4jzbFyyWJwHvzqujx0fuICKkCz9Qttij08?=
 =?us-ascii?Q?hYpnZDOfbJuVvfekWT0DKINUtsNvjcCBN636thB5EZZ7qFllfIhD8ejeEEK/?=
 =?us-ascii?Q?MjrkUmtIMu943KMWFpEf8V6ZsY9QiBkEa1Ad131/EaVMueB95ZYpnmCQEN1W?=
 =?us-ascii?Q?3zQ3+g26ebbBTyNSY3GkA0rwCFgTCZC8AvSTRR61pdaqPfCaGHjAes2T8ThW?=
 =?us-ascii?Q?t2+/2zomfcgLh54xrX8hquEKdcf4ZQ/8tNYjcgVD0mvBmmxB9hAtn7Yb/OEw?=
 =?us-ascii?Q?66n7Rp9PGNqDsa0kE5Ljxw0wHIXaWsjEArjlI9nMr59RIRJY7ogTp6QP5R1J?=
 =?us-ascii?Q?GYIdBFvK6+nTrTliNPDXTXP0rhUJ7bxj38KkDmwvguO7QLt71tNLTwcJoQ+p?=
 =?us-ascii?Q?HHN4gZ2TLzzJSbAOe3tyFbdPzCWKabWye6f7kw2eEG+8OiZpdt8JyxoZaodo?=
 =?us-ascii?Q?jIjkGgMbn2utxDQUAa1Uy1DUj61KlTgbgj8WGoShhVJ13S89l+CAogSrhFys?=
 =?us-ascii?Q?BOBhyLnd3LbdGJgw3Gw3bn0BaFvRjBhL7ykYCiPo0m1ulKr9CMKmm+b3Cy3F?=
 =?us-ascii?Q?Q8i2GMTMbQTTQuQXXxgJ4Sril/ighAuNwqObDQqPrCKhChf1zy/PHUdHn95M?=
 =?us-ascii?Q?gZrQ2iM2SBTUtYqe6TdK5OvRiBE89qBDRtkhCubM3SjucvFwu3bDXHi9W8SQ?=
 =?us-ascii?Q?62RQ5UAkEjRDePMTSrhWIXpdOvjRJAi6SfJQPUaJhGfYVvNep+PkOeev7MWs?=
 =?us-ascii?Q?xtGeu1cxRIq1QPNCLtcADYMQpAH2u5oh14SMF61NzUt7iNQeR/rbvUgp52m/?=
 =?us-ascii?Q?6kjiJGFUAbkzihX9YppjNzdo7A4gL2GQYGo7PviCTF0N/VYvEuuEcxtRZbUm?=
 =?us-ascii?Q?J1dxTgA5C7U8DDdHObjRBpzq0AR+AWFEc9LkUn1UREyztQmArltLSVnrmJbM?=
 =?us-ascii?Q?KdaV+y2KBYe0UL7FFJQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef6db93-222e-449c-8d96-08db00884388
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2023 17:02:25.1163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VLRRX4TDl414ezM0eKAMeqPKRSlyicrVM4jAz0z7hNzxwzW0RQPSudkJOmsEqCtz6vqByBEkWE0YpYgKJ8kqdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6122
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]



> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Friday, January 27, 2023 10:53
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Jaroslav Kysela <jkysela@redhat.com>; Mukunda, Vijendar
> <Vijendar.Mukunda@amd.com>; Saba Kareem, Syed
> <Syed.SabaKareem@amd.com>; linux-kernel@vger.kernel.org;
> Pananchikkal, Renjith <Renjith.Pananchikkal@amd.com>; Mark Pearson
> <mpearson@lenovo.com>; Liam Girdwood <lgirdwood@gmail.com>;
> Jaroslav Kysela <perex@perex.cz>; Takashi Iwai <tiwai@suse.com>; alsa-
> devel@alsa-project.org
> Subject: Re: [PATCH 1/6] ASoC: amd: yc: Adjust the gain for PDM DMIC
>=20
> On Fri, Jan 27, 2023 at 10:01:28AM -0600, Mario Limonciello wrote:
> > A number of users for Lenovo Rembrandt based laptops are
> > reporting that the microphone is too quiet relative to
> > Windows with a dual boot.
> >
> > Increase the PDM gain to overcome this problem.
>=20
> Why not just make this a regular control that can be adjusted as
> users see fit?

Maximum HW gain is what we probably should have been setting from the
beginning.  The module parameter stuff was in case we need to debug it.

My thought is if we find some reported problems with the series we ask
users to try the module parameters.  If we're finding that certain paramete=
rs
make sense for different systems then we tear out the module parameter
and instead export a control and set policy from ucm.

If nothing is reported, we can probably drop the parameters at some time
in the future.
