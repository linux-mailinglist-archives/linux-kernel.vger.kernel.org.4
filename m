Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3335F619A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 09:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiJFHYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 03:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiJFHYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 03:24:48 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FBFB491
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 00:24:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpNekdgzKLoNbzu59mK17Yh2/0EZgNm7OVtPjGkqPTqwE+gdboAWuCADrFy4F0aWs4FWTp7qN2bVOQebiDumAcKBORIsAPYCiRsxXfkf2GSRC/sRa7MTCXBR66SmmrtwXuuNWyp5opqm8HfKyTe5B31Y3XoAR5uClXevtA7YqyqvLpsyUu6js05inA+vgW/K19pCqWntXDKRq38OlZt6zhhb94+cIqJGdHAMZjwedIeCDYfDcz+kb5O9QqgFfvVrTU9Ml8GmzENDhhkQ6gJsqtV8fjPzCYwC3v+6cmI4PxifwkPuriY5CPruwNZzNwGdZW2eZtevQgLTmOI2aNHiKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+FceXckbprkZdnfDk2O58+uLoEfALCq2zBQAH4ZQfw=;
 b=m0MT/W/tA6YxMBWKoRM7livQbqIAy1nyGRflEduAmtzhIY1UtSWW45kL4YapgE4quYmxmLG2w+SgZCx0Cnnr+P3T/l90fsy6P8KvaVpcqcmDK9TJTvIb5a5Fpiy5mHXZO+5MPiA+fNKwvUEUcy4K1vK/PE2AAobEIyywI4TcbfOfNFEVnLUXURquYHJMm3lY84qp8jQjKSvJvPbPhMpeb4o0gmaUMRoc5iDurlv6nmdYB05suAT2xTPVvULjaMdMnkeasv3zPTCIHV+1zfytvx9ThTJ6proBLfTp2kmmb7sctpnRFl+L8/AU6tnoSpttxWb463R8u9X0B3CTJiUqLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+FceXckbprkZdnfDk2O58+uLoEfALCq2zBQAH4ZQfw=;
 b=PxP2xAlsTfK0DVE8MpJAqpem7QOBZArovyHr3D/UyRRgGeZx3SLt1Kd84JR4BPPZ3xuA/sIVtiodxQso+wrHqId4f4538asKYS3MJFm5+DgxjqUG6CsQ9vjg6lvrbVkkenMJnk1KbgACE/9VuICzaYtirJNE5r6Ocoo3FNHvS0HsbUeVS1UTMPhJCu5kbEXkTqbu25Th/HUoCuX6rX17jEtYjzTaaQ73FfxhMDU1s6MNPFi8KSFwnIVmgjHNkB59u/1guvCkRUARDzoZ5XYo9Z1XbNhtfH5JBL6rel+QrxNbYiTJDE/E3gB3qEZS4XxeVFIdkG7zRvAf2q/YxZ1EuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by PAXPR04MB8407.eurprd04.prod.outlook.com (2603:10a6:102:1c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Thu, 6 Oct
 2022 07:24:43 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::2459:15ae:e6cb:218a]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::2459:15ae:e6cb:218a%7]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 07:24:43 +0000
Message-ID: <bf62192a-ab6a-dade-2a06-73d27fe02282@suse.com>
Date:   Thu, 6 Oct 2022 09:24:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To:     the arch/x86 maintainers <x86@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
From:   Jan Beulich <jbeulich@suse.com>
Subject: [PATCH] x86/assembly: replace MOVSD uses
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::7) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|PAXPR04MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: 30a6fde0-6175-47e9-819d-08daa76bd6e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: up/gz1xNLivDiiBVkuYSsTbG+CTIkeRtnIlYg4LtKlru0pHpibqufhysEZovlhg3EAQXikb1pMJ446iE1wNCyKMhKN6N7GtdjQKHYR8GHTrR8U2+M6XjkduJF8cbjwoE6kTN9/ZzHNLw6qOn0tuatvb4MCQoTh3QwQoKqmx+Mg1y3u7a2Y8YITjlU6j35f/WpAWQ7WDToPpMuXkbPr1AuelVk4xhLCj314Z7KowWpDKNM0DAYGePV0b1ENvvNOcFLeTO7Zs8jHhZSvE4cZdEWp9ePvR6sJPeEdWLhQKwePefRZavtSvSUnwMx/mdZAUhrsUIbmSxo32nbAuP/HNJ6N7L9zPDv/et+uBaCta7HSRElqqzuuy5IQLXNfNkxi+GRCZQ/d0nxNz1anyJ6SydUI8+XeLWHvQfUznXI5De+dBpbdlr65OpM9nrTd3V5EYtTxWjNkDFUsPeUtMYuo+njSupVv9hKxDF26qYxyAQcCHD3RRHKqh53oawUkn7ayL8JLqsx4x0/6eUkqVwrYtAGffVwSflrvE6tPMMzh/kb1I4lIZyhc36hxITHxTsZnWZVAtbPDQSsgpw5Yl6RPcYPB1jz3bctbisBHGG8WXVUHuemqHJ+zLfHPd6gZ0IzBUfeAMwem6ttXpmf0tEkTcKAL3nKsfRg/BDRuye8sioufGZ7VOhbE+QGpz78Yobsjm6AIklkkwmgX98nFcnNsEhkMD/MCTJdJDyuLpaIU0aNtFSjmFQi5VqXPBCN7Y4oSCxYBA5lkxZI6u0zpi8Piwws8URO+IkaW1umN3rgW/tOHU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(136003)(396003)(366004)(376002)(451199015)(31696002)(36756003)(2616005)(31686004)(86362001)(38100700002)(2906002)(83380400001)(186003)(6506007)(6512007)(8936002)(478600001)(6486002)(5660300002)(54906003)(6916009)(8676002)(66476007)(316002)(4326008)(66556008)(66946007)(26005)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ellqRFpqcU9LVzVld3JJVEhMTDZISTgvOHJzcUgza3NLK1JzMG5xenFFc2ZP?=
 =?utf-8?B?MFV4ZU1vcmVZSk5CWlhiNklpLzNySWVXZ1lGR3dkSFJzZ3RzQWhCZS80RU0y?=
 =?utf-8?B?Mk9hUTU1elNjZ3ErcTZVaHZYSWM2Y094OFYyTG9FOUcwUU5hTEIyNGxCekFU?=
 =?utf-8?B?ZDNxeFdnRnErMUFodGRFbTdwUjZ4YjFLcFh3TUJOazB5eCtnMW4ybVQ3RFlC?=
 =?utf-8?B?N3FPemJJVDJuTEpvVjFGK0k5YkhRZ29pK0NISDRjRDVzMTFENC9VRXRYTmpT?=
 =?utf-8?B?ODlvUEFwVFM1QnVlRGVnU1A3bnZyZ0V1Qm9CT0VRa2p0NnVKalpMdUVSWEJK?=
 =?utf-8?B?U2lsQ090dk04NU4zUU5sWFNYTk9jQzUzRHBteVhpYlovVGMyVnNIaGZvK1Z5?=
 =?utf-8?B?YVE5MEdTOG9NRkIyK2FDY2FWTDYvQ0ZMUmszdHhjZk9RSXRQc3BYQnRmUmJq?=
 =?utf-8?B?bEg0aTJKbG40ZmFpMCtBYzRMQllwZGFvY2d0MFRQMm5mNmxVQkw1aXBwdlFJ?=
 =?utf-8?B?b3M1NVdHMGhpcHFYc0VhRzZ3VERmbU9LTkNqZkR0TElOd1h6MzFtWXpPUFpt?=
 =?utf-8?B?MXpSTC9RWndvb1BveFRtbVlqSUYwVTdVT2VBKzVrV1pJUzR0SmJIVHJ5RXBs?=
 =?utf-8?B?M3NLS20welE5bXloMUpaS0plZ2hSODhNQVlKemtJMWdMMjRoNG93YkdydVlT?=
 =?utf-8?B?NHR5ZmZaZkp6T2FNNVJnRmJpTXBhS050d1YwV1lQUGxPdFhPVy9rblJZYzdT?=
 =?utf-8?B?alk3bzVoYTViVlBDWDVFcEYrTGFMWE9GdTlBUy82bDFKMHZwb1BJK3ZIUCti?=
 =?utf-8?B?RnRZcXBZSmlSTmlhR0RISmdFdit6dzhWbGhkTmRyUXJEYlBJNkZxY1daY29Z?=
 =?utf-8?B?R3g0QTg3WFhrQUE4RnNPakJjOUxDMUlMdklDd0Z1T1ZMNHNOem5xOGpLZU8w?=
 =?utf-8?B?cEYyMmhSVnpWcXpZVXlnZ3lkWEpGT3NEbkFoWWhQWFMzUm52ZGtiSzBCb0Q2?=
 =?utf-8?B?cFVyR0hyRDBIdFgrQkM3d21xVVU3R2pXU2FEdi9CbWZvZjdLd1Z6eEw1S25h?=
 =?utf-8?B?cXZ6NlRrbHZyMkQ1SFhWU21HVXZnSGIwQ1VaZVpDa3I4OGh4UjU2em94aXl0?=
 =?utf-8?B?Nm90OWtsL1UybmltemRVMDJCc3Axc3BUbHRjR29maCthVkFiVmVSdmloMHlP?=
 =?utf-8?B?a01BY0RuNnlUVWNBRSthVjY3T0JHWm5mMktablIySkd6UmhsQnptWStVbUFI?=
 =?utf-8?B?bWJSOG9abXRvUzU1YUR1WVRseGFOdGY3ZEhWRXIxd29hOVR6MUQ2NVFLSzRy?=
 =?utf-8?B?Z2dYZ1RiSU5kdi9QSGoxcGYxQUxYUEdDbTk5N3F3ZXZHRlNSanp0T2JEdDFn?=
 =?utf-8?B?ZU1iSkVPVHFIbVRrU2VNeE5vQ1YvRXBqTkhzMVlzaStHSmlnUXRPNFh3VVBy?=
 =?utf-8?B?cUR6NWp0NmhEdUVROEEySm9TaGRmQUEvUFJMRDVwbnF3aVh3aUJ0NHVLR1dw?=
 =?utf-8?B?UEJza0VyVEtsNWtSVS82OEtCUmZVVTAzTmN0MjJIVUpCWWpwWUtkU2g1Ti9C?=
 =?utf-8?B?M0ZYM0JaNWFYMkpzNHRpcW1sWDROdm5nNWlsY3ZqTERJbzM0UVBwcTZqVnFP?=
 =?utf-8?B?YnozbmJMeU85VjlZQStvdlFhT3NuM25EY1pQYjhEUVE3Ri9VcHA2VWh3YjRr?=
 =?utf-8?B?UUFtaHgrVlpMQ0dBcGV4NytSMnR4QnpjdlNVWGt5V09ZZlE3SlRvNDVyRnhS?=
 =?utf-8?B?RFp6WVphRmR5b0xaaUp5SDA3WjhFRkNVdnR5RWZaWStCWnFTVEdueGNnK1Zx?=
 =?utf-8?B?eEFCcjYrb0lUQUtNcG1aa08wN0pzU2F2V0lqSlJFWVN0TGZlL3FwbzRiNXBN?=
 =?utf-8?B?UDNnRkxrQnU3Qk01YlEvNm5PbHNxdGUyaDlYeHNyNWlXT3doRmErdm1tcitm?=
 =?utf-8?B?eFRsYkY2UldoSEZ2bHBvZXo1TitaczQvMHA4aW1XaWRwMkQzLzRGdVZtOXMy?=
 =?utf-8?B?SEVPTDR5cXBLbHl1SGlqQ1R0aVB5VHNsOUo2UXN5R0kwd0RraGhYZGFMWGw3?=
 =?utf-8?B?eXVpc01yS0Q3eURTc3FySldKT2owajB3ZnZjdTdKTVBhSnFHenhvTjcrcFJ0?=
 =?utf-8?Q?Pu3ExHwkkYWqkUM8axn8v6X+9?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a6fde0-6175-47e9-819d-08daa76bd6e1
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 07:24:43.5726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJ5o7nlZ+j4Ue8GmGURo2se9qau2sm3t2F9m3i6wVOFzuJ5VjEF9Vif21ZYe1o/lJ5gR6Aew0wCmQBsRtocUpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8407
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D-suffixed mnemonics do not exist in AT&T syntax; an L suffix is to be
used instead. MOVSD and CMPSD are only SSE2 instructions in AT&T mode.
Future gas versions may at least warn about such bogus uses. (Due to an
implementation detail [read: bug] gas has been supporting MOVSD and
CMPSD as string instructions, but not any of the other mnemonics where
Intel/AMD documentation enumerates a possible D suffix, e.g. STOS or
IRET. Clang's integrated assembler, yet more oddly, supports only MOVSD
as a string instruction, and apparently only without any operands.)

Signed-off-by: Jan Beulich <jbeulich@suse.com>
---
I also view as questionable the use of semicolons in two of the three
instances changed - REP isn't really an instruction on its own. I wasn't
sure though whether adjusting this at the same time would be deemed
acceptable.

--- a/arch/x86/boot/bioscall.S
+++ b/arch/x86/boot/bioscall.S
@@ -32,7 +32,7 @@ intcall:
 	movw	%dx, %si
 	movw	%sp, %di
 	movw	$11, %cx
-	rep; movsd
+	rep; movsl
 
 	/* Pop full state from the stack */
 	popal
@@ -67,7 +67,7 @@ intcall:
 	jz	4f
 	movw	%sp, %si
 	movw	$11, %cx
-	rep; movsd
+	rep; movsl
 4:	addw	$44, %sp
 
 	/* Restore state and return */
--- a/arch/x86/lib/iomap_copy_64.S
+++ b/arch/x86/lib/iomap_copy_64.S
@@ -10,6 +10,6 @@
  */
 SYM_FUNC_START(__iowrite32_copy)
 	movl %edx,%ecx
-	rep movsd
+	rep movsl
 	RET
 SYM_FUNC_END(__iowrite32_copy)
