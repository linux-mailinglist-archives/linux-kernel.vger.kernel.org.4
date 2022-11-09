Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C8E622961
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiKIK7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKIK7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:59:04 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5634F11C0F;
        Wed,  9 Nov 2022 02:59:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4BEnm2buFnR4cod1QjxRCHkM9HoS0JZkzUBdqQlVAuK/ctS2d2dcBrrfieroCiGfolUx8EAmQI9yxEk937Em32mX+bQ1JswrG73XY6z9dvFnl95O/PhnFm0gjIwusNnLIx4FTwIbKA2hmPaAkyBIgkaFDthGpqS3MLRq/k/IZa18+hjmp6J81bPrJNgwyRk8zvpiaEALnUuYvjdnCuEBBbK3MEDsvVwrS9eHQwRh2s7wA6mfhqPa0it6m/DzuK6idfZIRiwSC++3Zk3aZtCgZSLUqtUxca2fSdw1fHlhm+0MS9muB2lMnQjT8rdJHIYlfL9Vz7+xsLVQxMfhwHFAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5jXOUfwY+INb9UGVvuCTHIgBkCUIWemOx1oNL82udg=;
 b=GcTAhfRL2OOA/CLNebaB/qIbWw4arIcITHMfNtslsvknMb7nDa51Sp/wFH2R4DJ4fa01fMf/tJplQDVK8/ONJG4eUV75bgtkuikhtZNulJQ50Px/C+cGnmqBbMqCQvtsZX3pMD8x8fCaNN5oU+NjqoLHfgItq8O2Wfmr2vHAyVtmB1WXgNF2uoH9FusAgT4j2CVVIITLLBCART01tgA87mSzUjIyiRZhGWi9C+tnBw6k2hMIJTLEWp6LYWYAsZOheoLM24faT9zvq4bbvqveJ36WYnxDf5YRtjgLEuaTkxqagIEpvZ0wd70eOWdUC6hRMacngKiB0LRb2mtmdp3i8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5jXOUfwY+INb9UGVvuCTHIgBkCUIWemOx1oNL82udg=;
 b=a7eb329NfSpGyQhVO2FtzsmWDsxuiM7ND0alyWl4CtfUwdzYL9xhnqnJyVbe9DyZns3Xb4w/C0FonRJbdEMgQnqvnyx97hdDicejbN9xoaB613hJ/dYdPMs41rjPGrUuKu1qDtcpvIk4pk1RSA4WgecIiC7mhL0m+b+vjT/YD+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB8515.eurprd04.prod.outlook.com (2603:10a6:20b:342::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 9 Nov
 2022 10:59:00 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d%3]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 10:59:00 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH 0/2] fsl_lpuart: add some new features for lpuart driver 
Date:   Wed,  9 Nov 2022 18:56:57 +0800
Message-Id: <20221109105659.17381-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|AS8PR04MB8515:EE_
X-MS-Office365-Filtering-Correlation-Id: 17388d5b-c9e8-4897-6ac9-08dac2416808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +gK9hosx5KXQqACmXvm9d4xEmkwBNODBwO99UMbpO43pQscz9lPvKB0g0U/rBGXjvdqUuWvE1PD4/x5dZ0/0yf7NVEbtg8Ujr/7vUv6ORvB7qr7uCbO3JL1zbVRGR+akqjYpwHRhrU9Q21qj5OJ3tC1bi4Ku8mlpaRkgmkiZMmEwiX4rMC8mzY5fVp9bmeOKbWi+ILDI+RkuhaTxsqT9H9FwlFJ+nOIKvdCjU+Ffjcn2LHxMXJ3uqs1EkopMD1MfUk1f4MXyPKGNAdh2zfmGwt+eSLWqpfxe/68iIC9cr3zyshQ9A5G/6WYN1gIwbznVrTBFiTedp4MoGIvWfACJUcRhf9mRqX83JrNzpqe5cIzbzF3gu1Rnk4X8gQw7c/jp8/nP+1jMBg+HBYQNHm38AxWKhlHiCV70kRHnMYrgCfEzKK9Tr+FhBzIVIf65PmoaK+TQ7JEVYiur/oJprtZlgHHBCTr1PODGCHjnFRl34osOLmS3o0NPgwxUhHBWr/amCVf7TGzo6a/mKTNJySqGUBZmziBuwqL7Z2TgjxbCDXaRcYTQGOfOefqZNgwf0K/O9H0lPfAJq7FoxoyNELP0PLrgMGafQonkU4ti9O33dhOGbYTan3AUgPPX2my6bYWzFwMJQa1flp7T0fAVu6ZI7a9BSrEBydh+Evvvv9xeznOQsRf7iY1vvZrT9Nt+Gvu7tewA1/hvcLtpZUxCX2A1g+BtCMyb1e4wAlPyGcSW8B6m9gCgcg6v7DEsmWnLTDd4nBg8zGUYwRROZeyODxXgGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199015)(36756003)(86362001)(4743002)(4744005)(44832011)(5660300002)(52116002)(2906002)(26005)(6512007)(83380400001)(38350700002)(38100700002)(1076003)(2616005)(6506007)(186003)(66946007)(66556008)(66476007)(316002)(478600001)(41300700001)(4326008)(8936002)(6666004)(6486002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?158ic8zzoC0Gh8BW2EpgUqHOiyXDOUliX4jEZh4QqOie/LemPRpmxl/cQjbp?=
 =?us-ascii?Q?sx4QRc5FIr7RaVPI5lQeXH/gg9zziCkjZ6cI3cJ8U040IaicAVMzfY8gty+I?=
 =?us-ascii?Q?aMZIHOkkfwQleMbKh0LsbEXHA204+Xskl40qd10l5EiSzoczwkMxtSqFLewj?=
 =?us-ascii?Q?Wy0tKKq+gW6gav+LEZfFjum891B8W2gRQRK9MskdXwoMPmWPz2LlwfSTw6Wg?=
 =?us-ascii?Q?fFZMjIitp0+S6ddp7bQHAixJRYMw18jGAtZfaTO+prP0JfICJOrpWuvSMFjo?=
 =?us-ascii?Q?fiS88N/STfMqpeu44kdI3b01ZmVRCPbL86H4rEpp2hD5VO9+D4qYmlNBgYkf?=
 =?us-ascii?Q?t1c6Ru4vM1QLXN4FBegDdriO+f33vOG6vSDA+Z1GFOXhlWEEaPALj0yczp+A?=
 =?us-ascii?Q?6gULCA1fd7SinDNgELWqEVy7J/dE5DTKtU+dzK3tqyCdTkurGKzpFMSOa6GM?=
 =?us-ascii?Q?vJbwco5n8MnDw1xu/qkeJCCI7Q5utcy87cyI3y8UmrytwksR1s4Am27lX94M?=
 =?us-ascii?Q?Bfcaxvb4hxXujZmbyUN9beOQ0SGEeWQykl/POpt2V5ig+lOUeundPdMvpt2l?=
 =?us-ascii?Q?gGMS2ws9OPUsidQ2bbGWtXJJHM6vAGxk+iQfo4XzWFySdPdsWQSoT7kDz1Ov?=
 =?us-ascii?Q?ENSLyJ52xT5QcG6VNtybjER2L30UyqUYjnP6MiqgpurriE9nAW2+A+4F/iGI?=
 =?us-ascii?Q?alL3IlnMlkMrF1qGKEdtzN4npqI8N7mhk8N1PDxnQImnXJVbJaT4sZtxAyK0?=
 =?us-ascii?Q?mhzjktgDHKPbn/WCWCxEl/TjVVuv1IBNhjhJ7isprRtUBNNUZzBZA9hRMLBU?=
 =?us-ascii?Q?zSr8p60/pMaP8h58bQLGNizhgIGbW+IsdiDtPMVbl7lasH65fDmWu97KIkLa?=
 =?us-ascii?Q?E/6Wy0a6Wd+3w7nRY55OKBG6f7uArhirrSI8O+nIzQ6TDU+H6LsHoqH/OgZE?=
 =?us-ascii?Q?S4q4gPX9VaGn3L75ebPI1Ff7xyZgmymeEkp1ZpwSg+tWBfW5QaNtFRLW1rO8?=
 =?us-ascii?Q?9eECEvPwpVP3zFKj9eVNEWrTUgsK3S/4zA3PbhcUQNc3u/nXWHfnqEjioNcN?=
 =?us-ascii?Q?0qYFbSgBSChraaBrR05ITtFwjnFzzeBiXbp/1q7II0Nd3cCKc+B1vAHZUf6s?=
 =?us-ascii?Q?iveIKTZm1ob7KDZ9/u/lUBBHRnjL2sc1cvVhMOZxbldEpMgt1Ne7hutlDI1+?=
 =?us-ascii?Q?nUfvkcw7sSplxjpRXh/CiLeTV4Wxe9qccOmGoffljIW7prkyuGjZgQdIWTiS?=
 =?us-ascii?Q?ZxzqfenPnee/dciQqTLAPUrAkx42Np/7hplSQurapHLiM1SsoFmIT+4t5AP+?=
 =?us-ascii?Q?oZXOJXFvGIAkcvTlZMbDLnvkx6/x1YUeb7UhY5lrfwXUhwR4NbJYcFUEqgTc?=
 =?us-ascii?Q?Ts94GfkcD5qZ5IZXDVWR0JzUqaCbmd11Sn3fDqkIH/Nn8ApNE/DNVW4RIzBl?=
 =?us-ascii?Q?7u88HqHCyXT7yZ4yTZkfWmRrRVA6dJP8vzr6eNCPX6nMAKzj9o+LuyVL9Fd4?=
 =?us-ascii?Q?nzzpWk9O4CfIr/rRIEDwf9AIa7oOvDdqKxloZH+rfK3zAYz2p3mQN33LqxLl?=
 =?us-ascii?Q?rQgMrX0/cI4WoBPOBsaBkeK1Go7za7x5gcu5kC1G?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17388d5b-c9e8-4897-6ac9-08dac2416808
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 10:59:00.8840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CrF8HG2dP9ZNOBY8fvL5syaTTnqNWkrVC0smM03VjbbxtUVwhUh6g8MoivV+W5tdsGowrX2Dxms96fsBMlnH6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8515
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patches have added the wakeup source support for lpuart, also enable the
runtime pm for lpuart driver, it has been tested on imx8ulp-evk board, and the
two new features can work well.

Sherry Sun (2):
  tty: serial: fsl_lpuart: enable wakeup source for lpuart
  tty: serial: fsl_lpuart: Add runtime pm support

 drivers/tty/serial/fsl_lpuart.c | 341 ++++++++++++++++++++++++--------
 1 file changed, 260 insertions(+), 81 deletions(-)

-- 
2.17.1

