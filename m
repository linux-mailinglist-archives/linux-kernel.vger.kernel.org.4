Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFF77457FB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjGCJFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjGCJFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:05:16 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2114.outbound.protection.outlook.com [40.107.117.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0ECE42;
        Mon,  3 Jul 2023 02:05:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFviwpD1R9r8tmK3jzOaCtybz3k5c0RxQAD8uzVItjzJi2MOSeVMf0TLqVqaQ4jvTAASvK0ME2THm+TuGTcZ2nrSrUNVbGpxj+at7ogdM6eojCAHjAM5V2DDmBX5reoM1BKDruJTgJQehNKmkYkV7xYgXi2NURSTyx81pRf5MeDtuzH7bUdgjudWFUs5ZwgftzZqB/f85Z+HRhURUJPOydPsMZO70LZKwCV7J+Nkojs7IXopkCuK2TG6BTirjJj/JJZXQXBv2a28Qj16maF8iYjiLyBlMd3PCbY4OVI9OuFP0Xh2lkWw8miEG2oIeqKnTAXjhpef2Z8UzgHUB5lXAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCWtJN68R1HhPxwC9VrxWnUi7tOuRuwEkcqHIHyRU0E=;
 b=f3VHbGGPhYCGpk0q2h6FN+cj/saJf2RHAU81KlQvfizeuQhvGxBxwBCpzpTs5SUohbp0oWYTHEPa5p0Aqcgm+pGLNjiJ4YRy23CYOiyePFbt6b80OlruLDbb+dis+2o2gpX8euuJcbmrZoq2wvxMBwwzPwN5qWI1IO6fMQgkikegAx4O/wR4KTGrYranEDRLLbXGhwHc4x+f6WwDiBJkTphqG7urCi5Xlt0dxUdeyCoq2vO1kQlH+A6PTn6GcPVozfuHSJ7EwKmd5E94kAGFh+fObgAXeNwbTbSPUHQidIWEZgR3/eVTlRiYiiLR5FjuyHnwdBTN/U5qOzo8HcrCSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCWtJN68R1HhPxwC9VrxWnUi7tOuRuwEkcqHIHyRU0E=;
 b=O//zC9iUN8xr8DUIGihgO4f+CcDYmkeBSwR045DfE5baEoo8runAl0Z6Uip7bYuAIfZ2XKgwhG3ZMWYHZf/+6X1CsplYR6RVa9s3uAgDmzMNaA2kb8zalQO1FoZJ9D5X6kpweIlRHKoy+qd4pmCK9wDFrSqa0vVANOs6sBR4loa2xnAnJUE5mIAheDR62HWDNfPAeUixuHF4hAOH/EKwfyq5gUKQHU+PHU/eErvnqWJFJTJLs9AlgIVwlr+ojEcKez/GmRLVpnQfVpN24KtDEJlKELKbgSs4k5g4Q2DXjDB0cv7r2V06Rp4m1yhBFriiPrS2AaNLDFB3lf77eQpxBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5850.apcprd06.prod.outlook.com (2603:1096:301:fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 09:05:09 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 09:05:08 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     miquel.raynal@bootlin.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, tglx@linutronix.de,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        bchihi@baylibre.com, frank.li@vivo.com, wenst@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 0/5] introduce devm_request_threaded_irq_emsg()
Date:   Mon,  3 Jul 2023 17:04:49 +0800
Message-Id: <20230703090455.62101-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB5850:EE_
X-MS-Office365-Filtering-Correlation-Id: 97bac4c2-d106-497e-c1b6-08db7ba49958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d+73wsR7/mieaY6O/VCZGbO+UgOjzfa8GCXMZSW/oTBy5KOH5Fjso5Ts0owjR3gSHkGagtIe5JKTlFO7GUS1aM9vSch6vb1EGZ/alkCHkN7rIgieVgQjSpexYSroLrl83suEvS2CFtXAvvw0xLM7j1lc8gTwe5HrRRY6mRPJKG1cPI8vVr5oQbOR5cW9yCG0qlPIGpSx5PAQ1p0ZzuvCa1bEBtApU54DxN4tUcKQtx2q5d6WfdgJdUPCAfy+46E0gZ1taE2IYkeV0nP6H7VzGZUftP5XuxsU+Y9d69QENJyEWnQmn/Us74GrzQv9asRSN/KwkkSccWP+ufr8L+gKZTcWGhlBnr5jHC2Xk/x5VC8ydAO2PcbIu+ay7MzMWvwE2oZrZ4YdIPuw8tOy3PESbkp7curY8KdCjW+pSrzgsAlAXqWFHdGkIWAx+JXWWedcuCw9oOxdt1d1RTYg2XBlk1nzCBjJATvZLAbiYkylG+BYe9m8ls3qw4zXRsMNwTyH38yEb8ZAiLVtFasxP84zEGt5A+ooKoQzzu/tL021Fctwn/iRphkixn7pe3NizxRkxpueF5G0H9qdAj0oZKJyefdkAIkKjAAvpq4bUGjQXzEPncLctPJAF3O5iefTf3b7nnaWQgJ9eOtezih+YAEDeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199021)(2906002)(41300700001)(5660300002)(8676002)(8936002)(7416002)(36756003)(86362001)(186003)(2616005)(478600001)(26005)(6512007)(6506007)(1076003)(6666004)(6486002)(52116002)(316002)(4326008)(66476007)(66556008)(66946007)(38100700002)(38350700002)(921005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7a4c10RXRhguPlr/LWFsPfEpUckr3zHzfd+R0rAKPouIgMubTHpoK1Dvtwd6?=
 =?us-ascii?Q?QKM9Yj7nSmQlEQsSoXkwu/DF26MrVgqhkjFDx9EGeO0RFQeOmdDDPt/azGRP?=
 =?us-ascii?Q?VmPEcWJJuF7Sqp484f1afnwUz6z5LLOERMGKa9XL2V2AhZP2Ywwb0r71Z7ac?=
 =?us-ascii?Q?MmhQM689mhXtYy7swESnk8JhILOaxuZF2GCfBjaR5Rq+MRRcyK2rJoBsTDS7?=
 =?us-ascii?Q?87sJ/+oZdrWLsPi+5IzfO0XzS5NHepSZ10xYkYCvgzJ7yB6Ld1HNuo3vqjUF?=
 =?us-ascii?Q?+wv/PPhi2NTSLOMgF3g59HdzbM+bbUEi/quvQhmt4yGgzmSKBU2KYGDRukIG?=
 =?us-ascii?Q?Se6LP/82WEBADjOTvRiURKc2ND3it0vG3Ef9aXLwgfuMoVQhU9u71WIsyqZU?=
 =?us-ascii?Q?23N+a9r7M4R5JcWaKekgc1/vtzTspYSKRISxnshBAmuF0gNW5OmhKiZw3mUp?=
 =?us-ascii?Q?Wmi3VlzfWFsuSYLMhngGWxBKIQLKjqm94+eOOzuQO/p4NWoEpAEdZuBvGoKZ?=
 =?us-ascii?Q?nWhh7efcKAL2gK9jDtVYEBaQRzJGCMUWUNOdq/AiqYGnrWU+9t27c5l5R7lC?=
 =?us-ascii?Q?ytTTlsyJB+tcNL3xbvIJnf8c2TswqbeL9EYAh6vQnVJiY8qXER2ZgFJuXXZx?=
 =?us-ascii?Q?tmPvBRHetJ88WRqHimuypcps5nz8NQ9iqiPpKwZ0eMkZjfgq+vkSV6jGNOcZ?=
 =?us-ascii?Q?FhGVVP4Xp8/2LeDwOQXPlgpl1nDKf5whh51O4Wz65Ma0G8WvSPOaPmrAunB9?=
 =?us-ascii?Q?5IYjJSCfHc5bdvW+K7bv/V+93j/B0sArz+WZSd0AME+BpW+KQH4UdxsA1yaq?=
 =?us-ascii?Q?5iR5HhsglNAfIMyy3UCsi/E3KOUHLg89qTqmhoVcLKoO+1US8lZogW2Z/dOL?=
 =?us-ascii?Q?54mQvjUdGO5PD6vMWp6YFll08c7jrSw8tyNNDTWb42S+dtQP82ck8InDQrnv?=
 =?us-ascii?Q?AQ2x6N4nww0dOg5KMDKgCv9x1vGTvA57tGsOL9rqL/vUUpLVnIu04MM19fHb?=
 =?us-ascii?Q?aR79vuYjL2xW0lJl8jaNbtd7m1fLEF/wDCNRq1ZnWtgjduUdi7WmDeShR9hj?=
 =?us-ascii?Q?Zj6W6bkXVJVRe4z1Cho7sL57Y4KKj7WpujPESBWZ/5Y3U1IzM6gSEnSl2hjd?=
 =?us-ascii?Q?0iMuZKkWGTsPbcUHxJ75uEYBLJ4FobvoIz3G72kUJZ3uDLG60y3g6CHr1MTi?=
 =?us-ascii?Q?fay+LLV89qpaukDcSMQH/FBzUU+s0ekOP1Ytb6a2mMdW8LK22/Sk0u9EEWhD?=
 =?us-ascii?Q?wVNx+OY5O/rdn6rfr/+oKeDWRqLZSQHDkZ9BBJuw6kYSAI7I/VTahdhb9e/S?=
 =?us-ascii?Q?CTcrP3/NlGLVnb+LBQN933/+JrKHiI+ysOqPWu8ZaviqdxIT+WZdGzHaQxwF?=
 =?us-ascii?Q?Caej+4R6Jpb2NRZTOPB5WhBH31JDXtEi1IAI6+VkGxNv6IgL+H17Azn84Xjk?=
 =?us-ascii?Q?ezRRND9v8I5/ZeO1LFCY1etSB+VL9gjwtzaB87cIJoydJERn8pQDfc1s9iiX?=
 =?us-ascii?Q?MY9eIbPqmZ3f8vJSELwfgp+IaQivgN56+YfDCuJ6vC36xnvGsPOKIOQjZv+9?=
 =?us-ascii?Q?YtKdUASuPAMUhHyyVhEZxawoJJEMzufH1V3mYA3Z?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97bac4c2-d106-497e-c1b6-08db7ba49958
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 09:05:08.3551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZgxHWykNdfWeZxIEOBIk05He+uojXL/uQtLkwt4iPTVf6MDEEbRMe5PIEaf/w9/7Kk48nXeBDjkkrUXjhS6uqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5850
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are more than 700 calls to the devm_request_threaded_irq method.
Most drivers only request one interrupt resource, and these error
messages are basically the same. If error messages are printed
everywhere, more than 1000 lines of code can be saved by removing the
msg in the driver.

And tglx point out that:

  If we actually look at the call sites of
  devm_request_threaded_irq() then the vast majority of them print more or
  less lousy error messages. A quick grep/sed/awk/sort/uniq revealed

     519 messages total (there are probably more)

     352 unique messages

     323 unique messages after lower casing

         Those 323 are mostly just variants of the same patterns with
         slight modifications in formatting and information provided.

     186 of these messages do not deliver any useful information,
         e.g. "no irq", "

     The most useful one of all is: "could request wakeup irq: %d"

  So there is certainly an argument to be made that this particular
  function should print a well formatted and informative error message.

  It's not a general allocator like kmalloc(). It's specialized and in the
  vast majority of cases failing to request the interrupt causes the
  device probe to fail. So having proper and consistent information why
  the device cannot be used _is_ useful.

So add devm_request_threaded_irq_emsg(), which ensure that all error
handling branches print error information. In this way, when this function
fails, the upper-layer functions can directly return an error code without
missing debugging information. Otherwise, the error message will be
printed redundantly or missing.

Yangtao Li (5):
  genirq/devres: Add devm_request_threaded_irq_emsg()
  thermal/drivers/armada: convert to use
    devm_request_threaded_irq_emsg()
  thermal/drivers/brcmstb_thermal: convert to use
    devm_request_threaded_irq_emsg()
  thermal/drivers/db8500: convert to use
    devm_request_threaded_irq_emsg()
  thermal/drivers/mediatek/lvts_thermal: convert to use
    devm_request_threaded_irq_emsg()

 drivers/thermal/armada_thermal.c           | 13 +++----
 drivers/thermal/broadcom/brcmstb_thermal.c | 12 +++----
 drivers/thermal/db8500_thermal.c           | 16 ++++-----
 drivers/thermal/mediatek/lvts_thermal.c    |  6 ++--
 include/linux/interrupt.h                  |  6 ++++
 kernel/irq/devres.c                        | 42 ++++++++++++++++++++++
 6 files changed, 67 insertions(+), 28 deletions(-)

-- 
2.39.0

