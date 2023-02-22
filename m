Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB8F69EE4C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 06:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjBVF2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 00:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjBVF2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 00:28:35 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B722312B;
        Tue, 21 Feb 2023 21:28:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3d0x8NauMDBAW5w/h8m5JoZ1XX7owWyIPskwZ32v9Sw3aPZ1tBqqobzRmOP0CWt4BPm5JEhdzqVdVCcxKGzQXgUfndO1lqa6kz5DucnnXHnOsgADFbAlrdBo9jm2Jb2yBRMU8EJ/Ux+KMEWSrK8LFWHvqYuYthZsrgSGhezgx3WfGkYKQuX3PuLKxv8+72j70yfDqsKvu7q9V1cpsFmvltKRUk+lm6iuJ6pg0ezmQlLcFJ9HVYOEpAeFN901igfWDTqxmju+e1CS+nDbaFsWyiyxDcUm2Z+eGOMpKMiUCSrD8oCspwHBX2j1eRsmnKrPRCrLN2WKrxsZ6hOpqkSnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuzSdPQF8fhUjP+owOIVllE6GslTkOkW32qIFG1p2eQ=;
 b=k50hM4hX5bp6v840XtpoJlaGjZ0pl0zmfk9bvyVDYpP366VqIYG/X1kqIqr4MiAFKVy13sKvXnBQkR8Iswzfs87r1x/RfXtjW/Wd1NjSHTrEdCT0vTVVYAWE3yyLQGm4T1mt1nK0ff1yfxeVnPlKa2FGF91OmB05pBAyTBmBtaPZvx2P44dCMlOKwD9//hnmhKLUGnOU6bqwccPd0rP40hxRB4TcyVC0iK2vjR6/d6ZxE4b0a7IW1ohI5BYojbFf+VFg/W/KuSqCcpf7LovOrL2+PgpnJ5FVe5Kk655fPSIptfAyc/o5POMYrr0pvLN9p1ixKijj6zgbmjMaJB5K8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuzSdPQF8fhUjP+owOIVllE6GslTkOkW32qIFG1p2eQ=;
 b=1U91e6laEwE/D47dQHgJPQzoW8GYfg3yRaOMOk01v8mLlk4rG6v4vOigCRd40ctpPFG/eTFidSMmWmqZg9+FGbriVYi8ybvkNk6mrE1H1AezOlQKruzwJySMBPdndFeTxWhDQMxGtb4z3+0hJcJfmqEaoqzr8LzkoROPE4ebO7Q=
Received: from BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9)
 by SA1PR12MB8600.namprd12.prod.outlook.com (2603:10b6:806:257::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 05:28:30 +0000
Received: from BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::8dc2:6f02:faaa:deb]) by BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::8dc2:6f02:faaa:deb%9]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 05:28:30 +0000
From:   "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To:     "Shah, Tanmay" <tanmay.shah@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>,
        "Levinsky, Ben" <ben.levinsky@amd.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "Shah, Tanmay" <tanmay.shah@amd.com>
Subject: RE: [PATCH v3 1/3] drivers: mailbox: zynqmp: handle multiple child
 nodes
Thread-Topic: [PATCH v3 1/3] drivers: mailbox: zynqmp: handle multiple child
 nodes
Thread-Index: AQHZP/DJdYTHndDKDk2NKSpY+bJWAa7afIyQ
Date:   Wed, 22 Feb 2023 05:28:29 +0000
Message-ID: <BY5PR12MB49020AC690EFE6F21A81962981AA9@BY5PR12MB4902.namprd12.prod.outlook.com>
References: <20230213211825.3507034-1-tanmay.shah@amd.com>
 <20230213211825.3507034-2-tanmay.shah@amd.com>
In-Reply-To: <20230213211825.3507034-2-tanmay.shah@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-22T05:28:26Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b7abbeda-7f14-4a3b-b45f-7dbd61cc0d0b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4902:EE_|SA1PR12MB8600:EE_
x-ms-office365-filtering-correlation-id: fe6e9103-716b-4a15-7c13-08db1495a1ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F25QK1TM/suciULd6BolbtXi5yu186yPD7YzaKFpJYgWv+YkK0ZEYVugsrBGFThNlWbIMaRr7s+wYIZBGC7GofnoWoj4vDnMnBYPGULW2Fi74TAfPuHWSuB7rcsfuvcpiHCZFXSmE5oLamNajOYQHXmLiSX4qXTzyHKLFTfn4xT1fmAk7Pamdmp7smlFJuLpFyughIaLphfbJ2hdxQrPQIN1kfQS5qTjTIHonHkxl4Ag1w69OtX4GJs11aaV45Ls6e3wOEPKmSRR9QtufW5ZEnEEjY4U/0kT0MgyhcJcTmd3iuOBLXVOGUlbszjIhnuT7+fKorwXFlET/4lYMAZQCv99k7DuLA7ByELup4bMlnmMWCL5JUT4d/fFZIN74V6ve1B4jMhYjoX6Cn6gI0SZth112PsEjfxQEPVCrgKIOmrQKQ9Jm2AVeT9ec7Et8N2gtAI/4mZjQTtzvEPrIDAKPSIEKF0kyTHv8wuzC+oZUTebn9MiYlu9YpjxScuNOBHCRYdRnKHwXihUGtTPogbQEKErdRFG++Th3QuguTRIGQP39QwwykfT7/B7T/2X3g2i7ziOhQRGMwLkxifRYwgaVNB7M88g4pLf8EhJbzZEaJXb10ROFIYt2ahvGmHfrz3WXaxcD91djTTMDCsW2fDieQBBNkhf0G7ub7JbMQLZsSSmGoS0gpEe2UnFJ9qBls3r895jzNI+5N+JTEBceph9Gg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4902.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199018)(15650500001)(5660300002)(2906002)(83380400001)(9686003)(38070700005)(26005)(186003)(122000001)(38100700002)(55016003)(76116006)(66946007)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(316002)(8936002)(41300700001)(52536014)(33656002)(53546011)(6506007)(478600001)(86362001)(6636002)(54906003)(110136005)(71200400001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o7h2x14POagYKgrKp3BJqVc+Gpw20iXU4qhYdPW+JqslttqBj6jGaX3kFKjB?=
 =?us-ascii?Q?zfVLs2LsLGVt8SDLCPeRnCE5azFL1/6pjSU8hXOe2L1y15I7qd4W2JU+K7Ne?=
 =?us-ascii?Q?0Aab8pvWUK9JZv6BK3DNMgm/+Vp8qBaarAWIKRH0++JlGtlxJMPCRiU+JT2a?=
 =?us-ascii?Q?yXrAAmHKF7zhOz/BdMvzcFINLHsBDef7umdr6rFGUXjoahLGAw3viicyhs03?=
 =?us-ascii?Q?BonnnOT0fE61WJgIJcrrUyO/GZH8K1ZYIb4ye2uv2uTYQYmCbzUYL7xkDPZg?=
 =?us-ascii?Q?cQKDwFaBSxXFyAOnrB4GcxyQrzxx+ElBgSeb69JwaEhBUJ4gwkw3EkiDB6uq?=
 =?us-ascii?Q?CgPzQzVk4jHsUKaz9BhLmZWTavSNp4LfOJfpzTI3d2MzSLSr/U8LgYBDLdAX?=
 =?us-ascii?Q?XbVB78QXjeM4eXGcADUVfh91DJAhAMjFsPNPAs9TRLrPyJtfhMO220UrS6WJ?=
 =?us-ascii?Q?H2NF6oNcpnKxpVXGuU4a+MSgNP1TEinLqAFf8o2OQmdInsncYtxjl8JqmOg9?=
 =?us-ascii?Q?APvuIInaXobhrOxpO7WWvbL1O2ZEb8aHvcGeSaXCHvOzyrJx5B6Fsxeq1vVk?=
 =?us-ascii?Q?ZnI6BW90cOQFJ597Hqug6OZXvSHanOncERaF2bDNz01OQSzXcisRDumt5sTg?=
 =?us-ascii?Q?9kYvU9HiG1jCHman6MAgT+/PrErm2U8i5voJxY5E0W08qsKmmyJahzGxbKKe?=
 =?us-ascii?Q?e5G9dj+NZGsi7pkTV6fbd9LyZIweCE5b3OJULOZXBvWZcNr28xLqRM2BycbZ?=
 =?us-ascii?Q?jrEgYq4JkZ0qvrFuCqcMGY030SHhT0mMRUF+kmjsdpb3HDfmHQ094Os/Kkxx?=
 =?us-ascii?Q?YFJ+/1lH8p+quU2z/QLtYEk03JJG6VhU+9stG2DjC5fNx7IsXWytZQWjqDEM?=
 =?us-ascii?Q?XyZgNXXvX4XLr52PFrS1xxiU5YlXw2M3u/6XaJc886ABcX+urqPNhDaw1PMl?=
 =?us-ascii?Q?FQPH49iQNAxa5NfqHEyz0wIRssNn9ExhLOlWQ6qujE7kNMbS88Tq86sShG8N?=
 =?us-ascii?Q?KbV945GZOW5VYHxen44wxe8IRMGszAoSCms4nEHnqexhbcTTjjxRHMWtHAwL?=
 =?us-ascii?Q?WiWyVLCgzL3cOkVTqlIoP+6YrAf7Dbv4hvAmup7wk35gQvclARX90VgKfl4f?=
 =?us-ascii?Q?t0faDIGB6CnJuOOVpeNGrxtK8nyZt6VC/T9ZTXDEDL4ULymjwdR2IA8Ql+IA?=
 =?us-ascii?Q?A/D5npoDrOqGqc5lflBZMD3DLJZ6H+FAmomMl+t43fCqTZpzj8pzVnUaxb56?=
 =?us-ascii?Q?lpLNaBgRQfnXmdxfWmlXcHtV3wkJbjwYnppA3jR4quIk3ix+0qHKFip35G6H?=
 =?us-ascii?Q?nx0XGxJnndAEncLny9YN6Ea2mssUf1OaWo2iHVkGMK2/YhqemIA+3Hcu6Pue?=
 =?us-ascii?Q?gYyefXap1ts5nvPO6CmkkP/z8xyq61GO+a5dEhmNB+gbzL1nbacvOMyNXWYh?=
 =?us-ascii?Q?S9cTp/OeRZN8zUQ5MeAhAQ2awIJ9a2cuDXfmr7waw10bW2VmgSy6JSbsCdxl?=
 =?us-ascii?Q?QPuQaXHVg+Fn0MAcqCrSR26+GJ5BwHllKk7YC2JCJyZSHh5erc0L6U7Z5vYQ?=
 =?us-ascii?Q?ZZZRNPFK49Gshd8D2Y0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6e9103-716b-4a15-7c13-08db1495a1ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 05:28:29.8623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rSGoNlN5JHZjT8zVbazeTKp84EaVkmGH3p8wAygDJX4akvP/E3DBBJm4kEjC1zsShj3DzRTw1Z9abUMw9GR1Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8600
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

Hi,


> -----Original Message-----
> From: Tanmay Shah <tanmay.shah@amd.com>
> Sent: Tuesday, February 14, 2023 2:48 AM
> To: Simek, Michal <michal.simek@amd.com>; andersson@kernel.org;
> mathieu.poirier@linaro.org; jaswinder.singh@linaro.org; Levinsky, Ben
> <ben.levinsky@amd.com>; Datta, Shubhrajyoti
> <shubhrajyoti.datta@amd.com>
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-remoteproc@vger.kernel.org; Shah, Tanmay
> <tanmay.shah@amd.com>
> Subject: [PATCH v3 1/3] drivers: mailbox: zynqmp: handle multiple child
> nodes
>=20
> As of now only one child node is handled by zynqmp-ipi mailbox driver.
> Upon introducing remoteproc r5 core mailbox nodes, found few
> enhancements in Xilinx zynqmp mailbox driver as following:
>=20
> - fix mailbox child node counts
>   If child mailbox node status is disabled it causes
>   crash in interrupt handler. Fix this by assigning
>   only available child node during driver probe.
>=20
> - fix typo in IPI documentation %s/12/32/
>   Xilinx IPI message buffers allows 32-byte data transfer.
>   Fix documentation that says 12 bytes
>=20
> - fix bug in zynqmp-ipi isr handling
>   Multiple IPI channels are mapped to same interrupt handler.
>   Current isr implementation handles only one channel per isr.
>   Fix this behavior by checking isr status bit of all child
>   mailbox nodes.

It does multiple things it will be good if one patch does one stuff.
