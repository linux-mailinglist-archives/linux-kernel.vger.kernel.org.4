Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085D96080EF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 23:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJUVtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 17:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJUVtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 17:49:17 -0400
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2047.outbound.protection.outlook.com [40.107.23.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD62275B93;
        Fri, 21 Oct 2022 14:49:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMQ6kl0Hojz7QVcGPpo8gR/pEicX1vIN8A3+Sei/NFR9c1N2MyBD/+i/0oR7AbtG4xbwOzhO8uaJnEfT2K0/p4UUNO0Peg4JqeUkKVMWIntvLyKcpGC2S66fyzxLGo26KnW0dAUW2l2eXcSiLmpXW6au9ZQy5lfXh8Fc9R7778eqwfg4JDKoD60Y0PPvpRZbndI+E91Zm1ckVcXMvLgMdmDl4ypr5v378zLCU/7Czp85FFrPY/99QYuKLwON6H9Fqc3Gnz6BwKVW1lTo/LMb9z9ZB+8s4igbP0xyEdewdTPYl+8lDK1tAcuhxev4S3Gmy0bycFupTwpSlPTFlJ56gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APm3trawsb1RgrFSZcW9iVahPxSGNYKm9PlWLLQTzvI=;
 b=jgQzaUTa/w2xVDtxZcKyYZmxoKDaWPsywvCK1Wj4gJXpei+Bh9pHPGWzIOMAh+fM2XJdfiprZfvXPfgsY8oYHcaBGkSULnDobpBt/wJ35d6iBP2tszHKzJpabvN1nKPrN+kv756Q0YSXMPoI82rPWj+aoSA8rzHzrN4TYcnexGvOL7hUmXLL2IERpf3FuJ7jYeIx54FjeIqXx4R0XtShKi2S8+oUi/aiXk0ZE99FaHQ54ghBfVHsNRsOL9QgJH2Te60Yw3p9e4VwHuDiJ3+lE4SloZBabpKBR9io/EGzaKvQniX2Rz/iA9RM0utkZEZLG2MaT/AMnaLgVrAVCtXAmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 188.184.36.46) smtp.rcpttodomain=infradead.org smtp.mailfrom=cern.ch;
 dmarc=bestguesspass action=none header.from=cern.ch; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector2-cern-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APm3trawsb1RgrFSZcW9iVahPxSGNYKm9PlWLLQTzvI=;
 b=TXCOJBFDsGROKhHGiD+hIly91AOVjR9hpEdcw+1i8s4mu/nnS1LAALxaFlX4aZZQ6Pkb8Pia49cziZypHZWCak1JDZEStsjVLwZDl8/mdfXkM+DMcomjVyU+xxHTROJ8g2FY52Z2dR6sBcqcncn8dUhATC5PvFb/l0AYW81gDiM=
Received: from FR3P281CA0155.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a2::16)
 by ZR0P278MB0775.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Fri, 21 Oct
 2022 21:49:04 +0000
Received: from VE1EUR02FT010.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:d10:a2:cafe::3) by FR3P281CA0155.outlook.office365.com
 (2603:10a6:d10:a2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.22 via Frontend
 Transport; Fri, 21 Oct 2022 21:49:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 188.184.36.46)
 smtp.mailfrom=cern.ch; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.46 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.46; helo=cernmxgwlb4.cern.ch; pr=C
Received: from cernmxgwlb4.cern.ch (188.184.36.46) by
 VE1EUR02FT010.mail.protection.outlook.com (10.152.12.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5746.16 via Frontend Transport; Fri, 21 Oct 2022 21:49:03 +0000
Received: from cernfe01.cern.ch (188.184.36.42) by cernmxgwlb4.cern.ch
 (188.184.36.46) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 21 Oct
 2022 23:49:03 +0200
Received: from number5.vaga.pv.it (2a04:ee41:86:7004:af5c:cfb6:df3d:69d2) by
 smtp.cern.ch (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id
 14.3.498.0; Fri, 21 Oct 2022 23:49:02 +0200
Date:   Fri, 21 Oct 2022 23:48:57 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] package: add tar development package for 3rd party
 modules
Message-ID: <20221021214857.saijsfcx5skdksp3@number5.vaga.pv.it>
References: <20221021101452.1367745-1-federico.vaga@cern.ch>
 <20221021101452.1367745-2-federico.vaga@cern.ch>
 <55dd0e6d-3d52-fce9-015f-6ebb75cf826e@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <55dd0e6d-3d52-fce9-015f-6ebb75cf826e@infradead.org>
X-Originating-IP: [2a04:ee41:86:7004:af5c:cfb6:df3d:69d2]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR02FT010:EE_|ZR0P278MB0775:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e6c33bc-8c28-47fe-b664-08dab3ae1235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aKqygYNo++yUtgPt9d0ao2ufUXTH9g25N4ggnibckNrr3vojHVqGSUk62LNJuELOeMV4CImwWIUk2QDk50hzT/w7F84Q5iwvxY24q+RE9e+NSDKSKHTuNlGTS8wdAqARpcXL+tztzMc7qhKMYRcOGMVp95+g4yRMKc6itbtFjTpvW45G13wqwwtZZabkxTx1fvaFIKC+bpRpNyOcm5yYA63SLZ/2EsGduYHoKmVeW5kGmo3hdzGzp/UI50vVxUlx7j0VGFrClCuvM1VnJluetMU5UROy9b0tevBLdf0tbAsX02t281oKwyF+EG2/ErB2nkKSIBs5yGL1VUxtLRi4H0ESj+HX1LIJPEEFiTyAqMFNKSzOV8dFAIadw1neJomibwgt0wKaTUHOThSskfd+jdr6irsFsVOrlZwmWX4tir9nxIXMCtirdTioTbkYRxAIEIEWXeR77gvUvyqZ95eQNNLv+NvNR0cpAV9Gfqv3/9PwU6rpOeLecSyQmY3eIFY7tPPFGYec0JaWLATJFJNPfhc60aSRqsiYY4jxtBYx0vd3QBgKYG9UXBDjT9Xxw+ZExkTEjCFsprdSVnqTDdRQAsTBwlfqLhfB2M+j/q0xMMNWWS9y/bepW5l7rEfhxXLFuLLsik405YNLAs/5YIn5sNxRJXQ6kD75Mp2ZfEqAS5I707ozLjubY4yn7GfBDika5wc8sAOuop7dOxhRPMDbt4+NpFdKfArFsrillEpINEs2DKpckat251nV+rXYHgguXwEVMJj6fqnqbB+GxDxsWQ==
X-Forefront-Antispam-Report: CIP:188.184.36.46;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cernmxgwlb4.cern.ch;PTR:cernmx13.cern.ch;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199015)(36840700001)(40470700004)(46966006)(41300700001)(36860700001)(8936002)(5660300002)(47076005)(16526019)(426003)(86362001)(83380400001)(356005)(336012)(1076003)(82740400003)(7636003)(186003)(9686003)(26005)(6666004)(7696005)(55016003)(40460700003)(786003)(54906003)(4326008)(6916009)(316002)(8676002)(70586007)(70206006)(478600001)(40480700001)(44832011)(82310400005)(41320700001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 21:49:03.5037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6c33bc-8c28-47fe-b664-08dab3ae1235
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.46];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT010.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0775
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 01:11:18PM -0700, Randy Dunlap wrote:
>Hi--
>
>On 10/21/22 03:14, Federico Vaga wrote:
>> Most, if not all, Linux distributions provides a Linux development
>> package which purpose is to support the building of out-of-tree modules
>> without providing the entire source tree.
>>
>> What ends up in this development directory is a mixture of source
>> files (mainly headers) and generated ones (headers, and tools produced
>> by `make modules_prepare`).
>>
>> This patch is an attempt to generate a tarball archive containing all
>> required files to build external modules. It could be than reused by
>> packagers.
>>
>> Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
>> ---
>>  Makefile                       |   2 +-
>>  scripts/Makefile.package       |  13 +++
>>  scripts/package/buildtar-devel | 207 +++++++++++++++++++++++++++++++++
>>  3 files changed, 221 insertions(+), 1 deletion(-)
>>  create mode 100644 scripts/package/buildtar-devel
>
>Is there a patch 2/2?  I don't see it anywhere.

My mistake.

Yes there is a second one but I did not want to send it becuase it is about
generalizing buildtar to build 3 type of tarballs: the linux binaries to be
placed in /boot, the header files for user-space, and the development headers
and tools for out-of-tree modules (this patch).

The second one makes sense, only if this one makes sense. That's why I wrote few
lines in the RFC cover letter. I should have used the format-patch option to not
enumerate patches :)

>thanks.
>-- 
>~Randy

-- 
-------------------------------
Federico Vaga - CERN BE-CEM-EDL
