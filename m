Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545726977FD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 09:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbjBOISy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 03:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjBOISw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 03:18:52 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C6E36442;
        Wed, 15 Feb 2023 00:18:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cP8NcHQkDsTa6JPVp7hp1qCQ80UIobeat5Dp+xUMo5OnRpJEVt++iw9LEJGfsxyCnKqsJ20MHcM+A901dfLzUL40/g+D9pLpU1KEEjD7milGmyI8Uh3cU2X5jOPFxf0ObDrXYbqTj0Tuq7KVlHJ+ewYhHHAEAJUCzBLJr3laUhwYBbJTJb2n5zly9xC3IhAjpvr6ndBuOc/fAI1r4va3GBziZN5NNrYk/YO0WddT0qGsKFG+WfE5siD0hpNnxvUZl9ZKpqfmLcCi+9xhq9dD2Kjvl0nOjlSZMKxF99NPt4TjM0M4YhjdkNULnFe5NzT+wNA9cl8LJG9oJq6mn08kCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26XsuSqVWnD0VcJfjKTw0QPDdMGxAvkJR93QAFngwOw=;
 b=RpNO/tAejC2LmG4gFTn8acLB2O9mtNEwapQFQ3yFwpALnkX3X3Vms8oXXMo+n39YAY696yYZxmAcmPpr2MQfACR65dcmiaSe1eKjJp0z9ngBAYkc3fwOdwLKD3NA8z5tvs13O5vNcGtYppxLLrQGWssb94yB7Fs0fUaQT94Y/+WhK5yScHBM2fBSPwbjkpyfFcf+WYnAZ9EDB31EMUBhqtIP6xDvsrUUBkHfeWULRrsgtRHe6noE0vC1l76TUyFwGgZ+HciWp6tOWXPsskaFqbKMAKF9pm4bSE2ZN44XA/usUVm4RBsfd4IfVyhmxvXLRm/vXQ8Gob9q6m8NMNzu7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26XsuSqVWnD0VcJfjKTw0QPDdMGxAvkJR93QAFngwOw=;
 b=KGuTeA8A7kpxjFEwcsvBOetz99NWlCIgXXWrdk1tU5n6qAHtDLAtKULRXHvUZK+NdPI7d1Kd/USN10Iw8WahcZt1xtz+Nx61QNLZSIHH/0onXRFuTijcypd7y/Nj1x+n2ewrgc5bMrTAIAr8VeHIzn/afRomHksZbAGboyme1Kw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by PR3PR08MB5706.eurprd08.prod.outlook.com (2603:10a6:102:80::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 08:18:48 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::93ad:a231:e2ea:d1b1]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::93ad:a231:e2ea:d1b1%5]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 08:18:48 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
To:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH v2 0/2] pcf85363: support for quartz-load-femtofarads
Date:   Wed, 15 Feb 2023 09:18:13 +0100
Message-Id: <20230215081815.3141776-1-javier.carrasco@wolfvision.net>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0161.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::18) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|PR3PR08MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: e496655a-294d-49f2-ec9e-08db0f2d4367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nZRLyQVqojz1DcF6Fte3Zc2esFizWjbzyfwWZ369Fv2D21uLVUkzWSoOjDTrAQptFhHcu4BNJ4NF7vKKOnVv+0AENZCOJ/fJAzfGAwQjaiovpOQVSZzSaBfriOAIAhrvp6eQPDLA50pxVoo53YMhKPom08EWM8Fl+JOuQOGuWmWvAk8tzsqoU0ELYhTJjtrIVVYkHQ3+TUL8LtNq/cWFyU+LaX8xJMmt/fv1+hubJIHwKdh9HadpNrgi0cAmlqUsEvcYYb/QwT7e4t698BeGHKIK6/5wTWpY5to7CJmRKqWjlXiM246RQByIEg4vK8sTKGjEeoLhRJDt1NlFbJCZ0JeHH8gV+bYgtIYwXeUzEHn5xtAqCR38kSdyteml86ZDrLvlLMNC9cFFnHW6dUym8jpYJAu2fTZhY0dxNVFn2b7c+FUdvXrzNQ802vBX1zV3dMchO+jEDfhgMXFi8mSvBD/RaK0OQImq7XSYOH3NmgacBFHIZ4Z7/n9GUaRpczyPNHJ5Ew+uW4EFmGdGN6bCkJrgD8kxXcjVHMehr6Pd5T3Gmp0O0glyDlalgWtH9yzAwqCl+w13a9QVMIqXYv6Zaaqfx8CFQNmNUc4E3gZt4ArB/vLB31GY8M9q4ShyXEoeCwlOjHisWjHXyy4u0GV5EKoc9KbF6BVI+lhiYN7Viy4EA6q5OOtBMebEXtDc4ejb3yvP/iQ46WAnG5ttg/SQfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(366004)(136003)(396003)(39850400004)(451199018)(83380400001)(316002)(54906003)(38100700002)(38350700002)(2906002)(5660300002)(36756003)(44832011)(86362001)(4326008)(8676002)(66946007)(66476007)(66556008)(8936002)(6666004)(107886003)(1076003)(2616005)(478600001)(6486002)(26005)(186003)(6512007)(6506007)(41300700001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l4J9GzU0HnbqFGxhojld/Ke9XPcAois3dmcmTBuY2+Fqd14ALKVOu0S+pfNw?=
 =?us-ascii?Q?Z4oMIJbQ4GJ6PRGe58SDsebAlm1XAYuehSbxsbrE1XRtmIEHgGI+h8rJaSWb?=
 =?us-ascii?Q?AbaJTdqw6ROKpbEK2iQ6hQ8StZQHtgJMb4jtWXti4UWuR5mqKVfnRDoC/lzM?=
 =?us-ascii?Q?z5tW7y9f/sWbyvNonVPDQnv96+yj/KPSNITSGKUIZ9fcAn0PRNWmRaP5knXR?=
 =?us-ascii?Q?oLO//Cz2EkMahEBDdkSTHY5ebjzaJwcHtuAFLnMTLLyGlXJ4aOYXHHUZc8i1?=
 =?us-ascii?Q?78W1ZjrvnFSD8i8cE4fMQFToBhYZuT0RaB6O5T67hyL21oQoBMjJ4PLD8jHO?=
 =?us-ascii?Q?44EPoPIqE+GFB83MU+RS87+Cm1LCol5RntUvs+pfHq84Y17uu6TY1KR3Pgiy?=
 =?us-ascii?Q?WB0hi9YbNheS04DYSpjDKTAoSbyxhdSxq80ix7yW9Qn7BQ4/Cp7JVNxMrbpj?=
 =?us-ascii?Q?HKcEOFESlg1nK/rAZWVk7ufyZLRJs4ROvOmIs3lZC73gc/nElilguRMdSRZy?=
 =?us-ascii?Q?JltIzcxdtksZO4V8qTT37i/UnHKZXFJO34KJcYA4a20IJYVT3CgE7FnrZV84?=
 =?us-ascii?Q?dMIBxAQWQ7rMT0mxMogsHHGzhPpri66ibTCayoQSHUysusm80s+BLLVgItld?=
 =?us-ascii?Q?TepT33lksHVr3RvKF1iZQGgNBWi5q8UZIrQC3axJb/VoFUYqurXjyaSmlZxL?=
 =?us-ascii?Q?mkDcVmtXYMp2/n3iCrqjVqr7D/jfU5PK36kSoxnJun442RbSbKSLwXj/FaUy?=
 =?us-ascii?Q?4si6hYOdGnAvxenKLbV5lm5FIjwEnas0d4Jqcj28PwFU3YHmvFNtyw85ZeOb?=
 =?us-ascii?Q?RM/NCpG6qnebdBgxXHm6I9PNcEdvYC70dMINBv9u+O6axHStgvDPivrPoR1m?=
 =?us-ascii?Q?Zg0BN3NAgPxzu42di3h2dK/+FnCjIgHpOmYHB1g8HibLu0ZNdcUOpyM58klO?=
 =?us-ascii?Q?5vixWTF2XdScT3WDfj8miqdceQZSRZnEicF4Me5llQx36Cu8dwVw4GFPau2a?=
 =?us-ascii?Q?utjCfNFO9QCT4q+F6kCPl6Nd+xSfK0Gfzs6LJvxKCuCduV+eIhAOFDgIoibY?=
 =?us-ascii?Q?Nl6xYmF976f4A0s65qA9nRdxiTBG48TGKIz7gzAAYk6PdAjgjslq6TXEjq1o?=
 =?us-ascii?Q?6T/LSCFoupfgHq0fKgZaR7pkGVZEgy5QjuP5RswFIT1KRR+R6KlM4N0Rx9V4?=
 =?us-ascii?Q?+67bl1q+BW/meL0hgQJafFSFyHnzXL315paUi4zy2DJVFqTmb4AF+pRx9Igf?=
 =?us-ascii?Q?O5GAfuIgrO51Ane+MU6zn3FDtVlNJw0Otsq4Pwd+mshQV/xqHJumwRxlFIN6?=
 =?us-ascii?Q?d6PuZDUBLSt699rFq0XkBwZWTP/WIiH+L/aLOPEHoK5wmux6AeOU0QOgESCa?=
 =?us-ascii?Q?ZqaKsNYPshbR8Cee+T/ru5UDJDOZPYGzA950bP1iDvIc/BaVkYicrRdCMmYA?=
 =?us-ascii?Q?I+tptvH0w4HGz7RMdTVvoIfAzVpalkUGoWRsBJBfuDsBYYboWXVI8O6LAcwG?=
 =?us-ascii?Q?gsV7+dlkJ5RIWZiOpbzGCXBZ2ilIyk2vlgIK22ZufHnN+wSsB2zi2iNb18T0?=
 =?us-ascii?Q?4Yse3OurDZUGMAT+5gYRSDW8hBN8ve568xkv69b6CIWkEFbLVjUHwXwa41kd?=
 =?us-ascii?Q?ZCj6rto4X1CwE7jq0tQ2iLI=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e496655a-294d-49f2-ec9e-08db0f2d4367
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 08:18:48.3604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VPXfea0IcKCvBFLcQlScI8hGNy0yD+G6ZXj2qd6iqVxcAcVV1ZPZdeqUVvjIWnvZVC/Gq0XveqwaHdmcMIraruqnFIoxeK9e2ya4GU5IulY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5706
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add support for the quartz-load-femtofarads property in
the pcf85363 device driver and new bindings for the pcf85263 and
pcf85363 Real Time Clocks.

The driver has been tested with a PCF85263ATT RTC and a CTS3-32.768-12.5-20
oscillator that needs a 12.5 pF load capacitor. With no property
support the 7 pF default value leads to at least 2 Hz output frequency
deviations, while setting the right value the deviation decreased to
0.15 Hz. These measurements were made with a high precision oscilloscope
(SIGLENT SDS5104X).

This modification does not affect existing designs where the
quartz-load-femtofarads is not defined because in that case the default
value is used.

Javier Carrasco (2):
  dt-bindings: rtc: nxp,pcf8563: move pcf85263/pcf85363 to a dedicated
    binding
  rtc: pcf85363: add support for the quartz-load-femtofarads property

 .../devicetree/bindings/rtc/nxp,pcf85363.yaml | 60 +++++++++++++++++++
 .../devicetree/bindings/rtc/nxp,pcf8563.yaml  |  2 -
 drivers/rtc/rtc-pcf85363.c                    | 37 +++++++++++-
 3 files changed, 96 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf85363.yaml

-- 
2.37.2

