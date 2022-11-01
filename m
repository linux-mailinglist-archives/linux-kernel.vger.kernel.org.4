Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642336149DE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 12:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiKALuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 07:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKALti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 07:49:38 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20042.outbound.protection.outlook.com [40.107.2.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9430F19C36;
        Tue,  1 Nov 2022 04:45:23 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=epRevjZHz5QCJxH4SwkXtsWBsxXbgpN40dyDVc23gnT/xaNH7aGtl2UeNMcjPn4RH5LKhpb3n07niQ3u74CP2aKlSk/aIcW7iRyrAMukYiOpQJPl+G6Ksq+sJ8BL8kqc8QSmOT5OBL9PVwvu1qkm1cYMSPOOvrp3EJTyS9OJ6vblJiodUFkzLybgeeGih7uiW4kzgW+FQr8OLI1GaZjOP3RsGW1rmJnCQBRa20Ukr++lSlOPXhgH83gwyKX2OgRvDGJN37l/M2rytjN8z3TNBqMJ0seMq+fMM71lEN14wureFgrvXqizX1eYwRcnvuzslRiHdBXitrs1S+yVPcKJSA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Lm6CH8MMUoD/G6jZUL6JRMF4OGpJwtWp0S0oFIfvLw=;
 b=NWbwmkBO/8urhUBYzNxqOWJ+aO00d6CsvIaPdbyhHOYyBP7q776OU+tUpXTdf5RGFk1DUYNqaRkYmzwaqNMEUM75dleT0/1WnjDBgbzoinLO3/8QEPzrlkbErnSkxdJPv1NljLlxa2mR/uNQtceAvzP1G2mWAhuwp7UYWpvQYmu++UwN3z6LEH8Br+QuvSoL0GS6t+9MCj4pCnh7cDDQvc4bxvw3OgUj3GLVNE3oJYeqBy0jVlgg8x03U+6vbsokvfCFTvW4Wq32PuHqiNzeuChppa7UM2rB1aPOOoX4yLB4F+EclWkBKoh6pptEJXoczIc50GKhPIAnwwLtstmZ3A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Lm6CH8MMUoD/G6jZUL6JRMF4OGpJwtWp0S0oFIfvLw=;
 b=2CJu0Y8YLgWfnoVGM5Zz//rJnmTOhAr4K0uQhz+0GGIcBiKTvQpu+6Gva4eHEYUJnoI2K3x8pZJ83pLteAG5nxrNOs/dcpvRlGrzmrQIeDbcXI8IpVr9zs8f+WDPVa7nAG/z6XHZG2vpXy2qFJqxEx9xrB7f6StHgD423WLL8Lo=
Received: from AS8PR04CA0194.eurprd04.prod.outlook.com (2603:10a6:20b:2f3::19)
 by PAVPR08MB9819.eurprd08.prod.outlook.com (2603:10a6:102:31f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Tue, 1 Nov
 2022 11:45:15 +0000
Received: from AM7EUR03FT007.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:2f3:cafe::9) by AS8PR04CA0194.outlook.office365.com
 (2603:10a6:20b:2f3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Tue, 1 Nov 2022 11:45:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT007.mail.protection.outlook.com (100.127.140.242) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.14 via Frontend Transport; Tue, 1 Nov 2022 11:45:15 +0000
Received: ("Tessian outbound 6c699027a257:v130"); Tue, 01 Nov 2022 11:45:15 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 2647c60af6ddf6e9
X-CR-MTA-TID: 64aa7808
Received: from 07ee51695762.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7B554909-4AC6-4DEA-9931-089CABC515DC.1;
        Tue, 01 Nov 2022 11:45:08 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 07ee51695762.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 01 Nov 2022 11:45:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1rEop5yxhciGW5Iw4Ta+d7f4jSUMjOeutpp9oxSxYhLExxz0etiHZTZQE41ecYdhyzy10nGc81el4a8d08WolXnUO8MKQpEpjB6nfHlpL2O0hrAKYP4A+36EN4VF07vIxWtgSXaXm2yJ79sm+2u5Bld1cTAzcRvvogh6cy6foew9Se0loT0+M8q1QZOYhqCr3pMLjJnzyHPen3x5xZtfI0KGSoBftcoaxwY7azVBoMtgDp8DJCghuvC/ZTvNs25aQp6M/x4QMj9mDZgWJG9QtPo2ZgwZa9YA0LY6ol5GkeS/fBn3zGYZOljgE7nbhy6q3ztmBiasv4PMHWtVm+/nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Lm6CH8MMUoD/G6jZUL6JRMF4OGpJwtWp0S0oFIfvLw=;
 b=V8dCpFfHZOgCuFKG2hS62zfq4QN75LowiLmgL3+GpoRT09rQCY0/RFBDXc+GCPMZB3sySXAAfGiJ7JsjXc5mPwLS7CnY0HtlDyCA6nNbEBrFTK7Y8cspOhOge9a3rnHeMu4zELGDDfxOLxTNDfDFUFS/ZW0NLTWUkCgNc0IYluPYp2HOAvtsXznaTyb+BHwVuiai09490UD0GJzIYZpYO8mo966Fz8C/syFrxxVkMUvt4ql+CrkoGWiJhIuP0JOrVtrVSxu1Fnzodl9Ms8JpYDL+iQT0uoC9tqtUgYbAcEuI9TJnYMyIKg6DBvkV88Dnyysv8MaBUZlmkQiHvkOjMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Lm6CH8MMUoD/G6jZUL6JRMF4OGpJwtWp0S0oFIfvLw=;
 b=2CJu0Y8YLgWfnoVGM5Zz//rJnmTOhAr4K0uQhz+0GGIcBiKTvQpu+6Gva4eHEYUJnoI2K3x8pZJ83pLteAG5nxrNOs/dcpvRlGrzmrQIeDbcXI8IpVr9zs8f+WDPVa7nAG/z6XHZG2vpXy2qFJqxEx9xrB7f6StHgD423WLL8Lo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by AM9PR08MB6209.eurprd08.prod.outlook.com (2603:10a6:20b:283::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 11:45:06 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::8999:7c8d:d088:d198]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::8999:7c8d:d088:d198%5]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 11:45:06 +0000
Date:   Tue, 1 Nov 2022 11:44:52 +0000
From:   'Szabolcs Nagy' <szabolcs.nagy@arm.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: linux interprets an fcntl int arg as long
Message-ID: <Y2EGtE05hcVn3B3a@arm.com>
References: <Y1/DS6uoWP7OSkmd@arm.com>
 <Y2B6jcLUJ1F2y2yL@mit.edu>
 <Y2DisyknbKxeCik4@arm.com>
 <a0693686d0ae41599fe1700680ec56ec@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a0693686d0ae41599fe1700680ec56ec@AcuMS.aculab.com>
X-ClientProxiedBy: LO4P265CA0245.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::17) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|AM9PR08MB6209:EE_|AM7EUR03FT007:EE_|PAVPR08MB9819:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a8a02b1-94f8-49a4-3d1b-08dabbfe8b09
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: TQWoHfwyaSv65pD4oVFUhhDyIDqJVGwWDeASsJK/SB6E0hIICU8WyPifwfbJ5rr3ObRhK6pvdXDh1pGqRA4x7A2VLI3enCW2cDiM0tgM2k4YPDt+RBYzew6dpTs9sKlQWn0HIKtoH50Bu0EXhn3uPtYGrRrzBe1O4cN3xw5iZKB9k8WDQJu0ISaEpmYtKcNIbHtSlRpzOmjxyH0tnjeuo2JsCvRvYAehCNKNokC47UwEel7uW/6DCOQmudDXl/AcdbpMVM0ZbAWjx+Kf0WkU5nv4OQkGP8OVkDoapK8TklVGIy+oHLq0bbUbiyhajK/Mz9fskx3jj88BXo9wYR5jcoBzHe7lWp40zr9PdO76TcTG1dvs62kQRmEa4Uh+OsvsEqGdgxlIGXgTUDk4JwM0FGm5Tx/iDdiVAc4zyQ+5oCcN9RkuHW9mmwajK61Mi8L6OgdaLe6UneT57RsCzma5hfMeuuF+p94wGFu8/Kox2id3EY+TYRjAaFq9Dm+jYvhJsSXONeXsnf4R6sWLrrNHo3ICXfqEXverzWtcQhv85ZfSPOZERoYkwz1a5IqOML5S8jox+9x5rjMlSu1kbDUHmPYu2nC9LbV6tz8vm2ZMf1d1XLhg7fMyyidTl3zHIvLIra7dwKen/7b6MtlHLIADt0XZMXMaxHX0aYvXbS99OQzEadScC22RWnQpakDpO+G3TlH7ezvoTg4VTNku2F70gA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199015)(2906002)(186003)(2616005)(478600001)(6486002)(8676002)(66556008)(66476007)(6916009)(66946007)(6666004)(4326008)(38100700002)(54906003)(6506007)(41300700001)(36756003)(316002)(5660300002)(8936002)(6512007)(86362001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6209
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT007.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4f25a5e4-4b06-4764-7d18-08dabbfe858d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SCc8uA0qXX8dYNPyKaCuwLcqCccAzqV7SAkhqmN9ggIhYkbJD1lB7/bEdL7p6JYMq3Am5UbkAGYBaohxm8wur1Uondhd8ose7xES3kZmchtglXmBtd+Zh0c0GU9w9Y8HX7NDk1OEYQDrucxj+g0PnByjA5SKBJAuItdinX5eT5jc82seYPanG09V62HlVWs1PCnHca5kF3NAshb6G40DbellBBkjPqQ93wDWxtxEv9tUde78CIzxXUixTqgSm4C9JWyeH/sJvZ7rOWv7sz0gDZWFP5NCg5uk06Q8Q9TpONcEu4cDr8BgtRxpwpemmKnUHf0NFAHonGvPgqLACOwipLNCItvBtKOxjDgLyn63HKcQxRAOYq7Cs/SocNs1t5KeHQvkgr4rdDIeozJrr4JBlT7B2j8cKARasFF1BMdwDTGfnX3pC87mHkkEpizrg+JIl8CcNJZdiT59s0F5tJkHP43PHbQNzR2uIAZRg3UrwKCtIlMmVKElk80MJYkM7I/gZ4tzi+qjjm6HtC7r4G6WHK1GMo4hvwgGJtu2C4v6bGsE1LTDIopvecsnSQelLslwIuyJHX04HmhrT1C+VroXwB8b6p+5F6v1OMLW3mZVJbc6n2rJK3qxrr/1gJnvDwhi3f0pJLN/JfbH8fhiNnvNQo3Bgk8ip+foy/oSJG/o48Z0EC8UPSkj1JBzbM9yXVe6D7hj6EkF+lOblHWF3PikN/L9EdpPJ4jp1396nkfYtHkkydc3qqA4pFAFkX0tzq25hK7AcDm6g5aahwMtR18Ukg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199015)(36840700001)(46966006)(40470700004)(6862004)(8936002)(2616005)(36756003)(316002)(5660300002)(4326008)(186003)(6512007)(6666004)(70206006)(40460700003)(36860700001)(70586007)(8676002)(26005)(450100002)(41300700001)(336012)(6506007)(107886003)(2906002)(40480700001)(81166007)(356005)(47076005)(6486002)(478600001)(82310400005)(86362001)(54906003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 11:45:15.4134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8a02b1-94f8-49a4-3d1b-08dabbfe8b09
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT007.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9819
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 11/01/2022 10:02, David Laight wrote:
> From: Szabolcs Nagy
> > Sent: 01 November 2022 09:11
> > 
> > The 10/31/2022 21:46, Theodore Ts'o wrote:
> > > On Mon, Oct 31, 2022 at 12:44:59PM +0000, Szabolcs Nagy wrote:
> > > > and such fcntl call can happen with c code that just passes
> > > > F_SEAL_WRITE since it is an int and e.g. with aarch64 pcs rules
> > > > it is passed in a register where top bits can be non-zero
> > > > (unlikely in practice but valid).
> > >
> > > In Linux's aarch64 ABI, an int is a 4-byte value.  It is *not* an
> > > 8-byte value.  So passing in "F_SEAL_WRITE | 0xF00000000" as an int
> > > (as in your example) is simply not valid thing for the userspace
> > > program to do.
> > >
> > > Now, if there is a C program which has "int c = F_SEAL_WRITE", if the
> > > PCS allows the compiler to pass a function paramter c --- for example
> > > f(a, b, c) --- where the 4-byte paramter 'c' is placed in a 64-bit
> > > register where the high bits of the 64-bit register contains non-zero
> > > garbage values, I would argue that this is a bug in the PCS and/or the
> > > compiler.
> > 
> > the callee uses va_arg(ap, type) to get the argument,
> > and if the type is wider than what was actually passed
> > then anything can happen. in practice what happens is
> > that the top bits can be non-zero.
> > 
> > many pcs are affected (aarch64 is the one i know well,
> > but at least x86_64, arm are affected too). and even if
> > it was aarch64 pcs only, it is incompetent to say that
> > the pcs is wrong: that's a constraint we are working with.
> > 
> > the kernel must not read a wider type than what it
> > documents as argument to variadic functions in the c api.
> > (it does not make much sense to expect anything there
> > anyway, but it can break userspace)
> 
> The Linux kernel just assumes that the varargs call looks like
> a non-varags call with the same parameters.
> (It doesn't use va_arg())
> All syscall arguments are passed in registers (unlike BSDs
> where they can also be on the user stack).
> On 64bit systems the same registers are expected to be used
> for 64bit and 32bit integers and for pointers.
> 32bit values usually get masked because they get passed to
> a function with an 'int' argument.
> 
> If any fcntl() calls require a 64bit value and the C ABI
> might leave non-zero high bits in an register containing
> a 32bit value (esp. to a varargs function) then the calling
> code will need to cast such arguments to 64 bits.

the entire point of my mail is that it is not possible
to tell in the libc if the vararg is pointer or int.

so in case a user passed an int, the libc cannot fix
that up, like it usually does for other cases where
linux syscall abi is incompatible with the c api.

let me go through step by step what is going on:

user code:
----------
int fcntl(int, int, ...);
void foobar(int fd, int foo, long arg)
{
	/* top bits of arg are used by the user (non-zero),
	   they are not for the syscall. */

	/* bottom bits of arg are passed to fcntl:
	   the compiler passes arg unmodified in a register
	   where top bits are set, but that's fine: the callee
	   only supposed to use the bottom 32bits.  */
	fcntl(fd, F_ADD_SEALS, (int)arg);
}

libc code:
----------
long internal_syscall(int, long, long, long, long, long, long);
int fcntl(int fd, int cmd, ...)
{
	va_list ap;
	va_start(ap, cmd);
	/* this is non-conforming C: wrong type in va_arg,
	   but that's not relevant since libc can implement
	   this as target specific asm, the important bit is
	   that the correct type is not known: libc cannot
	   replicate the kernel side dispatch logic because
	   new cmd can be introduced in the future with
	   arbitrary type arg.

	   top 32bits of arg are non-zero, libc cannot
	   zero them here as arg may be long or pointer.  */
	long arg = va_arg(ap, long);
	va_end(ap);
	return internal_syscall(SYS_fcntl, fd, cmd, arg, 0, 0, 0);
}

kernel code:
------------
SYSCALL_DEFINE3(fcntl, unsigned int, fd, unsigned int, cmd, unsigned long, arg)
{
	...
	switch (cmd) {
	...
	/* this part is in memfd_fcntl.  */
	case F_ADD_SEALS:
		/* uses arg as long instead of the documented
		   int type and fails because top bits are set.  */
	}
}



> 
> OTOH I suspect the argument is either absent, int or pointer.
> So it should mask the value to 32 bits.

how does that work on 64bit targets?

and how does it work on 32bit targets if a new cmd
is introduced with short int argument (posix does
not guarantee that it won't)?

> 
> Note that there are ABI where 'int' and 'pointer' get passed
> in different registers.
> Fortunately none will support Linux!

what i explained above is not theoretical abi or libc:
this is how things work now in practice on x86_64 and
aarch64 and it is clearly broken.

normally when linux does something silly like this the
libc fixes it up (since we want to support old kernels),
but in this case that would mean replicating the entire
ioctl, prctl, fcntl, etc dispatch logic in userspace
which is impractical and cannot be future proof.

so going forward i'd like linux devs to consider the
3 points i raised in my original mail. and fix
memfd_fcntl accordingly.

thanks.


complete example (tested on aarch64 and x86_64):

$ cat a.c
#define _GNU_SOURCE 1
#include <stdio.h>
#include <fcntl.h>
#include <sys/mman.h>

int g = 0;
__attribute__((noinline)) /* pretend to be in another TU. */
int foobar(int fd, int c, long arg)
{
        if (arg & 0x100000000) /* use top bits for something */
                g+=c;
        return fcntl(fd, F_ADD_SEALS, (int)arg);
}

int main (int argc, char *argv[])
{
  int fd = memfd_create ("tst", MFD_CLOEXEC|MFD_ALLOW_SEALING);
  if (fd < 0 ) return -1;
  int r = foobar(fd, argc, F_SEAL_WRITE | 0xF00000000);
  printf("%d %d %m\n", g, r);
  return 0;
}
$ gcc -O2 a.c
$ ./a.out
1 -1 Invalid argument
$ strace ./a.out 2>&1 |grep fcntl
fcntl(3, F_ADD_SEALS, F_SEAL_WRITE|0xf00000000) = -1 EINVAL (Invalid argument)
