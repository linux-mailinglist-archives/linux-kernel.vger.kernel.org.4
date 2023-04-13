Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BC96E1198
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 18:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjDMQBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 12:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjDMQBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 12:01:07 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2090.outbound.protection.outlook.com [40.107.255.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A19AF35
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 09:00:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdSEPbpqJPksLdsfcVKyA2TXJo4k9GDtqD0LSNl9Y5hx5DGRlIuBmsKfjuTjY9chdwFvXvfXoWfZja8tMS2+X7HofWnFUeejQ034oHyVS1nFm2JdQSCk6bEZ4SxQOrNvnM1fhsG8jwbeDXxU4umaP0N6ELHp4UX9/eU0ATbTor0JsDZ780WXQmPYt7k+fLCmlzb/jFcitPP2GHMFnAT4Z4wZXYwwexRD+f3Hubq54sKIsLsgi/UtW+zYUqJxD3Rv66EX+NwXwyaL7Fwh5gENOGI+AqY70Q9B1AkmR2PmV3C50tEDSdsX31/KW1cAO3cRfAjeoq9rbqq4IgXDGcLegQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDYtmaGYcaX/raoc+todctYpIy049nhT0yocDifWiv4=;
 b=ZeCqEIUNxjryISo8leWY/PV/eCiLSwSYAjaqI6tP+3bOEW+Ag5am2UqeynDJSs8OElkFTVTrCNBzRwKkRBPc3FD0bNy4CIE+SD9N23k10/q3MNzF1HEFp+bdyckGHYcjxATT9+HBQf9fFDgbfP2YlHL3jEGwOd7MUvTpoV+IDhOiMqYTx5yR3TMCMZdLd6qUD65DsHxHLtfuRXDkpZGA2BoGBzD35purOgVOeB22IjpIlvOKeSjjyQ2i5ck8nNvKY3RToLIlzmvSj14BkLejuW3mQ1AIM7b1+b2sGNlaqckQL+Jj6R041yFkFvB3SRV6gOmzwdAvHOj+N589GLhxDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDYtmaGYcaX/raoc+todctYpIy049nhT0yocDifWiv4=;
 b=J8Pxl9vDGVA8+hS1XRBhvYZyPHz+w4WPAgOmmFqTR441kf8s1M3+/79RHdGsTxgum0SSp0w9JoiOd+VudH2mftqvyZ7sX+K+bY+bVP7yePnaDF0kGakNsV/NE64LexcS3NwBWri6V847RaODq+CsSntgS4M36xSSRym2+q01Qn5B7LYuHN2AhinmWqXDZMkbTVs0TYeuLLlrmUvXWBxRcwQxbfkfXYqUv0/QiMkcB2HPowLTukYmRgLV+A0evAn02RhfNshzBzI9IatbSFeibnyXyIhbKEBxiuCnmSMm09vC+5W3/MeHXkBeJdL9Gopl/BlVW7caZ5HoAVplKRUqBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB4189.apcprd06.prod.outlook.com (2603:1096:400:26::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 16:00:56 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6277.038; Thu, 13 Apr 2023
 16:00:55 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     chao@kernel.org
Cc:     frank.li@vivo.com, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: introduce F2FS_SBI_RW_ATTR macro
Date:   Fri, 14 Apr 2023 00:00:46 +0800
Message-Id: <20230413160046.77717-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <88e48f65-a68f-6742-fe25-d05e7113c2fc@kernel.org>
References: <88e48f65-a68f-6742-fe25-d05e7113c2fc@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:3:17::25) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB4189:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b776ef-2c75-4e7a-5ea9-08db3c384329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FqIgXexs8DNwxaKUwuKrsr5mq9mszsBC3zVA6b07Bz2z3uFPt104pGVo+2sLENJS9k4DZutMATUbvMznMUUkYNq2o5K982n+u/CmGMlia1CNmVwc3QZxqTI7Tz6OWA1wh+MtkbnE7p/iY1WlmDqPUzzopIGIQnfXLUmxwsvRptUcDDNKlTAG5ZofT/vdEGTCZEIJYJpWgernUY6Iz2oGvoKnxLD871S9QDQTMWAl+ctDKsLarpY9TXTCNh3UT3/3hx6E19upNzNnt6+hkV6BjeeGOURwXhsyydQoK5zkBTF3Wxj0l+Uhgrm1jXDEiaYD2CT8VabMOm/6fj9Ux8Js8Ow+Mo/ysz6kQJDLkxZap+nmnZeS77ezD/zvT1IfSRJtXJXouYXznLhwmq0/LdaF/b5vZrqFYffM+IJKG+zQYTKCRKPGfu/8tvxg2Sr3FBwxUPPqZQNm5z41/YEbUGDubtJnAsrP7VwvpJ5877RK6HbtKrXZqnRxpw1qbXUzAmGAnnsEojAGeH//Sd0NEpWdZhirL8Mwv0pzq9ZB6458upvNVTm6LU6nZwyZXjEY9bsYz39WB6CkniTGO5d3o4SLsM71TwQQPGWfhxVU0dCRaGA7MBwnwwQwupIfoaF7MB4g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(451199021)(26005)(38350700002)(38100700002)(36756003)(5660300002)(4744005)(2906002)(316002)(8936002)(86362001)(66556008)(8676002)(66476007)(66946007)(41300700001)(4326008)(6916009)(6506007)(1076003)(2616005)(6512007)(186003)(52116002)(6486002)(478600001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?09In6xLHdxAZor4ykboV2OIwT4p59P5CKcMNtqhPA0NCJtled47cDOGGOrLa?=
 =?us-ascii?Q?ITKj067HY+hTBJ+O/kMELvngixy7oYTrmPrYEyBk+8FoLoXvJJdj+BrMAtDa?=
 =?us-ascii?Q?kAgZ/YwKBGuV/5P0Wz+cOYVaruxnyXlZz5Mw05oc3qLLUlZHvRi2AoOMauYc?=
 =?us-ascii?Q?/tEi/JmomXCtj9eH5taW5QzTjSFfi2Is0dNErElKPzf5grO2D3SOjeDvp2je?=
 =?us-ascii?Q?Ye1GFqEij++oP6CZ3hmLTJj4ow3p0DKxGBnhPK3HEK7P919SRERNMNWr4ldh?=
 =?us-ascii?Q?gTG/ueZBdJfncgXTWnMF6pktjieGoVwIQAkdvMC1vvKe01sSuH7KfUSPpQkw?=
 =?us-ascii?Q?GsPFFnOvHa7NeFdw8mGGAz6JhvpwOuc7GaupIasQLMKSr6r7YVsGgfiMPGul?=
 =?us-ascii?Q?eiGRwaC6pwnmPmQ3SeQi2YVqR47Ia2i16mdxzwtobgjcQB4itSeFqDHE8F0I?=
 =?us-ascii?Q?OoFq5REoNTBTei8F2H1DepSXC5fuBtuJ79L3o+JTogpQyFicTSnrJv6wdrIh?=
 =?us-ascii?Q?TtxPwvPpZthRV24KQLQeMDMs4o43vIVIsuoq96Sr7UjIPxSLwt4hLe6XP7DZ?=
 =?us-ascii?Q?7FzspFeOuebcMyZkutKVNxIilz5uOTkwh1T8e+JzzmrjIk3lZ1LOFQP+6jBg?=
 =?us-ascii?Q?VTR57v8k/zakjdQ3Omn19cpvmRJLz6IBJX5NrQgRSxI74GwJPxMvRcOcNb72?=
 =?us-ascii?Q?8NfjNCWaAw2dUSDY4YOUfRFX+gDhn1UZ2qHtCi7dzK2q4Cj+H5L7fit2xU/+?=
 =?us-ascii?Q?Jog7ixZhKNfKI+lFVwxO3It7LvDFluzILgvfZYofyIJSJfuYLqMnHN8unLXh?=
 =?us-ascii?Q?Qj7XAdyK0FieoX/OsJ/n0mplclyODr+uXY36A3HJE4WuOdBW8KrJXuTL1CYh?=
 =?us-ascii?Q?L6P0PCzbQTRndIjiuazBezHINh+WW8PCjsCBqzpLIZ0DQINd2lNr1+TAr9f0?=
 =?us-ascii?Q?5JRqIgwBPbny4fNEbADEV/xGUq3CNi959E51LetSudsFipaY1wb0VFdsP8/Y?=
 =?us-ascii?Q?OoqfC5B3NflPEFbhTMgnQfIA4djaanIjqwYRAmo7VA6gLY5OJIWDNU9kbBpt?=
 =?us-ascii?Q?9z1gOoConGRR+dEFcd+U3oYO5/slCfcK8gAkRpcHzWmUwdGmbLorVgBIHkmQ?=
 =?us-ascii?Q?Qv6ODYTGQ6x0DhNAaLETbGK1kkv/VWM5HZUImgMK3TEC/ZivK5HZbv4VmMAI?=
 =?us-ascii?Q?DN42WzNpndJoxZTp9Zn2LQ2xtTyAKSJCmd5Z0IlzlsAp6FfRXhZ17zsew8rd?=
 =?us-ascii?Q?Y9SsMWNbCSbfleLmxmISROUWTqF2EJX2yIgE8LNMmVzMMpognf7IvN1gaIpt?=
 =?us-ascii?Q?jdiWvq/CyJXrTJ7TaViGtLjtI3sH1jgJo9H7h4K7a1PWljEfXEUlKU5BuPKp?=
 =?us-ascii?Q?+/aq3ofp4ABnlG1KznlPeJKc7pE9JIfQisviD82hTX1hYXlW7zK9d9JNv7JS?=
 =?us-ascii?Q?DNt7qDnsiYsI1EEnaIW7+63cM/RRrbUuC86NG8fj0bq9ThW+6QItB/mF//Iw?=
 =?us-ascii?Q?1WgYXnlyiQOBKomGu6yiZcQcFVbY2vqx7DpiG8770NXnXFUUGwTSE7yTWMuH?=
 =?us-ascii?Q?CG1hvPb0sATLNaApb+EsCpQ+9gkh3N4g8ZZTQ/Gn?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b776ef-2c75-4e7a-5ea9-08db3c384329
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 16:00:55.1316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ReTO9WILKhHZfoK53buXTEWMubYk3jJZeqk74xa/YCSRShj9BW1UPsdQ5yPBiLjGJQVJ8vslQYDq65GJGtDOXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4189
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> F2FS_RW_ATTR looks more common to me.

My idea is to add macro like this:

F2FS_SBI_GENERAL_RW_ATTR(node_io_flag);
CPRC_INFO_GENERAL_RW_ATTR(ckpt_thread_ioprio);
......
F2FS_SBI_RW_ATTR(umount_discard_timeout, interval_time[UMOUNT_DISCARD_TIMEOUT]);

It seems unnecessary to repeat a bunch of the same things just to add a parameter.
Are there any problems using the new macros?

Thx,
Yangtao
