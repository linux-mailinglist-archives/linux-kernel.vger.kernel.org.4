Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0E35F9F64
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 15:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiJJN3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 09:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiJJN3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 09:29:42 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2117.outbound.protection.outlook.com [40.107.117.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71831559C;
        Mon, 10 Oct 2022 06:29:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivRqFXnbbpP4GrVLS+DsVV8sqhZIE01fT6Nn52mzJXppOCdUtHAxs6/9f//nsPYPgvDlJk463lfnB8LaeR+AtO06UKxZpMhzzkypqudiXiLp6/sViVlk19mT/JjWFuyOvawk+6cxSJzPh7TdiEXdPiVckzcVUMEHpbsO/gspVh4yArjIVbgNkp/Cp3990r9HJQkDhXjVPBu554D+G7Ohlv4APaCF/GLM8gXozii5dgKWWXAzxt3BS7nTi7TK5OcRDwX9RcjTO7VGoXz/DbtnS7vgQ7y0is2tu1S258G/NuZfMv62CZD8979/Ry57x0WtDlQHObVbkYm2K+N9zK/jRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHYZQdjkR30NcpEypuJIQZLtmNLDBV6x8+upmn6F55o=;
 b=i9rh17y2ecCH4wQZgyFzjCwsihcScfx/2EqAp50AZcSrn37l5xzHUujfOQlZxxBNLgpdZ8xQOUW1WGYalEF8QAxWLqnQwOkeZPZviniLbQmHThVOtqZdm4SXw+DdpKEDW84chDyLwobV/LW3R4RlNf3NWI5HLJkc7c5YfXUep+71z8dJuOZEOn1050UILkRPS/oaTAZ08QL3V3oJ+0KPbifHyrlGsV1r8k0ZYkMj2Hn/gexIscqbmXwtVbNEXAJt8hqzN2q0MNruIfrLz9NEDJaN5NQ+UBCbrP6J8ftvnQprflVkS5cff+z4YSlGG54PLweQNEmconqVBpetJjqf2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 145.14.71.66) smtp.rcpttodomain=linaro.org smtp.mailfrom=zeekrlife.com;
 dmarc=bestguesspass action=none header.from=zeekrlife.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geely.onmicrosoft.com;
 s=selector2-geely-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHYZQdjkR30NcpEypuJIQZLtmNLDBV6x8+upmn6F55o=;
 b=oZrj9DW/UHsHJiN+1f/cP9uwHpr7i/hTDJXMksqNzkE0Qi7BTuPJvGI0OqBrqEiqjfeoGDtAg/CDllS4QxBtirh8SomB6y+CvhM451olYJBT4Zgyt/ry1wRh0K3n9hV4Q9777iP3LSbasi8V1Z9eBkHxWfeVIOBuiSMYpW1uWvA=
Received: from SL2P216CA0078.KORP216.PROD.OUTLOOK.COM (2603:1096:101:2::11) by
 TYZPR02MB5199.apcprd02.prod.outlook.com (2603:1096:400:71::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.15; Mon, 10 Oct 2022 13:29:37 +0000
Received: from PSAAPC01FT052.eop-APC01.prod.protection.outlook.com
 (2603:1096:101:2:cafe::d6) by SL2P216CA0078.outlook.office365.com
 (2603:1096:101:2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 13:29:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 145.14.71.66)
 smtp.mailfrom=zeekrlife.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=zeekrlife.com;
Received-SPF: Pass (protection.outlook.com: domain of zeekrlife.com designates
 145.14.71.66 as permitted sender) receiver=protection.outlook.com;
 client-ip=145.14.71.66; helo=CN-BJI-EXP64.Geely.Auto; pr=C
Received: from CN-BJI-EXP64.Geely.Auto (145.14.71.66) by
 PSAAPC01FT052.mail.protection.outlook.com (10.13.38.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 13:29:35 +0000
Received: from Zbook.localdomain (10.186.26.33) by CN-BJI-EXP64.Geely.Auto
 (10.186.65.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Mon, 10 Oct
 2022 21:29:32 +0800
From:   Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Yuwei.Guan@zeekrlife.com>
Subject: [PATCH] block, bfq: remove unused variable for bfq_queue
Date:   Mon, 10 Oct 2022 21:29:07 +0800
Message-ID: <20221010132907.1252-1-Yuwei.Guan@zeekrlife.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [10.186.26.33]
X-ClientProxiedBy: CN-BJI-EXV01.Geely.Auto (10.86.214.82) To
 CN-BJI-EXP64.Geely.Auto (10.186.65.77)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAAPC01FT052:EE_|TYZPR02MB5199:EE_
X-MS-Office365-Filtering-Correlation-Id: 274c68c4-ae4d-469c-deb6-08daaac379c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Mb4EVRb2PJnQMVIMkboF8KA37UvXZIqd94SYIRDPsIrd4kNuGzKQgs7MDpz8wIX7Snmw97kWRaRCczhzPSOdvWUxtBLnB7CJidrTz/5veghKVXK4uyQdvV+HbS6AektsuHOMy+VBYVf2RMkn+R9O11n4lymUpWdEIv78pINtniCx+DMr73TdpCejmM6/FsNO8/+nd2+y1zGS0rr2ZAk6UQ9DjSOIoBSv1w7aKHRxy1BmjH2QhQdt7eMIxn6Q00xVRbTwzJpKga+Qoxx0ex7hQqlefg21ZegyDYo5xol48cR/Y3Kly7ZKodPazv97pK6iJ9GgviszF4i1oWWc8NFbwqTs02HCj/pbRBB1Le/XQwdxW3kvK7zD8eJgCLEByIFDxWX/ni4z+2DKWMNONt/9C2II/nSQGFnfSo/r8QzQr6LvXLobgoyT87vkebWKxTh66yQ6aov3DMhOC3XVxrcv4mYovwNj0RBAP+3tZxBhJjD2agp7i/Hrr4YeQ2MH0zwKjUjp3LBg4KVuoSfE4jI4jh2pL4Tv9bHki27KmEKuzMtx6/7AP7JtUKBH6dYqbsNuI2XKpVTlOIuPbW9GFxoc/LrHvplWlArEQOGLD/AB/lzZAK9hLy3X/9Pwbh67wQK8Q8CkleEzdgZY8pmwKYt9tIsYw/Txq/vKpWx3aD0Vfmsna5SQReanxNe3lX6LXxhoSttaDvn4ao+2YA4Foz/7lus9QHL8pznR5ni5AStLECh+8unsdo9KnTjRxdbJvdN6i8Eg99dm3k1umCVZjkfz/0vlNhG+5bBEzRrTbpVIL3ihalDAWhKxiDZFHHiVyd9
X-Forefront-Antispam-Report: CIP:145.14.71.66;CTRY:DE;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CN-BJI-EXP64.Geely.Auto;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(83380400001)(107886003)(36756003)(336012)(2906002)(70586007)(26005)(47076005)(8936002)(4326008)(8676002)(54906003)(70206006)(110136005)(82310400005)(186003)(2616005)(6666004)(36860700001)(40480700001)(16526019)(478600001)(356005)(86362001)(81166007)(1076003)(82740400003)(41300700001)(40460700003)(316002)(5660300002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: Zeekrlife.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 13:29:35.6446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 274c68c4-ae4d-469c-deb6-08daaac379c3
X-MS-Exchange-CrossTenant-Id: 6af81d03-dafe-4d76-a257-3cc43cb0454f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=6af81d03-dafe-4d76-a257-3cc43cb0454f;Ip=[145.14.71.66];Helo=[CN-BJI-EXP64.Geely.Auto]
X-MS-Exchange-CrossTenant-AuthSource: PSAAPC01FT052.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB5199
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

it defined in d0edc24, but there's nowhere to use it,
so remove it.

Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
---
 block/bfq-iosched.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 64ee618064ba..0a7b3506697c 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -372,9 +372,6 @@ struct bfq_queue {

        unsigned long creation_time; /* when this queue is created */

-       /* max service rate measured so far */
-       u32 max_service_rate;
-
        /*
         * Pointer to the waker queue for this queue, i.e., to the
         * queue Q such that this queue happens to get new I/O right
--
2.34.1

=E5=85=8D=E8=B4=A3=E5=A3=B0=E6=98=8E=EF=BC=9A=E6=9C=AC=E9=82=AE=E4=BB=B6=E6=
=89=80=E5=8C=85=E5=90=AB=E4=BF=A1=E6=81=AF=E5=8F=91=E7=BB=99=E6=8C=87=E5=AE=
=9A=E4=B8=AA=E4=BA=BA=E6=88=96=E6=9C=BA=E6=9E=84=EF=BC=8C=E9=82=AE=E4=BB=B6=
=E5=8F=AF=E8=83=BD=E5=8C=85=E5=90=AB=E4=BF=9D=E5=AF=86=E6=88=96=E4=B8=93=E5=
=B1=9E=E4=BF=A1=E6=81=AF=E3=80=82=E6=9C=AA=E7=BB=8F=E6=8E=A5=E6=94=B6=E8=80=
=85=E8=AE=B8=E5=8F=AF=EF=BC=8C=E4=B8=8D=E5=BE=97=E9=98=85=E8=AF=BB=E3=80=81=
=E8=BD=AC=E5=8F=91=E6=88=96=E4=BC=A0=E6=92=AD=E9=82=AE=E4=BB=B6=E5=86=85=E5=
=AE=B9=EF=BC=8C=E6=88=96=E6=A0=B9=E6=8D=AE=E9=82=AE=E4=BB=B6=E5=86=85=E5=AE=
=B9=E9=87=87=E5=8F=96=E4=BB=BB=E4=BD=95=E7=9B=B8=E5=85=B3=E8=A1=8C=E5=8A=A8=
=E3=80=82=E5=A6=82=E6=9E=9C=E9=94=99=E8=AF=AF=E5=9C=B0=E6=94=B6=E5=88=B0=E4=
=BA=86=E6=AD=A4=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E4=B8=8E=E6=94=B6=E4=BB=
=B6=E4=BA=BA=E8=81=94=E7=B3=BB=E5=B9=B6=E8=87=AA=E8=A1=8C=E5=88=A0=E9=99=A4=
=E9=82=AE=E4=BB=B6=E5=86=85=E5=AE=B9=E3=80=82

Disclaimer=EF=BC=9AThe information transmitted is intended only for the per=
son or entity to which it is addressed and may contain confidential and/or =
privileged material. Any review, retransmission, dissemination or other use=
 of, or taking of any action in reliance upon, this information by persons =
or entities other than the intended recipient is prohibited. If you receive=
d this in error , please contact the sender and delete the material from an=
y computer .
