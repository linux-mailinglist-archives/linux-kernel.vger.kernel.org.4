Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2817444EA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 00:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjF3Wfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 18:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjF3Wfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 18:35:34 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2131.outbound.protection.outlook.com [40.107.105.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1175F3C01;
        Fri, 30 Jun 2023 15:35:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZoRw0qpqZLfkfcxNx6DJ3hW8VZKEOxH4prAQ8RjSK/Pv4vvZSkQGiVJJod44cekgvoaSujYpRqdVe6tLVwcXkScCsO7Jw5ssqQVmW/TL5kbziRRwk+Oi54St3G+2XGv2X45OyXGHAKnKujb/itheAQcZXZZrHU5/ZSZTi7dfGNJ88BRxjJDvcf6WdjQOOAi44N8rj4yLKcRdzue0mgc/ggdGYK8t449UtSgJuD79JZ5bEMS/9S2DAMSlxvyoenTHnbYNh6Y8FElPFQwnW/zwyyD7/SyZ7/ShGlr+GzAPKNQSXGdY3u8+rsVcd6l/pv4Bt5c8CthXHK8HUvdiFQBbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKAVY2BJw0Z3yET/eE2eSiJDvutEBXQjAhgEVZxMlPY=;
 b=hCbLTQd82HjQ5y0gn/5/eYUSFC9gFpiybGxsNEtydCS1jqkOBFsNJ9twH1wZD5D6RH//ZVjhBVvIO7bmEbXN7qGJ1ds256vqGuWucsA4x1Pqkht3yiewEqYoPxJeqCd97zdBrSXV2+OxTEwNQ9TAsSUUDcJBjbsVDYGvPn4fPA+0ymVQHwLseHVxdUhEjcKFPvva75zYCYqRDQ3eQWRFdP89j5mzx4JkaT3Eyia6NTftgNDwEi8xga7YkROjJkhTOJtRIZQA/Wqm25GkIZtrvAecMJv9DbLkJZD9TGsDm7ifKcauk++egDhEdJAHOhpnZ+8S/WVB+13Lb7yspTZPSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cvut.cz; dmarc=pass action=none header.from=cvut.cz; dkim=pass
 header.d=cvut.cz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cvut.cz; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKAVY2BJw0Z3yET/eE2eSiJDvutEBXQjAhgEVZxMlPY=;
 b=Wk9N/RFdZrIWDB3Ga7cy7ckS/HhuHQpXF9wH5ZOpJ96TDVDjJqbBlO/xxX9Ma7I8+8kO1tRsGgoP4Xh+m9Y0d5wEdQpQOqPtBP/NK3H63zKsl8RnQve62Oq7xo+i4nlUTbNB+qgoI+x2ugBopycGyyRMwjvKp4FYhOgrMt3WJg+UlNgTnIgxIbg8m99bHEvRboqWHFqB05ewYb0i4wIDqvzChMNk4kTNjxLbg04ZZ3Nlnx0XMvzW0bs5ySnDwLiDzA51MvSsUE7k1LzSkvd+rLAUztTMNRkNwU44bSLOBjJAGpw43cj4CzE7HHEvT7Y3Rlrzi2PYWv3+bu/IRv2RNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cvut.cz;
Received: from AM6PR0602MB3749.eurprd06.prod.outlook.com
 (2603:10a6:209:1e::32) by AM9PR06MB8019.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 22:35:25 +0000
Received: from AM6PR0602MB3749.eurprd06.prod.outlook.com
 ([fe80::ae5:23c0:ec83:bedf]) by AM6PR0602MB3749.eurprd06.prod.outlook.com
 ([fe80::ae5:23c0:ec83:bedf%6]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 22:35:21 +0000
From:   Michal Sojka <michal.sojka@cvut.cz>
To:     Maxime Jayat <maxime.jayat@mobile-devices.fr>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Dae R. Jeong" <threeearcat@gmail.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: can: isotp: epoll breaks isotp_sendmsg
In-Reply-To: <11328958-453f-447f-9af8-3b5824dfb041@munic.io>
References: <11328958-453f-447f-9af8-3b5824dfb041@munic.io>
Date:   Sat, 01 Jul 2023 00:35:18 +0200
Message-ID: <87cz1czihl.fsf@steelpick.2x.cz>
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0032.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::45) To AM6PR0602MB3749.eurprd06.prod.outlook.com
 (2603:10a6:209:1e::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR0602MB3749:EE_|AM9PR06MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: 5144e4f1-8102-4848-11fb-08db79ba4985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ih11j8Rkw/kW4ulFkZJHwkYwetP+R1BFwzhwBmaBFudYWpYPa8bGRqp5ydJP9COFGjBd0RDFQpyb9wXhRPu2YqeqpsTvf2oNlRwZkOYUiJqLwURArY53ISZ1L1ckcN4CRYjtt9Ykj5FV24M2piTp86Nj9zEF/GKg0HzGmqGH2et65jxQHlTR4TmxFpxvYZBepwcegSXag/+iqbNzes1NVrmj7Z1gsRBRsBS2mzKweCjP2jRjHHZbDx8oXY2iGT/ruuxTyT02UH3zRCZTuyXINbviHbDkdwYPX0XzizQIGm4U6MImp8vmYEalv3fxzEQxqk0j+KLfaJmu33+xIIgecCYnieRwQDdjFv9TvvnHEgNgYrewt1bVH0FJCpnFgtRcs1GJ8e4bgZL1/SOvvQq7rsOTr2qBm14A8eikgokdO3k1VUdpfEXg0dFENXJc3e5bcqydOSXpM2BK8xmi5jwYSLa0Kz6V+lfLL+sKuDpAZz+0zvO/FTFyfVAGhUYdLNM3HlD29I+n/L9tgJi/JTca5r2VynlR1pBtQc0jItiNklnFAuzDuzCVyIl0Do6VlsC/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0602MB3749.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(366004)(39850400004)(346002)(451199021)(54906003)(110136005)(4326008)(8676002)(8936002)(5660300002)(478600001)(6486002)(66946007)(6666004)(66476007)(66556008)(786003)(316002)(41300700001)(6512007)(38100700002)(186003)(6506007)(26005)(44832011)(9686003)(86362001)(83380400001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vOzU4929Dp+ioscsozFG8zmjcYIthIS5C3z0TtnHhq+4j9n3u18npEjiNl+A?=
 =?us-ascii?Q?KATeKbWPPM2oHyh/VxyVhBCkE+QwbvQu1yRR5ZgNJNmviSIXl1T6SgMIG8Ne?=
 =?us-ascii?Q?0cAHmOjZiZy52JpPtekylIKAtAg1vHOLB4GLd621wbTaoRGS3IwLWySsrNIJ?=
 =?us-ascii?Q?iWwvZMo20K1LzTaPEz3SvCTGWsyHqkCsl4u7lkpNayFpHSTUb9Ogy2zaR/Jo?=
 =?us-ascii?Q?3dY9RLFnLJsD2CS1yJuCLa5RwK5Q8TwSS0U6hJ9SeXn702ajUXvNmdbsHMrM?=
 =?us-ascii?Q?jB6bXiIrdXqM1era6t/CbP0nbln8Zprbs9eq3aubVwAG6ISYcA5oBPTGAENG?=
 =?us-ascii?Q?d2jcARp3qGpOBBfwEL27Wg32X9tuKTcqjEU1nBmIsvy/aQfCK4AZ/cJtjiml?=
 =?us-ascii?Q?hR6EMEFl/bh3bxsWc9hFOcbEnJhPKnjkF7b/DNym3WvFpAKc27YBP/cm+pDX?=
 =?us-ascii?Q?iO9FYxSEBDdSsJeLoP6BShq4RTdyjyU8pk8uVXm87leGoctHvVCBUf3xMwwc?=
 =?us-ascii?Q?cdh6f2/36ZB4l4NZ1uv9j/DXA5vL+VLi4hrVC+En09KVmVKk84Iwt2XOy8Ff?=
 =?us-ascii?Q?mLebUOIc1VfmFaul0cbKgGXGKThvouWJcB37pwx6W7qkgkUP/7kZK2LPaPgA?=
 =?us-ascii?Q?vTKw7Uw+5QhF3beJYsm1kHU4KP+a1bX1HDi60/L7rssI/kFuNigWLzsvJ62U?=
 =?us-ascii?Q?/+DL6B6JemIBx/nwGRCyoYOau+eS6gdPxK2WfTkeXKZFxuyEM7CDMZ/hTeri?=
 =?us-ascii?Q?94C1+UV3oqVr8PL80E80bK1xX6ZozwjpJEV9J3/Drsw9L7Lf1auV7IuED6Z/?=
 =?us-ascii?Q?HBwBwE2WBjXwu6bgZNs6DZ9Ga7gBh+W/tXFwYstI7RSwisGvwKukC6mgFxEk?=
 =?us-ascii?Q?5iwDtbQyb9cn/JtCOoqJer3Y4kOXjpVCv34p5KHE0ppkGkTv9lEjlFEjotvC?=
 =?us-ascii?Q?GjJIFiueqduLPuye9Z+zetxlg+QzE6SVQcEvp69O37o4V09zmepRMQyWw8g1?=
 =?us-ascii?Q?/zqda6PSJt9z7PSe99vVSzPBKnT2wnAfuOB44v+IZ7VzYsp2G/IhtwHlgpMe?=
 =?us-ascii?Q?0lG8WQkANENM/IEsBayaJsco4fcXKev6TiFsrvh5iryV6O1UFYovxrVnPtf7?=
 =?us-ascii?Q?H9gQMZOa63hVeNWuLcDQRg2n5H4L7hdwUITrXWWbVCpm54fqPKr/kwweFo4e?=
 =?us-ascii?Q?JfbX+e4VwuuUZC5CIrx7u5wI7K1YJ5Bv2hgivfeENVbwirK8b4DfIq88JRbx?=
 =?us-ascii?Q?1Y551w4s3tHZ4E2J48z6kmGokYqAFbh5q2rPVGbvOKfMXcJdEdel5APmdTOg?=
 =?us-ascii?Q?+n1BwuNmAjapYMIcxA7/Y2hd3we/I67T24UJb/LpEaaGIB3LmwVEf9KXlpl8?=
 =?us-ascii?Q?6mJY5/+M0vJS0cMjgfIhKCVkONZJtUW1JdLWohW+nYk/gIujQmQ8xT5ran9I?=
 =?us-ascii?Q?QJw34Ar4v42S7yfYLzKLBQo1j0qmw+JPpyCANk9s9h6U7L837l9XRRZ+Y0wg?=
 =?us-ascii?Q?iBwZ7XZOl4Gesaj6WS0gpNBnld6PxGmlxTMtgItz+BmioyQdeRTjTwHOxwqA?=
 =?us-ascii?Q?1i49rf8zF1OPRwc2sZ2VQsCwEJqJ3asJhyTIzXyK?=
X-OriginatorOrg: cvut.cz
X-MS-Exchange-CrossTenant-Network-Message-Id: 5144e4f1-8102-4848-11fb-08db79ba4985
X-MS-Exchange-CrossTenant-AuthSource: AM6PR0602MB3749.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 22:35:20.8753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f345c406-5268-43b0-b19f-5862fa6833f8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fL6aGrQ6PVrgVkFk1K5p/+ZzD+bqTQNhpWRNxFKQR41RLxP/fItWg3BvNdQ4K4jA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR06MB8019
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Fri, Jun 30 2023, Maxime Jayat wrote:
> Hi,
>
> There is something not clear happening with the non-blocking behavior
> of ISO-TP sockets in the TX path, but more importantly, using epoll now
> completely breaks isotp_sendmsg.
> I believe it is related to
> 79e19fa79c ("can: isotp: isotp_ops: fix poll() to not report false 
> EPOLLOUT events"),
> but actually is probably deeper than that.
>
> I don't completely understand what is exactly going on, so I am sharing
> the problem I face:
>
> With an ISO-TP socket in non-blocking mode, using epoll seems to make
> isotp_sendmsg always return -EAGAIN.

That's definitely not expected behavior. I tested the patch only with
poll, hoping that epoll would behave the same.

[...]

>
> By reverting 79e19fa79c, I get better results but still incorrect:

[...]

> It is then possible to write on the socket but the write is blocking,
> which is not the expected behavior for a non-blocking socket.

Yes, incorrect behavior was why we made the commit in question, however
we saw write() returning -EAGAIN when it shouldn't.

> I don't know how to solve the problem. To me, using wq_has_sleeper seems 
> weird.

Agreed. I've never tried to understand how synchronization works here.
Hopefully, Oliver knows more.

> The implementation of isotp_poll feels weird too (calling both 
> datagram_poll and
> poll_wait?). But I am not sure what would be the correct
> implementation.

I understand it as follows (which might be wrong - someone, please
correct me), isotp_poll() should register the file with all waitqueues
it can wait on. so->wait is one and sock->sq.wait (used by
datagram_poll) is another. The former is definitely used for TX, the
latter is probably used because skb_recv_datagram() is called for RX.
But so->wait is also used for RX and there might proabbly be be some
inconsistency between those.

> My actual use-case is in Async Rust using tokio.

Our initial motivation was also Rust and tokio however than I did
testing only with simple C programs. I'm definitely interested in having
this working.

I'll try to look at this in more detail during the weekend. It's too
late for me today.

Best regards,
-Michal
