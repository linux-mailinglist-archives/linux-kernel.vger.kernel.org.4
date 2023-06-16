Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5EA732FFD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbjFPLiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjFPLiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:38:03 -0400
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01hn2216.outbound.protection.outlook.com [52.100.1.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB4E2713
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCM0enJPCOlY/t+jVTTZtdfUTmD/D6pOWkb50W7hao0=;
 b=S7xZIz3PExISNS+ll/taWQODRqzWqHte525GWLd9AIbUf3xylxLgVrjIji/1EtweocgvWOp5gaQUHma3fBwXs7YypAm9GVO0V4F+ByepHzw5ozW2sRzRrvnpS1eFa9XHT/kCB7ZDwHuyMWM6FxSe/OTvju0WQZ7IslUfAiSso8k=
Received: from DUZPR01CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::17) by GV0P278MB1142.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:4c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 11:37:56 +0000
Received: from DB5EUR01FT092.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:3c3:cafe::6b) by DUZPR01CA0008.outlook.office365.com
 (2603:10a6:10:3c3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29 via Frontend
 Transport; Fri, 16 Jun 2023 11:37:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 77.74.96.169)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 77.74.96.169 as permitted sender) receiver=protection.outlook.com;
 client-ip=77.74.96.169; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (77.74.96.169) by
 DB5EUR01FT092.mail.protection.outlook.com (10.152.4.170) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.27 via Frontend Transport; Fri, 16 Jun 2023 11:37:56 +0000
Received: from securemail (localhost [127.0.0.1])
        by securemail.duagon.com (Postfix) with SMTP id 4QjHGC5WhSzxpC;
        Fri, 16 Jun 2023 13:37:55 +0200 (CEST)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01lp2047.outbound.protection.outlook.com [104.47.22.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Fri, 16 Jun 2023 13:37:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCM0enJPCOlY/t+jVTTZtdfUTmD/D6pOWkb50W7hao0=;
 b=S7xZIz3PExISNS+ll/taWQODRqzWqHte525GWLd9AIbUf3xylxLgVrjIji/1EtweocgvWOp5gaQUHma3fBwXs7YypAm9GVO0V4F+ByepHzw5ozW2sRzRrvnpS1eFa9XHT/kCB7ZDwHuyMWM6FxSe/OTvju0WQZ7IslUfAiSso8k=
Received: from FR3P281CA0163.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a2::9) by
 ZRAP278MB0826.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:49::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.29; Fri, 16 Jun 2023 11:37:53 +0000
Received: from VE1EUR01FT072.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:a2:cafe::c1) by FR3P281CA0163.outlook.office365.com
 (2603:10a6:d10:a2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25 via Frontend
 Transport; Fri, 16 Jun 2023 11:37:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 VE1EUR01FT072.mail.protection.outlook.com (10.152.3.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.13 via Frontend Transport; Fri, 16 Jun 2023 11:37:53 +0000
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (104.47.22.42) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 16 Jun 2023 11:37:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8NXiCp2YpSunr8bDvXnFZEzwit6R1MKH6v+FtLGVkpK97fc8YDUbzEHZcUbpDvv+OX1x0bggaEz+BKAb42PEtmS8F/h7K868sRlO/2t0y5lmGlL5j2JJlcEd+yqGUuA4W0vGAw5/tO5VXlrgWGKVhK8tkGDT9rEP/r4ywk2KEmKSlLfLz8CK42lQMgmOuZJOAQLpGt6hRK0bbHC6+bctW/PkVFEWuJwQ39LC4OK1jdOLcakMvRr1M57kBJ/hPVK5hqn/SfqGXZAVpV7KrA4xdPhLahzGc2XbiBFxxEwexkPUQGDi5Gd3L8hhiPZun+qqTpm4/pJJhckdtTwpUBMGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCM0enJPCOlY/t+jVTTZtdfUTmD/D6pOWkb50W7hao0=;
 b=HzVgh8qb3FHGr8l+KQFosXE1MQaJ2l4HAYQXTKsbrqlt+uCePJpr+PJftOnMPEOa4T5uZWFmSwaW4HKC4J/H1HZLIIOU7VUVvOdZAHzyO8cogcTPF/3D45yyTr8qZzZCpo3v9pwocYfsqQJ2MUlc2zl5GIkoPyb3Vz/53keNpF+Pizo0nD9hTEp1v9+hzBX0MVmAQ5OOcFjj4n4UfzPnEQ7kbTh2y5VHyRKONvADU3S/7JJZzTSbE+Zaf4yez9RwvmNItzHeWgwzcbP6fPsBlDAcWtnazb/9nO7DDnvMe9HuKLhxR1eifjU2NSjsGNO1u+W35f+XYAXYHUAoUeLk/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCM0enJPCOlY/t+jVTTZtdfUTmD/D6pOWkb50W7hao0=;
 b=S7xZIz3PExISNS+ll/taWQODRqzWqHte525GWLd9AIbUf3xylxLgVrjIji/1EtweocgvWOp5gaQUHma3fBwXs7YypAm9GVO0V4F+ByepHzw5ozW2sRzRrvnpS1eFa9XHT/kCB7ZDwHuyMWM6FxSe/OTvju0WQZ7IslUfAiSso8k=
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::13)
 by ZR0P278MB0800.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 11:37:50 +0000
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6afa:fd18:1d96:496f]) by GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6afa:fd18:1d96:496f%4]) with mapi id 15.20.6500.025; Fri, 16 Jun 2023
 11:37:50 +0000
From:   =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>
To:     "morbidrsa@gmail.com" <morbidrsa@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jth@kernel.org" <jth@kernel.org>,
        =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>,
        =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>
Subject: [PATCH 0/1] mcb: Fix crash mcb-core module is removed
Thread-Topic: [PATCH 0/1] mcb: Fix crash mcb-core module is removed
Thread-Index: AQHZoEb7xjLRe60SPUmdoJvLgvSEXw==
Date:   Fri, 16 Jun 2023 11:37:50 +0000
Message-ID: <20230616113732.83210-1-josejavier.rodriguez@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: GV0P278MB0996:EE_|ZR0P278MB0800:EE_|VE1EUR01FT072:EE_|ZRAP278MB0826:EE_|DB5EUR01FT092:EE_|GV0P278MB1142:EE_
X-MS-Office365-Filtering-Correlation-Id: d82f18fb-2fdd-49fb-e204-08db6e5e2122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: cJTa/xsbhr2lmhXIcHP45CJcryRH7Faw7tMgojUEJRLZM7wuh96NtQ6+o4+GireOhf6BiQCwHQt1pGYLHdhlq0lb6hrVeNvfxj+PQXhdpUCRK+UayCmtTKlX03lENPjpLT0sQajyI6ClrXu4/UPOqpqaW9S/+xKdUgEyknwBGGkXCwlQvt1/khOgwpqm5IezVF3HoG/SQKkCLAe5MG8/FmahO42oUCU3fhe1gmREI1aY00VZjckHMRrudf52UQLXOmNxGHeT+DvP1xm53+uJUOik80RbUrrXh7bipa5vTsR6C+AlBfCS6zty64whXWydL/V9gBGAbdkXfVfslqXoBgi7q0sXXr2no/Wh7RDQzIn8hZNRhl3WBmMleaRcFY15pm/Ndugr7udfS2JkwLVXRIlr9fz75Jzh2WxapAeCMW3vS+LaSKiHK7ZeWTstC+kDSob+sxI8RyiLzNqI7/DliKfJdXNI0OsDgo/X/3L/ZYOpboX04FV7YdxGjHIJJxVDs0gcMhG4VniN0zGJKaIS2pgmP4dzzrgYZHftFyxIiIMB8odY9FgrqNp7s6CpsPo8/Pc6JfYyOc6C6nQRr1x2TqRdXK7YTiYS/dPZKQtFXO40VSl6kDqzEMIBCQM4qLJ8
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39850400004)(376002)(366004)(346002)(451199021)(36756003)(86362001)(38070700005)(54906003)(66556008)(64756008)(66446008)(66476007)(316002)(6916009)(4326008)(91956017)(76116006)(66946007)(107886003)(71200400001)(478600001)(45080400002)(6486002)(41300700001)(8676002)(2906002)(8936002)(5660300002)(122000001)(38100700002)(2616005)(83380400001)(1076003)(26005)(6512007)(6506007)(186003);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0800
X-CodeTwo-MessageID: b491933f-0ec5-4296-8e6f-83a12bd750cc.20230616113751@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT072.eop-EUR01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2a79d936-89fa-4404-2136-08db6e5e1d8e
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: s4ju7Ci97+axBzyH1NaITAgJb+jMNr6pnoOzEM0p/J5pC1XVqJRlPS89cdcvWGQM3exFU2/IGczG829BO5mc89m5XiX/xVBDF5FzMzdaYnj17XCOaR2Hl9pWmrM2RAOXwCXwM8zgTSoIoSatHeG7rl+tqr/2ZPV3YxKCw/lloS0t0lloMzQB027w6JmOSect+JxwFRCQBmcG0vfuFy6dTrBhdiahgyY+B03hTEMR+cqEOAxmoWQ6WL4OceyDauMfwWR35axs+jcB/lf8pIPrypVim9Iev7l308mjoPNGo5waAPBp1TcILhMur0A/KO0ZRvpKP6Aloxv9Yb6oD1fxo6DA0tDtWbdyFB/EkmcID9vxQVVp7Hu/18DnxG/IhET5qtNXL6rwH6bfb/+jAZACB/N7Aatu0GujS5uew9sRaFSppcHGEF9V29zLYmmj1Dtcgm/+WU5DlyX6AOD7FU7GVwUcK8Ab9hEdajYuub/dVvI3WW3TA6p+5Cw0oA+hqyEV5/O+QUKC5Cov2Lt4PhfhOPj+CejX3ZV9RoBqprTBFF2uOqSu90GC3ovbgoJ0rRBZDbwYVuLSmVHPwCKPiwIp69pJQmpKh2u9YQ+jxPpv3niB+2C9WZUY3AC5RTtSnSO4NJP9YxnQ3EtxLNdM28vcVp5GD98oy/j7X1MYXiNesmKOrlPq+X8sH4eJOzwRK3DcRatGYP7Qfl1N9W9+LM18rQ==
X-Forefront-Antispam-Report-Untrusted: CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(376002)(39850400004)(451199021)(46966006)(36840700001)(83380400001)(336012)(2906002)(2616005)(36756003)(356005)(7596003)(7636003)(82740400003)(47076005)(40480700001)(36860700001)(6486002)(41300700001)(8676002)(54906003)(8936002)(82310400005)(5660300002)(4326008)(45080400002)(478600001)(316002)(70206006)(6916009)(70586007)(6506007)(1076003)(186003)(6512007)(26005)(86362001)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0826
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT092.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: caf3dbca-244c-413a-8177-08db6e5e1f4e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sfFy2/9XoBzPX9Wqkl39tfjNiPjNLbVerKTGrpPe/0A/CUcLLcPQKwXgkdf9oJOUJChW5jy2+jzKRqY+r7V7GnySQPRn50FOIvhbzMgn8sTWtuJJ9dH+HI3TumoY/d8L59nYIWX1esbTS3XUpQTx4NKokbQe6ZmKsKybFlUCpZGQsNr47Ct5m8uRKgZhvbW+1WyVrAvkrqsmAsjtsDqymtNYV0MRMcj76WqX9MFcfF1wIm7gTEOZIF7KwboE/E8ex14OIxYbFS+pY5RcdcBpDxzGXnaW6UymVQuKpdijmAFYSUSO+FWFYre71fn8oGZfJLEChbfsO3KtQdTRKQlJnfV9e/Dnaj6TMI14OcipoOceXVoq37Gr4jTzP+dVojort20oEt3e0AwF14dFs2nJvYDfeD0ZAkQQUyTzIx4VKkHxR3ACvg0djIjQdl8IrJYa85YwIkMINqsuHYTBQkmC8TRFRjt2g7Vm8+4haNzuQ6HiAvPCZJDzWxy3u8xuKBzv9ZBTM+taIOtGG5O2SL+1D9eJ7CPNCDbHzVCuAxOIZqQ5JipbMy6aF9UIduq8Hb2Pgl1DB89BEWo4jox5f7Vl9H5yy7esxRqcpILiKOz1KsVpMFtXFVpusSY0dOIYaJmdDMvvsguDNqWif5zhslP3JVsNoF5C7+wVcBlJ3LQkSU7LxrtZLnl3ra2CDak8swcsPcWfxMNxRGOBff5m8Fuws1piJ2y6eRdn/onEq+pnulJZriSo0lWqzKB6XjRAhv6yCdJAJrk47ieFcqthwzNK9x36ORo14hvIlo33SDn17F0RKxeo7b9WSmYg8ZUt5q8E
X-Forefront-Antispam-Report: CIP:77.74.96.169;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:securemail.duagon.com;PTR:169.96.74.77.ftth.as8758.net;CAT:NONE;SFS:(13230028)(39850400004)(376002)(136003)(346002)(396003)(5400799015)(451199021)(40470700004)(46966006)(36840700001)(82740400003)(5660300002)(8936002)(8676002)(81166007)(86362001)(82310400005)(83380400001)(316002)(34070700002)(41300700001)(4326008)(70206006)(70586007)(6916009)(36860700001)(336012)(54906003)(47076005)(2616005)(478600001)(186003)(45080400002)(107886003)(6512007)(36756003)(1076003)(6506007)(26005)(40460700003)(2906002)(6486002)(40480700001)(12100799033);DIR:OUT;SFP:1501;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 11:37:56.1535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d82f18fb-2fdd-49fb-e204-08db6e5e2122
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[77.74.96.169];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT092.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1142
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When allocating a new mcb_bus the bus_type is added to the mcb_bus itself,
causing an issue when calling mcb_bus_add_devices(). This function is not
only called for each mcb_device under the mcb_bus but for the bus itself.

The crash happens when the mcb_core module is removed, getting
the following error:

[  286.691693] ------------[ cut here ]------------
[  286.691695] ida_free called for id=3D1 which is not allocated.
[  286.691714] WARNING: CPU: 0 PID: 1719 at lib/idr.c:523 ida_free+0xe0/0x1=
40
[  286.691715] Modules linked in: snd_hda_codec_hdmi amd64_edac_mod snd_hda=
_intel edac_mce_amd snd_intel_dspcfg kvm_amd snd_hda_codec amdgpu nls_iso88=
59_1 ccp snd_hda_core snd_hwdep amd_iommu_v2 kvm snd_pcm gpu_sched crct10di=
f_pclmul crc32_pclmul snd_seq_midi snd_seq_midi_event ghash_clmulni_intel t=
tm snd_rawmidi aesni_intel snd_seq binfmt_misc crypto_simd cryptd glue_help=
er drm_kms_helper snd_seq_device snd_timer drm snd k10temp fb_sys_fops sysc=
opyarea sysfillrect sysimgblt snd_rn_pci_acp3x mcb_pci(-) snd_pci_acp3x sou=
ndcore altera_cvp fpga_mgr mcb spi_nor mtd 8250_dw mac_hid sch_fq_codel par=
port_pc ppdev lp parport ip_tables x_tables autofs4 mmc_block nvme ahci i2c=
_piix4 libahci i2c_amd_mp2_pci igb nvme_core i2c_algo_bit dca video sdhci_a=
cpi sdhci [last unloaded: 8250_men_mcb]
[  286.691752] CPU: 0 PID: 1719 Comm: modprobe Not tainted 5.4.702+ #11
[  286.691753] Hardware name: MEN F027/n/a, BIOS 1.03 04/20/2021
[  286.691756] RIP: 0010:ida_free+0xe0/0x140
[  286.691759] Code: a8 31 f6 e8 12 f7 00 00 eb 4b 4c 0f a3 28 72 21 48 8b =
7d a8 4c 89 f6 e8 8e ad 02 00 89 de 48 c7 c7 e8 02 83 b5 e8 b0 7a 5d ff <0f=
> 0b e9 67 ff ff ff 4c 0f b3 28 48 8d 7d a8 31 f6 e8 da e0 00 00
[  286.691761] RSP: 0018:ffff9a56c38f7bd8 EFLAGS: 00010282
[  286.691763] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 00000000000=
00006
[  286.691764] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff8d881fa=
1c8c0
[  286.691765] RBP: ffff9a56c38f7c30 R08: 0000000000000487 R09: 00000000000=
00004
[  286.691766] R10: 0000000000000000 R11: 0000000000000001 R12: 00000000000=
00001
[  286.691767] R13: 0000000000000001 R14: 0000000000000202 R15: 00000000000=
00001
[  286.691769] FS:  00007fb78e303540(0000) GS:ffff8d881fa00000(0000) knlGS:=
0000000000000000
[  286.691770] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  286.691771] CR2: 00007ffe92b2ce98 CR3: 000000079fd9c000 CR4: 00000000003=
406f0
[  286.691772] Call Trace:
[  286.691781]  mcb_free_bus+0x2b/0x40 [mcb]
[  286.691785]  device_release+0x2c/0x80
[  286.691787]  kobject_put+0xb9/0x1d0
[  286.691790]  put_device+0x13/0x20

As mcb_bus_add_devices() is called for the mcb_bus itself, the function
tries to cast the incorrectly passed struct mcb_bus to mcb_device. Both
structs have the same layout:

struct mcb_bus {
	struct device dev;
	struct device *carrier;
	int bus_nr;
...
};

struct mcb_device {
	struct device dev;
	struct mcb_bus *bus;
	bool is_added;
...
};

This incorrect casting is causing a wrong behaviour in
mcb_bus_add_devices() where the member bus_nr is casted to is_added,
meaning that when bus_nr is "0", the function continues and sets bus_nr
to "1" (is_added =3D true)

If we have 2 buses (one for each F215 board), the function ida_alloc()
will give the value "0" and "1" to each bus respectively, but as both
buses are included themselves in the devices' lists, after the call to
mcb_bus_add_devices(), the buses will have the value "1" and "1". For
this reason, when the mcb-core module is removed, the error raises as
the ida resource with value "1" is being released twice, leaking
the ida resource with value "0".

This patch solves the problem by not adding the bus_type to the mcb_bus
itself. After that, as no one calls mcb_free_bus(), a call to
device_unregister() is needed formcb_bus when the module is released.

This patch is based on linux-next (next-20230615)

Javier Rodriguez (1):
  mcb: Do not add the mcb_bus_type to the mcb_bus itself

 drivers/mcb/mcb-core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--=20
2.34.1
