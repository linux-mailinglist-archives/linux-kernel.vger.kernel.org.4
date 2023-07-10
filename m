Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DF674D371
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjGJK3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbjGJK3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:29:17 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372B6DA;
        Mon, 10 Jul 2023 03:28:50 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 369MmEFj028927;
        Mon, 10 Jul 2023 03:28:20 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3rq55p4twn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 03:28:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzyAV2swQfBngxMazM/bezf7AW+bw+C1L0M96vncH14yS1C1DW+X8x9assHGInMC3xzxjz23MqUJLkGoSrIm3dXI13FXVXKpRQJY3jKbXF8r4pQfpo6IXwcK32+7cyaZ67MDzjda0BvVVm6QXqBkFwwapWAdBu1QPhXQWSVu9FrmjG3QQQkcWVNfpYOwjlxGvz3wimNdCmwIogckw9lgxYuXTCrNAKN4xLb4oaxIXdBw9+AnhMIv7PaClCyNPY1qu+Jmx/BPvNJ9CmSPv/2SKUig+iPczzeH9nhEWYM3C0yJylGd8J7lEckmTMhoWUJhkvXiDc8a0YcMRFlm6nkKWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zC/hW2gjsZ6f1bINlRjWky14KpMv1BL9FDPMSfzU8zQ=;
 b=YfBRa5LBIDtlou8VK4gJEo8sVCegn8UdxbrrAjrxI9kfOBRa/s1b1MJXaAR3PgORebr8YdwGi9dLusonPMKXzQq3r+bO6+2y6KcHim5pTam+A0srz84nSQ83QZFpbat1/7QkSqO4O5weNh4XrjF3+EW83nBzhV09ZL2swfRptWH66pR93rZ2asQEvKWxKspRMogrSSshtMClzcDp0mG3bzaBCtAuHblNtQZxM4ErrBe3/6W2Q2Y6ol6Mft8jXC2K5BnmAgGC3enZ5al2vBGFWZN+QdbJ6Q19dyE7zTDJWN1nj8zw4tQ6kB8Czi9G839fdwxV3bGXGHgSTc8PWyJ7YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zC/hW2gjsZ6f1bINlRjWky14KpMv1BL9FDPMSfzU8zQ=;
 b=cdLcQPafcTQvoY87TXm1VsjhNqTDEZKED3H+GugpG8SBLgldrAo9PZxvSacPvKxNjvbnxihbr5tAGrI72tjESUnhFCVVp6FWkAMSv4ggM22gescLaluvCZGY5TIpWwymUTdzShBmWKnWVvzoVQ2CD/a3CmmgcCeXJFGjpLh2Tj4=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by SA0PR18MB3647.namprd18.prod.outlook.com (2603:10b6:806:92::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 10:28:17 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::ec1d:671b:dbbf:706a]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::ec1d:671b:dbbf:706a%6]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 10:28:17 +0000
From:   Suman Ghosh <sumang@marvell.com>
To:     Michal Kubiak <michal.kubiak@intel.com>
CC:     Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [net PATCH V4] octeontx2-pf: Add additional check for
 MCAM rules
Thread-Topic: [EXT] Re: [net PATCH V4] octeontx2-pf: Add additional check for
 MCAM rules
Thread-Index: AQHZsIaYZhp+Lo6+LkG+xdSrU5TZPK+uqeCAgAQnReA=
Date:   Mon, 10 Jul 2023 10:28:17 +0000
Message-ID: <SJ0PR18MB52167D52889AA5885844F554DB30A@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20230707035321.2227742-1-sumang@marvell.com>
 <ZKhhFeKmxlN3hFYD@localhost.localdomain>
In-Reply-To: <ZKhhFeKmxlN3hFYD@localhost.localdomain>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc3VtYW5nXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctNzljNmNlYjItMWYwYy0xMWVlLWI2ZGMtODQxNDRk?=
 =?us-ascii?Q?ZWVhNTRjXGFtZS10ZXN0XDc5YzZjZWI0LTFmMGMtMTFlZS1iNmRjLTg0MTQ0?=
 =?us-ascii?Q?ZGVlYTU0Y2JvZHkudHh0IiBzej0iMTgwNyIgdD0iMTMzMzM0NTg0OTQ4NDI2?=
 =?us-ascii?Q?NTEzIiBoPSJqL09YMHM2SnBSL2ZENTA0anZOT3E4eU51QVU9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFONFBBQUFS?=
 =?us-ascii?Q?QnlBOEdiUFpBVFd0alJLVXc4UTZOYTJORXBURHhEb1pBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFCdUR3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUVCQUFBQUk3cVRwQUNBQVFBQUFBQUFBQUFBQUo0QUFBQmhBR1FBWkFC?=
 =?us-ascii?Q?eUFHVUFjd0J6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdNQWRRQnpBSFFBYndCdEFGOEFjQUJs?=
 =?us-ascii?Q?QUhJQWN3QnZBRzRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFZd0IxQUhNQWRBQnZBRzBBWHdCd0FHZ0Fid0J1QUdVQWJnQjFB?=
 =?us-ascii?Q?RzBBWWdCbEFISUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCakFIVUFj?=
 =?us-ascii?Q?d0IwQUc4QWJRQmZBSE1BY3dCdUFGOEFaQUJoQUhNQWFBQmZBSFlBTUFBeUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR01B?=
 =?us-ascii?Q?ZFFCekFIUUFid0J0QUY4QWN3QnpBRzRBWHdCckFHVUFlUUIzQUc4QWNnQmtB?=
 =?us-ascii?Q?SE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVl3QjFBSE1BZEFCdkFHMEFY?=
 =?us-ascii?Q?d0J6QUhNQWJnQmZBRzRBYndCa0FHVUFiQUJwQUcwQWFRQjBBR1VBY2dCZkFI?=
 =?us-ascii?Q?WUFNQUF5QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFB?=
 =?us-ascii?Q?QUlBQUFBQUFKNEFBQUJqQUhVQWN3QjBBRzhBYlFCZkFITUFjd0J1QUY4QWN3?=
 =?us-ascii?Q?QndBR0VBWXdCbEFGOEFkZ0F3QURJQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFH?=
 =?us-ascii?Q?UUFiQUJ3QUY4QWN3QnJBSGtBY0FCbEFGOEFZd0JvQUdFQWRBQmZBRzBBWlFC?=
 =?us-ascii?Q?ekFITUFZUUJuQUdVQVh3QjJBREFBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWkFCc0FIQUFYd0J6QUd3?=
 =?us-ascii?Q?QVlRQmpBR3NBWHdCakFHZ0FZUUIwQUY4QWJRQmxBSE1BY3dCaEFHY0FaUUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: =?us-ascii?Q?QUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmtBR3dBY0FCZkFI?=
 =?us-ascii?Q?UUFaUUJoQUcwQWN3QmZBRzhBYmdCbEFHUUFjZ0JwQUhZQVpRQmZBR1lBYVFC?=
 =?us-ascii?Q?c0FHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFB?=
 =?us-ascii?Q?QUFBQUFBQWdBQUFBQUFuZ0FBQUdVQWJRQmhBR2tBYkFCZkFHRUFaQUJrQUhJ?=
 =?us-ascii?Q?QVpRQnpBSE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFRQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFD?=
 =?us-ascii?Q?ZUFBQUFiUUJoQUhJQWRnQmxBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhB?=
 =?us-ascii?Q?YmdCaEFHMEFaUUJ6QUY4QVl3QnZBRzRBWmdCcEFHUUFaUUJ1QUhRQWFRQmhB?=
 =?us-ascii?Q?R3dBWHdCaEFHd0Fid0J1QUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0Iy?=
 =?us-ascii?Q?QUdVQWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QnVBR0VBYlFCbEFITUFY?=
 =?us-ascii?Q?d0J5QUdVQWN3QjBBSElBYVFCakFIUUFaUUJrQUY4QVlRQnNBRzhBYmdCbEFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQW5nQUFBRzBBWVFCeUFIWUFaUUJzQUY4QWNBQnlB?=
 =?us-ascii?Q?RzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFISUFaUUJ6QUhRQWNn?=
 =?us-ascii?Q?QnBBR01BZEFCbEFHUUFYd0JvQUdVQWVBQmpBRzhBWkFCbEFITUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
 =?us-ascii?Q?QUNlQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUdFQWNnQnRBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-rorf: true
x-dg-refthree: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlB?=
 =?us-ascii?Q?QUFBQUFKNEFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFad0J2QUc4QVp3QnNB?=
 =?us-ascii?Q?R1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHMEFZ?=
 =?us-ascii?Q?UUJ5QUhZQVpRQnNBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhBWXdCdkFH?=
 =?us-ascii?Q?UUFaUUJ6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBYlFCaEFISUFkZ0JsQUd3QWJB?=
 =?us-ascii?Q?QmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QmpBRzhBWkFCbEFITUFYd0JrQUdr?=
 =?us-ascii?Q?QVl3QjBBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFB?=
 =?us-ascii?Q?SUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWNBQnlBRzhBYWdC?=
 =?us-ascii?Q?bEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFHTUFid0J1QUdZQWFRQmtBR1VB?=
 =?us-ascii?Q?YmdCMEFHa0FZUUJzQUY4QWJRQmhBSElBZGdCbEFHd0FiQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUcw?=
 =?us-ascii?Q?QVlRQnlBSFlBWlFCc0FHd0FYd0J3QUhJQWJ3QnFBR1VBWXdCMEFGOEFiZ0Jo?=
 =?us-ascii?Q?QUcwQVpRQnpBRjhBWXdCdkFHNEFaZ0JwQUdRQVpRQnVBSFFBYVFCaEFHd0FY?=
 =?us-ascii?Q?d0J0QUdFQWNnQjJBR1VBYkFCc0FGOEFid0J5QUY4QVlRQnlBRzBBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reffour: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFB?=
 =?us-ascii?Q?QUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBWHdC?=
 =?us-ascii?Q?dUFHRUFiUUJsQUhNQVh3QmpBRzhBYmdCbUFHa0FaQUJsQUc0QWRBQnBBR0VB?=
 =?us-ascii?Q?YkFCZkFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCdkFISUFYd0JuQUc4QWJ3Qm5B?=
 =?us-ascii?Q?R3dBWlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0IyQUdV?=
 =?us-ascii?Q?QWJBQnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFjd0Jm?=
 =?us-ascii?Q?QUhJQVpRQnpBSFFBY2dCcEFHTUFkQUJsQUdRQVh3QnRBR0VBY2dCMkFHVUFi?=
 =?us-ascii?Q?QUJzQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFB?=
 =?us-ascii?Q?QUFBQUFBZ0FBQUFBQW5nQUFBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QndBSElB?=
 =?us-ascii?Q?YndCcUFHVUFZd0IwQUY4QWJnQmhBRzBBWlFCekFGOEFjZ0JsQUhNQWRBQnlB?=
 =?us-ascii?Q?R2tBWXdCMEFHVUFaQUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2QUhJQVh3?=
 =?us-ascii?Q?QmhBSElBYlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNl?=
 =?us-ascii?Q?QUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhRQVpRQnlBRzBBYVFCdUFIVUFj?=
 =?us-ascii?Q?d0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0QUdFQWNnQjJB?=
 =?us-ascii?Q?R1VBYkFCc0FGOEFkd0J2QUhJQVpBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFJQUFBQUFBQUFBQUFBQUFBRUFB?=
 =?us-ascii?Q?QUFBQUFBQUFnQUFBQUFBIi8+PC9tZXRhPg=3D=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|SA0PR18MB3647:EE_
x-ms-office365-filtering-correlation-id: 376cf302-e8ab-4dd1-f7a6-08db8130600f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xKzbqRotd7swqwgvpNn9bMZZ0vfzUq0vLD6g4b8BfiXtCsv0uAwYcRfaldvHyHyKtNI7VIqLYrnFfhwJSzRjQuN2sG6mlHw6+qEwBS3KeWRcESOB64XZiHslGPeTxlBPAIZ6WIcIUWM/7QHcW7i9IBbOLMY8f44Ej2Zy55IRAMIGjePDn1qP8hC1gM0FkKtq/W4DdLQC0x8CEpV3sFg4Wohgk46UzmAtDU7OYSn12IswxWIQESOA80T1lr+I+R/N8h+qIHF2Z4VqaMk83f0zItpiNSCZW/wY2RqIoNWz6Z2BdtUQ7Fnt9egPSRYKaahglI60AjMTGAeFoxwpE7hRzFnAEAp7VIJ6v5WoiIOr073Rqnd7YClZ0Ez5wZ7lvd0qrx0S8x9nQq2ZwFbVlvaQW6eU6HTPaWLTegEoW82jybiDu1UaiyJwx/le9ex/KHLlRe+gPNUTGbNTdfmehZr0PD7QKK6asFHE7fguB1W/JdzPfCSAHCM4XJ99m8AjXTuIHIuGy536cgM86hQiaHZ4DipSQEvvEbAyR/VMrqvHs1/6Mac3qAXYHxIosjEne1OVGxJxlA4c61GJBGR+vvUp/rGKi6nA4Vugz+gcK7kxUDFy+ytvj2lbt1Igt3q6yc8V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(376002)(366004)(136003)(396003)(346002)(451199021)(7696005)(478600001)(76116006)(54906003)(71200400001)(83380400001)(38070700005)(33656002)(86362001)(55016003)(2906002)(66946007)(26005)(6506007)(186003)(9686003)(38100700002)(122000001)(8676002)(64756008)(4326008)(66446008)(5660300002)(316002)(6916009)(66556008)(66476007)(41300700001)(8936002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BisD2gxWFWpZWzgtl+O2N+dq9lvcs7GZI/u7JdsC8+pgx4OqzIvnhEid6HqR?=
 =?us-ascii?Q?sDOOb7Xq+19d8OJWizDwekTHbG1KIXBL0HZqcDGTtt/spnKsmObZJQ6oTz7u?=
 =?us-ascii?Q?suY22lj7P1c5c3eusjGQuQwxm5kOo9gBH0FEMhZcrbxuEXFhkEOtVaIYIlOa?=
 =?us-ascii?Q?aWwm91AvfUCYNm8A85wzYCJNRfQ9lMyT5RcYyqsFfreTCE5RaQMm4HwhbqbD?=
 =?us-ascii?Q?2nzYuoYCKVY1Sg7PFmQ1Ut29lUHKcDzdvVz5W65RBxlP4vPYo03i/bMVT66n?=
 =?us-ascii?Q?K7bGwqYO/vxykuo1weUJqBQjh6g2ju4+OOm1ke3MVduQJIflSa4+/wwRHl3S?=
 =?us-ascii?Q?8uDvDgvhIMo8oqiA72AVKi1uMJjQ+zhUS8EWfAqMTZ1YNLxF4nKXlmRsl3N1?=
 =?us-ascii?Q?ZphCkvyjmmWAoa1a23fVpy/Hqs/7HuHNqYbqL42iQEPmLmN+iUt3748uLJ3L?=
 =?us-ascii?Q?zfA10R9N6qVFXZq4dFYSs/K8Gd2siBK2DoEPtYGn6VZb4RD4LHOv2bePDyab?=
 =?us-ascii?Q?dCBIEHigfgg857jh2dKDHyWOrLiUWZZBhMLy132HPMczFqvi98MqKzubHTLh?=
 =?us-ascii?Q?oKMcj6BwrFZIDu0NdRYBQpfD43hJ9DzzosrCN3q2C6XpvNWYEriqHn8SavX6?=
 =?us-ascii?Q?AgPxJG+KVYxEkegTECRL25cG7AdZbnjDj0JrDnCZPglMYTJJuD+80hMdF6no?=
 =?us-ascii?Q?dinKzVntofBJkso8b/XFmXpX6n0QgYps7xg90qUtKlUNX4p75ivqxZmiIcgO?=
 =?us-ascii?Q?7tgGW3d6SJ22I6HSs71qDK1jyzZv1QJC0fVmcTbcuMWxZuZSFfZrBC6P82mS?=
 =?us-ascii?Q?D4okta3Ffel5tFDzAP+XJOc9dedg8p9iUz2Y2R5RJkZL30KFJV+BtFVfNvvy?=
 =?us-ascii?Q?7aRxt/CPoGusWChYdiU4zNw7VU/gL3021fVwt0qS4YZRmcuWnTgIf9+W0vjY?=
 =?us-ascii?Q?PewWSeaWhDieZd/l5yLd2Vu8QpNhIrFFbdlD3ykOZaXHcZUc5ZrWTWt54R29?=
 =?us-ascii?Q?retMKWarC1NYScvEyGMlfVExuQxIZiel/dunEXHQYfSJ6tbHE3LmMBASh6J7?=
 =?us-ascii?Q?FKa1HSupDEO2SZZlwbDm/j5ySygNxRG+mq/cjZ56MX+Bx6kmPjmeNWCaM+/C?=
 =?us-ascii?Q?itPCnK3Z8QO4DJ5DsGnVaj6vhJl82/1yiYnteL8b8emtP2nkp5ljhaQ2BdK3?=
 =?us-ascii?Q?8ymS9t3N5O1sphlViPutEfobqDAM0cvwQs4buCA2ynRmTo+qM9Jjxf9bq+EC?=
 =?us-ascii?Q?c04XGcuBlvdeXqfIKIbULgHSIdyp2647In4GkS4dthdasISRjYSk847HbR2s?=
 =?us-ascii?Q?VOMw0jkWSF49IKHmGyZhMoQLsNTyPPF2UTIBgEv/F0I8dSjCM+8jQUll5tns?=
 =?us-ascii?Q?Kh9BNn68pgjfCaRpehfQ3gLm72YgVWY1PE47R2KjhyWZjYDQE/ZbJSHfn9f4?=
 =?us-ascii?Q?WcqQ8uHScRfHHHyUnCLpO6uK79TsuZgNfQztirNvpfXoEaF4Xzn2bKgnxgfd?=
 =?us-ascii?Q?hbOdk3Oz7Qohn/MLarzRWAEVn9ZLg1Sz0EpyLin0Jwb5Fhmw6uz9axhyM7PE?=
 =?us-ascii?Q?5qpTpzxamwOO+N9gIpo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5216.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 376cf302-e8ab-4dd1-f7a6-08db8130600f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 10:28:17.3060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bbHsBdqVD8Kd65uYn6vJALKgTgEwyXwW+b6kLcai0F7efg1YQ8v0k5ypq6qhtKtcbNM+BBqHFOgf2JXRJWngtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR18MB3647
X-Proofpoint-GUID: z8w7y6_qe4HBl1SFXgyVvoz0-KtUBWdn
X-Proofpoint-ORIG-GUID: z8w7y6_qe4HBl1SFXgyVvoz0-KtUBWdn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_08,2023-07-06_02,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>----------------------------------------------------------------------
>On Fri, Jul 07, 2023 at 09:23:21AM +0530, Suman Ghosh wrote:
>> Due to hardware limitation, MCAM drop rule with ether_type =3D=3D 802.1Q
>> and vlan_id =3D=3D 0 is not supported. Hence rejecting such rules.
>>
>> Fixes: dce677da57c0 ("octeontx2-pf: Add vlan-etype to ntuple filters")
>> Signed-off-by: Suman Ghosh <sumang@marvell.com>
>
>(...)
>
>> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
>> @@ -604,6 +604,19 @@ static int otx2_tc_prepare_flow(struct otx2_nic
>*nic, struct otx2_tc_flow *node,
>>  			return -EOPNOTSUPP;
>>  		}
>>
>> +		if (!match.mask->vlan_id) {
>> +			struct flow_action_entry *act;
>> +			int i;
>> +
>> +			flow_action_for_each(i, act, &rule->action) {
>> +				if (act->id =3D=3D FLOW_ACTION_DROP) {
>> +					netdev_err(nic->netdev, "vlan tpid 0x%x with
>vlan_id %d is not supported for DROP rule.\n",
>> +						   ntohs(match.key->vlan_tpid), match.key-
>>vlan_id);
>> +					return -EOPNOTSUPP;
>
>The code got very nested here.
>Please consider moving the above check to a separate helper function, or
>at least reformatting the error log to fix the checkpatch warning about
>80 chars, for example:
[Suman] Will do the suggested reformatting in next version.
>
>			flow_action_for_each(i, act, &rule->action) {
>				if (act->id =3D=3D FLOW_ACTION_DROP) {
>					netdev_err(nic->netdev,
>						   "vlan tpid 0x%x with vlan_id %d is not
>supported for DROP rule.\n",
>						   ntohs(match.key->vlan_tpid),
>						   match.key->vlan_id);
>					return -EOPNOTSUPP;
>				}
>
>Thanks,
>Michal
