Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98ED0614663
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiKAJLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKAJLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:11:42 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60057.outbound.protection.outlook.com [40.107.6.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F51C60F9;
        Tue,  1 Nov 2022 02:11:41 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=FEpKyyHu2SZ7Zl1wBjT0S8QZK4yMBEz8+hd9tdbsvGiQPcrmuMijf1QuZRZQU/A4tt5DbSQqy7ckyvHBa/vj4OP6u61NMIX0xBGHNG4dptS3QNX1CyE4YSv1JIBHKhmX1JcM0LDyaOQAtZzJWmIOgDbSXztndv5gmAwHRmikj4WYReyhwmNMXZSQRLmD+sKbspoLzmlBRPI5bK0K7grX9RXlQiXTDV9V9zDg4X/NF+WdrFFZakmUEaOVeTLU8KDyHbdn5ZYU1VeO78k4Zp1X42fVfP8TAwcbMC3IuY1uuRHhxQkGjF0KISs0S/awFVzCnV8RMyMU1xdRE+v5z6HP4A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuQOb0ZvNm5BeuwPc9IM5rK/+6Fi1bBnuKNi1TWMwFc=;
 b=fmobU6Bp59hPa0ivHHZazuMuz62+MLX8g3dfyaNYaqiHhkVixPJv+rKKW5cdU4NGP4dd8nYmKLv3/m0GaU5r0dft6TvVeLZ8eRSOqBxAoNw34/kE1IMxUVOYP2xQOmbIJAoHPszBNK2AegDU9JQ1q1SPEiWzm1AWK6Z/yREcLdHXCp43SCWIqV2N092G7jfHhYnQHKmo6Ce7l4kWyQZKrJQUcfBcNOVEfmIgzFh/jU3/4B08/9qncYElTS2ij7gAYJCTxqFnXPNSSdHAp3uSBe9IcxQ5pm/pfsm1jSojKPWMcYEKEvk2//6h/DmX3lk7EF8YMJaBmeAub3E8JvUwpA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuQOb0ZvNm5BeuwPc9IM5rK/+6Fi1bBnuKNi1TWMwFc=;
 b=Em0tDxqw2/KfWBWFw+4kEezK5gs2hcOBJBCktTWvcig4qpAreV3Q77CdZKHPAfAH+Dh7KDYJrsiWIMWGW3pssWTSfupf78Yld5Dr1qU5FxeRb8vfe/tInmfpzRHbTWV7C+BkkQf6EwUyxBn+I4lw8k42bc0UjgLMtjb7ybKKh7U=
Received: from DU2PR04CA0156.eurprd04.prod.outlook.com (2603:10a6:10:2b0::11)
 by AS8PR08MB7885.eurprd08.prod.outlook.com (2603:10a6:20b:508::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Tue, 1 Nov
 2022 09:11:38 +0000
Received: from DBAEUR03FT049.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:2b0:cafe::9f) by DU2PR04CA0156.outlook.office365.com
 (2603:10a6:10:2b0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Tue, 1 Nov 2022 09:11:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT049.mail.protection.outlook.com (100.127.142.192) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.14 via Frontend Transport; Tue, 1 Nov 2022 09:11:38 +0000
Received: ("Tessian outbound 73ab5f36653e:v130"); Tue, 01 Nov 2022 09:11:38 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1233362068768165
X-CR-MTA-TID: 64aa7808
Received: from 7ec27c160198.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1F03189D-A1F3-465F-B9EF-46E6490BDA66.1;
        Tue, 01 Nov 2022 09:11:31 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 7ec27c160198.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 01 Nov 2022 09:11:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lidVBavqGjkac3AY+pluNrFOsQQmFcIvEhKF4vtX6khn+OX75yx3Qp2JvixDlkD2PEIWyjQ0lCNvXuZ94nHjAqZkvHjg2KEFs7O5HDelpmnNdcZ9Hz5m62o2mtdpYuDpJivSO/gZ01jD3Gt4aBbYI5qfsTVR0koXis804oDn4LHxz89lH1+HaE6MpH3rQd218gebw1OtLeBnsuPSfth2NkGKxUz2IfALoOODVVnUWSfvBeYz4V+RpC0oX0UwRQyf9S4gwXPQDWr67n1s6KOhXDnucXnuxUgztFzwdWvAjo4M6IygMPnM/C8owMMzdz9TFDBNKcLV8cKMCnNPPIJL8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuQOb0ZvNm5BeuwPc9IM5rK/+6Fi1bBnuKNi1TWMwFc=;
 b=XHteTLrWtb28JxCNIGjAmLrH0bdZLr6Pz4Ml5mOdOqwjdv70XOUOSQM5WBcFWtHjiPnnvy6DTZsPmc5ZvVqG5XpQwy8l0JwxW3hRdDcnPnEasIML4qpsVNvpb8KJbcdVE07HPE1PhhC4V9+C0U/sCcVXurVGJbVcxRQ6zBfnlOXwWIBKP6mokSDz/mLWR86cezbQWoxt1I3nmOeQz3FCTeX9vFXhPxLe2nFZ0mcNMPTkqdraS97M5TSw3NXmbGkNPPSsgYVKmFCY6vG6PbPMuX6i6x5p/KbXCtHzbSZxIpv9KzAegSeIzncJLpp7o6B7f5icZtaZY2BqqntYWDsgng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuQOb0ZvNm5BeuwPc9IM5rK/+6Fi1bBnuKNi1TWMwFc=;
 b=Em0tDxqw2/KfWBWFw+4kEezK5gs2hcOBJBCktTWvcig4qpAreV3Q77CdZKHPAfAH+Dh7KDYJrsiWIMWGW3pssWTSfupf78Yld5Dr1qU5FxeRb8vfe/tInmfpzRHbTWV7C+BkkQf6EwUyxBn+I4lw8k42bc0UjgLMtjb7ybKKh7U=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by AS1PR08MB7516.eurprd08.prod.outlook.com (2603:10a6:20b:483::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Tue, 1 Nov
 2022 09:11:29 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::8999:7c8d:d088:d198]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::8999:7c8d:d088:d198%5]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 09:11:29 +0000
Date:   Tue, 1 Nov 2022 09:11:15 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: linux interprets an fcntl int arg as long
Message-ID: <Y2DisyknbKxeCik4@arm.com>
References: <Y1/DS6uoWP7OSkmd@arm.com>
 <Y2B6jcLUJ1F2y2yL@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2B6jcLUJ1F2y2yL@mit.edu>
X-ClientProxiedBy: LO4P123CA0404.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::13) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|AS1PR08MB7516:EE_|DBAEUR03FT049:EE_|AS8PR08MB7885:EE_
X-MS-Office365-Filtering-Correlation-Id: 48212cc7-e5dd-4bfd-af14-08dabbe91533
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: effhx6OoF12KPBoOLd3YiH/KUanAfqguc/6N+JRmGdyY9TMpqjleZnAmHe2jdDjTVhSvzmBJa63NFqqxoqCyFqSsLx6gz2yBuHI5qCUcsOtg+f4VA7gzWBVLrnGTnoLqRWGNc8JBRA65kv1sCOhEIaB8IWyAiCx/BF/vpMQ7LO0+yk+kqf56AATsovQJZ2xVHbmuAyB7F1zIw20JZpBIoO/JxRDpWClu/HPtlbuaBiIdtsAFtK9ctM97UdaaSiqCBlbCdN6OvIwG0s1NEOYUBzoi/SV9UGk5qPPM1D55a9g1HMOgXTCzJhrtEXXO3GKn8VkAW/POtkMU7uu3Xo1cvU55bhn6kyAj8FhYQTgHD+eq0l1+b79oZFJKt6j4TEjlNcWbTNyxPogp16unNAdzmheEdVDcefr2KaS9jRrAdDUl/gyBB74ik2VlfTipJc7g10AMnN91k+1S+IkqeCJ8njL9TInwRsYChfdgzA2umTwxo6qd0iS6NL/mxcr2WT7IRDWJ1I9LGtmLtMzo4rMHAw/CWIQUEjzE4HDYJsr+0D8YBN8/rwIfORZ92CbFNjURhAttxzf/Jm5Aw36VjhMt/9C7GBTFjxStRjdQ3fz1B5rIpE2dH9qjat9EEqs79Gea+lsrYqzpEnb/AxIzAKjEsFyqjfRVS/V7qotiryRFbViYcXVIxEWpgAqnUG46HclH
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199015)(44832011)(5660300002)(2616005)(6666004)(6506007)(86362001)(66946007)(66556008)(6512007)(36756003)(26005)(478600001)(8936002)(2906002)(6486002)(66476007)(8676002)(4326008)(38100700002)(316002)(186003)(41300700001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7516
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT049.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3c8c53df-6323-4b32-ceff-08dabbe90fbd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LY7CfukNgHz6VQjF2f0pm3gjPCWYtQZ3Q+2fjQXbydQvIY1XZs/20hUqWn+dUBUQcIT29XStsrq/hhHmBnldsqFuW2LcyD56pesK4XVz3omxm8eHO9TtJ9IL6WHFOYnVzdJDLUxIxU25/xMs6pNbv8vDiww5f8CdBinFtxuIRvRGHS5Uxl/biieqIB70FbEvfqmy0tFa28AJaPqQmxmWPeckb3YTiw0EGz+cJn91HB1qthKy1bWKB6f9w9hlm5KnH1bZll5mrHtyE0VM0ASALbxY/OeqEbBpKTZUb8jQ+7gdmZrGRNMNboLKUhWU5EVMCZl7/IBvtLzgx42fTPDDSJgaRVAq+7lVX+9ii9IhH/m0fCaqGdViVxvx0JZGmY94m+mmjYb8nyRUHfVtbRzEtRQ6jYS7FTfIkOVQxvkK/pvhMMAuhqT1T8E2xw+i0soqwfbzG7ZR/vawSijO7LNXXuAaRysZ36aLSt0aiZx3GZo50mU7ngc4Y/wbNxZpAjI//kTQZiKKVIQUeuxU6SlVx0fKfbsHp9J/My4pIvVODh9vpAURRMrL0IM8HRgmrMd77aKOrPNtj/SIUolMDpg/aVvd6LJRVV1RPoHdcWQS3nnBKkCy7d3TgnITaFxo6673BFgS/7jggey+op+WTLuK23n7W8oI3TDlXxIWo3ZTU3Qz2U7YgW9y7hKfW8PqgQzzqjb9DU+t89UvUr6cnLBmq5rSY9x7JW63lu+VoxdFBYlZ5umJsj4qO7St801ktvL2p9WGbAuRIgOSfN24hUCcvQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199015)(40470700004)(36840700001)(46966006)(82310400005)(36756003)(2906002)(86362001)(336012)(40480700001)(47076005)(6486002)(356005)(41300700001)(8676002)(6862004)(5660300002)(44832011)(4326008)(81166007)(8936002)(6666004)(2616005)(70586007)(82740400003)(70206006)(316002)(36860700001)(478600001)(107886003)(40460700003)(6506007)(186003)(450100002)(6512007)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 09:11:38.2735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48212cc7-e5dd-4bfd-af14-08dabbe91533
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT049.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7885
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 10/31/2022 21:46, Theodore Ts'o wrote:
> On Mon, Oct 31, 2022 at 12:44:59PM +0000, Szabolcs Nagy wrote:
> > and such fcntl call can happen with c code that just passes
> > F_SEAL_WRITE since it is an int and e.g. with aarch64 pcs rules
> > it is passed in a register where top bits can be non-zero
> > (unlikely in practice but valid).
> 
> In Linux's aarch64 ABI, an int is a 4-byte value.  It is *not* an
> 8-byte value.  So passing in "F_SEAL_WRITE | 0xF00000000" as an int
> (as in your example) is simply not valid thing for the userspace
> program to do.
> 
> Now, if there is a C program which has "int c = F_SEAL_WRITE", if the
> PCS allows the compiler to pass a function paramter c --- for example
> f(a, b, c) --- where the 4-byte paramter 'c' is placed in a 64-bit
> register where the high bits of the 64-bit register contains non-zero
> garbage values, I would argue that this is a bug in the PCS and/or the
> compiler.

the callee uses va_arg(ap, type) to get the argument,
and if the type is wider than what was actually passed
then anything can happen. in practice what happens is
that the top bits can be non-zero.

many pcs are affected (aarch64 is the one i know well,
but at least x86_64, arm are affected too). and even if
it was aarch64 pcs only, it is incompetent to say that
the pcs is wrong: that's a constraint we are working with.

the kernel must not read a wider type than what it
documents as argument to variadic functions in the c api.
(it does not make much sense to expect anything there
anyway, but it can break userspace)

