Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28496FD05A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 22:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbjEIU4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 16:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234893AbjEIU4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 16:56:00 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2055.outbound.protection.outlook.com [40.107.241.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9799B59D4;
        Tue,  9 May 2023 13:55:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8tYHmf5Ue1NHWteMVEOev83uJl+IsMc1XOE7QJ2iFTU5RgTnVB6zVzLtIVw3xhZdvne6cG212S23IrmPnM+O42wpMsMI4mnp/hwUIV/4ES5/CBnOTbC+ugJLPJ/FSwEdzIVNa280Ys4/VF3r0OcIgtXVNCRchiLnwo2fnAsjnCwzbwPo6gpBAZivS2Gz4pCzjPQ+Cuo5iZnYVg4IW93At2N1snlLb3njd/fXp5yMRw0GrM5FftMRYycGrNnkb7eiwAq2rZtv9jP0TBs3I56OJBwDB4PSW0g3Vucb94OcGJKiInJknwP6ohImxYleKWXWWrb0NpLNOTEFch4UYqXSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRgLOZyb8YGiGM41S8ROnEF5wfGxS+vShKER0upqfXY=;
 b=ZNnoGAmA8NM3pGMa7daXsAj8QKXXssLHeuos3txyRMNoznCZFWKRPS6bq/Kd10LaQXTUK6embNujrHjGoI4/bqLwQQj3J4aezajB/+QgMaBH3cpHNmo44JEflvMHw6gKBsjh3jxjOo1z5+DzkSC0WD0dYDyrHiNFecpfkejToPmeme41eJvF1E6Qtdt30U2/VHEHWPvKiNN2b9JpvJF2Qe/rPTtMrudXg3KTJUFHYiOVpRy0VMwcGzpu8rf4VhTRl9ys22gRRrinbXRB594AkXcboUUYqMPBovh9/1MPFyzqU1BN+6JpuX8bLsH13nnN/bjKEgyfgq/Go0A4jqElNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRgLOZyb8YGiGM41S8ROnEF5wfGxS+vShKER0upqfXY=;
 b=uiTfMbN4ZT5F86WYONCpuvMNRcOG8genGBYTaHzimHRcFNIlkvfskrU85l3AHPWfTunv5cuPE1n2TjB3Ts/VMB8v5atEHZ8FhWS+8xhtLhC6i7Nq8VljdCnnxfbSf3jw+jEbojpwxu5H80dbpcX/Pk0QYv1xKn1oB6xqbEfFbeo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com (2603:10a6:802:2d::21)
 by PR3PR03MB6619.eurprd03.prod.outlook.com (2603:10a6:102:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 20:54:21 +0000
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::8cd9:c5f1:f698:5600]) by VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::8cd9:c5f1:f698:5600%3]) with mapi id 15.20.6363.031; Tue, 9 May 2023
 20:54:21 +0000
Date:   Tue, 9 May 2023 22:54:17 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/deadline: accurate reclaim bandwidth for GRUB
Message-ID: <20230509225417.61d36733@nowhere>
In-Reply-To: <20230509224829.2fb547fd@nowhere>
References: <20230508160829.2756405-1-vineeth@bitbyteword.org>
        <20230509132534.09098acc@luca64>
        <CAO7JXPhrqKWfsp860rRmEenxARi8U2gNMGsOn4m+aKporWwBcg@mail.gmail.com>
        <20230509224829.2fb547fd@nowhere>
Organization: Scuola Superiore Sant'Anna
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0105.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::20) To VI1PR03MB2880.eurprd03.prod.outlook.com
 (2603:10a6:802:2d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR03MB2880:EE_|PR3PR03MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: 44ec0e3d-65d6-4025-aa95-08db50cf9034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hyJ/pzUu9EtHSY+eehuVHaDSFYWwrjAZcCyRn9dg6f4tJ1C3e3nISsBanq4XJFSjwsWYqCcjz9vFTUCuO13cpreSYcH70+xHl5dOGacHJz4wCXs87j5C+gaYcBF4r4EJsn24F8krj3nShX2Or1k6IvwFAfzazDOGOW//Hbg4YTYydtbZLdC9fGbHz4sxUApwz6QYBS0x9cguOcMWxrQTZ2YZfzArTkA2V/B+LolQuimVjxH6BBqkmx11wncTHxHvW5McZvCP8YAhc2Y4f4tiwNG1u/7MaH6VVk/qLqPiXldFI9F16cMkSj93/JXmmEmA40N+QOgSOYnZFxvnfimsr8+2LliFhhPiQxCrhlqPcVHLjJLMRCXljuFW5hHEOhZKdmJGXq14FXwnuf2dIhIh8r+yH6YD5z8qjJOuAaxjyyP5iK0EHCEr2BCQP4jX/AHWlrziiXL/MizfPSKJx2O6bUENpYnbqQ1MGhW4ij8EByKS2PZx577wLOsbkqBCQ3+ALla2WQHiyMm8mDvipKBGWW0A8LqmWggvK/+8vxQUjuWaBMCRqqi0HUVdhn1clPgv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB2880.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199021)(6916009)(36916002)(33716001)(54906003)(86362001)(786003)(316002)(66476007)(6486002)(66556008)(6666004)(41300700001)(66946007)(4326008)(5660300002)(8936002)(8676002)(7416002)(478600001)(1076003)(6512007)(26005)(38100700002)(6506007)(41320700001)(186003)(2906002)(4744005)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HAGrBxI1fCh8DnlTvxEIX9LJGxGPM5o5+nNXIRRAlemlGm3WMN9lUSffFUBK?=
 =?us-ascii?Q?iZMdv/6/PYFfcXTRGHmOEpzMj1EN105WuyhA+pKrD9p9uxODxWOpOjxogRbP?=
 =?us-ascii?Q?afd1OSbh78vg7AAQpLvuPaKXNMvQYfeVLy8XZNU+LL6gxx/tVz/ruws4b12e?=
 =?us-ascii?Q?cChv+Ra3gD0ki1LbAGBgJbNENkbsFbtIa7eK4y5t8Y9YLslaf+oN6x4PiiJg?=
 =?us-ascii?Q?zsE6Xwn7D2vgYI3FiIb3M2aynAbQ/bDsJEtYU78iBAr8ZA5EFp5Xmp43xpPG?=
 =?us-ascii?Q?+eEZcLkdhpOLUvM72kyCcwZ6V33zgI+MNlH59SYyDZl8qfmcMUAa3k7ejx2q?=
 =?us-ascii?Q?FSZbf+sXayT7VqsyTXUAbD5zWxeZRO6fF9NYCCO4c6xJ5io0wGH5onSUVEfi?=
 =?us-ascii?Q?q61Hi5zfMw15V6xHJExoaVtQS0E4x/VIKwRwHeKLaksH0x0Xz3AErG6T66xL?=
 =?us-ascii?Q?sLwinmxDqhscmIPjE3/KQSDX32QymuYT30j/ks6oxgROwtz9j9YB4VNmqDiy?=
 =?us-ascii?Q?hQFmgaaz0Wtyj2ofo95tYU9fGjpotUrNzp1mv1Na6JXXTGHuWhj8f6tyR2QG?=
 =?us-ascii?Q?AByILyuOsL0da+uUdfqpVgzviXNPx6HX8Dal/ZfnjBgDnHZXflHaS9G8skS9?=
 =?us-ascii?Q?sthznXzpgStKD4cjEysTMbSDQHPjUd1RohXsTyrr3qabVLzDRaaH6v/mPCpq?=
 =?us-ascii?Q?ZYnmBd04yMZ2DUIEnuJQFqQIgECrqZMnJBmNsUX5ezNFGwE1UskRBxgEz9uc?=
 =?us-ascii?Q?8KTH3MwA2sJ953baT7UuwH36a93dIWy2cN6Z57lBkS6UAuurawbIDTuHZpPr?=
 =?us-ascii?Q?0/PD2+6WzKvApHfGgYZJaZPs86bPQAqeUTVQcVFqNApgDfhy9t3vP+mPw9Y/?=
 =?us-ascii?Q?If+LJ6wMy/2TKStO7O29mzJorDHggapCQCK+EvVAqSJOZdIYY+m+IFoctcFF?=
 =?us-ascii?Q?O+wVQ6jCjBNW2r7vpGDjfkU+Zpz1SHnf0sKeDOBvQ/LjXEKj0qliwvvDwg/t?=
 =?us-ascii?Q?kfc+qi/Cg8xerzzkMUBMazhzm54rK2LnPmXZib43BkBzRn6+nPD9w+nKmpwG?=
 =?us-ascii?Q?e1Jb0jVkGlWfN6CKrFS8O+WTC0Edk84j1jizDf433dQ8N1tD/7fnJtv6rBg0?=
 =?us-ascii?Q?nlU36SLiEwClFJr2uI6sI5JbxTZnG6voD/aCn5KsISm8zMGpI2GVXjuksqmT?=
 =?us-ascii?Q?8B/Q4DutQNcimmi0ZH8vpnhScBKun0ZE6MIkdMsEari5lWaiPJiYe5H4C1Rz?=
 =?us-ascii?Q?pN+f1gtiEUbkqdxM9rvUG16qgmS/aLKDBKLihIt1jM5rEFUVTLPL3ZnfrXeA?=
 =?us-ascii?Q?dpI3hH+YiRrTOtHJTbz7HV51TZwgWWP2wyxufa/FDR4L/Q6PAqR/75uizZ0H?=
 =?us-ascii?Q?W2P8FOB47Vjvkj8Z6DAM6wI7F5lvw3C4zVCPl1FCUrSf7YszVF2QvTOOHL/2?=
 =?us-ascii?Q?UzV5W30Tttx/rIf4mDusxKeNlYbpTv88RSMNmWC6H79oElc98wKU2Tagx6Ck?=
 =?us-ascii?Q?dNIO4oA6dM+dTIa/wmQqYnjUKLIQdUN+hWvNe1HOBd7cDjoDB12irFFGr3GO?=
 =?us-ascii?Q?HGHIXSLoA4vchMAjH4WTXlkvQDVNV5brvhSkPdEJsTlej6mAdOKhaNvB6YD7?=
 =?us-ascii?Q?iA=3D=3D?=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ec0e3d-65d6-4025-aa95-08db50cf9034
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB2880.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 20:54:21.2168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yi8TJiDgWlEJpnNCjQd/5IC97GA17njkYZE8ZCc1BX6cFpkto5kWzyPIBDfWm8SqeEwpiatM0bhNMLbwSsUs5xP5Mcfs8HZytmsXWYzLeps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR03MB6619
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2023 22:48:29 +0200
luca abeni <luca.abeni@santannapisa.it> wrote:

> Hi,
> 
> On Tue, 9 May 2023 15:29:21 -0400
> Vineeth Remanan Pillai <vineeth@bitbyteword.org> wrote:
> [...]
> > > Is this understanding correct?    
> > Yes, the above two details are correct. In addition to that, I think
> > the existing equation had a small bug:
> > GRUB paper says, running time is depreciated as
> >    "dq = -U dt" where U is running_bw.
> > This is assuming that the whole cpu bandwidth could be reclaimed.
> > But in our case, we cap at Umax. So the equation should be
> >    "dq = -(U/Umax) dt"  
> 
> Yes, this is the approximation I was mentioning... Instead of using a
> division, I approximated it with a different equation using a sum.

Sorry, ignore this comment (and the following); I misinterpreted the
code (and my old notes).

I do not understand why the "max{}" doe not work well, I need to double
think about it.


			Luca
