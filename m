Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5304C6F286C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 12:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjD3KIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 06:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjD3KIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 06:08:52 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6761989;
        Sun, 30 Apr 2023 03:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1682849331; x=1714385331;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1Md66KwtHZB3t3+MRXKdPJkv88VoNYT7BLyeGxRjsV4=;
  b=VDZr72opH2+cTZcGBZdK4btEED2tE5ADiZ8dWCKvrWYiAYaEHHbnkfyl
   46kT1f2ZM7g4nKEAOetug0SaO4MWnes7MxrrdFOkBTCZwB2iVcW7VOd6E
   kSqGFQ9EAR8aqq8ikhF2UcKsGrogdW2vRmW0hg17pHNrUV/OU0PJnhN1Z
   luhLIxN69xZ9RynvRmXuGJy3s2mAeAmABKUBgTvMIEHL9WGxvBwkXP+Px
   5Y9L9GM/Gph041InEq08r4yRXOsIi/LYXxNs23lvm2YO+z2JyzcTLzZVB
   5tnFIAoEUIu3UfDZzSRwofunWq6AyPHB+sOEUBZot4j4fXK8hy+riBeXk
   g==;
X-IronPort-AV: E=Sophos;i="5.99,239,1677513600"; 
   d="scan'208";a="341634013"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2023 18:08:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tfs3KTb6VI37ltVU9JRLr+wCKwGYRSaZTB8z1V5037SzCcnrjYp2fOKwDCpE0EFGIyIjoWbLXiPZXmtsfEAF3SZETAfEqmkqrbIRG3paPAsKIbO3Z/PuvF1Ljytr9ysDlyDqZe8dvs4eW9QsoWc1GPifhU/93DE8Y9A67Xi6KudEGTqBUwRAiTIwKW+Vjee00NiycTK/04olDs0K4verFsYEIn1Mv2QG6UWPVCq7gG+IxXD1X2n7g58WljsRW6PlI+RFi9OSPqFXkW3mDbDJ5n4eZvVnhXVnNlxyR03U09G3JkGYjhWsW7q5+ytCn//YQ4txzUZBX4Yg7xikKMSASQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Md66KwtHZB3t3+MRXKdPJkv88VoNYT7BLyeGxRjsV4=;
 b=Tqqls23p8azQEo69GoyYqNcS5QTwgntPB4HDgn/JZKM7P+r2fzJOeTz6ON6JlARfzu28YsenuU8MJWyjVfDtmwqCwrZvR0s9W66TPVYtlO/m2yt16DQHfBaa3ziC0s+gZ0L7m3Bnt6UfBRXMz5cNipN3uQMl0rZP6Yy2bEdSqaMsikizHSW63qDUofJX5MbxfCXHlEUcxGo4VTg2bAqKr4SJjarCSdwl07/S3d5nAiwL64G3phdTiRnNQ/gXA73ZK8EuQyrchcG3ZMGkni4hFS3K46lMdalt5RttLgf+0x0xRkdf8CBhd4xGDIq1mxIokU+YK3lr2fYLutI2lHjfwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Md66KwtHZB3t3+MRXKdPJkv88VoNYT7BLyeGxRjsV4=;
 b=qoD/Ym27EfKEKdy21RVc/uoN2X8n3JeLGgX+f4hoBoab05d5XGhUOGEj1RIjSYuNdosb9NaU8aPUdHWxjF+gz2I5AS2WlJ2EOukhX/FnDpAfDaivnDvw+x7uMaeYPDKhFPxbIl5zLLWAe1T+qhwotSXTKsEbwKqWBB/k2SRhvW8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6298.namprd04.prod.outlook.com (2603:10b6:5:1ef::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.27; Sun, 30 Apr 2023 10:08:48 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%9]) with mapi id 15.20.6340.028; Sun, 30 Apr 2023
 10:08:48 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH blktests v2 2/2] nvme-rc: Cleanup fc resource before
 module unloading
Thread-Topic: [PATCH blktests v2 2/2] nvme-rc: Cleanup fc resource before
 module unloading
Thread-Index: AQHZe0vBVEwtRfzey0GWUGL193fJOg==
Date:   Sun, 30 Apr 2023 10:08:48 +0000
Message-ID: <avghd7jgrqgh4pgewihhoa7dm3b7eb4oe3u2clcbefirevikdz@jo6cyhwfsn6y>
References: <20230419084757.24846-1-dwagner@suse.de>
 <20230419084757.24846-3-dwagner@suse.de>
 <dd3850e3-045f-75a0-4980-9f44a05fd397@nvidia.com>
 <xwkb2nrwcc2ysgynznx6txhfjn73xy24qg5jvnye6r7k6jlw77@wwmiqgy6mooc>
In-Reply-To: <xwkb2nrwcc2ysgynznx6txhfjn73xy24qg5jvnye6r7k6jlw77@wwmiqgy6mooc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6298:EE_
x-ms-office365-filtering-correlation-id: 978063e4-5cd3-4f98-2f77-08db4962e443
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TnaXT7+/wazECjzjpmDCfuSFVvcLOpopCw85G881Ny77E84EUWUJM6svcgsjisrVkdnRi89OK5bAQhg4yCAD53nMkWgPiSaV9IPtfESmf9tp5lEnC9QBsNLrcSDez/1jCfd7bb9M8v1jK+bxzTB/OAaCoaExCNWRvvPHp0GKOiJ23oM7JaJgHf2Ko5Pck2MnZzdjIxpLJtfV4dibcEjepEDnlDJ3eJig5gLdikFylJ8mqgr4mq4tMkI+8ioav/XVGf2bnzsPlpPlPDSNGI9eZSS5IuKpZd02a1/X7G+xACafmYFzjhkCkMxzsm/ljhjJcz7AkxCItcNxLt+0BXfRfRCCBbEzcdo/VmzUQSyggsWWSX5/iOUUbxNZmQSNDMjxtSncKDoKRh9qqhbPfuFrdF+1ZD7VKDhy8g54WYUDlTBkWgbaFBPlGeUt7xk3vHeze++XJn31QSPpLuC3E0Fm16tiS6WQdlyDGUlSn/8kgegw6NjAlg5ZbgybN5JdopSButp/uFYcKRdWUBA2FEmz4MwImY9P1AC1sHfMp0UEPQ7ikuiTv6nvP/6u4swXQ9FEumdnAXcvjxJuXJ8tQkiWyTi9CslCu9vXsytdX7ti4Iur9WiiM2i4OX/t81G125HI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199021)(33716001)(316002)(9686003)(6512007)(6506007)(26005)(186003)(41300700001)(83380400001)(66446008)(66476007)(54906003)(64756008)(478600001)(91956017)(66556008)(66946007)(76116006)(4326008)(6486002)(71200400001)(6916009)(38100700002)(4744005)(2906002)(82960400001)(122000001)(38070700005)(86362001)(5660300002)(8936002)(8676002)(44832011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kUpOh1j1IBZlmbmNg5uujA72QAqbNfVrbFrMv8BWNpGAi/dG1GmxYAYWksEF?=
 =?us-ascii?Q?AYisPgD4HFHVOh+GIDwLx3STc5oenQujB2vBSYP6LaRLA5x3gUC1whzYo7qU?=
 =?us-ascii?Q?5pOfGJcweihK9UaJCgqrp9k+zukHcQwpGa0/F5edsDQDUTEBPAK3LEwJ795p?=
 =?us-ascii?Q?qMuK0yRC0wrIdtt6wDXt5k8PwSCwoaOL/O2N/XPgqdVjEY67V1uct6zv5DXv?=
 =?us-ascii?Q?nO2k8opucnUT9lSEcVKIVjQ2KBoOAn+pjNXLlmhqX+8H6La6vKJfNPxa0pAk?=
 =?us-ascii?Q?l/ipVjoWJ+nvp7TwYNCJB7EowF/qZ1FDyUleFSt5Hd2qtz2BPXEmgj2xjDCl?=
 =?us-ascii?Q?Cnn6x97EW+2i4cMRh8nG0CFMpIOLPawqZ0CQJ3LclPZbGLaGDTKXATeMEuO6?=
 =?us-ascii?Q?2RXN7GLPMdiRUhoxA08Y6lyPYiCBIfFY0xnAmlpzgknDW0Vcs4E17oHRMWJt?=
 =?us-ascii?Q?a8ucYpSmvw0l41OjpQ8IYEPIIkfdW20fOWDr6qfgo2KhJ6VmOoVx12xT4+mw?=
 =?us-ascii?Q?CiACXXiltl/RtsG2LNBjc/n+mBvVd++HwZ7qdXvBPGjCWFoO6QabejnuaGBu?=
 =?us-ascii?Q?N2BXQukUWJUtdjmu3IioNRXzJCnBUQblIAzxKYXXwsrw46s5vcqIwAAEp+lj?=
 =?us-ascii?Q?1aTBQ0cQRkbErPGU7j3BkBn77s0HxLOW6A9EhdcNEdyxMYnUoAVm5h+Yncin?=
 =?us-ascii?Q?OzN9LFFhwnTcWeb4+NhHa9xlc3dmdYxa68tsitkTsbXiu7F+jigMpfCCBUe5?=
 =?us-ascii?Q?uuPQRNBlurKf2yf6IvQ1ScDlzoOBHxGjdzArzj5HaOxUbIboCZvkweXKwWO9?=
 =?us-ascii?Q?QuxJGPySRK0oi07HXAmx9pePbhA6tQ70tXXbQzsqQUXZBRx4oo6fNixWFE9v?=
 =?us-ascii?Q?74PEJihu0aL8pck4ZRyH898BRrqd3JanAdsd5HOyv8iUgRkiiy9kT5R1dCOl?=
 =?us-ascii?Q?904o3VNpYEw6LTEZtUpOFe6UVE9W/QgHHL2pEcUtdLJvLdsC80tc3MyB4git?=
 =?us-ascii?Q?REMNAMyALbvUkVEiZeZ7pqvzb8KV0DaPU0FUD2SbxhZlUV5zqCAZFtr+8VaS?=
 =?us-ascii?Q?V0knQtJ/hfq6RojiRje5iFuTCKgroCbuDe95M3OWbWWWmHwZlzVSxPnJOB5s?=
 =?us-ascii?Q?z6Np7InZu5RkcDPrtlG/XxLZOl27rD7k+oqySXNRER8fsR/xu2kuCYk313Xx?=
 =?us-ascii?Q?0FV1fcJNunIR+d41IsM7pCMZGWsIVCFYcKSVsEp6niJQgrGYh9VEWX1kOWN3?=
 =?us-ascii?Q?XXUbpX5sOPEGI9k3GD6O/XVd1wZnliqimVsgYat5Z/vYex+JzsWdPJF7p48a?=
 =?us-ascii?Q?/QSj9hfHpr3+SlTU5tAn/gcQurhCIaToAhTkILn1fqgEm8Kf5GslJjUjUyvl?=
 =?us-ascii?Q?l/cfPzw3Irc/fBrP/TWuBthRDH+qiUTY1cUAqmh0BUH/v1uH1B08OOAPf8k1?=
 =?us-ascii?Q?/rKUO6+irOFHMCk/bvbQxC/YnZ3uDRve+cz0rz60SLNghItfVhn6Wgp6R+el?=
 =?us-ascii?Q?q9TNJ35gRO/yZjeA16zu0SAkQa20V3mrJ8HkvUEmHtBXPz/BAE9A5YVEOJjP?=
 =?us-ascii?Q?rN430D/ov6B45ic0MGVzLAHSoO/2D8YlsVULpRnPTIxRLBFu2M55emmdxYSx?=
 =?us-ascii?Q?3MEz/dXj63xAq9gPxppfyn4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A09482E00D0C8D428C5FC1F43F8F7B50@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JTa/Zu269cpNRGH0vGz/Y7HZMwCGtv/L1QQWI0RxTNrZjz5895Q+p9zX5LHsU+bdjUgLdtENwTBL6Vp1xZHLK4rcgOZVN47z28u/yOYdY4WMiawnXoWFHNM0t5YhrQJdtKs00+BddBFEbC1eI0GZmGhTfSiEiSUBfzQK7BPyoMM0nTsuRKtQonYIkvlfJC6+AXe0HQWM3qSBIZM0xPDyqTLkLtYSa6cZMBUqiKjvhFIWGMeRM16q40oZdEhdff6cz+LLYgpnsIRp/8ZSEXluiwMJTEwOu60l3Nn1y0j3p8cas2LLT+BnjTOWFEsLpmSOHYSf4tlQ2wHX0MmqpujyF49yXhgX1bHfF/QDzEl0sjEmZKkaHVUAOk1FaUb8+cqfMqNAN6PbgsmZc7YzdMs62L6OKAp9DxFZJrIaQ4f/HSzUuQMT/2FxQebNdHCdfcu2GtHRGyF6CjYZiX3KVfYqNUU4pZ8NmgqwMKmsUOptR/UWMD0JaclRjzS8B5+qHW3rSaTLGet/iObIIVk+2W/AFIT8OygMWjxjya2m7Cdriel4Saf1InR15ZKsz82lHLVGe9H3cNSMeN4y42PN233xRPbn0s16tVOmYPgvHqtvnnwtf3YfsstJLPPqg4Kxtqj4Prmmao8xJhU/lzO8yOtAUlpXl8yiiPuzxAIKbvETKLUxWMMDYRjR/wk+F8UR/GOLFOUAkzlDIKUYt4cdQSiMFO9+0pT1Zmetq6MHMtK+5mc86du9E9mlo9PFWP87TSpMdlXDf0JDQVH6Fi7axQ6x78FZEotT4GahV4aHYXnWCIY/Fsy2+SnS9UJqFaIzLyw1NCTf8En2Zt2dbJwkg6AmEF8DfZTyK7f5XZjGkGW2a6ARxwrkhOgw8HwXU4LEScUUoYnVY0/fafge4SmkH5+hYFi42/rsAyX4efZnrT2I658=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 978063e4-5cd3-4f98-2f77-08db4962e443
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2023 10:08:48.7762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9AqvWgGHDp7OEBZLvZYDdwCzyZ5XGmV7SuOuOaWBIkynpkBsmbz/av34kmskLwXiiqvr92CKewAsjTW3HEIAV/7ci6XPQxHBERtioQsWbFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6298
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 19, 2023 / 12:36, Daniel Wagner wrote:
> On Wed, Apr 19, 2023 at 09:41:28AM +0000, Chaitanya Kulkarni wrote:
> > were you able to test this with RDMA ?
>=20
> Yes, I've tested it with all transports (loop, tcp, rdma, fc)
>=20
> > just want to make sure we are not breaking anything since we are changi=
ng
> > the order of module unload and stop_soft_rdma() in this patch ...
>=20
> Sure thing

I also tested, and observed no result change by these two patches. Only one
failure I observed is nvme/003 due to lockdep WARN, but it happens regardle=
ss
of the patches.=
