Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D5D714284
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 06:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjE2EOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 00:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjE2EOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 00:14:15 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2138.outbound.protection.outlook.com [40.107.255.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39857C2
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 21:14:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dENj+TH7qmoAz7ztCr0/CcR0rsHugE40CP0lOpc1iS99Fo/SQOxmGe2HY4pS0x2ai5urLalLbUpFDA2XTt+bIgZd4dcnvux42ITg7fdqlN/9FsXJe5xdn4k30tFXmkQJl13qAFe9jX6DtvJ1o1Hh2d0vAs0s80JZsQaMJj3GAK3DrtRgS0H333xLkuoJwV0xxwIedAoXo30/W4NueCQIV/p8BznKcuTqixAC8SJyLFIzZgxZ8traNIuE+5LnX8D+0f6IA772X2/RnwxBuzLxTEHuCHl1Yax8FsR019FVpm5YaePMA6pW6TS2QzWMnHSLHQ81N34qQYrT/r40G8cNuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A88sj0NkqZQQ34Ph5bh3U+TZDuoHKHhfzIk+2gG3mXE=;
 b=FOczUyCeLTqE5jYhDVK/u/ihltt8YKe+yZU/lBDafDidarhPMbinetMjZfOmgoLX6NWzoHMgzhXVRb63tRE2RyRdpnWEsydhBG13XGJOOR9O04iqZ8drZz4f032eA+n0pZ/fiQ+Gvh6EfVGn3MMpHNTFEjKREt17hHEdwFM9nKgIaTq/qpvuY4iNcVqgOLy64oP0fp/V6adAeWSTUTGRsuhoeraYLjQI9N8Gv7YsCElTJaBLIX9u4+e4fGETHm9yaRN31dDhsFGPwiVvwV6bb6dHpNXK1Hym9i/vjYC/uNOHmdBXg2nrwwUNEvjMaVZpLOZxyk/1Lw/vVO/ueZ2q0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A88sj0NkqZQQ34Ph5bh3U+TZDuoHKHhfzIk+2gG3mXE=;
 b=QO+t6CWEm/rieBpURYyJ31jL2ykG5gezMGoIG/MBIGCw77YBXQzvrP3JGC08KRhpxuT4mLAYlbCw//XZO470/aUxAVEEwI8Hin7T8uSee6vEDmnuystnnLb1AP0zIvqid1Eyd89j5JGjWC6ximitV6BqoWc0eel4iBLRKWa4BSEf6ELtQtuPaaT+dOeBnxKizfx+SIL1eiGz4BfqLOu9COpcYqebdCE70U4tOMaNrhSaFWTR63YWU0hVW7dIVEGNKd9WjVJiQ3rg2ARsfQLt8rAlzahgeQemcW/laE85tzDV2u+mBPhnp6ANRMqDLRRQc78rrr0CY8YfGohr0LPszQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3017.apcprd06.prod.outlook.com (2603:1096:100:3a::16)
 by TYZPR06MB5930.apcprd06.prod.outlook.com (2603:1096:400:336::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 04:13:46 +0000
Received: from SL2PR06MB3017.apcprd06.prod.outlook.com
 ([fe80::b895:d992:299e:32d4]) by SL2PR06MB3017.apcprd06.prod.outlook.com
 ([fe80::b895:d992:299e:32d4%7]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 04:13:45 +0000
From:   Wu Bo <bo.wu@vivo.com>
To:     chao@kernel.org
Cc:     bo.wu@vivo.com, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, wubo.oduw@gmail.com
Subject: Re: [f2fs-dev] [PATCH 1/1] f2fs: fix args passed to trace_f2fs_lookup_end
Date:   Mon, 29 May 2023 12:13:37 +0800
Message-Id: <20230529041337.36741-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <2bb05623-9438-3b68-6ac8-4294f9676ff6@kernel.org>
References: <2bb05623-9438-3b68-6ac8-4294f9676ff6@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0024.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::11)
 To SL2PR06MB3017.apcprd06.prod.outlook.com (2603:1096:100:3a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SL2PR06MB3017:EE_|TYZPR06MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: 03cd784b-6707-4ba2-13a1-08db5ffb187c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: brWjeEkgHhJRVuxoKluEL91FESSkl9bvWtVI0I1Ht0Zt9mOAJzSxTWypE8acr0+GXgQ54bm6oKzjvyWoo8Wz0mBQyRHPKMF+dnuQnM4le0mwME7Nzz2m+DET2Q9+5zUCUFlFGJ7bdXmDT80yRFXIjcAovwLLAtLc1zPaqquGC+5tTZO0zsgDf6SGhW0r/imBjMtDeDBVqh7EDXC2byqtDUx46l603uHs5/B9lN4gdOIbqYQsyYbI2oFfk5dISkXGhriips76r88ehyy5URrU7l4cldM4mmwU+lQI84VZOG1UAVvRdV1TTzyVyyetjlj+qDqdehpciwebLCnSshsnE3IsAsnr2qmZNPTC0sr+HFWoYANSFnujhcGDhWtkCMBBmSb1YN3zXMDSjh6SYrQbEynjSmAYhsyLMw2qSazzIKvZpLD/m5CTZzuWdru0hbAsHnz8LbL/pX8rJpkdtLDENsA9WDQKDHN7oX0YdQa0RNTuTzdD1WrMLyS+Emi8sx+01t16qlqAsvYBwQ/AMxfqU6/AdV3lq4odz59lTH8jye7ZF9vooxa2tLlFlnDt4CxoErFCFTz/w8MBV78MMTeMkN8WkX8+0YBR6mmXYfrNojc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3017.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39850400004)(136003)(366004)(396003)(346002)(451199021)(6486002)(52116002)(86362001)(41300700001)(966005)(4326008)(6916009)(6666004)(316002)(66476007)(66556008)(36756003)(66946007)(5660300002)(186003)(2906002)(53546011)(1076003)(6506007)(6512007)(26005)(2616005)(83380400001)(38100700002)(38350700002)(478600001)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3zmf1ZTZCwkRPROaQPg6cuEe62rrdghC6adOWYL4IFwe7OCdt3JUUFXKRLRA?=
 =?us-ascii?Q?rDVJG89O78T3mTXh1jhPNIdDELBvLA5y260gs9+40AaIpuVPOvwLYvdr+Td2?=
 =?us-ascii?Q?VOIz7O4V0DrYxoJUoXiRENVXKDbUmeCFLKVO1tD6X/5vmxCK9vkn7W08mke5?=
 =?us-ascii?Q?52ktJCqV7aCT1IT4eEx9XnZ/MNLlL8z/qYjYiy5722Cj/DxIupRRXMUTdLv/?=
 =?us-ascii?Q?TMNPiZk8jFY+HqRfWbtN6nJNPx2z2y3+8mSRO6xYsbo8aNvJIw2y3JimVplJ?=
 =?us-ascii?Q?KqnpGWJBSGZtXHA0jFxrEVVA+lvun/8oNyJ1CYh4ea5iGztibvl+x2OzudNX?=
 =?us-ascii?Q?UGIAb6crfiBJ04aBjAL5abcnau5htidbJit4j7UexvFgjCN4imdHaDpKPZzB?=
 =?us-ascii?Q?E6JTaqNN2q7JsGhk3AZyNtLyfHT2f1Oabf64Vvg7PtkbHl8mo89Ws5nwhkKU?=
 =?us-ascii?Q?ZAs2uQ1mfaLJdMVOsHtotDgIJXCzILwzWeJFiwN2ygRgMg1FGA/QdtfdpiZS?=
 =?us-ascii?Q?qd10lGOZjymthCsh0rT803XrfHZkVDQ7U/msM3PiAkHNRu6qgbyEkEyeWAGV?=
 =?us-ascii?Q?HXfyiyFQ7lPwaCo2dGj4goMvIg4jeMizikE9TrM22yT1uEmF+axrgl/Ipzdg?=
 =?us-ascii?Q?SCaKF5ZFUxjks2nyxaFIV+6i9/mQGYHsqXlXYMXYMI0ATHbcECt3kS48IV9p?=
 =?us-ascii?Q?7rDk+nR1M2Ef0pcjetCyUI2YOXEJRxMQ98wquVDekPyMMcTJWyGflaMlL2qL?=
 =?us-ascii?Q?5Pl+wqeRGv2GG4FPKxgLrG9aX1ShhNfiPiqwJzNH+yL47GAfzzjquOh97HnN?=
 =?us-ascii?Q?TToAEY/X5bzolJ/eVqkFPnbx6k1h19KI3krAYf0za3yooZE3BIE/ACDb58rb?=
 =?us-ascii?Q?JyiZC6iosecMI4mKFTjmetK3xZR3/i/yPo6r2ytoLXfnC6zCdmu0eRiBiY+b?=
 =?us-ascii?Q?VW16ntW1JZdxyfvG4tNRBrP6iuraoRaZwdKr1fZeAo15E6d+/5KzLVB6XPds?=
 =?us-ascii?Q?k+p/oOJ0TQ5c4ZNUEE5q4ItzouluXIWleR9mdgIrn1LFuPRewvh9Zl70DqyA?=
 =?us-ascii?Q?OUZO41FoRGbfw4/ikS7LLzLg2GaHWtumiqgaSKcv7SPJ8fupUjgBOvYO0liB?=
 =?us-ascii?Q?4cuTN5t6L/clNUm/sKhbkO/IuRcwhN4zAr7Zl/CZdik7ZdijeH14dCZyYqji?=
 =?us-ascii?Q?cW8rxMukWl5FontMgp0W+NMVZkmdqO+Ojd+U5BNZ+1DdL5ISE0LVQzALFIvb?=
 =?us-ascii?Q?DghGg5cFqD5EdSzQusHylRT/ch9EB8DYkDh1rI4gx8bJnFDZuQ8XKr6I7L9N?=
 =?us-ascii?Q?GoJ9bgH3tlPv9JndFXlGSo6s/cHOIdPCwSs+ecRT6dhXG4RepayWYlJEhKN9?=
 =?us-ascii?Q?y3BrCKdRzgJfla0Nk4YgPjlpyEkXcObsNebWOOyUm0/O9pCUe8g3pevnYI1R?=
 =?us-ascii?Q?5WQThFSynthyuBmapPS2QjeIzrrwxGkQ3QpQ7J3ns3RdJeF9YX2MG6vBwxHk?=
 =?us-ascii?Q?HaF1Z+bHXtWjVonuC59GIy8QWR2P2ePhYLFEK96T94LGcU8T3iUdZqhVb32j?=
 =?us-ascii?Q?XZuTSXxrH0bG3P4tg2ZZulIiYXg0Swx+s5GRx3ro?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03cd784b-6707-4ba2-13a1-08db5ffb187c
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3017.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 04:13:45.8567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YvXdksAMpLrVOpI4nZ21KrDKqS8npU7N7ibHbJANo9qpJOpVV8GSCiGEVCVCxklTsFU6mpYtjWqxWolMAPE7dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5930
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 27, 2023 at 09:01:41AM +0800, Chao Yu wrote:
> On 2023/5/27 1:21, Jaegeuk Kim wrote:
> > On 05/24, Wu Bo wrote:
> > > The NULL return of 'd_splice_alias' dosen't mean error.
> > > 
> > > Signed-off-by: Wu Bo <bo.wu@vivo.com>
> > > ---
> > >   fs/f2fs/namei.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> > > index 77a71276ecb1..e5a3e39ce90c 100644
> > > --- a/fs/f2fs/namei.c
> > > +++ b/fs/f2fs/namei.c
> > > @@ -577,7 +577,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
> > >   #endif
> > >   	new = c(inode, dentry);
> > >   	err = PTR_ERR_OR_ZERO(new);
> > > -	trace_f2fs_lookup_end(dir, dentry, ino, !new ? -ENOENT : err);
> > > +	trace_f2fs_lookup_end(dir, new ? new : dentry, ino, err);
> > 
> > Shouldn't give an error pointer to the dentry field.
> > 
> > How about just giving the err?
> > 
> > -       err = PTR_ERR_OR_ZERO(new);
> > -       trace_f2fs_lookup_end(dir, dentry, ino, !new ? -ENOENT : err);
> > +       trace_f2fs_lookup_end(dir, dentry, ino, PTR_ERR_OR_ZERO(new));
> 
> static inline int __must_check PTR_ERR_OR_ZERO(__force const void *ptr)
> {
> 	if (IS_ERR(ptr))
> 		return PTR_ERR(ptr);
> 	else
> 		return 0;
> }
> 
> For below two cases, PTR_ERR_OR_ZERO(new) will return zero:
> a) f2fs_lookup found existed dentry
> b) f2fs_lookup didn't find existed dentry (-ENOENT case)
> 
> So in below commit, I passed -ENOENT to tracepoint for case b), so we can
> distinguish result of f2fs_lookup in tracepoint, actually, -ENOENT is expected
> value when we create a new file/directory.
> 
> Commit 84597b1f9b05 ("f2fs: fix wrong value of tracepoint parameter")
I can see this commit is try to distinguish the dentry not existed case.
But a normal case which dentry is exactly found will also go through
'd_splice_alias', and its return is also NULL. This makes the tracepoint always
print 'err:-2' like the following:
      ls-11676   [004] .... 329281.943118: f2fs_lookup_end: dev = (254,39), pino = 4451, name:Alarms, ino:7093, err:-2
      ls-11676   [004] .... 329281.943145: f2fs_lookup_end: dev = (254,39), pino = 4451, name:Notifications, ino:7094, err:-2
      ls-11676   [004] .... 329281.943172: f2fs_lookup_end: dev = (254,39), pino = 4451, name:Pictures, ino:7095, err:-2
Even these lookup are acctually successful, this is a bit strange.
> 
> > 
> > 
> > >   	return new;
> > >   out_iput:
> > >   	iput(inode);
> > > -- 
> > > 2.35.3
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
