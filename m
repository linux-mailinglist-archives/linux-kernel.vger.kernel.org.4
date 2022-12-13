Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0E464B507
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 13:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbiLMMVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 07:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbiLMMVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 07:21:34 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2099.outbound.protection.outlook.com [40.107.117.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08866C0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:21:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=feaVyU4e6EbIgGVB67WvIgkRrRPnf8IvtGlc8zjA6LR3DM09+sWxc1rOIe9bvqqSroh76ycbBM4EVnVbjIKJMGydDeaJWMFqbiqVeX2g5kWOtu2AC7agB6OS7NdbQxltH9u3BJgCPg+UubJdftoTYIkGtazOq8sTJo84QWymsjpi1RAdnE31rD3QUWTH+OZOZMTvhzJq4YHChlTL/irFLM3qG7uKlhSz9ZX0n9/7hLBcBNO3QV4ElgPhwkEMSVh1HmoRh5EvmFvqnUZfc/oU7m9+nvi6UZlOF4q62MXEf5I8XlgVieo8Z3Pl1ApU/PajGJFXpuexnZkSQ4mvB9zHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BZuOFAwDWgF383bZFGqI+tx8jwBwqp+fhaLHiltM+M=;
 b=QYyqGrNNIk85g26qnnJVOS3RpaUTUFmSjKvT5VsRYE7qTaMGo609eFqwWEjlZsivRuBQfpkvIV6h3WvTbAWQiqGvPUXNZ7/4cc7H2noYa+r+md+k7nI8zuo5AVD7tH56vOxBeJjmNWBl6dGphjU7DLYoNfdPch+MWlarVxoK0XCZz3WsqsGql85bA0G3hIJsVZhB49osqC1kRDlfMw3DLLV6lFvMAyVEhQiGFhqJ//tuXUBMzLDYteMrW6lMtFCURwIVuY1nSn/kcHSHna+wkndXWiGOL8EUMVgIVWblIWb+2aka17btJpUxZ640exqMz4TASygXBdj3t4JeLNXKfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BZuOFAwDWgF383bZFGqI+tx8jwBwqp+fhaLHiltM+M=;
 b=YqKCh98Qo7SSgy4ATgbu6sid9vNMFpQJegS8YE+TSICrFl1kca5fqA7b7wFHagZT/UvEOgIOC+w3HNuFkb2r4GesHWNYK6m2I517Qhr/YXU96TM2eyz8HO45kIW6ZzW8ttvdGrrRtDvjCiL418nVh0qmLupYZ0nsshk7w19CJ/NvQ+OBOFiHRGt6MS9ZIJV9yTwRVwwhTZdzfItQzinQ2tVGEwoxQW1aipR4EaIg82vNMiFPSjcBws/WLODCNJeu58q05qi6XVv6w+0poa8MMUMlZrWhWCB+3Et9Yd8Eg3a8q0BiMDawdl3TKTlv5xW/44xhkZDN3ys9HWPZUutszw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5245.apcprd06.prod.outlook.com (2603:1096:101:75::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 12:21:29 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b%9]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 12:21:29 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: add support for counting time of submit discard cmd
Date:   Tue, 13 Dec 2022 20:21:21 +0800
Message-Id: <20221213122121.18685-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <0cc89bf7-ea7c-d6e9-5ba9-548181de4c82@kernel.org>
References: <0cc89bf7-ea7c-d6e9-5ba9-548181de4c82@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0214.apcprd06.prod.outlook.com
 (2603:1096:4:68::22) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB5245:EE_
X-MS-Office365-Filtering-Correlation-Id: f112fc51-fc0d-49b8-486e-08dadd049016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: APSqAgdxebMa/2qMF5L4jP7UPREZFNy9VpTFsSeK3YLsGs9QeTfT5LxxwMgVjmc/eikaPv12RsPhY9U+HRykLdjpyQNRlM6+7QhjZWaAnypRsHmBOd3IN0wDlI419gOfuk4z5g0y/XemtZq3Mn4ILZEISoHdaIkDQbISRi/9wvVhSP5EP4nWZX3098uDGLAEk3RGkZVcLImlm/HcIvk3iZFRKWkwcX8DkYOoWIkTP5WSAaEJL6HCJ3NMQGAr/P1OioFUNt5vepP3lnOqDyAmtFZrTczDJnl4ZDxnOJGtde7O1EaM1WWwAZr1SVT/WXYvCsQRxLRA5w9OtnHgEXw463GT6lm0lHypNY3Rnl6243tZxcINLR90QTYAJlvPCAz5UZX6l9WkXiYB4lsjkToY5dLVy6L6ePJiiW85IJObzRapTBDFsxorlx7Dlt+trIz2rSS+PRrBnGjBf3xhkHGthQ5TeQGqJNrnJPkPUnZd3D+sCFyNA/Cjg6TRIf0NZiSFW9rfmvM4EYaUHXneqwAL0PxmqIyk96nU4QB4Rtxxo715mo+aaAsc8gcyGqDYok8vFk/Z0S3TS1e5/7UI1R1YXhpa8Vy9/4If5wGOYSIAhmudg3AFt0gpBTixEDtHib7dTytO4K5uFNEB4Rf+WfYyWEHBuclKjLLJ97mdmAytJQnswVTUCDw2/8BCgTIQvRbi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199015)(86362001)(6486002)(316002)(83380400001)(26005)(186003)(52116002)(6506007)(6512007)(2616005)(1076003)(2906002)(41300700001)(4744005)(8936002)(5660300002)(8676002)(66476007)(4326008)(38100700002)(38350700002)(66946007)(66556008)(478600001)(36756003)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H8a/rSQG3F2cn2T/BR20dYHmyIVbaTIwijA1OY64kKgl+NqgPZXU3o27czZw?=
 =?us-ascii?Q?SFyPfYwLrE3JMMdOXsoW3/zG9OC2qkBxATjXf2sJHiwYWrn9LUhHkiSoS6s5?=
 =?us-ascii?Q?L+nB7+Tbm4yrJat9k9ylFlgTB8WJ9fKEjRg7hVP1RMWyhb0xTgnxUt/qrS+E?=
 =?us-ascii?Q?ZLJAOHdNyQBfWzaJ+N322DewNi/DlhP85wO2nbchlr/H7AYd3vOl6IJW8a/z?=
 =?us-ascii?Q?FLt1Mft19Wuj6FxtEk7NsefUEUc4HyD36q4VZIU+wjphyjwteKdpuxqc/zzz?=
 =?us-ascii?Q?KCHS4YFqnISkFsmijbSpWK7RsMpnOZqHRVfuQ8tIUaXU3Pyh1fS8lxff/Hyv?=
 =?us-ascii?Q?JDnPEA/KPBfOimyGV0kdwcQQhRhcMsVQzBkLGOqhv1L9BYyr75tnW6HNtXsg?=
 =?us-ascii?Q?WmOG6hjCpMGyZyg99zVmN+U0cXIZcW8ohuRy7QdRIuec9rfjiG7bwnjMuZO/?=
 =?us-ascii?Q?rI/CN7PF9kfyVtiV6+B9OS51QWTgRYXYlS1Gs5SXZe1B1oJv9jz0oVFMrhN3?=
 =?us-ascii?Q?bt1PRu3ph7Am4DFGweJv8jsgKcOw+K5tJMvPJokr/8yD0yXwqD2IJkSEwwnF?=
 =?us-ascii?Q?unzNXeFR2tTSmQs4Cn3aMNrCp0haqL8rljCrn8CtIA4GzE5hHrgBr3edYf+L?=
 =?us-ascii?Q?qc0v5RRYQjW8Igze6PD87xQWDzmM0CzBhP81easVSjN3ibuJY0AGRS+WqcDf?=
 =?us-ascii?Q?CaMrMGQGGG6A6GrF/ydDgatVtONg8tlAAj/g+vaM5IsTGZrHQddVuhKWtiNR?=
 =?us-ascii?Q?suSJvz+72jHU66tligE6JYQfnTSOu9RRFR7rXh09efDHZJKNYCftKAx1TvfN?=
 =?us-ascii?Q?gu9QXs4w7BOhkKH/1jAZHPLV2EJKSMOCyPZ3mQ5fdcumTIenTUFKBvMERLcf?=
 =?us-ascii?Q?+Zv9wBWo81SP1uxfX9yW2T4CYoZkuuQOP1JGbSF7YHnm/f7gWptxcNDSwijS?=
 =?us-ascii?Q?TUhKmLpOEmHLYW6nDT3tygYArYAVoq8b6Q9SBkGJAREfS6t44a9mctUmj6IY?=
 =?us-ascii?Q?wypDhWkt6J9nV3CrzTEDn4oo13J/vA0SL/iwCV6EGZyawQcdui4rrBrgIhUC?=
 =?us-ascii?Q?bGz89AoNpVC5EbE255dn1NSedsZnsfi/NDc1N7H07Y7U6ykoAl7wNYc4EAfk?=
 =?us-ascii?Q?I1reylxB+8wgPoAllD/U1D2ZthARpeXdDHiXe2F5gY+FDXBaUH5FbKBNHt/7?=
 =?us-ascii?Q?+0n6Zh0DypERtHWAx0qqWK2zXbFzkA9PitKXamGIXhgESaRsDBRuaTkhW3LG?=
 =?us-ascii?Q?7zfcYhzcRum7oxW8w/EzO9G+OSvOnGG/S/bTt1pJ5FYtpEajRVcloLmPL1F/?=
 =?us-ascii?Q?WgFR3L9Gf7P11JrNGvxfoo/EQDJiroVP8CqN7vRPwBhgCE7LQY/Z62YPcpJs?=
 =?us-ascii?Q?G6vk8TnW5TmEZXJfDOyaYKkKWkdCXKFMbJGNhGs3FXNWf/ipFa8nYwV41kfj?=
 =?us-ascii?Q?4NBYsc8G0naB4e6NAlX3HwKJQ7/IqicPYaf75Tf9zy2Lzg6kQVsg9wSYjAUB?=
 =?us-ascii?Q?/KGWdvxb720IBNwTftq+KsHd6kPHmA5fGYMLRHBPU95wlwsBuAwQQvzBjZJD?=
 =?us-ascii?Q?qiLWUFpCVeByC8GS7zFdepAJgUjvbcp4yxEfmWW0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f112fc51-fc0d-49b8-486e-08dadd049016
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 12:21:29.5364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Ohkn4ewcq6dX1gdbqsDu514LRqoPO4Jay4R4fFx0RdO94dL/w7lb+8lvdpKswE6GO/hP5n7Za26IgMj2Bsk5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5245
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaegeuk,

>>> Again, w'd better to consider this functionality only when DEBUG_FS 
>>> is enabled.
>> 
>> BTW, why can't we use iostat to get the discard latencies?
> 
> Agreed.

Let me spend some time on this. So, I guess this patch can't catch up with the merge window.
And I still have some patches that have not been picked, can you take a look, hope they can
catch up with the window.

How long is the 6.2 merge window left and when will you send the f2fs 6.2 pull request?

Thx,
Yangtao
