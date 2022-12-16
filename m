Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C433D64F1D6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 20:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiLPTdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 14:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLPTdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 14:33:04 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2103.outbound.protection.outlook.com [40.107.255.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B8F2251C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:33:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKRiAZOTpC/N+Awibn2YzzG/dTV0OAgcfUePOFhSh7oDFV63fGxE16GDx9SC7r4pFKEP35TXPMHnIJzfVHfnaZ9G8OKTDFIX6ssIA5tAh3KwPWlYj+SE6BS371//3OZ/S6cZBIKAJnGmeLUHo7eenSGSkLKuy9vMMA8Dzgi3c789obXFS86bf4Fv8JUQOgu+3QShfgErZj7QI2w7Yc3oqWy1yXTpmwmoWqsnMMosDzf9/GmhfiuFH6bQpikJs3M5N/A4o1Nr3yfwaArCPaAWOivSE3pey48dcyqt+3uddMTo9JiAT7yBG9Fk+oBRnTFY1Zqlkd0jVWlZ+mKGxP9ERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/9WZav7ZU957WNBB3ibkb0M+GQK4mTSrY1WJh8+is4=;
 b=TiJDPHpgSnQXbqfDtmG7NvDIsDwzxvh3Nx1Izy8dYDL1q4KCUbU5kz3hjFP0yBuxvUmmP5LBOAzPWNHHkqvS+waiiAM5uRsf6+64oib52P7/rX+mWmXF+h4TiABvDiGVn7An7Z9nenr62t43MlBhWBeeM+nJRfxmojCK1bUlmFIpR6+yIkE6f3ym0pSlhidlwz9abL0y83DzODRiKGUbBJdqRypxGw93uZtmujIxzBANZQzEzXlxvhat21HgilS5JL9qz/ls+9ip4J2S6vgluVbTYk0tQzk5mYn4CDRv85XFSJ8hfU46xECQ12fvzW+YS7odwJ/+N4ez9kK5SNV3gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/9WZav7ZU957WNBB3ibkb0M+GQK4mTSrY1WJh8+is4=;
 b=ltdBw9pXFfK/MRBfwvSaaircq+p6JVAUwvG9LNSLCRBX5h4dpiR4D7a3+dO+gQmrrX9+9GSDjYFztad9hHGCLdca6o3A37p61G9Tp/RQffT4E52m/93uZzTOTJKKsxJQR0Rg6MN5Y7NIoWjOV9GdBKKUNn+ZbhPpUGmazwBPUuB9nZqTG6wpN7gJpu/0xoRClYOxmnQvauDfizy00v+HmmxX1F0RQ4GQw3DYwUPUsXGiv5TkWY6OTPcqZxIBuYsi9KYqFuvjspJwRJhLNy/N2neIf7VLxmq9+YjMhwb9Ie1EiquUp55pz8WaNV7nUeCHs1zn7yO67QEKQ8YK50Rh+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5243.apcprd06.prod.outlook.com (2603:1096:4:1e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Fri, 16 Dec
 2022 19:32:57 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b%9]) with mapi id 15.20.5924.011; Fri, 16 Dec 2022
 19:32:57 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: merge f2fs_show_injection_info() into time_to_inject()
Date:   Sat, 17 Dec 2022 03:32:48 +0800
Message-Id: <20221216193248.71333-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <a2c286e1-470f-ff83-196a-f7ea490096ff@kernel.org>
References: <a2c286e1-470f-ff83-196a-f7ea490096ff@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0103.apcprd02.prod.outlook.com
 (2603:1096:4:92::19) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB5243:EE_
X-MS-Office365-Filtering-Correlation-Id: 95514d97-69cb-4e2f-b98c-08dadf9c55a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o89ytYmCilWlPx4Hs1h8D+s2IXMQaCJfmdheJT4RVT6JUHALgQEWoWV2cPnP9m8hynLZNa/zWDJIczHvkDC9+RrmWEWpgezfMTbEmo9RGkfOZ3CeAzIGjEG8h5LQwItbhDbtkzg5W+4FZFqvLT46PqmOJqdZJtXzr8kxqGAmp5v4XkVfipOlrESlKkJFNnsQeYpF12Xqq+G8zHi7+RTRa3UlmQPcv01u+61by0REZGkXDB2HTYIFNjmvoaPy57BiVBnVCw9p5Dw86JtKrBv70GQv7ih5e/qZkisJ4Xat9Rucf9oOiEn0xb3W4AJvfuRr43aJ+nJXBkuAxOB6YXVwelm8oMJ8lCPRVzasJSxRPPs/BuA8tEt4X5A3hMbyySr676cr2BkcAc0TSVQ7JZmnACdhDn6DC+iLYPJgh3p01BsgBkG48CjFxCd2TQnw2ze8yq1LRvetL1AjmcWHmSo5ZKICkDfKjZIHLks0kLm1ijkfql3wIwnZn2ChmD86CQUXDAC6vxk/OObUVbS92gx9o1vzGf84cGyXuo/Jbkar37EC9uYMyj4khaeQriBUJxcBTgRGt+EvsnYWG1SZo0BaaAxAkcNAyvYjse1+bKPMoHljCUfVVlzWaYyVSO4dlqeiIPD2CI++TsKrvopLO+OzvghwWf4fsSgw5xJj+oisi6FsUPUaI7r73yA7dJBzfgi1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199015)(8936002)(6666004)(86362001)(478600001)(41300700001)(36756003)(186003)(66946007)(2616005)(1076003)(6512007)(8676002)(66476007)(4326008)(66556008)(316002)(5660300002)(6506007)(6486002)(52116002)(26005)(2906002)(83380400001)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uCLvDdsa0w9sIW7JrAUpUtMyg9aLmzqnM0n7G3rIZBJE1SeWz3hnhpQ7cHWH?=
 =?us-ascii?Q?DtjX8Eh7VVzQitCC0odN9mWD3v9vjxEQTWTtRX59CLWLQ9CaunNc8cK0LUnf?=
 =?us-ascii?Q?UZEBRla+6EyAVXA8VV3Ipa3Mg8fN2RUX9aDff0xTSGrlaKkxoJkRhdtBawdC?=
 =?us-ascii?Q?zIAcGNQiZGlThQfqprJ1tqaIr0rdCkganpKkGQBus7UNG9IJcdKjX9I/RfdN?=
 =?us-ascii?Q?aLYCiN2ZzjTyR1095kC38jc0Gtv/qqokqiB7x6sdNiER6L8VYOMqnyRA7y4n?=
 =?us-ascii?Q?jYSpYB81QskmNep0EkDFGMsyzOKT2ydJ4X/8/QaDYYC9PeHLbjq2pCIuMMex?=
 =?us-ascii?Q?SAbVffPve6PLgq4V5xWhbkyAE3ou8VSWEgp1Z3quGrqapioYDxaXzrgAwZ2f?=
 =?us-ascii?Q?xj9LvYQ07z+z08CWFCQiQr9iESjg4qSQCfy7RM7xgKPYS9kHmj1Bk/zIgNRX?=
 =?us-ascii?Q?VbTnukRf6QddaWp7t7USS30LW0rMLV8TzeyJUsf+bMTYbx2C8UC0MeLRE9ek?=
 =?us-ascii?Q?fLbPJQ5/SZxc81neVEreIIieUixqSy7OZT/lp7m0WaDJiGRtJVVZkMfu+hRL?=
 =?us-ascii?Q?FqLUnY7PfObCS2BFWc92hvvHOu7L/mWHBYM3suXbdRHDXGEqOJpc4eLBKzas?=
 =?us-ascii?Q?oW5ArSphLEJZdgloGaFjSpCH02gv28YPTN3PWrSI1oWmt/1PgReYpbU2+XBE?=
 =?us-ascii?Q?ynEI/SwpKPsfP/I7GQ7Am0QARJ2MVY39w7wjC5Z4Tf4zQ7tmluPC44Tv6Qq6?=
 =?us-ascii?Q?7w2TAmICiOjYKc1CHhVN3I6xjIIJ+DsBdn/55lQtIwzmH5Pz15QflkX0CGiE?=
 =?us-ascii?Q?cYr7S434/INz1ZdKbEBkUzdICdHnrBIVPuBN2SoNsiFpzxiyZwa9AqAj6+w2?=
 =?us-ascii?Q?8N+Yhh1iOuNUsnNP1qxcpZeTAtWbU2j7Qk10o/euWYS6gVRjzs2qU0ZTngLl?=
 =?us-ascii?Q?/mSCRbc8w3GEgDz313kFxTuUDgRqrJbV6JtnF6Zsj8EJa7SjMsYVh40my8cM?=
 =?us-ascii?Q?QDmbywqPc9qe1r99TlwCl0wzZhghsPzXePDrYMVj70XXZ0IScPyt8G3Sx2LN?=
 =?us-ascii?Q?VmU7ziROfzYS1OeglGHhI8ODoQ6Osabvwsf5of/H3lSp8L5U3GDIgEUA/Q8d?=
 =?us-ascii?Q?6kyDfbIMoWPVLwReaPQFK2CNQ3RqJ5GBROEiATGu+mng0W8NU/9l9MIzRGPN?=
 =?us-ascii?Q?urfXxc5kVRrj1IAgkLeLiXnplnN5lfVgG7PYZI8Ih4qcBhqWpfRGxnsQq5zI?=
 =?us-ascii?Q?ttCbPw4RhFnmt83oorP//fJ/k0tZ/SmjXEdtgpA04dEgQaN3VnGh48dxevc/?=
 =?us-ascii?Q?9KuOn1JjauveTM25rD+1T9CuyGE7Z+LsvUYvpiScOFb6ZNARXob5H2UW/EG7?=
 =?us-ascii?Q?K/BKxmoT86Wyt+q+Z+13jf9OiTyX7diLbDbFUIBvwMYmvWufRjyyKWzmUTdT?=
 =?us-ascii?Q?SKoa9S/YrXv/dfTXSUWIg86WL+AXyYronLAKyH+R7o1UsKjiwcttRyJunRET?=
 =?us-ascii?Q?yhbNI4wXXKnP+NkWjJwlRy2vsHVvFgAnmVmNoKRA3E4AEVXsURLeq+ggbF12?=
 =?us-ascii?Q?49iNsbkN85iuPWSqeT66bXCg2lWS9f38nQq0Xrg0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95514d97-69cb-4e2f-b98c-08dadf9c55a5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 19:32:57.3037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNk3JeB4I/DRSPysmsJesmGI7drnu8aPFyJbUJ+tnH1y72D3p/Y+2nENgQvnBqP5hSTXgbx2Q/0M5yYmSpDw1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5243
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

> After moving f2fs_show_injection_info() core functionality into time_to_inject(),
> __builtin_return_address(0) result changes from return address of caller of
> f2fs_show_injection_info() to return address of time_to_inject().

It seems you are wrong, and the original patch didn't change the logic here.
Because time_to_inject is an inline function, __builtin_return_address(0)
has not return address of time_to_inject().

My test:

(1). w/ below patch, we found that the value of __builtin_return_address(0) in
	__time_to_inject() is the same as that in f2fs_show_injection_info().

# mount -t f2fs -o fault_type=0xffff,fault_injection=1 /mnt/9p/f2fs.img /mnt/f2fs
[   19.739661] loop0: detected capacity change from 0 to 2097152
[   19.749759]  new F2FS-fs (loop0) : inject kmalloc in f2fs_kmalloc of f2fs_fill_super+0x7eb/0x1780
[   19.750313] raw F2FS-fs (loop0) : inject kmalloc in f2fs_kmalloc of f2fs_fill_super+0x7eb/0x1780
mount: mounting /dev/loop0 on /mnt/f2fs failed: Cannot allocate memory

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4035dab1f570..1e5030633f4d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1876,11 +1876,13 @@ struct f2fs_sb_info {

 #ifdef CONFIG_F2FS_FAULT_INJECTION
 #define f2fs_show_injection_info(sbi, type)                                    \
-       printk_ratelimited("%sF2FS-fs (%s) : inject %s in %s of %pS\n", \
+       printk_ratelimited("%sraw F2FS-fs (%s) : inject %s in %s of %pS\n",     \
                KERN_INFO, sbi->sb->s_id,                               \
                f2fs_fault_name[type],                                  \
                __func__, __builtin_return_address(0))
-static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
+
+#define time_to_inject(sbi, type) __time_to_inject(sbi, type, __func__)
+static inline bool __time_to_inject(struct f2fs_sb_info *sbi, int type, const char *func_name)
 {
        struct f2fs_fault_info *ffi = &F2FS_OPTION(sbi).fault_info;

@@ -1893,6 +1895,10 @@ static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
        atomic_inc(&ffi->inject_ops);
        if (atomic_read(&ffi->inject_ops) >= ffi->inject_rate) {
                atomic_set(&ffi->inject_ops, 0);
+               printk_ratelimited("%s new F2FS-fs (%s) : inject %s in %s of %pS\n",
+                       KERN_INFO, sbi->sb->s_id,
+                       f2fs_fault_name[type],
+                       func_name, __builtin_return_address(0));
                return true;
        }
        return false;

(2). w/ below patch(remove inline form __time_to_inject()), we found that the value of
	__builtin_return_address(0) in __time_to_inject() is different from that in
	f2fs_show_injection_info().

# mount -t f2fs -o fault_type=0xffff,fault_injection=1 /mnt/9p/f2fs.img /mnt/f2fs
[   81.019451] loop0: detected capacity change from 0 to 2097152
[   81.031058]  new F2FS-fs (loop0) : inject kmalloc in f2fs_kmalloc of f2fs_init_write_merge_io+0x35/0x1c0
[   81.031745] raw F2FS-fs (loop0) : inject kmalloc in f2fs_kmalloc of f2fs_fill_super+0x7eb/0x1710
mount: mounting /dev/loop0 on /mnt/f2fs failed: Cannot allocate memory

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4035dab1f570..f15001b5d73b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1876,11 +1876,13 @@ struct f2fs_sb_info {

 #ifdef CONFIG_F2FS_FAULT_INJECTION
 #define f2fs_show_injection_info(sbi, type)                                    \
-       printk_ratelimited("%sF2FS-fs (%s) : inject %s in %s of %pS\n", \
+       printk_ratelimited("%sraw F2FS-fs (%s) : inject %s in %s of %pS\n",     \
                KERN_INFO, sbi->sb->s_id,                               \
                f2fs_fault_name[type],                                  \
                __func__, __builtin_return_address(0))
-static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
+
+#define time_to_inject(sbi, type) __time_to_inject(sbi, type, __func__)
+static bool __time_to_inject(struct f2fs_sb_info *sbi, int type, const char *func_name)
 {
        struct f2fs_fault_info *ffi = &F2FS_OPTION(sbi).fault_info;

@@ -1893,6 +1895,10 @@ static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
        atomic_inc(&ffi->inject_ops);
        if (atomic_read(&ffi->inject_ops) >= ffi->inject_rate) {
                atomic_set(&ffi->inject_ops, 0);
+               printk_ratelimited("%s new F2FS-fs (%s) : inject %s in %s of %pS\n",
+                       KERN_INFO, sbi->sb->s_id,
+                       f2fs_fault_name[type],
+                       func_name, __builtin_return_address(0));
                return true;
        }
        return false;

Thx,
Yangtao
