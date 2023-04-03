Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997746D4505
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjDCM6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjDCM6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:58:01 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F219A1FF2;
        Mon,  3 Apr 2023 05:57:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYPkezwtZPM9nTX5zlrETvjmVbtyRQ2T6uRoK3Hvp6oIbYrRctOVhckkrt1IsVrB5Bh/Tl/mnEg//Co/UdUj0SEJCCrXrDjGm2ArKkMr/n5iiZuLCTJDsN7X4mh3DTMa02slLFTUEBmiC56sKS+ga9stTRs3W3LgeTV4Z3/faZLnIKB9vNxmq8zQ8FjrlUZxrD+dpArbqSSG5Q1SnIS8bTh2vUFgqN8qDBKOiHFwiYuRSrWYAYjIDtTi6Dk9fjCA+8OoZUSs1VVcbUkJTdW7XxhdFfPG3XriaCECWLlGOtTznJ7b2UKY5b5FpYwtQLebnHW6QDAMauC9anhzFb/P8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RnFsWBQfwyUc7cl6REaM799e0vK6USlYes4uivKgPk=;
 b=YJd5qjSGdprIozhAsJEDPwomz68QuTgfdqfF8fqnOSTcppusauN1CMZIvjZgGTemlmMPNdWdrGtte8JquScNOmuS7TUrii7QV3OUGhUQTolAY0Y3Kvc5laQFdkV8a+APOhtd8OECUwpxiNNbvU6o/ypGj8OMIWUJJHEITPGSlQ/uwaJYLFOKhgkggrbZkqNVOhS/FG9wG9qNMuYBXj9fxxqHIGi3PZseBK92OfpSdcTl26G8/hMZDK4aikH11COshaF05sgNjXh51gdHEPpgsA4U35NlFGQkx8Q2mwzJwACa1hkhAjEj8GGDgfWlB9tcKYCtT5g5OQqbv7rgJ+6kMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RnFsWBQfwyUc7cl6REaM799e0vK6USlYes4uivKgPk=;
 b=f38G6n6BdMdYtJE6WFI37wonlaX8dqiL3tulVSEiws3nLzSVSXv0cKs28aHI32Z6mwRlhstq/C9u483xVvFQ1y5oWpyewCNfZ3LC4FhWZSHIPc1fVJWR46aok9FETeARdQ6x9nGsM6N2kDjm1fYi22nYJHHQDtZVCwu9FJXSEio=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DU0PR08MB8787.eurprd08.prod.outlook.com (2603:10a6:10:476::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 12:57:54 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c445:c8e:be5d:d40e]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c445:c8e:be5d:d40e%7]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 12:57:54 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Uwe Kleine-g <u.kleine-koenig@pengutronix.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH 0/2] Input: st1232: wakeup in Suspend to idle
Date:   Mon,  3 Apr 2023 14:47:05 +0200
Message-Id: <20230403124707.102986-1-javier.carrasco@wolfvision.net>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0055.eurprd09.prod.outlook.com
 (2603:10a6:802:28::23) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DU0PR08MB8787:EE_
X-MS-Office365-Filtering-Correlation-Id: 8967b367-ee18-4632-6292-08db344309fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tg7Ol/nrmqVtmI47CiR1yYPgsnM/2rej2AmT9ZyhubJzUl2cSuXbXvJooWr5uuG3gvxW5ho1WPnGubHAY3zmBLm1En8arhh6cydrUhSwtSuzTDH+J4V6ayX3P1FRQ9jQ/7ItoaOvygVemI00/rX9bZQ2Ug1OtiIGxbcJJhJLi8U+Iw4asClcLcMv0IqCEP6Mfo7Z0RJGqrUFKFMm/19YfjmU13sfgvlRp7Jz03c1EZYvcL6c3Jbx+seEY630pIE/Xo12xr5ikwwU8vRrbTCEVM8jE/2wLzbZ0Ct0FFiJTHHUj4ucM/OgNN/UQTdteysunAwRfY3Vn0l8D/JbLxLtTqlDyzqSvoaHkQEFlm49pkz5yZkpevf+Ut2cFvC1HkqVjq77IU3D7A299yqix/pxsVTKcATZ3B2JzkWJr3sYU9tDyksC4ossxzwx4W7ZFf6kH+4dE5Zu1k+M1xZp2LmpBq5RgDDDNA8f/NVvWhu8UYk6vZQnssqC59QVEdJyzTwYnzUhH/I3eC9yMRP3ICHUkYpVE09Sf+mBnOC28s/0gt97OcuabBMK7LYXkP2BOVd4O/584RsJFYhsqsJzhMHAps6pegmi9vpakqowy2sKbyHffmAEOOsMqx9GoCt0QDIs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(366004)(39850400004)(451199021)(2616005)(83380400001)(186003)(52116002)(6486002)(6666004)(478600001)(316002)(107886003)(6512007)(6506007)(2906002)(1076003)(26005)(54906003)(5660300002)(44832011)(15650500001)(36756003)(38100700002)(38350700002)(66556008)(66946007)(66476007)(41300700001)(4326008)(86362001)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yzFGCJATbSIo2mA6AjU7A+qB3uCgSps86PnaguuZd+VvC7xIbentV4zCu84Q?=
 =?us-ascii?Q?PAA6Q6rvZU5KNhKqxK9o4Z/GNquuna2497sF9dF+c8aYMB8YRViWOCTU+waY?=
 =?us-ascii?Q?WH1Kq/eNfGl2V2OQyak50qlQF3YuAzI+oux2/SgfCBPE9BGE4gNPY70N/7yR?=
 =?us-ascii?Q?rbJQAVfZdzlg87VNrGFpKCTNJCTUyd0/LsBBgJ7syyz8qRbHjEvEzj2vc64D?=
 =?us-ascii?Q?taaXD3pJZKpH471hKHf9wMgG6bNKPcgqRygP4dJQIQit6S8pYfqPErFylC/s?=
 =?us-ascii?Q?7plgr61204zIfYI8s2YLG66QY1lqjXyPorLXyXancKWS2fGtS5jEJPnmSXbo?=
 =?us-ascii?Q?KKK4CmGMZmFnNbo3oMNmeBDa3WrnxE5sIBkAOtDiSgKWGlff+avY6+A9ucX2?=
 =?us-ascii?Q?q0NwEkwyxfOXFgKqYblRsq1zdWPiXCvd4DKeerT6NfPyZk/Hf9G6LE31BZ6G?=
 =?us-ascii?Q?K+mGI+vTkl4+okRVsSattu1wnFVuX5JNaipTqGhMLOgChZbrILLSFMq2paDE?=
 =?us-ascii?Q?CuFj/++vsE13GYuwsYz9FJBFmFmuryRUKueSgzT/R4dJJ1h/eSpwBXh3dF1L?=
 =?us-ascii?Q?RP2vWF6S2QoaoeGB+3FYyWIHFneHRSzADYc0jpWcPAhhr0KNg6RcIIWelyIq?=
 =?us-ascii?Q?unkMWt8JzBaeR4bc4FTOv3B/suY+Pfhh7nJVSkNjAbtoN3sFX+i9xbN5FLgy?=
 =?us-ascii?Q?DUvNQwui5buEoJ6Eqy6y28oOCes6qoYXTK3/sDGdwpLvBxFiRlP6zfLy8M6g?=
 =?us-ascii?Q?lh1A13TrHCZYYP6h9EtXyTMnQTydQON9LYMqCP8IR3wyzozi58M6Y4yV8ipA?=
 =?us-ascii?Q?dhgQ4caWTUN66tbNkgnP3rFyJM1rlYF2gcSsmPsnS/6aQh2EVYAW1tiZHAob?=
 =?us-ascii?Q?ErU+aPs2FtbUuz7xnlhV8ihwyJ4VmfpjEMIsOe16rihFRfUrR3HDRUvFjAts?=
 =?us-ascii?Q?Tr70zJ9OclJMuG4AmHS4K8RucUweZ9aGqek+kDEpHsxjH/tXU1+eq+C0sXbl?=
 =?us-ascii?Q?kvqNaWhZSnYau/zq1R6u0QJdTAdAOolJ/cklqVk2XV158bGNj1q48l3FnP1b?=
 =?us-ascii?Q?3IcQjyqQJlAaZXT/NazuCeLGEooDFCit2J1taBpOPglMh66UQDVANzMEHC1W?=
 =?us-ascii?Q?23Ng3jn7yrIOz6G+q0yJckF2YkRiVBx2Mt3/upQXJYYDSTtvlqgYRw3J3wIS?=
 =?us-ascii?Q?PmauHIwO1oKGnDWIBAl9VisHAtlWtKMa9RUd9TppQreQSXrmg5GaTzOjQdsJ?=
 =?us-ascii?Q?xf5VcJlrMBf999JYw8CuFDQ7WE45pVWaYCGIgRb9NC7vEIhCV2MXk1gAklf4?=
 =?us-ascii?Q?heoz2r7HWCLgEuyhe1kjZFvkRbYwj1J+lQcRJ2lLL0dfAx0EHBkdP4y5GfBr?=
 =?us-ascii?Q?G+rw8TNaFJ/5Et7wKY9bxwA/mpVAEpET0svoEjBKKg1NkAPDSfxBq6NtzDJP?=
 =?us-ascii?Q?KK71eC0goNFgYom3chrquRbYwQCkX4pUpTG6RcjgwlYezKpFcPlV4hloRPUV?=
 =?us-ascii?Q?xTIR0u7x7hQ3iSUbIWKYc7P9eAYyE1NV4TYDQz3qFTDhsH0lsEAk1Egg+ims?=
 =?us-ascii?Q?/GuUi03Zk4jy+81VrVQc9OOAhyFSNQt20QRyge8qkAXh/atNbougdNDBnZ0c?=
 =?us-ascii?Q?rRGeBZ9/n2cGWD+IvKy8lPg=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8967b367-ee18-4632-6292-08db344309fc
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 12:57:53.9461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jE9kgWJiYgtFJu8FjjsdkeOhV3mYOoeP2IK8xShwNmUc4EiU9gF1t4/Y3fZ9UQIM3yzoTD9IvUbOXbA4oK1p2228DpBhGSGYAEDa8Bh4BKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8787
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The st1232 touchscreen provides an interrupt line that can be configured
as a wakeup source, and currently it is possible to use this mechanism in
"Suspend to RAM" and "Hibernate" power states. 

Unfortunately, that does not work in "Suspend to idle" (freeze) because
the device driver disables the interrupts in its suspend callback.
Given that the interrupt handling prior to entering the mentioned power
state modes is managed by the power subsystem, the irq enabling/disabling
can be removed from the touchscreen driver, allowing the device to work
as a wakeup source in "Suspend to idle".

Given that the st1232 device driver does not reflect its wakeup events
in sysfs, this series also adds pm_wakeup_event to the interrupt
handler.

These changes have been successfully tested with an ST1624-N32C and a
Rockchip-based platform.

Javier Carrasco (2):
  Input: st1232 - remove enable/disable irq in resume/suspend callbacks
  Input: st1232 - add wake up event counting

 drivers/input/touchscreen/st1232.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

-- 
2.37.2

