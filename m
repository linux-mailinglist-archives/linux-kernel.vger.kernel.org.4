Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E36470BE70
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjEVMhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbjEVMhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:37:10 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2043.outbound.protection.outlook.com [40.107.104.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A10810EF
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 05:36:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6FH3VRuU0Yw71u/sqTkJ63ct7oO1VpzhnWFboUI47+QbC6G2tj1JmWCCrD4HpfGQP85W9JAW0E8RHCp/v2dsQe9OlrabNJtrbdfPt8ekQ075fzmfpiF0G7/DfNq31gDWGsV7Oh2HiU38MrhUIaUX1C19P45WeURgN4A7cpSRDf5yaGo7/XZI1krbSRr+JfE4PB4rcH/8MWle0sgEEI8cIFIX9oWRTvqFYWcqnqY5yLPCD7byE3meQX1fDnXxTMAKWPkE0A2R4jAZZvuADx5QrzI9y98xn4dHPamU+fpF/AW2eKsu5jblIeYi/7bNOm5WxI/2S7dHIbaAzStQVdrjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srwT58UtPmTSfhvGg0HXE4eygBAwvIgHKN3yqqpYufM=;
 b=HdQqN77CltjxQ/A7w4G1f1zEDAKfpaJV/nFxa9nskXSdEO4K/uczGsphfryspzqjPoRPAcnFp923G/t+v1moQ6W13nZhyzkgqnbPoe1RkLebDWc0xcKmzq1WHGATq0Nb1ZaPs/T9EikL8uneaiMeF4+stNUJdklZODuYIycIvuFARV33AxtxTY2f3oS3LZtLXY/CPZPtytMre3a0sjay6dv1j24dyeRJ7kUqkAg1AossVT5KpipoKNPEjdFoGFPSI6hMpBV0lLH2UnD1Iz2QgfZhSqOwgHs4y8azYNq71q01OO8I9ibHZkVE8z+FhreSk18lAlyTMC7yssXkPnOnFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srwT58UtPmTSfhvGg0HXE4eygBAwvIgHKN3yqqpYufM=;
 b=Iugw38dsZngXHA82z2XBzQ8Qjowzb/ZGWh0tWemM4Uo1lvPOwtMsXfbj7tFVM6JjyzV6QHFwvKTa2iBTUu6ifX9xmF4oy7NRNDCmeGA3Ttd6jfrZ3JBOH0bkYG3pXF9iLDxzYFmsZjNbHphVg7wWP9e5bQylDgE6Zjo+6kGUoQNDj8ltj5Gz0xuU5nOmoqnYAZ7NBcU2PeGllFHy4SZAKnzYXCAnZAlFfVDWbqgf1sJB5cSztKGmJkozXh+ce+0xkhH6kN+qwRXsPfKg8PvzJi+oWrel86no1/bcRvivTCMP+w6f3JWFWIr8/JFWjMs7mTdZSx/XtZqCZwiYn7R63g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB7990.eurprd04.prod.outlook.com (2603:10a6:20b:2a5::10)
 by DBBPR04MB7692.eurprd04.prod.outlook.com (2603:10a6:10:1f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 12:36:30 +0000
Received: from AS8PR04MB7990.eurprd04.prod.outlook.com
 ([fe80::d08d:bd7f:555f:95b6]) by AS8PR04MB7990.eurprd04.prod.outlook.com
 ([fe80::d08d:bd7f:555f:95b6%6]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 12:36:29 +0000
Date:   Mon, 22 May 2023 20:36:23 +0800
From:   Heming Zhao <heming.zhao@suse.com>
To:     =?utf-8?B?THXDrXM=?= Henriques <lhenriques@suse.de>
Cc:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>
Subject: Re: [PATCH] ocfs2: fix use-after-free when unmounting read-only
 filesystem
Message-ID: <20230522123623.eozzedrogy4oaj3w@p15>
References: <20230522102506.9205-1-lhenriques@suse.de>
 <a57047d6-8f57-3dde-f15f-b24f63d675cd@linux.alibaba.com>
 <87h6s47dxw.fsf@brahms.olymp>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h6s47dxw.fsf@brahms.olymp>
X-ClientProxiedBy: SI2P153CA0036.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::11) To AS8PR04MB7990.eurprd04.prod.outlook.com
 (2603:10a6:20b:2a5::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7990:EE_|DBBPR04MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: 77c7d4c8-5eef-46b6-126b-08db5ac12ab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SYaUOcYyvqIzv/yGufNRrITCvYcvaJUxgAn+yjb1YO2TP2J7XAybOilyNAMTn129dX2NPR5Er4xIStHs3W/BPneh+ehe95kcIfrkbsKPIfV5+SfYGldphvV9m16vKOYqnguZI3syWjH+2QfXtztzgJ8UkeVxuvp6RI+lEN5Y6Hinvtmpf0Yl+QHqfSenCzp6xJw+w+lgCRb8yt/23pqs0x0UfO+lodIYfzEsWxGb7rvZIseRl4PBz/EjwiNm9egdbIogUaVH4etMBFnAajBl/7RWeq43U24SkJU9OQAuO0W1VpYFxdthTxctZ0hsUYL65cq0367xgdRHYlrfErzAVOQUKgB4jrbgVHJGvtrWpbqm435VpvV0Qy1/gS1XLSZRWDGSWjHKm8pZW4jyk0QvyPDGO2Gif4dwG1thbl6jOC2ah2kPKbah1N6tAmwrHHXtLqUcMIDepsU1mye3GaIbWIKzCfDvyQvNsZviSySVIEixcQ7XkYWld0hKivkM6Koer05VGgN9TqhBFQI4znZiENX0sfTKdfK3b/rJJAIa6XbcD2ei5EF7T5mvptCi8yH8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7990.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199021)(2906002)(5660300002)(66574015)(83380400001)(44832011)(8676002)(8936002)(41300700001)(66946007)(66476007)(4326008)(66556008)(6916009)(54906003)(316002)(6666004)(6486002)(478600001)(9686003)(6512007)(6506007)(1076003)(26005)(33716001)(86362001)(186003)(53546011)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?JP5ZkavlDewb3fnVucTCnoU4R9beAsE8HzwoKmZnB7qNbgjQ5dlFgsEZKD?=
 =?iso-8859-1?Q?BK+E/2/WagHOcLEMMjKAk2K/7u142o1vzk/7XeoBMze757ESWBf2cJLkwp?=
 =?iso-8859-1?Q?hCKpfkPr8/7bIveHRYJTZNqcIZzbHx60ifiteN2/MR9Bo9wI507cULHcGX?=
 =?iso-8859-1?Q?LM3p+J7V/Qxev0rp6Yjg71dNXXrKMrvyyWU28Ryaiv8vRkyTxdkRrRKNi/?=
 =?iso-8859-1?Q?W6IVtjyQ9YIXAoZp8scNESLFSOLrV9jgssbwW6UCQiCsD8XtHS87f69IeE?=
 =?iso-8859-1?Q?KxaosYr6M1VWKFRhurkvQUnhNSqfzia1XM4iVdZCethGv51TznmEpXuWgU?=
 =?iso-8859-1?Q?8NNS7m5x2rjo6fafk23xUe+REeyyd5IyMiUEYymGroKX94lTsPg2o26CdO?=
 =?iso-8859-1?Q?ctLYW5R5j/jTIHLpkP28Vl8uoWxIBXEYznFJCHUc7MI6o24F9z9NwQoFJV?=
 =?iso-8859-1?Q?jsEQ8MpUHInLccVrGdLAq5aqS0XKvYuhyu9V9+90FOv8dsXcXwx3l+8vA9?=
 =?iso-8859-1?Q?JYLMTkLme9Pve2xVFK8Vx2yVRAjxjzHNpGEb160Nsw56acREEXvtyVA4rX?=
 =?iso-8859-1?Q?B58Eydwu3u6k11epFv41OjGTtghnUq23sb4dY2pDbznKR+qdMwNbh/Ow7O?=
 =?iso-8859-1?Q?eOn/nmhnw9b+XPbChnoaiL2oW/3Inc5kTsO+qct65JeDnn4iOEu4KK3jKi?=
 =?iso-8859-1?Q?JCQhVM6pL/GDFDAa0dIVjbcmw5V9q1at7RLP+Lm47nDoQJXGyDOWwfiC0U?=
 =?iso-8859-1?Q?WdD9sreff/FEYnktkxYvXFz9o+9HXhuS9v3LkHRYuVjMFaSSltbn8u9u/9?=
 =?iso-8859-1?Q?Ts/+bObMcbyG6M8ZJqQOfU5RYHZoxnV7Hgnr8b8anPfVm+TYwgloYZj35K?=
 =?iso-8859-1?Q?t5YlBgGc/1ynE5jK+LeKJFn+wDdPbC/0XkB9AoURz6ktrAMjIZN7NeUeKr?=
 =?iso-8859-1?Q?hTqKzC6dI7Z6miPMDR4E491jfue0K6cV+AmGqsYXZ1Zfga5Hv6DmX8wZF6?=
 =?iso-8859-1?Q?V9NHHbGmMzDXWvYmya/lrbXBoVEjH9oj0nJRnPtvlBl9StFluoYHN3mir4?=
 =?iso-8859-1?Q?A9p4ll7EjAzLxxTAd5V2djcr9QAgEcanXjKfX36Srci1g/nDalPjIHPWXU?=
 =?iso-8859-1?Q?MxHeV8wVYcwtqwuhijNogDld1GMbAez/sftdAyXVM3/fWCbdATW6By98Ye?=
 =?iso-8859-1?Q?azR2KwNIhqQ/SEaomXjZ8+CVj7Uxxz72wb0EZhwjkTocpzllvi6TSNJyd+?=
 =?iso-8859-1?Q?23w90swxY/wB4P4dMTiFka5MYWFL6XZiFtK88CywkwVZecOG2GoihusXwZ?=
 =?iso-8859-1?Q?sinAT7a65uQAuuwUdcunCYSbW+nh9Jq134+UM28x7O3NOukQ1Qk6hr7OVd?=
 =?iso-8859-1?Q?MMQG8xNfi7TaLUyPhEXVcwqUfF3ZNwfJzU+jVI0Kg6s85Qo4Gox7Pkcy1S?=
 =?iso-8859-1?Q?V+RY1LyfxTRzF7MEK6ZdjcIAFI0St1oW91We5zfrN0fbwXKaQkY9Wgg7bm?=
 =?iso-8859-1?Q?pqG9Ic+rNdYM9TRiu1vPbGLO+pIJ3VtL7+CMlNQc0a6tMzs17argj7k3Pq?=
 =?iso-8859-1?Q?e+VCtid6+AybfFI0GPZilnCe9YMJgVfdAwcmbsA+txXgMm97vlistw1VsL?=
 =?iso-8859-1?Q?tRGoK8/EgJRnCH+RxYJtxiw36NuxirOe5c?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c7d4c8-5eef-46b6-126b-08db5ac12ab0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7990.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 12:36:29.7816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PzWmzEmSNPioN3ElFjPu22ho5mfDNMy3m0CLiChDQPM8ZKpG0eINclsdlWMadQJd/5gqDtjO7kxfhqE9Lslu2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7692
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 01:23:07PM +0100, Luís Henriques wrote:
> Joseph Qi <joseph.qi@linux.alibaba.com> writes:
> 
> > On 5/22/23 6:25 PM, Luís Henriques wrote:
> >> It's trivial to trigger a use-after-free bug in the ocfs2 quotas code using
> >> fstest generic/452.  After mounting a filesystem as read-only, quotas are
> >
> > generic/452 is for testing ext4 mounted with dax and ro.
> > But ocfs2 doesn't support dax yet.
> 
> Right, but I think it's still useful to run the 'generic' test-suite in a
> filesystem.  We can always find issues in the test itself or, in this
> case, a bug in the filesystem.

It looks you did some special steps for 452. In my env, without changing
anything, I could pass this case successfully. 

- Heming

> 
> >> suspended and ocfs2_mem_dqinfo is freed through ->ocfs2_local_free_info().  When
> >> unmounting the filesystem, an UAF access to the oinfo will eventually cause a
> >> crash.
> >
> > In ocfs2_fill_super(), it won't enable quota if is a readonly mount.
> > Do you mean remount as readonly?
> 
> Yes, sorry. Instead of "mounting", the patch changelog should say
> 
>   "After remounting a filesystem as read-only..."
> 
> Cheers,
> -- 
> Luís
> 
> >
> > Thanks,
> > Joseph
> >
> >> 
> >> Cc: <stable@vger.kernel.org>
> >> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> >> ---
> >>  fs/ocfs2/super.c | 6 ++++--
> >>  1 file changed, 4 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
> >> index 0b0e6a132101..988d1c076861 100644
> >> --- a/fs/ocfs2/super.c
> >> +++ b/fs/ocfs2/super.c
> >> @@ -952,8 +952,10 @@ static void ocfs2_disable_quotas(struct ocfs2_super *osb)
> >>  	for (type = 0; type < OCFS2_MAXQUOTAS; type++) {
> >>  		if (!sb_has_quota_loaded(sb, type))
> >>  			continue;
> >> -		oinfo = sb_dqinfo(sb, type)->dqi_priv;
> >> -		cancel_delayed_work_sync(&oinfo->dqi_sync_work);
> >> +		if (!sb_has_quota_suspended(sb, type)) {
> >> +			oinfo = sb_dqinfo(sb, type)->dqi_priv;
> >> +			cancel_delayed_work_sync(&oinfo->dqi_sync_work);
> >> +		}
> >>  		inode = igrab(sb->s_dquot.files[type]);
> >>  		/* Turn off quotas. This will remove all dquot structures from
> >>  		 * memory and so they will be automatically synced to global
> 
