Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F68D6389BF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 13:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiKYM2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 07:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiKYM17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 07:27:59 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on20630.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe13::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC26E27914
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ygd+ecgBXK8F6p+GRecNHurBbETwJtiywSUKQ5GrVCo=;
 b=fg4F+7jdkNYeKRk3amRwrJdCSBx7P+1U8Ygv6zA50BXiOeWv236PflMjG3nmwTrAFDobnmPWSpYn9TGJZvZ13Y3uo5oPEt6mOrOkoLC7IFZwdfv9d+rd9R+l1KGZPnnjNNfSaQo4G6Mq/OTnidI9MjXZxmmLObkD59xW0Ue5nnE=
Received: from DB8P191CA0008.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::18)
 by AM8PR08MB6401.eurprd08.prod.outlook.com (2603:10a6:20b:361::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.5; Fri, 25 Nov
 2022 12:27:49 +0000
Received: from DBAEUR03FT016.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:130:cafe::c0) by DB8P191CA0008.outlook.office365.com
 (2603:10a6:10:130::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20 via Frontend
 Transport; Fri, 25 Nov 2022 12:27:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT016.mail.protection.outlook.com (100.127.142.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.19 via Frontend Transport; Fri, 25 Nov 2022 12:27:49 +0000
Received: ("Tessian outbound 6c699027a257:v130"); Fri, 25 Nov 2022 12:27:49 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: fb8cf5381c89c702
X-CR-MTA-TID: 64aa7808
Received: from 2e0900de757e.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id AB239D67-7BCC-4FFF-BEB0-D7036EDA438C.1;
        Fri, 25 Nov 2022 12:27:42 +0000
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 2e0900de757e.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 25 Nov 2022 12:27:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKPa54hxXQiiKDnTfSmCcQZswZPPDJZaAg66BdUhv4VjHHyMNsWRJZ1Ga6KFowb54NaBoRdrMp+KITaU7b80sK05rYQOKJa+4sK584hI6JweWRTucnyI5jFCmh8gsGwNVADcvTIH2aMVMWkwnmmGLHAv99XhgBw3mP/PGHNgLESvpd5bybvjsN/CMwPsV7APv8TP5hFyBaLGsaBXbb/gY/RJpcVw00ePCFpga5gm3g6dO9niyjyI4SnkhFOyX+tE1IMT7JbW4a47EmEbpOsvjky9l8Bjty5nQY8qIu8XRBp2/TvBAlyO2Bvrj/U8C/UnO9DcrkIgbs+uvJKaKk1E6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ygd+ecgBXK8F6p+GRecNHurBbETwJtiywSUKQ5GrVCo=;
 b=OjH70jcucyiuwaAnRTGX7JGJnwDOSsXLHK0lc+sZz9t3KNFDQiKXJbdg8pZzgNfDGzWojEUvEc/z4zoxEMDiN3NDZ54f5D2RHtYLv3EHSnzFUUHympP+N5RiaOKde9URGLGYBogDbiOEilO5ev6lwJYNgC0g6yYZlu1pC9H9DygIrMZLN0W8C5p1xKmpDO6JvV/SwDEqNBz2koHASi/B2Zj1u8YI57vcqEv3rru5nDvG/xbZUJYMSVi9m8tIl62m8P0xqwiQmxSrWqoDGDZHurrfSZ1OTFI6mRhy5VPmDkrE9/ND+jAPg0v62AlEBt6S0U9x53RXkufGK9NcXZoFrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ygd+ecgBXK8F6p+GRecNHurBbETwJtiywSUKQ5GrVCo=;
 b=fg4F+7jdkNYeKRk3amRwrJdCSBx7P+1U8Ygv6zA50BXiOeWv236PflMjG3nmwTrAFDobnmPWSpYn9TGJZvZ13Y3uo5oPEt6mOrOkoLC7IFZwdfv9d+rd9R+l1KGZPnnjNNfSaQo4G6Mq/OTnidI9MjXZxmmLObkD59xW0Ue5nnE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by DU0PR08MB7762.eurprd08.prod.outlook.com (2603:10a6:10:3ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 25 Nov
 2022 12:27:31 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::81ce:94a0:632d:7016]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::81ce:94a0:632d:7016%3]) with mapi id 15.20.5857.019; Fri, 25 Nov 2022
 12:27:31 +0000
Date:   Fri, 25 Nov 2022 12:27:14 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <kernel@axis.com>,
        Tamas Zsoldos <tamas.zsoldos@arm.com>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: vdso: Include .eh_frame in debug ELF
Message-ID: <Y4C0ope66V+0DzYC@arm.com>
References: <20221125103740.2062285-1-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221125103740.2062285-1-vincent.whitchurch@axis.com>
X-ClientProxiedBy: LO4P123CA0142.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::21) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|DU0PR08MB7762:EE_|DBAEUR03FT016:EE_|AM8PR08MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: 6883902b-ef50-427d-b7ef-08dacee07767
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: BN1gfBuUy1yWD0DdLYMn9RdOgsAeCq59LGBXTSgqzYtUUSg060HSq6F1boxSaxeiI/Lb8g9X8V4l5T5Z4Y24qeITQzWa96/5tBqoVT+yzamgGklvmeLSQxeNu+hXjJICg9hSVedpbpmmGK6HtKsBim1iV6Tj8YAV9WDxpssnSO6wAA55Y1denZ3/3nmwNZBKhlkHA5vfQGX4KcKrWh8L/YWyLJohYU5qt9w9EQnQA17IG5qd1tIltuuXW59V/uV5ji1HIhswrROFyiPawd9f9SbB4/xCHhQGyKTn7aR9XpUM7hyLyAF25++64aIX9XrQH/L68MSZbmaK4k+Aqw5z0gEDwMveNofSC7r5RTSF6xoVieuEOYYcCSuk0KAu9SVn2/hwDvufZZ5/aWCxC5xKBncUfPm9uKNGcUDyIUrYdOIoMkFw3rK+lo751FyVgvLT5oYTmwkfuvaQ1t/m4SOZRNf0ryfQ+75FdJKJrbhIuQFI9LSeaKVUniMv5m+SBcWHDv7QhlVbCWq+xONLIa3VbAEVI0kD8kFVWSj+dzVvSNJMMo0tt1AOtPgiUpy2wbCJCePKf66hfSxZ5kqnyEeJ7Na18AOqkkT+9euUExxJKOo42isNqXU1rZtBxc9w9hIqpN26i+E+3gtg8wQGEvAq0RixWmWKt8VR7alBLU1rtjlWvvu0L0iUqDG2MLfnzXM118vPmRnIyd9k9YfqxAyz9w==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199015)(36756003)(186003)(66556008)(66946007)(66476007)(8676002)(2906002)(4326008)(2616005)(83380400001)(6666004)(86362001)(478600001)(6486002)(316002)(6506007)(6512007)(6916009)(54906003)(26005)(41300700001)(8936002)(38100700002)(44832011)(5660300002)(142923001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7762
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT016.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4d7cbbab-fc74-495f-2d09-08dacee06ad5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FB0YS7imEJ+SAnWkK0iGyB1Cex8pKqkvxSBHmw5mY7E1edpfzKDTxJDDjr6GPKfrMn/Bg6wOsKxn4Tq0K+aRGs4PTxYagNA34odpJf5BbMFfEunjDpJtSplyXIDyH4kDES9DvRz/4yhbD5Fm+PFgwJ/RRm4S0DwvOlY4kChYDqDib4QGw7A53EFuxUToqG+VO2+wP5bWcZQlrRQ32mI3N7Ou1985Er9KZ8j3YbTWxlUoxoEFSoAW7JoU8jCykWMvFfn3TONthocwxB9Y4tRKJp4QT0hatH1/Grj9JIlBIFZKwn88QeSeLKP12DR+c6LYMREUBTfUPvaehvW6AyJn6PpFtrGOxciAJIQ6QsYd1JH5Qrh7EtYNdXKU4V3IZpJ7jQiNeSHwZBWedi/sCSta3KhjTyOcZxCkVAO42HSEh0z61vxknVUHUt7wByfyhW93Zvzuzconteb185sXT3ZclM0J5RMMhs2cF23Upd9XfevBTtJIF0ThJjnAHSqdxHi3KcKBo0OhUqghizX4ITbShgSAFJLyJ3LkuOxt0mvExfbkp9H7Lzcv90a+7DLofKIstjK0/8KKKppx1bxCM7C2H8lf52afLWfG0V+YcBYQLcY4XwhrQjqlgHskkkbB+t4pNu+EN/riz8xMIgrlvQjl5FQFmi87YHKp5Lg/ek4db9ibC/fSja8bs5XfPTSIiZkJ0vgoHz8dz5+zy28Lv4najSevpFjbXr6cF4Ch+I2IS7U=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199015)(36840700001)(46966006)(2906002)(4326008)(8676002)(44832011)(36860700001)(5660300002)(86362001)(36756003)(70206006)(70586007)(41300700001)(8936002)(6862004)(316002)(81166007)(6486002)(40480700001)(356005)(478600001)(82740400003)(83380400001)(6506007)(6512007)(6666004)(26005)(82310400005)(336012)(186003)(47076005)(54906003)(2616005)(142923001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 12:27:49.7472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6883902b-ef50-427d-b7ef-08dacee07767
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT016.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6401
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 11/25/2022 11:37, Vincent Whitchurch wrote:
> We currently strip out .eh_frame to work around crashes in libgcc when
> it tries to unwind out of signal handlers, see commit 87676cfca141
> ("arm64: vdso: Disable dwarf unwinding through the sigreturn
> trampoline").
> 
> The .eh_frame does however have correct unwind information for the
> functions implemented in C in vgettimeofday.c, but currently this
> information is not available even for offline unwinding using the
> vdso.so.dbg.  As a result of this, perf built with libdw is unable to
> unwind the stack when the PC is inside one of these functions.
> 
> To fix this, strip the .eh_frame section only from the vdso.so and not
> from the vdso.so.dbg.  This can be used by offline unwinders with access
> to the debug symbols, and will not affect libgcc since the section will
> still not be present in the normal vDSO.

adding eh_frame to vdso.so.dbg makes sense.

but if libdw correctly unwinds across a signal handler
then libgcc should be able to do so too.

so maybe eh_frame should be added back to vdso.so just
without frame info for __kernel_rt_sigreturn+NOP to
ensure unwinders use heuristics for sigreturn.
(i dont know if this was considered back when eh_frame
was dropped from the vdso)

> 
> Cc: Tamas Zsoldos <tamas.zsoldos@arm.com>
> Cc: Szabolcs Nagy <szabolcs.nagy@arm.com>
> Cc: Daniel Kiss <daniel.kiss@arm.com>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  arch/arm64/kernel/vdso/Makefile   | 2 +-
>  arch/arm64/kernel/vdso/vdso.lds.S | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> index 619e2dc7ee14..91aac17e11bc 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -65,7 +65,7 @@ $(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
>  	$(call if_changed,vdsold_and_vdso_check)
>  
>  # Strip rule for the .so file
> -$(obj)/%.so: OBJCOPYFLAGS := -S
> +$(obj)/%.so: OBJCOPYFLAGS := -S --remove-section=.eh_frame --remove-section=.eh_frame_hdr
>  $(obj)/%.so: $(obj)/%.so.dbg FORCE
>  	$(call if_changed,objcopy)
>  
> diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
> index 6028f1fe2d1c..66abf70efc58 100644
> --- a/arch/arm64/kernel/vdso/vdso.lds.S
> +++ b/arch/arm64/kernel/vdso/vdso.lds.S
> @@ -31,6 +31,8 @@ SECTIONS
>  	.gnu.version	: { *(.gnu.version) }
>  	.gnu.version_d	: { *(.gnu.version_d) }
>  	.gnu.version_r	: { *(.gnu.version_r) }
> +	.eh_frame	: { *(.eh_frame) }
> +	.eh_frame_hdr	: { *(.eh_frame_hdr) }
>  
>  	/*
>  	 * Discard .note.gnu.property sections which are unused and have
> @@ -78,7 +80,6 @@ SECTIONS
>  	/DISCARD/	: {
>  		*(.data .data.* .gnu.linkonce.d.* .sdata*)
>  		*(.bss .sbss .dynbss .dynsbss)
> -		*(.eh_frame .eh_frame_hdr)
>  	}
>  }
>  
> -- 
> 2.34.1
> 
