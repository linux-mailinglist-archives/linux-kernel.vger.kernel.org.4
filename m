Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5C66FB243
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbjEHOJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbjEHOJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:09:24 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D264116357;
        Mon,  8 May 2023 07:09:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOWpIeOM+cEK9Jd0wYil5/IDo+MHd+jUUDBPZOfB8BZtwXwPs7rw+81Jtfy4/7rtUKPKoT7DiSWDfutl2h9jvUPRBJR2koRI40vJmKtu5CQunDNYClGWchUOefg9efe0akU3YpPZav3pIyhjgINrMMq1P1ANTbT7zQPWYZ++10eS6p+GwUoSsTEfmAvK/GAqr/zSUUnZh91GmqTTydAbG14wkB1Q45nufJhp9uAdrpYoB9cn+Z5dTJ/syI1aF376z3bGcfHMgA2ZU3T1PgB07zAPujvhy83m7Z4P6PItkNnfAvn2v/v2lYXx8KehoJFsQW1DvnT0RgP73igLO6Ruxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFKVxYvbrwJ0hFoV6+HJePhZHF0GEvxrSdFoZRkiW7A=;
 b=DHImhw71PdYGNTuNJZj9OiyGo+m5aFRxwXp+dmnkDrxk+lqsoWE1ThUJQWSYtWKKOdsx2tOGSONP0qsyI17DHHvciSk4yGXb6D57+a4W9rKsbsHR+n8Xww4D8N0fk5phDb7DNUXd9JXKGg/usxCq4eH+o11rZMoHWvFwUeKWxmIGBuESZiwVtpxTsXbby5nJIsGRBvOSvaA4FTGxJsJf2lxzyNkOc3EbuvQrBiVq9Ok8F2lq7utXEFS4uvWpzGuAI4LJRaOQ1YS1BXLwdfWRimnHme5HLFa8cujYPEhdw4HSplIVNNtQBrvP+2tiNqaisFH+0xLOhZVBmYznwOCeOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFKVxYvbrwJ0hFoV6+HJePhZHF0GEvxrSdFoZRkiW7A=;
 b=TWmpMWbUiYgd3Nv+BIRrY2Viucj51BXj4965Y7F2UH+abblTyzuBOLP6wO3pJmpXlmOwg6kCnA8NDwg8IGthFskREz4y4OgLO9qE/7daA+q+kOpafSiHSLufAm5TpGgp99rC6i/3YvcLM3x9O5wA+cHQ99AAK0ZxW+j078V+ebM=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB4875.namprd12.prod.outlook.com (2603:10b6:610:35::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 14:09:17 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 14:09:17 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
CC:     "S, Sanath" <Sanath.S@amd.com>,
        "Gong, Richard" <Richard.Gong@amd.com>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>, Takashi Iwai <tiwai@suse.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] thunderbolt: Clear registers properly when auto
 clear isn't in use
Thread-Topic: [PATCH v2 1/2] thunderbolt: Clear registers properly when auto
 clear isn't in use
Thread-Index: AQHZdubWCKo2G26emki2NBlh5J/tta9Qfznw
Date:   Mon, 8 May 2023 14:09:17 +0000
Message-ID: <MN0PR12MB61019560E0A264485B46CB27E2719@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230424195556.2233-1-mario.limonciello@amd.com>
In-Reply-To: <20230424195556.2233-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=79df7a3e-df01-4c8a-b9f5-0a3dae7012f8;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-08T14:08:07Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|CH2PR12MB4875:EE_
x-ms-office365-filtering-correlation-id: b6c66e3d-79dd-472a-bb9b-08db4fcdcfe9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rpRJPsfLfuPP59evWlR23ye9SHnbjmBoMuuqTp91CC9Etf1lSOXCXGO/n9wOQVoyJI7/XOHpdt9oaowIASi7tZHD32o/4PclZqJhh6jpe3JQqEW3H7ioLslAzRW2xRdLuopIml+x05bBo8nl3QpKGAkrxT01g8xWb+eU9SMzDv1Zu9Inx8YkXYkR3b03gdqdvZ/QgN7cXTXzFezYcx2Vrd83Xywqm8XgV8Yf3u9bSOOQ96+kLSFwi7nzfsoACGMIrv5ds1DBMR68j+jSKC1Qd0DQRECdtSCUrY8SgUdAypX/Q6/lNNJW8me1yow2CsrzsSfMG4vVfmcUjr5Q9lj5ksV/zb1XAipTG/vbJ/v1FVXToc3DAcBc+f13NCWYle+mlfLyocG9L8ao48TmoiFSvb27r2wyPGv+qfIhDb6h4IO/wDc2d5jXh4eMn8oGAAxC3w7D1/w5QrnrreEFDn5UxlnxVDjgoOQBoBc2gXqDAEtM30UdBI2GJIHIAcmVhaL9sjVG74+/CC9+W98Drha5kPPgZypkrI4abOccqVUH9hQzhtA8WTN6NhBavoVElGkTzJGZVaaxAxEj8lZrhvPHDKFdZM7G8s7FK6dErsZ+PVo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199021)(86362001)(66446008)(33656002)(966005)(316002)(54906003)(110136005)(64756008)(4326008)(76116006)(66476007)(66556008)(7696005)(66946007)(478600001)(55016003)(52536014)(8676002)(2906002)(8936002)(5660300002)(41300700001)(71200400001)(38070700005)(122000001)(38100700002)(186003)(53546011)(6506007)(26005)(9686003)(83380400001)(84970400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2HhABJi8k3aKHJJD4lZk0FhgYI1VBLQfHhWIk1MHf58vOVS27fclI3bT8D6H?=
 =?us-ascii?Q?+Bn9mxQePBRknbAY/Dm8Ta51XEcKkZZzTQ12f4PuPdW1wfZ3H/stGgV+r7OS?=
 =?us-ascii?Q?yWQbZD70zsZAuDEl6H1Aue6UQfFqntIEGE5LaQn6VRExHcgbwTIasC2h6Lqk?=
 =?us-ascii?Q?bOYFisn0g1Tx+EC4ZfL7s0k32z/eRFZRziIkUy7kpPJXlmQafRjgLHdWEuN3?=
 =?us-ascii?Q?F9kIRKOIYzUh0EgF8svd494CRzd1Xe3kesbDEC/Yjlud0YWN+uAi+2EHZwui?=
 =?us-ascii?Q?NwRpW3ljn/YGjI8Nc3xh2cemcmVgxrCCQeNILy/MlJ5//3TQ5YXlj8MaXnP1?=
 =?us-ascii?Q?LHyT8GilGD7sIMLmhwT0eC2PBHkYLCtc9eEYK3grtnYrnbGGgYHBHpibzbhD?=
 =?us-ascii?Q?UH+Bd6gb/k9iCnX0gSMJhK0s5IvKq+i/ID5WKVFBfRU9P+PiVm41fInXVX3d?=
 =?us-ascii?Q?j02BAjazurMYtKFAwHCpn2+rYktCdc4qdRJWKd94a/wu7aWWYDX0WmsGD0OC?=
 =?us-ascii?Q?gYdfZgDu/5ohGAijT34F0LT50aeVkMqFTJJDw9UyPLZVkXY2oRXc+kN6zqRl?=
 =?us-ascii?Q?zzEOxmbIvmUKX4SVuMCGqOsCR5qIWsxyFEEu8G5STxCMC+hdB9h6pnFH4678?=
 =?us-ascii?Q?jDRYKAiaqwoCNSUwMFOLtsZfnx0/MjM0wBdP/Z9NtndLuuKDUT6u91yj6w42?=
 =?us-ascii?Q?QyK6D38TEjN8R80fE9c13k5gY1IIt3Ec9uKmC9BS3K4B7b4ynEADv74kkq1F?=
 =?us-ascii?Q?I+t0hDsxpMMIN1gq0hiP+VNYavKhcI8L7CVd3bTyIjqPxTyudcaBdUCWgGCk?=
 =?us-ascii?Q?LjP/bhS8wEm9D2zzKbn5ALkFyVymp86NPUKPBVSkahfpkNXpPS6Isl0JljVN?=
 =?us-ascii?Q?tS/VebzCQhH3I8dIe6MFYdVybhCeCqBo0XnzprFK8JsIX5bwrDh8cQ2uNUJT?=
 =?us-ascii?Q?S29/BG/CdECsFJICb2GNgiyNsDrSegVWf5rueGAi433An2ea3B/v54YUlJRc?=
 =?us-ascii?Q?lNggmZClvs9fZeMDoGMvv2P3RRTMiwwJBe8mLFURm8/Ivvi0ZHLpEsg4V2MN?=
 =?us-ascii?Q?0jMg2hHXDCY7Wi0INGzRtn/i8q5sjLDBsAhfAmnaa3dZ6qOohWknq1RGUnOw?=
 =?us-ascii?Q?HUfxD9mmf28oyXIiCq0d8/Ki5NCUFFfU0MLhkKNKbWjbWdqeCriMxUtewhfx?=
 =?us-ascii?Q?qfcn8NnKUO74eR0K20klKKZKC0N5l2M7v7ChwYXkVhjHh4IVgQPFZt8Ll++I?=
 =?us-ascii?Q?U8s9X2rI1BaOcz6nHdlOIBgz6sCVR03kaFYLaTDW1iYI/Tq3Z3sMp1UvXxzQ?=
 =?us-ascii?Q?q2qSo5bwJUnhXwl/wkl3gW5pb7vY3Zlb5bKLLnu+4o6mmjIEsWN+zyIBefud?=
 =?us-ascii?Q?br1j42ChF47dYXm28KhEAlnA1jin8QGKXvys/utUg1moGlb5NUsyporseaH0?=
 =?us-ascii?Q?ATTLaNom2Euuk8jZZZ08ny4RB8U6Xx/b2lGND6g5okVWXQfLQyk/5QGy/IGM?=
 =?us-ascii?Q?AzxFv+c6hk16fRUmNIowu2iMgE84FGfvhYYbh88Wfne7MJW/ScvTZzVRYHpQ?=
 =?us-ascii?Q?degvXTCn2YGRnCATppc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c66e3d-79dd-472a-bb9b-08db4fcdcfe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 14:09:17.8138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N0YgreYscHbSiI9nQ2DhRZPlnQuu0gjBgAmW8yRGtD4Q/gal6J5ZvzC3Dmmdw/RrFjAbX+N6GcQTRKayZ8fGAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4875
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Monday, April 24, 2023 2:56 PM
> To: Andreas Noever <andreas.noever@gmail.com>; Michael Jamet
> <michael.jamet@intel.com>; Mika Westerberg
> <mika.westerberg@linux.intel.com>; Yehezkel Bernat
> <YehezkelShB@gmail.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Cc: S, Sanath <Sanath.S@amd.com>; Gong, Richard
> <Richard.Gong@amd.com>; Mehta, Sanju <Sanju.Mehta@amd.com>;
> Takashi Iwai <tiwai@suse.de>; linux-usb@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH v2 1/2] thunderbolt: Clear registers properly when auto
> clear isn't in use
>
> When `QUIRK_AUTO_CLEAR_INT` isn't set, interrupt masking should be
> cleared by writing to Interrupt Mask Clear (IMR) and interrupt
> status should be cleared properly at shutdown/init.
>
> This fixes an error where interrupts are left enabled during resume
> from hibernation with `CONFIG_USB4=3Dy`.
>
> Fixes: 468c49f44759 ("thunderbolt: Disable interrupt auto clear for rings=
")
> Reported-by: Takashi Iwai <tiwai@suse.de>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217343
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>  * Whitespace changes
>  * Add new static functions for nhi_mask_interrupt() and
>    nhi_clear_interrupt()
>
> I tried to base this off thunderbolt.git/next (tag: thunderbolt-for-v6.4-=
rc1)
> but the following 3 commits are missing from that branch but are in 6.3-r=
c7:
>
> 58cdfe6f58b3 thunderbolt: Rename shadowed variables bit to interrupt_bit
> and auto_clear_bit
> 468c49f44759 thunderbolt: Disable interrupt auto clear for rings
> 1716efdb0793 thunderbolt: Use const qualifier for `ring_interrupt_index`
>
> I cherry picked them first as this patch builds on them. It's expected th=
at
> this patch should apply on top of 6.4-rc1 properly.

Mika,

Since 6.4-rc1 is out, you should be able to test and apply this patch now.
If you need any changes I'll send a v3 dropping the second patch.

Thanks!

> ---
>  drivers/thunderbolt/nhi.c      | 29 ++++++++++++++++++++++++-----
>  drivers/thunderbolt/nhi_regs.h |  2 ++
>  2 files changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> index d76e923fbc6a..c0aee5dc5237 100644
> --- a/drivers/thunderbolt/nhi.c
> +++ b/drivers/thunderbolt/nhi.c
> @@ -54,6 +54,21 @@ static int ring_interrupt_index(const struct tb_ring
> *ring)
>       return bit;
>  }
>
> +static void nhi_mask_interrupt(struct tb_nhi *nhi, int mask, int ring)
> +{
> +     if (nhi->quirks & QUIRK_AUTO_CLEAR_INT)
> +             return;
> +     iowrite32(mask, nhi->iobase +
> REG_RING_INTERRUPT_MASK_CLEAR_BASE + ring);
> +}
> +
> +static void nhi_clear_interrupt(struct tb_nhi *nhi, int ring)
> +{
> +     if (nhi->quirks & QUIRK_AUTO_CLEAR_INT)
> +             ioread32(nhi->iobase + REG_RING_NOTIFY_BASE + ring);
> +     else
> +             iowrite32(~0, nhi->iobase + REG_RING_INT_CLEAR + ring);
> +}
> +
>  /*
>   * ring_interrupt_active() - activate/deactivate interrupts for a single=
 ring
>   *
> @@ -61,8 +76,8 @@ static int ring_interrupt_index(const struct tb_ring
> *ring)
>   */
>  static void ring_interrupt_active(struct tb_ring *ring, bool active)
>  {
> -     int reg =3D REG_RING_INTERRUPT_BASE +
> -               ring_interrupt_index(ring) / 32 * 4;
> +     int index =3D ring_interrupt_index(ring) / 32 * 4;
> +     int reg =3D REG_RING_INTERRUPT_BASE + index;
>       int interrupt_bit =3D ring_interrupt_index(ring) & 31;
>       int mask =3D 1 << interrupt_bit;
>       u32 old, new;
> @@ -123,7 +138,11 @@ static void ring_interrupt_active(struct tb_ring *ri=
ng,
> bool active)
>                                        "interrupt for %s %d is already
> %s\n",
>                                        RING_TYPE(ring), ring->hop,
>                                        active ? "enabled" : "disabled");
> -     iowrite32(new, ring->nhi->iobase + reg);
> +
> +     if (active)
> +             iowrite32(new, ring->nhi->iobase + reg);
> +     else
> +             nhi_mask_interrupt(ring->nhi, mask, index);
>  }
>
>  /*
> @@ -136,11 +155,11 @@ static void nhi_disable_interrupts(struct tb_nhi
> *nhi)
>       int i =3D 0;
>       /* disable interrupts */
>       for (i =3D 0; i < RING_INTERRUPT_REG_COUNT(nhi); i++)
> -             iowrite32(0, nhi->iobase + REG_RING_INTERRUPT_BASE + 4
> * i);
> +             nhi_mask_interrupt(nhi, ~0, 4 * i);
>
>       /* clear interrupt status bits */
>       for (i =3D 0; i < RING_NOTIFY_REG_COUNT(nhi); i++)
> -             ioread32(nhi->iobase + REG_RING_NOTIFY_BASE + 4 * i);
> +             nhi_clear_interrupt(nhi, 4 * i);
>  }
>
>  /* ring helper methods */
> diff --git a/drivers/thunderbolt/nhi_regs.h b/drivers/thunderbolt/nhi_reg=
s.h
> index faef165a919c..6ba295815477 100644
> --- a/drivers/thunderbolt/nhi_regs.h
> +++ b/drivers/thunderbolt/nhi_regs.h
> @@ -93,6 +93,8 @@ struct ring_desc {
>  #define REG_RING_INTERRUPT_BASE      0x38200
>  #define RING_INTERRUPT_REG_COUNT(nhi) ((31 + 2 * nhi->hop_count) /
> 32)
>
> +#define REG_RING_INTERRUPT_MASK_CLEAR_BASE   0x38208
> +
>  #define REG_INT_THROTTLING_RATE      0x38c00
>
>  /* Interrupt Vector Allocation */
> --
> 2.34.1

