Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BC35FEA90
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 10:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiJNIb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 04:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiJNIb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 04:31:56 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2078.outbound.protection.outlook.com [40.92.107.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F06190E77
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 01:31:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArPPiSjmmoH0xjtaWJTP8fi8wB21pqjyhwRcUFmivqZpDhYOjoDO+TDxYxU6tRDR0kdLpLgloUpdnBHj0Kcp7QHVj9BNcjAmNLuCvfrYRMJ64VRjpc9xfgjVtKz4eA58fxfQvBGMI1XCv4Z2yx3fzf4zZnvw640srgbbLyu/B34EpNtn6DSBS7Vdzd+3rYPqjP5TCWFQnCH6blSn5eFGYE1rMWwORyo1YZhmpJpa71eJtfgPV3tnkj6FkbCCkHAGv0ykPOFE9myXksGCMdEZjwZ1ekIiaVZT+8xW/rH/VH1BdcIGGetIfYLNjAeSsac2hOSa6CXKIKbgYOcXAykIkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyxOP9BKS15BQdW71DpfQaTUzlCv8xD6r7ubV0UXh7g=;
 b=EqUk07ezGzx6ixVQTkdUC57SU7G0B31H1U1sDCl+AwqCyzJQNepGt6tPukKypdioGrzljXQDUJg7gnRu/KpIY4Py/2V/yY35w6A7ZYI8qGexotUmrj5hZj0lt8sK0DhCAV3SuqSdYL5WKEyf1mAeZAbAydFWhxDc2mydsshJHAPLQEPOwfWwticr0amN6fxz/hlHEgJLIyhpFe0l3K0fgFX75RKq9lgfgCxas4csN/Mxcu98RRnn+nzPAKrNpISbgJwzQL7DPnjePmfLIHgpGIKG2P7QutcoaFCjpQmU8VVuwxl5Or+WBLYJ5eDUXlV7OnuqHM6oUrB81jNyzWpJGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyxOP9BKS15BQdW71DpfQaTUzlCv8xD6r7ubV0UXh7g=;
 b=lT3l1VuOM0J+iS0JrroQkJ9ctcGRC9a97bZh8TFsb/Y2pl9OuckkJ2Malv/q9lAoWrD+I71DHyelVca7Td3+DMGN2tSsrv8bk/qbyJyQQhsu+tv0+43U7KZ17HyOq7naxrKPXlem33FCAga2dDT/Uuoug8Yl8VDg10tvHLlXIyYwAXfu2jhomgvikDTTxrjSbfKhMhY77f9Kf37VJ5loPoGgWsihP6bBAooAXuVH4CLm6OuQVIT38CkVYs5RVHKWg7FePEEg9YMYYWg/WAvdgBrHCz5W+VaQSYi1mAIFu7XLBilPsnKW0GdawfHeZ7/6NJ0vstuVa31VI3xiJc7Tew==
Received: from TYAPR03MB3085.apcprd03.prod.outlook.com (2603:1096:404:1d::10)
 by PSAPR03MB5398.apcprd03.prod.outlook.com (2603:1096:301:43::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.22; Fri, 14 Oct
 2022 08:31:50 +0000
Received: from TYAPR03MB3085.apcprd03.prod.outlook.com
 ([fe80::3e1b:cc07:6f81:d850]) by TYAPR03MB3085.apcprd03.prod.outlook.com
 ([fe80::3e1b:cc07:6f81:d850%6]) with mapi id 15.20.5676.007; Fri, 14 Oct 2022
 08:31:49 +0000
From:   Ken Lin <ken_lin5@hotmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     michael.jao@quanta.corp-partner.google.com, derekhuang@google.com,
        chi-jen.chen@quanta.corp-partner.google.com, dianders@chromium.org,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [PATCH 0/1] This patch disable write zeros support on WD SSDs.
Date:   Fri, 14 Oct 2022 16:30:56 +0800
Message-ID: <TYAPR03MB3085889D47D998F875D9775EAE249@TYAPR03MB3085.apcprd03.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [jwDDZpYShaa6891xuK4vKDCYPGaGUcs8]
X-ClientProxiedBy: TYWP286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::7) To TYAPR03MB3085.apcprd03.prod.outlook.com
 (2603:1096:404:1d::10)
X-Microsoft-Original-Message-ID: <20221014083058.1451914-1-ken_lin5@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAPR03MB3085:EE_|PSAPR03MB5398:EE_
X-MS-Office365-Filtering-Correlation-Id: d31f7dbe-0698-4a73-f028-08daadbe898b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MZm3A0rF1kHlvtO4UaQ5IxpKdxGGVHiyNwKvbYZd/KXO5/cNeygs/xIivFeDsvDGQvw6eDTEtfc6NgWQ0jCFO61WS6fgrhIWlGcoLtZk9GRYH08VTTjq9i0NUNoxIsVecHQJxjb8YfYl8z5QMZpyPK7QCvcYjxJyz5rz1BOmFUDrYezVvA+CghsVUEFOTuWq7wUITXl7dRZZwH0x1g/uRYwcDMIcBXnZ4YrIorUBxngu/8VPkdHuTg60rzwtgxohuArHTuT7y8iq/02cWXUr0PjdnQNqt6j0iWU9+mssqD0MJTIm/Yse0CnvEgQQneuVGeUaE8CpBBlvCm8J4Tzyc6pR+/u6nUG7JRO589ozYk4sh11NG6VuCU223vlaUGtwzrYZfccOW752+GU7OABas6EvMhiD2C3cCwOd6Y+uZjidX/5MYV0p1io7jK1dfHCnIQM0YQ8/y11QN24GTZQzWtRcnyWzmqafTN+/RriUw6DC8zGSKVDuu00SLALvMgKrp1issAlF55z+SgbxmWREJ8omyjGyUfvJRAkuTua7TdDA5/CaMidjbc91oHTmE6GbmQZD7xEzUBqCjuAyTH+CVOase9HqIgGX8gatjTmQkZGxLF1/7VtL/kp1wK6GhnUQ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KkCW637q4JxMblajR6rEynogdU3Q0nPsxIYpkuaoCBoUdB0NDakcDb72MwlI?=
 =?us-ascii?Q?CFVnA+6nnwfRLc+CFiEhRJ4M4cvRLRD2YEMGHOl073EB5BUAgZYDvs4JFttu?=
 =?us-ascii?Q?1qEiw/M/A5PMox5s/2cBm9e7QazYl4gstCyXaz7GaJv4hKhcOdVqVXW9pZ6L?=
 =?us-ascii?Q?JJyKq2nurc1hc9RqKfyKUzzkwCnWzXCmM+1b/mTvnZWHtz0O+yAGavRB7NSX?=
 =?us-ascii?Q?KawS/zfVEJTfhCTvtLkbeKoI73/O2Iz8mRU37JZE8K0IQmEHca/mrryRPnpJ?=
 =?us-ascii?Q?HP1kyWGtdpuwTi6e8IdFD7dVPgfACMmcuocI67jED+cirZch9vNAVptDA/ig?=
 =?us-ascii?Q?1ZDIJCD9P/cVszlLqKH0RAW+ftTaoVFW8Y9C/1wXsxynjdVGYpfLvZPHix2T?=
 =?us-ascii?Q?pn3SIXk/jAKlY3RMzfEJCvh+7IsBu14axzi45D+KuaoVTM2rA4caIYP8OMEO?=
 =?us-ascii?Q?wtz0LAYb5fGtocgjPLolbdedPsmDZXAXGLPpd0MZTMiWtlTXuS8d+nyG2j48?=
 =?us-ascii?Q?W0372oDd3sXw5eahMa2lJ90GxnScA32iyR07wWiG+O1b2pOJRS2bbzqHlIrQ?=
 =?us-ascii?Q?NSRcYGoQa9e11phuD4nNoO6FCxHkLMzg3JFn+9Y2Cb+MTz92F4aEpq2MjTUv?=
 =?us-ascii?Q?e7IaxoHt8VApGpuJBhx4o8kaWv6J4+ubrxVZqoS+QHIUpxOAVY5kSYbgQo9i?=
 =?us-ascii?Q?MfAN9kYF4vtjS3tgr7wrHfhcWyeexiwuWLQgGiLxHstWsXJsEvE15+debuu+?=
 =?us-ascii?Q?70md2Ho9L1lPOguzn/5/Og/x2KWqOjZB0UIx4n1j19bE67P9pl15UDYvEMuE?=
 =?us-ascii?Q?WVekf8s2zJVVScY0Xr6RqYy1HZX6uLYfGlxiQC0ZlHXIZ0MlBtyKKWPXMZWi?=
 =?us-ascii?Q?g3uneoI6fIHGkCB6Kd/01GXPP+Qxyo2lGf0ekVfspWEXh8Cnh/uQQx7XV5GL?=
 =?us-ascii?Q?WAObYAlud5MPQKdGoHDUX1Ho3AZBRNx8HR+xF4zeqZI3qRyPlUBGfmGVk7Fd?=
 =?us-ascii?Q?eFvSdfrhVPA6z+ciE1tox14gBFWJxk1GlwvFYe4Fx+Jcx4woLUO8TMU4aUv/?=
 =?us-ascii?Q?PcDEUax9C82ES3mg79D1oPYM/sMaMcVxzRfmV36X8LlxUh4wc3ugCcUC1cO+?=
 =?us-ascii?Q?PFNRQepqAMei7f3QkfsKOpSsMA7rA+Be9/Y3QsR/hA88n4DfJfWyq12WQnGI?=
 =?us-ascii?Q?ePACiTczfNK7jwtjcseidA0XKtLG2TC31HM0mrsg1cRHqIVRl3qm41TnBUEJ?=
 =?us-ascii?Q?cnY4/OBHkDS5SXOO6b5XCv4y23KChvpUoTY4h5DCyw=3D=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c0b75.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d31f7dbe-0698-4a73-f028-08daadbe898b
X-MS-Exchange-CrossTenant-AuthSource: TYAPR03MB3085.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 08:31:49.4231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5398
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this patch, devices with WD SSDs could not enter suspend properly.


Ken Lin (1):
  nvme-pci: disable write zeros support on WD SSDs

 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.25.1

