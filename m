Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9C2614B1A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 13:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiKAMtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 08:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiKAMtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 08:49:43 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005101ADBB;
        Tue,  1 Nov 2022 05:49:41 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=m6bVUkhNL97EVgSo9fTiivfJO2l6d08nkjLZJuckIbQN9hXAQVMf6OzCTGFwasCVfJmlTfZab7Nd7+sf+CZuyHj9DqCLUiDwQ1Kvt3ZC+m6dQVOsysZVNbztHr5QeEKYk0GvMvT8vFjSzhtu0W75VCzbUQb4qLkTQRyu+5i7uqlPGze5UfH0VKHlu56Lcdn10RRZ5fF6gnHFtW7s3tVKnTkTQmdOL7P4qvUHnNepiZVZ8bE17Ov2cqn1m+V7pDiDQfGRWyl8FM8Hpjp7HLB+AHcZ+EjBkCDT7ZLubtiAOqfZ3f7JKXxVdsVucelfPkeKLaS9h4R3aG7WL8ArvsCM/g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8E0M0WsfhgI6bkdY2wtJKDrCK9yM3qpwnmLMIdRwrU=;
 b=ZJuxShnrGgqBAIHDZHUrTehJwk5U8Aph4mcVCbuNC6z3UpOJGGdOpEvPQ0rHFt+jdCUs7z6KSdd62uphWDreo2bAMGJGt2e9vXcv1pHqt0xutgwaqwTyLhwjJ285mGyCg1xTMZdsAwalXAuM6vO8qXaLjb+3MggBtEC4KL3OIOVEq4mhEZLrNCatJ2tV2XmPg7u7CFA2InSeBCXa67TkT1WX4F6UUOthAFlu31LxpCfQ/j8D+BqqSn+3l4MevyPlTcR3Qhh0+Kyg9hJpxDc90XApOMCgG0lKZntdpkH2Z5zW8BSHyzZFynkm83vImqVAANfzKU+BQuDrAoJbkpdjSA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8E0M0WsfhgI6bkdY2wtJKDrCK9yM3qpwnmLMIdRwrU=;
 b=tPNG+tceNMoKoO17M+qmsge3Tftt6dQ+KzfBmFiSwLBGg2UUyzqUw6ptivTwc4RkEGzQgI7bJCzyIicuG6DI3UQdj4PhaKzhXQTumUhK4dWfkAsDInnhiNF6VoKD2SpbCevziov3GVVI0mRvJFcTbu1Tg98fkGX1GU/kCewc4Rk=
Received: from AS4P192CA0026.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::10)
 by DB4PR08MB8152.eurprd08.prod.outlook.com (2603:10a6:10:380::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Tue, 1 Nov
 2022 12:49:38 +0000
Received: from AM7EUR03FT010.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:5e1:cafe::34) by AS4P192CA0026.outlook.office365.com
 (2603:10a6:20b:5e1::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21 via Frontend
 Transport; Tue, 1 Nov 2022 12:49:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT010.mail.protection.outlook.com (100.127.141.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.14 via Frontend Transport; Tue, 1 Nov 2022 12:49:36 +0000
Received: ("Tessian outbound 2ff13c8f2c05:v130"); Tue, 01 Nov 2022 12:49:36 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0dfa640a10e3d825
X-CR-MTA-TID: 64aa7808
Received: from 82fdc8b2df50.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C4ADC9AC-99EA-4956-94FD-2E48A10F0CC3.1;
        Tue, 01 Nov 2022 12:49:28 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 82fdc8b2df50.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 01 Nov 2022 12:49:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k48G9LZoOSErLnGAZPQtgNAXo7A1vaDB2YT60wtDeyjQOoFwDpJZqyAeSFq6qQaj1FGCWwiQprK43t7Yj3NR0KbBub4QLBGOMyJMckrHKOsP910bsT3ZxCQnM++LoXDxYU72r0OZ7HzQGX83dzh/fY7Psx1VHbl0STpMyY+87m9tepTNJbujbanP55WfYgE28evBcln7gRFAcWAKKMurMiFDyXCzE2AZKQS5LVKYPTaQSA8rTRhqercgUCx7/gxZKeTyBqX3mXdvCeCTOgqAn0CKKaV1o7J5UVFN3SID3IFk/g0A0az1JBkELBKEq9tB3jU4G0KGpiNMj5gEuEvHWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8E0M0WsfhgI6bkdY2wtJKDrCK9yM3qpwnmLMIdRwrU=;
 b=R6AJw5d62CVI1KTjE5RmOs7i+OoY3PZ5UlxJcQ9jQqZ/AKW0dqd1o+6TEcJcK0JVadzgjARTXnTMdyTcjuMvEc/mwl17wYsWM115RnIlCoPs4OYEXfDEW+kmiT+m3EguGhmBIMSum6ezE/uKyi1Eb1pT+Za+a5JJW+ODynUi/123mDKNJFV3mg0SV1O3KgqQlSxIoBBHr8Vk7x3KUH8gdFYF4PMzCSNAiuhhlHUzgb7YSDmCff12QkVucCCUYowMD8Uns3pxmvlYktpNg84TebxaRDDLYUR4H74DZNGt7SVfn6oe1B5+qcJ+W7bS8tR5v9Nfz38pIrdKN2FUzHAgBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8E0M0WsfhgI6bkdY2wtJKDrCK9yM3qpwnmLMIdRwrU=;
 b=tPNG+tceNMoKoO17M+qmsge3Tftt6dQ+KzfBmFiSwLBGg2UUyzqUw6ptivTwc4RkEGzQgI7bJCzyIicuG6DI3UQdj4PhaKzhXQTumUhK4dWfkAsDInnhiNF6VoKD2SpbCevziov3GVVI0mRvJFcTbu1Tg98fkGX1GU/kCewc4Rk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by DBBPR08MB5961.eurprd08.prod.outlook.com (2603:10a6:10:203::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 12:49:27 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::8999:7c8d:d088:d198]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::8999:7c8d:d088:d198%5]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 12:49:26 +0000
Date:   Tue, 1 Nov 2022 12:49:11 +0000
From:   'Szabolcs Nagy' <szabolcs.nagy@arm.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: linux interprets an fcntl int arg as long
Message-ID: <Y2EVx95XUEVOn7p3@arm.com>
References: <Y1/DS6uoWP7OSkmd@arm.com>
 <Y2B6jcLUJ1F2y2yL@mit.edu>
 <Y2DisyknbKxeCik4@arm.com>
 <a0693686d0ae41599fe1700680ec56ec@AcuMS.aculab.com>
 <Y2EGtE05hcVn3B3a@arm.com>
 <0030a20a94cd49628c5461d044bb28ed@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0030a20a94cd49628c5461d044bb28ed@AcuMS.aculab.com>
X-ClientProxiedBy: LO2P265CA0168.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::36) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|DBBPR08MB5961:EE_|AM7EUR03FT010:EE_|DB4PR08MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: e7a537cb-44ce-465b-2543-08dabc0788b1
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: dD7+jZD6hhJAAiLfuEMoAZ1JI3JiRYnhrNIxkmMDLRKqgaI0fnYQZSi4HTj7N38Z4+nHWuOFzMMyQb8/bwSN7gnZYPlHdcXNXfRk6mki3Er2yLdsh273QS7DyKBximhHVfZRWb/47wGFAnGgBVPnuqRzQaVjZEm9ddHgXKtsN3XnkmWAcIArLbHwxu8VTECFJbRUPWVyJ2OvGwU7K+bvseDFXgVWdJy6AEHRv1CkNq3Ifw2anX6vGpgli4BW1iVBA627YCdwKo/btHAkd5fiiD4o6Pk3Q8/SJXF+naugcp4S8FNvLomXldOZVEz6gammfVVCAdTHh+yLZeFWCg8QW+ni/A8d4tJiWcEIioa/rsvG6MeOEhOJtKEB9Nj2XE0lSfDH0+AWI7yzh9QtSgn1kF4rHfHLMMDto76r/Q5mqChr5z/7WXMI2JSx2Bv22sPjGhw5sD16/tB2KxfYDI+C8QZOurMvUXHkEmCpLkt5Y3G9naH90xEzTz+NZaEG5kQ5U8NEUsV/YsmDElKgr5NoR8y3pRr1DdqB0vH15JluC2EJp20km7XCuv/95fG/qzV8vEjkLBH04jyXmA00b9nblSjE2Zy4NftOMyaZ7ziOOC5zLc/k644OvfMgJqU49Pec7DIyVSqdRToMmkY3v3Bx9OnaavdCVfGAXAmdocH8tCdvNdTieYkVMl+29NUq6LU55lQK3ecbBqXDVpbdIqAAyw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(451199015)(41300700001)(54906003)(36756003)(6916009)(6666004)(4326008)(6506007)(66476007)(8676002)(66946007)(66556008)(316002)(38100700002)(8936002)(5660300002)(26005)(6512007)(86362001)(2616005)(186003)(2906002)(4744005)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5961
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f52d5c75-54f3-4c5a-01fc-08dabc07828f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q6GnUSIB6yFOU048qcXgvW8sFPJa1lDPw9Lbj9bHhSOrNApzMTw2qHtwwRUVtcZ7lpXNhrhPs6kCseS9aKOiM04/fcOWiK1I0aLBtDQDGbbgXOb1BZZUStcwwp7KSlIXTc+0k3SMr6Efrm339QL6vPAUvpmOQ4LNiYDd/sTI3pK9PR2mY6oked1nVqv7IXv94Ec98irxZmiYNz7xtp8vjvWAKEtMHRJuJOrNcaq9sILDrqtoGpp4oJAWxejDnMFWSs1EnL76cHSfWW5Uq9gQgLPhJd5Z6qJukh9GJMPfaa3TUWk++FlWI1LpiLXUtJVI9Z5U4wfV2pWSwqC3AUu6n9KaV1A4Hd/X8W4fI8zihe1up7YpSXNMjmgVta8Pzkl2NkjHic/LBT54b+AbP0fQ4+ZlBl8XFbA+xKMJ/P49uLOAoQ1zaGETEx8jq6FU4hJqPRKd8JZ0xm0pd4c6pjS3OpzeLMlm1lgAZdWUlGqimOkr6sayWU9p4iyLlqiOwRF8MEYun+5GfSu2j22XTAMrZvkAb4kgd93jdObjrgy1fKhbYYLk510JsYqg7CGSgW+6a3JdHDTnCO6WLHPElKEhwWIZjNJr2Q+9wMfTicZ164Gs8vbgajpcRtt7jAvwmvuQzH5ZGK0n8AYRizJWmKDhd49nKU6uicW7xHjIuj0LPUL53aa41n9ma3ZM/PGwehM/AT/582lqBHTo7GSBgmeD3wacc8z5Acdx1v9MvKaCvymF+2sZ8Y1Z0KOa/WutChJV9AnAe/aGO+19KuGIWGHM2Q==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39850400004)(451199015)(46966006)(36840700001)(40470700004)(26005)(2616005)(316002)(36860700001)(6512007)(336012)(478600001)(47076005)(36756003)(6486002)(40460700003)(6506007)(54906003)(186003)(6666004)(107886003)(81166007)(356005)(82310400005)(86362001)(40480700001)(2906002)(82740400003)(70586007)(70206006)(8676002)(6862004)(450100002)(4326008)(5660300002)(4744005)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 12:49:36.9669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a537cb-44ce-465b-2543-08dabc0788b1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8152
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 11/01/2022 12:19, David Laight wrote:
> From: 'Szabolcs Nagy' <szabolcs.nagy@arm.com>
> > SYSCALL_DEFINE3(fcntl, unsigned int, fd, unsigned int, cmd, unsigned long, arg)
> > {
> 
> That is just a wrapper and calls do_fcntl().
> which needs changing to be add:
> 	arg &= ~0U;
> before the switch(cmd) {

this makes sense.
i thought previously you meant masking in userspace.

although if you mask there then many linux internal
apis could use int instead of long arg.

do you want me to post a patch? (i'm not a kernel
developer)
