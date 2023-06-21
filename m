Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07C8737C3C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjFUHbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjFUHbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:31:17 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADB81706;
        Wed, 21 Jun 2023 00:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687332675; x=1718868675;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=XMEInHc4U7JglyGz452o982xp5CLgDMsjrk5ZZ87T54=;
  b=f1cwq1SFR4PBt1X7TZbqmpbl4KP0mD6Uf8W/ITFPxTsk+7y8G35xE7t2
   IPScjmt/KBGil+F9hA4E+zMycXAh3KqUPfUy/GXEE3eOeFYrfHGolqCYz
   im1n3QbL/dZAMcYUZ64yiwa3CWoJjUW04Z3Z+i33mcT5c+X0VADq9Pb0q
   rmrr+Iez7YIfdAO0u3TAfitQUegnU+hjW9yis7Av/svjZZQ4UYIOj2cf3
   RQk+N6Td1/G6uCAhMuji5WSNJfRwDPmvy3Ox6sAVPoW/7DAmkXlpOBjF4
   785q1wjbtll+To5F7tQUjIIYvG8qZ6L4skPp9emWHOFFxOkbbEoC5OyWG
   g==;
X-IronPort-AV: E=Sophos;i="6.00,259,1681142400"; 
   d="scan'208";a="348036622"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2023 15:31:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vb1t+5yXi4u24ANKQY7fkqtM4PQJXAx6cun1QBOkhAmUVUFODVlcy+kINx7/RNGi0XHA2iWFcP+4AC2wTiQZv6sYYWT22Wy6iBJ6gkFASnqmFWoy2TJKSdFNYHNHPTu2Hw7Ji7G4Z/CT+Pv1+pdgUo1y7TPl1RR1EvwzHZ7zq8e63t3+3sjvDDbWowi4b5T6UQM8UXSbeOC3q84WjMFc202myJsM6YjdA3rMaPVqor2DiaL9BfGQ/PsJAtXemGo/Gcbmf2I81Rhm0P1qfdHdb4Cgz/0N3K7miVa4NpUNZP8vpbubprplvcbYd7k0sjveGkJfn50QY4vbxFJoUYMX8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZN7oeweKzGkpXLPA1XPgUymJB+TQJj8QOAHFHHW/HmY=;
 b=WXB1uKxrID0Eea4ZLIfrbIQ1ydsIjUP6mYb+Gf91diUww1OWQYSo3ISlPn0n6a/z1+R40PNz2hybbj7/KQ9v5M7e5vKvmLeaUa/QKbOD2a1x0ckY6ttCtyw6ve2TLWB7wlYBTsjHyCXuPon2CguH+SxI5nrGVQ6ZHa7lWUo+7wABL0Ti4+vDSi7LMwCNHZRCW0guuD08BldnQAaaqGpwzcxjQnLMIRKU/72n5qdaVkTXzSPfTbx5pIgCV95DQ7LKhd69+IKms2svqkHb/5IXcHdk8m2ip9hlIrrBW981XogRmLaT7Z8UIDB+qlBltwWS+/7tRX6SA0SPiDM2RDr3OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZN7oeweKzGkpXLPA1XPgUymJB+TQJj8QOAHFHHW/HmY=;
 b=reRc+WOQJUeqGLSgUjWNoDZwyzfRk9Bh2cjyQS9nP4qEuvj2pCfiCEhxZkvlT4+6dc1Om84qjko4CgNcoMk8eWknegSXJcDzHYhQweL+8nTkfpMbMuj84OjlaegDjcz7rA1FRAIQPpXCQrRWBgK6O5pVmoOR9vV7agRNoRWQoD0=
Received: from BL0PR04MB6564.namprd04.prod.outlook.com (2603:10b6:208:17d::11)
 by SJ0PR04MB7166.namprd04.prod.outlook.com (2603:10b6:a03:29f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 07:31:12 +0000
Received: from BL0PR04MB6564.namprd04.prod.outlook.com
 ([fe80::dc4e:29e0:7689:e1ce]) by BL0PR04MB6564.namprd04.prod.outlook.com
 ([fe80::dc4e:29e0:7689:e1ce%5]) with mapi id 15.20.6521.020; Wed, 21 Jun 2023
 07:31:11 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Christian Loehle <CLoehle@hyperstone.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: RE: [PATCHv3 1/1] mmc: block: ioctl: Add PROG-error aggregation
Thread-Topic: [PATCHv3 1/1] mmc: block: ioctl: Add PROG-error aggregation
Thread-Index: AdmjdCfpdU8NnQgrT4iRiz4+JBhVQwAmzJ7g
Date:   Wed, 21 Jun 2023 07:31:11 +0000
Message-ID: <BL0PR04MB65647F33DC7CC1D2903E5A66FC5DA@BL0PR04MB6564.namprd04.prod.outlook.com>
References: <26d178dcfc2f4b7d9010145d0c051394@hyperstone.com>
In-Reply-To: <26d178dcfc2f4b7d9010145d0c051394@hyperstone.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR04MB6564:EE_|SJ0PR04MB7166:EE_
x-ms-office365-filtering-correlation-id: 18ed1635-5a91-42b7-22c2-08db72297ce7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AyAEIJ564ORDDaIqeLx/9COgANmI8ivRCi+e2jiGOmZFbCWDug/sNIuRK4/eTxHKpl5KRWbxA2/MUaIVva6mEjZNfG3rvy3tR9jQqraj/8vxNZQUOPsGAeGO3wKnMtpR2U9Zk9lH/ChXU13vRsWZLE/9w2jgatmCM5DFUI0bCTyixEUYKVDbXCCckoeXkRw2XfIdlz49s6UsIuExe0rmba+T6tE3sa+NdAbzqM/MpHlGcW3Mzyijat6sCaK0dunZrFIN7qo07QHfjkMp1vBDmxIUmDevsIdnJYOzgKb4/sv0FsXrTq7JFi++YoCImDgqUv5pHpfPOa5QTODsNMzoCsOzDZWj6HVk3xh9LdYLWgw1SukQa+zoJO6lY9JWt2b8O9XeHexViyJYOTaUqyE+4EeQSiz3qkFvP2HEHLBtT2OvOF6cVL2KqIBihhD4C9xpbtypK4k1gXIk+24/U7+r7NPKnEzAOxS6suVD0XYfYn0bzecFd/rC0gWW7xcOL+CW5JUpbiFZuvBgxj2GTaCS/tidpNZtyR9/idTypjvrYgSC0jWI+SSDy1trn4bTRSKgYgO049CgaE3hZjNbFoJfkGtiY9oDy+4kqaxVfgOFf9hS48n1bhK73NXbqNOuwfTt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6564.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199021)(71200400001)(478600001)(7696005)(110136005)(76116006)(9686003)(6506007)(26005)(186003)(55016003)(2906002)(8676002)(8936002)(38070700005)(86362001)(41300700001)(66556008)(66946007)(66446008)(316002)(64756008)(66476007)(5660300002)(52536014)(38100700002)(122000001)(33656002)(83380400001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eVqEvL5fKkvSAvOKIjTe+6mnaHz0C/w+pjvZbipy5g6foF/xGMNEwnDBw5af?=
 =?us-ascii?Q?zVgOSUir9dUV38PDziQLnpC0maqyO4yYaWdKSt1E9Xvp2xaCUPe+broDroPR?=
 =?us-ascii?Q?PeJMDecVxnljSlK/oW1Bn5c5hwEJUKJ8Qd25ZdxZMCVccjSb2gN7PyZ+phH3?=
 =?us-ascii?Q?giDwzLqEMLgtea6fM6+vftyTJkwsZKDWm/SVrpkt1dziTksnvck9uzbbd0Oo?=
 =?us-ascii?Q?FK2B2LEWVV8hfRDnjLPmAgmI4k+3nbYmuAS+cpLb6M+bwi2BOh/IQLsZXD8j?=
 =?us-ascii?Q?UOTEXntdNzEERf46djEvZGV8va+MZP6veMbXyxKmruL4DG/sZelLxuVwgPSN?=
 =?us-ascii?Q?olIy5MDh6eFEz1sa041Sev/lbe8Pm9jjQ1nPVBGmdTQ07I5zom6SkVpnq4Tg?=
 =?us-ascii?Q?VBsfX1V0Ul0MVmCjjeN9kJsrTvPzljq7QqkM0fbuFS36QfhKvoHDnFCrk9yu?=
 =?us-ascii?Q?QLYs/qikPwQNoy7NcSOSR61XyAEbSnAAMMkMuZWTTj4PkWSmlhk0yx1ZyBd8?=
 =?us-ascii?Q?BFyW1b12C+nCJqEGN/D+HasKuwoqSJShzZppJkgj5h7drDIZFLJ2D/avFrXy?=
 =?us-ascii?Q?VXurFlAO0q9gYYmYOKaHBvGJjWx9WhcmXZfzSC+TiQUPIlCsRMK039xjyLMw?=
 =?us-ascii?Q?+ML7RKBSx0SZ7ZLg4tWIHzvkeu2dlSUNZtoycozQPdjqhYBGGlO22B34EeKQ?=
 =?us-ascii?Q?lT6FXUKV97qkjBFMATNN0y8MgwEzHU+O9NYV9e87CSphMkIif3LT+irLcwu3?=
 =?us-ascii?Q?tbNz6Nrc+mF6Q6BjjxkK/7PiiTN7oe8s3vO8LhdGbJ0/JuaH+X+8iJUoU3fO?=
 =?us-ascii?Q?koVBPfadLVEpckTTxbm5kMjBOzqrxptGHiq0b+fomwJNETL7q5OE380Mrk/n?=
 =?us-ascii?Q?jRxiX+8gC6oF9uQg7fHya6qnpQYryAq/WCMrBhitQoAjQfbVnrvdpS9K6brh?=
 =?us-ascii?Q?+UOJcEoogGw81/J1G6cNc0PDOlBWRcWYpwnTyv2//FwNavQDvXySX7Ocwgkw?=
 =?us-ascii?Q?85R+fzpV2ItgjqHZSkWwxYOU4ujfYMYy/c3aA3235aioa8bpkA488D/EPZKX?=
 =?us-ascii?Q?6Lin88KTxblXZu3q+sUJ3srwk1NMTZFxddNXkLlD4KrqcLhQS8c5lq3RkTaS?=
 =?us-ascii?Q?ij8ZFRi3AfTDYWgPoWOaTJBoHQIUF6V7tpqhiWBqhXjH6owUA3lZeJO8FaV0?=
 =?us-ascii?Q?Co8re3lPte/3io+Enby19P5on894gMofd/VQLut7NOLLfOe6rC4w+lKMSJ+G?=
 =?us-ascii?Q?cP7vY8JNeRlwfXJwQ4nXIhRdKyhnX+HXbxaM66uA2dKIgxN7hKId2gJEkl+1?=
 =?us-ascii?Q?7o9mjMvlEvpkhFH44AxmhEbOPI+YbZWREoI5dSyShtUOOrSlMED8F3yjVqne?=
 =?us-ascii?Q?QLRpLVWPq3i58MTXAH5YppciQTqfiixD5Uainl7ulcQudYwAmZi6bLNfAwo5?=
 =?us-ascii?Q?lHc7DT2arLNubsFrvjyXXsZOTpHlbj+GAW3/LRvmpep7p6Hbtx+AHZVPtZBo?=
 =?us-ascii?Q?axAE4HbDcvXRTr2iUrAT/S/yBuHhe5ZaZ4XODkSkLT1DTCMMTr7lSZV/G61y?=
 =?us-ascii?Q?g8r64XeWYQ7EHiwLhpsfD67nC51Lrzwcqt2xZpjx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DU11HF9PKjF5TRyCT37wPk2/PB/ZE5bz2I4mE/yuL9uoJAWfLCbCqDRoF5P75LnzLeHaygiF77+MXZdvRPIZf6fjCaGIfS2zPaIy2XIcFlW/jp2TYCMA5IcD3wLZEXjsqaetZ8Vx7+zfozWfrAEwKg5WTbCtFRqGAQZMIdZC7INLZ7mvwH08cfyhag8PM1yhbiYP0woPXtb7DstW4Pm+Fr3rqgH8PeI01C0Txj1CfOQCE5o0E0l4x+pKfM7fm0eaf54o6xJXjB+G3QjSiE6lEAdPHeFIcAIhqFKl40XfpN12yRvOjIymYZKEzmxtSf0AaqCN0h2Rk7lI5A05CkuQHTsCJEXQp590RONHNcq90NZ374UfuXAcyvbxsRC2caA5za1y2H6Y7AePbfI8nEPEn5jw/kJPZxYxYOYdFAMICbYjdlH95W1aKdypHXVnvKGz0tp67d5YbmED230NSNvCYLgzaSt2OVdmnQwuf/0BCu8DMEzHSVDCI+kv352fzQMXWCX+20IQmf9SmPFnpahLmwQN7eDwNwM8mQKPKN1fcE9nFUwgDnrYfe9qBUD/EbMegpHYRtuy04LClD9s1RbnXpMYVp7HZXFzxc9IltUY/0D2YxCt+DBK3Xs7+0EltNMBvB/zm1HCas2DrR3WOhBPlJXuVI2n4/KcVvtaH8GWVDVP8ZZ6S5jo2uMo0+obTXQ4n4MwriD5Mj7p1iT2ZpagzmcY9P2RmHZUdmkrOnMUf5hOkyU0BX/jlgRjf5w+/AKwr2dKLECl43HdQ/eak1soN4cxUZCXNHj52e4H7jXZSMnireI6vpiWlkkmZ5DuIcg4JAvaAQ8zYmUAeZ4FK+s95WEQtCnxbwC/nCqTu+3uDYuHO0t4kh+oxHJ7BU2H8UgJ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6564.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ed1635-5a91-42b7-22c2-08db72297ce7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 07:31:11.7713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hIsZHUzTaniNUkf8GqKPDbC2gWz6nGrv/MuNGksdI+LLUb+Z81csWV1N5zwx9Zi2GQDg553R51KH/GR+JIK4Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7166
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Userspace currently has no way of checking for error bits of
> detection mode X. These are error bits that are only detected by
> the card when executing the command. For e.g. a sanitize operation
> this may be minutes after the RSP was seen by the host.
>=20
> Currently userspace programs cannot see these error bits reliably.
> They could issue a multi ioctl cmd with a CMD13 immediately following
> it, but since errors of detection mode X are automatically cleared
> (they are all clear condition B).
> mmc_poll_for_busy of the first ioctl may have already hidden such an
> error flag.
>=20
> In case of the security operations: sanitize, secure erases and
> RPMB writes, this could lead to the operation not being performed
> successfully by the card with the user not knowing.
> If the user trusts that this operation is completed
> (e.g. their data is sanitized), this could be a security issue.
> An attacker could e.g. provoke a eMMC (VCC) flash fail, where a
> successful sanitize of a card is not possible. A card may move out
> of PROG state but issue a bit 19 R1 error.
>=20
> This patch therefore will also have the consequence of a mmc-utils
> patch, which enables the bit for the security-sensitive operations.
>=20
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
Acked-by: Avri Altman <avri.altman@wdc.com>

> ---
>  drivers/mmc/core/block.c   | 26 +++++++++++++++-----------
>  drivers/mmc/core/mmc_ops.c | 14 +++++++-------
>  drivers/mmc/core/mmc_ops.h |  9 +++++++++
>  3 files changed, 31 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index e46330815484..c7e2b8ae58a9 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -470,7 +470,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card
> *card, struct mmc_blk_data *md,
>  	struct mmc_data data =3D {};
>  	struct mmc_request mrq =3D {};
>  	struct scatterlist sg;
> -	bool r1b_resp, use_r1b_resp =3D false;
> +	bool r1b_resp;
>  	unsigned int busy_timeout_ms;
>  	int err;
>  	unsigned int target_part;
> @@ -551,8 +551,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card
> *card, struct mmc_blk_data *md,
>  	busy_timeout_ms =3D idata->ic.cmd_timeout_ms ? :
> MMC_BLK_TIMEOUT_MS;
>  	r1b_resp =3D (cmd.flags & MMC_RSP_R1B) =3D=3D MMC_RSP_R1B;
>  	if (r1b_resp)
> -		use_r1b_resp =3D mmc_prepare_busy_cmd(card->host, &cmd,
> -						    busy_timeout_ms);
> +		mmc_prepare_busy_cmd(card->host, &cmd,
> busy_timeout_ms);
>=20
>  	mmc_wait_for_req(card->host, &mrq);
>  	memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));
> @@ -605,19 +604,24 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card
> *card, struct mmc_blk_data *md,
>  	if (idata->ic.postsleep_min_us)
>  		usleep_range(idata->ic.postsleep_min_us, idata-
> >ic.postsleep_max_us);
>=20
> -	/* No need to poll when using HW busy detection. */
> -	if ((card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) &&
> use_r1b_resp)
> -		return 0;
> -
>  	if (mmc_host_is_spi(card->host)) {
>  		if (idata->ic.write_flag || r1b_resp || cmd.flags &
> MMC_RSP_SPI_BUSY)
>  			return mmc_spi_err_check(card);
>  		return err;
>  	}
> -	/* Ensure RPMB/R1B command has completed by polling with CMD13.
> */
> -	if (idata->rpmb || r1b_resp)
> -		err =3D mmc_poll_for_busy(card, busy_timeout_ms, false,
> -					MMC_BUSY_IO);
> +	/* Poll for RPMB/write/R1B execution errors */
> +	if (idata->rpmb || idata->ic.write_flag || r1b_resp) {
AFAIK write_flag  and r1b_resp are set together (in mmc-utils that is)?
As for rpmb read operations you were pondering about -
the rpmb read-counter is one example, because you use it to sign write oper=
ations.
So restoring all rpmb operations is in place - all should be monitored.

> +		struct mmc_busy_data cb_data;
Maybe use designated initializing?

Thanks,
Avri
> +
> +		cb_data.card =3D card;
> +		cb_data.retry_crc_err =3D false;
> +		cb_data.aggregate_err_flags =3D true;
> +		cb_data.busy_cmd =3D MMC_BUSY_IO;
> +		cb_data.status =3D &idata->ic.response[0];
> +		err =3D __mmc_poll_for_busy(card->host, 0, busy_timeout_ms,
> +				&mmc_busy_cb, &cb_data);
> +
> +	}
>=20
>  	return err;
>  }
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 3b3adbddf664..15d8b806c670 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -54,11 +54,6 @@ static const u8 tuning_blk_pattern_8bit[] =3D {
>  	0xff, 0x77, 0x77, 0xff, 0x77, 0xbb, 0xdd, 0xee,
>  };
>=20
> -struct mmc_busy_data {
> -	struct mmc_card *card;
> -	bool retry_crc_err;
> -	enum mmc_busy_cmd busy_cmd;
> -};
>=20
>  struct mmc_op_cond_busy_data {
>  	struct mmc_host *host;
> @@ -457,14 +452,15 @@ int mmc_switch_status(struct mmc_card *card, bool
> crc_err_fatal)
>  	return mmc_switch_status_error(card->host, status);
>  }
>=20
> -static int mmc_busy_cb(void *cb_data, bool *busy)
> +int mmc_busy_cb(void *cb_data, bool *busy)
>  {
>  	struct mmc_busy_data *data =3D cb_data;
>  	struct mmc_host *host =3D data->card->host;
>  	u32 status =3D 0;
>  	int err;
>=20
> -	if (data->busy_cmd !=3D MMC_BUSY_IO && host->ops->card_busy) {
> +	if (data->busy_cmd !=3D MMC_BUSY_IO && host->ops->card_busy &&
> +			!data->aggregate_err_flags) {
>  		*busy =3D host->ops->card_busy(host);
>  		return 0;
>  	}
> @@ -477,6 +473,9 @@ static int mmc_busy_cb(void *cb_data, bool *busy)
>  	if (err)
>  		return err;
>=20
> +	if (data->aggregate_err_flags)
> +		*data->status =3D R1_STATUS(*data->status) | status;
> +
>  	switch (data->busy_cmd) {
>  	case MMC_BUSY_CMD6:
>  		err =3D mmc_switch_status_error(host, status);
> @@ -549,6 +548,7 @@ int mmc_poll_for_busy(struct mmc_card *card,
> unsigned int timeout_ms,
>=20
>  	cb_data.card =3D card;
>  	cb_data.retry_crc_err =3D retry_crc_err;
> +	cb_data.aggregate_err_flags =3D false;
>  	cb_data.busy_cmd =3D busy_cmd;
>=20
>  	return __mmc_poll_for_busy(host, 0, timeout_ms, &mmc_busy_cb,
> &cb_data);
> diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
> index 09ffbc00908b..a57751b83f19 100644
> --- a/drivers/mmc/core/mmc_ops.h
> +++ b/drivers/mmc/core/mmc_ops.h
> @@ -18,6 +18,14 @@ enum mmc_busy_cmd {
>  	MMC_BUSY_IO,
>  };
>=20
> +struct mmc_busy_data {
> +	struct mmc_card *card;
> +	bool retry_crc_err;
> +	bool aggregate_err_flags;
> +	enum mmc_busy_cmd busy_cmd;
> +	u32 *status;
> +};
> +
>  struct mmc_host;
>  struct mmc_card;
>  struct mmc_command;
> @@ -41,6 +49,7 @@ int mmc_can_ext_csd(struct mmc_card *card);
>  int mmc_switch_status(struct mmc_card *card, bool crc_err_fatal);
>  bool mmc_prepare_busy_cmd(struct mmc_host *host, struct mmc_command
> *cmd,
>  			  unsigned int timeout_ms);
> +int mmc_busy_cb(void *cb_data, bool *busy);
>  int __mmc_poll_for_busy(struct mmc_host *host, unsigned int period_us,
>  			unsigned int timeout_ms,
>  			int (*busy_cb)(void *cb_data, bool *busy),
> --
> 2.37.3
