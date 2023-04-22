Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0696EB919
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 14:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjDVMOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 08:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjDVMOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 08:14:32 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2100.outbound.protection.outlook.com [40.92.98.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E190D11C;
        Sat, 22 Apr 2023 05:14:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZe/V6+CgskWCot6AdHkrsg+gfUaOCWS2Rsvj4JgfyFh26o54ojl9iKZ5NwzKwq0ZpOzAcGmc8YcW5fE1yNNb9CJvm6ET8F5ss9jVk15y/TQKo2KiCFG1HjyUwPXdVG461YZBgUBGXc4ChL6EVN0yUJpZeJLXEhmTEGyJIInOncBnCA+qtf209AhDprj846NpKKtzVaTM5Ybf1O0EaieIa3GTVbZaBdS6ShiX9EfUCJz3/StYqCmPbNKMwaSDAcFwup+7rJ7ImZQ5WtMkgirNDjRWtkSg2XT9fFuVQ0yHcPrmbR6CkkSmHl5+aJUoecMorJN69pWE/6cOXATs4VmyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bhv11105JkCRFR7jdWpd+JFv2KjOxonFqQ8aQMaay0M=;
 b=ZxsdjCKI0Gd2QCQesvJVxDZqBTVMXX7uRXmxDw7cHN8NBzuNmZ6j6UxvDj3lbs2Er3oM9XlAYQv+/vPPvrbt9ikC/iOvH+5hTeifOyBDhOg/MUJLy0GgAHEMXy/d6+A7ssfB/+scotyeGjCy1O3lpFTA4aeZTVZ3nptfQyQFVQyvnw6IOQtwTVa3xBH58Wp+9dYGo3E6TApnFazPMkp51WsvCaN8DcbeMaAeOpcuRpj6GzSjRJCbWB1yd62F3n2nsDsX0L7kkX6cCYsSKn80RIse8RsMlNibL0E9tTZAK8guacYPP4Jt+/hF1pbLHhzmGUe2b59E5BQZudLRwc/juQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bhv11105JkCRFR7jdWpd+JFv2KjOxonFqQ8aQMaay0M=;
 b=MiMaJYSNYVyAD+4c/nZmCDsKSgUtjpj4YP3YqeqvhUu6uIL1u0J6SdaDJdq7BDMpcjeHVgCXMMikLSHlkhoFRC57HQglvbywGyYoRKK/2AO5akMYX0idENfSRcTtqayCiL6x/Rzi63ztR/jrqT6PAGIXd5mp9kDtYRuSBSzoenmy3KlquNKWEmyCsLacYec2AcuHDS+29Kkt45z5Hcn8M4LiKyS/x2sDKiOb3HQLRRS7FaCDUjUjD8d01S4StOVowF+5FsWNU8LDqKYAMS2jHUkHy8tCUsafeIjcM34HH9Gtu/W+X/X859oPW6eWaRHge8wWXqpKtXI/45jdtzbs4Q==
Received: from OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:d9::7) by
 TYCP286MB3395.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2ba::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22; Sat, 22 Apr 2023 12:14:25 +0000
Received: from OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4ac1:a1e6:7a7:f317]) by OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4ac1:a1e6:7a7:f317%5]) with mapi id 15.20.6319.028; Sat, 22 Apr 2023
 12:14:25 +0000
From:   Yahu Gao <yahu.gao@outlook.com>
To:     dlemoal@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        yahu.gao@outlook.com
Subject: [PATCH v2] ata: libata-core: Simplies if condition
Date:   Sat, 22 Apr 2023 20:14:14 +0800
Message-ID: <OS3P286MB0632FC8C1783241084E41BB79E619@OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [juSP09TLKLCCIr2zkCSVkZgiJBBmVoRe]
X-ClientProxiedBy: SG2PR02CA0087.apcprd02.prod.outlook.com
 (2603:1096:4:90::27) To OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:d9::7)
X-Microsoft-Original-Message-ID: <20230422121415.6276-1-yahu.gao@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0632:EE_|TYCP286MB3395:EE_
X-MS-Office365-Filtering-Correlation-Id: 650d2ef1-4f00-41bc-a993-08db432b1d2a
X-MS-Exchange-SLBlob-MailProps: zZTkHIKWWP8vWxCysbaqpqe0iiXLBw0ds9rgdnHBgu2CH2nKqRZwhymjBE8xtA/q2eKnOPbJQW3SacZg4hHJBmBpGO8IG8CplXUQ62R9Egx7d1SyUMPBHTXeM3gQUG+sC/vr9tM3ZvGqxqVbnNdKMdpaP8+UTKa6hZHCY2DeqqT+b6n32Ny7CKR+2GVaa0ok/ZMT6LesKLR/4OByzB6S8/1syAhL9Xlw5lSOmUfVQ+sBbLt0gdfgI5xHZvkxgucdVgPR32tmRnl3pUsXvKfquiOU9PJg5lVBjM3BFekQ2GsHZFbIydTrRdoxKde867Iaao7wO1Op16+KGWoyB91yl3hxGB1sK0e5pI21tJNEJ/e0oYo4Hew7UWvisTSfSYYTr1yhDwW2lOJJFSHw2Rxf/1gBVymxGjPamQcVspOjR7K3vMxkZEZ1ZWDm8XisB1Ydd3qBppYIGfl+p/IV9c3LlG2W1ETjl2notQK/+cVjo5MnLNjv/mSb8Vfym+vkv7iZ4pNN2RMxU7Nu0Z5hyoddPcRrn2AoLvqouWspqjwwBRZ2Fgw9ALzM0ZDDE8m4EnupnZ76pm4QFiIJzASpm5VJSLxL48Gi1MQDwsH8NuVyuCQkpdHO4oi94dSWOSGT/aKOCOj/huk3X/FPSTRdolBoxW5jqXi2n7FkKz8kOVi1QnDcnisQbHBvLw==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ZjNsA89vn+j6xwZ12EFYF+PcNtM/yplWb07fRQUS7SQ63rnFF+oDk9kC/GTzbYCx0a+3IB00FD7hx6f1oPKyUsP6/O4kPGB1k2gzcUfFV+j0nKTRR5ei1NPm3UCaf7deGzfZHfogUqu1VAUsi+lO0c4h5VPdJdSOCW0YepVFhBGn6CmGar6Tea8M0lD3fTAV4e1xgEKh5tMoWq8sPV7GQDEf0v+HiJmYbIKQNgc+9SVedGurR9M5nzLBgthSNym6j+fgPz2wlGAEZU7zZKhBCMwSAIJsyfPlGuDrRIcIjAuDYSFHpIZGEX4XApEozqf+ElruPUyuz5G7nJ2qFoTmuT+kS80I3UR7arY22xEE6MU7F3lneO7aMtPMkZguKAUCJk4ds78epaZH0pT7stln3fVjvtht0+UsB/PHenjV+Qf6VbI+mwtS23V4NOD7I/3VndOzGn+DA+wEaZVqfWYA1otWglHsO+FWTZNQD3qcBFmodLr2ruxeKd5xUOKfEU+6C272Ytu9TeKEOMnaVRhM+FDgSOam20iWGkkWS4EjCq69LEYhGwGxaddfiURmXkejpwy//Iwe+jhSVroIrtQIh2jxnS0h6Uj+CUrwyshOMyYFOejdI06Q6D8+IQ+Bwl9
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fTp8mW3nRFC5miEZqRTnx+YoDs+NXp4PBYjm5gIfHLBP0Bi0fQzIi5ef9zuL?=
 =?us-ascii?Q?8YUBrFG3Wrc503krEYtA7WbGtmZ4S4Xv6uhf+D1j1VwYbN9wtdZoKtDPPJ/a?=
 =?us-ascii?Q?nj2C5RjGZGWXYx3N7zRcaDsSZHL2r2ZvrwaJMmLvSvLPb6OlPTeQpo+JmcnG?=
 =?us-ascii?Q?GOIiTkaVn+lm1pEk/j3hupaq8QWPf/fngrduPouRWYPeiWG0xzw4o6ouBmP4?=
 =?us-ascii?Q?I4p/GU92LYZFHOY1QBwUBOAD6CFKxc/pmRhAUFh/y3FrfFQXEAtRJYHCdcqM?=
 =?us-ascii?Q?4fRsNK7wxhcqO39GkF0ZKRTmLI+kseg8DBg8P9ie6z3xOtebXKHE+BXxDcG/?=
 =?us-ascii?Q?z0XwmdCct4HBghVWgz+4VC0lD2jkZANtTWyCcXD/6+d+t3zGDw31QJvJoFm0?=
 =?us-ascii?Q?XDEOHRgzZDDMqAilySRHevLSjxI6usFe80cfwKU9RW7ZYRsdND4KXRKGM4ij?=
 =?us-ascii?Q?Y5XZxQyKl0dc+nxnZ/l9ID+7CVJIrOMgMktFIsWKd11qn9dctuVV6U2UedwF?=
 =?us-ascii?Q?GiDYc9x0zYJwXA4Y9wowGcZV9Vz3cBGwQm4JqNZ1BS4HdIgyUayM3v7qq17U?=
 =?us-ascii?Q?alg75cp3BnwerdcBgA5iPQNCpLItX3C4pqVu8xkuJPP0suG3nPlBZYeC7Bno?=
 =?us-ascii?Q?B1gk627NP8TM4huaq8eelRC0cYjvzdEsFXWpeJW8lkGW0cI+AGoBxYApM8jl?=
 =?us-ascii?Q?S8zqpyP96y0EyY9304N9bSXLTFPNACInTAdko812+pJoDkvcFJ6Ym6MgEn1S?=
 =?us-ascii?Q?8Rs3SbUxqVlsb7Avo4C0kdiIJ/vZWcFlQl9bnzozwlC9A1MzL/wko0rSK6Nh?=
 =?us-ascii?Q?zkM0wJJprhfV0nLCGkOLy+TPagIxX32bai25UHYDxP4qMp+e862gzFhbRqR6?=
 =?us-ascii?Q?ZDyJRUCvxhXroSgK855UfwO++thD/tWCvw14DavKCaHXT4ZafOCW7Th7xrnC?=
 =?us-ascii?Q?Vm9csb7prsbku29RQAfvCiVFodqhxh6cS4AWb/C3iNQw67Ddyl6EifoGK2eX?=
 =?us-ascii?Q?RHbvr7iVJcutKz4hDh+Dk+AkzYgRpcZHuSUaZCqEZRAf8i/4hDVQtl22UwiY?=
 =?us-ascii?Q?vjRXfzyECnYoBLgmvp27ct4+RBFGJktAhUIRtil4J1IhTyKA/9hbYX9QzaPY?=
 =?us-ascii?Q?pN0lOjV/fCakvSKRhsIhRjAiWl9QNsXZLbDAq6paXovuF2apQqFyrRy8vtcE?=
 =?us-ascii?Q?3+PZOmJ8rEMkRsKSaaBVna2zS+og8BY4Mc/49w=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 650d2ef1-4f00-41bc-a993-08db432b1d2a
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 12:14:25.8114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3395
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes V1->V2:
  Update the patch title.
