Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36756DC669
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 13:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjDJLtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 07:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDJLte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 07:49:34 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070b.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::70b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8737D4ED4;
        Mon, 10 Apr 2023 04:49:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAGjmfMVHmEWc3CcFcurWaC4fw84+GxsQ9oEjsDstGIFAertHs8A/xfJraEKOt269fpn1wsJe7hfghAvlHe1VkdblKvO1VDn4AH8N3v9zsA0nP0ZU7ruT0g4ksI0MJlknQAVR0ulRDpXo08Raj9UrdaIc3CaTRgUU6Y2KfGgC35qv+86hqy4LL2ROYRtymZGeLBhnS1Hpd9wA4O/qWxdxEN0Rbn3dBV0s0AH+AzsVlpUJQYo3WTw92tl3P2Q4iFFRAWtJ83BTSPPVkI6vrLbaSDYlxcaOVXBXcRDP10NHBKhfcUksc4r4q83bXb6dlqPOwR02TRin4a2nKS661HElw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KERBg7bOnS6WW3KSGKKhw+a//npYSwX5OouEdpg+X/c=;
 b=UaNPu0GjkBckE0i1IA4nPFJfDlxCgKGBXCmkmzBcLPFD5kcBFY7v9KqbyvKTBOWkTybEquzeAskvGmbFJ33RUl5gLAS1bvEDD1ZhyV3Bn2ZFjMw9WtW+qZzv2ylzjSlD5AjNWgAueqiurN35TAxgHO3zUeQilpj9xQ7goajodQ5Fvnjv8oYsG+lDHTuLbiixH6zulT0ksvRrfSjCGjg1mogse/aGr+wp0FMbRvKB4X09dnh3P6F0rhV/3Cau/cFGWF0NGRGeE0sm6hVUqRPLNk6vgyaF1KK7KqAtWxqXbyn4xgBd1cnP6t3/Tri3S8Ygzk8aGOHbGzkM0Khsi5ZRUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chelsio.com; dmarc=pass action=none header.from=chelsio.com;
 dkim=pass header.d=chelsio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chelsio.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KERBg7bOnS6WW3KSGKKhw+a//npYSwX5OouEdpg+X/c=;
 b=UiOSiAZcO+fQuCSIEBs3z1wrLgnFfpTBxVzMwvuUn2QVx+2Qepc8JfflY0l8x0dbm4J1yTW9231rRcojvrK1s8AYg2rKKUglYLupRyjc8YDi/ZpO+AaHz9SJakg/NhLu0K78ZsmxWXW5a3imILuRgvkv7rHKKir1GFPpFLH+f2E=
Received: from BN9PR12MB5324.namprd12.prod.outlook.com (2603:10b6:408:105::15)
 by MW5PR12MB5622.namprd12.prod.outlook.com (2603:10b6:303:198::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Mon, 10 Apr
 2023 11:49:29 +0000
Received: from BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::6d75:bbae:8cf6:2c08]) by BN9PR12MB5324.namprd12.prod.outlook.com
 ([fe80::6d75:bbae:8cf6:2c08%6]) with mapi id 15.20.6277.031; Mon, 10 Apr 2023
 11:49:29 +0000
From:   Varun Prakash <varun@chelsio.com>
To:     Denis Plotnikov <den-plotnikov@yandex-team.ru>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "nab@linux-iscsi.org" <nab@linux-iscsi.org>
Subject: RE: [PATCH] cxgbit: check skb dequeue result in
 cxgbit_send_tx_flowc_wr()
Thread-Topic: [PATCH] cxgbit: check skb dequeue result in
 cxgbit_send_tx_flowc_wr()
Thread-Index: AQHZaSZ0kfcxd4Ywc0iGdBV4qkHtr68kcasw
Date:   Mon, 10 Apr 2023 11:49:29 +0000
Message-ID: <BN9PR12MB5324AEFFA45F46CA998CB450BC959@BN9PR12MB5324.namprd12.prod.outlook.com>
References: <20230407075603.311230-1-den-plotnikov@yandex-team.ru>
In-Reply-To: <20230407075603.311230-1-den-plotnikov@yandex-team.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chelsio.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5324:EE_|MW5PR12MB5622:EE_
x-ms-office365-filtering-correlation-id: 8597bedf-8f7a-4bed-d639-08db39b9a449
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mGU4I82JywMKxS+cr08h80oydBxUuGK5oZgHdRR+YBLeeQ8r7nzq0olMH/AVHkJQKLl2bmgqYZgj5REnVHyX6AUA7i3X/L206i1/ci006yB/FLMP7iO+87Urlbs4sEvUov8Xkk1Y0xP6vdAWqitrvOSzeK0+NdupRJLvKWsyS3yL1gh+YfcFC2KTZ6kepJ6gyyQ4xCikI2UqpZwRt2hc01UfMA/KEe+T4JqVAz/dZvx3jKpNQgZQ49J5LpkkXx3HmHfSjBLVV3URRNfOLfn2sfoYJbCpvPM2WkOhxPwZjhw9nETaicXxlbvwRta3tZgavmBuTVYa36RskRUrhnTt2SoY4qmiLlRexk0hhOF4L+CuQLzCydFb4sVatBpd4nPtBdRBp2/v6BiNH46r/S1tbrRCYwFSCFe2N4hS5SDfXZcwnLL6CctIhYiJpbw3cchatGVVU/iAegy+W1vzuMasMHlyU0YcA/cwwQPci455X+PHiNwDnWgSOKZ8IK01KA/F5vbJmb8jxYZlsZb72YbddFHvCZWK+y61UkNR4UBwDUIfBL/DmHbuJtirhx58ND3SsBHGa4TdeuXwxp1IvX09lZuKIma1R2pYpdEqVcsOC4WdCL8CslCfpOLCLxDowCXh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5324.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(346002)(366004)(39830400003)(451199021)(478600001)(7696005)(71200400001)(316002)(54906003)(110136005)(9686003)(6506007)(26005)(186003)(2906002)(4744005)(5660300002)(4326008)(76116006)(66946007)(41300700001)(66446008)(8936002)(8676002)(66476007)(64756008)(52536014)(66556008)(38100700002)(38070700005)(122000001)(86362001)(55016003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zuLPocYF7o7EyB5rC87CZ/D/gI6zNOVrZcXWiwMYFp6HRzMRV05i+WrRc9zv?=
 =?us-ascii?Q?wfeavNYXEhGbc5JSG6tCO8rJrk8FDCyIJKPnPtCKONVsv02pjiD/YywfjtsK?=
 =?us-ascii?Q?RQfE9pHoYpj6JMpcI/QbunANZjKdzCHPJBypVxfoAEo6BSXA6ao8K4hRItL4?=
 =?us-ascii?Q?rx0UZ1wk2X1a35nvrr+LsOQODqvPsjhzSTowSoyqdDEwcXuFdVJPZyGplfHk?=
 =?us-ascii?Q?nrB92pAS3qw7fif1g4E/dzFytVTxHPzWUrgLUwaYCEbltT2ZAqfDiRhmMh08?=
 =?us-ascii?Q?6d0WNv13UQ73Rkh7K8wb7WXiNKeh24PM4DdNgBf9D9tmmU08waG26SI/RkGb?=
 =?us-ascii?Q?w5iX1fwxpo/NFxdVOUg61m8hrDXgfxlUxhiYuSu/Zdqwjxg49BnYMsPRSNLX?=
 =?us-ascii?Q?gEq1bRX1SsklRhwzy4ECWlexn0VsHpYRGduFUtm9lrjyHbscQZ34e3tkVoly?=
 =?us-ascii?Q?OAVD25dO+DMh0TbTLXXSW50QTxZEpHhSlK9ORNXdmgjIuXTEXE4KtSKoMUJN?=
 =?us-ascii?Q?LkQ9QU578YWTc0H1Igf1kAstgZttleZYe03963jryb7loUs5JG/X1f/WgPwB?=
 =?us-ascii?Q?5oj5IazNpwdtQk+OAlW48qx10TaEpxRmyGA9NkArycIaTrL0dytOqVcEZgyU?=
 =?us-ascii?Q?g8DEZHX20Gc1dtnB8B+bALmLwYqsraEv+Upf+dtE3fL2dZPmPUTlDwrPMoJk?=
 =?us-ascii?Q?HWjZdX82c+4ix8vc0Q2hjnvNstpgSCbGtSTQzgOkI6n1XBGdQB8YBNtf3FQn?=
 =?us-ascii?Q?mptLzgSOnD7/t/WNvEuMKPwaUKEQdwOJ8Q/mj0y5O5qvWf7lumkBwp5vl4zB?=
 =?us-ascii?Q?Iqz5mFGp+gS5sc6Le+qdP8dS3/tkySN6eAlz6LdlcCAsaGB6OCL/ZHVXVV6p?=
 =?us-ascii?Q?DoG9Tj6nXId38VW50njYlYstE8jgV2GRHNhnhABv4NOf3CEJvEdigqxMpGzd?=
 =?us-ascii?Q?Gc+MH9xHtscWp8ngmmGR24pWVdkVeBSAePfOlsjaa2UnsJuiO5CiNhBy4lS2?=
 =?us-ascii?Q?3wU2QG4IBVK4zyhguX25LYnkVq7WJNbbWjV997X8ov7ENjtQjWkdMJlO7y/4?=
 =?us-ascii?Q?eLSaexBB0xcN8pjlCy62ImTyU6MHiBX9MBH4cUc9stOQQoz56wG4MXVcV7HN?=
 =?us-ascii?Q?cWqhXP28tq/LaE5bsn+iIaVL7z8XS6GYYKILlIbptSLpmErm6IDK/xIPOxPe?=
 =?us-ascii?Q?QDZ8eI34CRda0UWfQxtrrAAl+73HF1+HwdsSNNP1oMCFqkU6t44HJWN6ohD8?=
 =?us-ascii?Q?rCcmPng0CBri4h9Uje5MTFgOixw8ClvLr28uyEor+r6mr249niIUVQEFMp7u?=
 =?us-ascii?Q?2iwxpWcLqKWajYutztNgEqiL4ZtB3qUhdNvmUpz5fOCNITCVwPOc6eM8lfUq?=
 =?us-ascii?Q?+g0T0fmNXRqXcUcBisBLCN8+VKOm2ZfI68KdtdvgWci91/TMxYdkaDFdQ1Pg?=
 =?us-ascii?Q?GHdTaKM9ZUlSIVEaYcQuTvzMgALA01UXSq0v17eBFkoKe7kMyjq26wm3dc+M?=
 =?us-ascii?Q?OMhp+HFrbjT8CPyHLugU2ZQomdGMfVC1gf/iR52X+4VlfpL0B71KOUeGHPu/?=
 =?us-ascii?Q?b+KxErHgC9DDCidurj697Qj6811vA+it/xVsMsj4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8597bedf-8f7a-4bed-d639-08db39b9a449
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2023 11:49:29.0513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /SwSNNSO7Bd+RWxK/EpI2RQKTrn8usDx2cbB9BgGtDEziAxtXrRzknHdYgcUnf9Mh32wMh9XYE7CrILKhfOKDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5622
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>Skb dequeuing may end up with returning NULL if a queue is empty,
>which, in turn, may end up with further null pointer dereference.
>
>Fix it by checking the return value of skb dequeuing end returning
>before the pointer dereference.

skbs in csk->skbq are preallocated for critical events in cxgbit_alloc_csk_=
skb(),
so there is no need to check for NULL.
