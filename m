Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF03873DE5B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjFZMAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjFZMAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:00:30 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2109.outbound.protection.outlook.com [40.107.215.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F66DE52
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 05:00:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Teht7YiioCzjKyg1DdJyXCUmUAHxijNEuAU9i4vOiDZfdcRm8gA7bQzGIbcZvXLYGHXLt7Dv5S5u/VXKygeHCO4iPPvWGA5xUd3N7eyKvFjO28kMbQc8Y/+S2dKQyvyEkgq+FI2WA567DWYTFGk1/WoPaA3Kcc4Obp4Vks4M/GqFbZE6I/6hHQyqH1qH/Ldi0n86N3JmfmLPt51NvLEe8+EcDpEInFohTzOVJX6hW4+++p6/jC5hXQFzJVh5+xshX4zf3zOsBjdeSiKeJogVKnbSvT5jkeoQ+6a6za7PqIeI0wKnq6aZ+SU7WmPbpmI+G5QbtnAMhR+uTtE31thQVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZyTuPgkmUcByTjC/ScUClvlm8OL8REf4meiejdlEQo=;
 b=YeNRFZZd+IgM1fTvGoEjBdoOsOUaYXlUwEUya1arh3lafzvGT9cKjjxxnlvZsK2gAqbsms8osx5L5ZDWpI3tdRmHWG8WGHxjbdZ+61wwUuCUIyS7Ewyn2oyRUhDHYvixoZeEAa9vXbA5wRjNoVkRS/XjEIn/TEY98kmozqwPh19k76RfR7QvSClYpn3jrQEEZPtttXUVk+pK2id2pYOoeDzcTfdG/gYNB6LyvtwUqyWp4MuaSg4HzVi00ooptelwfK2q+9fOAOMMb3biWjG/EPOKc2O37v9bhkpDVN2QVF96vmZZC78KM+IfsvCx0IQcucW9sM07TnmW2ueWRCHB3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZyTuPgkmUcByTjC/ScUClvlm8OL8REf4meiejdlEQo=;
 b=kMoo5UD6Myt7O4FXT6nwk/giqU1RjCcvZtfcCv3ur4yYyqgsXFDMT0XbFpxqIxmdUIUsaKcMEXFgtGkGEQMqj25SJIZDPrRuotlcr9j9AetdL5ePMOKHi3BAUMlPcG14sILxVmatQGnSA7GCznZzeZXwfthjn/EXydr2BYMwc+Y58Rz26kZmSEx6Y0Md6J616YfdjXEqPVKukEBORdN7VeiSE9sggKgI5WGoYGw5lzesTpAdJ+y+Gm2l9ftgW5QE6lgVfzf8qc1WUqbNx1Hc5yGtTIfHEE2hKYGwkKhuzgRsExTxU8R1VKyTIAgHoc6ZWjD4i5GScRjgvUouhGGR7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com (2603:1096:301:11d::13)
 by SEYPR06MB6754.apcprd06.prod.outlook.com (2603:1096:101:174::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 12:00:23 +0000
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::adc0:c22:ffae:227b]) by PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::adc0:c22:ffae:227b%6]) with mapi id 15.20.6500.045; Mon, 26 Jun 2023
 12:00:23 +0000
From:   You Kangren <youkangren@vivo.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org (open list:POSIX CLOCKS and TIMERS)
Cc:     opensource.kernel@vivo.com, youkangren@vivo.com
Subject: [PATCH] posix-timers: Release the acquired lock before returning
Date:   Mon, 26 Jun 2023 20:00:17 +0800
Message-Id: <20230626120017.3030-1-youkangren@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:404:56::24) To PUZPR06MB5936.apcprd06.prod.outlook.com
 (2603:1096:301:11d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5936:EE_|SEYPR06MB6754:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c606663-c699-4dab-9c73-08db763ceba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lbMMuYf9qkQY8FX/egJ5axQC+cfTVZTXmpB0ORPAJFTc2uGlY6TIZyNtBlyaxVMryr7Vq+r0O64qn03+7IK21SCwpQvnUeYc3swVfxVaEzLGN0SwW54Q53BDNR6ZsBtihnDLR5pJJhdoElHiNh3W3p0eJ/tc3VnyaoJSEyBFajd7i9FztG9FW2fh3Ab1lt94ANNtObwBuVMQvJeEGqDQVCGnWo8KvMcTcyo+gKPMejQgPeMhzAmSgoM5BJzjqQVkEG5make7cNwBr1DCQ4dbOquU0KQD++u0CL2RGcuwJUxmHeiA4u22K3yHeGKSmoGfX+WIaFyGECby8CCcVuQqVZH71dyHB7+S2ISrDXw1NpheYGGIxzUbldtM5LO5OnbGi5cY8kXMQFsVDHRPpoGYdzDWXd96ATC68w6PczNJo53FpcIUq5blvWta5gk35Q+mDhr1d5yFi4ns+r1Smqw64b828l8RL6LVsiq0vkduD+0dBrv4bz9t2Z+KICgDXoP7gjvhEFdJt45r7D3hq9d80s2PMBcwFzT9wSDLzlPb6R43nqkqTyXers3kNqSPHuO6UyfF8Zr8zNcFHMmLs1O2BJvc4EHgDJy/ukmRypE6FVLplC02r3UyFc92w/O14908
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5936.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199021)(2906002)(6486002)(52116002)(6666004)(38100700002)(38350700002)(107886003)(2616005)(83380400001)(6512007)(6506007)(1076003)(186003)(26005)(41300700001)(86362001)(478600001)(66946007)(66556008)(66476007)(316002)(4326008)(8936002)(8676002)(5660300002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8SO7/3sKMdoTyaEh+4smMYYAy8+9WQtjpV6V3XXlIk0JmTfyj8P2seZBhxae?=
 =?us-ascii?Q?XF5Ckb65NsfT8yQ0apHB1B3DzaWQizISOAjKBW9Q7+efH7KUf2c0HW++xjbh?=
 =?us-ascii?Q?0268ol1PH/+jDGXkcwcmg0ZySaJVNGhxm5vbPBEVyTHKDJr+FU60TRcdH/jJ?=
 =?us-ascii?Q?MBCnu/cONN49KeD9i+ysaSPm8UYvF0TeCJwciABvW2oRIk65UzQvVWiGYvyS?=
 =?us-ascii?Q?iHWTyPim2F7o8FyQqhrJL2H3mRP3wrnrJtJUXTV7F0Livb6tGgTEINN1v1aS?=
 =?us-ascii?Q?dazqJpLFrCLCxEiFt/SnU8aQTpi5OPIdiY5NBlE9YMgYPhxPuCPWxa6iZnwJ?=
 =?us-ascii?Q?2QLiw49WZ/C/M3vXi8Tg2elBPxMP5+9oSzK/WskTvvFsN/7Tkk8JIEZ7CI5/?=
 =?us-ascii?Q?CZr8GkpTwD2RrpWpgAhVfdY9sVrBNdFixXg7Tl4RG2ctrQ2vIMYDP6ZB5yuS?=
 =?us-ascii?Q?kFx6JLzU+SuUItaxEC0ssEYZJ24c9gJ/0Zt+29S0Ld+5yId7vJOdubSvU6Vr?=
 =?us-ascii?Q?Ief5QStLwC7JzSI7PJ22yiQ80h0WtfhvwKcGz1LNS4uJYGbBlLQ7FeRZVTPw?=
 =?us-ascii?Q?KjhueboKnDKcGFimXPCHS9dms/qoREvQ9eNxII+iHvfPUsjJrAqmcSy83ScX?=
 =?us-ascii?Q?gEBgHpH3n3Dcc87siorzVOntJ5T6nT6nT4ze6gDEl46at0ouSqxin44YbA8k?=
 =?us-ascii?Q?fgJxXiMr327k19f/N062+FY0xfkT/Ci/8LF3/NKSG+hzoQEaZ3G47DMsZbLx?=
 =?us-ascii?Q?r8t7HbuyszAq4OBomu70uB+adoU0WASoisNiqpD5srG8fGVJXupOjBrgEl+f?=
 =?us-ascii?Q?o5uL8oORm+bsicCqGxv0oFt8X5wc4Kf3By/OyjWiswAWDW/aX/y4cP+S2pXY?=
 =?us-ascii?Q?WYxRNL622/PM1KSuXi1UK6MFhMG+HY7F/fXy0FDe/TdclPAGj0/bHF2MHsbt?=
 =?us-ascii?Q?MRNerOm363PD4vpX49KLEl7f9xQuLnxue5gjX/iitIOc5xG8BuYu+yC8dE7Y?=
 =?us-ascii?Q?6I5cilf4bpq5HbsjTaFIUFy63SjnsGZF9oPxJ3y6Ru+opJYlWu3jq7ZMGI0r?=
 =?us-ascii?Q?JBsURAYQAxaCnlROts1ki6bp+FPGhz+zxvmKlsANyqBSTl987/zlLKGk1KmN?=
 =?us-ascii?Q?JYDakK9s3mpayWcwynNorBXqsUsWPDa3CkIUUyViwD+vG0A+ts7tTOqw1mJb?=
 =?us-ascii?Q?nl5oTQapQTkM1lczOB7YK/GIk1Po26vISnHUTP+trFIY15H6+sX1q+7TDJFn?=
 =?us-ascii?Q?8iU6tHPoe2rjtaBW24u6eW6JZdWZ0gaeoYaa9hFsHe9tzA8X2aH1CYza83ZR?=
 =?us-ascii?Q?1NX78L4PaJlx4Jd++jxc/BXZqdSXLwZbfmLbKEBZnPBUc1RXESZwf7zeoMP8?=
 =?us-ascii?Q?jQJJY9GptzGGmXUIyGMW39xwM98b/MmSiRnsztYm8Bj18fzDcQDVy85O8TPn?=
 =?us-ascii?Q?iSvQxb1TX5MdJbmJwcKPTG1q1uKIFYmMbjZb8SLj8jm32wsqY90FVGRzX9P7?=
 =?us-ascii?Q?1yG8OSc+4LGRINxcHgFIyngtz0JS0DvcYny950XPDqxAFnf5JlS/zREpsOIT?=
 =?us-ascii?Q?4S46JfLDO4EFNdhxRayjLXEPe9vwKx1zLQzLSG0a?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c606663-c699-4dab-9c73-08db763ceba7
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5936.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 12:00:22.9188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: beK8cuVTVPR+DFy5zfPjV4UHnTqy0OWpi+RXkeWRwLrcAqAbHlhtl0R87Zi/T1K5IAu0QmYJMBGyKMD++7fENQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6754
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Release the acquired lock before returning to prevent errors

Signed-off-by: You Kangren <youkangren@vivo.com>
---
 kernel/time/posix-timers.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index b924f0f096fa..8ab383cba0af 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -599,6 +599,7 @@ static struct k_itimer *__lock_timer(timer_t timer_id, unsigned long *flags)
 		 */
 		if (timr->it_signal == current->signal) {
 			rcu_read_unlock();
+			spin_unlock_irqrestore(&timr->it_lock, *flags);
 			return timr;
 		}
 		spin_unlock_irqrestore(&timr->it_lock, *flags);
@@ -1066,9 +1067,10 @@ static void itimer_delete(struct k_itimer *timer)
 		 * do_exit() only for the last thread of the thread group.
 		 * So no other task can access and delete that timer.
 		 */
-		if (WARN_ON_ONCE(timer_wait_running(timer, &flags) != timer))
+		if (WARN_ON_ONCE(timer_wait_running(timer, &flags) != timer)) {
+			spin_unlock_irqrestore(&timer->it_lock, flags);
 			return;
-
+		}
 		goto retry_delete;
 	}
 	list_del(&timer->list);
-- 
2.39.0

