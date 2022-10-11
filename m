Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67B75FB365
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiJKNZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiJKNZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:25:23 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2065.outbound.protection.outlook.com [40.92.98.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D071937FA9;
        Tue, 11 Oct 2022 06:25:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nE1PZDCg5zSREwY8A3Fn0lq5WsXmGF6UJq86lu5RxNzdMxGkTl3gtdt0nvECPajs69bNBroHT89TJQ7TMbZMniR3sAOEc8hSmZW9RcV9bQRgGm0urv08PYenzKDKPNqU1KkX9uJ/9WJMldWEUEdgENScQrlPRg8Nv0pY1LbcgsYjyglqxJtKDiIhnYCkqq1svqli6dP8rK7Y7asoAjCQOxOcAeFblAjepgrhsXhvkq4Yx/1SBPP+yWD+N1yscg2M55Swx3SKbtF9L1vflTsf12exfIi+5rbOQTDrb9TYBxsEajuOe7ZyQqDte8YDLvJ6CcOGw757tzsmmJI63Y+KNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCVsFpbtJPKLpK5uLC2nIGPYE9hPGGYtLCRycaKs/lg=;
 b=LT9D1EsF+36nztdtFMTyqfghKQeRU69ZBtQ0jghSpMsMiZqmYzelYsVFwPpAjYFYxDbaXZ5Gj/quxTVrXAWcli6ucZXDIA4/b0RBp0Lb1w394NKOj4xljiDBKxDfD6389xmhdFZmngMYQhODdVetg2bsjqat6VaINK42P7MAuZRc5RaLUAb3aQ50BHwmhIANutmsCJyTEmhg72S9Ii+RHbIODyiBPuqgO9vur57JtKHUn2/Ncer0SHDs/sMdjx8VGTSbQ9dU4WwzvPGPH9vCiZbcnkgM4LJRSdZMLcxG7btmAq/2/MNIcWMwqUvg+NyC09vorpSWYnqbpykLmp/YDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCVsFpbtJPKLpK5uLC2nIGPYE9hPGGYtLCRycaKs/lg=;
 b=P395oSIgrNd9elosU+I2UokV7DsQN/NCsn5tmFokmDUIVPq56pdTNq7cIVYYAHKVcI3HrlN3usZf9jEZkb3cYZ7lbYhyZXU4SQ8vmYSOyI6S3RU0let9dOVcG29b4a9V/k8AxnRHbaOPoxF/3RK0Q1f251oT+6NTauOKCwuule4OLEkD/DytzdD2Y4aymoor3H1kr/MU5vFjuXHnyce/Fbe8xCeyySiITU1SoSPdjtL1oDaqOK2gZR3qdgdml4q7z+EfWQTSSNQOOIosE1D6aEIAenkEp/Zy37Dq5oek/D7Pj8tgThfPYMhrmHbZJ+VuodUlRxnJckb8vSgb8IwxbQ==
Received: from OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:a7::12)
 by TYCP286MB1946.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:103::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 13:25:19 +0000
Received: from OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e524:f983:290d:369d]) by OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e524:f983:290d:369d%4]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 13:25:19 +0000
From:   Jinlong Chen <chenjinlong2016@outlook.com>
To:     yukuai1@huaweicloud.com
Cc:     axboe@kernel.dk, chenjinlong2016@outlook.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com
Subject: [PATCH] block: put the reference of the io scheduler module after switching back
Date:   Tue, 11 Oct 2022 21:23:48 +0800
Message-ID: <OS0P286MB0338E37232D7385CE39A0B07BE239@OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <7f6cb343-bf97-c73a-c3da-c22d7543bd4a@huaweicloud.com>
References: <7f6cb343-bf97-c73a-c3da-c22d7543bd4a@huaweicloud.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [BGjkmTajMRwX6MtC/3OonDKXzepYN3Y2]
X-ClientProxiedBy: SG2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:3:18::32) To OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:a7::12)
X-Microsoft-Original-Message-ID: <20221011132348.3328-1-chenjinlong2016@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS0P286MB0338:EE_|TYCP286MB1946:EE_
X-MS-Office365-Filtering-Correlation-Id: 1438bb27-b449-475b-ab1a-08daab8c0aa5
X-MS-Exchange-SLBlob-MailProps: BoO1yrQemBhGan5+5ws4G8VZFMmLUJNcy8EURbuIcD2+dQxzKFxdEIZ/m0bV/+FiTxCJeMTwLE6vbQH4/C6VG8iqUDGaQ9YBB/sN4Bvfr7IXpC23kO+lWjX+XeyZh4Nv1mzukta/VuC9A6Q9Ua1PkBBH8IO+/Eu30YvTiqoZ4DzPg97xF2sItDut9flV74oOdqefh3UY0zryMY4TpXosRxZhEjn9P5Tu4Dv6nHfGyRLrbaC0V2eRbnRpzTdVs3kvRgBhyGNZHitFHvQDeZBbII/cc2V0imve/5LK0Mjc9Xfj4DEibl25rCTKzRVWz91O+kwML6OyZSK5g15LrVxK8JG7pLMmQJR4rWS16SdJvCVov+sKRQvu0MMl3BhgGiUbCaor7NCTCi366A+FcUh9MMDp9h+lC4M/UADY7dp4NzL0fR3C4SjMwe7XlcfwvjXn23KojWPffRQsKjBhsSh6cENMcL5Agkw+CHxPB7fs+K2In7mWcdp5eBc+fb8WqpDQWHNpPBOxwfObIhJ/U4u0cQGUoYRhIEDlHDEYdyiF78xn4BxFC4/WJCt/eG4p4dF+Q769XFpSN0NEvXSylzwEewBHea7Ap9xkynBoeufPC+Zy2SVjjyRYXzKUZR1gchGTCABYtwt0g0U/xI59j8nJfMY306yrEf3x
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jnxTwvshK/egH8AsMtsIIomXevRYgS8LMV5FDIwmt1FzruS64bkKiX7l3j3b+pMliYdhAyag5aJVIbCxjAUJhz4ujcIF7urcFeEFSw17ctBvGFBxh5W3YXpdfu0vE+yeaaPaUYRu+cYPw9wqKSxaI5MlFV5N7p9YdWxqhM9AmUWC6jjTKOvmz++P/ULOjfo3Pmdk4uNtQQard94XWwfKxrN3SPbURAgzHRSQHsLwsqFxBvF55E9yd6kz45K0+lpqa1fPodSwyPjf+FBOacI3lBKLpCzJIZtf+NxRbF0egfWv68ocJ4ttFqil1HFZw1ucqh+4qzqdeKmdcd9I01k63KCKsvzMRSDNDWGfhNYxfB81XvuVSZjuQVXKe+8Oq0it6anN/KCrjRTwmx/7Jm0LFthpwHBGRCOf9Jjw9MfRWULqjNM3cYzDglagQ/CKwPx4hIvQApXRVglWIYp/ZKSAl8CliemRLLcXGItITo+jYu7s6rFEIk+QqT6KQ6XdYa3hGuGXT7AwO1SgAQqyPJI6xfCO/AQvE5Ib4exV17G1EQIQ0NjYuuYy5KHQlf5YVMV7FuGwwksnobFPpAI6+Q6z2MXOfe/hYIpEStJ3JFEMh21w+6WmDD+oZZLnq6JDapxmAOchwk7jX9r+CfF/nQRTKQS3e8tAL2XwqTSTWr2kTMbUD6l71cwPvCs8pCye2jYU
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WzaWRv9zJUl1UwzYVMWgQRBZMjsyNXCzOlOnn07aigU/sWAivawZ7/LSVj+1?=
 =?us-ascii?Q?+0C90BAOX5rvJBETpj9RPAwJLbLZVmO+YhmhME2cf2Aq3YZJKJQFI9xK2o1b?=
 =?us-ascii?Q?XN8QLTm9UuUXHzAb5O0kDDdo3lPwe4PaOd76JbmGw2B8MuBXfIsvqk/gU8LO?=
 =?us-ascii?Q?ml5M9v7asAgsMKPX9w9lqUMXmu5fq084yZvSXtLTbwsj0iG4rMQSMu6e2oz+?=
 =?us-ascii?Q?A4siRmDbL2p7eNnGiV8588gDM/9w4EiC9xC8Qf1H5zASWRddQCurb/a5Kd5v?=
 =?us-ascii?Q?yUCYenhUA2PjHVIJW88qBvqb/YcWAqMd1Uu7l3aFDox210+Q2Rav1a0M/JLk?=
 =?us-ascii?Q?IgqUscAahwEWEPVLHVAp1d/Mwq77fc7E1axEpgSmA7oCH+HPmIEpDf2lLWDe?=
 =?us-ascii?Q?eRUNdRtHqi6cv5pCmdS03UZPw1NvQ/S1cbyYLegFGkNWQuADilu1T1blr+4F?=
 =?us-ascii?Q?uT51o+UqUSNdD69sOXNhGbR1rMDM03Uw3IlxEp3+4fbzfPI7B/5+PSmiKdb9?=
 =?us-ascii?Q?IHsWGo/ZH6Ho9aSeV6hAlDsTfjqRbH3VfzwLBZx4OFsya2RJ4xrj1XVohSjK?=
 =?us-ascii?Q?7Zk4RXNh7/FYmlWcZS4h1SBJDs+Lk64KlZ4JGiGm2c3Qs2Z/EAJJfkgqLrwK?=
 =?us-ascii?Q?VVAJJHwfhQLQ3O4IKcps5d79aUClf03LM6iZMRP8amYbpjtHNc+eUhRZy1Ds?=
 =?us-ascii?Q?gz1UksIzsG7sfNsLRcc0DgBRNU7UeOpoU641XlHNbSLIzSiSXRI+U6j2Zrj7?=
 =?us-ascii?Q?U3LCe+0ggOyZPunB6FphSqb3sItyiTNWHnEIsGQFh8XHscsEnVcNeysm3WvC?=
 =?us-ascii?Q?yQSTjfX/qZQYPO0R2J8H7JKeS1NQTS0dau616VNRW7mV+YEK8Qn0N44p43u6?=
 =?us-ascii?Q?p6i55cUlYNqFHG9q+5LfGibeL8dqp7+qTWddnR2hCrNGmaep0ipiWTRcd6yR?=
 =?us-ascii?Q?YsdJx/5qm2fksyuta0RA/YbgmWd+ipZnEcuXFXe8kGYRVchokvwiKBw9416I?=
 =?us-ascii?Q?qvMneYU4EcZccvVrcxA276VSuOrjW+5ChVqOIZu8ZE+oq9ZEbLO8e/ule/VJ?=
 =?us-ascii?Q?pXQ2NRYdN9zftmmeuKlvQRCSqurYhf+KgWDhMwJyGzP/kh59/ALkgM40C7Hm?=
 =?us-ascii?Q?jlF2KCc4NsveZDZi8yeLMvYtZ/THRasmqKUpbDBzK6bJtRAbT8vnN1RLD8sz?=
 =?us-ascii?Q?ciVIVawivmNJPXwO4uT95trax23gKciII4XQB/eJKFNYWEy6LMNkmMGIyIO9?=
 =?us-ascii?Q?E52htVNG2eHeo/dA+W9RdBVacqLEF13ymdXY3hdIAMwqXDPFHzjFKPtcxFAd?=
 =?us-ascii?Q?uqw=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1438bb27-b449-475b-ab1a-08daab8c0aa5
X-MS-Exchange-CrossTenant-AuthSource: OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 13:25:19.3585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1946
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Thank you for reviewing!

> 
> I got it now if switch none failed, old queue is not added to the list,
> and later blk_lookup_qe_pair() will fail to lookup the queue.
> 

That's what I'm going to say. :)
