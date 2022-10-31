Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C2C6136CE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 13:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiJaMqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 08:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbiJaMpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 08:45:24 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF52F59B;
        Mon, 31 Oct 2022 05:45:23 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=C8r6OF+MJas1B1QYqKAvVL5Nvcsq82qle7lIY/bKqGbC0RKbs5gbFg859SOehiw/xjiG3tqiIgG2u2y/EIZuPlKupJFPTl2DXd2QZhfUvndTt4Z7DTR28sOGGqK0peZZqvaGybdlfXeeOgivOelwGTGkRk9ZEP2qO5tTiIibAv/C37F5wXrLcUsfil/kLLNNhm2X8nsEnqjQzbpuRUqHYKrRboF76+rQ9pcAHZlxl9LmclXE/FgSxmps2YreL2ls5nS1w5oyR/CYJXoexLUo6YFDRif0/V47QYV8Bbw/ag5cIFqPz6QZvwX2p9aCk9oDnDTp8IX7mpezRNQTMbuWAg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4uSRxvkqWSApxpa5bX0b4bKWNU/fy304FLk/BTKNXk=;
 b=eyBBAcrh00qp+Rl8xZFcOY0ZhNGpjTm56sZl4aH07/uzbrq1hAcreXsvSWHm2uO1qHIHU99JY7WYQ9KvTCSABYBJn+cjGwZT9Wp173diBWTkRUhf//RVaiD6rhyJV41ffiLop35BZq21rhIKWjNFhEkblk40b+x3NuGNGixJbFu4W+UQRwuCgPa+B0nOJrKHVosNSKSecV2ZXa5dKxVrWDwFrQ3A4Lts9zM4QhapmdRXqQUVe4mWziCC1N/PyXoIrd8lTkHlRE/AdaK9TOuT0tY0PbTDxmrRbis+1WfCSaiy1092SFd41YKU9mWYlezvWJC7pghz1XBOOzwsi9LZ4Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4uSRxvkqWSApxpa5bX0b4bKWNU/fy304FLk/BTKNXk=;
 b=UyeQiFMCLLLeWQc5oSUotJcCQblq/PevMjk12hmwqhCyeUc0Q4FHa+tXb2TQckgApHNyFwusjqM7odNflVJcEIkZt5gQ/DKBqIcHmfd4gg7ElDq+1M9NdWUSmgwm/zfwzKyjfsBbpMJD+Wy2vKWoK6YUL1YMWqbso8f6UI+6mKQ=
Received: from DUZPR01CA0046.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::14) by AS8PR08MB9979.eurprd08.prod.outlook.com
 (2603:10a6:20b:633::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Mon, 31 Oct
 2022 12:45:21 +0000
Received: from DBAEUR03FT042.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:469:cafe::1a) by DUZPR01CA0046.outlook.office365.com
 (2603:10a6:10:469::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19 via Frontend
 Transport; Mon, 31 Oct 2022 12:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT042.mail.protection.outlook.com (100.127.142.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.14 via Frontend Transport; Mon, 31 Oct 2022 12:45:21 +0000
Received: ("Tessian outbound 58faf9791229:v130"); Mon, 31 Oct 2022 12:45:21 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f197308e103735f1
X-CR-MTA-TID: 64aa7808
Received: from 3353663dd985.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3EAF491C-7499-4FBF-8AAB-F44FA8F86077.1;
        Mon, 31 Oct 2022 12:45:14 +0000
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 3353663dd985.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 31 Oct 2022 12:45:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPlVdDfJiA+F4QOEExFWCM8S+1XPUwPr3dzOBFDJcnqdC2kPMgTGXVRkN3gc0DupudjOiZkM1/0G4+RugG/iljvsp7ZiYiiKZ4G72b3t4KAbfqbWk6yik/MS9LgRFmVZb+oHbtz4NAQv4pZd6J5EKo+PwraSJIMBumNpuwym9bOZQFIpODReQvJ3b7JgPzCWhJcmOGPSZ2dxTwCSsqn9G+uxNObeqP4IbVd4P/QYCH1ipJZWZgqXvBWACyPTrYOXZYvet2D6lm/kN2c5WN3vnvj8nECypHFRqCeF6b3+L4NdRKVGUg4XKE8+pKYWO27YjQr2tyY4e+Pbm8O8NlxKgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4uSRxvkqWSApxpa5bX0b4bKWNU/fy304FLk/BTKNXk=;
 b=YRD8jTLj2GWK3xTFikzag8NiRV6Eva8ZQA34bIWH0SH2TRW6eFwOxuJFJkot76r2ttIL+vpDlMQVM+KH/NlwGDtJ9lCtQHirUVl98wT1XUB4Y5rcMSuT5/A+lRXVIyzSL4P+A1Vgl+R/G/uApR+dARGtEbZazPYmDDkZDEccPkZKloguvoBCcWlIEuKazFwAVbkJCTOjgtaEW9elq8FxdfNN6z1Liczqaf5ER+97Z4bHXSJTNhxmMreD0O7EZr1qZWF8t4fqmBm+ztqz8P0fUqp5UXQ4z5vPSqtK9TwkcIX/eiuyig7tz+k7Zr9+P18z5f1RpzTj0w30rzfH27UXMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4uSRxvkqWSApxpa5bX0b4bKWNU/fy304FLk/BTKNXk=;
 b=UyeQiFMCLLLeWQc5oSUotJcCQblq/PevMjk12hmwqhCyeUc0Q4FHa+tXb2TQckgApHNyFwusjqM7odNflVJcEIkZt5gQ/DKBqIcHmfd4gg7ElDq+1M9NdWUSmgwm/zfwzKyjfsBbpMJD+Wy2vKWoK6YUL1YMWqbso8f6UI+6mKQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by AM0PR08MB5409.eurprd08.prod.outlook.com (2603:10a6:208:183::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Mon, 31 Oct
 2022 12:45:13 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::8999:7c8d:d088:d198]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::8999:7c8d:d088:d198%5]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 12:45:12 +0000
Date:   Mon, 31 Oct 2022 12:44:59 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: linux interprets an fcntl int arg as long
Message-ID: <Y1/DS6uoWP7OSkmd@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-ClientProxiedBy: LO6P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::11) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|AM0PR08MB5409:EE_|DBAEUR03FT042:EE_|AS8PR08MB9979:EE_
X-MS-Office365-Filtering-Correlation-Id: ececf5bb-c539-4be7-b830-08dabb3dc5d3
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: wQl0cNB6364lOtpBZ0GIAR8913y1PaEDxnxfY4ZJ1tbVqHz+EwwHzND6jK1RY7LlJOG9rpY8DT6QpSMk4mpiqdZ+VrwBn2hkcesQan2itAFrE/3UheP0I0szV8hxp1g+Ni064RKSIRXfh9FItKZ8YqrVrXT32WbZQW3u8VNSlVmrZIs5qbNpexR9gpmJPMEu5QudR5E93nqjGxowRNCZmSk3qrAxik+SgdIL1Tbx8NtNt5ocgMwJGDaLMU6SddZYMxXf+SFXAaUT7YyeX5pwiCDM1LxR9GnaUdlnHu+7US/aVwSchbCgr3xbWepgyH9luVQqgq6IumgZA4lAmd7E8vUPpzCaodjnNrMD4vzTMRR+VY4DYT/yms+rYTs21KF6n3ZVcDakJPEjFkYCV0TWfDrbfV306r12HOGMlu4b2AgFuUWY4XvdB3T0tAkGI2BATp4sbRU67qL3iQPvrTS4sTRLtPIikkwoI4pgsMX5Qf7jT2NGdpsKE6f1Id1tgzhWuKZClJMbqQvVQbu0HPvcWnrz9Wodwlqsn+p6blu3c53M0nWOZOMGrd7vzQAaXjP13z/eoJORT4blh3g+z1FWwNRm3wvyB0xnNu6GLOpWrb0LfT8k8mbUQwxxs3Nu7xRd0GAY+be429FcqJo7Vm8FUe+e8n0kiFR36/6YIzMnlTbkw9vbkcmHOA34x/TGCrmv7Y0JaxSEdRKfgmaGfYkt2Q==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199015)(66899015)(8676002)(38100700002)(41300700001)(316002)(186003)(6506007)(2616005)(6666004)(5660300002)(44832011)(478600001)(8936002)(6486002)(66476007)(66556008)(2906002)(86362001)(6512007)(66946007)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5409
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT042.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 67071304-822f-497f-9044-08dabb3dc08b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s0/iYwG++qdS1/JcuLcTSRQ+fsui8iAL1HthVfBcJnp6kz1eTdUEQu4uLfodxuEpi+Lp6/+Dswmx1FZgMFy8J1j0dv6fHaRlfr48Q7OT4sk/yVw2nf/hklF1uMrhIpqMSozLtgttDhfPWsLAqOOskHzehE2p7Lx8zqg+VdVh8EFiGIRQ9wlrqRBtUzFQTzAuvcpvYkFuGZ2T3RzMr/sdMO8FBZIzoNHC91Qd7A61yqTriy8RrmnaBvMhD4P4qEw3FE/fUkLGEs1CgfwfOV5O11rA7y3Sf/nb/ulTWkRMcyt7r8DVp7Ok6yQINTGtWipiDw7TqF+XS5ViV86kpTiDdBQINta2+tmK9kqA7LK+x79G6QIIBaRpAMQCYXauInOZAPxGFzzPR17+fPo2bpHKCRKOTXkrRRnhPZo2Xn33JyPYLxCeWzaSOBTIuskgYUrhAFP5d8Bt5FelMkDOAdj7plwy52BfDVndKaW53N59jkz21En1pqgTF97e7AlKa7C28TkY4zzrbnkmo/8gwdSFgHEt0hqQ8/dutjWqByvnFSf6S+CGHKkDrQz7KiUFb/brDqo4fOaEuNqpLfRD58ROZsgB1TUaXyKscgj2Ezyq7ruuRs8gz3ztCC7Mi4tl2BiJMkeh1nk6/CzZWJfjzCWFFjjB0lvyVkIwtB3c3Q4aouQEIygZf8ajdELTCrXt0CqhLBKWRGMb0WCbHwErm7EmKnxgQqXBJ863weS+2cSJWIKHCClH0Luiop0/rVpdeIVRypmNyNO1oAoxjUIrkI+9KA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199015)(36840700001)(40470700004)(46966006)(6486002)(450100002)(36860700001)(5660300002)(70206006)(2906002)(70586007)(8676002)(8936002)(40480700001)(44832011)(82740400003)(186003)(316002)(6506007)(6666004)(2616005)(40460700003)(41300700001)(26005)(47076005)(336012)(6512007)(86362001)(81166007)(356005)(478600001)(82310400005)(66899015)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 12:45:21.2732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ececf5bb-c539-4be7-b830-08dabb3dc5d3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT042.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9979
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in short, F_ADD_SEALS fcntl cmd is documented to take int arg,
but linux mm/memfd.c has

        switch (cmd) {
        case F_ADD_SEALS:
                /* disallow upper 32bit */
                if (arg > UINT_MAX)
                        return -EINVAL;

fcntl is variadic:

  int fcntl(int fd, int cmd, ... /* arg */);

and arg is either int or pointer in the current documentation.
the libc does not know which (except for existing commands,
but there can be future extensions).

so glibc just assumes pointer arg and passes it down to the
kernel. musl uses unsigned long arg, but either way depending
on the vararg abi rules of the target the top bits of an int
arg can be non-zero when passed to the kernel. (in principle
it could crash too: variadic args only supposed to work when
the type is right, but in existing abis this does not seem to
be a problem.)

e.g. the following fails with EINVAL:

  int fd = memfd_create("test", MFD_CLOEXEC|MFD_ALLOW_SEALING);
  int r = fcntl(fd, F_ADD_SEALS, F_SEAL_WRITE | 0xF00000000);

and such fcntl call can happen with c code that just passes
F_SEAL_WRITE since it is an int and e.g. with aarch64 pcs rules
it is passed in a register where top bits can be non-zero
(unlikely in practice but valid).

i think there are general issues with variadic syscalls:

1) existing varargs that are documented as int should be
interpret as int on the kernel side (the libc cannot fix this
up reliably). i.e. linux should fix the F_ADD_SEALS code.

2) variadic args ideally should not have mixed type and the
type that is used for future extensions should be documented.

3) macro defines for varargs that are long should have type
long and not int in the uapi. (affects some prctl flags)
otherwise users must cast manually to the right type.

thanks.
