Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52923701C05
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 08:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjENGsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 02:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjENGsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 02:48:11 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954B91FC4
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 23:48:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUi7EMjCbsvYFWYG5MN8lxSAjJPocwhGdmwJZrQuHSC9cLmlGnSHC9GC9PAhBjaEnPaNNDmkwYqiMuELN+WjAPrBoX8PaKjRN9XtI2lpHydKqbyRJuO5GOeExpED1bMp4oKhdAsdl2yuMKO2Y83WUaQEJTIIPrIg6I9LKmEdZgD5nf5O6TAY5vak8r+nW1iYC/MOsUsmKKy2SXQi0Nl5O0wRMCTGgDoCT6kXXhuCBsSe+Nzuui0F9Td0SGd95ZViAK0EoOPRlxnFql6okB4mU3zgpytAJEORSv9+unbeEU9/N5iT3Li/cgURL+63CFUXzyJTp8hPsc5AlCuWR2fS1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7avMg3nSCDE+fM6FpfliRNn+At6krrKcoH7L4vtcJg=;
 b=m7Y2Q6kx6ejvozCvnGfhYWdAUKYJGYUOmZ0YpUTav0TCDBxtXIyM+QDFRP6GVGk5NidJ2ZVU2kf0awT5MUEuxBuKG06R/jGI+fTcV7APpVu1WALAQkvWKWq7N7qb9RWG9aFBui0kzVEjaYSPEOHv0uu3dW7kvco3P1mDmlaAeNS22MKiNYj+Pm73/MXMA5mL9DcLljFE1fOfrL89qkVIch9jCZHEGbDmi1EehsfkWYdWgXfMQWRQ9dxKFn7+bO6bs0sYQSCvFOEvmSFFws7ihcGBLqOiFnlJeim13WAvr/Fov288whhTOEnhBVA7ldRMksu/qgAu98yllonNVY6LPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7avMg3nSCDE+fM6FpfliRNn+At6krrKcoH7L4vtcJg=;
 b=aeYrjAV5c41td6NTLQ46uuxCX59/mmkTwWPbg0wb45om05to8bDnNU0JYGprKHdYDIvveffrMbOuI2QQvgaXofamYT25ngCbZSnQWLoKTldJqNMK8t765tkiYlTBudlo70IUXRQ2FIe4gfAgsO9/TASezIewvSjO9G8gJn4l9YkhHVHZXjtS/pe5epdNTuZNBOeGnSs/jZW85rGe92VaCkQq64ggdWMy1dhv2hq4SE+oTz5wN8/zDWRhlM9IL9HzQ5gxUyGWdXqalAJ15tXR+BTGs/wxc4wujKYGJs+jv/ggcKANP3lMJHYK4tGejEJZv7cU3jWwC8rG7czei+DhUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by SN7PR12MB8003.namprd12.prod.outlook.com (2603:10b6:806:32a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Sun, 14 May
 2023 06:48:08 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::66d8:40d2:14ed:7697]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::66d8:40d2:14ed:7697%3]) with mapi id 15.20.6387.027; Sun, 14 May 2023
 06:48:07 +0000
Date:   Sun, 14 May 2023 09:48:02 +0300
From:   Ido Schimmel <idosch@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     syzbot <syzbot+3384541342de0ca933f1@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [syzbot] [kernel?] possible deadlock in __hrtimer_run_queues
Message-ID: <ZGCEImqSjsYIlLgJ@shredder>
References: <00000000000026b68305fb78c24d@google.com>
 <871qjldbes.ffs@tglx>
 <ZF9aWEeQ5+Xvc+oF@shredder>
 <87ilcw9gaz.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilcw9gaz.ffs@tglx>
X-ClientProxiedBy: LO4P123CA0139.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::18) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|SN7PR12MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c05dca7-cb52-43bb-054c-08db54472cfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WQTz7PM7x61JZFLkvYdqxYYd73PtyW37Qt/U1sdRCwlorKrjmpVqcW04cH9tNKigu3lhokqxv0tlzrHftcOnS7llFhcgk8D7CFBMpeGeSgaxx5q+GTK+o4nphvMYHoRoDfgSwHYNkuf8nN5J1M7IjFigVLTOQItIzHw2OmeCjPxtHmtJk86Yc1D0bI/J7LiW+P0fuvStVZz4UhRHcQhuuKPu1jHLNne8FwL+K0eTYzNL4e/LYOwu1WoX99/vncaHRYr51HV/AMWjmFJkxlA5tWY/hi6Ju73o5JH4i2iO7O6cbAKGubj6yoDxO5B5DgGI3PR47IlN4/i5Fon3CUSO0KaQLHXPz0aCK/fxT8Vp7Dg6hdtVoDTRRfIe2x/pS4iV0j8Z+8GkNJp/L19rAmma9A5YQL6d9919SW9aCopAOhazVNLN7UWV06m4lQ6N4WkgzXZ/cz1qFJOt4DKrhpbeP8ckrywNJ3BtLh084f941SyMQkyFezk/z5gCE3XLiix5+4rwMKC7PvqnbDfWAD24d8UmrPj410onlTi7apwnCRfTglSiE8ibaat25cdIRcLM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199021)(33716001)(83380400001)(66476007)(66556008)(66946007)(26005)(6486002)(6512007)(6506007)(9686003)(478600001)(54906003)(186003)(6666004)(86362001)(2906002)(4744005)(8676002)(8936002)(5660300002)(4326008)(6916009)(41300700001)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C9pw6BGuUZiX8lCan1Y02V6MaZpYWRTmJEU5jIz51SKmpmqZErSUd7WihCUs?=
 =?us-ascii?Q?+kQq2IiRGLyAg6C2DA7Fp+/HsTjDc2ti5JAtmblFY6RCErO0LyI/sNRdqzVI?=
 =?us-ascii?Q?ovbRnyjxkNGq5F0I9DBFJr4aXoS0GQ/eYc3vHM+VGqAVjj40/JE5ORnc8dnd?=
 =?us-ascii?Q?0nHZ6Drv7iJ23b0zEmbDhOCNFYnzfCjq6WByRKcDfOYK4SLbf8LyFmkrUtK0?=
 =?us-ascii?Q?jbRACYpice2d1ZFfY2VjW24/JaLp0qmuGhmi2yLxPf1FXkrXeeC8zQH4tnWQ?=
 =?us-ascii?Q?m1+jxMoUwmWOVBMTz2FAci/XptLCRZS0ySnxzMyLyrP9rhZuneMfn8Xi2lCo?=
 =?us-ascii?Q?++vbv2c0L15Vn4y2RO7VOJGAE3Tq6qs5rpj2tWjGcR+uK2NKJcm/pLdGSejj?=
 =?us-ascii?Q?s1GHJjBJcv0oYMl9DU0Qt3T/DaPb1eCLix2gdI+2hoxty9E3UxfrQ9cOGf1w?=
 =?us-ascii?Q?WmEi8T9kbekxjahWsJz4lashd1EmREzd5cmvxCrEw+6la1tmygKT27tWc96W?=
 =?us-ascii?Q?mimxCVq7IaSVv5HGijMvmhSPb00QxgibsuAwpok+gmyV3S3zuhJOuQiVoxFW?=
 =?us-ascii?Q?gew3b5xQ7rm19KAFpUyMSsHNppY7RfnXCBPRynq0VnTeUd5MP3H47KfehpqW?=
 =?us-ascii?Q?oEwTH0heYJxjLnu0UAZWqk/ezEPuPeenOxiqInAZV2FL2myCBBaHfL84dWkl?=
 =?us-ascii?Q?9QFfgirrC5YWN2yT3qbQOCK/4YNNyAPGhup7CedlrXy6D2q6y5UkHKWRJdAd?=
 =?us-ascii?Q?xnZtDWhZvpxE8Ej4Rm14etrquacjXBL9oxAgXFnbePj/kzE0dC+LOTvISYI/?=
 =?us-ascii?Q?9XxlSYvAeMS6ipoDDypHBq6km98xbO8bDdZw/UwVAV0tPUIIAkXLCWy/V8aD?=
 =?us-ascii?Q?QUVBP0ctIzrorZwHDtAlOnX7YyO0+A8g7tAP2cSjTFt9/racLJQ4PRkYfYtv?=
 =?us-ascii?Q?h/oxQI6mxdw9TVAKAPfsUJCc15nGHzdrviRjTiW69FWiJ3LIgoAm/RStFUzA?=
 =?us-ascii?Q?8PN7tufU9bBJwJJr4Za+vqQR0Bj8eDIkvKdG1rvlL0tV+XU4a9+qdt3CqMbr?=
 =?us-ascii?Q?xLradDLMXInyDGb2+uXedHEbYdQNSTUC3kYQ2rbAdHWdWrJnT7InclxdI8KW?=
 =?us-ascii?Q?b0WlWQu+PpoFT90pxEH1C/o0oBxSsDFWrEKdQm7lWI5CKWURQgT/o4i7Fd3y?=
 =?us-ascii?Q?0/YYg44d1rczkW6bIlrLfywcBPZb9IlIWyzS/Im++5CP05Rv7f3foT/GRJp3?=
 =?us-ascii?Q?0xzdJqwEq5PkhKHfb95cbuvnx4Ca0XpqKhN6VvSuXdEaHrvpw4P45ttulwHM?=
 =?us-ascii?Q?l8NQoR6adYfK45ZMcFtBHrBbxMQWlEtCekzhRiajZXVCQs2OIwbfGC0/l/JC?=
 =?us-ascii?Q?Yr7Zsm1PixNhEvvY/zyQW0WALbwA1oUD5LlaoJ8XibZaw6a7xHJvU1fDN5nS?=
 =?us-ascii?Q?o1Kwyw0IIDCMhSjKnAkUCXxgxBwxNRAmoKuNq0J9NAjQOfUnzGSbSnq6Gj1Q?=
 =?us-ascii?Q?R8XfYnTnvqVWHOmSI4NPwoZHPna0VcGhtFGoQEhxfjjsFmw3TkHdnFkU+Qms?=
 =?us-ascii?Q?YTa71q9JwNbzoor0ApYdw7CqwF+R6kRWeq23uTIL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c05dca7-cb52-43bb-054c-08db54472cfa
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2023 06:48:07.8210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3W5V9GlBej9hGdPQRh9PRR0c+sxw1MoYAPh0o3f4SOtnaJE9xOd2OUM6uLgP7MyV11Ctdkn4wInDq/iazZLug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8003
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2023 at 09:34:12PM +0200, Thomas Gleixner wrote:
> On Sat, May 13 2023 at 12:37, Ido Schimmel wrote:
> > Thomas, I applied the fix on top of net-next (which includes
> > 0af462f19e63). I'm getting the splat below during boot and then the
> > systems hangs.
> 
> Because I'm a moron. I got the same splat while testing, fixed it on the
> test machine and then did not sync it back before sending...
> 
> Updated fix which also replaces GFP_ATOMIC with __GFP_HIGH to prevent
> the allocator to wake up the swap daemons, which causes yet another lock
> inversion issue.

Looks good now. Feel free to add:

Tested-by: Ido Schimmel <idosch@nvidia.com>

Thanks a lot!
