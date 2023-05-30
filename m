Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C23A7156B5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjE3H2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjE3H1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:27:42 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2117.outbound.protection.outlook.com [40.107.215.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEA6131
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:27:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GR370He9LUpAZ+C49OkvP6ujKKGTrOYaGKaAO68biXwRhWi62Bu/VSegSSRyjaKZ+0QOuKgOn+N/VqMF+xJ5Cb6D+3pBXnjIcFhQ8z6waa/muNk3D+8lR88FSc9D6WqjAfHK9UQGdKkPKm/UEXV0FKw2ODF/NNP/6XwqkUhIEQI+QJn9oCiFXiBamwiNewTkmiXtq3gyMH7ei3sfSdz+LSuT80eBLoNL8Cnt0QFbj320Vv120tRaSecBa6Fy7Pr1TlJXXyuFdWoEOWmPgQE/+ZXsCJhpPHg2Tk3pyUzwhqB+3grAfp2rVhrwwshunfgwuQ4njYfFBdX96ywsXsqTrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOrbsqZE2NtiZFd3LXLoXD3PLTMmCfCXoLJozvzxiX8=;
 b=aLDFv1KSQvBcDfx18CN7E9MNgDj055Y977zOwYUNdyED0PwZSkSLpXbStqZ10izxcrLQaFunwsOhvO8JYIYjf5BBR4FoH2h4AzpDhUNB09InDEdU5M7gJnmzCn9qBIMHewEvc/TTWKVH23f+oVTHSdkOj/TAGw8OasaWUzNGxZBxa3YF51hPSLpImM3VawrjYkDTOL8qIWZs1r9zoo1Awr4yTLHdhwik+12BSRh6k0/Z3MNlzDtQTV1D7qHeRRjKQNM1I0IuVbEuYESE9IuGOfyP/vDI5MjqYmmG+9r4X/WDdrLOTEATpzUbXoUqAjBjc3Idrh7YJNkA2E4l6cOjPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOrbsqZE2NtiZFd3LXLoXD3PLTMmCfCXoLJozvzxiX8=;
 b=ok5zg+yHwfD6dWPumGx6kX3DPC0Bc9fhuic77KskX7mzILUixZCuCAznVK6hU81D+AI/c4kWx7ZBZdWU8n9s9y+yvRMR1ijy+AqE/lUsIb7/H7JLIgMwQ+YPZ+B20vXjVXtb+9WyMkglEEGUgtWfezSf199+hRoyoTMNYDaJhDJnWG2B5fas7/Z5HQWsc3ZcPe3BJN/awATCWuR9jbIdPa0ddn0CplYoOoWsfxSkd8+ogi6nef5FiZsFtgZyRArCIEmK2xjBmEVouSPbW+E5hGmkQ33SCtymyTrppZVBTEiC69/DC3SoIrgoIZMGVCsfYy4kSd7JwT+NibKG/v74ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by TYZPR06MB4205.apcprd06.prod.outlook.com (2603:1096:400:2e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Tue, 30 May
 2023 07:27:00 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e%5]) with mapi id 15.20.6433.018; Tue, 30 May 2023
 07:27:00 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        sound-open-firmware@alsa-project.org (moderated list:SOUND - SOUND OPEN
        FIRMWARE (SOF) DRIVERS),
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH] sound: Fix incorrect calculation of object size by sizeof
Date:   Tue, 30 May 2023 15:26:48 +0800
Message-Id: <20230530072648.13998-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYXPR01CA0052.jpnprd01.prod.outlook.com
 (2603:1096:403:a::22) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|TYZPR06MB4205:EE_
X-MS-Office365-Filtering-Correlation-Id: f40ae8b6-a380-4ac1-3320-08db60df4151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wk9XLz5EXIMUaO+tr6FAFl435dg0WaIkeTk0gsbLt2+yY0fdcEcBqXzOWLVeLDfW+jwTSRPuWWUuM1911NMeFo57mCozD0Vi51dJJKgXpP3BzReHmVVsopzuL+F8U2vpikAXpgDZd/lWmASJbVC4ToS9yauKQYgDH62X8Gk1AW044zMQOPw3k6ohbP7nRB9+L9V/p7o7Y32cgnvduRuPQhXclErxkGb+Klt+tHhu+P/XDU1ubRSMKcFCgugzzdhN7kPO/pbuV+DY4h3ZD4/W6hQNTZzOfYXaStrpCA+JBz5jPPuIwlViI2OqnwhbABRTvVanBIbn9HJrkyO0aMCINT9JIqT3oIC86G8OQPg0HufkZq4HnVz7uVEG8+TgD57Ks7LKzp0v+8OqZHyRmFxLBDRWEC0MHWjd61o5uaIl3HDWDxC9r5SKTjfblWF6UOjik7mT2uq5Q3QHaNK3Lz6TkmTy0MEHuR4MLhK2aUraqDAHhj2D9wlXquwTK0M3ciX2FRv7hMY2JPC6InHxEqo281gKWOeQftZ6fzuldpJYyuXdJqFWxKH5V6GsHeVv+IWK5g69sOY0rSliMRf/TMCx92l5GdCLehGJ2ldg9xw80drpEHpEWLcsNppd3Qlw8a0U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(136003)(39850400004)(451199021)(478600001)(110136005)(5660300002)(7416002)(4744005)(8936002)(8676002)(2906002)(86362001)(36756003)(4326008)(66556008)(66946007)(66476007)(316002)(921005)(38100700002)(38350700002)(41300700001)(2616005)(107886003)(186003)(6512007)(26005)(1076003)(6506007)(6486002)(52116002)(6666004)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q+kW9mJJ9GrXsj4igNeSrlSt9SJmFAM7BGcFc8IHcFo1uThXmnWYe0emtr1+?=
 =?us-ascii?Q?DYT1icqq3SdT+U+CiuCsaMKtTQTTZ2l1FQrj7voZrtZ9EHe0T3pLuqzVpwV/?=
 =?us-ascii?Q?gemH5SLTNFwmhTWNlPPnY+eLnFFfbgLw6CsvaagDThFtIQAbGbjz6yuAqRJg?=
 =?us-ascii?Q?Qm0Fs+jINQnZlbTAJ1WqowbZXVyhdoq/6tD2rLTuNgZ1rtc8866UdO8t3Iu6?=
 =?us-ascii?Q?+JVOlcVHKeEsP2NKdAEUpb96iVU3kwvr23gtrQ76zJ1L81TdQliKAjPzGVKd?=
 =?us-ascii?Q?2YHLgv3BJwr8OdUmROMEBbJ+UsXJSEiNMp7EcIwgicHMeZuVq8vEwCF8cdgx?=
 =?us-ascii?Q?OWu8Fr30BKMgjHKeoWor4DsIE80tp4ndNGDjOMDbTOo21mOr1cVYOUlYYiLn?=
 =?us-ascii?Q?hYnXsQT4mSJR1PLhSmp9MxVJ0Uj8m1cfBPxHu5xu9Oeq3IHTdvyoZlsv4Z3Z?=
 =?us-ascii?Q?DA9rkR3r/MiZBK/7rNIQS7J0uL0s1Q9VYXqovaAEAVDEcLUnfeGzyqXmVG/L?=
 =?us-ascii?Q?gutvw3P3JOUHWgf/1ZO4DZlTgMp5PZsohnvoEX+ac/9dv1g3h3LlodR+jnl+?=
 =?us-ascii?Q?GeqO1AIoXTCpoRO9Ovp34ktQ7o6bjYkNf/yBw84Lr8m/+0mLdHXHkb9sh/Zy?=
 =?us-ascii?Q?x41olwHTKD+PeSKeQLjfUsa1jqRb+kCGWl2m0J2Zgvy9gwLPp3j9OFIrE+vW?=
 =?us-ascii?Q?3WAquKN2Nwj4YH1wlyovfPTxcWlj2sNk3crIrs7Gyz72tZpjlDtLSh5EgpAk?=
 =?us-ascii?Q?Zn6GGHQLIYpanWRwllLRUN+lURSSDe7UMD5gRE5kO3JfweXj3USrb47Lu3dH?=
 =?us-ascii?Q?6Xe6yTTylS2TvMHvYh3CrNOAUpUt5fWLnIPdExS52SnEXI1mSIztyxvA9yh9?=
 =?us-ascii?Q?z7EzH7sIQ2y+HtL+4F/v0QBb9ovEp1QPgLhxoWP89jAlfBXucdsLe1JoENyD?=
 =?us-ascii?Q?0ydLlwD3e3wRSPgBhBv43/DkKLcuEJwKWBlcUPOc4s+ts2jsxmGtvyyppX4m?=
 =?us-ascii?Q?cyUoik7OEqfEyLEp5UkctuHjy9AgoyyZirXOTlK+e0mcmZsACY8YRPSVuQnY?=
 =?us-ascii?Q?wWQK9h3/0Td9WVHgGfkXsvmBNmPNmht/NENrB2fuAmGtUu7jNkaNhJ8edz7r?=
 =?us-ascii?Q?klemASawMV8XTIVclpCGktcrzsDkNtTQjLstu+J7Y7woCkib/5preKPKGBQa?=
 =?us-ascii?Q?dGa17D+Fhejl01/MYPs9ZC8CBREhJkdkMiZW6L9A6KW/hBmomzKELyeeKokJ?=
 =?us-ascii?Q?VF/Xs76tunjhu1Lr7R4qTwzhh3eCT79ZXq0d0brqVNkIrYHhrQwOmsaSDW2Y?=
 =?us-ascii?Q?LgZDg+vyp2EPBNAgfHMyCr7LzsvFWVG9BdqpolPEzpWlCtdIm/3knag5ffst?=
 =?us-ascii?Q?GwUE2FsvQn7clQCrJSYw9GmwJCpIkF+LEw/YyLqYFcd0vTIolNN6Pmi+r6sw?=
 =?us-ascii?Q?C+sEXDSEnlV+5Mb6IuDKVkk6fP3jEPrwwA2kk0xUPqUMcbZSLgx8GGkFGIVP?=
 =?us-ascii?Q?pAzrBhj+YTgjPUk13DLMfVC1TqdrSoujdvZdJt9jkdDpKtckWd7pANgrzWIb?=
 =?us-ascii?Q?saTAM2OY8JlwLHcpWr0b0IXcMCRqZqxel2SzN0GM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f40ae8b6-a380-4ac1-3320-08db60df4151
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 07:26:59.8249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1hH75LlhprBj4n9rNx0LlJ+Ij1bo0c8ACmGwNYu4mvbpZ5BqzLjYbvpWtFa+126GjD2UZb4viQfz9yDzzU+3/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4205
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What we need to calculate is the size of the object, not the size of the
pointer. This patch can fix this error.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 sound/soc/sof/ipc4-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 mode change 100644 => 100755 sound/soc/sof/ipc4-topology.c

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 5abe616a2054..29b6dede53b0
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -220,7 +220,7 @@ static int sof_ipc4_get_audio_fmt(struct snd_soc_component *scomp,
 
 	ret = sof_update_ipc_object(scomp, available_fmt,
 				    SOF_AUDIO_FMT_NUM_TOKENS, swidget->tuples,
-				    swidget->num_tuples, sizeof(available_fmt), 1);
+				    swidget->num_tuples, sizeof(*available_fmt), 1);
 	if (ret) {
 		dev_err(scomp->dev, "Failed to parse audio format token count\n");
 		return ret;
-- 
2.39.0

